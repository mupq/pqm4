

#include "macros.i"
#include "schoolbooks.i"

#ifndef LOOP
#define LOOP
#endif

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_base_mul_16
.type __asm_base_mul_16, %function
__asm_base_mul_16:
    push.w {r4-r12, lr}

    .equ width, 2

    mov.w r12, r3
    ldr.w r14, [sp, #40]

    vmov.w s1, r1

#ifdef LOOP
    add.w r11, r0, #256*width
    vmov.w s2, r11
    _mul_16:
#else
.rept 32
#endif

    vmov.w r1, s1
    ldrsh.w r3, [r1], #2
    vmov.w s1, r1

// r12 = zeta

    ldrstr2jump ldr.w, r12, r4, r5, #2*width, #4*width
    ldrstr2jump ldr.w, r14, r6, r7, #2*width, #4*width

// r4 = a1 | a0; r5 = a3 | a2
// r6 = b1 | b0; r7 = b3 | b2

    c1_4x4_16 r9, r4, r5, r6, r7, r3, r2, r1
    c3_4x4_16 r10, r4, r5, r6, r7, r3, r2, r1

// re-pack

    pkhbt r8, r4, r5, lsl #16
    pkhtb r5, r5, r4, asr #16
    pkhbt r4, r6, r7, lsl #16
    pkhtb r7, r7, r6, asr #16

// r8 = a2 | a0; r5 = a3 | a1
// r4 = b2 | b0; r7 = b3 | b1

    c2_4x4_16 r11, r8, r5, r4, r7, r3, r2, r1

    pkhtb r10, r10, r11, asr #16
    str.w r10, [r0, #2*width]

    c0_4x4_16 r10, r8, r5, r4, r7, r3, r2, r1

    pkhtb r9, r9, r10, asr #16
    str.w r9, [r0], #4*width

    neg.w r3, r3

// r12 = -zeta

    ldrstr2jump ldr.w, r12, r4, r5, #2*width, #4*width
    ldrstr2jump ldr.w, r14, r6, r7, #2*width, #4*width

// r4 = a1 | a0; r5 = a3 | a2
// r6 = b1 | b0; r7 = b3 | b2

    c1_4x4_16 r9, r4, r5, r6, r7, r3, r2, r1
    c3_4x4_16 r10, r4, r5, r6, r7, r3, r2, r1

// re-pack

    pkhbt r8, r4, r5, lsl #16
    pkhtb r5, r5, r4, asr #16
    pkhbt r4, r6, r7, lsl #16
    pkhtb r7, r7, r6, asr #16

// r8 = a2 | a0; r5 = a3 | a1
// r4 = b2 | b0; r7 = b3 | b1

    c2_4x4_16 r11, r8, r5, r4, r7, r3, r2, r1

    pkhtb r10, r10, r11, asr #16
    str.w r10, [r0, #2*width]

    c0_4x4_16 r10, r8, r5, r4, r7, r3, r2, r1

    pkhtb r9, r9, r10, asr #16
    str.w r9, [r0], #4*width

#ifdef LOOP
    vmov.w r11, s2
    cmp.w r0, r11
    bne.w _mul_16
#else
.endr
#endif

    pop.w {r4-r12, pc}

.align 2
.global __asm_base_mul_32x16
.type __asm_base_mul_32x16, %function
__asm_base_mul_32x16:
    push.w {r4-r12, lr}

    .equ ldrwidth, 4
    .equ strwidth, 2

    mov.w r12, r3
    ldr.w r14, [sp, #40]

    vmov.w s1, r1

#ifdef LOOP
    add.w r11, r0, #256*strwidth
    vmov.w s2, r11
    _mul_32x16:
#else
.rept 32
#endif

    vmov.w r1, s1
    ldrsh.w r3, [r1], #2
    vmov.w s1, r1

// r12 = zeta

    ldrstr4jump ldr.w, r12, r4, r8, r5, r9, #1*ldrwidth, #2*ldrwidth, #3*ldrwidth, #4*ldrwidth
    ldrstr2jump ldr.w, r14, r6, r7, #1*ldrwidth, #2*ldrwidth

    montgomery_16 r4, r2, r11
    montgomery_16 r8, r2, r11
    montgomery_16 r5, r2, r11
    montgomery_16 r9, r2, r11

    pkhtb r4, r8, r4, asr #16
    pkhtb r5, r9, r5, asr #16

// r4 = a1 | a0; r5 = a3 | a2
// r6 = b1 | b0; r7 = b3 | b2

    c1_4x4_16 r9, r4, r5, r6, r7, r3, r2, r1
    c3_4x4_16 r10, r4, r5, r6, r7, r3, r2, r1

// re-pack

    pkhbt r8, r4, r5, lsl #16
    pkhtb r5, r5, r4, asr #16
    pkhbt r4, r6, r7, lsl #16
    pkhtb r7, r7, r6, asr #16

// r8 = a2 | a0; r5 = a3 | a1
// r4 = b2 | b0; r7 = b3 | b1

    c2_4x4_16 r11, r8, r5, r4, r7, r3, r2, r1

    pkhtb r10, r10, r11, asr #16
    str.w r10, [r0, #2*strwidth]

    c0_4x4_16 r10, r8, r5, r4, r7, r3, r2, r1

    pkhtb r9, r9, r10, asr #16
    str.w r9, [r0], #4*strwidth

    neg.w r3, r3

// r12 = -zeta

    ldrstr4jump ldr.w, r12, r4, r8, r5, r9, #1*ldrwidth, #2*ldrwidth, #3*ldrwidth, #4*ldrwidth
    ldrstr2jump ldr.w, r14, r6, r7, #1*ldrwidth, #2*ldrwidth

    montgomery_16 r4, r2, r11
    montgomery_16 r8, r2, r11
    montgomery_16 r5, r2, r11
    montgomery_16 r9, r2, r11

    pkhtb r4, r8, r4, asr #16
    pkhtb r5, r9, r5, asr #16

// r4 = a1 | a0; r5 = a3 | a2
// r6 = b1 | b0; r7 = b3 | b2

    c1_4x4_16 r9, r4, r5, r6, r7, r3, r2, r1
    c3_4x4_16 r10, r4, r5, r6, r7, r3, r2, r1

// re-pack

    pkhbt r8, r4, r5, lsl #16
    pkhtb r5, r5, r4, asr #16
    pkhbt r4, r6, r7, lsl #16
    pkhtb r7, r7, r6, asr #16

// r8 = a2 | a0; r5 = a3 | a1
// r4 = b2 | b0; r7 = b3 | b1

    c2_4x4_16 r11, r8, r5, r4, r7, r3, r2, r1

    pkhtb r10, r10, r11, asr #16
    str.w r10, [r0, #2*strwidth]

    c0_4x4_16 r10, r8, r5, r4, r7, r3, r2, r1

    pkhtb r9, r9, r10, asr #16
    str.w r9, [r0], #4*strwidth

#ifdef LOOP
    vmov.w r11, s2
    cmp.w r0, r11
    bne.w _mul_32x16
#else
.endr
#endif

    pop.w {r4-r12, pc}

.global __asm_base_mul_32
.type __asm_base_mul_32, %function
__asm_base_mul_32:
    push.w {r4-r12, lr}

    vldr.w s12, [sp, #40]
    vldr.w s13, [sp, #44]

    .equ width, 4

    vmov.w s0, s1, r0, r1

#ifdef LOOP
    add.w r12, r0, #256*width
    vmov.w s2, r12
    _mul_32:
#else
.rept 32
#endif

    vmov.w r12, r14, s12, s13
    ldrstr4jump ldr.w, r12, r4, r5, r6, r7, #4, #8, #12, #16
    ldrstr4jump ldr.w, r14, r8, r9, r10, r11, #4, #8, #12, #16
    vmov.w s12, s13, r12, r14

    vmov.w r12, s1
    ldr.w r1, [r12], #4
    vmov.w s1, r12

    c3_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #12]

    c2_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #8]

    c1_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #4]

    c0_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0], #16
    vmov.w s0, r0

// ================================

    vmov.w r12, r14, s12, s13
    ldrstr4jump ldr.w, r12, r4, r5, r6, r7, #4, #8, #12, #16
    ldrstr4jump ldr.w, r14, r8, r9, r10, r11, #4, #8, #12, #16
    vmov.w s12, s13, r12, r14

    neg.w r1, r1

    c3_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #12]

    c2_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #8]

    c1_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #4]

    c0_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0], #16
    vmov.w s0, r0

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _mul_32
#else
.endr
#endif

    pop.w {r4-r12, pc}




















