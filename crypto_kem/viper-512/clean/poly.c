#include "poly.h"
#include "ntt.h"
#include "reduce.h"
#include "params.h"
#include "fips202.h"


static void cbd_eta(poly *r, const uint8_t *buf, int eta) {
    unsigned bitpos = 0;
    for (int i = 0; i < MLWQ_N; ++i) {
        uint16_t a = 0;
        uint16_t b = 0;
        for (int j = 0; j < eta; ++j) {
            a += (uint16_t)((buf[bitpos >> 3] >> (bitpos & 7)) & 1u);
            bitpos++;
        }
        for (int j = 0; j < eta; ++j) {
            b += (uint16_t)((buf[bitpos >> 3] >> (bitpos & 7)) & 1u);
            bitpos++;
        }
        r->coeffs[i] = (int16_t)(a - b);
    }
}

static void ref_poly_getnoise_eta(poly *r, const uint8_t *seed, uint8_t nonce, int eta) {
    uint8_t buf[MLWQ_N];
    uint8_t extseed[33];

    for (int i = 0; i < 32; i++) extseed[i] = seed[i];
    extseed[32] = nonce;

    shake256(buf, (size_t)((2 * eta * MLWQ_N + 7) / 8), extseed, 33);
    cbd_eta(r, buf, eta);
}

void ref_poly_getnoise_eta1(poly *r, const uint8_t *seed, uint8_t nonce) {
    ref_poly_getnoise_eta(r, seed, nonce, MLWQ_ETA_S);
}

void ref_poly_getnoise_eta_r(poly *r, const uint8_t *seed, uint8_t nonce) {
    ref_poly_getnoise_eta(r, seed, nonce, MLWQ_ETA_R);
}

static void poly_ntt(poly *r) { ntt(r->coeffs); }
static void poly_invntt(poly *r) { invntt(r->coeffs); }

static void poly_basemul(poly *r, const poly *a, const poly *b) {
    for(int i = 0; i < MLWQ_N / 4; i++) {
        basemul(&r->coeffs[4 * i], &a->coeffs[4 * i], &b->coeffs[4 * i], zetas[64 + i]);
        basemul(&r->coeffs[4 * i + 2], &a->coeffs[4 * i + 2], &b->coeffs[4 * i + 2], -zetas[64 + i]);
    }
}

static void pack_bits(uint8_t *out, const poly *a, int bits) {
    uint32_t acc = 0;
    int acc_bits = 0;
    size_t idx = 0;
    const uint32_t mask = (1u << bits) - 1u;

    for (int i = 0; i < MLWQ_N; ++i) {
        uint32_t v = (uint16_t)(a->coeffs[i] + ((a->coeffs[i] >> 15) & MLWQ_Q));
        acc |= (v & mask) << acc_bits;
        acc_bits += bits;
        while (acc_bits >= 8) {
            out[idx++] = (uint8_t)acc;
            acc >>= 8;
            acc_bits -= 8;
        }
    }
}

static void unpack_bits(poly *r, const uint8_t *in, int bits) {
    uint32_t acc = 0;
    int acc_bits = 0;
    size_t idx = 0;
    const uint32_t mask = (1u << bits) - 1u;

    for (int i = 0; i < MLWQ_N; ++i) {
        while (acc_bits < bits) {
            acc |= ((uint32_t)in[idx++]) << acc_bits;
            acc_bits += 8;
        }
        r->coeffs[i] = (int16_t)(acc & mask);
        acc >>= bits;
        acc_bits -= bits;
    }
}

void ref_poly_tobytes(uint8_t *r, const poly *a) { pack_bits(r, a, BIT_PK); }
void ref_poly_frombytes(poly *r, const uint8_t *a) { unpack_bits(r, a, BIT_PK); }
void ref_poly_compress_u(uint8_t *r, const poly *a) { pack_bits(r, a, BIT_U); }
void ref_poly_decompress_u(poly *r, const uint8_t *a) { unpack_bits(r, a, BIT_U); }
void ref_poly_compress_v(uint8_t *r, const poly *a) { pack_bits(r, a, BIT_V); }
void ref_poly_decompress_v(poly *r, const uint8_t *a) { unpack_bits(r, a, BIT_V); }

