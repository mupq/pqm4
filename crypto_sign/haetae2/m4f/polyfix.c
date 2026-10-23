// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#include "polyfix.h"
#include "fips202.h"
#include "fixpoint.h"
#include "params.h"
#include "sampler.h"

#include <stdint.h>

/*************************************************
 * Name:        polyfix_add
 *
 * Description: Add fixed-point polynomial (HAETAE_LNBITS fractional bits)
 *              and integer polynomial: c = a + HAETAE_LN * b.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyfix *c: pointer to output fixed-point polynomial
 *              - const polyfix *a: pointer to first summand
 *              - const poly *b: pointer to second summand
 **************************************************/
void polyfix_add(polyfix *c, const polyfix *a, const poly *b) {
  unsigned int i;

  for (i = 0; i < HAETAE_N; ++i)
    c->coeffs[i] = a->coeffs[i] + HAETAE_LN * b->coeffs[i];
}

static int32_t fix_round(int32_t num) {
  return (num + HAETAE_LNHALF) >> HAETAE_LNBITS;
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

  for (i = 0; i < HAETAE_N; ++i)
    a->coeffs[i] = fix_round(b->coeffs[i]);
}

/*************************************************
 * Name:        polyfixveck_round
 *
 * Description: rounds a fixed polynomial vector of length HAETAE_K
 *
 * Arguments:   - polyveck *a: output integer polynomial vector
 *              - const polyfixveck *b: input fixed polynomial vector
 **************************************************/
void polyfixveck_round(polyveck *a, const polyfixveck *b) {
  unsigned i;

  for (i = 0; i < HAETAE_K; ++i)
    polyfix_round(&a->vec[i], &b->vec[i]);
}

/*************************************************
 * Name:        polyfixvecl_round
 *
 * Description: rounds a fixed polynomial vector of length L
 *
 * Arguments:   - polyvecl *a: output integer polynomial vector
 *              - const polyfixvecl *b: input fixed polynomial vector
 **************************************************/
void polyfixvecl_round(polyvecl *a, const polyfixvecl *b) {
  unsigned i;

  for (i = 0; i < HAETAE_L; ++i)
    polyfix_round(&a->vec[i], &b->vec[i]);
}

/*************************************************
 * Name:        polyfixveclk_sqnorm2
 *
 * Description: Calculates the squared L2 norm of the fixed-point polynomial
 *              vector (a, b) of length HAETAE_L + HAETAE_K. The result is the
 *              squared norm * HAETAE_LN^2, as the coefficients are stored
 *              multiplied by HAETAE_LN.
 *
 * Arguments:   - const polyfixvecl *a: polynomial vector with length HAETAE_L
 *              - const polyfixveck *b: polynomial vector with length HAETAE_K
 **************************************************/
uint64_t polyfixveclk_sqnorm2(const polyfixvecl *a, const polyfixveck *b) {
  unsigned int i, j;
  uint64_t ret = 0;

  for (i = 0; i < HAETAE_L; ++i) {
    for (j = 0; j < HAETAE_N; ++j)
      ret += (int64_t)a->vec[i].coeffs[j] * a->vec[i].coeffs[j];
  }

  for (i = 0; i < HAETAE_K; ++i) {
    for (j = 0; j < HAETAE_N; ++j)
      ret += (int64_t)b->vec[i].coeffs[j] * b->vec[i].coeffs[j];
  }

  return ret;
}

/*************************************************
 * Name:        polyfixveclk_sqnorm2_2z_minus_y
 *
 * Description: Squared norm of (2 * z1 - y1, 2 * z2 - y2), i.e.
 *              polyfixveclk_sqnorm2() of the vector 2z - y without storing it.
 *
 * Arguments:   - const polyfixvecl *z1, *y1: vectors of length HAETAE_L
 *              - const polyfixveck *z2, *y2: vectors of length HAETAE_K
 **************************************************/
uint64_t polyfixveclk_sqnorm2_2z_minus_y(const polyfixvecl *z1,
                                         const polyfixvecl *y1,
                                         const polyfixveck *z2,
                                         const polyfixveck *y2) {
  unsigned int i, j;
  int32_t t;
  uint64_t ret = 0;

  for (i = 0; i < HAETAE_L; ++i) {
    for (j = 0; j < HAETAE_N; ++j) {
      t = 2 * z1->vec[i].coeffs[j] - y1->vec[i].coeffs[j];
      ret += (int64_t)t * t;
    }
  }

  for (i = 0; i < HAETAE_K; ++i) {
    for (j = 0; j < HAETAE_N; ++j) {
      t = 2 * z2->vec[i].coeffs[j] - y2->vec[i].coeffs[j];
      ret += (int64_t)t * t;
    }
  }

  return ret;
}

