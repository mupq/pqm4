
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_base_mul
.type __asm_base_mul, %function
__asm_base_mul:
    push {r4-r12, lr}

    vmov.w s0, s1, r0, r1
    vmov.w s2, s3, r2, r3

// ================================

#ifdef LOOP
    add.w r12, r0, #10240
    vmov.w s15, r12
    _base_mul_loop:
#else
.rept 128
#endif

.rept 4

    vmov.w r0, r1, s0, s1
    ldm r0!, {r4-r8}
    ldm r1!, {r9-r12, r14}
    vmov.w s0, s1, r0, r1

    smull r2, r3, r4, r10
    smlal r2, r3, r5, r9
    smlal r2, r3, r6, r14
    smlal r2, r3, r7, r12
    smlal r2, r3, r8, r11

    smull r0, r1, r4, r9
    smlal r0, r1, r5, r14
    smlal r0, r1, r6, r12
    smlal r0, r1, r7, r11
    smlal r0, r1, r8, r10

    vmov.w s6, s7, r4, r11
    vmov.w s8, r14

    vmov.w r4, r11, s2, s3

    mul r14, r0, r4
    smlal r0, r1, r14, r11
    mul r14, r2, r4
    smlal r2, r3, r14, r11

    vmov.w r0, s0
    str.w r1, [r0, #-20]
    str.w r3, [r0, #-16]

    vmov.w r4, r11, s6, s7
    vmov.w r14, s8

    smull r0, r1, r4, r11
    smlal r0, r1, r5, r10
    smlal r0, r1, r6, r9
    smlal r0, r1, r7, r14
    smlal r0, r1, r8, r12

    smull r2, r3, r4, r12
    smlal r2, r3, r5, r11
    smlal r2, r3, r6, r10
    smlal r2, r3, r7, r9
    smlal r2, r3, r8, r14

    smull r4, r14, r4, r14
    smlal r4, r14, r5, r12
    smlal r4, r14, r6, r11
    smlal r4, r14, r7, r10
    smlal r4, r14, r8, r9

    vmov.w r5, r6, s2, s3

    mul r7, r0, r5
    smlal r0, r1, r7, r6
    mul r7, r2, r5
    smlal r2, r3, r7, r6
    mul r7, r4, r5
    smlal r4, r14, r7, r6

    vmov.w r0, s0
    str.w r1, [r0, #-12]
    str.w r3, [r0, #-8]
    str.w r14, [r0, #-4]

.endr

#ifdef LOOP
    vmov.w r12, s15
    cmp.w r0, r12
    bne.w _base_mul_loop
#else
.endr
#endif

// ================================

    pop {r4-r12, pc}


















