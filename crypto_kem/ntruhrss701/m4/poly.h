#ifndef POLY_H
#define POLY_H

#include <stdint.h>
#include "params.h"

typedef struct{
  uint16_t coeffs[NTRU_N];
} poly;

void poly_Rq_tobytes(unsigned char *r, const poly *a);
void poly_Rq_frombytes(poly *r, const unsigned char *a);
void poly_Rq_frommsg(poly *r, const unsigned char *a);

void poly_S3_tobytes(unsigned char msg[NTRU_OWCPA_MSGBYTES], const poly *r);
void poly_S3_tomsg(unsigned char msg[NTRU_OWCPA_MSGBYTES], const poly *r);
void poly_S3_frombytes(poly *r, const unsigned char msg[NTRU_OWCPA_MSGBYTES]);

void poly_S3_sample(poly *r, const unsigned char *seed, const unsigned char nonce);
void poly_S3_sample_plus(poly *r, const unsigned char *seed, const unsigned char nonce);
void poly_Rq_getnoise(poly *r,const unsigned char *seed, const unsigned char nonce);

void poly_Rq_mul(poly *r, const poly *a, const poly *b);
void poly_Rq_mul_xm1(poly *r, const poly *a);
void poly_S3_mul(poly *r, const poly *a, const poly *b);
void poly_S3_to_Rq(poly *r, const poly *a);
void poly_Rq_to_S3(poly *r, const poly *a);

void poly_Rq_inv(poly *r, const poly *a);
void poly_S3_inv(poly *r, const poly *a);

#endif
