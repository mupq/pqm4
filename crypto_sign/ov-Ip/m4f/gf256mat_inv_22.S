.syntax unified
.cpu cortex-m4
.thumb

#include "gf256_madd.i"

.macro gf256_inv g, f, delta, r, v, mdelta, tmp, tmp2, tmp3
    lsl.w \g, \g, #1
    mov.w \f, #0x11b
    mov.w \delta, #1
    mov.w \r, #0x100
    mov.w \v, #0

    // 15 instructions
    .rept 15
        eor \tmp, \f, \g
        eor \tmp2, \v, \r

        lsrs \tmp3, \g, #8
        itt ne
        eorne \g, \g, \f
        eorne \r, \r, \v

        neg \mdelta, \delta
        tst \tmp3, \mdelta, lsr#31

        ittte ne
        addne \delta, \mdelta, #1
        eorne \f, \f, \tmp
        eorne \v, \v, \tmp2
        addeq \delta, #1

        lsl \g, \g, #1
        lsr \v, \v, #1
    .endr
    and \g, \v, #0xff
.endm


.global gf256mat_inv_m4f_22_init
.type gf256mat_inv_m4f_22_init, %function
.align 2
gf256mat_inv_m4f_22_init:
    push {r4-r11, r14}
    inputoutput_fpu .req s18
    extmat_fpu  .req s19
    ai .req r3
    ii .req r1
    aj0 .req r9
    aj1 .req r6
    aj2 .req r7
    aj3 .req r8
    vmov.w inputoutput_fpu, r1
    vmov.w extmat_fpu, r0



    // set the entire extended matrix to zero
    mov.w r1, #0
    mov.w r2, #22*22*2
    bl.w memset

    mov.w r14, #1

    // copy over the input matrix to the left half of the extended matrix
    vmov.w r0, inputoutput_fpu
    vmov.w ai, extmat_fpu
    mov.w ii, #22
    1:
    ldr.w aj1, [r0, #4]
    ldr.w aj2, [r0, #8]
    ldr.w aj3, [r0, #12]
    ldr.w aj0, [r0], #16


    str.w aj1, [ai, #4]
    str.w aj2, [ai, #8]
    str.w aj3, [ai, #12]
    str.w aj0, [ai], #16

    ldrh.w aj1, [r0, #4]
    ldr.w aj0, [r0], #6

    strh.w aj1, [ai, #4]
    str.w aj0, [ai], #6


    add r12, ai, #22
    sub r12, ii
    strb r14, [r12]

    add.w ai, #22


    subs.w ii, ii, #1
    bne.w 1b


    .unreq ai
    .unreq ii
    .unreq aj0
    .unreq aj1
    .unreq aj2
    .unreq aj3
    .unreq inputoutput_fpu
    .unreq extmat_fpu
    pop {r4-r11, pc}


.global gf256mat_inv_m4f_22_extract
.type gf256mat_inv_m4f_22_extract, %function
.align 2
gf256mat_inv_m4f_22_extract:
    push {r4-r11, r14}
    ai .req r3
    ii .req r1
    aj0 .req r9
    aj1 .req r6
    aj2 .req r7
    aj3 .req r8

    inputoutput_fpu .req s11
    extmat_fpu  .req s0
    vmov.w inputoutput_fpu, r0
    vmov.w extmat_fpu, r1

    vmov.w ai, extmat_fpu
    vmov.w r2, inputoutput_fpu
    mov.w ii, #22
    add.w ai, #22
    1:
    ldr.w aj1, [ai, #4]
    ldr.w aj2, [ai, #8]
    ldr.w aj3, [ai, #12]
    ldr.w aj0, [ai], #16


    str.w aj1, [r2, #4]
    str.w aj2, [r2, #8]
    str.w aj3, [r2, #12]
    str.w aj0, [r2], #16

    ldrh.w aj1, [ai, #4]
    ldr.w aj0, [ai], #6+22

    strh.w aj1, [r2, #4]
    str.w aj0, [r2], #6


    subs.w ii, #1
    bne.w 1b

    pop {r4-r11, pc}

    .unreq ai
    .unreq ii
    .unreq aj0
    .unreq aj1
    .unreq aj2
    .unreq aj3
    .unreq inputoutput_fpu
    .unreq extmat_fpu

// computes _gf256v_mul_scalar_u32( ai  , pivot , w);
.macro madd_row pivot, aj, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, matf0, matf1, matf2, matf3, matf4, matf5, matf6, matf7, matf8, matf9, matf10
    gf256_madd_precompb \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \pivot, \c01010101, \pconst, \tmp8

    ldr.w \tmp4, [\aj, #4*0]
    ldr.w \tmp5, [\aj, #4*1]
    ldr.w \tmp6, [\aj, #4*2]
    ldr.w \tmp7, [\aj, #4*3]

    vmov.w \tmp0, \matf0
    vmov.w \tmp1, \matf1
    vmov.w \tmp2, \matf2
    vmov.w \tmp3, \matf3

    gf256_madd 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    str.w \tmp4, [\aj, #4*0]
    str.w \tmp5, [\aj, #4*1]
    str.w \tmp6, [\aj, #4*2]
    str.w \tmp7, [\aj, #4*3]

    ldr.w \tmp4, [\aj, #4*4]
    ldr.w \tmp5, [\aj, #4*5]
    ldr.w \tmp6, [\aj, #4*6]
    ldr.w \tmp7, [\aj, #4*7]

    vmov.w \tmp0, \matf4
    vmov.w \tmp1, \matf5
    vmov.w \tmp2, \matf6
    vmov.w \tmp3, \matf7

    gf256_madd 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    str.w \tmp4, [\aj, #4*4]
    str.w \tmp5, [\aj, #4*5]
    str.w \tmp6, [\aj, #4*6]
    str.w \tmp7, [\aj, #4*7]

    ldr.w \tmp4, [\aj, #4*8]
    ldr.w \tmp5, [\aj, #4*9]
    ldr.w \tmp6, [\aj, #4*10]

    vmov.w \tmp0, \matf8
    vmov.w \tmp1, \matf9
    vmov.w \tmp2, \matf10

    gf256_madd 3, \tmp4, \tmp5, \tmp6, xxx, \tmp0, \tmp1, \tmp2, xxx, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    str.w \tmp4, [\aj, #4*8]
    str.w \tmp5, [\aj, #4*9]
    str.w \tmp6, [\aj, #4*10]
.endm

// computes (r8 is assumbed to be at sp+0):
// r8 &= gf256_is_nonzero(ai[i]);
// uint8_t pivot = ai[i];
// pivot = gf256_inv( pivot );
// _gf256v_mul_scalar_u32( ai  , pivot , w);
.macro invert_pivot_and_multiply ai, pivotidx, pivot, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, matf0, matf1, matf2, matf3, matf4, matf5, matf6, matf7, matf8, matf9, matf10, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7
    // invert ai[i]
    ldrb.w \pivot, [\ai, \pivotidx]
    ldrb.w \tmp0, [sp, #0]
    cmp.n \pivot, #0
    it eq
    moveq.w \tmp0, #0
    strb.w \tmp0, [sp, #0]


    gf256_inv \pivot, \tmp0, \tmp1, \tmp2, \tmp3, \tmp4, \tmp5, \tmp6, \tmp7
    gf256_madd_precompb \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \pivot, \c01010101, \pconst, \tmp8

    ldr.w \tmp0, [\ai, #4*0]
    ldr.w \tmp1, [\ai, #4*1]
    ldr.w \tmp2, [\ai, #4*2]
    ldr.w \tmp3, [\ai, #4*3]


    gf256_mul_u32 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \matf0, \tmp4
    vmov.w \matf1, \tmp5
    vmov.w \matf2, \tmp6
    vmov.w \matf3, \tmp7
    str.w \tmp4, [\ai, #4*0]
    str.w \tmp5, [\ai, #4*1]
    str.w \tmp6, [\ai, #4*2]
    str.w \tmp7, [\ai, #4*3]

    ldr.w \tmp0, [\ai, #4*4]
    ldr.w \tmp1, [\ai, #4*5]
    ldr.w \tmp2, [\ai, #4*6]
    ldr.w \tmp3, [\ai, #4*7]

    gf256_mul_u32 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \matf4, \tmp4
    vmov.w \matf5, \tmp5
    vmov.w \matf6, \tmp6
    vmov.w \matf7, \tmp7
    str.w \tmp4, [\ai, #4*4]
    str.w \tmp5, [\ai, #4*5]
    str.w \tmp6, [\ai, #4*6]
    str.w \tmp7, [\ai, #4*7]

    ldr.w \tmp0, [\ai, #4*8]
    ldr.w \tmp1, [\ai, #4*9]
    ldr.w \tmp2, [\ai, #4*10]

    gf256_mul_u32 3, \tmp4, \tmp5, \tmp6, xxx, \tmp0, \tmp1, \tmp2, xxx, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \matf8, \tmp4
    vmov.w \matf9, \tmp5
    vmov.w \matf10, \tmp6
    str.w \tmp4, [\ai, #4*8]
    str.w \tmp5, [\ai, #4*9]
    str.w \tmp6, [\ai, #4*10]
.endm

.macro conditional_add ai, ii, aj, ajmax, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7
    // for the last row, we don't have rows left to add, so we skip the inner loop
    cmp.w \ii, #21
    beq.w last

    add.w \aj, \ai, #2*22
    rsb.w \ajmax, \ii, #22
    mov.w \tmp0, #2*22
    mla.w \ajmax, \ajmax, \tmp0, \ai

    1:
        ldrb.n \tmp0, [\ai, \ii]
        cmp.n \tmp0, #0

        # got 22*2/4 = 11 words to mult
        .rept 2 // 8 words
            ldr.w \tmp1, [\aj, #4*1]
            ldr.w \tmp2, [\aj, #4*2]
            ldr.w \tmp3, [\aj, #4*3]
            ldr.w \tmp0, [\aj], #16

            ldr.w \tmp4, [\ai, #4*0]
            ldr.w \tmp5, [\ai, #4*1]
            ldr.w \tmp6, [\ai, #4*2]
            ldr.w \tmp7, [\ai, #4*3]

            itttt eq
            eoreq \tmp4, \tmp4, \tmp0
            eoreq \tmp5, \tmp5, \tmp1
            eoreq \tmp6, \tmp6, \tmp2
            eoreq \tmp7, \tmp7, \tmp3

            str.w \tmp5, [\ai, #4*1]
            str.w \tmp6, [\ai, #4*2]
            str.w \tmp7, [\ai, #4*3]
            str.w \tmp4, [\ai], #16
        .endr
        // last 3 words
        ldr.w \tmp2, [\aj, #4*2]
        ldr.w \tmp1, [\aj, #4*1]
        ldr.w \tmp0, [\aj], #12
        ldr.w \tmp4, [\ai, #4*0]
        ldr.w \tmp5, [\ai, #4*1]
        ldr.w \tmp6, [\ai, #4*2]

        ittt eq
        eoreq \tmp4, \tmp4, \tmp0
        eoreq \tmp5, \tmp5, \tmp1
        eoreq \tmp6, \tmp6, \tmp2

        str.w \tmp5, [\ai, #4*1]
        str.w \tmp6, [\ai, #4*2]
        str.w \tmp4, [\ai], #-2*16

        cmp.w \aj, \ajmax
        bne.w 1b
    last:
.endm


.global gf256mat_inv_m4f_22_gauss
.type gf256mat_inv_m4f_22_gauss, %function
.align 2
gf256mat_inv_m4f_22_gauss:
    push.w {r4-r11, r14}
    vpush.w {s16-s31}
    sub.w sp, sp, #24
    mov.w r2, #0
    str.w r2, [sp, #4]

    // return code (0 if not invertible)
    mov.w r3, #1
    str.w r3, [sp, #0]

    // ai
    str.w r0, [sp, #16]
    // mat
    str.w r0, [sp, #20]


    mov.w r12, #0x01010101
    mov.w r14, #0x1b

    mov.w r1, r0
    2:
        str.w r0, [sp, #8]

        conditional_add r1, r2, r0, r3, r4, r5, r6, r7, r8, r9, r10, r11

        invert_pivot_and_multiply r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r2, r0, r12, r14, s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s24, s25, s26, s27, s28, s29, s30, s31

        ldr.w r0, [sp, #8]
        ldr.w r2, [sp, #4]
        add.w r1, r0, #22*22*2
        mov.w r3, #22*2
        mla.w r3, r2, r3, r0

        str.w r1, [sp, #8]
        str.w r3, [sp, #12]

        1:
            // check if i == j
            ldr.w r3, [sp, #12]
            cmp.w r3, r0
            beq.w skip

            // load pivot
            ldr r2, [sp, #4]
            ldrb.n r2, [r0, r2]

            // gf256v_madd( aj , ai , aj[i] , w);
            madd_row r2, r0, r1, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r14, s24, s25, s26, s27, s28, s29, s30, s31, s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10

        skip:
        ldr.w r1, [sp, #8]
        add.w r0, #22*2
        cmp.w r0, r1
        bne.w 1b

    ldr.w r1, [sp, #16]
    add.w r1, #2*22
    str.w r1, [sp, #16]

    ldr.w r2, [sp, #4]
    add.w r2, #1
    str.w r2, [sp, #4]

    // mat
    ldr.w r0, [sp, #20]
    cmp.w r2, #22
    bne.w 2b


    ldr.w r0, [sp, #0]
    add.w sp, sp, #24

    vpop {s16-s31}
    pop {r4-r11, pc}

.global gf256mat_inv_m4f_22
.type gf256mat_inv_m4f_22, %function
.align 2
gf256mat_inv_m4f_22:
    push.w {r4-r11, r14}
    vpush.w {s16-s19}
    vmov s16, r0
    vmov s17, r1

    sub.w sp, sp, #22*22*2
    mov.w r0, sp
    // initialize matrix
    bl.w gf256mat_inv_m4f_22_init

    mov.w r0, sp
    // actual Gauss elimination
    bl.w gf256mat_inv_m4f_22_gauss

    vmov.w s17, r0
    mov.w r1, sp
    vmov.w r0, s16
    // extract result
    bl.w gf256mat_inv_m4f_22_extract

    add.w sp, sp, #22*22*2
    vmov.w r0, s17
    vpop.w {s16-s19}
    pop {r4-r11, pc}