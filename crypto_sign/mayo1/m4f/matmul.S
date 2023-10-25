.syntax unified
.cpu cortex-m4
.thumb

#include "matmul.i"
#include "asm_params.h"


//void mul_add_bitsliced_m_upper_triangular_mat_x_mat_m4f_V_V_O_triangular_asm(uint32_t *c, uint32_t *a, uint8_t *b);
.global mul_add_bitsliced_m_upper_triangular_mat_x_mat_m4f_V_V_O_triangular_asm
.type mul_add_bitsliced_m_upper_triangular_mat_x_mat_m4f_V_V_O_triangular_asm, %function
.align 2
mul_add_bitsliced_m_upper_triangular_mat_x_mat_m4f_V_V_O_triangular_asm:
    mul_add_bitsliced_m_upper_triangular_mat_x_mat_m4f V, 0, 1, O, M

//void mul_add_bitsliced_m_upper_triangular_mat_x_mat_trans_m4f_V_V_K_triangular_asm(uint32_t *c, uint32_t *a, uint8_t *b);
.global mul_add_bitsliced_m_upper_triangular_mat_x_mat_trans_m4f_V_V_K_triangular_asm
.type mul_add_bitsliced_m_upper_triangular_mat_x_mat_trans_m4f_V_V_K_triangular_asm, %function
.align 2
mul_add_bitsliced_m_upper_triangular_mat_x_mat_trans_m4f_V_V_K_triangular_asm:
    mul_add_bitsliced_m_upper_triangular_mat_x_mat_m4f V, 1, 1, K, M


//void mul_add_mat_x_bitsliced_m_mat_m4f_K_V_O_triangular_asm(uint32_t *c, uint8_t *a, uint32_t *b);
.global mul_add_mat_x_bitsliced_m_mat_m4f_K_V_O_triangular_asm
.type mul_add_mat_x_bitsliced_m_mat_m4f_K_V_O_triangular_asm, %function
.align 2
mul_add_mat_x_bitsliced_m_mat_m4f_K_V_O_triangular_asm:
    mul_add_mat_x_bitsliced_m_mat_m4f K, V, O, M

//void mul_add_mat_x_bitsliced_m_mat_m4f_K_V_K_triangular_asm(uint32_t *c, uint8_t *a, uint32_t *b);
.global mul_add_mat_x_bitsliced_m_mat_m4f_K_V_K_triangular_asm
.type mul_add_mat_x_bitsliced_m_mat_m4f_K_V_K_triangular_asm, %function
.align 2
mul_add_mat_x_bitsliced_m_mat_m4f_K_V_K_triangular_asm:
    mul_add_mat_x_bitsliced_m_mat_m4f K, V, K, M

.global mayo_expand_sk_computeL_inner1_m4f
.type mayo_expand_sk_computeL_inner1_m4f, %function
.align 2
mayo_expand_sk_computeL_inner1_m4f:
    mayo_expand_sk_computeL_inner1_m4f M, O

.global mayo_expand_sk_computeL_inner2_m4f
.type mayo_expand_sk_computeL_inner2_m4f, %function
.align 2
mayo_expand_sk_computeL_inner2_m4f:
    mayo_expand_sk_computeL_inner2_m4f M, O, V