/*************************************************
 * Name:        polyfixveclk_sample_hyperball
 *
 * Description: Sample (y1, y2) uniformly from the hyperball (fixed point)
 *              and the byte b whose two lowest bits are used in signing.
 *
 * Arguments:   - polyfixvecl *y1: output polynomial vector of length HAETAE_L
 *              - polyfixveck *y2: output polynomial vector of length HAETAE_K
 *              - uint8_t *b: output byte
 *              - uint8_t seed[HAETAE_CRHBYTES]: input seed bytes
 *              - const uint16_t nonce: input nonce
 *              - uint64_t samples[]: workspace of HAETAE_HYPERBALL_SAMPLES
 *              words
 *
 * Returns the next nonce.
 *
 * Specification: Implements @[Algorithm 13, SampleHyperball]
 **************************************************/
uint16_t
polyfixveclk_sample_hyperball(polyfixvecl *y1, polyfixveck *y2, uint8_t *b,
                              const uint8_t seed[HAETAE_CRHBYTES],
                              const uint16_t nonce,
                              uint64_t samples[HAETAE_HYPERBALL_SAMPLES]) {
  uint16_t ni = nonce;
  fp96_76 sqsum, invsqrt;
  unsigned int i, j;
  uint8_t signs[HAETAE_N * (HAETAE_L + HAETAE_K) / 8];

  do {
    sqsum.limb48[0] = 0;
    sqsum.limb48[1] = 0;

    sample_gauss_N(&samples[0], &signs[0], &sqsum, seed, ni++, HAETAE_N + 1);
    sample_gauss_N(&samples[HAETAE_N], &signs[HAETAE_N / 8], &sqsum, seed, ni++,
                   HAETAE_N + 1);

    for (i = 2; i < HAETAE_L + HAETAE_K; i++)
      sample_gauss_N(&samples[HAETAE_N * i], &signs[HAETAE_N / 8 * i], &sqsum,
                     seed, ni++, HAETAE_N);

    // divide sqsum by 2 and approximate inverse square root
    sqsum.limb48[0] += 1; // rounding
    sqsum.limb48[0] >>= 1;
    sqsum.limb48[0] += (sqsum.limb48[1] & 1) << 47;
    sqsum.limb48[1] >>= 1;
    sqsum.limb48[1] += sqsum.limb48[0] >> 48;
    sqsum.limb48[0] &= (UINT64_C(1) << 48) - 1;
    fixpoint_newton_invsqrt(&invsqrt, &sqsum);
    fixpoint_mul_high(&sqsum, &invsqrt,
                      (uint64_t)(HAETAE_B0 * HAETAE_LN + HAETAE_SQNM / 2)
                          << (28 - 13));

    for (i = 0; i < HAETAE_L; i++) {
      for (j = 0; j < HAETAE_N; j++)
        y1->vec[i].coeffs[j] = fixpoint_mul_rnd13(
            samples[(i * HAETAE_N + j)], &sqsum,
            (signs[(i * HAETAE_N + j) / 8] >> ((i * HAETAE_N + j) % 8)) & 1);
    }
    for (i = HAETAE_L; i < HAETAE_K + HAETAE_L; i++) {
      for (j = 0; j < HAETAE_N; j++)
        y2->vec[i - HAETAE_L].coeffs[j] = fixpoint_mul_rnd13(
            samples[(i * HAETAE_N + j)], &sqsum,
            (signs[(i * HAETAE_N + j) / 8] >> ((i * HAETAE_N + j) % 8)) & 1);
    }
  } while (polyfixveclk_sqnorm2(y1, y2) > HAETAE_B0SQ * HAETAE_LN * HAETAE_LN);

  {
    uint8_t tmp[HAETAE_CRHBYTES + 2];
    for (i = 0; i < HAETAE_CRHBYTES; i++) {
      tmp[i] = seed[i];
    }
    tmp[HAETAE_CRHBYTES + 0] = ni >> 0;
    tmp[HAETAE_CRHBYTES + 1] = ni >> 8;
    shake256(b, 1, tmp, HAETAE_CRHBYTES + 2);
  }

  return ni;
}
