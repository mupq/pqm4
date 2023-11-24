#ifndef M4F_ASM_H
#define M4F_ASM_H

#include <stdint.h>



void mul_add_mat_x_bitsliced_m_mat_m4f_K_V_O_triangular_asm(uint32_t *acc, const unsigned char *mat, const uint32_t *bs_mat);
void mul_add_mat_x_bitsliced_m_mat_m4f_K_V_K_triangular_asm(uint32_t *acc, const unsigned char *mat, const uint32_t *bs_mat);
void mul_add_bitsliced_m_upper_triangular_mat_x_mat_trans_m4f_V_V_K_triangular_asm(uint32_t *acc, const uint32_t *bs_mat, const unsigned char *mat);
void mul_add_bitsliced_m_upper_triangular_mat_x_mat_m4f_V_V_O_triangular_asm(uint32_t *acc, const uint32_t *bs_mat, const unsigned char *mat);

void bitsliced_m_calculate_SPS_m4f_asm(uint32_t *, const uint32_t *, const unsigned char *);
void bitsliced_multiply_bins_asm(uint32_t *, uint32_t *, const int);

#if N_MAX <= 78
void bitsliced_m_calculate_PS_m4f_asm(uint32_t *, const uint32_t *, const unsigned char *, const int);
#else
void bitsliced_m_calculate_PS_m4f_stack_asm(uint32_t *, const uint32_t *, const unsigned char *, const int);
void bitsliced_multiply_bins_stack_asm(uint32_t *, uint32_t *, const int);
#endif


int sample_solution_m4f(const mayo_params_t *p, unsigned char *A,
                           const unsigned char *y, const unsigned char *r,
                           unsigned char *x);

void mayo_expand_sk_computeL_inner1_m4f(uint32_t *p2, const uint32_t *p1, const uint8_t *O, const uint8_t *O_max);
void mayo_expand_sk_computeL_inner2_m4f(uint32_t *p2, const uint32_t *p1, const uint8_t *O, size_t c);

#endif