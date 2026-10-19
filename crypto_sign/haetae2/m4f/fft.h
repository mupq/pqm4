// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#ifndef HAETAE_FFT_H
#define HAETAE_FFT_H

#include "params.h"
#include "poly.h"

#include <stdint.h>

#define FFT_N 256

typedef struct {
  int32_t real;
  int32_t imag;
} complex_fp32_16;

/* fft.S; identical to the reference for inputs from fft_init_and_bitrev() of
 * polynomials with coefficients in [-3, 3] (KeyGen: [-2, 2]) */
#define fft HAETAE_NAMESPACE(fft)
void fft(complex_fp32_16 data[FFT_N]);
#define fft_init_and_bitrev HAETAE_NAMESPACE(fft_init_and_bitrev)
void fft_init_and_bitrev(complex_fp32_16 r[FFT_N], const poly *x);
/* |x|^2 with the rounded fixed-point products of the reference; computed in
 * 64 bits (the reference truncates the two terms and their sum to int32_t,
 * which gives the same value whenever they fit) */
static inline int64_t complex_fp_sqabs(complex_fp32_16 x) {
  return ((((int64_t)x.real * x.real) + (1 << 15)) >> 16) +
         ((((int64_t)x.imag * x.imag) + (1 << 15)) >> 16);
}

#endif /* !HAETAE_FFT_H */
