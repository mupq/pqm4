// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#include "polyvec.h"
#include "decompose.h"
#include "fft.h"
#include "params.h"
#include "poly.h"
#include "reduce.h"

#include <stddef.h>
#include <stdint.h>

/*************************************************
 * Name:        polyveck_add
 *
 * Description: Add vectors of polynomials of length HAETAE_K.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyveck *w: pointer to output vector
 *              - const polyveck *u: pointer to first summand
 *              - const polyveck *v: pointer to second summand
 **************************************************/
void polyveck_add(polyveck *w, const polyveck *u, const polyveck *v) {
  unsigned int i;

  for (i = 0; i < HAETAE_K; ++i)
    poly_add(&w->vec[i], &u->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyveck_sub
 *
 * Description: Subtract vectors of polynomials of length HAETAE_K.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyveck *w: pointer to output vector
 *              - const polyveck *u: pointer to first input vector
 *              - const polyveck *v: pointer to second input vector to be
 *              subtracted from first input vector
 **************************************************/
void polyveck_sub(polyveck *w, const polyveck *u, const polyveck *v) {
  unsigned int i;

  for (i = 0; i < HAETAE_K; ++i)
    poly_sub(&w->vec[i], &u->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyveck_double
 *
 * Description: Double vector of polynomials of length HAETAE_K.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyveck *b: pointer to input/output vector
 **************************************************/
void polyveck_double(polyveck *b) {
  unsigned int i, j;

  for (i = 0; i < HAETAE_K; ++i)
    for (j = 0; j < HAETAE_N; ++j)
      b->vec[i].coeffs[j] *= 2;
}

/*************************************************
 * Name:        polyveck_reduce2q
 *
 * Description: Reduce coefficients to 2q
 *
 * Arguments:   - polyveck *v: pointer to input/output vector
 **************************************************/
void polyveck_reduce2q(polyveck *v) {
  unsigned int i;

  for (i = 0; i < HAETAE_K; ++i)
    poly_reduce2q(&v->vec[i]);
}

/*************************************************
 * Name:        polyveck_freeze
 *
 * Description: For all coefficients of polynomials in vector of length HAETAE_K
 *              compute standard representative r = a mod^+ HAETAE_Q.
 *
 * Arguments:   - polyveck *v: pointer to input/output vector
 **************************************************/
void polyveck_freeze(polyveck *v) {
  unsigned int i;

  for (i = 0; i < HAETAE_K; ++i)
    poly_freeze(&v->vec[i]);
}

/*************************************************
 * Name:        polyveck_freeze2q
 *
 * Description: For all coefficients of polynomials in vector of length HAETAE_K
 *              compute standard representative r = a mod^+ 2Q.
 *
 * Arguments:   - polyveck *v: pointer to input/output vector
 **************************************************/
void polyveck_freeze2q(polyveck *v) {
  unsigned int i;

  for (i = 0; i < HAETAE_K; ++i)
    poly_freeze2q(&v->vec[i]);
}

/*************************************************
 * Name:        polyveck_expand_vecA
 *
 * Description: Sample a vector of polynomials with uniformly random
 *              coefficients in Zq by rejection sampling on the
 *              output stream from SHAKE128(seed|nonce)
 *
 * Arguments:   - polyveck *v: pointer to output a vector of polynomials of
 *              length HAETAE_K
 *              - const uint8_t seed[]: byte array with seed of length
 *              HAETAE_SEEDBYTES
 *
 * Specification: Implements @[Algorithm 7, ExpandVeca]
 **************************************************/
void polyveck_expand_vecA(polyveck *v, const uint8_t seed[HAETAE_SEEDBYTES]) {
  unsigned int i, nonce = (HAETAE_K << 8) + HAETAE_M;
  for (i = 0; i < HAETAE_K; ++i)
    poly_uniform(&v->vec[i], seed, nonce++);
}

/*************************************************
 * Name:        polyvecmk_expand_S
 *
 * Description: Sample a vector of polynomials with uniformly random
 *              coefficients in [-ETA,ETA] by rejection sampling on the
 *              output stream from SHAKE256(seed|nonce)
 *
 * Arguments:   - polyvecm *u: pointer to output vector of polynomials of
 *              length HAETAE_M
 *              - polyveck *v: pointer to output vector of polynomials of
 *              length HAETAE_K
 *              - const uint8_t seed[]: byte array with seed of length
 *              HAETAE_CRHBYTES
 *              - uint16_t nonce: 2-byte nonce of the first polynomial
 *
 * Specification: Implements @[Algorithm 10, ExpandS]
 **************************************************/
void polyvecmk_expand_S(polyvecm *u, polyveck *v,
                        const uint8_t seed[HAETAE_CRHBYTES], uint16_t nonce) {
  unsigned int i, n = nonce;
  for (i = 0; i < HAETAE_M; i++)
    poly_uniform_eta(&u->vec[i], seed, n++);
  for (i = 0; i < HAETAE_K; ++i)
    poly_uniform_eta(&v->vec[i], seed, n++);
}

/*************************************************
 * Name:        polyveck_double_negate
 *
 * Description: multiply each coefficient with -2 mod q (Montgomery
 *              multiplication by -2 * MONT; outputs in (-q, q))
 *
 * Arguments:   - polyveck *v: pointer to input/output vector of polynomials
 *                              of length HAETAE_K
 **************************************************/
void polyveck_double_negate(polyveck *v) {
  unsigned int i, j;

  for (i = 0; i < HAETAE_K; ++i)
    for (j = 0; j < HAETAE_N; j++)
      v->vec[i].coeffs[j] =
          montgomery_reduce((int64_t)v->vec[i].coeffs[j] * MONT * -2);
}

/*************************************************
 * Name:        polyveck_frommont
 *
 * Description: multiply each coefficient with MONT mod q (Montgomery
 *              multiplication by MONTSQ; outputs in (-q, q))
 *
 * Arguments:   - polyveck *v: pointer to input/output vector of polynomials
 *              of length HAETAE_K
 **************************************************/
void polyveck_frommont(polyveck *v) {
  unsigned int i, j;

  for (i = 0; i < HAETAE_K; ++i)
    for (j = 0; j < HAETAE_N; j++)
      v->vec[i].coeffs[j] =
          montgomery_reduce((int64_t)v->vec[i].coeffs[j] * MONTSQ);
}

/*************************************************
 * Name:        polyveck_poly_fromcrt
 *
 * Description: recover polynomials from CRT domain, where all "mod q"
 *              polynomials are known and only the uppermost "mod 2" polynomial
 *              is non-zero
 *
 * Arguments:   - polyveck *w: pointer to output vector of polynomials of
 *              length HAETAE_K
 *              - const polyveck *u: pointer to the input vector of polynomials
 *              of length HAETAE_K
 *              - const poly *v: pointer to the input polynomial ("mod 2")
 *
 * Specification: Implements @[Algorithm 3, iCRT]
 **************************************************/
void polyveck_poly_fromcrt(polyveck *w, const polyveck *u, const poly *v) {
  unsigned int i;

  poly_fromcrt(&w->vec[0], &u->vec[0], v);

  for (i = 1; i < HAETAE_K; i++) {
    poly_fromcrt0(&w->vec[i], &u->vec[i]);
  }
}

void polyveck_highbits_hint(polyveck *w, const polyveck *v) {
  unsigned int i, j;
  for (i = 0; i < HAETAE_K; i++) {
    for (j = 0; j < HAETAE_N; j++) {
      decompose_hint(&w->vec[i].coeffs[j], v->vec[i].coeffs[j]);
    }
  }
}

void polyveck_caddDQ2ALPHA(polyveck *h) {
  unsigned int i, j;
  for (i = 0; i < HAETAE_K; i++) {
    for (j = 0; j < HAETAE_N; j++) {
      h->vec[i].coeffs[j] +=
          (h->vec[i].coeffs[j] >> 31) & ((HAETAE_DQ - 2) / HAETAE_ALPHA_HINT);
    }
  }
}

void polyveck_csubDQ2ALPHA(polyveck *v) {
  unsigned int i, j;
  for (i = 0; i < HAETAE_K; i++) {
    for (j = 0; j < HAETAE_N; j++) {
      v->vec[i].coeffs[j] -=
          ~((v->vec[i].coeffs[j] - (HAETAE_DQ - 2) / HAETAE_ALPHA_HINT) >> 31) &
          ((HAETAE_DQ - 2) / HAETAE_ALPHA_HINT);
    }
  }
}

void polyveck_mul_alpha(polyveck *v, const polyveck *u) {
  unsigned int i, j;
  for (i = 0; i < HAETAE_K; i++) {
    for (j = 0; j < HAETAE_N; j++) {
      v->vec[i].coeffs[j] = u->vec[i].coeffs[j] * HAETAE_ALPHA_HINT;
    }
  }
}

void polyveck_div2(polyveck *v) {
  unsigned i, j;
  for (i = 0; i < HAETAE_K; ++i)
    for (j = 0; j < HAETAE_N; ++j)
      v->vec[i].coeffs[j] >>= 1;
}

void polyveck_caddq(polyveck *v) {
  unsigned i, j;
  for (i = 0; i < HAETAE_K; ++i)
    for (j = 0; j < HAETAE_N; ++j)
      v->vec[i].coeffs[j] = caddq(v->vec[i].coeffs[j]);
}

void polyveck_decompose_vk(polyveck *v0, polyveck *v) {
  for (int i = 0; i < HAETAE_K; i++) {
    for (int j = 0; j < HAETAE_N; j++) {
      v->vec[i].coeffs[j] =
          decompose_vk(&v0->vec[i].coeffs[j], v->vec[i].coeffs[j]);
    }
  }
}

void polyveck_ntt(polyveck *x) {
  unsigned int i;
  for (i = 0; i < HAETAE_K; i++) {
    poly_ntt(&x->vec[i]);
  }
}

void polyveck_invntt_tomont(polyveck *x) {
  unsigned int i;
  for (i = 0; i < HAETAE_K; i++) {
    poly_invntt_tomont(&x->vec[i]);
  }
}

/*************************************************
 * Name:        polyveck_sqnorm2
 *
 * Description: Calculates the squared L2 norm of a polynomial vector with
 *              length k
 *
 * Arguments:   - const polyveck *b: polynomial vector with length k
 **************************************************/
uint64_t polyveck_sqnorm2(const polyveck *b) {
  unsigned int i, j;
  uint64_t ret = 0;

  for (i = 0; i < HAETAE_K; ++i) {
    for (j = 0; j < HAETAE_N; ++j) {
      ret += (uint64_t)b->vec[i].coeffs[j] * b->vec[i].coeffs[j];
    }
  }
  return ret;
}

/*************************************************
 * Name:        polyvecl_highbits
 *
 * Description: Compute HighBits of a vector of polynomials
 *
 * Arguments:   - polyvecl *v2: pointer to output vector of polynomials of
 *              length L
 *              - const polyvecl *v: pointer to input vector of polynomials of
 *              length L
 **************************************************/
void polyvecl_highbits(polyvecl *v2, const polyvecl *v) {
  unsigned int i;

  for (i = 0; i < HAETAE_L; ++i)
    poly_highbits(&v2->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyvecl_lowbits
 *
 * Description: Compute LowBits of a vector of polynomials
 *
 * Arguments:   - polyvecl *v1: pointer to output vector of polynomials of
 *              length L
 *              - const polyvecl *v: pointer to input vector of polynomials of
 *              length L
 **************************************************/
void polyvecl_lowbits(polyvecl *v1, const polyvecl *v) {
  unsigned int i;

  for (i = 0; i < HAETAE_L; ++i)
    poly_lowbits(&v1->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyvecl_sqnorm2
 *
 * Description: Calculates the squared L2 norm of a polynomial vector with
 *              length l
 *
 * Arguments:   - const polyvecl *a: polynomial vector with length l
 **************************************************/
uint64_t polyvecl_sqnorm2(const polyvecl *a) {
  unsigned int i, j;
  uint64_t ret = 0;

  for (i = 0; i < HAETAE_L; ++i) {
    for (j = 0; j < HAETAE_N; ++j) {
      ret += (uint64_t)a->vec[i].coeffs[j] * a->vec[i].coeffs[j];
    }
  }

  return ret;
}

/*************************************************
 * Name:        polyvecl_pointwise_acc_montgomery
 *
 * Description: Pointwise multiply vectors of polynomials of length L, multiply
 *              resulting vector by 2^{-32} and add (accumulate) polynomials
 *              in it. Input/output vectors are in NTT domain representation.
 *
 * Arguments:   - poly *w: output polynomial
 *              - const polyvecl *u: pointer to first input vector
 *              - const polyvecl *v: pointer to second input vector
 **************************************************/
void polyvecl_pointwise_acc_montgomery(poly *w, const polyvecl *u,
                                       const polyvecl *v) {
  unsigned int i;
  poly t;

  poly_pointwise_montgomery(w, &u->vec[0], &v->vec[0]);
  for (i = 1; i < HAETAE_L; ++i) {
    poly_pointwise_montgomery(&t, &u->vec[i], &v->vec[i]);
    poly_add(w, w, &t);
  }
}

void polyvecl_ntt(polyvecl *x) {
  unsigned int i;
  for (i = 0; i < HAETAE_L; i++) {
    poly_ntt(&x->vec[i]);
  }
}

/*************************************************
 * Name:        polyvecm_pointwise_acc_montgomery
 *
 * Description: Pointwise multiply vectors of polynomials of length M, multiply
 *              resulting vector by 2^{-32} and add (accumulate) polynomials
 *              in it. Input/output vectors are in NTT domain representation.
 *
 * Arguments:   - poly *w: output polynomial
 *              - const polyvecm *u: pointer to first input vector
 *              - const polyvecm *v: pointer to second input vector
 **************************************************/
void polyvecm_pointwise_acc_montgomery(poly *w, const polyvecm *u,
                                       const polyvecm *v) {
  unsigned int i;
  poly t;

  poly_pointwise_montgomery(w, &u->vec[0], &v->vec[0]);
  for (i = 1; i < HAETAE_M; ++i) {
    poly_pointwise_montgomery(&t, &u->vec[i], &v->vec[i]);
    poly_add(w, w, &t);
  }
}

void polyvecm_ntt(polyvecm *x) {
  unsigned int i;
  for (i = 0; i < HAETAE_M; i++) {
    poly_ntt(&x->vec[i]);
  }
}

/*************************************************
 * Name:        minmax
 *
 * Description: compare and swap two integers
 *
 * Arguments:   - int64_t *x: pointer to first input/output integer
 *              - int64_t *y: pointer to second input/output integer
 *
 * Specification: Implements @[Algorithm 50, minmax]
 * **************************************************/
static inline void minmax(int64_t *x, int64_t *y) // taken from djbsort
{
  int64_t a = *x;
  int64_t b = *y;
  int64_t ab = b ^ a;
  int64_t c = b - a;
  c ^= ab & (c ^ b);
  c >>= 63;
  c &= ab;
  *x = a ^ c;
  *y = b ^ c;
}
static inline void minmaxmask(int32_t *x, int32_t *y,
                              int32_t *mask) // adapted from djbsort
{
  // If mask is -1, we perform the operation, else we do basically nothing.
  // mask truth table:
  // mask = 0 -> mask = 0, no swap is performed
  // mask = -1, swap performed -> mask = 0
  // mask = -1, swap not performed -> mask = -1
  int32_t a = *x;
  int32_t b = *y;
  int32_t ab = (b ^ a) & *mask;
  int32_t c = b - a;
  c ^= ab & (c ^ b);
  c >>= 31;
  *mask &= ~c;
  c &= ab;
  *x = a ^ c;
  *y = b ^ c;
}

/*************************************************
 * Name:        polyvecmk_sk_singular_value
 *
 * Description: calculate the (rounded, fixed-point) squared largest singular
 *              value bound of the signing key, which KeyGen compares with
 *              HAETAE_GAMMA^2 * HAETAE_N
 *
 * Arguments:   - const polyvecm *s1: pointer to first input vector
 *              - const polyveck *s2: pointer to second input vector
 *
 * Returns the squared value.
 *
 * Specification: Implements @[Algorithm 48, skSingularValue]
 **************************************************/
/*
 * sum[j] is the sum of the squared FFT magnitudes |s_i(zeta_j)|^2 over the
 * M + K secret polynomials (fixed point).  The reference accumulates it, and
 * computes res, in int32_t; here int64_t is used, which gives the same result
 * whenever the reference does not overflow (in practice the values stay far
 * below INT32_MAX) and the value of the same formula without overflow
 * otherwise.
 */
int64_t polyvecmk_sk_singular_value(const polyvecm *s1, const polyveck *s2) {
  int64_t res = 0;
  complex_fp32_16 input[FFT_N] = {0};
  int64_t sum[HAETAE_N] = {0}, bestm[HAETAE_N / HAETAE_TAU + 1] = {0}, min = 0;

  for (size_t i = 0; i < HAETAE_M; ++i) {
    fft_init_and_bitrev(input, &s1->vec[i]);
    fft(input);
    // cumulative sum
    for (size_t j = 0; j < HAETAE_N; j++) {
      sum[j] += complex_fp_sqabs(input[j]);
    }
  }

  for (size_t i = 0; i < HAETAE_K; ++i) {
    fft_init_and_bitrev(input, &s2->vec[i]);
    fft(input);

    // cumulative sum
    for (size_t j = 0; j < HAETAE_N; j++) {
      sum[j] += complex_fp_sqabs(input[j]);
    }
  }

  // compute max m
  for (size_t i = 0; i < HAETAE_N / HAETAE_TAU + 1; ++i) {
    bestm[i] = sum[i];
  }
  for (size_t i = HAETAE_N / HAETAE_TAU + 1; i < HAETAE_N; i++) {
    for (size_t j = 0; j < HAETAE_N / HAETAE_TAU + 1; j++) {
      minmax(&sum[i], &bestm[j]);
    }
  }
  // find minimum in bestm
  min = bestm[0];
  for (size_t i = 1; i < HAETAE_N / HAETAE_TAU + 1; i++) {
    int64_t tmp = bestm[i];
    minmax(&min, &tmp);
  }
  // multiply the entries above the minimum by HAETAE_TAU and the minimum by
  // HAETAE_N mod HAETAE_TAU (as in the reference, every entry equal to the
  // minimum gets HAETAE_N mod HAETAE_TAU on a tie)
  for (size_t i = 0; i < HAETAE_N / HAETAE_TAU + 1; i++) {
    int64_t fac =
        ((min - bestm[i]) >>
         63); // all-ones if bestm[i] != min (arithmetic right shift of a
              // negative value: implementation-defined, arithmetic in GCC)
    fac = (fac & (HAETAE_TAU)) ^
          ((~fac) & (HAETAE_N % HAETAE_TAU)); // fac = HAETAE_TAU for all != min
                                              // and N%HAETAE_TAU for min
    bestm[i] += 0x10200; // add 1 for the "1 poly" in S, and prepare rounding
    bestm[i] >>= 10;     // round off 10 bits
    bestm[i] *= fac;
    res += bestm[i];
  }

  return (res + (1 << 5)) >> 6; // return rounded, squared value
}
