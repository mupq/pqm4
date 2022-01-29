
#include "macros.i"
#include "schoolbooks.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_base_mul
.type __asm_base_mul, %function
__asm_base_mul:
    push.w {r4-r12, lr}

    vldr.w s0, [sp, #40]
    ldr.w r11, [sp, #44]

    .equ width, 4

    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #1728*width
    vmov.w s2, r12
    _mul:
#else
.rept 32
#endif

#ifdef LOOP
    add.w r14, r0, #27*width
    vmov.w s3, r14
    _mul_inner:
#else
.rept 3
#endif

.rept 3

    vmov.w r12, s1
    ldr.w r1, [r12], #4
    vmov.w s1, r12

    vmov.w r10, s0
    ldr.w r4, [r10, #27*width]
    ldr.w r5, [r10, #28*width]
    ldr.w r6, [r10, #29*width]
    ldr.w r7, [r11, #27*width]
    ldr.w r8, [r11, #28*width]
    ldr.w r9, [r11, #29*width]

    c1_3x3_32 r10, r4, r5, r6, r7, r8, r9, r1, r2, r3, r12, r14
    str.w r10, [r0, #28*width]

    c2_3x3_32 r10, r4, r5, r6, r7, r8, r9, r1, r2, r3, r12, r14
    str.w r10, [r0, #29*width]

    c0_3x3_32 r10, r4, r5, r6, r7, r8, r9, r1, r2, r3, r12, r14
    str.w r10, [r0, #27*width]

    neg.w r1, r1

    vmov.w r10, s0
    ldr.w r5, [r10, #1*width]
    ldr.w r6, [r10, #2*width]
    ldr.w r4, [r10], #3*width
    ldr.w r8, [r11, #1*width]
    ldr.w r9, [r11, #2*width]
    ldr.w r7, [r11], #3*width
    vmov.w s0, r10

    c1_3x3_32 r10, r4, r5, r6, r7, r8, r9, r1, r2, r3, r12, r14
    str.w r10, [r0, #1*width]

    c2_3x3_32 r10, r4, r5, r6, r7, r8, r9, r1, r2, r3, r12, r14
    str.w r10, [r0, #2*width]

    c0_3x3_32 r10, r4, r5, r6, r7, r8, r9, r1, r2, r3, r12, r14
    str.w r10, [r0], #3*width

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _mul_inner
#else
.endr
#endif

    vmov.w r10, s0
    add.w r0, r0, #27*width
    add.w r10, r10, #27*width
    add.w r11, r11, #27*width
    vmov.w s0, r10

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _mul
#else
.endr
#endif

    pop.w {r4-r12, pc}










