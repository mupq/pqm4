
#include "macros.i"
#include "schoolbooks.i"

.syntax unified
.cpu cortex-m4

.global __asm_base_mul
.type __asm_base_mul, %function
__asm_base_mul:
    push.w {r4-r12, lr}

    vldr.w s12, [sp, #40]
    vldr.w s13, [sp, #44]

    .equ width, 4

    vmov.w s0, s1, r0, r1

#ifdef LOOP
    add.w r12, r0, #1536*width
    vmov.w s2, r12
    _mul:
#else
.rept 64
#endif

// ================

    vmov.w r12, s1
    ldr.w r1, [r12], #4
    vmov.w s1, r12

// ================

    add.w r14, r0, #24*width
    vmov.w s3, r14
    _parity:

    .equ offset, 2

    vmov.w r12, r14, s12, s13
    ldrstr4 ldr.w, r12, r4, r5, r6, r7, #(0+offset)*width, #(3+offset)*width, #(6+offset)*width, #(9+offset)*width
    ldrstr4 ldr.w, r14, r8, r9, r10, r11, #(0+offset)*width, #(3+offset)*width, #(6+offset)*width, #(9+offset)*width
    c3_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #(9+offset)*width]
    c2_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #(6+offset)*width]
    c1_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #(3+offset)*width]
    c0_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #(0+offset)*width]

    .equ offset, 1

    vmov.w r12, r14, s12, s13
    ldrstr4 ldr.w, r12, r4, r5, r6, r7, #(0+offset)*width, #(3+offset)*width, #(6+offset)*width, #(9+offset)*width
    ldrstr4 ldr.w, r14, r8, r9, r10, r11, #(0+offset)*width, #(3+offset)*width, #(6+offset)*width, #(9+offset)*width
    c3_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #(9+offset)*width]
    c2_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #(6+offset)*width]
    c1_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #(3+offset)*width]
    c0_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #(0+offset)*width]

    vmov.w r12, r14, s12, s13
    ldrstr4jump ldr.w, r12, r4, r5, r6, r7, #3*width, #6*width, #9*width, #12*width
    ldrstr4jump ldr.w, r14, r8, r9, r10, r11, #3*width, #6*width, #9*width, #12*width
    vmov.w s12, s13, r12, r14
    c3_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #9*width]
    c2_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #6*width]
    c1_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0, #3*width]
    c0_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12
    vmov.w r0, s0
    str.w r14, [r0], #12*width
    vmov.w s0, r0

    neg.w r1, r1

    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _parity

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _mul
#else
.endr
#endif

    pop.w {r4-r12, pc}









