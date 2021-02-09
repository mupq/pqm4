
#include "macros_common.S"

#ifndef LOOP
#define LOOP
#endif

.syntax unified
.cpu cortex-m4

.global mul
.type mul, %function
mul:
    vldr.w s12, [sp, #0]
    vldr.w s13, [sp, #4]

    push.w {r4-r12, lr}

    vmov.w s0, s1, r0, r1

#ifdef LOOP
    add.w r12, r0, #1024
    vmov.w s2, r12
    mul_loop:
#else
.rept 16
#endif

.rept 2

    vmov.w r12, r14, s12, s13
    ldrstr4 ldr.w, r12, r4, r5, r6, r7, #16, #20, #24, #28
    ldrstr4 ldr.w, r14, r8, r9, r10, r11, #16, #20, #24, #28

    vmov.w r12, s1
    ldr.w r1, [r12], #4
    vmov.w s1, r12

    smull.w r12, r14, r4, r11
    smlal.w r12, r14, r5, r10
    smlal.w r12, r14, r6, r9
    smlal.w r12, r14, r7, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #28]

    smull.w r12, r14, r7, r11
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r10
    smlal.w r12, r14, r5, r9
    smlal.w r12, r14, r6, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #24]

    smull.w r12, r14, r6, r11
    smlal.w r12, r14, r7, r10
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r9
    smlal.w r12, r14, r5, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #20]

    smull.w r12, r14, r5, r11
    smlal.w r12, r14, r6, r10
    smlal.w r12, r14, r7, r9
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #16]

// ================================

    vmov.w r12, r14, s12, s13
    ldrstr4jump ldr.w, r12, r4, r5, r6, r7, #4, #8, #12, #32
    ldrstr4jump ldr.w, r14, r8, r9, r10, r11, #4, #8, #12, #32
    vmov.w s12, s13, r12, r14

    neg.w r1, r1

    smull.w r12, r14, r4, r11
    smlal.w r12, r14, r5, r10
    smlal.w r12, r14, r6, r9
    smlal.w r12, r14, r7, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #12]

    smull.w r12, r14, r7, r11
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r10
    smlal.w r12, r14, r5, r9
    smlal.w r12, r14, r6, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #8]

    smull.w r12, r14, r6, r11
    smlal.w r12, r14, r7, r10
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r9
    smlal.w r12, r14, r5, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #4]

    smull.w r12, r14, r5, r11
    smlal.w r12, r14, r6, r10
    smlal.w r12, r14, r7, r9
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0], #32
    vmov.w s0, r0

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w mul_loop
#else
.endr
#endif

    pop.w {r4-r12, pc}

.global mul_acc
.type mul_acc, %function
mul_acc:
    vldr.w s12, [sp, #0]
    vldr.w s13, [sp, #4]

    push.w {r4-r12, lr}

    vmov.w s0, s1, r0, r1

#ifdef LOOP
    add.w r12, r0, #1024
    vmov.w s2, r12
    mul_acc_loop:
#else
.rept 16
#endif

.rept 2

    vmov.w r12, r14, s12, s13
    ldrstr4 ldr.w, r12, r4, r5, r6, r7, #16, #20, #24, #28
    ldrstr4 ldr.w, r14, r8, r9, r10, r11, #16, #20, #24, #28

    vmov.w r12, s1
    ldr.w r1, [r12], #4
    vmov.w s1, r12

    smull.w r12, r14, r4, r11
    smlal.w r12, r14, r5, r10
    smlal.w r12, r14, r6, r9
    smlal.w r12, r14, r7, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    ldr.w r12, [r0, #28]
    add.w r14, r14, r12
    str.w r14, [r0, #28]

    smull.w r12, r14, r7, r11
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r10
    smlal.w r12, r14, r5, r9
    smlal.w r12, r14, r6, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    ldr.w r12, [r0, #24]
    add.w r14, r14, r12
    str.w r14, [r0, #24]

    smull.w r12, r14, r6, r11
    smlal.w r12, r14, r7, r10
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r9
    smlal.w r12, r14, r5, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    ldr.w r12, [r0, #20]
    add.w r14, r14, r12
    str.w r14, [r0, #20]

    smull.w r12, r14, r5, r11
    smlal.w r12, r14, r6, r10
    smlal.w r12, r14, r7, r9
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    ldr.w r12, [r0, #16]
    add.w r14, r14, r12
    str.w r14, [r0, #16]

// ================================

    vmov.w r12, r14, s12, s13
    ldrstr4jump ldr.w, r12, r4, r5, r6, r7, #4, #8, #12, #32
    ldrstr4jump ldr.w, r14, r8, r9, r10, r11, #4, #8, #12, #32
    vmov.w s12, s13, r12, r14

    neg.w r1, r1

    smull.w r12, r14, r4, r11
    smlal.w r12, r14, r5, r10
    smlal.w r12, r14, r6, r9
    smlal.w r12, r14, r7, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    ldr.w r12, [r0, #12]
    add.w r14, r14, r12
    str.w r14, [r0, #12]

    smull.w r12, r14, r7, r11
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r10
    smlal.w r12, r14, r5, r9
    smlal.w r12, r14, r6, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    ldr.w r12, [r0, #8]
    add.w r14, r14, r12
    str.w r14, [r0, #8]

    smull.w r12, r14, r6, r11
    smlal.w r12, r14, r7, r10
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r9
    smlal.w r12, r14, r5, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    ldr.w r12, [r0, #4]
    add.w r14, r14, r12
    str.w r14, [r0, #4]

    smull.w r12, r14, r5, r11
    smlal.w r12, r14, r6, r10
    smlal.w r12, r14, r7, r9
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3
    smull.w r12, r14, r14, r1
    smlal.w r12, r14, r4, r8
    mul.w r0, r12, r2
    smlal.w r12, r14, r0, r3

    vmov.w r0, s0
    ldr.w r12, [r0]
    add.w r14, r14, r12
    str.w r14, [r0], #32
    vmov.w s0, r0

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w mul_acc_loop
#else
.endr
#endif

    pop.w {r4-r12, pc}

