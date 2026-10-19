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
#include "polyfix.h"
#include "decompose.h"
#include "ntt.h"
#include "params.h"
#include "reduce.h"
#include "sampler.h"
#include "symmetric.h"
#include <stdint.h>

int32_t fix_round(int32_t num) {
    return (num + LNHALF) >> LNBITS;
}

/*************************************************
 * Name:        polyfix_round
 *
 * Description: rounds a fixed polynomial to integer polynomial
 *
 * Arguments:   - poly *a: output integer polynomial
 *              - const polyfix *b: input fixed polynomial
 **************************************************/
void polyfix_round(poly *a, const polyfix *b) {
    unsigned i;

    for (i = 0; i < N; ++i)
        a->coeffs[i] = fix_round(b->coeffs[i]);
}

void polyfix_round_inplace(polyfix *a) {
    unsigned i;
    for (i = 0; i < N; ++i) {
        a->coeffs[i] = fix_round(a->coeffs[i]);
    }
}

/*
 * Streaming hyperball helpers for full-stream signing.
 */

uint16_t hyperball_pass1_scaling(fp96_76 *scaling_factor_out,
                                 const uint8_t seed[CRHBYTES],
                                 uint16_t nonce_start) {
    fp96_76 sqsum;
    unsigned int i, j;
    uint16_t ni = nonce_start;
    gauss_stream_ctx gctx;

    sqsum.limb48[0] = 0;
    sqsum.limb48[1] = 0;

    /* Stream Gaussian samples one-at-a-time, accumulate sqsum only. */
    for (i = 0; i < L + K; i++) {
        const size_t len = (i < 2) ? (N + 1) : N;
        gauss_stream_init(&gctx, seed, ni++, len);
        for (j = 0; j < len; j++) {
            uint64_t samp;
            fp96_76 sqr;
            gauss_stream_sample(&gctx, &samp, &sqr);
            sqsum.limb48[0] += sqr.limb48[0];
            sqsum.limb48[1] += sqr.limb48[1];
        }
    }
    renormalize(&sqsum);

    /* Compute scaling factor (same arithmetic as the baseline sampler). */
    sqsum.limb48[0] += 1; /* rounding */
    sqsum.limb48[0] >>= 1;
    sqsum.limb48[0] += (sqsum.limb48[1] & 1) << 47;
    sqsum.limb48[1] >>= 1;
    sqsum.limb48[1] += sqsum.limb48[0] >> 48;
    sqsum.limb48[0] &= (1ULL << 48) - 1;

    fp96_76 invsqrt;
    fixpoint_newton_invsqrt(&invsqrt, &sqsum);
    fixpoint_mul_high(&sqsum, &invsqrt,
                      (uint64_t)(B0 * LN + SQNM / 2) << (28 - 13));

    *scaling_factor_out = sqsum;
    return ni; /* nonce after all L+K blocks */
}

void hyperball_regen_single(polyfix *out,
                            const uint8_t seed[CRHBYTES],
                            uint16_t nonce_for_this_poly,
                            size_t gauss_len,
                            const fp96_76 *scaling_factor) {
    gauss_stream_ctx gctx;
    unsigned int j;

    gauss_stream_init(&gctx, seed, nonce_for_this_poly, gauss_len);

    for (j = 0; j < N; j++) {
        uint64_t samp;
        fp96_76 sqr;
        gauss_stream_sample(&gctx, &samp, &sqr);
        uint8_t sign = (gctx.signs[j / 8] >> (j % 8)) & 1;
        out->coeffs[j] = fixpoint_mul_rnd13(samp, scaling_factor, sign);
    }

    /* If gauss_len == N+1, consume the (N+1)-th sample (discard). */
    if (gauss_len > N) {
        uint64_t samp;
        fp96_76 sqr;
        gauss_stream_sample(&gctx, &samp, &sqr);
    }
}
