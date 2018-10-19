#ifndef POLY_H
#define POLY_H

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "params.h"

typedef double __attribute__ ((aligned (32))) poly_f[KINDI_KEM_N];
typedef int64_t __attribute__ ((aligned (32))) poly_d[KINDI_KEM_N];

#include "gen_randomness.h"

void poly_init(poly_d r);

void poly_type_convert_fd(poly_d d, poly_f f);
void poly_type_convert_df(poly_f f, poly_d d);

void poly_copy_d(poly_d r, poly_d p);

void poly_setrandom_rsec(poly_d *r,poly_d *e, uint8_t *gamma);
void poly_gen_matrix(poly_d A[KINDI_KEM_L][KINDI_KEM_L], uint8_t* seed);

void poly_sub_constant(poly_d r, const poly_d f, const int64_t c);
void poly_add_nored(poly_d r, const poly_d f, const poly_d g);
void poly_sub_nored(poly_d r, const poly_d f, const poly_d g);

void poly_mul(poly_d r,  poly_d x,  poly_d y);
void psi_loop_and_fft(poly_d p, poly_f real, poly_f img);
void poly_mul_precomp_fft(poly_d r,  poly_d x, const poly_f a_real,
		const poly_f a_img);
void poly_mul_pointwise(poly_d r, poly_f a_re, poly_f a_im, poly_f b_re, poly_f b_im);

void poly_coeffreduce(poly_d r);
void poly_coeffreduce_center(poly_d r);
#define poly_coeffreduce_pos poly_coeffreduce
void poly_print_d(const char *c, const poly_d f);
void poly_print_f(const char *c, const poly_f f);
int poly_equal(const poly_d f, const poly_d g);

void poly_compress(poly_d p, const int t);
void poly_decompress(poly_d p, const int t);


void poly_tobytes_bitlen(unsigned char* b, const poly_d p, const int bitlen);
void poly_frombytes_bitlen(poly_d p, const unsigned char* b, const int bitlen);
void poly_neg_tobytes_bitlen(unsigned char* b, const poly_d p, const int bitlen);
void poly_neg_frombytes_bitlen(poly_d p, const unsigned char* b, const int bitlen);

#endif
