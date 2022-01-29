#ifndef SMALLNTT_H
#define SMALLNTT_H

#include <stdint.h>
#include "params.h"


#define SMALL_Q 257
#define SMALL_Q_PRIME (16711935) // -q^-1 mod 2**32

static const int32_t twiddles_ntt_257_streamlined[]  = {-60, -35, -46, -42, 99, 89, -118, 27, -82, 108, -71, 54, 93, -41, 115, 68, 117, 73, -84, -59, -79, 21, -78, 37, -55, -109, 101, 74, -110, 39, 17, -70, -92, -50, -29, 57, -116, 83, 43, 75, -85, -91, 86, -107, 87, 15, -23, -111, -100, -58, 114, 25, -97, -10, 126, -40, 63, -20, -5, -80, -120, 44, -67, -72, -124, -31, 18, -106, 103, 90, -102, 45, -51, -77, 53, -121, -81, -11, 113, 9, -62, 36, -65, -12, -3, -48, 127, -24, -6, -96, 34, 88, 123, -49, -13, 61, -52, 112, -7, -66, -28, -33, -14, 125, -56, 30, 95, -22, -98, -26, 122, -104, -38, -94, 105, -119, -76, 69, -47, 19};
static const int32_t twiddles_intt_257_streamlined[] = { -19, 47, -69, 76, 119, -105, 94, 38, 104, -122, 26, 98, 22, -95, -30, 56, -125, 14, 33, 28, 66, 7, -112, 52, -61, 13, 49, -123, -88, -34, 96, 6, 24, -127, 48, 3, 12, 65, -36, 62, -9, -113, 11, 81, 121, -53, 77, 51, -45, 102, -90, -103, 106, -18, 31, 124, 72, 67, -44, 120, 80, 5, 20, -63, 40, -126, 10, 97, -25, -114, 58, 100, 111, 23, -15, -87, 107, -86, 91, 85, -75, -43, -83, 116, -57, 29, 50, 92, 70, -17, -39, 110, -74, -101, 109, 55, -37, 78, -21, 79, 59, 84, -73, -117, -68, -115, 41, -93, -54, 71, -108, 82, -27, 118, -89, -99, 42, 46, 35, 60};
static const int32_t twiddles_basemul_257[] = {27, -82, 108, -71, 54, 93, -41, 115, -78, 37, -55, -109, 101, 74, -110, 39, 83, 43, 75, -85, -91, 86, -107, 87, -97, -10, 126, -40, 63, -20, -5, -80, -106, 103, 90, -102, 45, -51, -77, 53, -65, -12, -3, -48, 127, -24, -6, -96, 112, -7, -66, -28, -33, -14, 125, -56, -38, -94, 105, -119, -76, 69, -47, 19};


// inputs in [-2, 2]; outputs in [-128, +128]
void __asm_fnt_257(int32_t *p, const int32_t twiddles[112], int32_t qprime, int32_t q);

void __asm_point_mul_257_16(int16_t p_prime[128], const int32_t p[256], int32_t qprime, int32_t q, const int32_t twiddles[64]);
void __asm_asymmetric_mul_257_16(int32_t c[256], const int32_t a[256], const int32_t b[256], const int16_t b_prime[128]);

// inputs in [-32768, 32768] outputs in [-128, +128]
void __asm_ifnt_257(int32_t *p, const int32_t twiddles[112], int32_t qprime, int32_t q);

#define small_ntt(a) __asm_fnt_257(a, twiddles_ntt_257_streamlined, SMALL_Q_PRIME, SMALL_Q)
#define small_invntt_tomont(a) __asm_ifnt_257(a, twiddles_intt_257_streamlined, SMALL_Q_PRIME, SMALL_Q)

#define small_point_mul(b_prime, b) __asm_point_mul_257_16(b_prime, b, SMALL_Q_PRIME, SMALL_Q, twiddles_basemul_257);
#define small_asymmetric_mul(c, a, b, b_prime) __asm_asymmetric_mul_257_16(c, a, b, b_prime);

#endif
