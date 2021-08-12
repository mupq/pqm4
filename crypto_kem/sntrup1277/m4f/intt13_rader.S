#include "rader13_macro.S"
.align
.syntax unified
.text
wpad:
    .word 545116
    .word 7879
    .word 4236115667
    .word 4207279284
    .word 4224909875
    .word 13433753
    .word 4161015477
    .word 251072126

@ [1, 2, 4, 8, 3, 6, 12, 11, 9, 5, 10, 7]
@ [6, 3, 8, 4, 2, 1, 7, 10, 5, 9, 11, 12]
.equ basesize, 216
.global intt13_rader
.type intt13_rader, %function
intt13_rader:
    push {r4-r11, lr}
    adr.w lr, wpad
    vldm lr, {s3-s10}
    vmov s0, s1, r0, r1
    add.w lr, r0, #2*basesize
    vmov s2, lr
intt13_rader_crt:
    @ ldr.w r4, [r1, #1*basesize*2]
    @ ldr.w r5, [r1, #2*basesize*2]
    @ ldr.w r6, [r1, #4*basesize*2]
    @ ldr.w r7, [r1, #8*basesize*2]
    @ ldr.w r8, [r1, #12*basesize*2]
    @ ldr.w r9, [r1, #11*basesize*2]
    @ ldr.w r10, [r1, #9*basesize*2]
    @ ldr.w r11, [r1, #5*basesize*2]

    ldr.w r4, [r1, #1*basesize*2]
    ldr.w r5, [r1, #2*basesize*2]
    ldr.w r6, [r1, #4*basesize*2]
    ldr.w r7, [r1, #8*basesize*2]
    add.w r1, r1, #10*basesize*2
    ldr.w r8, [r1, #2*basesize*2]
    ldr.w r9, [r1, #1*basesize*2]
    sub.w r1, r1, #10*basesize*2
    ldr.w r10, [r1, #9*basesize*2]
    ldr.w r11, [r1, #5*basesize*2]

    crt16x2 r3, r4, r8
    crt16x2 r4, r5, r9
    crt16x2 r5, r6, r10
    crt16x2 r6, r7, r11

    sadd16 r12, r3, r4
    sadd16 r12, r12, r5
    sadd16 r12, r12, r6

    pack16x2 r2, r3, r4
    pack16x2 r4, r5, r6
    pack16x2 r7, r8, r9
    pack16x2 r9, r10, r11

    @ str.w r2, [r0, #1*basesize*2]
    @ str.w r3, [r0, #4*basesize*2]
    @ str.w r4, [r0, #2*basesize*2]
    @ str.w r5, [r0, #5*basesize*2]
    @ str.w r7, [r0, #7*basesize*2]
    @ str.w r8, [r0, #10*basesize*2]
    @ str.w r9, [r0, #8*basesize*2]
    @ str.w r10, [r0, #11*basesize*2]

    str.w r2, [r0, #1*basesize*2]
    str.w r3, [r0, #4*basesize*2]
    str.w r4, [r0, #2*basesize*2]
    str.w r5, [r0, #5*basesize*2]
    add.w r0, r0, #6*basesize*2
    str.w r7, [r0, #1*basesize*2]
    str.w r8, [r0, #4*basesize*2]
    str.w r9, [r0, #2*basesize*2]
    str.w r10, [r0, #5*basesize*2]
    sub.w r0, r0, #6*basesize*2

    ldr.w r4, [r1, #3*basesize*2]
    ldr.w r5, [r1, #6*basesize*2]
    add.w r1, r1, #6*basesize*2
    ldr.w r6, [r1, #4*basesize*2]
    ldr.w r7, [r1, #1*basesize*2]
    sub.w r1, r1, #6*basesize*2

    crt16x2 r3, r4, r6
    crt16x2 r4, r5, r7

    sadd16 r11, r3, r4

    pack16x2 r2, r3, r4
    pack16x2 r5, r6, r7

    @ str.w r2, [r0, #3*basesize*2]
    @ str.w r3, [r0, #6*basesize*2]
    @ str.w r5, [r0, #9*basesize*2]
    @ str.w r6, [r0, #12*basesize*2]

    str.w r2, [r0, #3*basesize*2]
    str.w r3, [r0, #6*basesize*2]
    add.w r0, r0, #6*basesize*2
    str.w r5, [r0, #3*basesize*2]
    str.w r6, [r0, #6*basesize*2]
    sub.w r0, r0, #6*basesize*2

    vmov r9, r10, s3, s4
    
    sbfx r2, r11, #0, #16
    sbfx r3, r12, #0, #16
    sbfx r4, r11, #16, #16
    sbfx r5, r12, #16, #16
    add.w r2, r2, r3
    add.w r3, r4, r5
    barrett_reduce r2, r9, r10, r8
    barrett_reduce r3, r9, r10, r8
    pkhbt r2, r2, r3, lsl #16
    add.w r1, r1, #4
    str.w r2, [r0], #4
    cmp.w r0, lr
    bne.w intt13_rader_crt

    vmov r0, s0
    vmov r11, r12, s3, s4
    vmov r1, r2, s5, s6
    vmov r3, s7
intt13_rader_polymul_6x6_pos:
    ldr.w r5, [r0, #1*basesize*2]
    ldr.w r6, [r0, #2*basesize*2]
    ldr.w r7, [r0, #3*basesize*2]
    polymul_6x6_c1_positive_cyclic r8, r1, r2, r3, r5, r6, r7, r11, r12, r4
    polymul_6x6_c3_positive_cyclic r9, r1, r2, r3, r5, r6, r7, r11, r12, r4
    polymul_6x6_c5_positive_cyclic r10, r1, r2, r3, r5, r6, r7, r11, r12, r4
    permute_05_21_43 r4, r5, r6, r7
    pkhbt r7, r8, r9, lsl #16 @ c1c3
    polymul_6x6_c4_positive_cyclic r8, r1, r2, r3, r4, r5, r6, r11, r12, r9
    pkhbt r8, r8, r10, lsl #16 @ c4c5
    polymul_6x6_c0_positive_cyclic r9, r1, r2, r3, r4, r5, r6, r11, r12, r10
    polymul_6x6_c2_positive_cyclic r10, r1, r2, r3, r4, r5, r6, r11, r12, r4
    pkhbt r6, r9, r7, lsl #16 @ c0c1
    pkhbt r7, r10, r7 @ c2c3
    str.w r6, [r0, #1*basesize*2]
    str.w r7, [r0, #2*basesize*2]
    str.w r8, [r0, #3*basesize*2]

    ldr.w r5, [r0, #4*basesize*2]
    ldr.w r6, [r0, #5*basesize*2]
    ldr.w r7, [r0, #6*basesize*2]
    polymul_6x6_c1_positive_cyclic r8, r1, r2, r3, r5, r6, r7, r11, r12, r4
    polymul_6x6_c3_positive_cyclic r9, r1, r2, r3, r5, r6, r7, r11, r12, r4
    polymul_6x6_c5_positive_cyclic r10, r1, r2, r3, r5, r6, r7, r11, r12, r4
    permute_05_21_43 r4, r5, r6, r7
    pkhbt r7, r8, r9, lsl #16 @ c1c3
    polymul_6x6_c4_positive_cyclic r8, r1, r2, r3, r4, r5, r6, r11, r12, r9
    pkhbt r8, r8, r10, lsl #16 @ c4c5
    polymul_6x6_c0_positive_cyclic r9, r1, r2, r3, r4, r5, r6, r11, r12, r10
    polymul_6x6_c2_positive_cyclic r10, r1, r2, r3, r4, r5, r6, r11, r12, r4
    pkhbt r6, r9, r7, lsl #16 @ c0c1
    pkhbt r7, r10, r7 @ c2c3
    str.w r6, [r0, #4*basesize*2]
    str.w r7, [r0, #5*basesize*2]
    str.w r8, [r0, #6*basesize*2]

    add.w r0, r0, #4
    cmp.w r0, lr
    bne.w intt13_rader_polymul_6x6_pos

    vmov r0, s0
    vmov r1, r2, s8, s9
    vmov r3, s10
intt13_rader_polymul_6x6_neg:
    add.w r0, r0, #6*basesize*2
    ldr.w r5, [r0, #1*basesize*2]
    ldr.w r6, [r0, #2*basesize*2]
    ldr.w r7, [r0, #3*basesize*2]
    polymul_6x6_c1_negative_cyclic r8, r1, r2, r3, r5, r6, r7, r11, r12, r4
    polymul_6x6_c3_negative_cyclic r9, r1, r2, r3, r5, r6, r7, r11, r12, r4
    polymul_6x6_c5_negative_cyclic r10, r1, r2, r3, r5, r6, r7, r11, r12, r4
    permute_05_21_43 r4, r5, r6, r7
    pkhbt r7, r8, r9, lsl #16 @ c1c3
    polymul_6x6_c4_negative_cyclic r8, r1, r2, r3, r4, r5, r6, r11, r12, r9
    pkhbt r8, r8, r10, lsl #16 @ c4c5
    str.w r8, [r0, #3*basesize*2]
    polymul_6x6_c0_negative_cyclic r9, r1, r2, r3, r4, r5, r6, r11, r12, r10
    polymul_6x6_c2_negative_cyclic r10, r1, r2, r3, r4, r5, r6, r11, r12, r8
    pkhbt r6, r9, r7, lsl #16 @ c0c1
    pkhbt r7, r10, r7 @ c2c3
    str.w r6, [r0, #1*basesize*2]
    str.w r7, [r0, #2*basesize*2]

    @ ldr.w r5, [r0, #10*basesize*2]
    @ ldr.w r6, [r0, #11*basesize*2]
    @ ldr.w r7, [r0, #12*basesize*2]
    @ polymul_6x6_c1_negative_cyclic r8, r1, r2, r3, r5, r6, r7, r11, r12, r4
    @ polymul_6x6_c3_negative_cyclic r9, r1, r2, r3, r5, r6, r7, r11, r12, r4
    @ polymul_6x6_c5_negative_cyclic r10, r1, r2, r3, r5, r6, r7, r11, r12, r4
    @ permute_05_21_43 r4, r5, r6, r7
    @ pkhbt r7, r8, r9, lsl #16 @ c1c3
    @ polymul_6x6_c4_negative_cyclic r8, r1, r2, r3, r4, r5, r6, r11, r12, r9
    @ pkhbt r8, r8, r10, lsl #16 @ c4c5
    @ str.w r8, [r0, #12*basesize*2]
    @ polymul_6x6_c0_negative_cyclic r9, r1, r2, r3, r4, r5, r6, r11, r12, r10
    @ polymul_6x6_c2_negative_cyclic r10, r1, r2, r3, r4, r5, r6, r11, r12, r8
    @ pkhbt r6, r9, r7, lsl #16 @ c0c1
    @ pkhbt r7, r10, r7 @ c2c3
    @ str.w r6, [r0, #10*basesize*2]
    @ str.w r7, [r0, #11*basesize*2]

    ldr.w r5, [r0, #4*basesize*2]
    ldr.w r6, [r0, #5*basesize*2]
    ldr.w r7, [r0, #6*basesize*2]
    polymul_6x6_c1_negative_cyclic r8, r1, r2, r3, r5, r6, r7, r11, r12, r4
    polymul_6x6_c3_negative_cyclic r9, r1, r2, r3, r5, r6, r7, r11, r12, r4
    polymul_6x6_c5_negative_cyclic r10, r1, r2, r3, r5, r6, r7, r11, r12, r4
    permute_05_21_43 r4, r5, r6, r7
    pkhbt r7, r8, r9, lsl #16 @ c1c3
    polymul_6x6_c4_negative_cyclic r8, r1, r2, r3, r4, r5, r6, r11, r12, r9
    pkhbt r8, r8, r10, lsl #16 @ c4c5
    str.w r8, [r0, #6*basesize*2]
    polymul_6x6_c0_negative_cyclic r9, r1, r2, r3, r4, r5, r6, r11, r12, r10
    polymul_6x6_c2_negative_cyclic r10, r1, r2, r3, r4, r5, r6, r11, r12, r8
    pkhbt r6, r9, r7, lsl #16 @ c0c1
    pkhbt r7, r10, r7 @ c2c3
    str.w r6, [r0, #4*basesize*2]
    str.w r7, [r0, #5*basesize*2]
    sub.w r0, r0, #6*basesize*2

    add.w r0, r0, #4
    cmp.w r0, lr
    bne.w intt13_rader_polymul_6x6_neg

@ [6, 3, 8, 4, 2, 1, 7, 10, 5, 9, 11, 12]
    vmov r0, r1, s0, s1
intt13_rader_crt_output:
    @ ldr.w r2, [r1], #4
    @ ldr.w r5, [r0, #1*basesize*2]
    @ ldr.w r6, [r0, #4*basesize*2]
    @ ldr.w r7, [r0, #2*basesize*2]
    @ ldr.w r8, [r0, #5*basesize*2]
    @ ldr.w r9, [r0, #7*basesize*2]
    @ ldr.w r10, [r0, #10*basesize*2]
    @ ldr.w r11, [r0, #8*basesize*2]
    @ ldr.w r12, [r0, #11*basesize*2]

    ldr.w r2, [r1], #4
    vmov r11, r12, s3, s4
    mov.w r10, #7778
    smulbb r3, r10, r2
    smulbt r4, r10, r2
    barrett_reduce r3, r11, r12, r5
    barrett_reduce r4, r11, r12, r5
    pkhbt r2, r3, r4, lsl #16

    ldr.w r5, [r0, #1*basesize*2]
    ldr.w r6, [r0, #4*basesize*2]
    ldr.w r7, [r0, #2*basesize*2]
    ldr.w r8, [r0, #5*basesize*2]
    add.w r0, r0, #6*basesize*2
    ldr.w r9, [r0, #1*basesize*2]
    ldr.w r10, [r0, #4*basesize*2]
    ldr.w r11, [r0, #2*basesize*2]
    ldr.w r12, [r0, #5*basesize*2]
    sub.w r0, r0, #6*basesize*2


    pack16x2 r4, r5, r6
    pack16x2 r6, r7, r8
    pack16x2 r8, r9, r10
    pack16x2 r10, r11, r12

    crt16x2 r3, r4, r8
    crt16x2 r4, r5, r9
    crt16x2 r5, r6, r10
    crt16x2 r6, r7, r11

    sadd16 r3, r3, r2
    sadd16 r4, r4, r2
    sadd16 r5, r5, r2
    sadd16 r6, r6, r2
    sadd16 r8, r8, r2
    sadd16 r9, r9, r2
    sadd16 r10, r10, r2
    sadd16 r11, r11, r2

    str.w r5, [r0, #8*basesize*2]
    str.w r6, [r0, #4*basesize*2]
    add.w r0, r0, #6*basesize*2
    str.w r8, [r0, #1*basesize*2]
    str.w r9, [r0, #4*basesize*2]
    sub.w r0, r0, #6*basesize*2
    str.w r10, [r0, #5*basesize*2]
    
    @ ldr.w r7, [r0, #3*basesize*2]
    @ ldr.w r8, [r0, #6*basesize*2]
    @ ldr.w r9, [r0, #9*basesize*2]
    @ ldr.w r10, [r0, #12*basesize*2]

    ldr.w r7, [r0, #3*basesize*2]
    ldr.w r8, [r0, #6*basesize*2]
    ldr.w r9, [r0, #9*basesize*2]
    add.w r0, r0, #10*basesize*2
    ldr.w r10, [r0, #2*basesize*2]
    sub.w r0, r0, #10*basesize*2

    pack16x2 r6, r7, r8
    pack16x2 r8, r9, r10

    crt16x2 r5, r6, r8
    crt16x2 r6, r7, r9

    sadd16 r5, r5, r2
    sadd16 r6, r6, r2
    sadd16 r8, r8, r2
    sadd16 r9, r9, r2

    str.w r3, [r0, #6*basesize*2]
    str.w r4, [r0, #3*basesize*2]
    str.w r11, [r0, #9*basesize*2]

    @ str.w r5, [r0, #2*basesize*2]
    @ str.w r6, [r0, #1*basesize*2]
    @ str.w r8, [r0, #11*basesize*2]
    @ str.w r9, [r0, #12*basesize*2]

    str.w r5, [r0, #2*basesize*2]
    str.w r6, [r0, #1*basesize*2]
    add.w r0, r0, #10*basesize*2
    str.w r8, [r0, #1*basesize*2]
    str.w r9, [r0, #2*basesize*2]
    sub.w r0, r0, #10*basesize*2

    ldr.w r3, [r0]
    vmov r11, r12, s3, s4
    mov.w r10, #7778
    smulbb r4, r10, r3
    smulbt r5, r10, r3
    barrett_reduce r4, r11, r12, r6
    barrett_reduce r5, r11, r12, r6
    pkhbt r3, r4, r5, lsl #16
    sadd16 r3, r3, r2
    str.w r3, [r0], #4

    cmp.w r0, lr
    bne.w intt13_rader_crt_output
    pop {r4-r11, pc}