#ifndef REF_POLY_H
#define REF_POLY_H

#include "structs.h"

void ref_poly_add(poly *res, const poly *a, const poly *b);
void ref_poly_sub(poly *res, const poly *a, const poly *b);
void ref_poly_mul_mod(poly *res, const poly *a, const poly *b);

void ref_poly_quantize(poly *res, const poly *v, const poly *d, int32_t P);
void ref_poly_dequantize(poly *res, const poly *b, int32_t P);

void ref_poly_vec_transpose_mul(poly *res, const poly_vec *a_t, const poly_vec *b);
void ref_poly_matrix_vec_mul(poly_vec *res, const poly_matrix *A, const poly_vec *s);

void ref_poly_msg_encode(poly *res, const uint8_t *msg);
void ref_poly_msg_decode(uint8_t *msg, const poly *p);


// Removed to prevent linker conflict with main if not used, 
// or implement it if needed. For now, main uses memcmp/binary check.
// int ref_check_poly_eq(const poly *a, const poly *b); 

// 打包解包需要的ref_poly_tobytes与ref_poly_frombytes
void ref_poly_tobytes(uint8_t *r, const poly *a);
void ref_poly_frombytes(poly *r, const uint8_t *a);

void ref_poly_compress_u(uint8_t *r, const poly *a);
void ref_poly_decompress_u(poly *r, const uint8_t *a);

void ref_poly_compress_v(uint8_t *r, const poly *a);
void ref_poly_decompress_v(poly *r, const uint8_t *a);

void ref_poly_getnoise_eta1(poly *r, const uint8_t *seed, uint8_t nonce);
#endif