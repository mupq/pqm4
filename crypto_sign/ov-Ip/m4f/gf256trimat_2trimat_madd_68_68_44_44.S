.syntax unified
.cpu cortex-m4
.thumb

#include "gf256_madd.i"

.macro madd_44 accf0, accf1, accf2, accf3, accf4, accf5, accf6, accf7, accf8, accf9, accf10, matptr, bb, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, c01010101, pconst, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7

    gf256_madd_precompb \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \bb, \c01010101, \pconst, \tmp8

    ldr.w \tmp1, [\matptr, #4*1]
    ldr.w \tmp2, [\matptr, #4*2]
    ldr.w \tmp3, [\matptr, #4*3]
    ldr.w \tmp0, [\matptr], #16

    vmov.w \tmp4, \accf0
    vmov.w \tmp5, \accf1
    vmov.w \tmp6, \accf2
    vmov.w \tmp7, \accf3

    gf256_madd 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \accf0, \tmp4
    vmov.w \accf1, \tmp5
    vmov.w \accf2, \tmp6
    vmov.w \accf3, \tmp7


    ldr.w \tmp1, [\matptr, #4*1]
    ldr.w \tmp2, [\matptr, #4*2]
    ldr.w \tmp3, [\matptr, #4*3]
    ldr.w \tmp0, [\matptr], #16


    vmov.w \tmp4, \accf4
    vmov.w \tmp5, \accf5
    vmov.w \tmp6, \accf6
    vmov.w \tmp7, \accf7

    gf256_madd 4, \tmp4, \tmp5, \tmp6, \tmp7, \tmp0, \tmp1, \tmp2, \tmp3, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \accf4, \tmp4
    vmov.w \accf5, \tmp5
    vmov.w \accf6, \tmp6
    vmov.w \accf7, \tmp7


    ldr.w \tmp1, [\matptr, #4*1]
    ldr.w \tmp2, [\matptr, #4*2]
    ldr.w \tmp0, [\matptr], #12

    vmov.w \tmp4, \accf8
    vmov.w \tmp5, \accf9
    vmov.w \tmp6, \accf10

    gf256_madd 3, \tmp4, \tmp5, \tmp6, xxx, \tmp0, \tmp1, \tmp2, xxx, \fbx0, \fbx1, \fbx2, \fbx3, \fbx4, \fbx5, \fbx6, \fbx7, \c01010101, \tmp8, \tmp9

    vmov.w \accf8, \tmp4
    vmov.w \accf9, \tmp5
    vmov.w \accf10, \tmp6
.endm



//void gf256trimat_2trimat_madd_m4f_68_68_44_44(uint32_t *c, uint32_t *a, uint8_t *b);
.global gf256trimat_2trimat_madd_m4f_68_68_44_44
.type gf256trimat_2trimat_madd_m4f_68_68_44_44, %function
.align 2
gf256trimat_2trimat_madd_m4f_68_68_44_44:
    push.w {r4-r11, r14}
    vpush.w {s16-s27}

    cc .req r0
    aa .req r1
    bb .req r2


    tmp1 .req r3
    tmp2 .req r0
    c01010101 .req r12
    pconst .req r14

    mov.w c01010101, #0x01010101
    mov.w pconst, #0x1b

    accf0 .req s0
    accf1 .req s1
    accf2 .req s2
    accf3 .req s3
    accf4 .req s4
    accf5 .req s5
    accf6 .req s6
    accf7 .req s7
    accf8 .req s8
    accf9 .req s9
    accf10 .req s10

    matf0 .req s11
    matf1 .req s12
    matf2 .req s13
    matf3 .req s14
    matf4 .req s15
    matf5 .req s16
    matf6 .req s17
    matf7 .req s18

    ccf   .req s19
    aaf   .req s20
    bbbf  .req s21
    iii   .req s22
    maxaa .req s23
    kkk   .req s23
    maxbb .req s24

    origAA .req s25
    origBB  .req s26
    incrAA .req s27

    mov.w tmp1, #0
    vmov.w iii, tmp1
    vmov.w ccf, cc
    vmov.w origAA, aa
    vmov.w origBB, bb

    4:
    vmov.w aa, origAA
    vmov.w bbbf, origBB

    // aa = aa + size_batch*((Aheight + Aheight - i + 1 )*i/2 + 1);
    vmov.w tmp1, iii
    rsb.w tmp2, tmp1, #68+68+1
    mul.w tmp2, tmp1, tmp2
    asr.w tmp2, tmp2, #1
    add.w tmp2, #1
    mov.w tmp1, #44
    mla.w aa, tmp1, tmp2, aa

    vmov.w aaf, aa
    vmov.w bb, bbbf

    # maxbb = B+ 44*68
    add.w tmp1, bb, #44*68
    vmov.w maxbb, tmp1
    3:

    vmov.w cc, ccf
    vldr.w accf0, [cc, #4*0]
    vldr.w accf1, [cc, #4*1]
    vldr.w accf2, [cc, #4*2]
    vldr.w accf3, [cc, #4*3]
    vldr.w accf4, [cc, #4*4]
    vldr.w accf5, [cc, #4*5]
    vldr.w accf6, [cc, #4*6]
    vldr.w accf7, [cc, #4*7]
    vldr.w accf8, [cc, #4*8]
    vldr.w accf9, [cc, #4*9]
    vldr.w accf10, [cc, #4*10]

    vmov.w tmp1, iii
    cmp.w tmp1, #0
    beq.w skip_first


    // for(unsigned k=0;k<i;k++)
    vmov.w aa, origAA
    mov.w tmp2, #44
    mla.w aa, tmp1, tmp2, aa
    vmov.w kkk, iii

    mov.w tmp1, #(68-2)*44
    vmov.w incrAA, tmp1
    1:
        vmov.w tmp1, bbbf
        ldrb.w bb, [tmp1], #1
        vmov.w bbbf, tmp1

        madd_44 accf0, accf1, accf2, accf3, accf4, accf5, accf6, accf7, accf8, accf9, accf10, aa, bb, r4, r5, r6, r7, r8, r9, r10, r11, tmp1, tmp2, c01010101, pconst, matf0, matf1, matf2, matf3, matf4, matf5, matf6, matf7

        vmov.w tmp1, incrAA
        add.w aa, aa, tmp1
        sub.w tmp1, tmp1, #44
        vmov.w incrAA, tmp1

        vmov.w tmp1, kkk
        subs.w tmp1, tmp1, #1
        vmov.w kkk, tmp1
        bne.w 1b

    skip_first:

    // increment bb pointer
    vmov.w tmp2, bbbf
    add.w tmp2, #1
    vmov.w bbbf, tmp2

    // check if i==67
    vmov.w tmp1, iii
    cmp.w tmp1, #67
    beq.w skip_second

    vmov.w aa, aaf
    // for(unsigned k=i+1;k<Aheight;k++)
    mov.w tmp2, #44
    rsb.w tmp1, tmp1, #68-1
    mla.w tmp1, tmp1, tmp2, aa
    vmov.w maxaa, tmp1

    2:
        vmov.w tmp1, bbbf
        ldrb.w bb, [tmp1], #1
        vmov.w bbbf, tmp1

        madd_44 accf0, accf1, accf2, accf3, accf4, accf5, accf6, accf7, accf8, accf9, accf10, aa, bb, r4, r5, r6, r7, r8, r9, r10, r11, tmp1, tmp2, c01010101, pconst, matf0, matf1, matf2, matf3, matf4, matf5, matf6, matf7

        vmov.w tmp1, maxaa
        cmp.w tmp1, aa
        bne.w 2b

    skip_second:

    vmov.w cc, ccf
    vstr.w accf0, [cc, #4*0]
    vstr.w accf1, [cc, #4*1]
    vstr.w accf2, [cc, #4*2]
    vstr.w accf3, [cc, #4*3]
    vstr.w accf4, [cc, #4*4]
    vstr.w accf5, [cc, #4*5]
    vstr.w accf6, [cc, #4*6]
    vstr.w accf7, [cc, #4*7]
    vstr.w accf8, [cc, #4*8]
    vstr.w accf9, [cc, #4*9]
    vstr.w accf10, [cc, #4*10]


    // increment cc
    add.w cc, #44
    vmov.w ccf, cc

    vmov.w tmp1, bbbf
    vmov.w tmp2, maxbb
    cmp.w tmp1, tmp2
    bne.w 3b

    vmov.w tmp1, iii
    add.w tmp1, #1
    vmov.w iii, tmp1
    cmp.w tmp1, #68
    bne.w 4b

    vpop.w {s16-s27}
    pop.w {r4-r11, pc}