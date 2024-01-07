#include "poly.h"
#include "decompose.h"
#include "ntt332.h"
#include "params.h"
#include "reduce.h"
#include "symmetric.h"
#include "arm_simd.h"
#include <stdint.h>


void poly_decompose_vk(poly *v0, poly *v) {
    for (int j = 0; j < N; j++) {
        v->coeffs[j] = decompose_vk(&v0->coeffs[j], v->coeffs[j]);
    }
}

void poly_frommont(poly *v) {
    unsigned int j;

    for (j = 0; j < N; j++)
        v->coeffs[j] = montgomery_reduce((int64_t)v->coeffs[j] * MONTSQ);
}

void poly_double_negate(poly *v) {
    unsigned int j;

    for (j = 0; j < N; j++)
        v->coeffs[j] = montgomery_reduce((int64_t)v->coeffs[j] * MONT * (-2));
}

void poly_caddq(poly *v) {
    unsigned j;

    for (j = 0; j < N; ++j)
        v->coeffs[j] = caddq(v->coeffs[j]);
}




/*************************************************
 * Name:        poly_clone
 *
 * Description: Clones the contents of one poly to another.
 *
 * Arguments:   - poly src: polynomial to be cloned
 *              - poly dest: polynomial to clone to
 **************************************************/
void poly_clone(poly *dest, const poly *src){
    for (size_t i=0; i<N; ++i) 
        dest->coeffs[i] = src->coeffs[i];
}

/*************************************************
 * Name:        poly_add
 *
 * Description: Add polynomials. No modular reduction is performed.
 *
 * Arguments:   - poly *c: pointer to output polynomial
 *              - const poly *a: pointer to first summand
 *              - const poly *b: pointer to second summand
 **************************************************/
void poly_add(poly *c, const poly *a, const poly *b) {
    unsigned int i;

    for (i = 0; i < N; ++i)
        c->coeffs[i] = a->coeffs[i] + b->coeffs[i];
}

/*************************************************
 * Name:        poly_sub
 *
 * Description: Subtract polynomials. No modular reduction is
 *              performed.
 *
 * Arguments:   - poly *c: pointer to output polynomial
 *              - const poly *a: pointer to first input polynomial
 *              - const poly *b: pointer to second input polynomial to be
 *                               subtraced from first input polynomial
 **************************************************/
void poly_sub(poly *c, const poly *a, const poly *b) {
    unsigned int i;

    for (i = 0; i < N; ++i)
        c->coeffs[i] = a->coeffs[i] - b->coeffs[i];
}

/*************************************************
 * Name:        poly_cneg
 *
 * Description: Conditionally negate polynomial. No modular reduction is
 *              performed.
 *
 * Arguments:   - poly *c: pointer to input/output polynomial
 *              - const uint8_t b: bit in [0,1]. If zero keep,
 *                                 else negate.
 **************************************************/
void poly_cneg(poly *c, const uint8_t b) {
    unsigned int j;
    for (j = 0; j < N; j++) {
        c->coeffs[j] *= 1 - 2 * b;
    }
}


/*************************************************
 * Name:        polyq_shl
 * 
 * Description: Shift every coefficient left by shmnt.
 *              No overflow checking is done.
 * 
 * Arguments:   - poly *r: pointer to polynomial to work on
 *              - const uint8_t shmnt: shift amount
 **************************************************/
void poly_shl(poly *r, const uint8_t shmnt){
    for (size_t k = 0; k < N; ++k) 
        r->coeffs[k] <<= shmnt;
}

/*************************************************
 * Name:        poly_double
 *
 * Description: Double vector of polynomials of length K.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyveck *w: pointer to output vector
 **************************************************/
void poly_double(poly *b) {
    unsigned int j;

    for (j = 0; j < N; ++j)
        b->coeffs[j] *= 2;
}

/*************************************************
 * Name:        poly_pointwise_montgomery
 *
 * Description: Pointwise multiplication of polynomials in NTT domain
 *              representation and multiplication of resulting polynomial
 *              by 2^{-32}.
 *
 * Arguments:   - poly *c: pointer to output polynomial
 *              - const poly *a: pointer to first input polynomial
 *              - const poly *b: pointer to second input polynomial
 **************************************************/
void poly_pointwise_montgomery(poly *c, const poly *a, const poly *b) {
    unsigned int i;

    for (i = 0; i < N; ++i)
        c->coeffs[i] = montgomery_reduce((int64_t)a->coeffs[i] * b->coeffs[i]);
}

