#ifndef NTT_H
#define NTT_H

#include <stdint.h>

#define N 512
#define RmodM 1808149
#define invRmodM -1064648
#define invN -11225
#define RinvN 2641407
#define R2invN 1209020
#define MOD 5747201
#define pr 7
#define Mprime -795627009

void Good_mul_768(uint16_t *res_coeffs, const uint16_t *small_coeffs, const uint16_t *big_coeffs);

#endif