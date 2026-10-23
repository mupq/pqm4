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
// clang-format off
#ifndef HAETAE_POLYFIX_H
#define HAETAE_POLYFIX_H

#include "params.h"
#include "poly.h"
#include "polyvec.h"
#include "reduce.h"
#include <stdint.h>

/*
 * NOTE: polyfix has the same in-memory layout as `poly`.
 *
 * In the low-SRAM signing path the NTT and poly routines are applied to
 * rounded fixed-point polynomials in place.  To avoid strict-aliasing
 * undefined behaviour, polyfix is an alias of `poly` (semantic tag only).
 */

typedef poly polyfix;

#define fix_round HAETAE_NAMESPACE(fix_round)
int32_t fix_round(int32_t num);

#define polyfix_round HAETAE_NAMESPACE(polyfix_round)
void polyfix_round(poly *a, const polyfix *b);

/* In-place rounding (safe because polyfix and poly share the same layout).
 * This is used to reduce stack pressure by avoiding an extra rounded copy.
 */
#define polyfix_round_inplace HAETAE_NAMESPACE(polyfix_round_inplace)
void polyfix_round_inplace(polyfix *a);

/*
 * Streaming hyperball sampler helpers (two-pass SampleHyperball).
 *
 * hyperball_pass1_scaling: Pass 1 only -- compute sqnorm of unscaled Gaussian
 *   vector and derive the scaling factor.  The Gaussian samples are NOT stored.
 *   Returns the nonce value after all L+K Gaussian blocks have been consumed.
 *
 * hyperball_regen_single: Regenerate the i-th poly from the same seed/nonce,
 *   apply the previously computed scaling factor, and write to `out`.
 */
#define hyperball_pass1_scaling HAETAE_NAMESPACE(hyperball_pass1_scaling)
uint16_t hyperball_pass1_scaling(fp96_76 *scaling_factor_out,
                                 const uint8_t seed[CRHBYTES],
                                 uint16_t nonce_start);

#define hyperball_regen_single HAETAE_NAMESPACE(hyperball_regen_single)
void hyperball_regen_single(polyfix *out,
                            const uint8_t seed[CRHBYTES],
                            uint16_t nonce_for_this_poly,
                            size_t gauss_len,
                            const fp96_76 *scaling_factor);

#endif
// clang-format on
