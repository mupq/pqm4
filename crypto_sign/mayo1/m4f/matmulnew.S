.syntax unified
.cpu cortex-m4
.thumb

#include "matmulnew.i"
#include "asm_params.h"

//void mul_add_mat_x_m_mat_m4f_K_V_O_triangular_asm(uint32_t *c, uint8_t *a, uint32_t *b);
.global mul_add_mat_x_m_mat_m4f_K_V_O_triangular_asm
.type mul_add_mat_x_m_mat_m4f_K_V_O_triangular_asm, %function
.align 2
mul_add_mat_x_m_mat_m4f_K_V_O_triangular_asm:
    mul_add_mat_x_m_mat_m4f K, V, O, M

//void mul_add_mat_x_m_mat_m4f_K_V_K_triangular_asm(uint32_t *c, uint8_t *a, uint32_t *b);
.global mul_add_mat_x_m_mat_m4f_K_V_K_triangular_asm
.type mul_add_mat_x_m_mat_m4f_K_V_K_triangular_asm, %function
.align 2
mul_add_mat_x_m_mat_m4f_K_V_K_triangular_asm:
    mul_add_mat_x_m_mat_m4f K, V, K, M

//void mul_add_mat_trans_x_m_mat_m4f_V_O_O_asm(uint64_t *acc, const unsigned char *mat, const uint64_t *bs_mat);
.global mul_add_mat_trans_x_m_mat_m4f_V_O_O_asm
.type mul_add_mat_trans_x_m_mat_m4f_V_O_O_asm, %function
.align 2
mul_add_mat_trans_x_m_mat_m4f_V_O_O_asm:
    mul_add_mat_trans_x_m_mat_m4f V, O, O, M