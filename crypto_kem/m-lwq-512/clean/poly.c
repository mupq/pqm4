#include "poly.h"
#include "ntt.h"
#include "reduce.h"
#include "params.h"


static inline int16_t load24_littleendian(const uint8_t x[3]) {
  return (int16_t)((uint16_t)x[0] | ((uint16_t)x[1] << 8) | ((uint16_t)x[2] << 16));
}

static void cbd3(poly *r, const uint8_t buf[3*MLWQ_N/4]) {
  unsigned int i, j;
  uint32_t t, d;
  int16_t a, b;

  // 每次处理 3 字节 -> 生成 4 个系数
  for(i=0; i<MLWQ_N/4; i++) {
    t = load24_littleendian(buf+3*i);
    d = t & 0x00249249;
    d += (t>>1) & 0x00249249;
    d += (t>>2) & 0x00249249;

    for(j=0; j<4; j++) {
      a = (d >> (6*j+0)) & 0x7;
      b = (d >> (6*j+3)) & 0x7;
      r->coeffs[4*i+j] = a - b;
    }
  }
}

// -------------------------------------------------------------------------
// [新增] 多项式采样接口 (PRF + CBD)
// -------------------------------------------------------------------------
void ref_poly_getnoise_eta1(poly *r, const uint8_t *seed, uint8_t nonce) {
    uint8_t buf[MLWQ_ETA1*MLWQ_N/4]; // Eta=3 -> 192 bytes
    uint8_t extseed[33]; // seed + nonce
    
    // 1. 准备种子: seed || nonce
    for(int i=0; i<32; i++) extseed[i] = seed[i];
    extseed[32] = nonce;
    
    // 2. PRF (使用 SHAKE256 生成固定长度字节)
    shake128(buf, sizeof(buf), extseed, 33);
    
    // 3. CBD 解析
    cbd3(r, buf);
}

// -------------------------------------------------------------------------
// 1. NTT 适配层
// -------------------------------------------------------------------------
static void poly_ntt(poly *r) { ntt(r->coeffs); }
static void poly_invntt(poly *r) { invntt(r->coeffs); }

static void poly_basemul(poly *r, const poly *a, const poly *b) {
    for(int i = 0; i < MLWQ_N / 4; i++) {
        basemul(&r->coeffs[4 * i], &a->coeffs[4 * i], &b->coeffs[4 * i], zetas[64 + i]);
        basemul(&r->coeffs[4 * i + 2], &a->coeffs[4 * i + 2], &b->coeffs[4 * i + 2], -zetas[64 + i]);
    }
}

// -------------------------------------------------------------------------
// 2. [核心优化] 极速打包与解包 (Packing/Unpacking)
// -------------------------------------------------------------------------
void ref_poly_tobytes(uint8_t *r, const poly *a) {
    int i;
#if BIT_PK == 9
    // 9-bit: 8 coeffs -> 9 bytes
    for(i=0; i<MLWQ_N/8; i++) {
        uint16_t t[8];
        for(int j=0; j<8; j++) t[j] = a->coeffs[8*i+j] + ((a->coeffs[8*i+j] >> 15) & MLWQ_Q);
        r[9*i+0] = (uint8_t)(t[0]);
        r[9*i+1] = (uint8_t)((t[0] >> 8) | (t[1] << 1));
        r[9*i+2] = (uint8_t)((t[1] >> 7) | (t[2] << 2));
        r[9*i+3] = (uint8_t)((t[2] >> 6) | (t[3] << 3));
        r[9*i+4] = (uint8_t)((t[3] >> 5) | (t[4] << 4));
        r[9*i+5] = (uint8_t)((t[4] >> 4) | (t[5] << 5));
        r[9*i+6] = (uint8_t)((t[5] >> 3) | (t[6] << 6));
        r[9*i+7] = (uint8_t)((t[6] >> 2) | (t[7] << 7));
        r[9*i+8] = (uint8_t)(t[7] >> 1);
    }
#elif BIT_PK == 10
    // 10-bit: 4 coeffs -> 5 bytes
    for(i=0; i<MLWQ_N/4; i++) {
        uint16_t t[4];
        for(int j=0; j<4; j++) t[j] = a->coeffs[4*i+j] + ((a->coeffs[4*i+j] >> 15) & MLWQ_Q);
        r[5*i+0] = (uint8_t)(t[0]);
        r[5*i+1] = (uint8_t)((t[0] >> 8) | (t[1] << 2));
        r[5*i+2] = (uint8_t)((t[1] >> 6) | (t[2] << 4));
        r[5*i+3] = (uint8_t)((t[2] >> 4) | (t[3] << 6));
        r[5*i+4] = (uint8_t)(t[3] >> 2);
    }
#endif
}

