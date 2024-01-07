#include <stdint.h>

#include "decompose.h"
#include "fft.h"
#include "math.h"
#include "params.h"
#include "poly.h"
#include "polyvec.h"

/**************************************************************/
/************ Vectors of polynomials of length K **************/
/**************************************************************/

/*************************************************
 * Name:        polyveck_add
 *
 * Description: Add vectors of polynomials of length K.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyveck *w: pointer to output vector
 *              - const polyveck *u: pointer to first summand
 *              - const polyveck *v: pointer to second summand
 **************************************************/
void polyveck_add(polyveck *w, const polyveck *u, const polyveck *v) {
    unsigned int i;

    for (i = 0; i < K; ++i)
        poly_add(&w->vec[i], &u->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyveck_sub
 *
 * Description: Subtract vectors of polynomials of length K.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyveck *w: pointer to output vector
 *              - const polyveck *u: pointer to first input vector
 *              - const polyveck *v: pointer to second input vector to be
 *                                   subtracted from first input vector
 **************************************************/
void polyveck_sub(polyveck *w, const polyveck *u, const polyveck *v) {
    unsigned int i;

    for (i = 0; i < K; ++i)
        poly_sub(&w->vec[i], &u->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyveck_double
 *
 * Description: Double vector of polynomials of length K.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyveck *w: pointer to output vector
 **************************************************/
void polyveck_double(polyveck *b) {
    unsigned int i;

    for (i = 0; i < K; ++i)
        poly_double(&b->vec[i]);
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

    for (i = 0; i < K; ++i)
        poly_reduce2q(&v->vec[i]);
}

/*************************************************
 * Name:        polyveck_freeze
 *
 * Description: For all coefficients of polynomials in vector of length K
 *              compute standard representative r = a mod^+ Q.
 *
 * Arguments:   - polyveck *v: pointer to input/output vector
 **************************************************/
void polyveck_freeze(polyveck *v) {
    unsigned int i;

    for (i = 0; i < K; ++i)
        poly_freeze(&v->vec[i]);
}

/*************************************************
 * Name:        polyveck_freeze2q
 *
 * Description: For all coefficients of polynomials in vector of length K
 *              compute standard representative r = a mod^+ 2Q.
 *
 * Arguments:   - polyveck *v: pointer to input/output vector
 **************************************************/
void polyveck_freeze2q(polyveck *v) {
    unsigned int i;

    for (i = 0; i < K; ++i)
        poly_freeze2q(&v->vec[i]);
}

/*************************************************
 * Name:        polyveck_expand
 *
 * Description: Sample a vector of polynomials with uniformly random
 *              coefficients in Zq by rejection sampling on the
 *              output stream from SHAKE128(seed|nonce)
 *
 * Arguments:   - polyveck *v: pointer to output a vector of polynomials of
 *                             length K
 *              - const uint8_t seed[]: byte array with seed of length SEEDBYTES
 **************************************************/
void polyveck_expand(polyveck *v, const uint8_t seed[SEEDBYTES]) {
    unsigned int i, nonce = (K << 8) + M;
    for (i = 0; i < K; ++i)
        poly_uniform(&v->vec[i], seed, nonce++);
}

/*************************************************
 * Name:        polyvecmk_uniform_eta
 *
 * Description: Sample a vector of polynomials with uniformly random
 *              coefficients in [-ETA,ETA] by rejection sampling on the
 *              output stream from SHAKE256(seed|nonce)
 *
 * Arguments:   - polyveck *v: pointer to output a vector of polynomials of
 *                             length K
 *              - const uint8_t seed[]: byte array with seed of length CRHBYTES
 *              - uint16_t nonce: 2-byte nonce
 **************************************************/
void polyvecmk_uniform_eta(polyvecm *u, polyveck *v,
                           const uint8_t seed[CRHBYTES], uint16_t nonce) {
    unsigned int i, n = nonce;
    for (i = 0; i < M; i++)
        poly_uniform_eta(&u->vec[i], seed, n++);
    for (i = 0; i < K; ++i)
        poly_uniform_eta(&v->vec[i], seed, n++);
}

/*************************************************
 * Name:        polyveck_double_negate
 *
 * Description: multiply each coefficient with -2
 *
 * Arguments:   - polyveck *v: pointer to output vector of polynomials of
 *                              length K
 **************************************************/
void polyveck_double_negate(polyveck *v) {
    unsigned int i, j;

    for (i = 0; i < K; ++i)
        for (j = 0; j < N; j++)
            v->vec[i].coeffs[j] =
                montgomery_reduce((int64_t)v->vec[i].coeffs[j] * MONT * -2);
}

/*************************************************
 * Name:        polyveck_frommont
 *
 * Description: multiply each coefficient with MONT
 *
 * Arguments:   - polyveck *v: pointer to output vector of polynomials of
 *                              length K
 **************************************************/
void polyveck_frommont(polyveck *v) {
    unsigned int i, j;

    for (i = 0; i < K; ++i)
        for (j = 0; j < N; j++)
            v->vec[i].coeffs[j] =
                montgomery_reduce((int64_t)v->vec[i].coeffs[j] * MONTSQ);
}

void polyveck_poly_pointwise_montgomery(polyveck *w, const polyveck *u,
                                        const poly *v) {
    unsigned int i;
    for (i = 0; i < K; i++) {
        poly_pointwise_montgomery(&w->vec[i], &u->vec[i], v);
    }
}

/*************************************************
 * Name:        polyveck_poly_fromcrt
 *
 * Description: recover polynomials from CRT domain, where all "mod q"
 *              polynomials are known and only the uppermost "mod 2" polynomial
 *              is non-zero
 *
 * Arguments:   - polyveck *w: pointer to output vector of polynomials of
 *                             length K
 *              - const polyveck *u: pointer to the input vector of polynomials
 *                                   of length K
 *              - const poly *v: pointer to the input polynomial ("mod 2")
 **************************************************/
void polyveck_poly_fromcrt(polyveck *w, const polyveck *u, const poly *v) {
    unsigned int i;

    poly_fromcrt(&w->vec[0], &u->vec[0], v);

    for (i = 1; i < K; i++) {
        poly_fromcrt0(&w->vec[i], &u->vec[i]);
    }
}

void polyveck_highbits_hint(polyveck *w, const polyveck *v) {
    unsigned int i, j;
    for (i = 0; i < K; i++) {
        for (j = 0; j < N; j++) {
            decompose_hint(&w->vec[i].coeffs[j], v->vec[i].coeffs[j]);
        }
    }
}

void polyveck_pack_highbits(uint8_t *buf, const polyveck *v) {
    unsigned int i;
    for (i = 0; i < K; i++) {
        poly_pack_highbits(buf + i * POLY_HIGHBITS_PACKEDBYTES, &v->vec[i]);
    }
}

void polyveck_cneg(polyveck *v, const uint8_t b) {
    unsigned int row;
    for (row = 0; row < K; row++) {
        poly_cneg(&v->vec[row], b);
    }
}

void polyveck_caddDQ2ALPHA(polyveck *h) {
    unsigned int i, j;
    for (i = 0; i < K; i++) {
        for (j = 0; j < N; j++) {
            h->vec[i].coeffs[j] +=
                (h->vec[i].coeffs[j] >> 31) & ((DQ - 2) / ALPHA_HINT);
        }
    }
}

void polyveck_csubDQ2ALPHA(polyveck *v) {
    unsigned int i, j;
    for (i = 0; i < K; i++) {
        for (j = 0; j < N; j++) {
            v->vec[i].coeffs[j] -=
                ~((v->vec[i].coeffs[j] - (DQ - 2) / ALPHA_HINT) >> 31) &
                ((DQ - 2) / ALPHA_HINT);
        }
    }
}

void polyveck_mul_alpha(polyveck *v, const polyveck *u) {
    unsigned int i, j;
    for (i = 0; i < K; i++) {
        for (j = 0; j < N; j++) {
            v->vec[i].coeffs[j] = u->vec[i].coeffs[j] * ALPHA_HINT;
        }
    }
}

void polyveck_div2(polyveck *v) {
    unsigned i, j;
    for (i = 0; i < K; ++i)
        for (j = 0; j < N; ++j)
            v->vec[i].coeffs[j] >>= 1;
}

void polyveck_caddq(polyveck *v) {
    unsigned i, j;
    for (i = 0; i < K; ++i)
        for (j = 0; j < N; ++j)
            v->vec[i].coeffs[j] = caddq(v->vec[i].coeffs[j]);
}

void polyveck_decompose_vk(polyveck *v0, polyveck *v) {
    for (int i = 0; i < K; i++) {
        for (int j = 0; j < N; j++) {
            v->vec[i].coeffs[j] =
                decompose_vk(&v0->vec[i].coeffs[j], v->vec[i].coeffs[j]);
        }
    }
}

void polyveck_ntt(polyveck *x) {
    unsigned int i;
    for (i = 0; i < K; i++) {
        poly_ntt(&x->vec[i]);
    }
}

void polyveck_invntt_tomont(polyveck *x) {
    unsigned int i;
    for (i = 0; i < K; i++) {
        poly_invntt_tomont(&x->vec[i]);
    }
}

/*************************************************
 * Name:        polyveck_sqnorm2
 *
 * Description: Calculates L2 norm of a polynomial vector with length k
 *
 * Arguments:   - polyveck *b: polynomial vector with length k to calculate
 *norm
 **************************************************/
uint64_t polyveck_sqnorm2(const polyveck *b) {
    unsigned int i, j;
    uint64_t ret = 0;

    for (i = 0; i < K; ++i) {
        for (j = 0; j < N; ++j) {
            ret += (uint64_t)b->vec[i].coeffs[j] * b->vec[i].coeffs[j];
        }
    }
    return ret;
}

/**************************************************************/
/************ Vectors of polynomials of length L **************/
/**************************************************************/

/*************************************************
 * Name:        polyvecl_highbits
 *
 * Description: Compute HighBits of a vector of polynomials
 *
 * Arguments:   - polyvecl *v2: pointer to output vector of polynomials of
 *                              length L
 *              - const polyvecl *v: pointer to input vector of polynomials of
 *                                   length L
 **************************************************/
void polyvecl_highbits(polyvecl *v2, const polyvecl *v) {
    unsigned int i;

    for (i = 0; i < L; ++i)
        poly_highbits(&v2->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyvecl_lowbits
 *
 * Description: Compute LowBits of a vector of polynomials
 *
 * Arguments:   - polyvecl *v1: pointer to output vector of polynomials of
 *                              length L
 *              - const polyvecl *v: pointer to input vector of polynomials of
 *                                   length L
 **************************************************/
void polyvecl_lowbits(polyvecl *v1, const polyvecl *v) {
    unsigned int i;

    for (i = 0; i < L; ++i)
        poly_lowbits(&v1->vec[i], &v->vec[i]);
}


/*************************************************
 * Name:        polyvecl_cneg
 *
 * Description: Conditionally negate all polynomials of a vector
 *
 * Arguments:   - polyvecl *v: pointer to output vector of polynomials of
 *                             length L
 *              - const uint8_t b: Keep as is, if zero, else negate.
 **************************************************/
void polyvecl_cneg(polyvecl *v, const uint8_t b) {
    for (size_t column = 0; column < L; column++) {
        poly_cneg(&v->vec[column], b);
    }
}

/*************************************************
 * Name:        polyvecl_sqnorm2
 *
 * Description: Calculates L2 norm of a polynomial vector with length l
 *
 * Arguments:   - polyvecl *a: polynomial vector with length l to calculate
 *norm
 **************************************************/
uint64_t polyvecl_sqnorm2(const polyvecl *a) {
    unsigned int i, j;
    uint64_t ret = 0;

    for (i = 0; i < L; ++i) {
        for (j = 0; j < N; ++j) {
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
    for (i = 1; i < L; ++i) {
        poly_pointwise_montgomery(&t, &u->vec[i], &v->vec[i]);
        poly_add(w, w, &t);
    }
}

void polyvecl_ntt(polyvecl *x) {
    unsigned int i;
    for (i = 0; i < L; i++) {
        poly_ntt(&x->vec[i]);
    }
}

/**************************************************************/
/************ Vectors of polynomials of length M **************/
/**************************************************************/

/*************************************************
 * Name:        polyvecm_pointwise_acc_montgomery
 *
 * Description: Pointwise multiply vectors of polynomials of length L, multiply
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
    for (i = 1; i < M; ++i) {
        poly_pointwise_montgomery(&t, &u->vec[i], &v->vec[i]);
        poly_add(w, w, &t);
    }
}

void polyvecm_ntt(polyvecm *x) {
    unsigned int i;
    for (i = 0; i < M; i++) {
        poly_ntt(&x->vec[i]);
    }
}

static inline void minmax(int32_t *x, int32_t *y) // taken from djbsort
{
    int32_t a = *x;
    int32_t b = *y;
    int32_t ab = b ^ a;
    int32_t c = b - a;
    c ^= ab & (c ^ b);
    c >>= 31;
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

int64_t polyvecmk_sqsing_value(const polyvecm *s1, const polyveck *s2) {
    int32_t res = 0;
    complex_fp32_16 input[FFT_N] = {0};
    int32_t sum[N] = {0}, bestm[N / TAU + 1] = {0}, min = 0;

    for (size_t i = 0; i < M; ++i) {
        fft_bitrev(input, &s1->vec[i]);
        fft(input);

        // cumulative sum
        for (size_t j = 0; j < N; j++) {
            sum[j] += complex_fp_sqabs(input[2 * j + 1]);
        }
    }

    for (size_t i = 0; i < K; ++i) {
        fft_bitrev(input, &s2->vec[i]);
        fft(input);

        // cumulative sum
        for (size_t j = 0; j < N; j++) {
            sum[j] += complex_fp_sqabs(input[2 * j + 1]);
        }
    }

    // compute max m
    for (size_t i = 0; i < N / TAU + 1; ++i) {
        bestm[i] = sum[i];
    }
    for (size_t i = N / TAU + 1; i < N; i++) {
        int32_t mask = -1;
        for (size_t j = 0; j < N / TAU + 1; j++) {
            minmaxmask(&sum[i], &bestm[j], &mask);
        }
    }
    // find minimum in bestm
    min = bestm[0];
    for (size_t i = 1; i < N / TAU + 1; i++) {
        int32_t tmp = bestm[i];
        minmax(&min, &tmp);
    }
    // multiply all but the minimum by N mod TAU
    for (size_t i = 0; i < N / TAU + 1; i++) {
        int32_t fac = ((min - bestm[i]) >> 31); // all-ones if bestm[i] != min (TODO: impl specific behaviour)
        fac =
            (fac & (TAU)) ^
            ((~fac) & (N % TAU)); // fac = TAU for all != min and N%TAU for min
        bestm[i] +=
            0x10200;     // add 1 for the "1 poly" in S, and prepare rounding
        bestm[i] >>= 10; // round off 10 bits
        bestm[i] *= fac;
        res += bestm[i];
    }

    return (res + (1 << 5)) >> 6; // return rounded, squared value
}
