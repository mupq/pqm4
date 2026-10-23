/*
 * Copyright 2026 YoungBeom Kim, Christine van Vredendaal, Gustavo Banegas, and Seog Chung Seo
 *
 * Derived from the HAETAE reference implementation, Copyright (c) 2026
 * Team HAETAE, MIT License (see LICENSE).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#ifndef FFT__H
#define FFT__H

#include "poly.h"
#include <stdint.h>

#define FFT_N 256
#define FFT_LOGN 8

typedef struct {
    int32_t real;
    int32_t imag;
} complex_fp32_16;

#define fft HAETAE_NAMESPACE(fft)
void fft(complex_fp32_16 data[FFT_N]);
#define fft_init_and_bitrev_inplace HAETAE_NAMESPACE(fft_init_and_bitrev_inplace)
void fft_init_and_bitrev_inplace(complex_fp32_16 r[FFT_N]);
#define complex_fp_sqabs HAETAE_NAMESPACE(complex_fp_sqabs)
int32_t complex_fp_sqabs(complex_fp32_16 x);

#endif
