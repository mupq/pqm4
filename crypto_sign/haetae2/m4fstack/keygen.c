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
#include "api.h"
#include "packing.h"
#include "params.h"
#include "poly.h"
#include "polyfix.h"
#include "polyvec.h"
#include "randombytes.h"
#include "symmetric.h"
#include <string.h>
#include "utils.h"
#include "fft.h"

/* Squared singular-value bound GAMMA^2 * N, truncated to an integer at compile
 * time.  For an integer x, x > GAMMA^2 * N holds iff x > sqsing_bound, so the
 * rejection test needs no (software) floating-point arithmetic at run time. */
static const int64_t sqsing_bound = (int64_t)(GAMMA * GAMMA * N);

static inline uint16_t nonce_a(const size_t row)
{
    return (K << 8) + M + row;
}
static inline uint16_t nonce_A_gen(const size_t row, const size_t column)
{
    return (row << 8) + column;
}
static inline uint16_t nonce_s_gen(const size_t nonce_offset,
                                   const size_t column)
{
    return nonce_offset + column;
}
static inline uint16_t nonce_e_gen(const size_t nonce_offset, const size_t row)
{
    return nonce_offset + M + row;
}

/* A0[row][column] is sampled on the fly and multiplied into the accumulator
 * (fused sample + pointwise multiplication; A0 is never stored). */
static void pointwise_montgomery_by_A_elem_set(poly *dest,
                                               const uint8_t rho[SEEDBYTES],
                                               const size_t row,
                                               const size_t column,
                                               const poly *src_hat)
{
    poly_uniform_frozen_pointwise_montgomery_set(dest, rho, nonce_A_gen(row, column), src_hat);
}

static void pointwise_montgomery_by_A_elem_addto(poly *acc,
                                                 const uint8_t rho[SEEDBYTES],
                                                 const size_t row,
                                                 const size_t column,
                                                 const poly *src_hat)
{
    poly_uniform_frozen_pointwise_montgomery_addto(acc, rho, nonce_A_gen(row, column), src_hat);
}


/* Key generation for modes 2 and 3 (D = 1), streamed one polynomial at a time.
 * The FFT for the singular-value check runs in place in a union with the
 * sampling buffer, so s1 is re-sampled after its FFT (same nonce, same
 * polynomial).  A0 is generated on the fly; only b and the running sum of
 * squared FFT magnitudes are kept. */
static inline int keygen_mode23(uint8_t *pk, uint8_t *sk,
                                       const uint8_t seed[SEEDBYTES])
{
    uint8_t seedbuf[2 * SEEDBYTES + CRHBYTES] = {0};
    uint16_t counter = 0;
    const uint8_t *rhoprime, *sigma, *key;

    poly b;
    union {
        complex_fp32_16 fft_input[FFT_N]; /* FFT scratch */
        poly s;                           /* sampling */
    } u;
    int32_t sum[N];

    generate_seed_from_one_source(seedbuf, 2 * SEEDBYTES + CRHBYTES, seed, SEEDBYTES);

    rhoprime = seedbuf;
    sigma = rhoprime + SEEDBYTES;
    key = sigma + CRHBYTES;

reject:
    memset(sum, 0, sizeof(int32_t) * N);
    for (size_t row = 0; row < K; row++)
    {
        for (size_t column = 0; column < M; column++)
        {
            poly_uniform_eta(&u.s, sigma, nonce_s_gen(counter, column));
            if (row == 0)
            {
                pack_sk_stream_s1(sk, &u.s, column);
                fft_init_and_bitrev_inplace(u.fft_input);
                fft(u.fft_input);
                for (size_t j = 0; j < N; j++)
                    sum[j] += complex_fp_sqabs(u.fft_input[j]);
                poly_uniform_eta(&u.s, sigma, nonce_s_gen(counter, column));
            }
            poly_ntt(&u.s);

            if (column == 0)
                pointwise_montgomery_by_A_elem_set(&b, rhoprime, row, column, &u.s);
            else
                pointwise_montgomery_by_A_elem_addto(&b, rhoprime, row, column, &u.s);
        }

        poly_invntt_tomont(&b);
        poly_uniform_eta(&u.s, sigma, nonce_e_gen(counter, row));
        poly_add(&b, &b, &u.s);

        poly_uniform_add(&b, rhoprime, nonce_a(row));
        poly_freeze(&b);

        poly_decompose_stream_pack(pk, &b, row);
        poly_sub(&u.s, &u.s, &b);

        pack_sk_stream_s2(sk, &u.s, row);
        fft_init_and_bitrev_inplace(u.fft_input);
        fft(u.fft_input);
        for (size_t j = 0; j < N; j++)
            sum[j] += complex_fp_sqabs(u.fft_input[j]);
    }

    int64_t squared_singular_value = polyvecmk_sqsing_value_min(sum, &u.s);

    counter += M + K;
    if (squared_singular_value > sqsing_bound)
        goto reject;

    pack_pk_stream_remain(pk, rhoprime);
    pack_sk_stream_remain(sk, pk, key);

    return 0;
}

