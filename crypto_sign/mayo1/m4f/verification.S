.syntax unified
.cpu cortex-m4
.thumb

#include "verification.i"
#include "asm_params.h"


// For MAYO3 and MAYO5 we need to compute PS incrementally
#if N <= 78
.global bitsliced_m_calculate_PS_m4f_asm
.type bitsliced_m_calculate_PS_m4f_asm, %function
.align 2
bitsliced_m_calculate_PS_m4f_asm:
    macro_bitsliced_m_calculate_PS_m4f_asm (M/32), N, K
#else
.global bitsliced_m_calculate_PS_m4f_stack_asm
.type bitsliced_m_calculate_PS_m4f_stack_asm, %function
.align 2
bitsliced_m_calculate_PS_m4f_stack_asm:
    macro_bitsliced_m_calculate_PS_m4f_stack_asm (M/32), N, K

.global bitsliced_multiply_bins_stack_asm
.type bitsliced_multiply_bins_stack_asm, %function
.align 2
bitsliced_multiply_bins_stack_asm:
    macro_bitsliced_multiply_bins_stack_asm (M/32), N, K
#endif

.global bitsliced_m_calculate_SPS_m4f_asm
.type bitsliced_m_calculate_SPS_m4f_asm, %function
.align 2
bitsliced_m_calculate_SPS_m4f_asm:
    macro_bitsliced_m_calculate_SPS_m4f_asm (M/32), N, K

.global bitsliced_multiply_bins_asm
.type bitsliced_multiply_bins_asm, %function
.align 2
bitsliced_multiply_bins_asm:
    macro_bitsliced_multiply_bins_asm (M/32), N, K