/*************************************************
 * Name:        poly_pointwise_montgomery_mixed
 *
 * Description: Pointwise multiplication of polynomials in NTT domain
 *              representation and multiplication of resulting polynomial
 *              by 2^{-32}. One of the input polynomials is frozen.
 *
 * Arguments:   - poly *c: pointer to output polynomial
 *              - const poly_frozen *a: pointer to first input polynomial
 *              - const poly *b: pointer to second input polynomial
 **************************************************/
void poly_pointwise_montgomery_mixed(poly *c, const poly_frozen *a, const poly *b) {
    unsigned int i;

    for (i = 0; i < N; ++i)
        c->coeffs[i] = _montgomery_reduce((int64_t)a->coeffs[i] * b->coeffs[i]);
}

void poly_pointwise_montgomery_mixed_2(poly *c, const poly_frozen *a, const poly *b) {
    uint16x2_t t;
    // TODO: According to benchmarks_2023-06-28_pmm* data this is a bit
    //       slower than the above, but saves about 5kB stack usage.

    for (size_t i = 0; i < (N >> 1); ++i){
        t = load_uint16x2_t(&a->coeffs[0], i);
        size_t j = i << 1;
        c->coeffs[j]   = _montgomery_reduce((int64_t)(t & 0xFFFF) * b->coeffs[j]);
        j++;
        c->coeffs[j] = _montgomery_reduce((int64_t)((t >> 16)) * b->coeffs[j]);
    }
}

/*************************************************
 * Name:        poly_reduce2q
 *
 * Description: Inplace reduction of all coefficients of polynomial to 2q
 *
 * Arguments:   - poly *a: pointer to input/output polynomial
 **************************************************/
void poly_reduce2q(poly *a) {
    unsigned int i;

    for (i = 0; i < N; ++i)
        a->coeffs[i] = reduce32_2q(a->coeffs[i]);
}

/*************************************************
 * Name:        poly_freeze2q
 *
 * Description: For all coefficients of in/out polynomial compute standard
 *              representative r = a mod^+ 2Q
 *
 * Arguments:   - poly *a: pointer to input/output polynomial
 **************************************************/
void poly_freeze2q(poly *a) {
    unsigned int i;

    for (i = 0; i < N; ++i)
        a->coeffs[i] = freeze2q(a->coeffs[i]);
}

/*************************************************
 * Name:        poly_freeze
 *
 * Description: For all coefficients of in/out polynomial compute standard
 *              representative r = a mod^+ Q
 *
 * Arguments:   - poly *a: pointer to input/output polynomial
 **************************************************/
void poly_freeze(poly *a) {
    unsigned int i;

    for (i = 0; i < N; ++i)
        a->coeffs[i] = freeze(a->coeffs[i]);
}

/*************************************************
 * Name:        poly_highbits
 *
 * Description: Compute HighBits of polynomial
 *
 * Arguments:   - poly *a2: pointer to output polynomial
 *              - const poly *a: pointer to input polynomial
 **************************************************/
void poly_highbits(poly *a2, const poly *a) {
    unsigned int i;
    int32_t a1tmp;

    for (i = 0; i < N; ++i)
        decompose_z1(&a2->coeffs[i], &a1tmp, a->coeffs[i]);
}

/*************************************************
 * Name:        poly_lowbits
 *
 * Description: Compute LowBits of polynomial
 *
 * Arguments:   - poly *a1: pointer to output polynomial
 *              - const poly *a: pointer to input polynomial
 **************************************************/
void poly_lowbits(poly *a1, const poly *a) {
    unsigned int i = 0;
    int32_t a2tmp = 0;

    for (i = 0; i < N; ++i)
        decompose_z1(&a2tmp, &a1->coeffs[i], a->coeffs[i]);
}

/*************************************************
 * Name:        poly_compose
 *
 * Description: Compose HighBits and LowBits to recreate the polynomial
 *
 * Arguments:   - poly *a3: pointer to output polynomial
 *              - const poly *ha: pointer to HighBits polynomial
 *              - const poly *la: pointer to HighBits polynomial
 **************************************************/
void poly_compose(poly *a, const poly *ha, const poly *la) {
    unsigned int i = 0;

    for (i = 0; i < N; ++i)
        a->coeffs[i] = (ha->coeffs[i] << 8) + la->coeffs[i];
}

