#ifndef POLY_H
#define POLY_H

#include <stdint.h>

#include "params.h"

#define MODQ(X) ((X) & (NTRU_Q-1))
uint16_t mod3(uint16_t a);

typedef struct {
    uint16_t coeffs[NTRU_N];
} poly;


void poly_Sq_tobytes(unsigned char *r, const poly *a);
void poly_Sq_frombytes(poly *r, const unsigned char *a);

void poly_Rq_sum_zero_tobytes(unsigned char *r, const poly *a);
void poly_Rq_sum_zero_frombytes(poly *r, const unsigned char *a);

void poly_S3_tobytes(unsigned char msg[NTRU_PACK_TRINARY_BYTES], const poly *a);
void poly_S3_frombytes(poly *r, const unsigned char msg[NTRU_PACK_TRINARY_BYTES]);

void poly_Sq_mul(poly *r, const poly *a, const poly *b);
void poly_SignedZ3_Sq_mul(poly *r, const poly *a, const poly *b);
void poly_Rq_mul(poly *r, const poly *a, const poly *b);
void poly_SignedZ3_Rq_mul(poly *r, const poly *a, const poly *b);
void poly_Rq_mul_x_minus_1(poly *r, const poly *a);
void poly_S3_mul(poly *r, const poly *a, const poly *b);
void poly_lift(poly *r, const poly *a);
void poly_Rq_to_S3(poly *r, const poly *a);

void poly_Rq_inv(poly *r, const poly *a);
void poly_S3_inv(poly *r, const poly *a);

void poly_Z3_to_Zq(poly *r);
void poly_Z3_to_SignedZ3(poly *r);
void poly_trinary_Zq_to_Z3(poly *r);

#endif
