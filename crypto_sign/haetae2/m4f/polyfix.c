#include "polyfix.h"
#include "decompose.h"
#include "math.h"
#include "params.h"
#include "reduce.h"
#include "symmetric.h"
#include "fp84_76.h"
#include "sampler.h"
#include <stdint.h>

const fp112_76 B0_squared_112 = B0SQ_FP112_76;

/*************************************************
 * Name:        polyfix_add
 *
 * Description: Add double polynomial and integer polynomial.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyfix *c: pointer to output double polynomial
 *              - const polyfix *a: pointer to first summand
 *              - const poly *b: pointer to second summand
 **************************************************/
void polyfix_add(polyfix *c, const polyfix *a, const poly *b) {
    unsigned int i;

    for (i = 0; i < N; ++i)
        c->coeffs[i] = a->coeffs[i] + LN * b->coeffs[i];
}

/*************************************************
 * Name:        polyfix_sub
 *
 * Description: Subtract fixed polynomial and fixed polynomial.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyfix *c: pointer to output fixed polynomial
 *              - const polyfix *a: pointer to first summand
 *              - const polyfix *b: pointer to second summand
 **************************************************/
void polyfix_sub(polyfix *c, const polyfix *a, const polyfix *b) {
    unsigned int i;

    for (i = 0; i < N; ++i)
        c->coeffs[i] = a->coeffs[i] - b->coeffs[i];
}

int32_t fix_round(int32_t num) {
    num += (num >> 31) & (-LN + 1);
    num +=
        LN /
        2; // total \floor(LN / 2) if positive, -\floor(LN / 2) + 1 if negative
    return num / LN;
}

/*************************************************
 * Name:        polyfix_round
 *
 * Description: rounds a fixed polynomial to integer polynomial
 *
 * Arguments:   - poly *a: output integer polynomial
 *              - poly *b: input fixed polynomial
 **************************************************/
void polyfix_round(poly *a, const polyfix *b) {
    unsigned i;

    for (i = 0; i < N; ++i)
        a->coeffs[i] = fix_round(b->coeffs[i]);
}

/**************************************************************/
/********* Double Vectors of polynomials of length K **********/
/**************************************************************/

/*************************************************
 * Name:        polyfixveck_add
 *
 * Description: Add vector to a vector of double polynomials of length K.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyveck *w: pointer to output vector
 *              - const polyveck *u: pointer to first summand
 *              - const polyveck *v: pointer to second summand
 **************************************************/
