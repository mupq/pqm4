.syntax unified
.cpu cortex-m4
.thumb


#include "gf256_madd.i"
.macro gf256_mul res, bb, aa0, pconst, tmp1, tmp2
    mov.w \tmp2, #0x01010101
    # bit 0
    ubfx.w \tmp1, \bb, #0, #1
    mul.w  \res, \aa0, \tmp1


    # bit 1-7
    .set k, 1
    .rept 7
        // 7 cycles
        and.w \tmp1, \tmp2, \aa0, lsr #7
        eor.w \aa0, \aa0, \tmp1, lsl #7

        mul.w \tmp1, \tmp1, \pconst
        eor.w \aa0, \tmp1, \aa0, lsl#1

        ubfx.w \tmp1, \bb, #k, #1

        mul.w \tmp1, \aa0, \tmp1
        eor.w \res, \res, \tmp1
    .set k, k+1
    .endr
.endm

.macro process_Px outerdim, triangular, innerdim
    mov.w ctrouter, \outerdim
    1:
        ldrb.w xi, [xptr], #1
        cmp.w xi, #0
        beq.w 6f
        vmov.w s0, ctrouter
        .if \triangular == 1
        mov.w ctrinner, ctrouter
        sub.w xptr2, xptr, #1
        .else
        mov.w ctrinner, \innerdim
        vmov.w xptr2, xptr_orig
        add.w xptr2, \outerdim
        .endif

        2:

            @ if ctrinner >= 4
            cmp.w ctrinner, #4
            blt.w 3f

            ldr.w xj, [xptr2], #4
            gf256_mul tmp, xi, xj, c1b, tmp3, tmp4

            .set k, 0
            .rept 4
                // low
                ubfx.w tmp3, tmp, #k*8, #4
                add.w tmp2, low, tmp3, lsl#6

                .set i,0
                .rept 44/8
                ldr.w tmp3,  [tmp2]
                ldr.w tmp4,  [tmp2, #4]
                ldr.w tmp5, [mat, #i*8]
                ldr.w tmp6, [mat, #i*8+4]
                eor.w tmp3, tmp3, tmp5
                eor.w tmp4, tmp4, tmp6
                str.w tmp3, [tmp2], #4
                str.w tmp4, [tmp2], #4
                .set i, i+1
                .endr
                ldr.w tmp3,  [tmp2]
                ldr.w tmp5, [mat, #40]
                eor.w tmp3, tmp3, tmp5
                str.w tmp3, [tmp2]

                // high
                ubfx.w tmp3, tmp, #k*8+4, #4
                add.w tmp2, high, tmp3, lsl#6
                .rept 44/8
                ldr.w tmp3,  [tmp2]
                ldr.w tmp4,  [tmp2, #4]
                ldr.w tmp5, [mat], #4
                ldr.w tmp6, [mat], #4
                eor.w tmp3, tmp3, tmp5
                eor.w tmp4, tmp4, tmp6
                str.w tmp3, [tmp2], #4
                str.w tmp4, [tmp2], #4
                .endr
                ldr.w tmp3,  [tmp2]
                ldr.w tmp5, [mat], #4
                eor.w tmp3, tmp3, tmp5
                str.w tmp3, [tmp2]
                .set k,k+1
            .endr
            subs.w ctrinner, ctrinner, #4
            bne.w 2b
            b.w 4f
            @ else
            3:
            ldrb.w xj, [xptr2], #1

            gf256_mul tmp, xi, xj, c1b, tmp3, tmp4

            // low
            and.w tmp3, tmp, #0xF
            add.w tmp2, low, tmp3, lsl#6
            .set i,0
            .rept 44/8
            ldr.w tmp3,  [tmp2]
            ldr.w tmp4,  [tmp2, #4]
            ldr.w tmp5, [mat, #i*8]
            ldr.w tmp6, [mat, #i*8+4]
            eor.w tmp3, tmp3, tmp5
            eor.w tmp4, tmp4, tmp6
            str.w tmp3, [tmp2], #4
            str.w tmp4, [tmp2], #4
            .set i, i+1
            .endr
            ldr.w tmp3,  [tmp2]
            ldr.w tmp5, [mat, #40]
            eor.w tmp3, tmp3, tmp5
            str.w tmp3, [tmp2]

            // high
            ubfx.w tmp3, tmp, #4, #4
            add.w tmp2, high, tmp3, lsl#6
            .rept 44/8
            ldr.w tmp3,  [tmp2]
            ldr.w tmp4,  [tmp2, #4]
            ldr.w tmp5, [mat], #4
            ldr.w tmp6, [mat], #4
            eor.w tmp3, tmp3, tmp5
            eor.w tmp4, tmp4, tmp6
            str.w tmp3, [tmp2], #4
            str.w tmp4, [tmp2], #4
            .endr
            ldr.w tmp3,  [tmp2]
            ldr.w tmp5, [mat], #4
            eor.w tmp3, tmp3, tmp5
            str.w tmp3, [tmp2]
            subs.w ctrinner, ctrinner, #1
            bne.w 2b
        4:
        vmov.w ctrouter, s0
        subs.w ctrouter, ctrouter, #1
        bne.w 1b
        b.w 5f

        6:
        .if \triangular == 1
        mov.w tmp, #44
        mla.w mat, tmp, ctrouter, mat
        .else
        add.w mat, mat, #44*44
        .endif
		subs.w ctrouter, ctrouter, #1
		bne.w 1b
    5:
.endm

//void gf256trimat_eval_m4f_112_44_publicinputs(uint32_t *c, uint32_t *a, uint8_t *b);
.global gf256trimat_eval_m4f_112_44_publicinputs
.type gf256trimat_eval_m4f_112_44_publicinputs, %function
.align 2
gf256trimat_eval_m4f_112_44_publicinputs:
    push.w {r4-r11, r14}
    vpush.w {s16-s31}

    low  .req r0
    high .req r3
    mat  .req r1
    xptr .req r2
    xptr2 .req r10
    xi   .req r4
    xj   .req r5

    tmp .req r6
    tmp2 .req r7
    tmp3 .req r8
    tmp4 .req r9
    tmp5 .req r5
    tmp6 .req r14


    c1b .req r11

    ctrinner .req r12
    ctrouter .req r14

    outputf .req s16
    lowf .req s17
    highf .req s18
    xptr_orig .req s19

    vmov.w xptr_orig, xptr
    vmov.w outputf, r0
    sub.w sp, sp, #2*16*64
    mov.w low, sp
    add.w high, sp, #16*64
    vmov.w lowf, low
    vmov.w highf, high

    push {r0-r3}
    mov.w r1, #0
    mov.w r2, #2*16*64
    bl memset
    pop {r0-r3}


    mov.w c1b, #0x1b


    # P1 (triangular)
    process_Px 68, 1, xxx

    # P2 (square)
    vmov.w xptr, xptr_orig
    process_Px 68, 0, 44

    # P3 (triangular)
    vmov.w xptr, xptr_orig
    add.w xptr, #68
    process_Px 44, 1, xxx

    b madd_reduce_gf256




.macro load_accumulate first, src, incr, t0, t1, t2, t3, t4, t5, t6, t7, tmp, acc0, acc1, acc2, acc3, acc4, acc5, acc6, acc7, acc8, acc9, acc10
    .if \first == 1
        vldr.w \acc0, [\src, #0*4]
        vldr.w \acc1, [\src, #1*4]
        vldr.w \acc2, [\src, #2*4]
        vldr.w \acc3, [\src, #3*4]
        vldr.w \acc4, [\src, #4*4]
        vldr.w \acc5, [\src, #5*4]
        vldr.w \acc6, [\src, #6*4]
        vldr.w \acc7, [\src, #7*4]
        vldr.w \acc8, [\src, #8*4]
        vldr.w \acc9, [\src, #9*4]
        vldr.w \acc10, [\src, #10*4]
        add.w \src, \src, \incr
    .else


    ldr.w \t0, [\src, #8*4]
    ldr.w \t1, [\src, #9*4]
    ldr.w \t2, [\src, #10*4]

    vmov.w \tmp, \acc8
    eor.w \tmp, \t0
    vmov.w \acc8, \tmp

    vmov.w \tmp, \acc9
    eor.w \tmp, \t1
    vmov.w \acc9, \tmp

    vmov.w \tmp, \acc10
    eor.w \tmp, \t2
    vmov.w \acc10, \tmp


    ldr.w \t1, [\src, #1*4]
    ldr.w \t2, [\src, #2*4]
    ldr.w \t3, [\src, #3*4]
    ldr.w \t4, [\src, #4*4]
    ldr.w \t5, [\src, #5*4]
    ldr.w \t6, [\src, #6*4]
    ldr.w \t7, [\src, #7*4]
    .if \incr < 256
    ldr.w \t0, [\src], #\incr
    .else
    ldr.w \t0, [\src]
    add.w \src, \incr
    .endif

    vmov.w \tmp, \acc0
    eor.w \tmp, \t0
    vmov.w \acc0, \tmp

    vmov.w \tmp, \acc1
    eor.w \tmp, \t1
    vmov.w \acc1, \tmp

    vmov.w \tmp, \acc2
    eor.w \tmp, \t2
    vmov.w \acc2, \tmp

    vmov.w \tmp, \acc3
    eor.w \tmp, \t3
    vmov.w \acc3, \tmp

    vmov.w \tmp, \acc4
    eor.w \tmp, \t4
    vmov.w \acc4, \tmp

    vmov.w \tmp, \acc5
    eor.w \tmp, \t5
    vmov.w \acc5, \tmp

    vmov.w \tmp, \acc6
    eor.w \tmp, \t6
    vmov.w \acc6, \tmp

    vmov.w \tmp, \acc7
    eor.w \tmp, \t7
    vmov.w \acc7, \tmp

    .endif
.endm


.macro mult tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, bb, acc0, acc1, acc2, acc3, acc4, acc5, acc6, acc7, acc8, acc9, acc10, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7
    gf256_madd_precompb \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \bb, \c01010101, \pconst, \tmp8

    vmov.w \tmp0, \tt0
    vmov.w \tmp1, \tt1
    vmov.w \tmp2, \tt2
    vmov.w \tmp3, \tt3

    vmov.w \tmp4, \acc0
    vmov.w \tmp5, \acc1
    vmov.w \tmp6, \acc2
    vmov.w \tmp7, \acc3

    gf256_madd 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \acc0, \tmp4
    vmov.w \acc1, \tmp5
    vmov.w \acc2, \tmp6
    vmov.w \acc3, \tmp7

    vmov.w \tmp0, \tt4
    vmov.w \tmp1, \tt5
    vmov.w \tmp2, \tt6
    vmov.w \tmp3, \tt7

    vmov.w \tmp4, \acc4
    vmov.w \tmp5, \acc5
    vmov.w \tmp6, \acc6
    vmov.w \tmp7, \acc7

    gf256_madd 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \acc4, \tmp4
    vmov.w \acc5, \tmp5
    vmov.w \acc6, \tmp6
    vmov.w \acc7, \tmp7

    vmov.w \tmp0, \tt8
    vmov.w \tmp1, \tt9
    vmov.w \tmp2, \tt10

    vmov.w \tmp4, \acc8
    vmov.w \tmp5, \acc9
    vmov.w \tmp6, \acc10

    gf256_madd 3, \tmp4, \tmp5, \tmp6, xxx, \tmp0, \tmp1, \tmp2, xxx, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \acc8, \tmp4
    vmov.w \acc9, \tmp5
    vmov.w \acc10, \tmp6
.endm


.align 2
madd_reduce_gf256:
    vmov.w r0, outputf
    vmov.w r1, lowf
    vmov.w r2, highf
    .unreq low
    .unreq high
    .unreq mat
    .unreq xptr
    .unreq xi
    .unreq xj

    .unreq tmp
    .unreq tmp2
    .unreq tmp3
    .unreq tmp4
    .unreq tmp5
    .unreq tmp6
    .unreq c1b
    .unreq ctrinner
    .unreq ctrouter
    .unreq outputf
    //TODO: unifty
    .unreq lowf
    .unreq highf

    tmpy .req r0
    lowhigh .req r1
    lowf  .req s30
    highf .req s31


    tmp0 .req r4
    tmp1 .req r5
    tmp2 .req r6
    tmp3 .req r7
    tmp4 .req r8
    tmp5 .req r9
    tmp6 .req r10
    tmp7 .req r11
    tmp8 .req r1
    tmp9 .req r2
    c01010101 .req r3
    pconst .req r14
    tmp .req r12

    yy0 .req s0
    yy1 .req s1
    yy2 .req s2
    yy3 .req s3
    yy4 .req s4
    yy5 .req s5
    yy6 .req s6
    yy7 .req s7 
    yy8 .req s8 
    yy9 .req s9 
    yy10 .req s10

    tt0 .req s11
    tt1 .req s12
    tt2 .req s13
    tt3 .req s14
    tt4 .req s15
    tt5 .req s16
    tt6 .req s17
    tt7 .req s18
    tt8 .req s19
    tt9 .req s20
    tt10 .req s21

    fbx0 .req s22
    fbx1 .req s23
    fbx2 .req s24
    fbx3 .req s25
    fbx4 .req s26
    fbx5 .req s27
    fbx6 .req s28
    fbx7 .req s29


    vmov.w lowf, r1
    vmov.w highf, r2

    mov.w c01010101, #0x01010101
    mov.w pconst, #0x1b

    // x^0
    add.w lowhigh, #64
    .set first, 1
    .rept 8
    load_accumulate first, lowhigh, 64*2, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, yy0, yy1, yy2, yy3, yy4, yy5, yy6, yy7, yy8, yy9, yy10
    .set first, 0
    .endr

    // TODO: this can be done much faster; but does not matter much
    // x^1
    vmov.w lowhigh, lowf
    add.w lowhigh, #2*64
    .set first, 1
    .rept 4
        load_accumulate first, lowhigh, 64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
        .set first, 0
        load_accumulate 0, lowhigh, 3*64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
    .endr
    // acc += tmp*x^1
    mov.w tmp, #2
    mult tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, tmp, yy0, yy1, yy2, yy3, yy4, yy5, yy6, yy7, yy8, yy9, yy10, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7


    // x^2
    vmov.w lowhigh, lowf
    add.w lowhigh, #4*64
    .set first, 1
    .rept 2
        .rept 3
        load_accumulate first, lowhigh, 64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
        .set first, 0
        .endr
        load_accumulate 0, lowhigh, 5*64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
    .endr

    // acc += tmp*x^2
    mov.w tmp, #4
    mult tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, tmp,  yy0, yy1, yy2, yy3, yy4, yy5, yy6, yy7, yy8, yy9, yy10, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7

    // x^3
    vmov.w lowhigh, lowf
    add.w lowhigh, #8*64
    .set first, 1
    .rept 1
        .rept 7
        load_accumulate first, lowhigh, 64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
        .set first, 0
        .endr
        load_accumulate 0, lowhigh, 9*64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
    .endr

    // acc += tmp*x^3
    mov.w tmp, #8
    mult tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, tmp,  yy0, yy1, yy2, yy3, yy4, yy5, yy6, yy7, yy8, yy9, yy10, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7


    // x^4
    vmov.w lowhigh, highf
    add.w lowhigh, #64
    .set first, 1
    .rept 8
        load_accumulate first, lowhigh, 2*64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
        .set first, 0
    .endr
    // acc += tmp*x^4
    mov.w tmp, #16
    mult tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, tmp,  yy0, yy1, yy2, yy3, yy4, yy5, yy6, yy7, yy8, yy9, yy10, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7

    // x^5
    vmov.w lowhigh, highf
    add.w lowhigh, #2*64
    .set first, 1
    .rept 4
        load_accumulate first, lowhigh, 64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
        .set first, 0
        load_accumulate 0, lowhigh, 3*64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
    .endr
    // acc += tmp*x^5
    mov.w tmp, #32
    mult tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, tmp,  yy0, yy1, yy2, yy3, yy4, yy5, yy6, yy7, yy8, yy9, yy10, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7

    // x^6
    vmov.w lowhigh, highf
    add.w lowhigh, #4*64
    .set first, 1
    .rept 2
        .rept 3
        load_accumulate first, lowhigh, 64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
        .set first, 0
        .endr
        load_accumulate 0, lowhigh, 5*64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
    .endr

    // acc += tmp*x^6
    mov.w tmp, #64
    mult tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, tmp,  yy0, yy1, yy2, yy3, yy4, yy5, yy6, yy7, yy8, yy9, yy10, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7



    // x^7
    vmov.w lowhigh, highf
    add.w lowhigh, #8*64
    .set first, 1
    .rept 1
        .rept 7
        load_accumulate first, lowhigh, 64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
        .set first, 0
        .endr
        load_accumulate 0, lowhigh, 9*64, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10
    .endr

    // acc += tmp*x^7
    mov.w tmp, #128
    mult tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, tmp, yy0, yy1, yy2, yy3, yy4, yy5, yy6, yy7, yy8, yy9, yy10, tt0, tt1, tt2, tt3, tt4, tt5, tt6, tt7, tt8, tt9, tt10, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7

    vstr.w yy0, [tmpy, #0*4]
    vstr.w yy1, [tmpy, #1*4]
    vstr.w yy2, [tmpy, #2*4]
    vstr.w yy3, [tmpy, #3*4]
    vstr.w yy4, [tmpy, #4*4]
    vstr.w yy5, [tmpy, #5*4]
    vstr.w yy6, [tmpy, #6*4]
    vstr.w yy7, [tmpy, #7*4]
    vstr.w yy8, [tmpy, #8*4]
    vstr.w yy9, [tmpy, #9*4]
    vstr.w yy10,[tmpy, #10*4]

    add.w sp, sp, #2*16*64
    vpop.w {s16-s31}
    pop.w {r4-r11, pc}