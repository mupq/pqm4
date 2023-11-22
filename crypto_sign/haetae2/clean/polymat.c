#include "polymat.h"
#include "params.h"
#include "poly.h"
#include "polyvec.h"
#include <stdint.h>

/*************************************************
 * Name:        polymat_expand
 *
 * Description: Implementation of ExpandA. Generates matrix A with uniformly
 *              random coefficients a_{i,j} by performing rejection
 *              sampling on the output stream of SHAKE128(rho|j|i)
 *              or AES256CTR(rho,j|i).
 *
 * Arguments:   - polyvecm mat[K]: output matrix k \times m
 *              - const uint8_t rho[]: byte array containing seed rho
 **************************************************/
void polymatkl_expand(polyvecl mat[K], const uint8_t rho[SEEDBYTES]) {
    unsigned int i, j;

    for (i = 0; i < K; ++i)
        for (j = 0; j < M; ++j)
            poly_uniform(&mat[i].vec[j + 1], rho, (i << 8) + j);
}

/*************************************************
 * Name:        polymat_expand
 *
 * Description: Implementation of ExpandA. Generates matrix A with uniformly
 *              random coefficients a_{i,j} by performing rejection
 *              sampling on the output stream of SHAKE128(rho|j|i)
 *              or AES256CTR(rho,j|i).
 *
 * Arguments:   - polyvecm mat[K]: output matrix k \times m
 *              - const uint8_t rho[]: byte array containing seed rho
 **************************************************/
void polymatkm_expand(polyvecm mat[K], const uint8_t rho[SEEDBYTES]) {
    unsigned int i, j;

    for (i = 0; i < K; ++i)
        for (j = 0; j < M; ++j)
            poly_uniform(&mat[i].vec[j], rho, (i << 8) + j);
}

// doubles k * m sub-matrix of k * l mat
void polymatkl_double(polyvecl mat[K]) {
    unsigned int i, j, k;
    for (i = 0; i < K; ++i) {
        for (j = 1; j < L; ++j) {
            for (k = 0; k < N; ++k) {
                mat[i].vec[j].coeffs[k] *= 2;
            }
        }
    }
}

void polymatkl_pointwise_montgomery(polyveck *t, const polyvecl mat[K],
                                    const polyvecl *v) {
    unsigned int i;

    for (i = 0; i < K; ++i) {
        polyvecl_pointwise_acc_montgomery(&t->vec[i], &mat[i], v);
    }
}

void polymatkm_pointwise_montgomery(polyveck *t, const polyvecm mat[K],
                                    const polyvecm *v) {
    unsigned int i;

    for (i = 0; i < K; ++i) {
        polyvecm_pointwise_acc_montgomery(&t->vec[i], &mat[i], v);
    }
}
