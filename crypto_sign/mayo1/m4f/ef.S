
.syntax unified
.cpu cortex-m4
.thumb


#include "gf16_madd_bitsliced.i"
#include "gf16_inverse.i"
#include "gf16_bitslice.i"
#include "asm_params.h"

.macro bitsliced_32_vec_mul_add legs, acc0, acc1, acc2, acc3, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2, incr
    ldr.w \mat1, [\mat, #4*1*\legs]
    ldr.w \mat2, [\mat, #4*2*\legs]
    ldr.w \mat3, [\mat, #4*3*\legs]
    .if \incr < 256
    ldr.w \mat0, [\mat], \incr
    .else
    ldr.w \mat0, [\mat]
    add.w \mat, \mat, \incr
    .endif

    gf16_madd_bitsliced \acc0, \acc1, \acc2, \acc3, \mat0, \mat1, \mat2, \mat3, \bbb, \tmp0, \tmp1, \tmp2
.endm


.macro extract_bitsliced  legs, el, AAA, tmp0, tmp1, tmp2, tmp3, tmp4, index
    // in += 4*(index / 32)
    ubfx.w \tmp0, \index, #5, #27
    add.w \tmp2, \AAA, \tmp0, lsl#2

    // (idx & 0x4) + 8*(idx & 0x3) + ((idx & 0x18)>>3);
    and.w     \tmp0, \index, #4
    bfi.w     \tmp0, \index, #3, #2
    ubfx.w    \tmp4, \index, #3, #2
    add.w     \tmp4, \tmp0

    ldr.w \el, [\tmp2]
    ldr.w \tmp0, [\tmp2, #4*1*\legs]
    ldr.w \tmp1, [\tmp2, #4*2*\legs]
    ldr.w \tmp2, [\tmp2, #4*3*\legs]

    lsr.w \el, \el, \tmp4
    lsr.w \tmp0, \tmp0, \tmp4
    lsr.w \tmp1, \tmp1, \tmp4
    lsr.w \tmp2, \tmp2, \tmp4

    bfi.w \el, \tmp0, #1, #1
    bfi.w \el, \tmp1, #2, #1
    bfi.w \el, \tmp2, #3, #1

    and.w \el, #0xF
.endm


.macro bitsliced_vec_mul_add legs, accu0, accu1, accu2, accu3, acc, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2
    .set i, 0
    .rept \legs
        ldr.w \accu0, [\acc, #4*0*\legs]
        ldr.w \accu1, [\acc, #4*1*\legs]
        ldr.w \accu2, [\acc, #4*2*\legs]
        ldr.w \accu3, [\acc, #4*3*\legs]


        .if i != \legs-1
            .set incrAcc, 4
            .set incrMat, 4
        .else
            .set incrAcc, 4+4*3*\legs
            .set incrMat, 4-4*\legs
        .endif

        bitsliced_32_vec_mul_add \legs, \accu0, \accu1, \accu2, \accu3, \mat0, \mat1, \mat2, \mat3, \mat, \bbb, \tmp0, \tmp1, \tmp2, incrMat

        str.w \accu1, [\acc, #4*1*\legs]
        str.w \accu2, [\acc, #4*2*\legs]
        str.w \accu3, [\acc, #4*3*\legs]
        str.w \accu0, [\acc], incrAcc

        .set i, i+1
    .endr
.endm


.global ef_inner1_asm
.type ef_inner1_asm, %function
.align 2
ef_inner1_asm:
    .set ncols, (K*O+1)
    .set legs, ((ncols+31)/32)
    pivot_row_idxf .req s0
    pivot_is_zero .req r12
    row_upper_bound .req s1

    vldr.w pivot_row_idxf, [sp]
    ldr.w r12, [sp, #4]
    ldrb.w pivot_is_zero, [r12]
    vldr.w row_upper_bound, [sp, #8]

    push.w {r4-r11, r14}

    pivot_row .req r0
    AAA .req r1
    pivot_col .req r2
    row .req r3

    tmp0 .req r4
    tmp1 .req r5
    tmp2 .req r6
    tmp3 .req r7
    tmp4 .req r8
    tmp5 .req r9
    tmp6 .req r10
    tmp7 .req r11

    pivot .req r14
    1:

    // ((row == pivot_row) || ((row > pivot_row) && pivot_is_zero))
    vmov.w tmp0, pivot_row_idxf
    mov.w tmp1, pivot_is_zero
    cmp.n row, tmp0
    it lt
    movlt tmp1, #0
    it eq
    moveq tmp1, #1
    nop
    cmp.w tmp1, #0

    .set i, 0
    .rept legs
            ldr.w tmp0, [pivot_row, #0*4]
            ldr.w tmp1, [pivot_row, #1*4]
            ldr.w tmp2, [pivot_row, #2*4]
            ldr.w tmp3, [pivot_row, #3*4]

            ldr.w tmp5, [AAA, #1*4]
            ldr.w tmp6, [AAA, #2*4]
            ldr.w tmp7, [AAA, #3*4]
            ldr.w tmp4, [AAA], #16

            nop
            itttt ne
            eorne.w tmp0, tmp4
            eorne.w tmp1, tmp5
            eorne.w tmp2, tmp6
            eorne.w tmp3, tmp7

            str.w tmp1, [pivot_row, #1*4]
            str.w tmp2, [pivot_row, #2*4]
            str.w tmp3, [pivot_row, #3*4]
            .if i < legs-1
            str.w tmp0, [pivot_row], #16
            .else
            str.w tmp0, [pivot_row], -16*(legs-1)
            .endif
            .set i,i+1
    .endr

    // extract pivot
    mov.w r8, pivot_row
    extract_bitsliced legs, pivot, r8, r4, r5, r6, r7, r9, pivot_col

    // update pivot_is_zero
    clz pivot_is_zero, pivot
    lsr pivot_is_zero, #5

    add.w row, row, #1
    vmov.w tmp0, row_upper_bound
    cmp.w row, tmp0
    ble.w 1b

    // store pivot_is_zero
    ldr.w r8, [sp, #4+9*4]
    strb.w pivot_is_zero, [r8]
    mov.w r0, pivot

    pop.w {r4-r11, pc}


    .unreq pivot_row_idxf
    .unreq pivot_is_zero
    .unreq row_upper_bound
    .unreq pivot_row
    .unreq AAA
    .unreq pivot_col
    .unreq row
    .unreq tmp0
    .unreq tmp1
    .unreq tmp2
    .unreq tmp3
    .unreq tmp4
    .unreq tmp5
    .unreq tmp6
    .unreq tmp7
    .unreq pivot




.global ef_inner2_asm
.type ef_inner2_asm, %function
.align 2
ef_inner2_asm:
    .set ncols, (K*O+1)
    .set legs, ((ncols+31)/32)
    push.w {r4-r11, r14}
    pivot_row_out .req r0
    pivot_row_in .req r1
    pivot        .req r2
    accu0 .req r3
    accu1 .req r4
    accu2 .req r5
    accu3 .req r6

    mat0 .req r7
    mat1 .req r8
    mat2 .req r9
    mat3 .req r10

    tmp0 .req r11
    tmp1 .req r12
    tmp2 .req r14

    gf16_inverse tmp0, pivot, tmp1, tmp2
    mov.w pivot, tmp0

    .rept legs
        mov.w accu0, #0
        mov.w accu1, #0
        mov.w accu2, #0
        mov.w accu3, #0

        bitsliced_32_vec_mul_add legs, accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, pivot_row_in, pivot, tmp0, tmp1, tmp2, 4

        str.w accu1, [pivot_row_out, #4*1*legs]
        str.w accu2, [pivot_row_out, #4*2*legs]
        str.w accu3, [pivot_row_out, #4*3*legs]
        str.w accu0, [pivot_row_out], #4
   .endr

    pop.w {r4-r11, pc}

    .unreq pivot_row_out
    .unreq pivot_row_in
    .unreq pivot
    .unreq accu0
    .unreq accu1
    .unreq accu2
    .unreq accu3

    .unreq mat0
    .unreq mat1
    .unreq mat2
    .unreq mat3

    .unreq tmp0
    .unreq tmp1
    .unreq tmp2


.global ef_inner3_asm
.type ef_inner3_asm, %function
.align 2
ef_inner3_asm:
    .set ncols, (K*O+1)
    .set legs, ((ncols+31)/32)
    pivot_row_upper_boundf .req s0
    pivot_is_nonzero .req r12

    vldr.w pivot_row_upper_boundf, [sp]
    ldr.w pivot_is_nonzero, [sp, #4]

    push.w {r4-r11, r14}

    AAA .req r0
    pivot_row .req r1
    pivot_row_ctr .req r2
    row .req r3

    tmp0 .req r4
    tmp1 .req r5
    tmp2 .req r6
    tmp3 .req r7
    tmp4 .req r8
    tmp5 .req r9
    tmp6 .req r10
    tmp7 .req r11


    1:
        eor.w tmp0, pivot_row_ctr, row
        orrs.w tmp0, tmp0, pivot_is_nonzero

        .set i, 0
        .rept legs
            ldr.w tmp0, [AAA, #0*4]
            ldr.w tmp1, [AAA, #1*4]
            ldr.w tmp2, [AAA, #2*4]
            ldr.w tmp3, [AAA, #3*4]

            ldr.w tmp5, [pivot_row, #1*4]
            ldr.w tmp6, [pivot_row, #2*4]
            ldr.w tmp7, [pivot_row, #3*4]

            .if i < (legs-1)
            ldr.w tmp4, [pivot_row], #16
            .else
            ldr.w tmp4, [pivot_row], -16*(legs-1)
            .endif

            nop
            itttt eq
            moveq.w tmp0, tmp4
            moveq.w tmp1, tmp5
            moveq.w tmp2, tmp6
            moveq.w tmp3, tmp7

            str.w tmp1, [AAA, #1*4]
            str.w tmp2, [AAA, #2*4]
            str.w tmp3, [AAA, #3*4]
            str.w tmp0, [AAA], #16
            .set i, i+1
        .endr

        add.w row, row, #1
        vmov.w tmp0, pivot_row_upper_boundf
        cmp.w row, tmp0
        ble.w 1b


    pop.w {r4-r11, pc}


    .unreq AAA
    .unreq pivot_row
    .unreq pivot_row_ctr
    .unreq row
    .unreq tmp0
    .unreq tmp1
    .unreq tmp2
    .unreq tmp3
    .unreq tmp4
    .unreq tmp5
    .unreq tmp6
    .unreq tmp7
    .unreq pivot_is_nonzero


.global ef_inner4_asm
.type ef_inner4_asm, %function
.align 2
ef_inner4_asm:
    .set ncols, (K*O+1)
    .set legs, ((ncols+31)/32)
    AAA .req r0
    pivot_row .req r1
    row_ctr .req r2
    pivot_row_ctr .req r3
    below_pivot .req r4
    bbb .req r2


    accu0 .req r3
    accu1 .req r4
    accu2 .req r5
    accu3 .req r6

    mat0 .req r7
    mat1 .req r8
    mat2 .req r9
    mat3 .req r10

    tmp0 .req r11
    tmp1 .req r12
    tmp2 .req r14
    tmp3 .req mat0

    pivot_col_f .req s0
    pivot_is_nonzero .req s1
    pivot_row_ctrf .req s2
    row_ctrf .req s3

    vldr.w pivot_col_f, [sp, #0]
    vldr.w pivot_is_nonzero, [sp, #4]
    push.w {r4-r11, r14}


    vmov.w pivot_row_ctrf, pivot_row_ctr
    vmov.w row_ctrf, row_ctr

    mov.w tmp0, #4*4*legs
    mul.w tmp0, tmp0, row_ctr
    add.w AAA, tmp0


    1:
        vmov.w below_pivot, pivot_is_nonzero
        vmov.w pivot_row_ctr, pivot_row_ctrf
        cmp.n row_ctr, pivot_row_ctr
        it le
        movle.w below_pivot, 0

        vmov.w r10, pivot_col_f
        extract_bitsliced legs, bbb, AAA, tmp0, tmp1, tmp2, tmp3, r10, r10

        mul.w bbb, below_pivot
        bitsliced_vec_mul_add legs, accu0, accu1, accu2, accu3, AAA, mat0, mat1, mat2, mat3, pivot_row, bbb, tmp0, tmp1, tmp2

        vmov.w row_ctr, row_ctrf
        add.w row_ctr, #1
        vmov.w row_ctrf, row_ctr
        cmp.w row_ctr, M
        bne.w 1b



    vmov.w tmp0, pivot_is_nonzero
    vmov.w tmp1, pivot_row_ctrf
    add.w tmp1, tmp0
    vmov.w pivot_row_ctrf, tmp1

    vmov.w r0, pivot_row_ctrf

    pop.w {r4-r11, pc}


    .unreq AAA
    .unreq pivot_row
    .unreq row_ctr
    .unreq pivot_row_ctr
    .unreq below_pivot
    .unreq bbb

    .unreq accu0
    .unreq accu1
    .unreq accu2
    .unreq accu3

    .unreq mat0
    .unreq mat1
    .unreq mat2
    .unreq mat3

    .unreq tmp0
    .unreq tmp1
    .unreq tmp2
    .unreq tmp3

    .unreq pivot_col_f
    .unreq pivot_is_nonzero
    .unreq pivot_row_ctrf
    .unreq row_ctrf




.global ef_bitslice_asm
.type ef_bitslice_asm, %function
.align 2
ef_bitslice_asm:
    .set ncols, (K*O+1)
    .set legs, ((ncols+31)/32)
    push.w {r4-r11, r14}
    out .req r0
    in  .req r1

    tmp0 .req r2
    tmp1 .req r3
    tmp2 .req r4
    tmp3 .req r5
    tmp4 .req r6
    tmp5 .req r7
    tmp6 .req r8
    tmp7 .req r9

    ctr .req r10

    mov.w ctr, M

    1:
        .rept legs
            ldr.w tmp1, [in, #4*1]
            ldr.w tmp2, [in, #4*2]
            ldr.w tmp3, [in, #4*3]
            ldr.w tmp4, [in, #4*4]
            ldr.w tmp5, [in, #4*5]
            ldr.w tmp6, [in, #4*6]
            ldr.w tmp7, [in, #4*7]
            ldr.w tmp0, [in], #32

            eor.w tmp0, tmp0, tmp1, lsl#4
            eor.w tmp2, tmp2, tmp3, lsl#4
            eor.w tmp4, tmp4, tmp5, lsl#4
            eor.w tmp6, tmp6, tmp7, lsl#4

            gf16_bitslice tmp1, tmp3, tmp5, tmp7, tmp0, tmp2, tmp4, tmp6


            str.w tmp3, [out, #4*1*legs]
            str.w tmp5, [out, #4*2*legs]
            str.w tmp7, [out, #4*3*legs]
            str.w tmp1, [out], #4
        .endr

        add.w out, legs*16 - 4*legs
        sub.w in, legs*32 - ncols

        subs.w ctr, #1
        bne 1b

    pop.w {r4-r11, pc}

    .unreq out
    .unreq in
    .unreq tmp0
    .unreq tmp1
    .unreq tmp2
    .unreq tmp3
    .unreq tmp4
    .unreq tmp5
    .unreq tmp6
    .unreq tmp7
    .unreq ctr



.global ef_unbitslice_asm
.type ef_unbitslice_asm, %function
.align 2
ef_unbitslice_asm:
    .set ncols, (K*O+1)
    .set legs, ((ncols+31)/32)
    push.w {r4-r11, r14}
    out .req r0
    in  .req r1

    tmp0 .req r2
    tmp1 .req r3
    tmp2 .req r4
    tmp3 .req r5
    tmp4 .req r6
    tmp5 .req r7
    tmp6 .req r8
    tmp7 .req r9


    # store elements except for last word
    .rept legs-1
        ldr.w tmp3, [in, #4*1*legs]
        ldr.w tmp5, [in, #4*2*legs]
        ldr.w tmp7, [in, #4*3*legs]
        ldr.w tmp1, [in], #4

        gf16_bitslice tmp0, tmp2, tmp4, tmp6, tmp1, tmp3, tmp5, tmp7

        lsr.w tmp1, tmp0, #4
        lsr.w tmp3, tmp2, #4
        lsr.w tmp5, tmp4, #4
        lsr.w tmp7, tmp6, #4

        and.w tmp0, #0x0F0F0F0F
        and.w tmp1, #0x0F0F0F0F
        and.w tmp2, #0x0F0F0F0F
        and.w tmp3, #0x0F0F0F0F
        and.w tmp4, #0x0F0F0F0F
        and.w tmp5, #0x0F0F0F0F
        and.w tmp6, #0x0F0F0F0F
        and.w tmp7, #0x0F0F0F0F

        str.w tmp1, [out, #4*1]
        str.w tmp2, [out, #4*2]
        str.w tmp3, [out, #4*3]
        str.w tmp4, [out, #4*4]
        str.w tmp5, [out, #4*5]
        str.w tmp6, [out, #4*6]
        str.w tmp7, [out, #4*7]
        str.w tmp0, [out], #32
    .endr

    # store last word
    ldr.w tmp3, [in, #4*1*legs]
    ldr.w tmp5, [in, #4*2*legs]
    ldr.w tmp7, [in, #4*3*legs]
    ldr.w tmp1, [in], #4

    gf16_bitslice tmp0, tmp2, tmp4, tmp6, tmp1, tmp3, tmp5, tmp7


    .if ncols % 32 == 9
    lsr.w tmp1, tmp0, #4

    and.w tmp0, #0x0F0F0F0F
    and.w tmp1, #0x0F0F0F0F
    and.w tmp2, #0x0F0F0F0F

    str.w tmp0, [out]
    str.w tmp1, [out, #4*1]
    strb.w tmp2, [out, #4*2]
    .endif

    .if ncols % 32 == 15
    lsr.w tmp1, tmp0, #4
    lsr.w tmp3, tmp2, #4

    and.w tmp0, #0x0F0F0F0F
    and.w tmp1, #0x0F0F0F0F
    and.w tmp2, #0x0F0F0F0F
    and.w tmp3, #0x0F0F0F0F

    str.w tmp0, [out]
    str.w tmp1, [out, #4*1]
    str.w tmp2, [out, #4*2]

    // DODO can we just do a str directly?
    strb.w tmp3, [out, #4*3]
    lsr.w tmp3, 8
    strb.w tmp3, [out, #4*3+1]
    lsr.w tmp3, 8
    strb.w tmp3, [out, #4*3+2]

    .endif



    pop.w {r4-r11, pc}

    .unreq out
    .unreq in
    .unreq tmp0
    .unreq tmp1
    .unreq tmp2
    .unreq tmp3
    .unreq tmp4
    .unreq tmp5
    .unreq tmp6
    .unreq tmp7

.macro backsub_add ptr, el, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, ncols
    ubfx \tmp0, \el, #28, #4
    ubfx \tmp1, \el, #24, #4
    ubfx \tmp2, \el, #20, #4
    ubfx \tmp3, \el, #16, #4

    ldrb.w \tmp4,  [\ptr, #0*\ncols]
    ldrb.w \tmp5,  [\ptr, #1*\ncols]
    ldrb.w \tmp6,  [\ptr, #2*\ncols]
    ldrb.w \tmp7,  [\ptr, #3*\ncols]

    eor.w \tmp4, \tmp0
    eor.w \tmp5, \tmp1
    eor.w \tmp6, \tmp2
    eor.w \tmp7, \tmp3


    strb.w \tmp4, [\ptr], \ncols
    strb.w \tmp5, [\ptr], \ncols
    strb.w \tmp6, [\ptr], \ncols
    strb.w \tmp7, [\ptr], \ncols

    ubfx \tmp0, \el, #12, #4
    ubfx \tmp1, \el, #8, #4
    ubfx \tmp2, \el, #4, #4
    ubfx \tmp3, \el, #0, #4

    ldrb.w \tmp4, [\ptr, #0*\ncols]
    ldrb.w \tmp5, [\ptr, #1*\ncols]
    ldrb.w \tmp6, [\ptr, #2*\ncols]
    ldrb.w \tmp7, [\ptr, #3*\ncols]

    eor.w \tmp4, \tmp0
    eor.w \tmp5, \tmp1
    eor.w \tmp6, \tmp2
    eor.w \tmp7, \tmp3


    strb.w \tmp4, [\ptr], \ncols
    strb.w \tmp5, [\ptr], \ncols
    strb.w \tmp6, [\ptr], \ncols
    strb.w \tmp7, [\ptr], \ncols
.endm



.global backsub_inner_asm
.type backsub_inner_asm, %function
.align 2
backsub_inner_asm:
    .set ncols, (K*O+1)
    .set legs, ((ncols+31)/32)

    ctr .req s0

    vldr.w ctr, [sp]
    push.w {r4-r11, r14}
    vmov.w s2, r1

    ldrb.w r0, [r0]
    cmp.n r3, #0

    // TODO: check if mul works too
    it eq
    moveq.w r0, #0

    vmov.w r12, ctr
    1:

    cmp.w r12, #32
    blt.w 4f

    // ctr >= 32
    // 0-7
    ldrb.w r9, [r1], ncols
    and.w r9, 0xF
    .rept 7
        ldrb.w r8, [r1], ncols
        eor.w r9, r8, r9, lsl#4
    .endr

    // 8-15
    ldrb.w r10, [r1], ncols
    and.w r10, 0xF
    .rept 7
        ldrb.w r8, [r1], ncols
        eor.w r10, r8, r10, lsl#4
    .endr

    // 16-23
    ldrb.w r11, [r1], ncols
    and.w r11, 0xF
    .rept 7
        ldrb.w r8, [r1], ncols
        eor.w r11, r8, r11, lsl#4
    .endr

    // 24-31
    ldrb.w r12, [r1], ncols
    and.w r12, 0xF
    .rept 7
        ldrb.w r8, [r1], ncols
        eor.w r12, r8, r12, lsl#4
    .endr


    gf16_bitslice r4, r5, r6, r7, r9, r10, r11, r12

    mov.w r8, #0
    mov.w r9, #0
    mov.w r10, #0
    mov.w r11, #0

    gf16_madd_bitsliced r8, r9, r10, r11, r4, r5, r6, r7, r0, r12, r14, r3

    gf16_bitslice r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w s7, r5
    vmov.w s8, r6
    vmov.w s9, r7

    backsub_add r2, r4, r12, r5, r6, r7, r8, r9, r10, r11, ncols
    vmov.w r4, s7
    backsub_add r2, r4, r12, r5, r6, r7, r8, r9, r10, r11, ncols
    vmov.w r4, s8
    backsub_add r2, r4, r12, r5, r6, r7, r8, r9, r10, r11, ncols
    vmov.w r4, s9
    backsub_add r2, r4, r12, r5, r6, r7, r8, r9, r10, r11, ncols

    vmov.w r12, ctr
    subs.w r12, r12, #32
    vmov.w ctr, r12
    bne.w 1b
    b.w 3f


    4:

    cmp.w r12, #8
    blt.w 2f

    // ctr >= 8
    ldrb.w r9, [r1], ncols
    .rept 7
        ldrb.w r8, [r1], ncols
        eor.w r9, r8, r9, lsl#4
    .endr

    gf16_bitslice_single r4, r5, r6, r7, r9

    mov.w r8, #0
    mov.w r9, #0
    mov.w r10, #0
    mov.w r11, #0

    gf16_madd_bitsliced r8, r9, r10, r11, r4, r5, r6, r7, r0, r12, r14, r3

    gf16_unbitslice_single r12, r8, r9, r10, r11

    backsub_add r2, r12, r4, r5, r6, r7, r8, r9, r10, r11, ncols

    vmov.w r12, ctr
    subs.w r12, r12, #8
    vmov.w ctr, r12
    bne.w 1b
    b.w 3f

    // ctr < 8
    2:
    ldrb.w r8, [r1], ncols

    gf16_bitslice_single r4, r5, r6, r7, r8

    mov.w r8, #0
    mov.w r9, #0
    mov.w r10, #0
    mov.w r11, #0

    gf16_madd_bitsliced r8, r9, r10, r11, r4, r5, r6, r7, r0, r12, r14, r3
    gf16_unbitslice_single r12, r8, r9, r10, r11


    ldrb.w r14, [r2]
    eor.w r14, r14, r12
    strb.w r14, [r2], ncols

    vmov.w r12, ctr
    subs.w r12, r12, #1
    vmov.w ctr, r12
    bne.w 1b

    // end
    3:

    pop.w {r4-r11, pc}
