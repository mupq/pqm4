
#include "macros.i"
#include "butterflies.i"
#include "special_butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_Good_3x2
.type __asm_Good_3x2, %function
__asm_Good_3x2:
    push.w {r4-r12, lr}

    .equ ldrwidth, 2
    .equ strwidth, 4

    ldm.w r1, {r10-r11}

    ldr.w r14, [sp, #40]

#ifdef LOOP
    add.w r12, r0, #(9*63)*strwidth
    _Good_3x2:
#else
.rept 63
#endif

    ldrsh.w r5, [r14, #514*ldrwidth]
    ldrsh.w r6, [r14, #2*ldrwidth]
    ldrsh.w r7, [r14, #258*ldrwidth]
    sbfx.w r5, r5, #0, #13
    sbfx.w r6, r6, #0, #13
    sbfx.w r7, r7, #0, #13
    _6_ntt_011 r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #776*strwidth]
    str.w r8, [r0, #775*strwidth]
    str.w r7, [r0, #774*strwidth]
    str.w r6, [r0, #8*strwidth]
    str.w r5, [r0, #7*strwidth]
    str.w r4, [r0, #6*strwidth]

    ldrsh.w r4, [r14, #513*ldrwidth]
    ldrsh.w r5, [r14, #1*ldrwidth]
    ldrsh.w r9, [r14, #257*ldrwidth]
    sbfx.w r4, r4, #0, #13
    sbfx.w r5, r5, #0, #13
    sbfx.w r9, r9, #0, #13
    _6_ntt_110 r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #773*strwidth]
    str.w r8, [r0, #772*strwidth]
    str.w r7, [r0, #771*strwidth]
    str.w r6, [r0, #5*strwidth]
    str.w r5, [r0, #4*strwidth]
    str.w r4, [r0, #3*strwidth]

    ldrsh.w r6, [r14, #512*ldrwidth]
    ldrsh.w r8, [r14, #256*ldrwidth]
    ldrsh.w r4, [r14], #3*ldrwidth
    sbfx.w r4, r4, #0, #13
    sbfx.w r6, r6, #0, #13
    sbfx.w r8, r8, #0, #13
    _6_ntt_101 r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #770*strwidth]
    str.w r8, [r0, #769*strwidth]
    str.w r7, [r0, #768*strwidth]
    str.w r6, [r0, #2*strwidth]
    str.w r5, [r0, #1*strwidth]
    str.w r4, [r0], #9*strwidth

#ifdef LOOP
    cmp.w r0, r12
    bne.w _Good_3x2
#else
.endr
#endif

#ifdef LOOP
    add.w r12, r0, #(9*22)*strwidth
    _Good_3x2_zero:
#else
.rept 22
#endif

    ldrsh.w r6, [r14, #2*ldrwidth]
    ldrsh.w r7, [r14, #258*ldrwidth]
    movw.w r5, #0
    sbfx.w r6, r6, #0, #13
    sbfx.w r7, r7, #0, #13
    _6_ntt_011 r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #776*strwidth]
    str.w r8, [r0, #775*strwidth]
    str.w r7, [r0, #774*strwidth]
    str.w r6, [r0, #8*strwidth]
    str.w r5, [r0, #7*strwidth]
    str.w r4, [r0, #6*strwidth]

    ldrsh.w r5, [r14, #1*ldrwidth]
    ldrsh.w r9, [r14, #257*ldrwidth]
    movw.w r4, #0
    sbfx.w r5, r5, #0, #13
    sbfx.w r9, r9, #0, #13
    _6_ntt_110 r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #773*strwidth]
    str.w r8, [r0, #772*strwidth]
    str.w r7, [r0, #771*strwidth]
    str.w r6, [r0, #5*strwidth]
    str.w r5, [r0, #4*strwidth]
    str.w r4, [r0, #3*strwidth]

    ldrsh.w r8, [r14, #256*ldrwidth]
    ldrsh.w r4, [r14], #3*ldrwidth
    movw.w r6, #0
    sbfx.w r4, r4, #0, #13
    sbfx.w r8, r8, #0, #13
    _6_ntt_101 r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #770*strwidth]
    str.w r8, [r0, #769*strwidth]
    str.w r7, [r0, #768*strwidth]
    str.w r6, [r0, #2*strwidth]
    str.w r5, [r0, #1*strwidth]
    str.w r4, [r0], #9*strwidth

#ifdef LOOP
    cmp.w r0, r12
    bne.w _Good_3x2_zero
#else
.endr
#endif

    ldrsh.w r8, [r14, #256*ldrwidth]
    ldrsh.w r4, [r14], #3*ldrwidth
    movw.w r6, #0
    sbfx.w r4, r4, #0, #13
    sbfx.w r8, r8, #0, #13
    _6_ntt_101 r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #770*strwidth]
    str.w r8, [r0, #769*strwidth]
    str.w r7, [r0, #768*strwidth]
    str.w r6, [r0, #2*strwidth]
    str.w r5, [r0, #1*strwidth]
    str.w r4, [r0], #9*strwidth

    pop.w {r4-r12, pc}

.align 2
.global __asm_Good_3x2_small
.type __asm_Good_3x2_small, %function
__asm_Good_3x2_small:
    push.w {r4-r12, lr}

    .equ ldrwidth, 2
    .equ strwidth, 4

    ldm.w r1, {r10-r11}

    ldr.w r14, [sp, #40]

#ifdef LOOP
    add.w r12, r0, #(9*63)*strwidth
    _Good_3x2_small:
#else
.rept 63
#endif

    ldrsh.w r5, [r14, #514*ldrwidth]
    ldrsh.w r6, [r14, #2*ldrwidth]
    ldrsh.w r7, [r14, #258*ldrwidth]
    _6_ntt_011_small r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #776*strwidth]
    str.w r8, [r0, #775*strwidth]
    str.w r7, [r0, #774*strwidth]
    str.w r6, [r0, #8*strwidth]
    str.w r5, [r0, #7*strwidth]
    str.w r4, [r0, #6*strwidth]

    ldrsh.w r4, [r14, #513*ldrwidth]
    ldrsh.w r5, [r14, #1*ldrwidth]
    ldrsh.w r9, [r14, #257*ldrwidth]
    _6_ntt_110_small r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #773*strwidth]
    str.w r8, [r0, #772*strwidth]
    str.w r7, [r0, #771*strwidth]
    str.w r6, [r0, #5*strwidth]
    str.w r5, [r0, #4*strwidth]
    str.w r4, [r0, #3*strwidth]

    ldrsh.w r6, [r14, #512*ldrwidth]
    ldrsh.w r8, [r14, #256*ldrwidth]
    ldrsh.w r4, [r14], #3*ldrwidth
    _6_ntt_101_small r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #770*strwidth]
    str.w r8, [r0, #769*strwidth]
    str.w r7, [r0, #768*strwidth]
    str.w r6, [r0, #2*strwidth]
    str.w r5, [r0, #1*strwidth]
    str.w r4, [r0], #9*strwidth

#ifdef LOOP
    cmp.w r0, r12
    bne.w _Good_3x2_small
#else
.endr
#endif

#ifdef LOOP
    add.w r12, r0, #(9*22)*strwidth
    _Good_3x2_zero_small:
#else
.rept 22
#endif

    ldrsh.w r6, [r14, #2*ldrwidth]
    ldrsh.w r7, [r14, #258*ldrwidth]
    movw.w r5, #0
    _6_ntt_011_small r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #776*strwidth]
    str.w r8, [r0, #775*strwidth]
    str.w r7, [r0, #774*strwidth]
    str.w r6, [r0, #8*strwidth]
    str.w r5, [r0, #7*strwidth]
    str.w r4, [r0, #6*strwidth]

    ldrsh.w r5, [r14, #1*ldrwidth]
    ldrsh.w r9, [r14, #257*ldrwidth]
    movw.w r4, #0
    _6_ntt_110_small r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #773*strwidth]
    str.w r8, [r0, #772*strwidth]
    str.w r7, [r0, #771*strwidth]
    str.w r6, [r0, #5*strwidth]
    str.w r5, [r0, #4*strwidth]
    str.w r4, [r0, #3*strwidth]

    ldrsh.w r8, [r14, #256*ldrwidth]
    ldrsh.w r4, [r14], #3*ldrwidth
    movw.w r6, #0
    _6_ntt_101_small r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #770*strwidth]
    str.w r8, [r0, #769*strwidth]
    str.w r7, [r0, #768*strwidth]
    str.w r6, [r0, #2*strwidth]
    str.w r5, [r0, #1*strwidth]
    str.w r4, [r0], #9*strwidth

#ifdef LOOP
    cmp.w r0, r12
    bne.w _Good_3x2_zero_small
#else
.endr
#endif

    ldrsh.w r8, [r14, #256*ldrwidth]
    ldrsh.w r4, [r14], #3*ldrwidth
    movw.w r6, #0
    _6_ntt_101_small r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #770*strwidth]
    str.w r8, [r0, #769*strwidth]
    str.w r7, [r0, #768*strwidth]
    str.w r6, [r0, #2*strwidth]
    str.w r5, [r0, #1*strwidth]
    str.w r4, [r0], #9*strwidth

    pop.w {r4-r12, pc}













