
#ifndef NTT_H
#define NTT_H

#include <stdint.h>

#define RmodM 501252
#define inv64 -52587
#define Rinv64 -202516
#define inv9 -373952
#define inv576 -5843
#define MOD 3365569
#define Mprime 1205062335
#define Rinv576 -770406
#define R2inv576 1204317

void mixed_radix_NTT_mul_864(uint16_t *res_coeffs, const uint16_t *small_coeffs, const uint16_t *big_coeffs);

#endif
