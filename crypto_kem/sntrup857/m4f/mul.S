
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_base_mul
.type __asm_base_mul, %function
__asm_base_mul:
    push {r4-r12, lr}

    ldr.w r4, [sp, #40]

    add.w r4, r4, #4
    vmov.w s1, r4

#ifdef LOOP
    add.w r12, r0, #6912
    vmov.w s2, r12
    _mul_light_loop:
#else
.rept 8
#endif

.rept 8

    ldr.w r5, [r0, #4]
    ldr.w r6, [r0, #8]
    ldr.w r4, [r0], #108
    ldr.w r8, [r1, #4]
    ldr.w r9, [r1, #8]
    ldr.w r7, [r1], #108

    smull r12, r14, r4, r7
    smlal r12, r14, r5, r9
    smlal r12, r14, r6, r8
    mul r11, r12, r2
    smlal r12, r14, r11, r3

    str.w r14, [r0, #-108]

    smull r12, r14, r4, r8
    smlal r12, r14, r5, r7
    smlal r12, r14, r6, r9
    mul r11, r12, r2
    smlal r12, r14, r11, r3

    str.w r14, [r0, #-104]

    smull r12, r14, r4, r9
    smlal r12, r14, r5, r8
    smlal r12, r14, r6, r7
    mul r11, r12, r2
    smlal r12, r14, r11, r3

    str.w r14, [r0, #-100]

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _mul_light_loop
#else
.endr
#endif

    sub.w r0, r0, #6912
    sub.w r1, r1, #6912

    add.w r0, r0, #12
    add.w r1, r1, #12

#ifdef LOOP
    add.w r12, r0, #96
    vmov.w s2, r12
    _mul_loop:
#else
.rept 8
#endif

    vmov.w r4, s1
    ldr.w r10, [r4], #4
    vmov.w s1, r4

#ifdef LOOP
    add.w r14, r0, #6912
    vmov.w s3, r14
    _mul_loop_inner:
#else
.rept 16
#endif

.rept 4

    ldr.w r5, [r0, #4]
    ldr.w r6, [r0, #8]
    ldr.w r4, [r0], #108
    ldr.w r8, [r1, #4]
    ldr.w r9, [r1, #8]
    ldr.w r7, [r1], #108

    smull r12, r14, r5, r9
    smlal r12, r14, r6, r8
    mul r11, r12, r2
    smlal r12, r14, r11, r3
    smull r12, r14, r14, r10
    smlal r12, r14, r4, r7
    mul r11, r12, r2
    smlal r12, r14, r11, r3

    str.w r14, [r0, #-108]

    smull r12, r14, r6, r9
    mul r11, r12, r2
    smlal r12, r14, r11, r3
    smull r12, r14, r14, r10
    smlal r12, r14, r4, r8
    smlal r12, r14, r5, r7
    mul r11, r12, r2
    smlal r12, r14, r11, r3

    str.w r14, [r0, #-104]

    smull r12, r14, r4, r9
    smlal r12, r14, r5, r8
    smlal r12, r14, r6, r7
    mul r11, r12, r2
    smlal r12, r14, r11, r3

    str.w r14, [r0, #-100]

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _mul_loop_inner
#else
.endr
#endif

    sub.w r0, r0, #6912
    sub.w r1, r1, #6912

    add.w r0, r0, #12
    add.w r1, r1, #12

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _mul_loop
#else
.endr
#endif


    pop {r4-r12, pc}
































