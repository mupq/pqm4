.macro macro_calculate_PS_m4f_stack_asm m_vec_limbs, n, k
    push.w {r4-r11, r14}
    accu0 .req r3
    accu1 .req r4
    accu2 .req r5
    accu3 .req r6

    mat0 .req r7
    mat1 .req r8
    mat2 .req r9
    mat3 .req r10

    add.w r11, r2, r3
    mov.w r14, 8*\m_vec_limbs

    1:
    ldrb.w r12, [r2], #1
    mla.w r12, r14, r12, r0
    // TODO: this is not using all register; can pipeline this much better by doing 2 iterations in one
    .rept \m_vec_limbs
        ldr.w mat1, [r1, #4]
        ldr.w mat0, [r1], #8

        ldr.w accu0, [r12, #0*4]
        ldr.w accu1, [r12, #1*4]

        eor.w accu0, mat0
        eor.w accu1, mat1

        str.w accu1, [r12, #1*4]
        str.w accu0, [r12], #8
    .endr

   cmp.w r2, r11
   bne.w 1b

    pop.w {r4-r11, pc}
.endm

.macro macro_calculate_SPS_m4f_asm m_vec_limbs, n, k
    push.w {r4-r11, r14}
    mov.w r14, 8*\m_vec_limbs

    mov.w r11, \n
    1:
    .set i,0
    .rept \k
        ldrb.w r12, [r2], \n
        mla.w r12, r14, r12, r0

        // TODO: this is not using all register; can pipeline this much better by doing 2 iterations in one
        .rept \m_vec_limbs
            ldr.w mat1, [r1, #4]
            ldr.w mat0, [r1], #8

            ldr.w accu0, [r12, #0*4]
            ldr.w accu1, [r12, #1*4]

            eor.w accu0, mat0
            eor.w accu1, mat1

            str.w accu1, [r12, #1*4]
            str.w accu0, [r12], #8
        .endr

        .if i < \k-1
        add.w r0, \k*16*8*\m_vec_limbs
        sub.w r1, \m_vec_limbs*8
        .else
            .if (\k-1)*\k*16*8*\m_vec_limbs > 16384
                // TODO: check if we have extra registers after implementing the other TODO, if so just keep it in registers
                ldr.w r12, =((\k-1)*\k*16*8*\m_vec_limbs)
                sub.w r0, r12
            .else
                sub.w r0, (\k-1)*\k*16*8*\m_vec_limbs
            .endif
        add.w r1, \k*\m_vec_limbs*8 - \m_vec_limbs*8
        .endif

        .set i, i+1
    .endr

    sub.w r2, \n*\k-1

    subs.w r11, #1
    bne.w 1b

    pop.w {r4-r11, pc}
.endm



.macro addx_single out, in, tmp
    and.w \tmp, \in, 0x88888888
    //acc[0] ^= in[3];
    eor.w \out, \out, \tmp, lsr#3
    //acc[1] ^= in[3];
    eor.w \out, \out, \tmp, lsr#2
    //acc[1] ^= in[0]
    and.w \tmp, \in, 0x11111111
    eor.w \out, \out, \tmp, lsl#1
    //acc[2] ^= in[1];
    and.w \tmp, \in, 0x22222222
    eor.w \out, \out, \tmp, lsl#1
    //acc[3] ^= in[2];
    and.w \tmp, \in, 0x44444444
    eor.w \out, \out, \tmp, lsl#1
.endm

.macro multiply_bins_load out, addr, idx, m_vec_limbs
    ldr.w \out, [\addr, (\idx-1)* (\m_vec_limbs*8)]
.endm

.macro multiply_bins_load_incr out, addr
    ldr.w \out, [\addr], #4
.endm



.macro multiply_bins out, in, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, m_vec_limbs
    bin2 .req \t10
    bin3 .req \t0
    bin4 .req \t1
    bin6 .req \t2
    bin7 .req \t3
    bin8 .req \t4
    bin10 .req \t5
    bin12 .req \t6
    bin13 .req \t7
    bin14 .req \t8
    bin15 .req \t9

    multiply_bins_load bin2, \in, 2, \m_vec_limbs
    multiply_bins_load bin3, \in, 3, \m_vec_limbs
    multiply_bins_load bin4, \in, 4, \m_vec_limbs
    multiply_bins_load bin6, \in, 6, \m_vec_limbs
    multiply_bins_load bin7, \in, 7, \m_vec_limbs
    multiply_bins_load bin8, \in, 8, \m_vec_limbs
    multiply_bins_load bin10, \in, 10, \m_vec_limbs
    multiply_bins_load bin12, \in, 12, \m_vec_limbs
    multiply_bins_load bin13, \in, 13, \m_vec_limbs
    multiply_bins_load bin14, \in, 14, \m_vec_limbs
    multiply_bins_load bin15, \in, 15, \m_vec_limbs

    // m_vec_add(m_legs, bins + 15 * m_legs * 4, bins + 12 * m_legs * 4);
    // m_vec_add(m_legs, bins + 15 * m_legs * 4, bins +  3 * m_legs * 4);
    eor.w bin12, bin15
    eor.w bin3, bin15

    // m_vec_add(m_legs, bins + 14 * m_legs * 4, bins +  8 * m_legs * 4);
    // m_vec_add(m_legs, bins + 14 * m_legs * 4, bins +  6 * m_legs * 4);
    eor.w bin8, bin14
    eor.w bin6, bin14

    // m_vec_add(m_legs, bins + 13 * m_legs * 4, bins + 10 * m_legs * 4);
    // m_vec_add(m_legs, bins + 13 * m_legs * 4, bins +  7 * m_legs * 4);
    eor.w bin10, bin13
    eor.w bin7, bin13


    // m_vec_add(m_legs, bins + 12 * m_legs * 4, bins +  8 * m_legs * 4);
    // m_vec_add(m_legs, bins + 12 * m_legs * 4, bins +  4 * m_legs * 4);
    eor.w bin8, bin12
    eor.w bin4, bin12

    // m_vec_add(m_legs, bins + 7 * m_legs * 4, bins +  4 * m_legs * 4);
    // m_vec_add(m_legs, bins + 7 * m_legs * 4, bins +  3 * m_legs * 4);
    eor.w bin4, bin7
    eor.w bin3, bin7

    .unreq bin15
    .unreq bin14
    .unreq bin13
    .unreq bin12
    .unreq bin7

    bin1  .req \t6
    bin5  .req \t3
    bin7  .req \t7
    bin9  .req \t8
    bin11 .req \t9


    // // free: t9, t8, t7, t6, t3

    multiply_bins_load bin5, \in, 5, \m_vec_limbs
    multiply_bins_load bin7, \in, 7, \m_vec_limbs
    multiply_bins_load bin9, \in, 9, \m_vec_limbs
    multiply_bins_load bin11, \in, 11, \m_vec_limbs
    multiply_bins_load_incr bin1, \in

    // m_vec_add(m_legs, bins + 11 * m_legs * 4, bins +  9 * m_legs * 4);
    // m_vec_add(m_legs, bins + 11 * m_legs * 4, bins +  2 * m_legs * 4);
    eor.w bin9, bin11
    eor.w bin2, bin11

    //m_vec_add(m_legs, bins + 10 * m_legs * 4, bins +  8 * m_legs * 4);
    //m_vec_add(m_legs, bins + 10 * m_legs * 4, bins +  2 * m_legs * 4);
    eor.w bin8, bin10
    eor.w bin2, bin10

    //m_vec_add(m_legs, bins + 9 * m_legs * 4, bins +  8 * m_legs * 4);
    //m_vec_add(m_legs, bins + 9 * m_legs * 4, bins +  1 * m_legs * 4);
    eor.w bin8, bin9
    eor.w bin1, bin9

    // m_vec_add(m_legs, bins + 6 * m_legs * 4, bins +  4 * m_legs * 4);
    // m_vec_add(m_legs, bins + 6 * m_legs * 4, bins +  2 * m_legs * 4);
    eor.w bin4, bin6
    eor.w bin2, bin6

    // m_vec_add(m_legs, bins + 5 * m_legs * 4, bins +  4 * m_legs * 4);
    // m_vec_add(m_legs, bins + 5 * m_legs * 4, bins +  1 * m_legs * 4);
    eor.w bin4, bin5
    eor.w bin1, bin5

    // m_vec_add(m_legs, bins + 3 * m_legs * 4, bins +  2 * m_legs * 4);
    // m_vec_add(m_legs, bins + 3 * m_legs * 4, bins +  1 * m_legs * 4);
    eor.w bin2, bin3
    eor.w bin1, bin3


    // m_vec_mul_add_x(m_legs, bins + 8 * m_legs * 4, bins + 4 * m_legs * 4);
    // m_vec_mul_add_x(m_legs, bins + 4 * m_legs * 4, bins + 2 * m_legs * 4);
    // m_vec_mul_add_x(m_legs, bins + 2 * m_legs * 4, bins + 1 * m_legs * 4);

    addx_single bin4, bin8, bin3
    addx_single bin2, bin4, bin3
    addx_single bin1, bin2, bin3

    str.w bin1, [\out], #4

    .unreq bin2
    .unreq bin3
    .unreq bin4
    .unreq bin6
    .unreq bin8
    .unreq bin10

    .unreq bin1
    .unreq bin5
    .unreq bin7
    .unreq bin9
    .unreq bin11
.endm

.macro macro_multiply_bins_asm m
    .set m_vec_limbs, ((\m + 15)/16)
    push.w {r4-r11, r14}
    add.w r1, m_vec_limbs*8
    mov.w r14, r2
    1:
    .rept  m_vec_limbs * 2
    multiply_bins r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, m_vec_limbs
    .endr

    add.w r1, 16 * 8 * m_vec_limbs - m_vec_limbs*8
    add.w r0, 8 * m_vec_limbs - m_vec_limbs*8

    subs.w r14, #1
    bne 1b

    pop.w {r4-r11, pc}
.endm

.macro macro_multiply_bins_stack_asm m, k
    .set m_vec_limbs, ((\m + 15)/16)
    push.w {r4-r11, r14}
    add.w r1, m_vec_limbs*8
    mov.w r14, r2
    1:
    .rept m_vec_limbs * 2
    multiply_bins r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, m_vec_limbs
    .endr
    add.w r1, 16 * 8 * m_vec_limbs - m_vec_limbs*8
    add.w r0, \k * 8 * m_vec_limbs - m_vec_limbs*8
    subs.w r14, #1
    bne 1b

    pop.w {r4-r11, pc}
.endm