void polyfixveck_add(polyfixveck *w, const polyfixveck *u, const polyveck *v) {
    unsigned int i;

    for (i = 0; i < K; ++i)
        polyfix_add(&w->vec[i], &u->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyfixfixveck_sub
 *
 * Description: subtract vector to a vector of fixed polynomials of length k.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyveck *w: pointer to output vector
 *              - const polyfixveck *u: pointer to first summand
 *              - const polyfixveck *v: pointer to second summand
 **************************************************/
void polyfixfixveck_sub(polyfixveck *w, const polyfixveck *u,
                        const polyfixveck *v) {
    unsigned int i;

    for (i = 0; i < K; ++i)
        polyfix_sub(&w->vec[i], &u->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyfixveck_double
 *
 * Description: Double vector of polynomials of length K.
 *
 * Arguments:   - polyveck *b: pointer to output vector
 *              - polyveck *a: pointer to input vector
 **************************************************/
void polyfixveck_double(polyfixveck *b, const polyfixveck *a) {
    unsigned int i, j;

    for (i = 0; i < K; ++i)
        for (j = 0; j < N; ++j)
            b->vec[i].coeffs[j] = 2 * a->vec[i].coeffs[j];
}

/*************************************************
 * Name:        polyfixveck_round
 *
 * Description: rounds a fixed polynomial vector of length K
 *
 * Arguments:   - polyveck *a: output integer polynomial vector
 *              - polyfixveck *b: input fixed polynomial vector
 **************************************************/
void polyfixveck_round(polyveck *a, const polyfixveck *b) {
    unsigned i;

    for (i = 0; i < K; ++i)
        polyfix_round(&a->vec[i], &b->vec[i]);
}

/**************************************************************/
/********* Double Vectors of polynomials of length L **********/
/**************************************************************/

/*************************************************
 * Name:        polyfixvecl_add
 *
 * Description: Add vector to a vector of double polynomials of length L.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyvecl *w: pointer to output vector
 *              - const polyfixvecl *u: pointer to first summand
 *              - const polyvecl *v: pointer to second summand
 **************************************************/
void polyfixvecl_add(polyfixvecl *w, const polyfixvecl *u, const polyvecl *v) {
    unsigned int i;

    for (i = 0; i < L; ++i)
        polyfix_add(&w->vec[i], &u->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyfixfixvecl_sub
 *
 * Description: subtract vector to a vector of fixed polynomials of length l.
 *              No modular reduction is performed.
 *
 * Arguments:   - polyvecl *w: pointer to output vector
 *              - const polyfixvecl *u: pointer to first summand
 *              - const polyfixvecl *v: pointer to second summand
 **************************************************/
void polyfixfixvecl_sub(polyfixvecl *w, const polyfixvecl *u,
                        const polyfixvecl *v) {
    unsigned int i;

    for (i = 0; i < L; ++i)
        polyfix_sub(&w->vec[i], &u->vec[i], &v->vec[i]);
}

/*************************************************
 * Name:        polyfix_double
 *
 * Description: Double contents of polynomial.
 *
 * Arguments:   - polyveck *b: pointer to output polynomial
 *              - polyveck *a: pointer to input polynomial
 **************************************************/
void polyfix_double(polyfix *b, const polyfix *a) {
    unsigned int j;

    for (j = 0; j < N; ++j)
        b->coeffs[j] = 2 * a->coeffs[j];
}

/*************************************************
 * Name:        polyfixvecl_double
 *
 * Description: Double vector of polynomials of length L.
 *
 * Arguments:   - polyveck *b: pointer to output vector
 *              - polyveck *a: pointer to input vector
 **************************************************/
void polyfixvecl_double(polyfixvecl *b, const polyfixvecl *a) {
    unsigned int i;

    for (i = 0; i < L; ++i)
        polyfix_double(&b->vec[i], &a->vec[i]);
}

/*************************************************
 * Name:        polyfixvecl_round
 *
 * Description: rounds a fixed polynomial vector of length L
 *
 * Arguments:   - polyvecl *a: output integer polynomial vector
 *              - polyfixvecl *b: input fixed polynomial vector
 **************************************************/
void polyfixvecl_round(polyvecl *a, const polyfixvecl *b) {
    unsigned i;

    for (i = 0; i < L; ++i)
        polyfix_round(&a->vec[i], &b->vec[i]);
}


/*************************************************
 * Name:        polyfix_norm2
 *
 * Description: Calculates L2 norm of a fixed point polynomial 
 *
 * Arguments:   - polyfix *a: polynomial to calculate norm
 **************************************************/
uint64_t polyfix_sqnorm2(const polyfix *a) {
    unsigned int j;
    uint64_t ret = 0;

    for (j = 0; j < N; ++j)
        ret += (int64_t)a->coeffs[j] * a->coeffs[j];

    return ret;
}

/*************************************************
 * Name:        polyfixveclk_norm2
 *
 * Description: Calculates L2 norm of a fixed point polynomial vector with
 *length L + K The result is L2 norm * LN similar to the way polynomial is
 *usually stored
 *
 * Arguments:   - polyfixvecl *a: polynomial vector with length L to calculate
 *                norm
 *              - polyfixveck *a: polynomial vector with length K to calculate
 *                norm
 **************************************************/
uint64_t polyfixveclk_sqnorm2(const polyfixvecl *a, const polyfixveck *b) {
    unsigned int i;
    uint64_t ret = 0;

    for (i = 0; i < L; ++i) {
        ret += polyfix_sqnorm2(&a->vec[i]);
    }

    for (i = 0; i < K; ++i) {
        ret += polyfix_sqnorm2(&b->vec[i]);
    }

    return ret;
}

uint16_t polyfixveclk_sample_hyperball(polyfixvecl *y1, polyfixveck *y2, uint8_t *b,
                                       const uint8_t seed[CRHBYTES],
                                       const uint16_t nonce) {
    uint16_t ni = nonce;
    uint64_t samples[N * (L + K)];
    fp112_76 sqsum112 = {{0}};
    fp96_76 sqsum, invsqrt;
    uint64_t sqnorm2;
    unsigned int i, j;
    uint8_t signs[N * (L + K) / 8];

    do {
        set_to_zero_112(&sqsum112);
        sample_gauss_N(&samples[0], &signs[0], &sqsum112, seed, ni++, N + 1);
        sample_gauss_N(&samples[N], &signs[N / 8], &sqsum112, seed, ni++, N + 1);

        for (i = 2; i < L + K; i++)
            sample_gauss_N(&samples[N * i], &signs[N / 8 * i], &sqsum112, seed,
                           ni++, N);

        convert_fp112_76_to_fp96_76(&sqsum, &sqsum112);

        // divide sqsum by 2 and approximate inverse square root
        sqsum.limb48[0] += 1; // rounding
        sqsum.limb48[0] >>= 1;
        sqsum.limb48[0] += (sqsum.limb48[1] & 1) << 47;
        sqsum.limb48[1] >>= 1;
        sqsum.limb48[1] += sqsum.limb48[0] >> 48;
        sqsum.limb48[0] &= (1ULL << 48) - 1;
        fixpoint_newton_invsqrt(&invsqrt, &sqsum);
        fixpoint_mul_high(&sqsum, &invsqrt,
                          (uint64_t)(B0 * LN + SQNM / 2) << (28 - 13));

        for (i = 0; i < L; i++) {
            for (j = 0; j < N; j++)
                y1->vec[i].coeffs[j] = fixpoint_mul_rnd13(
                    samples[(i * N + j)], &sqsum,
                    (signs[(i * N + j) / 8] >> ((i * N + j) % 8)) & 1);
        }
        for (i = L; i < K + L; i++) {
            for (j = 0; j < N; j++)
                y2->vec[i - L].coeffs[j] = fixpoint_mul_rnd13(
                    samples[(i * N + j)], &sqsum,
                    (signs[(i * N + j) / 8] >> ((i * N + j) % 8)) & 1);
        }
        sqnorm2 = polyfixveclk_sqnorm2(y1, y2);
    } while (sqnorm2 > B0SQ * LN * LN);

    {
        uint8_t tmp[CRHBYTES + 2];
        for (i = 0; i < CRHBYTES; i++)
        {
            tmp[i] = seed[i];
        }
        tmp[CRHBYTES + 0] = ni >> 0;
        tmp[CRHBYTES + 1] = ni >> 8;
        shake256(b, 1, tmp, CRHBYTES+2);
    }

    return ni;
}

uint16_t polyfixveclk_two_pass_sample_hyperball(polyfixvecl *y1, polyfixveck *y2,
                                       uint8_t *b, 
                                       const uint8_t seed[CRHBYTES],
                                       const uint16_t nonce) {
    uint16_t ni = nonce;
    uint16_t ni_at_start_of_pass_1;

    uint64_t samples[N + 1];
    fp112_76 sqsum112 = {{0}};
    fp96_76 sqsum, invsqrt;
    fp112_76 sqsum_2nd_pass__throw_away = {{0}};

    unsigned int i, j;
    uint8_t signs[N / 8];

    do {
        /* ------------- PASS ONE: compute sqsum and invsqrt ----------- */
        ni_at_start_of_pass_1 = ni;

        sample_gauss_N(&samples[0], &signs[0], &sqsum112, seed, ni++, N + 1);
        sample_gauss_N(&samples[0], &signs[0], &sqsum112, seed, ni++, N + 1);

        for (i = 2; i < L + K; i++)
            sample_gauss_N(&samples[0], &signs[0], &sqsum112, seed, ni++, N);

        convert_fp112_76_to_fp96_76(&sqsum, &sqsum112);

        // divide sqsum by 2 and approximate inverse square root
        sqsum.limb48[0] += 1; // rounding
        sqsum.limb48[0] >>= 1;
        sqsum.limb48[0] += (sqsum.limb48[1] & 1) << 47;
        sqsum.limb48[1] >>= 1;
        sqsum.limb48[1] += sqsum.limb48[0] >> 48;
        sqsum.limb48[0] &= (1ULL << 48) - 1;
        fixpoint_newton_invsqrt(&invsqrt, &sqsum);
        fixpoint_mul_high(&sqsum, &invsqrt,
                          (uint64_t)(B0 * LN + SQNM / 2) << (28 - 13));

        /* ------------- PASS TWO: sample y1 and y2 ----------------- */
        ni = ni_at_start_of_pass_1;
        for (i = 0; i < 2; i++) {
            sample_gauss_N(&samples[0], &signs[0], &sqsum_2nd_pass__throw_away, seed, ni++, N + 1);
            for (j = 0; j < N; j++)
                y1->vec[i].coeffs[j] = fixpoint_mul_rnd13(
                    samples[j], &sqsum,
                    (signs[j / 8] >> (j % 8)) & 1);
        }
        for (i = 2; i < L; i++) {
            sample_gauss_N(&samples[0], &signs[0], &sqsum_2nd_pass__throw_away, seed, ni++, N);
            for (j = 0; j < N; j++)
                y1->vec[i].coeffs[j] = fixpoint_mul_rnd13(
                    samples[j], &sqsum,
                    (signs[j / 8] >> (j % 8)) & 1);
        }
        for (i = L; i < K + L; i++) {
            sample_gauss_N(&samples[0], &signs[0], &sqsum_2nd_pass__throw_away, seed, ni++, N);
            for (j = 0; j < N; j++)
                y2->vec[i - L].coeffs[j] = fixpoint_mul_rnd13(
                    samples[j], &sqsum,
                    (signs[j / 8] >> (j % 8)) & 1);
        }
    } while (polyfixveclk_sqnorm2(y1, y2) > B0SQ * LN * LN);

    {
        uint8_t tmp[CRHBYTES + 2];
        for (i = 0; i < CRHBYTES; i++)
        {
            tmp[i] = seed[i];
        }
        tmp[CRHBYTES + 0] = ni >> 0;
        tmp[CRHBYTES + 1] = ni >> 8;
        shake256(b, 1, tmp, CRHBYTES+2);
    }

    return ni;
}