/* Key generation for mode 5 (D = 0): pass 1 samples (s1, s2) to compute the
 * singular-value check, pass 2 re-samples them for the accepted nonce and
 * computes NTT(-2b) column by column.  Both passes share memory via a union. */
static inline int keygen_mode5(uint8_t *pk, uint8_t *sk,
                                       const uint8_t seed[SEEDBYTES])
{
    uint8_t seedbuf[2 * SEEDBYTES + CRHBYTES] = {0};
    uint16_t counter = 0;
    const uint8_t *rhoprime, *sigma, *key;

    union {
        complex_fp32_16 fft_input[FFT_N]; /* Pass 1 FFT scratch */
        poly s;                           /* both passes */
    } u;
    union {
        int32_t sum[N];  /* Pass 1: sv accumulator */
        poly    b;       /* Pass 2: row accumulator */
    } scratch;

    generate_seed_from_one_source(seedbuf, 2 * SEEDBYTES + CRHBYTES, seed, SEEDBYTES);

    rhoprime = seedbuf;
    sigma = rhoprime + SEEDBYTES;
    key = sigma + CRHBYTES;

reject:
    memset(scratch.sum, 0, sizeof(scratch.sum));
    for (size_t column = 0; column < M; column++)
    {
        poly_uniform_eta(&u.s, sigma, nonce_s_gen(counter, column));
        fft_init_and_bitrev_inplace(u.fft_input);
        fft(u.fft_input);
        for (size_t j = 0; j < N; j++)
            scratch.sum[j] += complex_fp_sqabs(u.fft_input[j]);
    }
    for (size_t row = 0; row < K; row++)
    {
        poly_uniform_eta(&u.s, sigma, nonce_e_gen(counter, row));
        fft_init_and_bitrev_inplace(u.fft_input);
        fft(u.fft_input);
        for (size_t j = 0; j < N; j++)
            scratch.sum[j] += complex_fp_sqabs(u.fft_input[j]);
    }
    counter += M + K;
    if (polyvecmk_sqsing_value_min(scratch.sum, &u.s) > sqsing_bound)
        goto reject;

    counter -= M + K;
    for (size_t row = 0; row < K; row++)
    {
        for (size_t column = 0; column < M; column++)
        {
            poly_uniform_eta(&u.s, sigma, nonce_s_gen(counter, column));
            if (row == 0)
                pack_sk_stream_s1(sk, &u.s, column);
            poly_ntt(&u.s);

            if (column == 0)
                pointwise_montgomery_by_A_elem_set(&scratch.b, rhoprime, row, column, &u.s);
            else
                pointwise_montgomery_by_A_elem_addto(&scratch.b, rhoprime, row, column, &u.s);
        }

        poly_frommont(&scratch.b);

        poly_uniform_eta(&u.s, sigma, nonce_e_gen(counter, row));
        pack_sk_stream_s2(sk, &u.s, row);
        poly_ntt(&u.s);
        poly_add(&scratch.b, &scratch.b, &u.s);

        poly_double_negate(&scratch.b);
        poly_caddq(&scratch.b);

        pack_pk_stream(pk, &scratch.b, row);
    }
    counter += M + K;

    pack_pk_stream_remain(pk, rhoprime);
    pack_sk_stream_remain(sk, pk, key);

    return 0;
}

/*************************************************
 * Name:        crypto_sign_keypair_internal
 *
 * Description: Generates public and private key from a 32-byte seed
 *              (HAETAE 1.2.0 KeyGenInternal).
 *
 * Arguments:   - uint8_t *pk: pointer to output public key (allocated
 *                             array of CRYPTO_PUBLICKEYBYTES bytes)
 *              - uint8_t *sk: pointer to output private key (allocated
 *                             array of CRYPTO_SECRETKEYBYTES bytes)
 *              - const uint8_t *seed: pointer to the input seed
 *
 * Returns 0 (success)
 **************************************************/
int crypto_sign_keypair_internal(uint8_t *pk, uint8_t *sk,
                                 const uint8_t seed[SEEDBYTES]) {
#if D > 0
    return keygen_mode23(pk, sk, seed);
#else
    return keygen_mode5(pk, sk, seed);
#endif
}

/*************************************************
 * Name:        crypto_sign_keypair
 *
 * Description: Generates public and private key (HAETAE 1.2.0 KeyGen).
 *
 * Returns 0 (success)
 **************************************************/
int crypto_sign_keypair(uint8_t *pk, uint8_t *sk) {
    uint8_t seed[SEEDBYTES];

    randombytes(seed, SEEDBYTES);
    return crypto_sign_keypair_internal(pk, sk, seed);
}