/*************************************************
 * Name:        poly_lsb
 *
 * Description: Compute least significant bits of polynomial
 *
 * Arguments:   - poly *a0: pointer to output polynomial
 *              - const poly *a: pointer to input polynomial
 **************************************************/
void poly_lsb(poly *a0, const poly *a) {
    unsigned int i;

    for (i = 0; i < N; ++i)
        a0->coeffs[i] = a->coeffs[i] & 1;
}

/*************************************************
 * Name:        poly_uniform
 *
 * Description: Sample polynomial with uniformly random coefficients
 *              in [0,Q-1] by performing rejection sampling on the
 *              output stream of SHAKE256(seed|nonce)
 *
 * Arguments:   - poly *a: pointer to output polynomial
 *              - const uint8_t seed[]: byte array with seed of length SEEDBYTES
 *              - uint16_t nonce: 2-byte nonce
 **************************************************/
#define POLY_UNIFORM_NBLOCKS                                                   \
    ((512 + STREAM128_BLOCKBYTES - 1) / STREAM128_BLOCKBYTES)
// N * 2(random bytes for [0, Q - 1])

void poly_uniform(poly *a, const uint8_t seed[SEEDBYTES], uint16_t nonce) {
    unsigned int i, ctr, off;
    unsigned int buflen = POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES;
    uint8_t buf[POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES + 1];
    stream128_state state;

    stream128_init(&state, seed, nonce);
    stream128_squeezeblocks(buf, POLY_UNIFORM_NBLOCKS, &state);

    ctr = rej_uniform(a->coeffs, N, buf, buflen);

    while (ctr < N) {
        off = buflen % 2;
        for (i = 0; i < off; ++i)
            buf[i] = buf[buflen - off + i];

        stream128_squeezeblocks(buf + off, 1, &state);
        buflen = STREAM128_BLOCKBYTES + off;
        ctr += rej_uniform(a->coeffs + ctr, N - ctr, buf, buflen);
    }
}

/*************************************************
 * Name:        poly_uniform_frozen
 *
 * Description: Sample polynomial with uniformly random coefficients
 *              in [0,Q-1] by performing rejection sampling on the
 *              output stream of SHAKE256(seed|nonce)
 *
 * Arguments:   - poly *a: pointer to output polynomial
 *              - const uint8_t seed[]: byte array with seed of length SEEDBYTES
 *              - uint16_t nonce: 2-byte nonce
 **************************************************/
void poly_uniform_frozen(poly_frozen *a, const uint8_t seed[SEEDBYTES], uint16_t nonce) {
    unsigned int i, ctr, off;
    unsigned int buflen = POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES;
    uint8_t buf[POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES + 1];
    stream128_state state;

    stream128_init(&state, seed, nonce);
    stream128_squeezeblocks(buf, POLY_UNIFORM_NBLOCKS, &state);

    ctr = rej_uniform_frozen(a->coeffs, N, buf, buflen);

    while (ctr < N) {
        off = buflen % 2;
        for (i = 0; i < off; ++i)
            buf[i] = buf[buflen - off + i];

        stream128_squeezeblocks(buf + off, 1, &state);
        buflen = STREAM128_BLOCKBYTES + off;
        ctr += rej_uniform_frozen(a->coeffs + ctr, N - ctr, buf, buflen);
    }
}

/*************************************************
 * Name:        poly_uniform_eta
 *
 * Description: Sample polynomial with uniformly random coefficients
 *              in [-ETA,ETA] by performing rejection sampling on the
 *              output stream from SHAKE256(seed|nonce)
 *
 * Arguments:   - poly *a: pointer to output polynomial
 *              - const uint8_t seed[]: byte array with seed of length CRHBYTES
 *              - uint16_t nonce: 2-byte nonce
 **************************************************/
#if ETA == 1
#define POLY_UNIFORM_ETA_NBLOCKS                                               \
    ((136 + STREAM256_BLOCKBYTES - 1) / STREAM256_BLOCKBYTES)
#elif ETA == 2
#define POLY_UNIFORM_ETA_NBLOCKS                                               \
    ((136 + STREAM256_BLOCKBYTES - 1) / STREAM256_BLOCKBYTES)
#endif

