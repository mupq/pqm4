/// @file blas_matrix_ref.h
/// @brief linear algebra functions for matrix op.
///
#ifndef _BLAS_MATRIX_REF_H_
#define _BLAS_MATRIX_REF_H_

#include <stdint.h>



#ifdef  __cplusplus
extern  "C" {
#endif


///////////////// Section: multiplications  ////////////////////////////////

void gf16mat_prod_ref(uint8_t *c, const uint8_t *matA, unsigned n_A_vec_byte, unsigned n_A_width, const uint8_t *b);

void gf256mat_prod_ref(uint8_t *c, const uint8_t *matA, unsigned n_A_vec_byte, unsigned n_A_width, const uint8_t *b);



void gf16mat_rowmat_mul_ref(uint8_t *matC, const uint8_t *matA, unsigned height_A, unsigned width_A_byte, const uint8_t *matB, unsigned width_B_byte);

void gf256mat_rowmat_mul_ref(uint8_t *matC, const uint8_t *matA, unsigned height_A, unsigned width_A_byte, const uint8_t *matB, unsigned width_B_byte);


void gf16mat_colmat_mul_ref(uint8_t *mat_c, const uint8_t *mat_a, unsigned a_veclen_byte, unsigned a_n_vec, const uint8_t *mat_b, unsigned b_n_vec);

void gf256mat_colmat_mul_ref(uint8_t *mat_c, const uint8_t *mat_a, unsigned a_veclen_byte, unsigned a_n_vec, const uint8_t *mat_b, unsigned b_n_vec);


/////////////////////////////////////////////////////

unsigned gf16mat_inv_ref(uint8_t *inv_a, const uint8_t *a , unsigned len );

unsigned gf256mat_inv_ref(uint8_t *inv_a, const uint8_t *a , unsigned len );


/////////////////////////////////////////////////////

unsigned gf256mat_LDUinv_ref(uint8_t *mat_U_AinvB, uint8_t *mat_Ainv, uint8_t *mat_CAinvB_inv, uint8_t *mat_L_C, const uint8_t *matA , unsigned len);

void gf256mat_LDUinv_prod_ref(uint8_t *c, const uint8_t *mat_U_AinvB, const uint8_t *mat_Ainv, const uint8_t *mat_CAinvB_inv, const uint8_t *mat_L_C, const uint8_t * b , unsigned len);


unsigned gf16mat_LDUinv_ref(uint8_t *mat_U_AinvB, uint8_t *mat_Ainv, uint8_t *mat_CAinvB_inv, uint8_t *mat_L_C, const uint8_t *matA , unsigned mat_dim);

void gf16mat_LDUinv_prod_ref(uint8_t *c, const uint8_t *mat_U_AinvB, const uint8_t *mat_Ainv, const uint8_t *mat_CAinvB_inv, const uint8_t *mat_L_C, const uint8_t * b , unsigned veclen_byte );




void gf256mat_back_substitute_ref( uint8_t *constant, const uint8_t *sq_row_mat_a, unsigned len);

void gf16mat_back_substitute_ref( uint8_t *constant, const uint8_t *sq_row_mat_a, unsigned len);

#ifdef  __cplusplus
}
#endif

#endif  // _BLAS_MATRIX_REF_H_

