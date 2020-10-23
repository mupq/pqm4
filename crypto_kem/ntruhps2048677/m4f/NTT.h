#ifndef NTT_H
#define NTT_H

#include <stdint.h>

#define N 512
#define RmodM -190483
#define invN -2714
#define MOD 1389569
#define Mprime -1383779329
#define RinvN 51194
#define R2invN 408540
#define pr 3


void Good_mul_768(uint16_t *res_coeffs, const uint16_t *small_coeffs, const uint16_t *big_coeffs);

#endif