void poly_uniform_eta(poly *a, const uint8_t seed[CRHBYTES], uint16_t nonce) {
    unsigned int ctr;
    unsigned int buflen = POLY_UNIFORM_ETA_NBLOCKS * STREAM256_BLOCKBYTES;
    uint8_t buf[POLY_UNIFORM_ETA_NBLOCKS * STREAM256_BLOCKBYTES];
    stream256_state state;

    stream256_init(&state, seed, nonce);
    stream256_squeezeblocks(buf, POLY_UNIFORM_ETA_NBLOCKS, &state);

    ctr = rej_eta(a->coeffs, N, buf, buflen);

    while (ctr < N) {
        stream256_squeezeblocks(buf, 1, &state);
        ctr += rej_eta(a->coeffs + ctr, N - ctr, buf, STREAM256_BLOCKBYTES);
    }
}

uint8_t hammingWeight_8(uint8_t x) {
    x = (x & 0x55) + (x >> 1 & 0x55);
    x = (x & 0x33) + (x >> 2 & 0x33);
    x = (x & 0x0F) + (x >> 4 & 0x0F);

    return x;
}

/*************************************************
 * Name:        poly_challenge
 *
 * Description: Implementation of challenge. Samples polynomial with TAU 1
 *              coefficients using the output stream of SHAKE256(seed).
 *
 * Arguments:   - poly *c: pointer to output polynomial
 *              - const uint8_t seed[]: byte array containing seed of length
 *                SEEDBYTES
 **************************************************/
void poly_challenge(poly *c, const uint8_t highbits_lsb[POLYVECK_HIGHBITS_PACKEDBYTES + 
                    POLYC_PACKEDBYTES], const uint8_t mu[SEEDBYTES]) {
#if (HAETAE_MODE == 2) || (HAETAE_MODE == 3)
    unsigned int i, b, pos = 0;
    uint8_t buf[XOF256_BLOCKBYTES];
    xof256_state state;

    // H(HighBits(A * y mod 2q), LSB(round(y0) * j), M)
    xof256_absorb_twice(&state, 
                        highbits_lsb, POLYVECK_HIGHBITS_PACKEDBYTES + POLYC_PACKEDBYTES, 
                        mu, SEEDBYTES);    
    xof256_squeezeblocks(buf, 1, &state);

    for (i = 0; i < N; ++i)
        c->coeffs[i] = 0;
    for (i = N - TAU; i < N; ++i) {
        do {
            if (pos >= XOF256_BLOCKBYTES) {
                xof256_squeezeblocks(buf, 1, &state);
                pos = 0;
            }

            b = buf[pos++];
        } while (b > i);

        c->coeffs[i] = c->coeffs[b];
        c->coeffs[b] = 1;
    }
#elif HAETAE_MODE == 5
    unsigned int i, hwt = 0, cond = 0;
    uint8_t mask = 0, w0 = 0;
    uint8_t buf[32] = {0};
    xof256_state state;

    // H(HighBits(A * y mod 2q), LSB(round(y0) * j), M)
    xof256_absorb_twice(&state, 
                        highbits_lsb, POLYVECK_HIGHBITS_PACKEDBYTES + POLYC_PACKEDBYTES, 
                        mu, SEEDBYTES);
    xof256_squeeze(buf, 32, &state);

    for (i = 0; i < 32; ++i)
        hwt += hammingWeight_8(buf[i]);

    cond = (128 - hwt);
    mask = 0xff & (cond >> 8);
    w0 = -(buf[0] & 1);
    mask = w0 ^ ((-(!!cond & 1)) & (mask ^ w0)); // mask = !!cond ? mask : w0
    for (i = 0; i < 32; ++i) {
        buf[i] ^= mask;
        c->coeffs[8 * i] = buf[i] & 1;
        c->coeffs[8 * i + 1] = (buf[i] >> 1) & 1;
        c->coeffs[8 * i + 2] = (buf[i] >> 2) & 1;
        c->coeffs[8 * i + 3] = (buf[i] >> 3) & 1;
        c->coeffs[8 * i + 4] = (buf[i] >> 4) & 1;
        c->coeffs[8 * i + 5] = (buf[i] >> 5) & 1;
        c->coeffs[8 * i + 6] = (buf[i] >> 6) & 1;
        c->coeffs[8 * i + 7] = (buf[i] >> 7) & 1;
    }
#endif
}

void poly_decomposed_pack(uint8_t *buf, const poly *a) {
    unsigned int i;
    for (i = 0; i < N; i++) {
        buf[i] = a->coeffs[i];
    }
}

void poly_decomposed_unpack(poly *a, const uint8_t *buf) {
    unsigned int i;
    for (i = 0; i < N; i++) {
        a->coeffs[i] = (int8_t)buf[i];
    }
}