void ref_poly_frombytes(poly *r, const uint8_t *a) {
    int i;
#if BIT_PK == 9
    for(i=0; i<MLWQ_N/8; i++) {
        r->coeffs[8*i+0] =  (a[9*i+0]       | ((uint16_t)a[9*i+1] << 8)) & 0x1FF;
        r->coeffs[8*i+1] = ((a[9*i+1] >> 1) | ((uint16_t)a[9*i+2] << 7)) & 0x1FF;
        r->coeffs[8*i+2] = ((a[9*i+2] >> 2) | ((uint16_t)a[9*i+3] << 6)) & 0x1FF;
        r->coeffs[8*i+3] = ((a[9*i+3] >> 3) | ((uint16_t)a[9*i+4] << 5)) & 0x1FF;
        r->coeffs[8*i+4] = ((a[9*i+4] >> 4) | ((uint16_t)a[9*i+5] << 4)) & 0x1FF;
        r->coeffs[8*i+5] = ((a[9*i+5] >> 5) | ((uint16_t)a[9*i+6] << 3)) & 0x1FF;
        r->coeffs[8*i+6] = ((a[9*i+6] >> 6) | ((uint16_t)a[9*i+7] << 2)) & 0x1FF;
        r->coeffs[8*i+7] = ((a[9*i+7] >> 7) | ((uint16_t)a[9*i+8] << 1)) & 0x1FF;
    }
#elif BIT_PK == 10
    for(i=0; i<MLWQ_N/4; i++) {
        r->coeffs[4*i+0] = ((a[5*i+0] >> 0) | ((uint16_t)(a[5*i+1] & 0x03) << 8));
        r->coeffs[4*i+1] = ((a[5*i+1] >> 2) | ((uint16_t)(a[5*i+2] & 0x0F) << 6));
        r->coeffs[4*i+2] = ((a[5*i+2] >> 4) | ((uint16_t)(a[5*i+3] & 0x3F) << 4));
        r->coeffs[4*i+3] = ((a[5*i+3] >> 6) | ((uint16_t)(a[5*i+4] & 0xFF) << 2));
    }
#endif
}


// =========================================================================
// 2. 密文 U 压缩 (compress_u)
// 全等级均为 10-bit
// =========================================================================

void ref_poly_compress_u(uint8_t *r, const poly *a) {
    // 10-bit: 4 coeffs -> 5 bytes
    int i;
    for(i=0; i<MLWQ_N/4; i++) {
        uint16_t t[4];
        for(int j=0;j<4;j++) t[j] = a->coeffs[4*i+j];
        r[5*i+0] = (uint8_t)(t[0]);
        r[5*i+1] = (uint8_t)((t[0] >> 8) | (t[1] << 2));
        r[5*i+2] = (uint8_t)((t[1] >> 6) | (t[2] << 4));
        r[5*i+3] = (uint8_t)((t[2] >> 4) | (t[3] << 6));
        r[5*i+4] = (uint8_t)(t[3] >> 2);
    }
}

void ref_poly_decompress_u(poly *r, const uint8_t *a) {
    int i;
    for(i=0; i<MLWQ_N/4; i++) {
        r->coeffs[4*i+0] = ((a[5*i+0] >> 0) | ((uint16_t)(a[5*i+1] & 0x03) << 8));
        r->coeffs[4*i+1] = ((a[5*i+1] >> 2) | ((uint16_t)(a[5*i+2] & 0x0F) << 6));
        r->coeffs[4*i+2] = ((a[5*i+2] >> 4) | ((uint16_t)(a[5*i+3] & 0x3F) << 4));
        r->coeffs[4*i+3] = ((a[5*i+3] >> 6) | ((uint16_t)(a[5*i+4] & 0xFF) << 2));
    }
}


