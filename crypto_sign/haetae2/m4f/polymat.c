// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#include "polymat.h"
#include "params.h"
#include "poly.h"
#include "polyvec.h"

#include <stdint.h>

/*************************************************
 * Name:        polymatkl_expand_matA
 *
 * Description: Implementation of ExpandA. Generates matrix A with uniformly
 *              random coefficients a_{i,j} by performing rejection
 *              sampling on the output stream of SHAKE128(rho|j|i).
 *
 * Arguments:   - polyvecl mat[HAETAE_K]: output matrix k \times l; the
 *              k \times m matrix is written to columns 1 to m, column 0 is
 *              not changed
 *              - const uint8_t rho[]: byte array containing seed rho
 *
 * Specification: Implements @[Algorithm 6, ExpandMatA]
 **************************************************/
void polymatkl_expand_matA(polyvecl mat[HAETAE_K],
                           const uint8_t rho[HAETAE_SEEDBYTES]) {
  unsigned int i, j;

  for (i = 0; i < HAETAE_K; ++i)
    for (j = 0; j < HAETAE_M; ++j)
      poly_uniform(&mat[i].vec[j + 1], rho, (i << 8) + j);
}

/*************************************************
 * Name:        polymatkm_expand_matA
 *
 * Description: Implementation of ExpandA. Generates matrix A with uniformly
 *              random coefficients a_{i,j} by performing rejection
 *              sampling on the output stream of SHAKE128(rho|j|i).
 *
 * Arguments:   - polyvecm mat[HAETAE_K]: output matrix k \times m
 *              - const uint8_t rho[]: byte array containing seed rho
 *
 * Specification: Implements @[Algorithm 6, ExpandMatA]
 **************************************************/
void polymatkm_expand_matA(polyvecm mat[HAETAE_K],
                           const uint8_t rho[HAETAE_SEEDBYTES]) {
  unsigned int i, j;

  for (i = 0; i < HAETAE_K; ++i)
    for (j = 0; j < HAETAE_M; ++j)
      poly_uniform(&mat[i].vec[j], rho, (i << 8) + j);
}

// doubles k * m sub-matrix of k * l mat
void polymatkl_double(polyvecl mat[HAETAE_K]) {
  unsigned int i, j, k;
  for (i = 0; i < HAETAE_K; ++i) {
    for (j = 1; j < HAETAE_L; ++j) {
      for (k = 0; k < HAETAE_N; ++k) {
        mat[i].vec[j].coeffs[k] *= 2;
      }
    }
  }
}

void polymatkl_pointwise_montgomery(polyveck *t, const polyvecl mat[HAETAE_K],
                                    const polyvecl *v) {
  unsigned int i;

  for (i = 0; i < HAETAE_K; ++i) {
    polyvecl_pointwise_acc_montgomery(&t->vec[i], &mat[i], v);
  }
}

void polymatkm_pointwise_montgomery(polyveck *t, const polyvecm mat[HAETAE_K],
                                    const polyvecm *v) {
  unsigned int i;

  for (i = 0; i < HAETAE_K; ++i) {
    polyvecm_pointwise_acc_montgomery(&t->vec[i], &mat[i], v);
  }
}