void poly_caddDQ2ALPHA(poly *h) {
    unsigned int j;
    for (j = 0; j < N; j++) {
        h->coeffs[j] +=
            (h->coeffs[j] >> 31) & ((DQ - 2) / ALPHA_HINT);
    }
}

void poly_highbits_hint(poly *w, const poly *v) {
    unsigned int j;
    for (j = 0; j < N; j++) {
        decompose_hint(&w->coeffs[j], v->coeffs[j]);
    }
}

void poly_pack_highbits(uint8_t *buf, const poly *a) {
    unsigned int i;
    for (i = 0; i < N / 8; i++) {
        buf[9 * i + 0] = a->coeffs[8 * i + 0] & 0xff;

        buf[9 * i + 1] = (a->coeffs[8 * i + 0] >> 8) & 0x01;
        buf[9 * i + 1] |= (a->coeffs[8 * i + 1] << 1) & 0xff;

        buf[9 * i + 2] = (a->coeffs[8 * i + 1] >> 7) & 0x03;
        buf[9 * i + 2] |= (a->coeffs[8 * i + 2] << 2) & 0xff;

        buf[9 * i + 3] = (a->coeffs[8 * i + 2] >> 6) & 0x07;
        buf[9 * i + 3] |= (a->coeffs[8 * i + 3] << 3) & 0xff;

        buf[9 * i + 4] = (a->coeffs[8 * i + 3] >> 5) & 0x0f;
        buf[9 * i + 4] |= (a->coeffs[8 * i + 4] << 4) & 0xff;

        buf[9 * i + 5] = (a->coeffs[8 * i + 4] >> 4) & 0x1f;
        buf[9 * i + 5] |= (a->coeffs[8 * i + 5] << 5) & 0xff;

        buf[9 * i + 6] = (a->coeffs[8 * i + 5] >> 3) & 0x3f;
        buf[9 * i + 6] |= (a->coeffs[8 * i + 6] << 6) & 0xff;

        buf[9 * i + 7] = (a->coeffs[8 * i + 6] >> 2) & 0x7f;
        buf[9 * i + 7] |= (a->coeffs[8 * i + 7] << 7) & 0xff;

        buf[9 * i + 8] = (a->coeffs[8 * i + 7] >> 1) & 0xff;
    }
}

void poly_pack_lsb(uint8_t *buf, const poly *a) {
    unsigned int i;
    for (i = 0; i < N; i++) {
        if ((i % 8) == 0) {
            buf[i / 8] = 0;
        }
        buf[i / 8] |= (a->coeffs[i] & 1) << (i % 8);
    }
}

/*************************************************
 * Name:        polyq_pack
 *
 * Description: Bit-pack polynomial with coefficients in [0, Q - 1].
 *
 * Arguments:   - uint8_t *r: pointer to output byte array with at least
 *                            POLYQ_PACKEDBYTES bytes
 *              - const poly *a: pointer to input polynomial
 **************************************************/
void polyq_pack(uint8_t *r, const poly *a) {
    unsigned int i;
#if D == 1
    int b_idx = 0, d_idx = 0;

    for (i = 0; i < (N >> 3); ++i) {
        b_idx = 15 * i;
        d_idx = 8 * i;

        r[b_idx] = (a->coeffs[d_idx] & 0xff);
        r[b_idx + 1] = ((a->coeffs[d_idx] >> 8) & 0x7f) |
                       ((a->coeffs[d_idx + 1] & 0x1) << 7);
        r[b_idx + 2] = ((a->coeffs[d_idx + 1] >> 1) & 0xff);
        r[b_idx + 3] = ((a->coeffs[d_idx + 1] >> 9) & 0x3f) |
                       ((a->coeffs[d_idx + 2] & 0x3) << 6);
        r[b_idx + 4] = ((a->coeffs[d_idx + 2] >> 2) & 0xff);
        r[b_idx + 5] = ((a->coeffs[d_idx + 2] >> 10) & 0x1f) |
                       ((a->coeffs[d_idx + 3] & 0x7) << 5);
        r[b_idx + 6] = ((a->coeffs[d_idx + 3] >> 3) & 0xff);
        r[b_idx + 7] = ((a->coeffs[d_idx + 3] >> 11) & 0xf) |
                       ((a->coeffs[d_idx + 4] & 0xf) << 4);
        r[b_idx + 8] = ((a->coeffs[d_idx + 4] >> 4) & 0xff);
        r[b_idx + 9] = ((a->coeffs[d_idx + 4] >> 12) & 0x7) |
                       ((a->coeffs[d_idx + 5] & 0x1f) << 3);
        r[b_idx + 10] = ((a->coeffs[d_idx + 5] >> 5) & 0xff);
        r[b_idx + 11] = ((a->coeffs[d_idx + 5] >> 13) & 0x3) |
                        ((a->coeffs[d_idx + 6] & 0x3f) << 2);
        r[b_idx + 12] = ((a->coeffs[d_idx + 6] >> 6) & 0xff);
        r[b_idx + 13] = ((a->coeffs[d_idx + 6] >> 14) & 0x1) |
                        (a->coeffs[d_idx + 7] & 0x7f) << 1;
        r[b_idx + 14] = ((a->coeffs[d_idx + 7] >> 7) & 0xff);
    }
#else
    for (i = 0; i < N / 1; ++i) {
        r[2 * i + 0] = a->coeffs[1 * i + 0] >> 0;
        r[2 * i + 1] = a->coeffs[1 * i + 0] >> 8;
    }
#endif
}

