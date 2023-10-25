 .macro macro_bitsliced_m_calculate_PS_m4f_asm m_legs, n, k
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
    mov.w r14, 16*\m_legs

    1:
    .set i, 0
    .rept \m_legs
        ldr.w mat1, [r1, #1*4*\m_legs]
        ldr.w mat2, [r1, #2*4*\m_legs]
        ldr.w mat3, [r1, #3*4*\m_legs]
        ldr.w mat0, [r1], #4


        .rept \k
            ldrb.w r12, [r2], \n
            mla.w r12, r14, r12, r0

            ldr.w accu0, [r12, #0*4*\m_legs]
            ldr.w accu1, [r12, #1*4*\m_legs]
            ldr.w accu2, [r12, #2*4*\m_legs]
            ldr.w accu3, [r12, #3*4*\m_legs]

            eor.w accu0, mat0
            eor.w accu1, mat1
            eor.w accu2, mat2
            eor.w accu3, mat3

            str.w accu0, [r12, #0*4*\m_legs]
            str.w accu1, [r12, #1*4*\m_legs]
            str.w accu2, [r12, #2*4*\m_legs]
            str.w accu3, [r12, #3*4*\m_legs]

            add.w r0, r0, 16*16*\m_legs
        .endr

        .if i < \m_legs-1
        sub.w r2, \n*\k
        mov.w r12, 16*16*\k*\m_legs-4
        sub.w r0, r0, r12
        .else
        sub.w r2, \n*\k-1
        mov.w r12, 16*16*\k*\m_legs+(\m_legs-1)*4
        sub.w r0, r0, r12
        .endif

        .set i,i+1
    .endr
    add.w r1, r1, #3*4*\m_legs
    cmp.w r2, r11
    bne.w 1b

    pop.w {r4-r11, pc}
.endm

 .macro macro_bitsliced_m_calculate_PS_m4f_stack_asm m_legs, n, k
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
    mov.w r14, 16*\m_legs


    1:
    ldrb.w r12, [r2], #1
    mla.w r12, r14, r12, r0

    .set i, 0
    .rept \m_legs
        ldr.w mat1, [r1, #1*4*\m_legs]
        ldr.w mat2, [r1, #2*4*\m_legs]
        ldr.w mat3, [r1, #3*4*\m_legs]
        ldr.w mat0, [r1], #4

        ldr.w accu0, [r12, #0*4*\m_legs]
        ldr.w accu1, [r12, #1*4*\m_legs]
        ldr.w accu2, [r12, #2*4*\m_legs]
        ldr.w accu3, [r12, #3*4*\m_legs]

        eor.w accu0, mat0
        eor.w accu1, mat1
        eor.w accu2, mat2
        eor.w accu3, mat3

        str.w accu1, [r12, #1*4*\m_legs]
        str.w accu2, [r12, #2*4*\m_legs]
        str.w accu3, [r12, #3*4*\m_legs]
        str.w accu0, [r12], #4
    .endr

    add.w r1, r1, 16*\m_legs - \m_legs*4

    cmp.w r2, r11
    bne.w 1b

    pop.w {r4-r11, pc}
.endm

.macro macro_bitsliced_m_calculate_SPS_m4f_asm m_legs, n, k
    push.w {r4-r11, r14}
    mov.w r14, 16*\m_legs

    mov.w r11, \n
    1:
    .set i,0
    .rept \k
        ldrb.w r12, [r2], \n
        mla.w r12, r14, r12, r0

        .rept \m_legs
            ldr.w mat1, [r1, #1*4*\m_legs]
            ldr.w mat2, [r1, #2*4*\m_legs]
            ldr.w mat3, [r1, #3*4*\m_legs]
            ldr.w mat0, [r1], #4

            ldr.w accu0, [r12, #0*4*\m_legs]
            ldr.w accu1, [r12, #1*4*\m_legs]
            ldr.w accu2, [r12, #2*4*\m_legs]
            ldr.w accu3, [r12, #3*4*\m_legs]

            eor.w accu0, mat0
            eor.w accu1, mat1
            eor.w accu2, mat2
            eor.w accu3, mat3

            str.w accu1, [r12, #1*4*\m_legs]
            str.w accu2, [r12, #2*4*\m_legs]
            str.w accu3, [r12, #3*4*\m_legs]
            str.w accu0, [r12], #4
        .endr

        .if i < \k-1
        add.w r0, \k*16*16*\m_legs
        sub.w r1, \m_legs*4
        .else
        sub.w r0, (\k-1)*\k*16*16*\m_legs
        add.w r1, \k*\m_legs*16 - \m_legs*4
        .endif

        .set i, i+1
    .endr

    sub.w r2, \n*\k-1

    subs.w r11, #1
    bne.w 1b

    pop.w {r4-r11, pc}
.endm


.macro addx m_legs, outidx, inidx
        ldr.w r3, [r0, #0*4*\m_legs+(\inidx-1)*16*\m_legs]
        ldr.w r4, [r0, #1*4*\m_legs+(\inidx-1)*16*\m_legs]
        ldr.w r5, [r0, #2*4*\m_legs+(\inidx-1)*16*\m_legs]
        ldr.w r6, [r0, #3*4*\m_legs+(\inidx-1)*16*\m_legs]

        ldr.w r7,  [r0, #0*4*\m_legs+(\outidx-1)*16*\m_legs]
        ldr.w r8,  [r0, #1*4*\m_legs+(\outidx-1)*16*\m_legs]
        ldr.w r9,  [r0, #2*4*\m_legs+(\outidx-1)*16*\m_legs]
        ldr.w r10, [r0, #3*4*\m_legs+(\outidx-1)*16*\m_legs]

        eor.w r7, r6
        eor.w r8, r3
        eor.w r8, r6
        eor.w r9, r4
        eor.w r10, r5

        str.w r7,  [r0, #0*4*\m_legs+(\outidx-1)*16*\m_legs]
        str.w r8,  [r0, #1*4*\m_legs+(\outidx-1)*16*\m_legs]
        str.w r9,  [r0, #2*4*\m_legs+(\outidx-1)*16*\m_legs]
        str.w r10, [r0, #3*4*\m_legs+(\outidx-1)*16*\m_legs]
.endm

.macro addx_final m_legs, outidx, inidx
        ldr.w r3, [r0, #0*4*\m_legs+(\inidx-1)*16*\m_legs]
        ldr.w r4, [r0, #1*4*\m_legs+(\inidx-1)*16*\m_legs]
        ldr.w r5, [r0, #2*4*\m_legs+(\inidx-1)*16*\m_legs]
        ldr.w r6, [r0, #3*4*\m_legs+(\inidx-1)*16*\m_legs]

        ldr.w r8,  [r0, #1*4*\m_legs+(\outidx-1)*16*\m_legs]
        ldr.w r9,  [r0, #2*4*\m_legs+(\outidx-1)*16*\m_legs]
        ldr.w r10, [r0, #3*4*\m_legs+(\outidx-1)*16*\m_legs]
        ldr.w r7,  [r0], #4

        eor.w r7, r6
        eor.w r8, r3
        eor.w r8, r6
        eor.w r9, r4
        eor.w r10, r5

        str.w r8,  [r1, #1*4*\m_legs]
        str.w r9,  [r1, #2*4*\m_legs]
        str.w r10, [r1, #3*4*\m_legs]
        str.w r7,  [r1], #4
.endm

.macro addx_inv m_legs, outidx, inidx
        ldr.w r3, [r0, #0*4*\m_legs+(\inidx-1)*16*\m_legs]
        ldr.w r4, [r0, #1*4*\m_legs+(\inidx-1)*16*\m_legs]
        ldr.w r5, [r0, #2*4*\m_legs+(\inidx-1)*16*\m_legs]
        ldr.w r6, [r0, #3*4*\m_legs+(\inidx-1)*16*\m_legs]

        ldr.w r7,  [r0, #0*4*\m_legs+(\outidx-1)*16*\m_legs]
        ldr.w r8,  [r0, #1*4*\m_legs+(\outidx-1)*16*\m_legs]
        ldr.w r9,  [r0, #2*4*\m_legs+(\outidx-1)*16*\m_legs]
        ldr.w r10, [r0, #3*4*\m_legs+(\outidx-1)*16*\m_legs]

        eor.w r7, r3
        eor.w r7, r4
        eor.w r8, r5
        eor.w r9, r6
        eor.w r10, r3

        str.w r7,  [r0, #0*4*\m_legs+(\outidx-1)*16*\m_legs]
        str.w r8,  [r0, #1*4*\m_legs+(\outidx-1)*16*\m_legs]
        str.w r9,  [r0, #2*4*\m_legs+(\outidx-1)*16*\m_legs]
        str.w r10, [r0, #3*4*\m_legs+(\outidx-1)*16*\m_legs]
.endm




.macro macro_bitsliced_multiply_bins_asm m_legs, n, k
    push.w {r4-r11, r14}
    add.w r0, \m_legs*16
    mov.w r11, r2
    1:
        .rept \m_legs
            addx_inv \m_legs, 10, 5
            addx \m_legs, 12, 11
            addx_inv \m_legs, 7, 10
            addx \m_legs, 6, 12
            addx_inv \m_legs, 14, 7
            addx \m_legs, 3, 6
            addx_inv \m_legs, 15, 14
            addx \m_legs, 8, 3
            addx_inv \m_legs, 13, 15
            addx \m_legs, 4, 8
            addx_inv \m_legs, 9, 13
            addx \m_legs, 2, 4
            addx_inv \m_legs, 1, 9
            addx_final \m_legs, 1, 2
        .endr

        add.w r0, 4*16*4*\m_legs - \m_legs*4
        add.w r1, 8*2*\m_legs - \m_legs*4

        subs.w r11, #1
        bne 1b
    pop.w {r4-r11, pc}
.endm


.macro macro_bitsliced_multiply_bins_stack_asm m_legs, n, k
    push.w {r4-r11, r14}
    add.w r0, \m_legs*16
    mov.w r11, r2
    1:
        .rept \m_legs
            addx_inv \m_legs, 10, 5
            addx \m_legs, 12, 11
            addx_inv \m_legs, 7, 10
            addx \m_legs, 6, 12
            addx_inv \m_legs, 14, 7
            addx \m_legs, 3, 6
            addx_inv \m_legs, 15, 14
            addx \m_legs, 8, 3
            addx_inv \m_legs, 13, 15
            addx \m_legs, 4, 8
            addx_inv \m_legs, 9, 13
            addx \m_legs, 2, 4
            addx_inv \m_legs, 1, 9
            addx_final \m_legs, 1, 2
        .endr

        add.w r0, 4*16*4*\m_legs - \m_legs*4
        add.w r1, 8*2*\k*\m_legs - \m_legs*4

        subs.w r11, #1
        bne 1b
    pop.w {r4-r11, pc}
.endm