// 快速除法常数 (针对 Q=3329)
// 1/3329 approx 322376 / 2^30
static inline int32_t fast_div_3329(int32_t val) {
    return (int32_t)(((int64_t)val * 322376) >> 30);
}

// 量化 (带抖动)
void ref_poly_quantize(poly *res, const poly *v, const poly *d, int32_t P) {
    int32_t mask = P - 1;
    for(int i = 0; i < MLWQ_N; ++i) {
        // d 现在按 [0, Q) 采样，量化时使用:
        // floor((v * P + d) / Q)
        // 这样 d 作为细粒度抖动落在一个量化步长内，不会破坏解密正确性。
        int32_t temp = (int32_t)v->coeffs[i] * P + (int32_t)d->coeffs[i];
        int32_t floor = fast_div_3329(temp);
        res->coeffs[i] = floor & mask;
    }
}

// 反量化 (恢复)
void ref_poly_dequantize(poly *res, const poly *b, int32_t P) {
    for(int i = 0; i < MLWQ_N; ++i) {
        // v = (b * Q + Q/2) / P
        // 尽量使用乘法，但这里为了精度保持除法 (非性能热点)
        int32_t v = (int32_t)b->coeffs[i] * MLWQ_Q + (MLWQ_Q / 2);
        res->coeffs[i] = v / P;
    }
}

// -------------------------------------------------------------------------
// 4. 基础算术 & 矩阵乘法 (保持之前的 NTT 优化)
// -------------------------------------------------------------------------

void ref_poly_add(poly *res, const poly *a, const poly *b) {
    for(int i = 0; i < MLWQ_N; i+=8) {
        res->coeffs[i+0] = barrett_reduce(a->coeffs[i+0] + b->coeffs[i+0]);
        res->coeffs[i+1] = barrett_reduce(a->coeffs[i+1] + b->coeffs[i+1]);
        res->coeffs[i+2] = barrett_reduce(a->coeffs[i+2] + b->coeffs[i+2]);
        res->coeffs[i+3] = barrett_reduce(a->coeffs[i+3] + b->coeffs[i+3]);
        res->coeffs[i+4] = barrett_reduce(a->coeffs[i+4] + b->coeffs[i+4]);
        res->coeffs[i+5] = barrett_reduce(a->coeffs[i+5] + b->coeffs[i+5]);
        res->coeffs[i+6] = barrett_reduce(a->coeffs[i+6] + b->coeffs[i+6]);
        res->coeffs[i+7] = barrett_reduce(a->coeffs[i+7] + b->coeffs[i+7]);
    }
}

void ref_poly_sub(poly *res, const poly *a, const poly *b) {
    for(int i = 0; i < MLWQ_N; i+=8) {
        res->coeffs[i+0] = barrett_reduce(a->coeffs[i+0] - b->coeffs[i+0]);
        res->coeffs[i+1] = barrett_reduce(a->coeffs[i+1] - b->coeffs[i+1]);
        res->coeffs[i+2] = barrett_reduce(a->coeffs[i+2] - b->coeffs[i+2]);
        res->coeffs[i+3] = barrett_reduce(a->coeffs[i+3] - b->coeffs[i+3]);
        res->coeffs[i+4] = barrett_reduce(a->coeffs[i+4] - b->coeffs[i+4]);
        res->coeffs[i+5] = barrett_reduce(a->coeffs[i+5] - b->coeffs[i+5]);
        res->coeffs[i+6] = barrett_reduce(a->coeffs[i+6] - b->coeffs[i+6]);
        res->coeffs[i+7] = barrett_reduce(a->coeffs[i+7] - b->coeffs[i+7]);
    }
}

void ref_poly_mul_ntt(poly *res, const poly *a, const poly *b) {
    poly ta = *a;
    poly tb = *b;
    poly_ntt(&ta);
    poly_ntt(&tb);
    poly_basemul(res, &ta, &tb);
    poly_invntt(res);
    for(int i=0; i<MLWQ_N; i++) res->coeffs[i] = barrett_reduce(res->coeffs[i]);
}

