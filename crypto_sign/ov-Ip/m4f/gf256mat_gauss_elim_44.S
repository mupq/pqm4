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
        eor.w \tmp, \f, \g
        eor.w \tmp2, \v, \r

        lsrs.w \tmp3, \g, #8
        itt ne
        eorne.n \g, \g, \f
        eorne.w \r, \r, \v

        neg \mdelta, \delta
        tst \tmp3, \mdelta, lsr#31

        nop.n
        ittte ne
        addne \delta, \mdelta, #1
        eorne \f, \f, \tmp
        eorne \v, \v, \tmp2
        addeq.w \delta, #1

        lsl \g, \g, #1
        lsr \v, \v, #1
    .endr
    and \g, \v, #0xff
.endm


// computes _gf256v_mul_scalar_u32( ai  , pivot , w);
.macro madd_row pivot, aj, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, matf0, matf1, matf2, matf3, matf4, matf5, matf6, matf7, matf8, matf9, matf10, matf11
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
    ldr.w \tmp7, [\aj, #4*11]

    vmov.w \tmp0, \matf8
    vmov.w \tmp1, \matf9
    vmov.w \tmp2, \matf10
    vmov.w \tmp3, \matf11


    gf256_madd 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    str.w \tmp4, [\aj, #4*8]
    str.w \tmp5, [\aj, #4*9]
    str.w \tmp6, [\aj, #4*10]
    str.w \tmp7, [\aj, #4*11]
.endm



// computes _gf256v_mul_scalar_u32( ai  , pivot , w);
.macro madd_row_second pivot, aj, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, matf0, matf1, matf2, matf3, matf4, matf5, matf6, matf7, matf8, matf9, matf10, matf11
    gf256_madd_precompb \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \pivot, \c01010101, \pconst, \tmp8

    @ ldr.w \tmp4, [\aj, #4*0]
    @ ldr.w \tmp5, [\aj, #4*1]
    @ ldr.w \tmp6, [\aj, #4*2]
    @ ldr.w \tmp7, [\aj, #4*3]

    @ vmov.w \tmp0, \matf0
    @ vmov.w \tmp1, \matf1
    @ vmov.w \tmp2, \matf2
    @ vmov.w \tmp3, \matf3

    @ gf256_madd 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    @ str.w \tmp4, [\aj, #4*0]
    @ str.w \tmp5, [\aj, #4*1]
    @ str.w \tmp6, [\aj, #4*2]
    @ str.w \tmp7, [\aj, #4*3]

    @ ldr.w \tmp4, [\aj, #4*4]
    @ ldr.w \tmp5, [\aj, #4*5]
    ldr.w \tmp6, [\aj, #4*6]
    ldr.w \tmp7, [\aj, #4*7]

    @ vmov.w \tmp0, \matf4
    @ vmov.w \tmp1, \matf5
    vmov.w \tmp2, \matf6
    vmov.w \tmp3, \matf7

    //gf256_madd 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9
    gf256_madd 2, \tmp6, \tmp7, xxx, xxx, \tmp2, \tmp3, xxx, xxx, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9


    @ str.w \tmp4, [\aj, #4*4]
    @ str.w \tmp5, [\aj, #4*5]
    str.w \tmp6, [\aj, #4*6]
    str.w \tmp7, [\aj, #4*7]

    ldr.w \tmp4, [\aj, #4*8]
    ldr.w \tmp5, [\aj, #4*9]
    ldr.w \tmp6, [\aj, #4*10]
    ldr.w \tmp7, [\aj, #4*11]

    vmov.w \tmp0, \matf8
    vmov.w \tmp1, \matf9
    vmov.w \tmp2, \matf10
    vmov.w \tmp3, \matf11


    gf256_madd 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    str.w \tmp4, [\aj, #4*8]
    str.w \tmp5, [\aj, #4*9]
    str.w \tmp6, [\aj, #4*10]
    str.w \tmp7, [\aj, #4*11]
.endm

// computes (r8 is assumbed to be at sp+0):
// r8 &= gf256_is_nonzero(ai[i]);
// uint8_t pivot = ai[i];
// pivot = gf256_inv( pivot );
// _gf256v_mul_scalar_u32( ai  , pivot , w);
.macro invert_pivot_and_multiply ai, pivotidx, pivot, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, matf0, matf1, matf2, matf3, matf4, matf5, matf6, matf7, matf8, matf9, matf10, matf11, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7
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
    ldr.w \tmp3, [\ai, #4*11]
    gf256_mul_u32 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \matf8, \tmp4
    vmov.w \matf9, \tmp5
    vmov.w \matf10, \tmp6
    vmov.w \matf11, \tmp7
    str.w \tmp4, [\ai, #4*8]
    str.w \tmp5, [\ai, #4*9]
    str.w \tmp6, [\ai, #4*10]
    str.w \tmp7, [\ai, #4*11]
.endm


.macro invert_pivot_and_multiply_second ai, pivotidx, pivot, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, matf0, matf1, matf2, matf3, matf4, matf5, matf6, matf7, matf8, matf9, matf10, matf11, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7
    // invert ai[i]
    ldrb.w \pivot, [\ai, \pivotidx]
    ldrb.w \tmp0, [sp, #0]
    cmp.n \pivot, #0
    it eq
    moveq.w \tmp0, #0
    strb.w \tmp0, [sp, #0]


    gf256_inv \pivot, \tmp0, \tmp1, \tmp2, \tmp3, \tmp4, \tmp5, \tmp6, \tmp7
    gf256_madd_precompb \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \pivot, \c01010101, \pconst, \tmp8

    @ ldr.w \tmp0, [\ai, #4*0]
    @ ldr.w \tmp1, [\ai, #4*1]
    @ ldr.w \tmp2, [\ai, #4*2]
    @ ldr.w \tmp3, [\ai, #4*3]


    @ gf256_mul_u32 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    @ vmov.w \matf0, \tmp4
    @ vmov.w \matf1, \tmp5
    @ vmov.w \matf2, \tmp6
    @ vmov.w \matf3, \tmp7
    @ str.w \tmp4, [\ai, #4*0]
    @ str.w \tmp5, [\ai, #4*1]
    @ str.w \tmp6, [\ai, #4*2]
    @ str.w \tmp7, [\ai, #4*3]

    @ ldr.w \tmp0, [\ai, #4*4]
    @ ldr.w \tmp1, [\ai, #4*5]
    ldr.w \tmp2, [\ai, #4*6]
    ldr.w \tmp3, [\ai, #4*7]

    //gf256_mul_u32 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9
    gf256_mul_u32 2, \tmp6, \tmp7, xxx, xxx, \tmp2, \tmp3, xxx, xxx, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    @ vmov.w \matf4, \tmp4
    @ vmov.w \matf5, \tmp5
    vmov.w \matf6, \tmp6
    vmov.w \matf7, \tmp7
    @ str.w \tmp4, [\ai, #4*4]
    @ str.w \tmp5, [\ai, #4*5]
    str.w \tmp6, [\ai, #4*6]
    str.w \tmp7, [\ai, #4*7]

    ldr.w \tmp0, [\ai, #4*8]
    ldr.w \tmp1, [\ai, #4*9]
    ldr.w \tmp2, [\ai, #4*10]
    ldr.w \tmp3, [\ai, #4*11]
    gf256_mul_u32 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \matf8, \tmp4
    vmov.w \matf9, \tmp5
    vmov.w \matf10, \tmp6
    vmov.w \matf11, \tmp7
    str.w \tmp4, [\ai, #4*8]
    str.w \tmp5, [\ai, #4*9]
    str.w \tmp6, [\ai, #4*10]
    str.w \tmp7, [\ai, #4*11]
.endm

.macro conditional_add ai, ii, aj, ajmax, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7
    // for the last row, we don't have rows left to add, so we skip the inner loop
    cmp.w \ii, #43
    beq.w 2f

    add.w \aj, \ai, #48

    cmp.n \ii, #36
    ite lt
    movlt.w \ajmax, #8
    rsbge.w \ajmax, \ii, #44
    mov.w \tmp0, #48
    mla.w \ajmax, \ajmax, \tmp0, \ai

    1:
        ldrb.n \tmp0, [\ai, \ii]
        cmp.n \tmp0, #0

        # got 48/4 = 12 words to mult
        .rept 3 // 8 words
            ldr.w \tmp1, [\aj, #4*1]
            ldr.w \tmp2, [\aj, #4*2]
            ldr.w \tmp3, [\aj, #4*3]
            ldr.w \tmp0, [\aj], #16

            ldr.w \tmp4, [\ai, #4*0]
            ldr.w \tmp5, [\ai, #4*1]
            ldr.w \tmp6, [\ai, #4*2]
            ldr.w \tmp7, [\ai, #4*3]

            nop.n
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

        sub.w \ai, \ai, #48
        cmp.w \aj, \ajmax
        bne.w 1b
    2:
.endm

.global gf256mat_gauss_elim_row_echolen_m4f_44
.type gf256mat_gauss_elim_row_echolen_m4f_44, %function
.align 2
gf256mat_gauss_elim_row_echolen_m4f_44:
    push.w {r4-r11, r14}
    vpush.w {s16-s31}
    sub.w sp, sp, #4
    mov.w r14, #1
    str.w r14, [sp]

    ii .req s16
    jj .req s17
    ai .req s18

    mov.w r2, #0
    mov.w r1, r0
    mov.w r12, #0x01010101
    mov.w r14, #0x1b
    vmov.w ii, r2
    vmov.w ai, r1

    3:
        conditional_add r1, r2, r0, r3, r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r0, ii
        cmp.w r0, #24
        bge second_half
        invert_pivot_and_multiply r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r2, r0, r12, r14, s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s24, s25, s26, s27, s28, s29, s30, s31
        vmov.w r0, ii

        add.w r3, r0, #1
        vmov.w jj, r3

        1:
            add.w r1, r1, #48
            vmov.w r0, ii
            ldrb.w r2, [r1, r0]

            madd_row r2, r1, r0, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r14, s24, s25, s26, s27, s28, s29, s30, s31, s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11

            vmov r3, jj
            add.w r3, #1
            vmov jj, r3
            cmp.w r3, #44
            bne 1b

        b.w 2f
        second_half:
        invert_pivot_and_multiply_second r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r2, r0, r12, r14, s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s24, s25, s26, s27, s28, s29, s30, s31
        vmov.w r0, ii
        cmp.w r0, #43
        beq 2f

        add.w r3, r0, #1
        vmov.w jj, r3

        1:
            add.w r1, r1, #48
            vmov.w r0, ii
            ldrb.w r2, [r1, r0]

            madd_row_second r2, r1, r0, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r14, s24, s25, s26, s27, s28, s29, s30, s31, s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11

            vmov r3, jj
            add.w r3, #1
            vmov jj, r3
            cmp.w r3, #44
            bne 1b
        2:
    vmov.w r2, ii
    add.w r2, #1
    vmov.w ii, r2
    vmov.w r1, ai
    add.w r1, #48
    vmov.w ai, r1

    cmp.w r2, #44
    bne.w 3b

    ldr.w r0, [sp]
    add.w sp, sp, #4
    vpop.w {s16-s31}
    pop {r4-r11, pc}
