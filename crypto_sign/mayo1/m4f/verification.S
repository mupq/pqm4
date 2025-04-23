.syntax unified
.cpu cortex-m4
.thumb

#include "verification.i"
#include "asm_params.h"

.global calculate_PS_m4f_stack_asm
.type calculate_PS_m4f_stack_asm, %function
.align 2
calculate_PS_m4f_stack_asm:
    macro_calculate_PS_m4f_stack_asm ((M + 15)/16), N, K

.global multiply_bins_stack_asm
.type multiply_bins_stack_asm, %function
.align 2
multiply_bins_stack_asm:
    macro_multiply_bins_stack_asm M, K

.global calculate_SPS_m4f_asm
.type calculate_SPS_m4f_asm, %function
.align 2
calculate_SPS_m4f_asm:
    macro_calculate_SPS_m4f_asm ((M + 15)/16), N, K


.global multiply_bins_asm
.type multiply_bins_asm, %function
.align 2
multiply_bins_asm:
    macro_multiply_bins_asm M




