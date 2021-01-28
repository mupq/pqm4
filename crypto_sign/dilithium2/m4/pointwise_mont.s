.syntax unified
.thumb

.macro montgomery_multiplication res, pa, pb, q, qinv
    smull \pa, \res, \pa, \pb
    mul \pb, \pa, \qinv
    smlal \pa, \res, \pb, \q
.endm


// void asm_pointwise_montgomery(int32_t c[N], const int32_t a[N], const int32_t b[N]);
.global pqcrystals_dilithium_asm_pointwise_montgomery
.type pqcrystals_dilithium_asm_pointwise_montgomery,%function
.align 2
pqcrystals_dilithium_asm_pointwise_montgomery:
    push.w {r4-r11, r14}
    c_ptr .req r0
    a_ptr .req r1
    b_ptr .req r2
    qinv  .req r3
    q     .req r4
    pa0   .req r5
    pa1   .req r6
    pa2   .req r7
    pb0   .req r8
    pb1   .req r9
    pb2   .req r10
    tmp0  .req r11
    ctr   .req r12
    res   .req r14

    movw qinv, #:lower16:0xfc7fdfff
    movt qinv, #:upper16:0xfc7fdfff
    movw q, #0xE001
    movt q, #0x7F


    // 85x3 = 255 coefficients
    movw ctr, #85
    1:
        ldr.w pa1, [a_ptr, #4]
        ldr.w pa2, [a_ptr, #8]
        ldr pa0, [a_ptr], #12
        ldr.w pb1, [b_ptr, #4]
        ldr.w pb2, [b_ptr, #8]
        ldr pb0, [b_ptr], #12

        montgomery_multiplication res, pa0, pb0, q, qinv
        str res, [c_ptr], #4
        montgomery_multiplication res, pa1, pb1, q, qinv
        str res, [c_ptr], #4
        montgomery_multiplication res, pa2, pb2, q, qinv
        str res, [c_ptr], #4
    subs ctr, #1
    bne.w 1b

    // final coefficient
    ldr.w pa0, [a_ptr]
    ldr.w pb0, [b_ptr]
    montgomery_multiplication res, pa0, pb0, q, qinv
    str.w res, [c_ptr]

    pop.w {r4-r11, pc}
.size pqcrystals_dilithium_asm_pointwise_montgomery, .-pqcrystals_dilithium_asm_pointwise_montgomery

// void asm_pointwise_acc_montgomery(int32_t c[N], const int32_t a[N], const int32_t b[N]);
.global pqcrystals_dilithium_asm_pointwise_acc_montgomery
.type pqcrystals_dilithium_asm_pointwise_acc_montgomery,%function
.align 2
pqcrystals_dilithium_asm_pointwise_acc_montgomery:
    push.w {r4-r11, r14}
    c_ptr .req r0
    a_ptr .req r1
    b_ptr .req r2
    qinv  .req r3
    q     .req r4
    pa0   .req r5
    pa1   .req r6
    pa2   .req r7
    pb0   .req r8
    pb1   .req r9
    pb2   .req r10
    tmp0  .req r11
    ctr   .req r12
    res   .req r14

    movw qinv, #:lower16:0xfc7fdfff
    movt qinv, #:upper16:0xfc7fdfff
    movw q, #0xE001
    movt q, #0x7F


    // 85x3 = 255 coefficients
    movw ctr, #85
    1:
        ldr.w pa1, [a_ptr, #4]
        ldr.w pa2, [a_ptr, #8]
        ldr pa0, [a_ptr], #12
        ldr.w pb1, [b_ptr, #4]
        ldr.w pb2, [b_ptr, #8]
        ldr pb0, [b_ptr], #12

        montgomery_multiplication res, pa0, pb0, q, qinv
        montgomery_multiplication pa0, pa1, pb1, q, qinv
        montgomery_multiplication pa1, pa2, pb2, q, qinv

        ldr.w pb0, [c_ptr]
        ldr.w pb1, [c_ptr, #4]
        ldr.w pb2, [c_ptr, #8]
        add.w res, res, pb0
        str res, [c_ptr], #12
        add.w pa0, pa0, pb1
        str pa0, [c_ptr, #-8]
        add.w pa1, pa1, pb2
        str pa1, [c_ptr, #-4]
    subs ctr, #1
    bne.w 1b

    // final coefficient
    ldr.w pa0, [a_ptr]
    ldr.w pb0, [b_ptr]
    ldr.w pa1, [c_ptr]
    montgomery_multiplication res, pa0, pb0, q, qinv
    add.w res, res, pa1
    str.w res, [c_ptr]

    pop.w {r4-r11, pc}
.size pqcrystals_dilithium_asm_pointwise_acc_montgomery, .-pqcrystals_dilithium_asm_pointwise_acc_montgomery
