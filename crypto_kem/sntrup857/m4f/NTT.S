
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_ntt_3_4_5
.type __asm_ntt_3_4_5, %function
__asm_ntt_3_4_5:
    push {r4-r12, lr}

    add.w r1, r1, #28
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #108
    vmov.w s2, r12
    _3_4_5_light_inner:
#else
.rept 9
#endif

.rept 3

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #108, #324, #540, #756
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0, #216, #432, #648
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #108, #216, #324, #432, #540, #648, #756, #4

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5_light_inner
#else
.endr
#endif

    add.w r0, r0, #756

#ifdef LOOP
    add.w r12, r0, #6048
    vmov.w s2, r12
    _3_4_5:
#else
.rept 7
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #108
    vmov.w s3, r14
    _3_4_5_inner:
#else
.rept 9
#endif

.rept 3

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0, #108, #216, #324, #432, #540, #648, #756
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #108, #216, #324, #432, #540, #648, #756, #4

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _3_4_5_inner
#else
.endr
#endif

    add.w r0, r0, #756

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5
#else
.endr
#endif

    pop {r4-r12, pc}






































