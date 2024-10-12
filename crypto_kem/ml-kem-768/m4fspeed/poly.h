#ifndef POLY_H
#define POLY_H

#include "params.h"

#include <stdint.h>

#define poly_getnoise(p, seed, nonce) poly_noise(p, seed, nonce, 0)
#define poly_addnoise(p, seed, nonce) poly_noise(p, seed, nonce, 1)

/*
 * Elements of R_q = Z_q[X]/(X^n + 1). Represents polynomial
 * coeffs[0] + X*coeffs[1] + X^2*xoeffs[2] + ... + X^{n-1}*coeffs[n-1]
 */
typedef struct {
    int16_t coeffs[KYBER_N];
} poly;

void poly_compress(unsigned char *r, const poly *a);
void poly_decompress(poly *r, const unsigned char *a);

void poly_packcompress(unsigned char *r, poly *a, int i);
void poly_unpackdecompress(poly *r, const unsigned char *a, int i);

int cmp_poly_compress(const unsigned char *r, poly *a);
int cmp_poly_packcompress(const unsigned char *r, poly *a, int i);

void poly_tobytes(unsigned char *r, poly *a);
void poly_frombytes(poly *r, const unsigned char *a);
void poly_frombytes_mul_16_32(int32_t *r_tmp, const poly *b, const unsigned char *a);
void poly_frombytes_mul_32_32(int32_t *r_tmp, const poly *b, const unsigned char *a);
void poly_frombytes_mul_32_16(poly *r, const poly* b, const unsigned char *a, const int32_t *r_tmp);

void poly_frommsg(poly *r, const unsigned char msg[KYBER_SYMBYTES]);
void poly_tomsg(unsigned char msg[KYBER_SYMBYTES], poly *a);

void poly_noise(poly *r, const unsigned char *seed, unsigned char nonce, int add);

void poly_ntt(poly *r);
void poly_invntt(poly *r);
void poly_basemul_opt_16_32(int32_t *r, const poly *a, const poly *b, const poly *a_prime);
void poly_basemul_acc_opt_32_32(int32_t *r_tmp, const poly *a, const poly *b, const poly *a_prime);
void poly_basemul_acc_opt_32_16(poly *r, const poly *a, const poly *b, const poly *a_prime, const int32_t * r_tmp);
void poly_fromplant(poly *r);

void poly_reduce(poly *r);

void poly_add(poly *r, const poly *a, const poly *b);
void poly_sub(poly *r, const poly *a, const poly *b);

void poly_zeroize(poly *p);

#endif