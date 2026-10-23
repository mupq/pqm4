/*
 * Copyright 2026 YoungBeom Kim, Christine van Vredendaal, Gustavo Banegas, and Seog Chung Seo
 *
 * Derived from the HAETAE reference implementation, Copyright (c) 2026
 * Team HAETAE, MIT License (see LICENSE).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include "poly.h"
#include "decompose.h"
#include "ntt.h"
#include "params.h"
#include "reduce.h"
#include "symmetric.h"
#include <stdint.h>


void poly_decompose_stream_pack(uint8_t pk[CRYPTO_PUBLICKEYBYTES], poly *v, size_t count)
{
    int32_t t;

    pk += SEEDBYTES + count * POLYQ_PACKEDBYTES;

#if D == 1
    int32_t r[8];
    int b_idx;
    for (int j = 0; j < (N >> 3); j++)
    {
        r[0] = decompose_vk(&t, v->coeffs[8 * j + 0]);
        v->coeffs[8 * j + 0] = t;
        r[1] = decompose_vk(&t, v->coeffs[8 * j + 1]);
        v->coeffs[8 * j + 1] = t;
        r[2] = decompose_vk(&t, v->coeffs[8 * j + 2]);
        v->coeffs[8 * j + 2] = t;
        r[3] = decompose_vk(&t, v->coeffs[8 * j + 3]);
        v->coeffs[8 * j + 3] = t;
        r[4] = decompose_vk(&t, v->coeffs[8 * j + 4]);
        v->coeffs[8 * j + 4] = t;
        r[5] = decompose_vk(&t, v->coeffs[8 * j + 5]);
        v->coeffs[8 * j + 5] = t;
        r[6] = decompose_vk(&t, v->coeffs[8 * j + 6]);
        v->coeffs[8 * j + 6] = t;
        r[7] = decompose_vk(&t, v->coeffs[8 * j + 7]);
        v->coeffs[8 * j + 7] = t;

        b_idx = 15 * j;

        pk[b_idx] = (r[0] & 0xff);
        pk[b_idx + 1] = ((r[0] >> 8) & 0x7f) | ((r[1] & 0x1) << 7);
        pk[b_idx + 2] = ((r[1] >> 1) & 0xff);
        pk[b_idx + 3] = ((r[1] >> 9) & 0x3f) | ((r[2] & 0x3) << 6);
        pk[b_idx + 4] = ((r[2] >> 2) & 0xff);
        pk[b_idx + 5] = ((r[2] >> 10) & 0x1f) | ((r[3] & 0x7) << 5);
        pk[b_idx + 6] = ((r[3] >> 3) & 0xff);
        pk[b_idx + 7] = ((r[3] >> 11) & 0xf) | ((r[4] & 0xf) << 4);
        pk[b_idx + 8] = ((r[4] >> 4) & 0xff);
        pk[b_idx + 9] = ((r[4] >> 12) & 0x7) | ((r[5] & 0x1f) << 3);
        pk[b_idx + 10] = ((r[5] >> 5) & 0xff);
        pk[b_idx + 11] = ((r[5] >> 13) & 0x3) | ((r[6] & 0x3f) << 2);
        pk[b_idx + 12] = ((r[6] >> 6) & 0xff);
        pk[b_idx + 13] = ((r[6] >> 14) & 0x1) | ((r[7] & 0x7f) << 1);
        pk[b_idx + 14] = ((r[7] >> 7) & 0xff);
    }
#else
    int32_t r;
    for (unsigned int i = 0; i < N; ++i)
    {
        r = decompose_vk(&t, v->coeffs[i]);
        v->coeffs[i] = t;
        pk[2 * i + 0] = r >> 0;
        pk[2 * i + 1] = r >> 8;
    }
#endif
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
void poly_add(poly *c, const poly *a, const poly *b)
{
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
void poly_sub(poly *c, const poly *a, const poly *b)
{
    unsigned int i;

    for (i = 0; i < N; ++i)
        c->coeffs[i] = a->coeffs[i] - b->coeffs[i];
}

/*************************************************
 * Name:        poly_frommont
 *
 * Description: Multiply each coefficient by MONT = 2^32 mod Q (Montgomery
 *              multiplication by MONTSQ; outputs in (-Q, Q)). This removes
 *              the factor 2^{-32} of a poly_pointwise_montgomery product, as
 *              polyveck_frommont of the reference implementation.
 *
 * Arguments:   - poly *a: pointer to input/output polynomial
 **************************************************/
