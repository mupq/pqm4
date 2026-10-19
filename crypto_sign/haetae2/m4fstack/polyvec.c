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
#include <stdint.h>

#include "decompose.h"
#include "fft.h"
#include "params.h"
#include "poly.h"
#include "polyvec.h"

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
/*
 * sum[j] is the sum of the squared FFT magnitudes |s_i(zeta_j)|^2 over the
 * M + K secret polynomials (fixed point), accumulated in int32_t exactly as
 * in the reference implementation.  As there, it can overflow for extreme
 * secrets (two all-one polynomials already give 3481412146 > INT32_MAX); for
 * KeyGen secrets the largest value observed over 3000 keys per parameter set
 * (about 30000 checks, rejected candidates included) was below INT32_MAX/4.7.
 */
int64_t polyvecmk_sqsing_value_min(int32_t *sum, poly *scratch)
{
    int32_t res = 0;
    int32_t *bestm = scratch->coeffs;
    int32_t min = 0;

    // compute max m
    for (size_t i = 0; i < N / TAU + 1; ++i)
    {
        bestm[i] = sum[i];
    }
    for (size_t i = N / TAU + 1; i < N; i++)
    {
        for (size_t j = 0; j < N / TAU + 1; j++)
        {
            minmax(&sum[i], &bestm[j]);
        }
    }
    // find minimum in bestm
    min = bestm[0];
    for (size_t i = 1; i < N / TAU + 1; i++)
    {
        int32_t tmp = bestm[i];
        minmax(&min, &tmp);
    }
    // multiply the entries above the minimum by TAU and the minimum by
    // N mod TAU (as in the reference, every entry equal to the minimum gets
    // N mod TAU on a tie)
    for (size_t i = 0; i < N / TAU + 1; i++)
    {
        int32_t fac = ((min - bestm[i]) >> 31); // all-ones if bestm[i] != min
        fac = (fac & (TAU)) ^ ((~fac) & (N % TAU));
        bestm[i] += 0x10200; // add 1 for the "1 poly" in S, and prepare rounding
        bestm[i] >>= 10;     // round off 10 bits
        bestm[i] *= fac;
        res += bestm[i];
    }

    return (res + (1 << 5)) >> 6; // return rounded, squared value
}