/*************************************************
 * Name:        polyq_unpack
 *
 * Description: Unpack polynomial with coefficients in [0, Q - 1].
 *
 * Arguments:   - poly *r: pointer to output polynomial
 *              - const uint8_t *a: byte array with bit-packed polynomial
 **************************************************/
void polyq_unpack(poly *r, const uint8_t *a) {
    unsigned int i;
#if D == 1
    int b_idx = 0, d_idx = 0;

    for (i = 0; i < (N >> 3); ++i) {
        b_idx = 15 * i;
        d_idx = 8 * i;

        r->coeffs[d_idx] = (a[b_idx] & 0xff) | ((a[b_idx + 1] & 0x7f) << 8);
        r->coeffs[d_idx + 1] = ((a[b_idx + 1] >> 7) & 0x1) |
                               ((a[b_idx + 2] & 0xff) << 1) |
                               ((a[b_idx + 3] & 0x3f) << 9);
        r->coeffs[d_idx + 2] = ((a[b_idx + 3] >> 6) & 0x3) |
                               ((a[b_idx + 4] & 0xff) << 2) |
                               ((a[b_idx + 5] & 0x1f) << 10);
        r->coeffs[d_idx + 3] = ((a[b_idx + 5] >> 5) & 0x7) |
                               ((a[b_idx + 6] & 0xff) << 3) |
                               ((a[b_idx + 7] & 0xf) << 11);
        r->coeffs[d_idx + 4] = ((a[b_idx + 7] >> 4) & 0xf) |
                               ((a[b_idx + 8] & 0xff) << 4) |
                               ((a[b_idx + 9] & 0x7) << 12);
        r->coeffs[d_idx + 5] = ((a[b_idx + 9] >> 3) & 0x1f) |
                               ((a[b_idx + 10] & 0xff) << 5) |
                               ((a[b_idx + 11] & 0x3) << 13);
        r->coeffs[d_idx + 6] = ((a[b_idx + 11] >> 2) & 0x3f) |
                               ((a[b_idx + 12] & 0xff) << 6) |
                               ((a[b_idx + 13] & 0x1) << 14);
        r->coeffs[d_idx + 7] =
            ((a[b_idx + 13] >> 1) & 0x7f) | ((a[b_idx + 14] & 0xff) << 7);
    }

#else
    for (i = 0; i < N / 1; ++i) {
        r->coeffs[1 * i + 0] = a[2 * i + 0] >> 0;
        r->coeffs[1 * i + 0] |= (uint16_t)a[2 * i + 1] << 8;
        r->coeffs[1 * i + 0] &= 0xffff;
    }
#endif
}

/*************************************************
 * Name:        polyeta_pack
 *
 * Description: Bit-pack polynomial with coefficients in [-ETA,ETA].
 *
 * Arguments:   - uint8_t *r: pointer to output byte array with at least
 *                            POLYETA_PACKEDBYTES bytes
 *              - const poly *a: pointer to input polynomial
 **************************************************/
