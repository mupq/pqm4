
#include "macros.i"

#ifndef LOOP
#define LOOP
#endif

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_solv_CRT_32_m4
.type __asm_solv_CRT_32_m4, %function
__asm_solv_CRT_32_m4:
    push.w {r4-r12, lr}

    .equ ldrwidth, 2
    .equ strwidth, 4
    .equ logq, 13

    ldm.w r3, {r4-r6}

    lsr.w r3, r4, #1 // r3 = Q1Q2half
    mov.w r12, r5
    mov.w r14, r6

    // r3 = Q1Q2half, r4 = Q1Q2, r12 = Q1Q1invRmod, r14 = Q2Q2prime

#ifdef LOOP
    add.w r11, r0, #256*strwidth
    vmov.w s2, r11
    _CRT:
#else
.rept 16
#endif

.rept 8

    ldr.w r8, [r1], #2*ldrwidth
    ldr.w r9, [r2], #2*ldrwidth

    ssub16.w r7, r9, r8
    asr.w r9, r8, #16
    sxth.w r8, r8
    doublemontgomery_16 b, r7, r12, r14, r10, r11
    smlabt r5, r7, r12, r8
    smlatt r6, r7, r12, r9

    str.w r6, [r0, #4]
    str.w r5, [r0], #2*strwidth

.endr

#ifdef LOOP
    vmov.w r11, s2
    cmp.w r0, r11
    bne.w _CRT
#else
.endr
#endif

    pop.w {r4-r12, pc}