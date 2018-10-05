/******************************************************************************
 * NTRU Cryptography Reference Source Code submitting to NIST call for
 * proposals for post quantum cryptography
 *
 * This code is written by Zhenfei Zhang @ OnboardSecurity, with additional
 * codes from public domain.
 *
 ******************************************************************************/
/*
 * poly_gen.h
 *
 *  Created on: Aug 16, 2017
 *      Author: zhenfei
 */

#ifndef POLY_POLY_H_
#define POLY_POLY_H_

#include <stdint.h>
#include "param.h"
#include "stddef.h"
/* generate a random binary polynomial with degree less than N */
void
binary_poly_gen(
          uint64_t  *f,
    const uint16_t  N);


/* generate a trinary polynomial with fixed number of +/- 1s */
void
trinary_poly_gen(
          uint16_t  *f,
    const uint16_t  N,
    const uint16_t  d);


/* deterministically generate a trinary polynomial with fixed number of +/- 1s */
void
trinary_poly_gen_w_seed(
          uint16_t  *f,
    const uint16_t  N,
    const uint16_t  d,
    unsigned char   *seed,
    const size_t    seed_len);

/* deterministically generate a random trinary polynomial */
void
rand_tri_poly_from_seed(
          uint16_t   *v,
    const int16_t    N,
    unsigned char    *seed,
    const size_t     seed_len);

/*
 * generate a degree N-1 polynomial whose coefficients
 * follow discrete Gaussian with deviation stdev
 */

void DGS (
          int64_t   *v,
    const uint16_t  N,
    const uint16_t   stdev);


/* converting a poly into its NTT form */
void NTT(
    const int64_t     *f,
          int64_t     *f_ntt,
    const PARAM_SET    *param);

/* inverse the NTT conversion */
void INTT(
          int64_t     *f,
    const int64_t     *f_ntt,
    const PARAM_SET    *param);

/* ntru_ring_inv
 *
 * Finds the inverse of a polynomial, a, in (Z/2Z)[X]/(X^N - 1).
  */

int
ntru_ring_inv(
    uint16_t       *a,          /*  in - pointer to polynomial a */
    uint16_t        N,          /*  in - no. of coefficients in a */
    uint16_t       *t,          /*  in - temp buffer of 2N elements */
    uint16_t       *a_inv);     /* out - address for polynomial a^-1 */


/* ntru_ring_lift_inv_pow2_standard
 *
 * Lifts an element of (Z/2)[x]/(x^N - 1) to (Z/q)[x]/(x^N - 1)
 * where q is a power of 2 such that 256 < q <= 65536.
 *
 * inv must be padded with zeros to the degree used by
 * ntru_ring_mult_coefficients.
 *
 * inv is assumed to be the inverse mod 2 of the trinary element f.
 * The lift is performed in place -- inv will be overwritten with the result.
 *
 * Requires scratch space for ntru_ring_mult_coefficients + one extra
 * polynomial with the same padding.
 */
uint32_t
ring_lift_inv_pow2(
    uint16_t       *inv,
    uint16_t const *f,
    PARAM_SET const *param,
    uint16_t       *t);


/* ntru_ring_mult_coefficients
 *
 * Multiplies ring element (polynomial) "a" by ring element (polynomial) "b"
 * to produce ring element (polynomial) "c" in (Z/qZ)[X]/(X^N - 1).
 * This is a convolution operation.
 *
 * This assumes q is 2^r where 8 < r < 16, so that overflow of the sum
 * beyond 16 bits does not matter.
 */

void
ntru_ring_mult_coefficients(
    uint16_t const *a,          /*  in - pointer to polynomial a */
    uint16_t const *b,          /*  in - pointer to polynomial b */
    PARAM_SET const*param,
    uint16_t       *tmp,        /*  in - temp buffer of 3*padN elements */
    uint16_t       *c);          /* out - address for polynomial c */
/* misc functions */

int64_t InvMod(int64_t a, int64_t n);

int64_t modq(int64_t a, int64_t q);
#endif /* POLY_POLY_H_ */
