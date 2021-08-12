
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_base_mul
.type __asm_base_mul, %function
__asm_base_mul:
    push.w {r4-r12, lr}

    add.w r14, r0, #4096
    add.w r14, r14, #4096

    vmov.w s0, s1, r0, r14
    vmov.w s2, r1

#ifdef LOOP
    vmov.w s3, r14
    _mul_loop:
#else
.rept 256
#endif

    vmov.w r0, r14, s0, s1
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0, #4, #8, #12
    ldrstr4 ldr.w, r14, r8, r9, r10, r11, #0, #4, #8, #12

    vmov.w r12, s2
    ldr.w r1, [r12], #4
    vmov.w s2, r12

    smull r12, r14, r5, r11
    smlal r12, r14, r6, r10
    smlal r12, r14, r7, r9
    mul r0, r12, r2
    smlal r12, r14, r0, r3
    smull r12, r14, r14, r1
    smlal r12, r14, r4, r8
    mul r0, r12, r2
    smlal r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #0]

    smull r12, r14, r6, r11
    smlal r12, r14, r7, r10
    mul r0, r12, r2
    smlal r12, r14, r0, r3
    smull r12, r14, r14, r1
    smlal r12, r14, r4, r9
    smlal r12, r14, r5, r8
    mul r0, r12, r2
    smlal r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #4]

    smull r12, r14, r7, r11
    mul r0, r12, r2
    smlal r12, r14, r0, r3
    smull r12, r14, r14, r1
    smlal r12, r14, r4, r10
    smlal r12, r14, r5, r9
    smlal r12, r14, r6, r8
    mul r0, r12, r2
    smlal r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #8]

    smull r12, r14, r4, r11
    smlal r12, r14, r5, r10
    smlal r12, r14, r6, r9
    smlal r12, r14, r7, r8
    mul r0, r12, r2
    smlal r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #12]

// ================================

    vmov.w r14, s1

    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #16, #20, #24, #28
    ldrstr4 ldr.w, r14, r8, r9, r10, r11, #16, #20, #24, #28

    add.w r14, r14, #32
    vmov.w s1, r14

    neg.w r1, r1

    smull r12, r14, r5, r11
    smlal r12, r14, r6, r10
    smlal r12, r14, r7, r9
    mul r0, r12, r2
    smlal r12, r14, r0, r3
    smull r12, r14, r14, r1
    smlal r12, r14, r4, r8
    mul r0, r12, r2
    smlal r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #16]

    smull r12, r14, r6, r11
    smlal r12, r14, r7, r10
    mul r0, r12, r2
    smlal r12, r14, r0, r3
    smull r12, r14, r14, r1
    smlal r12, r14, r4, r9
    smlal r12, r14, r5, r8
    mul r0, r12, r2
    smlal r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #20]

    smull r12, r14, r7, r11
    mul r0, r12, r2
    smlal r12, r14, r0, r3
    smull r12, r14, r14, r1
    smlal r12, r14, r4, r10
    smlal r12, r14, r5, r9
    smlal r12, r14, r6, r8
    mul r0, r12, r2
    smlal r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #24]

    smull r12, r14, r4, r11
    smlal r12, r14, r5, r10
    smlal r12, r14, r6, r9
    smlal r12, r14, r7, r8
    mul r0, r12, r2
    smlal r12, r14, r0, r3

    vmov.w r0, s0
    str.w r14, [r0, #28]
    add.w r0, r0, #32
    vmov.w s0, r0

#ifdef LOOP
    vmov.w r12, s3
    cmp.w r0, r12
    bne.w _mul_loop
#else
.endr
#endif

    pop.w {r4-r12, pc}
