// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#include "decompose.h"
#include "params.h"

#include <stdint.h>

/*************************************************
 * Name:        decompose_z1
 *
 * Description: For finite field element r, compute high and lowbits
 *              hb, lb such that r = hb * b + lb with -b/2 <= lb < b/2,
 *              for b = alpha = 256.
 *
 * Arguments:   - int32_t *highbits: pointer to output element hb
 *              - int32_t *lowbits: pointer to output element lb
 *              - int32_t r: input element
 *
 * Specification: Implements @[Algorithm 20, HighBits] and
 *                @[Algorithm 21, LowBits] with alpha = 256
 **************************************************/
void decompose_z1(int32_t *highbits, int32_t *lowbits, const int32_t r) {
  const int alpha = 256; // base of HighBits/LowBits of z1 (specification)
  const int log_alpha = 8;

  int32_t lb, center;
  uint32_t alpha_mask = alpha - 1;

  lb = r & alpha_mask;
  center = ((alpha >> 1) - (lb + 1)) >> 31; // if lb >= HALF_ALPHA
  lb -= alpha & center;
  *lowbits = lb;
  *highbits = (r + (alpha >> 1)) >> log_alpha;
}

/*************************************************
 * Name:        decompose_hint
 *
 * Description: For r in [0, 2Q), compute the highbits
 *              hb = floor((r + HAETAE_ALPHA_HINT/2) / HAETAE_ALPHA_HINT),
 *              i.e. r divided by HAETAE_ALPHA_HINT and rounded (halves
 *              up); the largest value hb = (2Q - 2) / HAETAE_ALPHA_HINT
 *              is replaced by 0.
 *
 * Arguments:   - int32_t *highbits: pointer to output element hb
 *              - int32_t r: input element
 *
 * Specification: Implements @[Algorithm 22, DecomposeHint]
 **************************************************/

void decompose_hint(int32_t *highbits, const int32_t r) {
  int32_t hb, edgecase;

  hb = (r + HAETAE_HALF_ALPHA_HINT) >> HAETAE_LOG_ALPHA_HINT;
  edgecase = ((HAETAE_DQ - 2) / HAETAE_ALPHA_HINT - (hb + 1)) >>
             31; // if hb == (HAETAE_DQ-2)/ALPHA
  hb -= (HAETAE_DQ - 2) / HAETAE_ALPHA_HINT & edgecase; // hb = 0

  *highbits = hb;
}

/*************************************************
 * Name:        decompose_vk
 *
 * Description: For finite field element a, compute a0, a1 such that
 *              a = a1*2^D + a0 with D = 1 and a0 in {-1, 0, 1}, where
 *              a1 = a/2 rounded to the nearest integer, ties to even.
 *              Assumes a to be standard representative.
 *
 * Arguments:   - int32_t a: input element
 *              - int32_t *a0: pointer to output element a0
 *
 * Returns:     - a1
 *
 * Specification: Implements @[Algorithm 19, DecomposeVK]
 **************************************************/
int32_t decompose_vk(int32_t *a0, const int32_t a) {
  *a0 = a & 1;
  *a0 -= ((a >> 1) & *a0) << 1;
  return (a - *a0) >> 1;
}
