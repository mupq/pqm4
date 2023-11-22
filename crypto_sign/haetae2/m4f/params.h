// clang-format off
#ifndef HAETAE_PARAMS_H
#define HAETAE_PARAMS_H

#include "config.h"

/***************************************************************
 * Settings for Stack Management, use STACK_STRATEGY 
 * in config.h to select these.
 *  ENABLE_TWO_PASS_SAMPLING:
 *     - Default: not defined
 *     - relates to polyfixveclk_sample_hyperball()
 *     - Discards and recomputes some intermediate results
 *     - use about (L + K - 1) * 2kB less stack memory
 *     - roughly double the execution time
 *  ENABLE_SIGNATURE_MATRIX_BUFFER:
 *     - Default: defined
 *     - Enables the use of large matrices in 
 *       crypto_sign() to store the public key matrix
 *     - Uses about L * K * 2kB stack memory 
 *     - disabling increases runtime, as the matrix needs
 *       to be recomputed for each rejection cycle
 *  ENABLE_KEYPAIR_MATRIX_BUFFER:
 *     - Default: defined
 *     - Enables the use of large matrices in 
 *       crypto_keypair() to store the public key matrix
 *     - Uses about L * K * 2kB stack memory 
 *     - disabling increases runtime, as the matrix needs
 *       to be recomputed for each rejection cycle
 * Execute "make clean" to ensure the switches take effect.
 ***************************************************************/
#ifndef STACK_STRATEGY
#define ENABLE_SIGNATURE_MATRIX_BUFFER
#define ENABLE_KEYPAIR_MATRIX_BUFFER
#else
#if STACK_STRATEGY == 0
#define ENABLE_SIGNATURE_MATRIX_BUFFER
#define ENABLE_KEYPAIR_MATRIX_BUFFER
#elif STACK_STRATEGY == 1
#elif STACK_STRATEGY == 2
#define ENABLE_TWO_PASS_SAMPLING
#else 
#error Unknown STACK_STRATEGY specified
#endif /* if STACK_STRATEGY == 0 */
#endif /* ifndef STACK_STRATEGY */



#define SEEDBYTES 32
#define CRHBYTES 64
#define N 256
#define ROOT_OF_UNITY 3

#define Q 64513
#define DQ (Q << 1)// 2Q

#if HAETAE_MODE == 2
#define K 2
#define L 4
#define ETA 1
#define TAU 58
#define B0 9846.02
#define B0SQ_FP112_76 {.digit = {0x04D6A161, 0x04538EF3, 0x0EE57247, 0x05C73F}}  // == round(9846.02**2 * 2^76)
#define B1 9838.99
#define B2 12777.52
#define GAMMA 48.858
#define LN 8192 // Large N
#define SQNM 39.191835884530846 // \sqrt(n * m)
#define D 1
#define CRYPTO_BYTES 1474

#define BASE_ENC_HB_Z1 132
#define BASE_ENC_H 7

#define ALPHA_HINT 512
#define LOG_ALPHA_HINT 9

#define POLYB1_PACKEDBYTES 480     // 15bits * N / 8bits
#define POLYQ_PACKEDBYTES 480  // 16bits * N / 8bits

#elif HAETAE_MODE == 3
#define K 3
#define L 6
#define ETA 1
#define TAU 80
#define B0 18314.98
#define B0SQ_FP112_76 {.digit = {0x0A9930BE, 0x0D495182, 0x09CE6809, 0x013FE62}}  // == round(18314.98**2 * 2^76)
#define B1 18307.70
#define B2 21906.65
#define GAMMA 57.707
#define LN 8192 // Large N
#define SQNM 48.0
#define D 1
#define CRYPTO_BYTES 2349

#define BASE_ENC_HB_Z1 376
#define BASE_ENC_H 127

#define ALPHA_HINT 512
#define LOG_ALPHA_HINT 9

#define POLYB1_PACKEDBYTES 480     // 15bits * N / 8bits
#define POLYQ_PACKEDBYTES 480  // 16bits * N / 8bits

#elif HAETAE_MODE == 5
#define K 4
#define L 7
#define ETA 1
#define TAU 128
#define B0 22343.66
#define B0SQ_FP112_76 {.digit = {0x0504816F, 0x077318FC, 0x0E6B212D, 0x01DC1C8}}  // == round(22343.66**2 * 2^76)
#define B1 22334.95
#define B2 24441.49
#define GAMMA 55.13
#define LN 8192 // Large N
#define SQNM 53.0659966456864
#define D 0
#define CRYPTO_BYTES 2948

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

#if ETA == 1
#define POLYETA_PACKEDBYTES 64
#define POLY2ETA_PACKEDBYTES 96
#elif ETA == 2
#define POLYETA_PACKEDBYTES 96
#endif

#define POLYC_PACKEDBYTES 32       // 1bit * N / 8bits
#define POLY_HIGHBITS_PACKEDBYTES (N * 9 / 8)
#define POLYVECK_HIGHBITS_PACKEDBYTES (POLY_HIGHBITS_PACKEDBYTES * K)
#define POLYVECK_BYTES (K * N * sizeof(int32_t))
#define POLYVECL_BYTES (L * N * sizeof(int32_t))

#define CRYPTO_PUBLICKEYBYTES (SEEDBYTES + K * POLYQ_PACKEDBYTES)                                      // seed + b
#if D == 1
#define CRYPTO_SECRETKEYBYTES (CRYPTO_PUBLICKEYBYTES + M * POLYETA_PACKEDBYTES + K * POLY2ETA_PACKEDBYTES + SEEDBYTES)  // pk + s + K
#elif D == 0
#define CRYPTO_SECRETKEYBYTES (CRYPTO_PUBLICKEYBYTES + (M + K) * POLYETA_PACKEDBYTES + SEEDBYTES)  // pk + s + K
#else
#error
#endif
#endif
// clang-format on