void poly_frommont(poly *a)
{
    unsigned int i;
    for (i = 0; i < N; ++i)
        a->coeffs[i] = montgomery_reduce((int64_t)a->coeffs[i] * MONTSQ);
}

/*************************************************
 * Name:        poly_double_negate
 *
 * Description: Multiply each coefficient by -2 mod Q (Montgomery
 *              multiplication by -2 * MONT; outputs in (-Q, Q)).
 *
 * Arguments:   - poly *a: pointer to input/output polynomial
 **************************************************/
void poly_double_negate(poly *a)
{
    unsigned int i;
    for (i = 0; i < N; ++i)
        a->coeffs[i] = montgomery_reduce((int64_t)a->coeffs[i] * MONT * -2);
}

void poly_caddq(poly *a)
{
    unsigned int i;
    for (i = 0; i < N; ++i)
        a->coeffs[i] = caddq(a->coeffs[i]);
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
void poly_pointwise_montgomery(poly *c, const poly *a, const poly *b)
{
    unsigned int i;

    for (i = 0; i < N; ++i)
        c->coeffs[i] = montgomery_reduce((int64_t)a->coeffs[i] * b->coeffs[i]);
}

/*
 * Fused uniform-frozen sampling + pointwise Montgomery multiplication (set).
 * Generates A coefficients via SHAKE128 rejection sampling and immediately
 * multiplies each coefficient with src_hat, storing the result in dest.
 * The sampled polynomial is never stored.
 */
void poly_uniform_frozen_pointwise_montgomery_set(poly *dest,
    const uint8_t seed[SEEDBYTES], uint16_t nonce, const poly *src_hat)
{
    unsigned int ctr = 0;
    unsigned int buflen = 0;
    unsigned int off;
    unsigned int pos;
    uint32_t t;

    uint8_t buf[STREAM128_BLOCKBYTES + 1];
    stream128_state state;

    stream128_init(&state, seed, nonce);

    stream128_squeezeblocks(buf, 1, &state);
    buflen = STREAM128_BLOCKBYTES;

    /* Inline rejection sampling + immediate pointwise multiply */
    pos = 0;
    while (ctr < N && pos + 2 <= buflen) {
        t = buf[pos++];
        t |= (uint32_t)buf[pos++] << 8;
        if (t < Q) {
            dest->coeffs[ctr] = montgomery_reduce((int64_t)(uint16_t)t * src_hat->coeffs[ctr]);
            ctr++;
        }
    }

    while (ctr < N) {
        off = buflen & 1U;
        if (off) {
            buf[0] = buf[buflen - 1];
        }
        stream128_squeezeblocks(buf + off, 1, &state);
        buflen = STREAM128_BLOCKBYTES + off;

        pos = 0;
        while (ctr < N && pos + 2 <= buflen) {
            t = buf[pos++];
            t |= (uint32_t)buf[pos++] << 8;
            if (t < Q) {
                dest->coeffs[ctr] = montgomery_reduce((int64_t)(uint16_t)t * src_hat->coeffs[ctr]);
                ctr++;
            }
        }
    }
}

/*
 * Fused uniform-frozen sampling + pointwise Montgomery multiplication (addto).
 * Same as _set variant but accumulates into acc instead of overwriting.
 */
void poly_uniform_frozen_pointwise_montgomery_addto(poly *acc,
    const uint8_t seed[SEEDBYTES], uint16_t nonce, const poly *src_hat)
{
    unsigned int ctr = 0;
    unsigned int buflen = 0;
    unsigned int off;
    unsigned int pos;
    uint32_t t;

    uint8_t buf[STREAM128_BLOCKBYTES + 1];
    stream128_state state;

    stream128_init(&state, seed, nonce);

    stream128_squeezeblocks(buf, 1, &state);
    buflen = STREAM128_BLOCKBYTES;

    pos = 0;
    while (ctr < N && pos + 2 <= buflen) {
        t = buf[pos++];
        t |= (uint32_t)buf[pos++] << 8;
        if (t < Q) {
            acc->coeffs[ctr] += montgomery_reduce((int64_t)(uint16_t)t * src_hat->coeffs[ctr]);
            ctr++;
        }
    }

    while (ctr < N) {
        off = buflen & 1U;
        if (off) {
            buf[0] = buf[buflen - 1];
        }
        stream128_squeezeblocks(buf + off, 1, &state);
        buflen = STREAM128_BLOCKBYTES + off;

        pos = 0;
        while (ctr < N && pos + 2 <= buflen) {
            t = buf[pos++];
            t |= (uint32_t)buf[pos++] << 8;
            if (t < Q) {
                acc->coeffs[ctr] += montgomery_reduce((int64_t)(uint16_t)t * src_hat->coeffs[ctr]);
                ctr++;
            }
        }
    }
}

void poly_uniform_frozen_double_pointwise_montgomery_addto(poly *acc,
    const uint8_t seed[SEEDBYTES], uint16_t nonce, const poly *src_hat)
{
    unsigned int ctr = 0;
    unsigned int buflen = 0;
    unsigned int off;
    unsigned int pos;
    uint32_t t;

    uint8_t buf[STREAM128_BLOCKBYTES + 1];
    stream128_state state;

    stream128_init(&state, seed, nonce);

    stream128_squeezeblocks(buf, 1, &state);
    buflen = STREAM128_BLOCKBYTES;

    pos = 0;
    while (ctr < N && pos + 2 <= buflen) {
        t = buf[pos++];
        t |= (uint32_t)buf[pos++] << 8;
        if (t < Q) {
            t *= 2u;
            if (t >= Q) t -= Q;
            acc->coeffs[ctr] += montgomery_reduce((int64_t)(uint16_t)t * src_hat->coeffs[ctr]);
            ctr++;
        }
    }

    while (ctr < N) {
        off = buflen & 1U;
        if (off) {
            buf[0] = buf[buflen - 1];
        }
        stream128_squeezeblocks(buf + off, 1, &state);
        buflen = STREAM128_BLOCKBYTES + off;

        pos = 0;
        while (ctr < N && pos + 2 <= buflen) {
            t = buf[pos++];
            t |= (uint32_t)buf[pos++] << 8;
            if (t < Q) {
                t *= 2u;
                if (t >= Q) t -= Q;
                acc->coeffs[ctr] += montgomery_reduce((int64_t)(uint16_t)t * src_hat->coeffs[ctr]);
                ctr++;
            }
        }
    }
}

/*************************************************
 * Name:        poly_reduce2q
 *
 * Description: Inplace reduction of all coefficients of polynomial to 2q
 *
 * Arguments:   - poly *a: pointer to input/output polynomial
 **************************************************/
void poly_reduce2q(poly *a)
{
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
void poly_freeze2q(poly *a)
{
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
void poly_freeze(poly *a)
{
    unsigned int i;

    for (i = 0; i < N; ++i)
        a->coeffs[i] = freeze(a->coeffs[i]);
}

/*************************************************
 * Name:        poly_uniform
 *
 * Description: Sample polynomial with uniformly random coefficients
 *              in [0,Q-1] by performing rejection sampling on the
 *              output stream of SHAKE128(seed|nonce)
 *
 * Arguments:   - poly *a: pointer to output polynomial
 *              - const uint8_t seed[]: byte array with seed of length SEEDBYTES
 *              - uint16_t nonce: 2-byte nonce
 **************************************************/
#define POLY_UNIFORM_NBLOCKS \
    ((512 + STREAM128_BLOCKBYTES - 1) / STREAM128_BLOCKBYTES)
// N * 2(random bytes for [0, Q - 1])

/*
void poly_uniform(poly *a, const uint8_t seed[SEEDBYTES], uint16_t nonce)
{
    unsigned int i, ctr, off;
    unsigned int buflen = POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES;
    uint8_t buf[POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES + 1];
    stream128_state state;

    stream128_init(&state, seed, nonce);
    stream128_squeezeblocks(buf, POLY_UNIFORM_NBLOCKS, &state);

    ctr = rej_uniform(a->coeffs, N, buf, buflen);

    while (ctr < N)
    {
        off = buflen % 2;
        for (i = 0; i < off; ++i)
            buf[i] = buf[buflen - off + i];

        stream128_squeezeblocks(buf + off, 1, &state);
        buflen = STREAM128_BLOCKBYTES + off;
        ctr += rej_uniform(a->coeffs + ctr, N - ctr, buf, buflen);
    }
}
    */

void poly_uniform(poly *a, const uint8_t seed[SEEDBYTES], uint16_t nonce) {
    unsigned int ctr = 0;
    unsigned int buflen = 0;
    unsigned int off;

    /* only one block + 1 byte carry */
    uint8_t buf[STREAM128_BLOCKBYTES + 1];
    stream128_state state;

    stream128_init(&state, seed, nonce);

    /* first block */
    stream128_squeezeblocks(buf, 1, &state);
    buflen = STREAM128_BLOCKBYTES;

    ctr = rej_uniform(a->coeffs, N, buf, buflen);

    while (ctr < N) {
        /* carry 1 byte if buflen is odd */
        off = buflen & 1U;
        if (off) {
            buf[0] = buf[buflen - 1];
        }

        /* squeeze exactly one more block into buf[off..] */
        stream128_squeezeblocks(buf + off, 1, &state);
        buflen = STREAM128_BLOCKBYTES + off;

        ctr += rej_uniform(a->coeffs + ctr, N - ctr, buf, buflen);
    }
}

void poly_uniform_add(poly *a, const uint8_t seed[SEEDBYTES], uint16_t nonce)
{
    unsigned int ctr = 0;
    unsigned int buflen = 0;
    unsigned int off;

    /* only one block + 1 byte carry */
    uint8_t buf[STREAM128_BLOCKBYTES + 1];
    stream128_state state;

    stream128_init(&state, seed, nonce);

    /* first block */
    stream128_squeezeblocks(buf, 1, &state);
    buflen = STREAM128_BLOCKBYTES;

    ctr = rej_uniform_add(a->coeffs, N, buf, buflen);

    while (ctr < N)
    {
        off = buflen & 1U;
        if (off)
        {
            buf[0] = buf[buflen - 1];
        }

        stream128_squeezeblocks(buf + off, 1, &state);
        buflen = STREAM128_BLOCKBYTES + off;

        ctr += rej_uniform_add(a->coeffs + ctr, N - ctr, buf, buflen);
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
#define POLY_UNIFORM_ETA_NBLOCKS \
    ((136 + STREAM256_BLOCKBYTES - 1) / STREAM256_BLOCKBYTES)

void poly_uniform_eta(poly *a, const uint8_t seed[CRHBYTES], uint16_t nonce)
{
    unsigned int ctr = 0;
    uint8_t buf[STREAM256_BLOCKBYTES];
    stream256_state state;

    stream256_init(&state, seed, nonce);

    while (ctr < N) {
        stream256_squeezeblocks(buf, 1, &state);
        ctr += rej_eta(a->coeffs + ctr, N - ctr, buf, STREAM256_BLOCKBYTES);
    }
}


#if HAETAE_MODE == 5
static uint8_t hammingWeight_8(uint8_t x)
{
    x = (x & 0x55) + (x >> 1 & 0x55);
    x = (x & 0x33) + (x >> 2 & 0x33);
    x = (x & 0x0F) + (x >> 4 & 0x0F);

    return x;
}
#endif

void poly_challenge_from_xof(poly *c, xof256_state *state)
{
#if (HAETAE_MODE == 2) || (HAETAE_MODE == 3)
    unsigned int i, b, pos = 0;
    uint8_t buf[XOF256_BLOCKBYTES];

    xof256_squeezeblocks(buf, 1, state);

    for (i = 0; i < N; ++i)
        c->coeffs[i] = 0;
    for (i = N - TAU; i < N; ++i)
    {
        do
        {
            if (pos >= XOF256_BLOCKBYTES)
            {
                xof256_squeezeblocks(buf, 1, state);
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

    xof256_squeeze(buf, 32, state);

    for (i = 0; i < 32; ++i)
        hwt += hammingWeight_8(buf[i]);

    cond = (128 - hwt);
    mask = 0xff & (cond >> 8);
    w0 = -(buf[0] & 1);
    mask = w0 ^ ((-(!!cond & 1)) & (mask ^ w0)); // mask = !!cond ? mask : w0
    for (i = 0; i < 32; ++i)
    {
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

void poly_decomposed_pack(uint8_t *buf, const poly *a)
{
    unsigned int i;
    for (i = 0; i < N; i++)
    {
        buf[i] = a->coeffs[i];
    }
}

/*************************************************
 * Name:        poly_pack_highbits
 *
 * Description: Pack the high bits of a polynomial into its
 *              POLY_HIGHBITS_PACKEDBYTES-byte slot of the challenge input
 *              (HAETAE 1.2.0 PackPolyHighBits).  Modes 2 and 3 store one byte
 *              per coefficient and zero-fill the remaining 32 bytes of the slot
 *              (the reference zero-initialises the whole buffer); mode 5 packs
 *              9 bits per coefficient.
 *
 * Arguments:   - uint8_t *buf: pointer to output array of
 *                              POLY_HIGHBITS_PACKEDBYTES bytes
 *              - const poly *a: pointer to input polynomial
 **************************************************/
void poly_pack_highbits(uint8_t *buf, const poly *a) {
    unsigned int i;
#if (HAETAE_MODE == 2) || (HAETAE_MODE == 3)
    for (i = 0; i < N; i++) {
        buf[i] = (uint8_t)a->coeffs[i];
    }
    for (i = N; i < POLY_HIGHBITS_PACKEDBYTES; i++) {
        buf[i] = 0;
    }
#elif HAETAE_MODE == 5
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
#endif
}

/*************************************************
 * Name:        polyq_pack
 *
 * Description: Bit-pack polynomial: modes 2 and 3 with coefficients in
 *              [0, 2^15 - 1] (15 bits each; the public key stores the rounded
 *              b, at most (Q + 1) / 2), mode 5 with coefficients in
 *              [0, Q - 1] (16 bits each).
 *
 * Arguments:   - uint8_t *r: pointer to output byte array with at least
 *                            POLYQ_PACKEDBYTES bytes
 *              - const poly *a: pointer to input polynomial
 **************************************************/
void polyq_pack(uint8_t *r, const poly *a)
{
    unsigned int i;
#if D == 1
    int b_idx = 0, d_idx = 0;

    for (i = 0; i < (N >> 3); ++i)
    {
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
    for (i = 0; i < N / 1; ++i)
    {
        r[2 * i + 0] = a->coeffs[1 * i + 0] >> 0;
        r[2 * i + 1] = a->coeffs[1 * i + 0] >> 8;
    }
#endif
}

/*************************************************
 * Name:        polyq_unpack
 *
 * Description: Unpack polynomial packed by polyq_pack (15 or 16 bits per
 *              coefficient).  No range check is performed.
 *
 * Arguments:   - poly *r: pointer to output polynomial
 *              - const uint8_t *a: byte array with bit-packed polynomial
 **************************************************/
void polyq_unpack(poly *r, const uint8_t *a)
{
    unsigned int i;
#if D == 1
    int b_idx = 0, d_idx = 0;

    for (i = 0; i < (N >> 3); ++i)
    {
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
    for (i = 0; i < N / 1; ++i)
    {
        r->coeffs[1 * i + 0] = a[2 * i + 0] >> 0;
        r->coeffs[1 * i + 0] |= (uint16_t)a[2 * i + 1] << 8;
        r->coeffs[1 * i + 0] &= 0xffff;
    }
#endif
}

#if D == 0
/*
 * Fused unpack + pointwise Montgomery multiply for D==0.
 * Avoids allocating a full poly for the unpacked pk row.
 * pk stores 16-bit LE NTT coefficients.
 */
void polyq_unpack_pointwise_montgomery(poly *dest, const uint8_t *a, const poly *src_hat)
{
    for (unsigned int i = 0; i < N; i++) {
        uint16_t t = (uint16_t)a[2 * i] | ((uint16_t)a[2 * i + 1] << 8);
        dest->coeffs[i] = montgomery_reduce((int64_t)t * src_hat->coeffs[i]);
    }
}
#endif

/*************************************************
 * Name:        polyeta_pack
 *
 * Description: Bit-pack polynomial with coefficients in [-ETA,ETA].
 *
 * Arguments:   - uint8_t *r: pointer to output byte array with at least
 *                            POLYETA_PACKEDBYTES bytes
 *              - const poly *a: pointer to input polynomial
 **************************************************/
void polyeta_pack(uint8_t *r, const poly *a)
{
    unsigned int i;
    uint8_t t[8];

    for (i = 0; i < N / 4; ++i)
    {
        t[0] = ETA - a->coeffs[4 * i + 0];
        t[1] = ETA - a->coeffs[4 * i + 1];
        t[2] = ETA - a->coeffs[4 * i + 2];
        t[3] = ETA - a->coeffs[4 * i + 3];
        r[i] = t[0] >> 0;
        r[i] |= t[1] << 2;
        r[i] |= t[2] << 4;
        r[i] |= t[3] << 6;
    }
}

/*************************************************
 * Name:        polyeta_unpack
 *
 * Description: Unpack polynomial with coefficients in [-ETA,ETA] packed by
 *              polyeta_pack.  No range check is performed (other inputs
 *              give coefficients down to ETA - 3).
 *
 * Arguments:   - poly *r: pointer to output polynomial
 *              - const uint8_t *a: byte array with bit-packed polynomial
 **************************************************/
void polyeta_unpack(poly *r, const uint8_t *a)
{
    unsigned int i;

    for (i = 0; i < N / 4; ++i)
    {
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

}

/*************************************************
 * Name:        poly2eta_pack
 *
 * Description: Bit-pack polynomial with coefficients in [-ETA-1,ETA+1]
 *              (3 bits each; used in modes 2 and 3 only).
 *
 * Arguments:   - uint8_t *r: pointer to output byte array with at least
 *                            96 bytes (POLY2ETA_PACKEDBYTES in modes 2 and 3)
 *              - const poly *a: pointer to input polynomial
 **************************************************/
void poly2eta_pack(uint8_t *r, const poly *a)
{
    unsigned int i;
    uint8_t t[8];

    for (i = 0; i < N / 8; ++i)
    {
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
}

/*************************************************
 * Name:        poly2eta_unpack
 *
 * Description: Unpack polynomial with coefficients in [-ETA-1,ETA+1] packed by
 *              poly2eta_pack.  No range check is performed (other inputs
 *              give coefficients down to 2 * ETA - 7).
 *
 * Arguments:   - poly *r: pointer to output polynomial
 *              - const uint8_t *a: byte array with bit-packed polynomial
 **************************************************/
void poly2eta_unpack(poly *r, const uint8_t *a)
{
    unsigned int i;

    for (i = 0; i < N / 8; ++i)
    {
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
}

void poly_fromcrt0(poly *w, const poly *u)
{
    unsigned int i;
    int32_t xq;

    for (i = 0; i < N; i++)
    {
        xq = u->coeffs[i];
        w->coeffs[i] = xq + (Q & -(xq & 1));
    }
}

void poly_ntt(poly *a) {
    ntt(&a->coeffs[0]);
}

void poly_invntt_tomont(poly *a) { invntt_tomont(&a->coeffs[0]); }