void polyeta_pack(uint8_t *r, const poly *a) {
    unsigned int i;
    uint8_t t[8];

#if ETA == 1
    for (i = 0; i < N / 4; ++i) {
        t[0] = ETA - a->coeffs[4 * i + 0];
        t[1] = ETA - a->coeffs[4 * i + 1];
        t[2] = ETA - a->coeffs[4 * i + 2];
        t[3] = ETA - a->coeffs[4 * i + 3];
        r[i] = t[0] >> 0;
        r[i] |= t[1] << 2;
        r[i] |= t[2] << 4;
        r[i] |= t[3] << 6;
    }
#elif ETA == 2
    for (i = 0; i < N / 8; ++i) {
        t[0] = ETA - a->coeffs[8 * i + 0];
        t[1] = ETA - a->coeffs[8 * i + 1];
        t[2] = ETA - a->coeffs[8 * i + 2];
        t[3] = ETA - a->coeffs[8 * i + 3];
        t[4] = ETA - a->coeffs[8 * i + 4];
        t[5] = ETA - a->coeffs[8 * i + 5];
        t[6] = ETA - a->coeffs[8 * i + 6];
        t[7] = ETA - a->coeffs[8 * i + 7];

        r[3 * i + 0] = (t[0] >> 0) | (t[1] << 3) | (t[2] << 6);
        r[3 * i + 1] = (t[2] >> 2) | (t[3] << 1) | (t[4] << 4) | (t[5] << 7);
        r[3 * i + 2] = (t[5] >> 1) | (t[6] << 2) | (t[7] << 5);
    }
#endif
}

/*************************************************
 * Name:        polyeta_unpack
 *
 * Description: Unpack polynomial with coefficients in [-ETA,ETA].
 *
 * Arguments:   - poly *r: pointer to output polynomial
 *              - const uint8_t *a: byte array with bit-packed polynomial
 **************************************************/
void polyeta_unpack(poly *r, const uint8_t *a) {
    unsigned int i;

#if ETA == 1
    for (i = 0; i < N / 4; ++i) {
        r->coeffs[4 * i + 0] = a[i] >> 0;
        r->coeffs[4 * i + 0] &= 0x3;

        r->coeffs[4 * i + 1] = a[i] >> 2;
        r->coeffs[4 * i + 1] &= 0x3;

        r->coeffs[4 * i + 2] = a[i] >> 4;
        r->coeffs[4 * i + 2] &= 0x3;

        r->coeffs[4 * i + 3] = a[i] >> 6;
        r->coeffs[4 * i + 3] &= 0x3;

        r->coeffs[4 * i + 0] = ETA - r->coeffs[4 * i + 0];
        r->coeffs[4 * i + 1] = ETA - r->coeffs[4 * i + 1];
        r->coeffs[4 * i + 2] = ETA - r->coeffs[4 * i + 2];
        r->coeffs[4 * i + 3] = ETA - r->coeffs[4 * i + 3];
    }

#elif ETA == 2
    for (i = 0; i < N / 8; ++i) {
        r->coeffs[8 * i + 0] = (a[3 * i + 0] >> 0) & 7;
        r->coeffs[8 * i + 1] = (a[3 * i + 0] >> 3) & 7;
        r->coeffs[8 * i + 2] = ((a[3 * i + 0] >> 6) | (a[3 * i + 1] << 2)) & 7;
        r->coeffs[8 * i + 3] = (a[3 * i + 1] >> 1) & 7;
        r->coeffs[8 * i + 4] = (a[3 * i + 1] >> 4) & 7;
        r->coeffs[8 * i + 5] = ((a[3 * i + 1] >> 7) | (a[3 * i + 2] << 1)) & 7;
        r->coeffs[8 * i + 6] = (a[3 * i + 2] >> 2) & 7;
        r->coeffs[8 * i + 7] = (a[3 * i + 2] >> 5) & 7;

        r->coeffs[8 * i + 0] = ETA - r->coeffs[8 * i + 0];
        r->coeffs[8 * i + 1] = ETA - r->coeffs[8 * i + 1];
        r->coeffs[8 * i + 2] = ETA - r->coeffs[8 * i + 2];
        r->coeffs[8 * i + 3] = ETA - r->coeffs[8 * i + 3];
        r->coeffs[8 * i + 4] = ETA - r->coeffs[8 * i + 4];
        r->coeffs[8 * i + 5] = ETA - r->coeffs[8 * i + 5];
        r->coeffs[8 * i + 6] = ETA - r->coeffs[8 * i + 6];
        r->coeffs[8 * i + 7] = ETA - r->coeffs[8 * i + 7];
    }
#endif
}

