#ifndef NTT_H
#define NTT_H

#include "inttypes.h"

extern int16_t omegas_inv_bitrev_montgomery[];
extern int16_t gammas_bitrev_montgomery[];
extern int16_t gammas_inv_montgomery[];


extern void asm_ntt1024(int16_t*, const int16_t*);
extern void asm_mul_coeff1024(int16_t*, const int16_t*);



void bitrev_vector(int16_t* poly);
void mul_coefficients(int16_t* poly, const int16_t* factors);
void ntt(int16_t* poly, const int16_t* omegas);
void c_ntt(int16_t* poly, const int16_t* omegas);
#endif
