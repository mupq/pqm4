#ifndef _BLAS_MATRIX_M4F_H_
#define _BLAS_MATRIX_M4F_H_

#include <stdint.h>
#include "ov_keypair.h"



#ifdef  __cplusplus
extern  "C" {
#endif

void gf16mat_prod_m4f(uint8_t *c, const uint8_t *matA, unsigned n_A_vec_byte, unsigned n_A_width, const uint8_t *b);
unsigned gf16mat_LDUinv_m4f(uint8_t *mat_U_AinvB, uint8_t *mat_Ainv, uint8_t *mat_CAinvB_inv, uint8_t *mat_L_C, const uint8_t *matA , unsigned len);
unsigned gf16mat_inv_m4f(uint8_t * inv_a , const uint8_t * a , unsigned H );
void batch_quad_trimat_eval_gf16_m4f(unsigned char * y, const unsigned char * trimat, const unsigned char * x, unsigned dim , unsigned size_batch);

void gf256mat_prod_m4f(uint8_t *c, const uint8_t *matA, unsigned n_A_vec_byte, unsigned n_A_width, const uint8_t *b);
unsigned gf256mat_LDUinv_m4f(uint8_t *mat_U_AinvB, uint8_t *mat_Ainv, uint8_t *mat_CAinvB_inv, uint8_t *mat_L_C, const uint8_t *matA , unsigned len);
unsigned gf256mat_inv_m4f(uint8_t * inv_a , const uint8_t * a , unsigned H );
void batch_quad_trimat_eval_gf256_m4f(unsigned char * y, const unsigned char * trimat, const unsigned char * x, unsigned dim , unsigned size_batch);

void ov_pkc_calculate_F_from_Q_m4f( sk_t * Fs);


unsigned gf256mat_gaussian_elim_m4f(uint8_t *sq_col_mat_a , uint8_t *constant, unsigned len);
unsigned gf16mat_gaussian_elim_m4f(uint8_t *sq_col_mat_a , uint8_t *constant, unsigned len);



#ifdef  __cplusplus
}
#endif


#endif