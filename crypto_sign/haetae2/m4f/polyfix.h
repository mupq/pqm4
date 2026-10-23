// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#ifndef HAETAE_POLYFIX_H
#define HAETAE_POLYFIX_H

#include "params.h"
#include "poly.h"
#include "polyvec.h"

#include <stdint.h>

typedef struct {
  int32_t coeffs[HAETAE_N];
} polyfix;

#define polyfix_norm2 HAETAE_NAMESPACE(polyfix_norm2)
double polyfix_norm2(const polyfix *a);

#define polyfix_round HAETAE_NAMESPACE(polyfix_round)
void polyfix_round(poly *a, const polyfix *b);

#define polyfix_add HAETAE_NAMESPACE(polyfix_add)
void polyfix_add(polyfix *c, const polyfix *a, const poly *b);

typedef struct {
  polyfix vec[HAETAE_K];
} polyfixveck;

#define polyfixveck_round HAETAE_NAMESPACE(polyfixveck_round)
void polyfixveck_round(polyveck *a, const polyfixveck *b);

typedef struct {
  polyfix vec[HAETAE_L];
} polyfixvecl;

#define polyfixvecl_round HAETAE_NAMESPACE(polyfixvecl_round)
void polyfixvecl_round(polyvecl *a, const polyfixvecl *b);

#define polyfixveclk_sqnorm2 HAETAE_NAMESPACE(polyfixveclk_sqnorm2)
uint64_t polyfixveclk_sqnorm2(const polyfixvecl *a, const polyfixveck *b);

#define polyfixveclk_sqnorm2_2z_minus_y                                        \
  HAETAE_NAMESPACE(polyfixveclk_sqnorm2_2z_minus_y)
uint64_t polyfixveclk_sqnorm2_2z_minus_y(const polyfixvecl *z1,
                                         const polyfixvecl *y1,
                                         const polyfixveck *z2,
                                         const polyfixveck *y2);

#define HAETAE_HYPERBALL_SAMPLES (HAETAE_N * (HAETAE_L + HAETAE_K))
#define polyfixveclk_sample_hyperball                                          \
  HAETAE_NAMESPACE(polyfixveclk_sample_hyperball)
uint16_t
polyfixveclk_sample_hyperball(polyfixvecl *y1, polyfixveck *y2, uint8_t *b,
                              const uint8_t seed[HAETAE_CRHBYTES],
                              const uint16_t nonce,
                              uint64_t samples[HAETAE_HYPERBALL_SAMPLES]);

#endif /* !HAETAE_POLYFIX_H */