void ref_poly_matrix_vec_mul(poly_vec *res, const poly_matrix *A, const poly_vec *s) {
    poly_vec s_ntt = *s;
    for(int i=0; i<MLWQ_K; i++) poly_ntt(&s_ntt.vec[i]);

    for(int i = 0; i < MLWQ_K; ++i) {
        poly acc;
        for(int k=0; k<MLWQ_N; k++) acc.coeffs[k] = 0;
        for(int j = 0; j < MLWQ_K; ++j) {
            poly t_a = A->row[i].vec[j];
            poly t_prod;
            poly_ntt(&t_a);
            poly_basemul(&t_prod, &t_a, &s_ntt.vec[j]);
            for(int k=0; k<MLWQ_N; k++) acc.coeffs[k] += t_prod.coeffs[k];
        }
        poly_invntt(&acc);
        for(int k=0; k<MLWQ_N; k++) res->vec[i].coeffs[k] = barrett_reduce(acc.coeffs[k]);
    }
}

void ref_poly_vec_transpose_mul(poly *res, const poly_vec *a_t, const poly_vec *b) {
    poly_vec a_ntt = *a_t;
    poly_vec b_ntt = *b;
    for(int i=0; i<MLWQ_K; i++) {
        poly_ntt(&a_ntt.vec[i]);
        poly_ntt(&b_ntt.vec[i]);
    }
    
    poly acc;
    for(int k=0; k<MLWQ_N; k++) acc.coeffs[k] = 0;
    
    for(int i = 0; i < MLWQ_K; ++i) {
        poly t_prod;
        poly_basemul(&t_prod, &a_ntt.vec[i], &b_ntt.vec[i]);
        for(int k=0; k<MLWQ_N; k++) acc.coeffs[k] += t_prod.coeffs[k];
    }
    poly_invntt(&acc);
    for(int k=0; k<MLWQ_N; k++) res->coeffs[k] = barrett_reduce(acc.coeffs[k]);
}

// -------------------------------------------------------------------------
// 5. 消息编码/解码
// -------------------------------------------------------------------------

void ref_poly_msg_encode(poly *res, const uint8_t *msg) {
#if MSG_BITS == 1
    int32_t scale = MLWQ_Q / 2;
    for(int i = 0; i < MLWQ_N; ++i) {
        int bit = (msg[i/8] >> (i%8)) & 1;
        res->coeffs[i] = bit ? scale : 0;
    }
#else
    const int used_coeffs = MU_BITS / 2;
    const int32_t base = MLWQ_Q / 8;
    const int32_t step = MLWQ_Q / 4;
    for (int i = 0; i < used_coeffs; ++i) {
        int byte_idx = i / 4;
        int shift = (i % 4) * 2;
        int sym = (msg[byte_idx] >> shift) & 0x3;
        res->coeffs[i] = (int16_t)(base + sym * step);
    }
    for (int i = used_coeffs; i < MLWQ_N; ++i) {
        res->coeffs[i] = 0;
    }
#endif
}

void ref_poly_msg_decode(uint8_t *msg, const poly *p) {
    for(int i=0; i<MU_BYTES; i++) msg[i] = 0;
#if MSG_BITS == 1
    int32_t lower = MLWQ_Q / 4;
    int32_t upper = 3 * MLWQ_Q / 4;
    for(int i = 0; i < MLWQ_N; ++i) {
        int16_t val = p->coeffs[i];
        int32_t t = (int32_t)val;
        if (t < 0) t += MLWQ_Q;
        int bit = (t > lower && t < upper) ? 1 : 0;
        if(bit) msg[i/8] |= (1 << (i%8));
    }
#else
    const int used_coeffs = MU_BITS / 2;
    const int32_t q4 = MLWQ_Q / 4;
    const int32_t q2 = MLWQ_Q / 2;
    const int32_t q34 = (3 * MLWQ_Q) / 4;
    for (int i = 0; i < used_coeffs; ++i) {
        int32_t t = p->coeffs[i];
        if (t < 0) t += MLWQ_Q;
        int sym;
        if (t < q4) sym = 0;
        else if (t < q2) sym = 1;
        else if (t < q34) sym = 2;
        else sym = 3;
        msg[i / 4] |= (uint8_t)(sym << ((i % 4) * 2));
    }
#endif
}

int ref_check_poly_eq(const poly *a, const poly *b) {
    for(int i = 0; i < MLWQ_N; ++i)
        if (a->coeffs[i] != b->coeffs[i]) return 0;
    return 1;
}