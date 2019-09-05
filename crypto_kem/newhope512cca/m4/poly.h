#ifndef POLY_H
#define POLY_H

#include <stdint.h>
#include "params.h"

/* 
 * Elements of R_q = Z_q[X]/(X^n + 1). Represents polynomial
 * coeffs[0] + X*coeffs[1] + X^2*xoeffs[2] + ... + X^{n-1}*coeffs[n-1] 
 */
typedef struct {
  int16_t coeffs[NEWHOPE_N];
} poly __attribute__ ((aligned (32)));

void poly_uniform(poly *a, const unsigned char *seed);
void poly_sample(poly *r, const unsigned char *seed, unsigned char nonce);
void poly_add(poly *r, const poly *a, const poly *b);


extern void asm_add512(int16_t *r, const int16_t* a, const int16_t* b);
extern void asm_sub512(int16_t *r, const int16_t* a, const int16_t* b);
extern void asm_pointwise512(int16_t *r, const int16_t* a, const int16_t* b);


void poly_ntt(poly *r);
void poly_invntt(poly *r);
void poly_mul_pointwise(poly *r, const poly *a, const poly *b);

void poly_frombytes(poly *r, const unsigned char *a);
void poly_tobytes(unsigned char *r, const poly *p);
void poly_compress(unsigned char *r, const poly *p);
void poly_decompress(poly *r, const unsigned char *a);

void poly_frommsg(poly *r, const unsigned char *msg);
void poly_tomsg(unsigned char *msg, const poly *x);
void poly_sub(poly *r, const poly *a, const poly *b);

#endif