/*************************************************
 * Name:        poly2eta_pack
 *
 * Description: Bit-pack polynomial with coefficients in [-ETA-1,ETA+1].
 *
 * Arguments:   - uint8_t *r: pointer to output byte array with at least
 *                            POLYETA_PACKEDBYTES bytes
 *              - const poly *a: pointer to input polynomial
 **************************************************/
void poly2eta_pack(uint8_t *r, const poly *a) {
    unsigned int i;
    uint8_t t[8];

#if ETA == 1
    for (i = 0; i < N / 8; ++i) {
        t[0] = 2 * ETA - a->coeffs[8 * i + 0];
        t[1] = 2 * ETA - a->coeffs[8 * i + 1];
        t[2] = 2 * ETA - a->coeffs[8 * i + 2];
        t[3] = 2 * ETA - a->coeffs[8 * i + 3];
        t[4] = 2 * ETA - a->coeffs[8 * i + 4];
        t[5] = 2 * ETA - a->coeffs[8 * i + 5];
        t[6] = 2 * ETA - a->coeffs[8 * i + 6];
        t[7] = 2 * ETA - a->coeffs[8 * i + 7];

        r[3 * i + 0] = (t[0] >> 0) | (t[1] << 3) | (t[2] << 6);
        r[3 * i + 1] = (t[2] >> 2) | (t[3] << 1) | (t[4] << 4) | (t[5] << 7);
        r[3 * i + 2] = (t[5] >> 1) | (t[6] << 2) | (t[7] << 5);
    }
#elif ETA == 2
#error "not yet implemented"
#endif
}

/*************************************************
 * Name:        poly2eta_unpack
 *
 * Description: Unpack polynomial with coefficients in [-ETA-1,ETA+1].
 *
 * Arguments:   - poly *r: pointer to output polynomial
 *              - const uint8_t *a: byte array with bit-packed polynomial
 **************************************************/
void poly2eta_unpack(poly *r, const uint8_t *a) {
    unsigned int i;

#if ETA == 1
    for (i = 0; i < N / 8; ++i) {
        r->coeffs[8 * i + 0] = (a[3 * i + 0] >> 0) & 7;
        r->coeffs[8 * i + 1] = (a[3 * i + 0] >> 3) & 7;
        r->coeffs[8 * i + 2] = ((a[3 * i + 0] >> 6) | (a[3 * i + 1] << 2)) & 7;
        r->coeffs[8 * i + 3] = (a[3 * i + 1] >> 1) & 7;
        r->coeffs[8 * i + 4] = (a[3 * i + 1] >> 4) & 7;
        r->coeffs[8 * i + 5] = ((a[3 * i + 1] >> 7) | (a[3 * i + 2] << 1)) & 7;
        r->coeffs[8 * i + 6] = (a[3 * i + 2] >> 2) & 7;
        r->coeffs[8 * i + 7] = (a[3 * i + 2] >> 5) & 7;

        r->coeffs[8 * i + 0] = 2 * ETA - r->coeffs[8 * i + 0];
        r->coeffs[8 * i + 1] = 2 * ETA - r->coeffs[8 * i + 1];
        r->coeffs[8 * i + 2] = 2 * ETA - r->coeffs[8 * i + 2];
        r->coeffs[8 * i + 3] = 2 * ETA - r->coeffs[8 * i + 3];
        r->coeffs[8 * i + 4] = 2 * ETA - r->coeffs[8 * i + 4];
        r->coeffs[8 * i + 5] = 2 * ETA - r->coeffs[8 * i + 5];
        r->coeffs[8 * i + 6] = 2 * ETA - r->coeffs[8 * i + 6];
        r->coeffs[8 * i + 7] = 2 * ETA - r->coeffs[8 * i + 7];
    }
#elif ETA == 2
#error "not yet implemented"
#endif
}

void poly_fromcrt(poly *w, const poly *u, const poly *v) {
    unsigned int i;
    int32_t xq, x2;

    for (i = 0; i < N; i++) {
        xq = u->coeffs[i];
        x2 = v->coeffs[i];
        w->coeffs[i] = xq + (Q & -((xq ^ x2) & 1));
    }
}

void poly_fromcrt0(poly *w, const poly *u) {
    unsigned int i;
    int32_t xq;

    for (i = 0; i < N; i++) {
        xq = u->coeffs[i];
        w->coeffs[i] = xq + (Q & -(xq & 1));
    }
}

void poly_ntt(poly *a) { haetae_ntt332(&a->coeffs[0]); }

void poly_invntt_tomont(poly *a) { haetae_invntt332_tomont(&a->coeffs[0]); }
