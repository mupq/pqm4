.macro montgomery_mul_32bit lower, upper, a, b, Qprime, Q, tmp
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \lower, \Qprime
    smlal.w \lower, \upper, \tmp, \Q
.endm

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_final_map_n
.type __asm_final_map_n, %function
__asm_final_map_n:
    push {r4-r12, lr}

    mov.w r9, r1

    // invN_R2modM
    movw r12, #38372
    movt r12, #49

    add.w r10, r9, #4096
    add.w r11, r10, #4096

#ifdef LOOP
    add.w r14, r0, #4096
    add.w r14, r14, #4096
    add.w r14, r14, #2008
    vmov.w s0, r14
    _final_n:
#else
.rept 102
#endif

    ldr.w r5, [r0, #4]
    ldr.w r6, [r0, #8]
    ldr.w r7, [r0, #12]
    ldr.w r8, [r0, #16]
    ldr.w r4, [r0], #20

    montgomery_mul_32bit r1, r4, r4, r12, r2, r3, r14
    montgomery_mul_32bit r1, r5, r5, r12, r2, r3, r14
    montgomery_mul_32bit r1, r6, r6, r12, r2, r3, r14
    montgomery_mul_32bit r1, r7, r7, r12, r2, r3, r14
    montgomery_mul_32bit r1, r8, r8, r12, r2, r3, r14

    str.w r6, [r9, #2048]
    str.w r5, [r10, #2048]
    str.w r4, [r9], #4
    str.w r8, [r10], #4
    str.w r7, [r11], #4

    ldr.w r5, [r0, #4]
    ldr.w r6, [r0, #8]
    ldr.w r7, [r0, #12]
    ldr.w r8, [r0, #16]
    ldr.w r4, [r0], #20

    montgomery_mul_32bit r1, r4, r4, r12, r2, r3, r14
    montgomery_mul_32bit r1, r5, r5, r12, r2, r3, r14
    montgomery_mul_32bit r1, r6, r6, r12, r2, r3, r14
    montgomery_mul_32bit r1, r7, r7, r12, r2, r3, r14
    montgomery_mul_32bit r1, r8, r8, r12, r2, r3, r14

    str.w r7, [r9, #2048]
    str.w r6, [r10, #2048]
    str.w r5, [r9], #4
    str.w r4, [r10], #4
    str.w r8, [r11], #4

    ldr.w r5, [r0, #4]
    ldr.w r6, [r0, #8]
    ldr.w r7, [r0, #12]
    ldr.w r8, [r0, #16]
    ldr.w r4, [r0], #20

    montgomery_mul_32bit r1, r4, r4, r12, r2, r3, r14
    montgomery_mul_32bit r1, r5, r5, r12, r2, r3, r14
    montgomery_mul_32bit r1, r6, r6, r12, r2, r3, r14
    montgomery_mul_32bit r1, r7, r7, r12, r2, r3, r14
    montgomery_mul_32bit r1, r8, r8, r12, r2, r3, r14

    str.w r8, [r9, #2048]
    str.w r7, [r10, #2048]
    str.w r6, [r9], #4
    str.w r5, [r10], #4
    str.w r4, [r11], #4

    ldr.w r5, [r0, #4]
    ldr.w r6, [r0, #8]
    ldr.w r7, [r0, #12]
    ldr.w r8, [r0, #16]
    ldr.w r4, [r0], #20

    montgomery_mul_32bit r1, r4, r4, r12, r2, r3, r14
    montgomery_mul_32bit r1, r5, r5, r12, r2, r3, r14
    montgomery_mul_32bit r1, r6, r6, r12, r2, r3, r14
    montgomery_mul_32bit r1, r7, r7, r12, r2, r3, r14
    montgomery_mul_32bit r1, r8, r8, r12, r2, r3, r14

    str.w r4, [r9, #2048]
    str.w r8, [r10, #2048]
    str.w r7, [r9], #4
    str.w r6, [r10], #4
    str.w r5, [r11], #4

    ldr.w r5, [r0, #4]
    ldr.w r6, [r0, #8]
    ldr.w r7, [r0, #12]
    ldr.w r8, [r0, #16]
    ldr.w r4, [r0], #20

    montgomery_mul_32bit r1, r4, r4, r12, r2, r3, r14
    montgomery_mul_32bit r1, r5, r5, r12, r2, r3, r14
    montgomery_mul_32bit r1, r6, r6, r12, r2, r3, r14
    montgomery_mul_32bit r1, r7, r7, r12, r2, r3, r14
    montgomery_mul_32bit r1, r8, r8, r12, r2, r3, r14

    str.w r5, [r9, #2048]
    str.w r4, [r10, #2048]
    str.w r8, [r9], #4
    str.w r7, [r10], #4
    str.w r6, [r11], #4

#ifdef LOOP
    vmov.w r14, s0
    cmp.w r0, r14
    bne.w _final_n
#else
.endr
#endif

    ldr.w r5, [r0, #4]
    ldr.w r6, [r0, #8]
    ldr.w r7, [r0, #12]
    ldr.w r8, [r0, #16]
    ldr.w r4, [r0], #20

    montgomery_mul_32bit r1, r4, r4, r12, r2, r3, r14
    montgomery_mul_32bit r1, r5, r5, r12, r2, r3, r14
    montgomery_mul_32bit r1, r6, r6, r12, r2, r3, r14
    montgomery_mul_32bit r1, r7, r7, r12, r2, r3, r14
    montgomery_mul_32bit r1, r8, r8, r12, r2, r3, r14

    str.w r6, [r9, #2048]
    str.w r5, [r10, #2048]
    str.w r4, [r9], #4
    str.w r8, [r10], #4
    str.w r7, [r11], #4

    ldr.w r5, [r0, #4]
    ldr.w r6, [r0, #8]
    ldr.w r7, [r0, #12]
    ldr.w r8, [r0, #16]
    ldr.w r4, [r0], #20

    montgomery_mul_32bit r1, r4, r4, r12, r2, r3, r14
    montgomery_mul_32bit r1, r5, r5, r12, r2, r3, r14
    montgomery_mul_32bit r1, r6, r6, r12, r2, r3, r14
    montgomery_mul_32bit r1, r7, r7, r12, r2, r3, r14
    montgomery_mul_32bit r1, r8, r8, r12, r2, r3, r14

    str.w r7, [r9, #2048]
    str.w r6, [r10, #2048]
    str.w r5, [r9], #4
    str.w r4, [r10], #4
    str.w r8, [r11], #4







    pop {r4-r12, pc}
