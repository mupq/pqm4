
// upper <- a*b + c*d + e*f
.macro montgomery_mul_and_add a, b, c, d, e, f, lower, upper, tmp, M_inv, M
    smull.w \lower, \upper, \a, \b
    smlal.w \lower, \upper, \c, \d
    smlal.w \lower, \upper, \e, \f
    mul.w   \tmp, \lower,  \M_inv
    smlal.w \lower, \upper, \tmp, \M
.endm

.syntax unified
.cpu cortex-m4

.global __asm_my_mul
.type __asm_my_mul, %function
__asm_my_mul:
    push.w {r4-r12,lr}
    sub.w r4, r0, #2048  // serve pointer as counter
    vmov.w s1, r4
    my_multiply:

        ldr.w r4, [r0, #-4]
        ldr.w r5, [r0, #2044]
        ldr.w r6, [r0, #4092]
        ldr.w r7, [r1, #-4]
        ldr.w r8, [r1, #2044]
        ldr.w r9, [r1, #4092]

        // r14: A0B0 + A1B2 + A2B1
        montgomery_mul_and_add r4, r7, r5, r9, r6, r8, r10, r14, r12, r2, r3

        // r11: A1B0 + A0B1 + A2B2
        montgomery_mul_and_add r5, r7, r4, r8, r6, r9, r10, r11, r12, r2, r3

        // r5: A1B1 + A0B2 + A2B0
        montgomery_mul_and_add r5, r8, r4, r9, r6, r7, r10, r5, r12, r2, r3

        str.w r14, [r0, #-4]
        str.w r11, [r0, #2044]
        str.w r5, [r0, #4092]

        ldr.w r4, [r0, #-8]
        ldr.w r5, [r0, #2040]
        ldr.w r6, [r0, #4088]
        ldr.w r7, [r1, #-8]
        ldr.w r8, [r1, #2040]
        ldr.w r9, [r1, #4088]

        // r14: A0B0 + A1B2 + A2B1
        montgomery_mul_and_add r4, r7, r5, r9, r6, r8, r10, r14, r12, r2, r3

        // r11: A1B0 + A0B1 + A2B2
        montgomery_mul_and_add r5, r7, r4, r8, r6, r9, r10, r11, r12, r2, r3

        // r5: A1B1 + A0B2 + A2B0
        montgomery_mul_and_add r5, r8, r4, r9, r6, r7, r10, r5, r12, r2, r3

        str.w r14, [r0, #-8]
        str.w r11, [r0, #2040]
        str.w r5, [r0, #4088]

        ldr.w r4, [r0, #-12]
        ldr.w r5, [r0, #2036]
        ldr.w r6, [r0, #4084]
        ldr.w r7, [r1, #-12]
        ldr.w r8, [r1, #2036]
        ldr.w r9, [r1, #4084]

        // r14: A0B0 + A1B2 + A2B1
        montgomery_mul_and_add r4, r7, r5, r9, r6, r8, r10, r14, r12, r2, r3

        // r11: A1B0 + A0B1 + A2B2
        montgomery_mul_and_add r5, r7, r4, r8, r6, r9, r10, r11, r12, r2, r3

        // r5: A1B1 + A0B2 + A2B0
        montgomery_mul_and_add r5, r8, r4, r9, r6, r7, r10, r5, r12, r2, r3

        str.w r14, [r0, #-12]
        str.w r11, [r0, #2036]
        str.w r5, [r0, #4084]

        ldr.w r4, [r0, #-16]
        ldr.w r5, [r0, #2032]
        ldr.w r6, [r0, #4080]
        ldr.w r7, [r1, #-16]
        ldr.w r8, [r1, #2032]
        ldr.w r9, [r1, #4080]

        // r14: A0B0 + A1B2 + A2B1
        montgomery_mul_and_add r4, r7, r5, r9, r6, r8, r10, r14, r12, r2, r3

        // r11: A1B0 + A0B1 + A2B2
        montgomery_mul_and_add r5, r7, r4, r8, r6, r9, r10, r11, r12, r2, r3

        // r5: A1B1 + A0B2 + A2B0
        montgomery_mul_and_add r5, r8, r4, r9, r6, r7, r10, r5, r12, r2, r3

        str.w r14, [r0, #-16]
        str.w r11, [r0, #2032]
        str.w r5, [r0, #4080]

        ldr.w r4, [r0, #-20]
        ldr.w r5, [r0, #2028]
        ldr.w r6, [r0, #4076]
        ldr.w r7, [r1, #-20]
        ldr.w r8, [r1, #2028]
        ldr.w r9, [r1, #4076]

        // r14: A0B0 + A1B2 + A2B1
        montgomery_mul_and_add r4, r7, r5, r9, r6, r8, r10, r14, r12, r2, r3

        // r11: A1B0 + A0B1 + A2B2
        montgomery_mul_and_add r5, r7, r4, r8, r6, r9, r10, r11, r12, r2, r3

        // r5: A1B1 + A0B2 + A2B0
        montgomery_mul_and_add r5, r8, r4, r9, r6, r7, r10, r5, r12, r2, r3

        str.w r14, [r0, #-20]
        str.w r11, [r0, #2028]
        str.w r5, [r0, #4076]

        ldr.w r4, [r0, #-24]
        ldr.w r5, [r0, #2024]
        ldr.w r6, [r0, #4072]
        ldr.w r7, [r1, #-24]
        ldr.w r8, [r1, #2024]
        ldr.w r9, [r1, #4072]

        // r14: A0B0 + A1B2 + A2B1
        montgomery_mul_and_add r4, r7, r5, r9, r6, r8, r10, r14, r12, r2, r3

        // r11: A1B0 + A0B1 + A2B2
        montgomery_mul_and_add r5, r7, r4, r8, r6, r9, r10, r11, r12, r2, r3

        // r5: A1B1 + A0B2 + A2B0
        montgomery_mul_and_add r5, r8, r4, r9, r6, r7, r10, r5, r12, r2, r3

        str.w r14, [r0, #-24]
        str.w r11, [r0, #2024]
        str.w r5, [r0, #4072]

        ldr.w r4, [r0, #-28]
        ldr.w r5, [r0, #2020]
        ldr.w r6, [r0, #4068]
        ldr.w r7, [r1, #-28]
        ldr.w r8, [r1, #2020]
        ldr.w r9, [r1, #4068]

        // r14: A0B0 + A1B2 + A2B1
        montgomery_mul_and_add r4, r7, r5, r9, r6, r8, r10, r14, r12, r2, r3

        // r11: A1B0 + A0B1 + A2B2
        montgomery_mul_and_add r5, r7, r4, r8, r6, r9, r10, r11, r12, r2, r3

        // r5: A1B1 + A0B2 + A2B0
        montgomery_mul_and_add r5, r8, r4, r9, r6, r7, r10, r5, r12, r2, r3

        str.w r14, [r0, #-28]
        str.w r11, [r0, #2020]
        str.w r5, [r0, #4068]

        ldr.w r4, [r0, #-32]
        ldr.w r5, [r0, #2016]
        ldr.w r6, [r0, #4064]
        ldr.w r8, [r1, #2016]
        ldr.w r9, [r1, #4064]
        ldr.w r7, [r1, #-32]!

        // r14: A0B0 + A1B2 + A2B1
        montgomery_mul_and_add r4, r7, r5, r9, r6, r8, r10, r14, r12, r2, r3

        // r11: A1B0 + A0B1 + A2B2
        montgomery_mul_and_add r5, r7, r4, r8, r6, r9, r10, r11, r12, r2, r3

        // r5: A1B1 + A0B2 + A2B0
        montgomery_mul_and_add r5, r8, r4, r9, r6, r7, r10, r5, r12, r2, r3

        str.w r11, [r0, #2016]
        str.w r5, [r0, #4064]
        str.w r14, [r0, #-32]!

        vmov.w r4, s1
        cmp.w r4, r0
        bne.w my_multiply

    pop.w {r4-r12,pc}

