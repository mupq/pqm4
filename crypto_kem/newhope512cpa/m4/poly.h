#ifndef POLY_H
#define POLY_H

#include <stdint.h>
#include "params.h"

#define poly_getnoise(p, seed, nonce) poly_sample(p, seed, nonce, 0)
#define poly_addnoise(p, seed, nonce) poly_sample(p, seed, nonce, 1)


/*
 * Elements of R_q = Z_q[X]/(X^n + 1). Represents polynomial
 * coeffs[0] + X*coeffs[1] + X^2*xoeffs[2] + ... + X^{n-1}*coeffs[n-1]
 */
typedef struct {
  int16_t coeffs[NEWHOPE_N];
} poly;

void poly_uniform_mul_s(poly *a, const unsigned char *seed);
void poly_sample(poly *r, const unsigned char *seed, unsigned char nonce, int add);
void poly_add(poly *r, const poly *a);

void poly_ntt(poly *r);
void poly_invntt(poly *r);
void poly_mul_pointwise(poly *r, const poly *a);
void poly_reduce(poly *r);
void poly_bitrev(poly *r);

void poly_frombytes(poly *r, const unsigned char *a);
void poly_frombytes_mul(poly *r, const unsigned char *a, const unsigned char *b);
void poly_tobytes(unsigned char *r, const poly *p);
int poly_tobytes_cmp(const unsigned char *r, const poly *a);
void poly_compress(unsigned char *r, const poly *p);
int poly_compress_cmp(const unsigned char *r, const poly *a);
void poly_decompress_sub(poly *r, const unsigned char *a);

void poly_frommsg(poly *r, const unsigned char *msg);
void poly_tomsg(unsigned char *msg, const poly *x);

#endif
