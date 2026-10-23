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
// clang-format off
#ifndef HAETAE_PARAMS_H
#define HAETAE_PARAMS_H

#include "config.h"

#define SEEDBYTES 32
#define CRHBYTES 64
#define N 256
#define ROOT_OF_UNITY 3

#define Q 64513
#define DQ (Q << 1)// 2Q

#if HAETAE_MODE == 2
#define K 2
#define L 4
#define TAU 58
#define B0 9846.02
#define B1 9838.98
#define B2 12777.52
#define GAMMA 48.858
#define LN 8192 // Large N
#define LNHALF 4096
#define LNBITS 13
#define SQNM 39.191835884530846 // \sqrt(n * m)
#define D 1
#define SIGBYTES 1474

#define BASE_ENC_HB_Z1 132
#define BASE_ENC_H 7

#define ALPHA_HINT 512
#define LOG_ALPHA_HINT 9

#define POLYB1_PACKEDBYTES 480     // 15bits * N / 8bits
#define POLYQ_PACKEDBYTES 480  // 15bits * N / 8bits

#elif HAETAE_MODE == 3
#define K 3
#define L 6
#define TAU 80
#define B0 18314.98
#define B1 18307.70
#define B2 21906.65
#define GAMMA 57.707
#define LN 8192 // Large N
#define LNHALF 4096
#define LNBITS 13
#define SQNM 48.0
#define D 1
#define SIGBYTES 2349

#define BASE_ENC_HB_Z1 376
#define BASE_ENC_H 127

#define ALPHA_HINT 512
#define LOG_ALPHA_HINT 9

#define POLYB1_PACKEDBYTES 480     // 15bits * N / 8bits
#define POLYQ_PACKEDBYTES 480  // 15bits * N / 8bits

#elif HAETAE_MODE == 5
#define K 4
#define L 7
#define TAU 128
#define B0 22343.66
#define B1 22334.95
#define B2 24441.49
#define GAMMA 55.13
#define LN 8192 // Large N
#define LNHALF 4096
#define LNBITS 13
#define SQNM 53.0659966456864
#define D 0
#define SIGBYTES 2948

#define BASE_ENC_HB_Z1 501
#define BASE_ENC_H 358

#define ALPHA_HINT 256
#define LOG_ALPHA_HINT 8

#define POLYB1_PACKEDBYTES 512     // 16bits * N / 8bits
#define POLYQ_PACKEDBYTES 512  // 16bits * N / 8bits

#endif // HAETAE_MODE

#define HALF_ALPHA_HINT (ALPHA_HINT >> 1) // ALPHA / 2

#define B0SQ ((uint64_t)(B0*B0))
#define B1SQ ((uint64_t)(B1*B1))
#define B2SQ ((uint64_t)(B2*B2))

#define M (L-1)

#define ETA 1
#define POLYETA_PACKEDBYTES 64
#if D == 1
#define POLY2ETA_PACKEDBYTES 96
#elif D == 0
#define POLY2ETA_PACKEDBYTES 64
#endif

#define POLYC_PACKEDBYTES 32       // 1bit * N / 8bits
#define POLY_HIGHBITS_PACKEDBYTES (N * 9 / 8)
#define POLYVECK_HIGHBITS_PACKEDBYTES (POLY_HIGHBITS_PACKEDBYTES * K)
#define POLYVECK_BYTES (K * N * sizeof(int32_t))
#define POLYVECL_BYTES (L * N * sizeof(int32_t))

#define PUBLICKEYBYTES (SEEDBYTES + K * POLYQ_PACKEDBYTES) // seed + b
#define SECRETKEYBYTES                                                         \
    (PUBLICKEYBYTES + M * POLYETA_PACKEDBYTES + K * POLY2ETA_PACKEDBYTES +      \
     SEEDBYTES) // pk + s1 + s2 + key

/* The sizes exported by api.h must match the parameter set. */
#include "api.h"
#if (CRYPTO_PUBLICKEYBYTES != PUBLICKEYBYTES) ||                              \
    (CRYPTO_SECRETKEYBYTES != SECRETKEYBYTES) || (CRYPTO_BYTES != SIGBYTES)
#error "api.h sizes do not match params.h"
#endif

#endif
// clang-format on