// =========================================================================
// 3. 密文 V 压缩 (compress_v)
// 全等级均为 5-bit
// =========================================================================

void ref_poly_compress_v(uint8_t *r, const poly *a) {
    // 5-bit: 8 coeffs -> 5 bytes
    int i;
    for(i=0; i<MLWQ_N/8; i++) {
        uint8_t t[8];
        for(int j=0; j<8; j++) t[j] = a->coeffs[8*i+j] & 0x1F;
        
        r[5*i+0] = (t[0] >> 0) | (t[1] << 5);
        r[5*i+1] = (t[1] >> 3) | (t[2] << 2) | (t[3] << 7);
        r[5*i+2] = (t[3] >> 1) | (t[4] << 4);
        r[5*i+3] = (t[4] >> 4) | (t[5] << 1) | (t[6] << 6);
        r[5*i+4] = (t[6] >> 2) | (t[7] << 3);
    }
}

void ref_poly_decompress_v(poly *r, const uint8_t *a) {
    int i;
    for(i=0; i<MLWQ_N/8; i++) {
        r->coeffs[8*i+0] =  (a[5*i+0]       ) & 0x1F;
        r->coeffs[8*i+1] = ((a[5*i+0] >> 5) | (a[5*i+1] << 3)) & 0x1F;
        r->coeffs[8*i+2] = ((a[5*i+1] >> 2) ) & 0x1F;
        r->coeffs[8*i+3] = ((a[5*i+1] >> 7) | (a[5*i+2] << 1)) & 0x1F;
        r->coeffs[8*i+4] = ((a[5*i+2] >> 4) | (a[5*i+3] << 4)) & 0x1F;
        r->coeffs[8*i+5] = ((a[5*i+3] >> 1) ) & 0x1F;
        r->coeffs[8*i+6] = ((a[5*i+3] >> 6) | (a[5*i+4] << 2)) & 0x1F;
        r->coeffs[8*i+7] = ((a[5*i+4] >> 3) ) & 0x1F;
    }
}

// -------------------------------------------------------------------------
// 3. [核心优化] 快速压缩与解压缩 (Compress/Decompress)
// -------------------------------------------------------------------------
// 用于 Encaps/Decaps 中的密文处理

// 快速除法常数 (针对 Q=3329)
// 1/3329 approx 322376 / 2^30
static inline int32_t fast_div_3329(int32_t val) {
    return (int32_t)(((int64_t)val * 322376) >> 30);
}

// 量化 (带抖动)
void ref_poly_quantize(poly *res, const poly *v, const poly *d, int32_t P) {
    int32_t mask = P - 1;
    for(int i = 0; i < MLWQ_N; ++i) {
        int32_t val = (int32_t)v->coeffs[i] + d->coeffs[i];
        int32_t temp = val * P;
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
    int32_t scale = MLWQ_Q / 2;
    for(int i = 0; i < MLWQ_N; ++i) {
        int bit = (msg[i/8] >> (i%8)) & 1;
        res->coeffs[i] = bit ? scale : 0;
    }
}

void ref_poly_msg_decode(uint8_t *msg, const poly *p) {
    for(int i=0; i<32; i++) msg[i] = 0; 
    int32_t lower = MLWQ_Q / 4;
    int32_t upper = 3 * MLWQ_Q / 4;
    for(int i = 0; i < MLWQ_N; ++i) {
        int16_t val = p->coeffs[i];
        int32_t t = (int32_t)val;
        if (t < 0) t += MLWQ_Q;
        int bit = (t > lower && t < upper) ? 1 : 0;
        if(bit) msg[i/8] |= (1 << (i%8));
    }
}

int ref_check_poly_eq(const poly *a, const poly *b) {
    for(int i = 0; i < MLWQ_N; ++i)
        if (a->coeffs[i] != b->coeffs[i]) return 0;
    return 1;
}

