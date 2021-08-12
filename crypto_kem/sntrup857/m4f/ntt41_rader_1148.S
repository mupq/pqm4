#include "rader41_macro.S"
.p2align 2,,3
.syntax unified
.text
wpad:
    .word 338644273 @ qinv / q for montgomery reduce
    .word 4158518883
    .word 160103496
    .word 4181327661
    .word 47054397
    .word 4219076451
    .word 98368342
    .word 4254203283
    .word 4163761733
    .word 159318154
    .word 4149020504
    .word 96205454
    .word 119668645
    .word 4200660493
    .word 16122461
    .word 25231841
    .word 133826301
    .word 4195418889
    .word 4216455116
    .word 164035027
    .word 17301173
    .word 4186309003
    .word 20054702
    .word 165739993
    .word 4136500272
    .word 42467478

@ need 51 * basesize * sizeof(int16_t) space
@f_seq = 
@[1, 6, 36, 11, 25, 27, 39, 29, 10, 19, 32, 28, 4, 24, 21, 3, 18, 26, 33, 34, 
@ 40, 35, 5, 30, 16, 14, 2, 12, 31, 22, 9, 13, 37, 17, 20, 38, 23, 15, 8, 7]
@w_seq = 
@[34, 33, 26, 18, 3, 21, 24, 4, 28, 32, 19, 10, 29, 39, 27, 25, 11, 36, 6, 1, 
@ 7, 8, 15, 23, 38, 20, 17, 37, 13, 9, 22, 31, 12, 2, 14, 16, 30, 5, 35, 40]
.equ basesize, 28
.global ntt41_rader_1148
.type ntt41_rader_1148, %function
ntt41_rader_1148:
    push {r4-r11, lr}
    vpush {s16}
    vmov s16, r0
    adr.w lr, wpad
    ldr.w r12, [lr], #4
    sub.w sp, sp, #25*basesize*2
    sub.w sp, sp, #26*basesize*2
    mov.w r0, sp
    vmov s0, s1, r0, r1
    vmov s2, s3, lr, r12
    add.w lr, r0, #1*basesize*2
    vmov s4, lr
ntt41_rader_1148_crt:
    ldr.w r4, [r1, #1*basesize*2]
    ldr.w r5, [r1, #6*basesize*2]
    ldr.w r6, [r1, #36*basesize*2]
    ldr.w r7, [r1, #11*basesize*2]
    ldr.w r8, [r1, #40*basesize*2]
    ldr.w r9, [r1, #35*basesize*2]
    ldr.w r10, [r1, #5*basesize*2]
    ldr.w r11, [r1, #30*basesize*2]
    
    sadd16 r3, r4, r8 @ mod (x^20-1) 0
    ssub16 r8, r4, r8 @ mod (x^20+1) 0
    sadd16 r4, r5, r9 @ mod (x^20-1) 1
    ssub16 r9, r5, r9 @ mod (x^20+1) 1
    sadd16 r5, r6, r10 @ mod (x^20-1) 2
    ssub16 r10, r6, r10 @ mod (x^20+1) 2
    sadd16 r6, r7, r11 @ mod (x^20-1) 3
    ssub16 r11, r7, r11 @ mod (x^20+1) 3

    pkhbt r7, r8, r10, lsl #16 @ mod (x^20+1) 0,2 a
    pkhtb r10, r10, r8, asr #16 @ mod (x^20+1) 0,2 b
    pkhbt r8, r9, r11, lsl #16 @ mod (x^20+1) 1,3 a
    pkhtb r11, r11, r9, asr #16 @ mod (x^20+1) 1,3 b
    
    sadd16 r9, r7, r8 @ mod (x^20+1) 0+1,2+3 a
    sadd16 r12, r10, r11 @ mod (x^20+1) 0+1,2+3 b

    str.w r7, [r0, #21*basesize*2]
    str.w r8, [r0, #31*basesize*2]
    str.w r9, [r0, #41*basesize*2]
    str.w r10, [r0, #26*basesize*2]
    str.w r11, [r0, #36*basesize*2]
    str.w r12, [r0, #46*basesize*2]

    ldr.w r8, [r1, #32*basesize*2]
    ldr.w r9, [r1, #28*basesize*2]
    ldr.w r10, [r1, #9*basesize*2]
    ldr.w r11, [r1, #13*basesize*2]

    sadd16 r7, r8, r10 @ mod (x^20-1) 10
    ssub16 r10, r8, r10 @ mod (x^20+1) 10
    sadd16 r8, r9, r11 @ mod (x^20-1) 11
    ssub16 r11, r9, r11 @ mod (x^20+1) 11

    sadd16 r2, r3, r7 @ mod (x^10-1) 0
    ssub16 r7, r3, r7 @ mod (x^10+1) 0
    sadd16 r3, r4, r8 @ mod (x^10-1) 1
    ssub16 r8, r4, r8 @ mod (x^10+1) 1

    sadd16 r12, r2, r3 @ sum of 8 coefficients

    pkhtb r4, r3, r2, asr #16 @ mod (x^10-1) 0,1 b
    pkhbt r3, r2, r3, lsl #16 @ mod (x^10-1) 0,1 a
    pkhtb r9, r8, r7, asr #16 @ mod (x^10+1) 0,1 b
    pkhbt r8, r7, r8, lsl #16 @ mod (x^10+1) 0,1 a

    str.w r3, [r0, #1*basesize*2]
    str.w r8, [r0, #11*basesize*2]
    str.w r4, [r0, #6*basesize*2]
    str.w r9, [r0, #16*basesize*2]
    vmov s5, r12

    ldr.w r3, [r1, #4*basesize*2]
    ldr.w r4, [r1, #24*basesize*2]
    ldr.w r7, [r1, #37*basesize*2]
    ldr.w r8, [r1, #17*basesize*2]
    
    ssub16 r9, r4, r8 @ mod (x^20+1) 13
    sadd16 r4, r4, r8 @ mod (x^20-1) 13
    ssub16 r8, r3, r7 @ mod (x^20+1) 12
    sadd16 r3, r3, r7 @ mod (x^20-1) 12

    sadd16 r2, r5, r3 @ mod (x^10-1) 2
    ssub16 r5, r5, r3 @ mod (x^10+1) 2
    sadd16 r3, r6, r4 @ mod (x^10-1) 3
    ssub16 r6, r6, r4 @ mod (x^10+1) 3

    sadd16 r12, r2, r3

    pkhtb r4, r3, r2, asr #16 @ mod (x^10-1) 2,3 b
    pkhbt r3, r2, r3, lsl #16 @ mod (x^10-1) 2,3 a
    pkhtb r7, r6, r5, asr #16 @ mod (x^10+1) 2,3 b
    pkhbt r6, r5, r6, lsl #16 @ mod (x^10+1) 2,3 a

    str.w r3, [r0, #2*basesize*2]
    str.w r6, [r0, #12*basesize*2]
    str.w r4, [r0, #7*basesize*2]
    str.w r7, [r0, #17*basesize*2]
    vmov s6, r12

    ldr.w r3, [r1, #10*basesize*2]
    ldr.w r4, [r1, #19*basesize*2]
    ldr.w r5, [r1, #31*basesize*2]
    ldr.w r6, [r1, #22*basesize*2]

    sadd16 r2, r3, r5 @ mod (x^20-1) 8
    ssub16 r5, r3, r5 @ mod (x^20+1) 8
    sadd16 r3, r4, r6 @ mod (x^20-1) 9
    ssub16 r6, r4, r6 @ mod (x^20+1) 9

    pkhbt r4, r5, r10, lsl #16 @ mod (x^20+1) 8,10 a
    pkhtb r10, r10, r5, asr #16 @ mod (x^20+1) 8,10 b
    pkhbt r5, r6, r11, lsl #16 @ mod (x^20+1) 9,11 a
    pkhtb r11, r11, r6, asr #16 @ mod (x^20+1) 9,11 b

    sadd16 r6, r4, r5 @ mod (x^20+1) 8+9,10+11 a
    sadd16 r12, r10, r11 @ mod (x^20+1) 8+9,10+11 b

    str.w r4, [r0, #23*basesize*2]
    str.w r5, [r0, #33*basesize*2]
    str.w r6, [r0, #43*basesize*2]
    str.w r10, [r0, #28*basesize*2]
    str.w r11, [r0, #38*basesize*2]
    str.w r12, [r0, #48*basesize*2]

    ldr.w r5, [r1, #21*basesize*2]
    ldr.w r6, [r1, #3*basesize*2]
    ldr.w r10, [r1, #20*basesize*2]
    ldr.w r11, [r1, #38*basesize*2]

    sadd16 r4, r5, r10 @ mod (x^20-1) 14
    ssub16 r10, r5, r10 @ mod (x^20+1) 14
    sadd16 r5, r6, r11 @ mod (x^20-1) 15
    ssub16 r11, r6, r11 @ mod (x^20+1) 15

    pkhbt r7, r8, r10, lsl #16 @ mod (x^20+1) 12,14 a
    pkhtb r10, r10, r8, asr #16 @ mod (x^20+1) 12,14 b
    pkhbt r8, r9, r11, lsl #16 @ mod (x^20+1) 13,15 a
    pkhtb r11, r11, r9, asr #16 @ mod (x^20+1) 13,15 b

    sadd16 r9, r7, r8 @ mod (x^20+1) 12+13,14+15 a
    sadd16 r12, r10, r11 @ mod (x^20+1) 12+13,14+15 b

    add.w r0, r0, #20*basesize*2
    str.w r7, [r0, #4*basesize*2]
    str.w r8, [r0, #14*basesize*2]
    str.w r9, [r0, #24*basesize*2]
    str.w r10, [r0, #9*basesize*2]
    str.w r11, [r0, #19*basesize*2]
    str.w r12, [r0, #29*basesize*2]
    sub.w r0, r0, #20*basesize*2

    ldr.w r8, [r1, #33*basesize*2]
    ldr.w r9, [r1, #34*basesize*2]
    ldr.w r10, [r1, #8*basesize*2]
    ldr.w r11, [r1, #7*basesize*2]

    sadd16 r7, r8, r10 @ mod (x^20-1) 18
    ssub16 r10, r8, r10 @ mod (x^20+1) 18
    sadd16 r8, r9, r11 @ mod (x^20-1) 19
    ssub16 r11, r9, r11 @ mod (x^20+1) 19

    sadd16 r6, r2, r7 @ mod (x^10-1) 8
    ssub16 r2, r2, r7 @ mod (x^10+1) 8
    sadd16 r7, r3, r8 @ mod (x^10-1) 9
    ssub16 r3, r3, r8 @ mod (x^10+1) 9

    sadd16 r12, r6, r7

    pkhbt r8, r6, r7, lsl #16 @ mod (x^10-1) 8,9 a
    pkhtb r9, r7, r6, asr #16 @ mod (x^10-1) 8,9 b
    pkhbt r6, r2, r3, lsl #16 @ mod (x^10+1) 8,9 a
    pkhtb r7, r3, r2, asr #16 @ mod (x^10+1) 8,9 b

    str.w r8, [r0, #5*basesize*2]
    str.w r6, [r0, #15*basesize*2]
    str.w r9, [r0, #10*basesize*2]
    str.w r7, [r0, #20*basesize*2]
    vmov s7, r12

    ldr.w r6, [r1, #18*basesize*2]
    ldr.w r7, [r1, #26*basesize*2]
    ldr.w r8, [r1, #23*basesize*2]
    ldr.w r9, [r1, #15*basesize*2]

    sadd16 r2, r6, r8 @ mod (x^20-1) 16
    ssub16 r8, r6, r8 @ mod (x^20+1) 16
    sadd16 r3, r7, r9 @ mod (x^20-1) 17
    ssub16 r9, r7, r9 @ mod (x^20+1) 17

    pkhbt r6, r8, r10, lsl #16 @ mod (x^20+1) 16,18 a
    pkhtb r10, r10, r8, asr #16 @ mod (x^20+1) 16,18 b
    pkhbt r7, r9, r11, lsl #16 @ mod (x^20+1) 17,19 a
    pkhtb r11, r11, r9, asr #16 @ mod (x^20+1) 17,19 b

    sadd16 r8, r6, r7 @ mod (x^20+1) 16+17,18+19 a
    sadd16 r12, r10, r11 @ mod (x^20+1) 16+17,18+19 b

    add.w r0, r0, #20*basesize*2
    str.w r6, [r0, #5*basesize*2]
    str.w r7, [r0, #15*basesize*2]
    str.w r8, [r0, #25*basesize*2]
    str.w r10, [r0, #10*basesize*2]
    str.w r11, [r0, #20*basesize*2]
    str.w r12, [r0, #30*basesize*2]
    sub.w r0, r0, #20*basesize*2

    ldr.w r8, [r1, #25*basesize*2]
    ldr.w r9, [r1, #27*basesize*2]
    ldr.w r10, [r1, #16*basesize*2]
    ldr.w r11, [r1, #14*basesize*2]

    sadd16 r7, r8, r10 @ mod (x^20-1) 4
    ssub16 r10, r8, r10 @ mod (x^20+1) 4
    sadd16 r8, r9, r11 @ mod (x^20-1) 5
    ssub16 r11, r9, r11 @ mod (x^20+1) 5

    sadd16 r6, r7, r4 @ mod (x^10-1) 4
    ssub16 r4, r7, r4 @ mod (x^10+1) 4
    sadd16 r7, r8, r5 @ mod (x^10-1) 5
    ssub16 r5, r8, r5 @ mod (x^10+1) 5

    sadd16 r12, r6, r7

    pkhtb r8, r7, r6, asr #16 @ mod (x^10-1) 4,5 b
    pkhbt r7, r6, r7, lsl #16 @ mod (x^10-1) 4,5 a
    pkhtb r6, r5, r4, asr #16 @ mod (x^10+1) 4,5 b
    pkhbt r5, r4, r5, lsl #16 @ mod (x^10+1) 4,5 a

    str.w r7, [r0, #3*basesize*2]
    str.w r5, [r0, #13*basesize*2]
    str.w r8, [r0, #8*basesize*2]
    str.w r6, [r0, #18*basesize*2]
    vmov s8, r12

    ldr.w r6, [r1, #39*basesize*2]
    ldr.w r7, [r1, #29*basesize*2]
    ldr.w r8, [r1, #2*basesize*2]
    ldr.w r9, [r1, #12*basesize*2]

    sadd16 r5, r6, r8 @ mod (x^20-1) 6
    ssub16 r8, r6, r8 @ mod (x^20+1) 6
    sadd16 r6, r7, r9 @ mod (x^20-1) 7
    ssub16 r9, r7, r9 @ mod (x^20+1) 7

    sadd16 r4, r5, r2 @ mod (x^10-1) 6
    ssub16 r2, r5, r2 @ mod (x^10+1) 6
    sadd16 r5, r6, r3 @ mod (x^10-1) 7
    ssub16 r3, r6, r3 @ mod (x^10+1) 7

    sadd16 r12, r4, r5

    pkhbt r6, r4, r5, lsl #16 @ mod (x^10-1) 6,7 a
    pkhtb r7, r5, r4, asr #16 @ mod (x^10-1) 6,7 b
    pkhbt r4, r2, r3, lsl #16 @ mod (x^10+1) 6,7 a
    pkhtb r5, r3, r2, asr #16 @ mod (x^10+1) 6,7 b

    pkhbt r2, r10, r8, lsl #16 @ mod (x^20+1) 4,6 a
    pkhtb r8, r8, r10, asr #16 @ mod (x^20+1) 4,6 b
    pkhbt r3, r11, r9, lsl #16 @ mod (x^20+1) 5,7 a
    pkhtb r9, r9, r11, asr #16 @ mod (x^20+1) 5,7 b

    sadd16 r10, r2, r3 @ mod (x^20+1) 4+5,6+7 a
    sadd16 r11, r8, r9 @ mod (x^20+1) 4+5,6+7 b

    str.w r6, [r0, #4*basesize*2]
    str.w r4, [r0, #14*basesize*2]
    str.w r7, [r0, #9*basesize*2]
    str.w r5, [r0, #19*basesize*2]

    str.w r2, [r0, #22*basesize*2]
    str.w r3, [r0, #32*basesize*2]
    str.w r10, [r0, #42*basesize*2]
    str.w r8, [r0, #27*basesize*2]
    str.w r9, [r0, #37*basesize*2]
    str.w r11, [r0, #47*basesize*2]

    vmov r8, r9, s5, s6
    vmov r10, r11, s7, s8
    vmov r3, r2, s3, s4
    mov.w r4, #3532 @ 65536 % 5167
    smulbb r5, r4, r8
    smlabb r5, r4, r9, r5
    smlabb r5, r4, r10, r5
    smlabb r5, r4, r11, r5
    smlabb r5, r4, r12, r5
    smulbt r6, r4, r8
    smlabt r6, r4, r9, r6
    smlabt r6, r4, r10, r6
    smlabt r6, r4, r11, r6
    smlabt r6, r4, r12, r6
    montgomery_reduce r5, r3, r7
    montgomery_reduce r6, r3, r7
    pkhtb r5, r6, r5, asr #16 @ sum(a1~a40)
    add.w r1, r1, #4
    str.w r5, [r0], #4
    cmp.w r0, r2
    bne.w ntt41_rader_1148_crt

    vmov r0, s0
    vmov r12, lr, s2, s3
    ldm r12!, {r1-r5}
    vmov s2, r12
    add.w r0, r0, #1*basesize*2
    add.w r12, r0, #1*basesize*2
    vmov s5, s6, r0, r12
ntt41_rader_1148_10x10_positive:
    ldr.w r6, [r0, #5*basesize*2]
    ldr.w r7, [r0, #6*basesize*2]
    ldr.w r8, [r0, #7*basesize*2]
    ldr.w r9, [r0, #8*basesize*2]
    ldr.w r10, [r0, #9*basesize*2]
    polymul_10x10_positive_cyclic_c1 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
    polymul_10x10_positive_cyclic_c3 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c1,c3
    vmov s7, r11

    polymul_10x10_positive_cyclic_c5 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
    polymul_10x10_positive_cyclic_c7 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c5,c7
    vmov s8, r11

    polymul_10x10_positive_cyclic_c9 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
    montgomery_reduce r11, lr, r0

    permute_09_21_43_65_87 r12, r6, r7, r8, r9, r10
    
    polymul_10x10_positive_cyclic_c8 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9
    montgomery_reduce r10, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c8,c9
    vmov s9, r10

    polymul_10x10_positive_cyclic_c4 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9
    polymul_10x10_positive_cyclic_c6 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c4,c6
    vmov s10, r10

    polymul_10x10_positive_cyclic_c0 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9
    polymul_10x10_positive_cyclic_c2 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c0,c2
    vmov s11, r10

    vmov r0, s5
    ldr.w r6, [r0]
    ldr.w r7, [r0, #1*basesize*2]
    ldr.w r8, [r0, #2*basesize*2]
    ldr.w r9, [r0, #3*basesize*2]
    ldr.w r10, [r0, #4*basesize*2]
    polymul_10x10_positive_cyclic_c1 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
    polymul_10x10_positive_cyclic_c3 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c1,c3
    vmov s12, r11

    polymul_10x10_positive_cyclic_c5 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
    polymul_10x10_positive_cyclic_c7 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c5,c7
    vmov s13, r11

    polymul_10x10_positive_cyclic_c9 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
    montgomery_reduce r11, lr, r0

    permute_09_21_43_65_87 r12, r6, r7, r8, r9, r10
    
    polymul_10x10_positive_cyclic_c8 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9
    montgomery_reduce r10, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c8,c9
    vmov s14, r10

    polymul_10x10_positive_cyclic_c4 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9
    polymul_10x10_positive_cyclic_c6 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c4,c6
    vmov s15, r10

    polymul_10x10_positive_cyclic_c0 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9
    polymul_10x10_positive_cyclic_c2 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c0,c2

    vmov r0, r6, s5, s6
    vmov r11, r12, s7, s8
    vmov r8, r9, s12, s13
    pkhbt r7, r8, r11, lsl #16 @ 1
    pkhtb r11, r11, r8, asr #16 @ 3
    pkhbt r8, r9, r12, lsl #16 @ 5
    pkhtb r12, r12, r9, asr #16 @ 7

    str.w r7, [r0, #1*basesize*2]
    str.w r11, [r0, #3*basesize*2]
    str.w r8, [r0, #5*basesize*2]
    str.w r12, [r0, #7*basesize*2]

    vmov r11, r12, s9, s10
    vmov r8, r9, s14, s15
    pkhbt r7, r8, r11, lsl #16 @ 8
    pkhtb r11, r11, r8, asr #16 @ 9
    pkhbt r8, r9, r12, lsl #16 @ 4
    pkhtb r12, r12, r9, asr #16 @ 6
    
    str.w r7, [r0, #8*basesize*2]
    str.w r11, [r0, #9*basesize*2]
    str.w r8, [r0, #4*basesize*2]
    str.w r12, [r0, #6*basesize*2]

    vmov r11, s11
    pkhbt r8, r10, r11, lsl #16 @ 0
    pkhtb r9, r11, r10, asr #16 @ 2
    str.w r9, [r0, #2*basesize*2]
    str.w r8, [r0], #4
    vmov s5, r0
    cmp.w r0, r6
    bne.w ntt41_rader_1148_10x10_positive

    vmov r0, s0
    vmov r12, s2
    ldm r12!, {r1-r5}
    vmov s2, r12
    add.w r0, r0, #11*basesize*2
    add.w r12, r0, #1*basesize*2
    vmov s5, s6, r0, r12
ntt41_rader_1148_10x10_negative:
    ldr.w r6, [r0, #5*basesize*2]
    ldr.w r7, [r0, #6*basesize*2]
    ldr.w r8, [r0, #7*basesize*2]
    ldr.w r9, [r0, #8*basesize*2]
    ldr.w r10, [r0, #9*basesize*2]
    polymul_10x10_negative_cyclic_c1 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c3 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c1,c3
    vmov s7, r11

    polymul_10x10_negative_cyclic_c5 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c7 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c5,c7
    vmov s8, r11

    polymul_10x10_negative_cyclic_c9 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0

    permute_09_21_43_65_87 r12, r6, r7, r8, r9, r10
    
    polymul_10x10_negative_cyclic_c8 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c8,c9
    vmov s9, r10

    polymul_10x10_negative_cyclic_c4 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c6 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c4,c6
    vmov s10, r10

    polymul_10x10_negative_cyclic_c0 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c2 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c0,c2
    vmov s11, r10

    vmov r0, s5
    ldr.w r6, [r0]
    ldr.w r7, [r0, #1*basesize*2]
    ldr.w r8, [r0, #2*basesize*2]
    ldr.w r9, [r0, #3*basesize*2]
    ldr.w r10, [r0, #4*basesize*2]
    polymul_10x10_negative_cyclic_c1 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c3 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c1,c3
    vmov s12, r11

    polymul_10x10_negative_cyclic_c5 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c7 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c5,c7
    vmov s13, r11

    polymul_10x10_negative_cyclic_c9 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0

    permute_09_21_43_65_87 r12, r6, r7, r8, r9, r10
    
    polymul_10x10_negative_cyclic_c8 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c8,c9
    vmov s14, r10

    polymul_10x10_negative_cyclic_c4 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c6 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c4,c6
    vmov s15, r10

    polymul_10x10_negative_cyclic_c0 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c2 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c0,c2

    vmov r0, r6, s5, s6
    vmov r11, r12, s7, s8
    vmov r8, r9, s12, s13
    pkhbt r7, r8, r11, lsl #16 @ 1
    pkhtb r11, r11, r8, asr #16 @ 3
    pkhbt r8, r9, r12, lsl #16 @ 5
    pkhtb r12, r12, r9, asr #16 @ 7

    str.w r7, [r0, #1*basesize*2]
    str.w r11, [r0, #3*basesize*2]
    str.w r8, [r0, #5*basesize*2]
    str.w r12, [r0, #7*basesize*2]

    vmov r11, r12, s9, s10
    vmov r8, r9, s14, s15
    pkhbt r7, r8, r11, lsl #16 @ 8
    pkhtb r11, r11, r8, asr #16 @ 9
    pkhbt r8, r9, r12, lsl #16 @ 4
    pkhtb r12, r12, r9, asr #16 @ 6
    
    str.w r7, [r0, #8*basesize*2]
    str.w r11, [r0, #9*basesize*2]
    str.w r8, [r0, #4*basesize*2]
    str.w r12, [r0, #6*basesize*2]

    vmov r11, s11
    pkhbt r8, r10, r11, lsl #16 @ 0
    pkhtb r9, r11, r10, asr #16 @ 2
    str.w r9, [r0, #2*basesize*2]
    str.w r8, [r0], #4
    vmov s5, r0
    cmp.w r0, r6
    bne.w ntt41_rader_1148_10x10_negative

    vmov r0, s0
    vmov r12, s2
    ldm r12!, {r1-r5}
    vmov s2, r12
    add.w r0, r0, #21*basesize*2
    add.w r12, r0, #1*basesize*2
    vmov s5, s6, r0, r12
ntt41_rader_1148_20x20_negative_karatsuba_low:
    ldr.w r6, [r0, #5*basesize*2]
    ldr.w r7, [r0, #6*basesize*2]
    ldr.w r8, [r0, #7*basesize*2]
    ldr.w r9, [r0, #8*basesize*2]
    ldr.w r10, [r0, #9*basesize*2]
    polymul_10x10_negative_cyclic_c1 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c3 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c1,c3
    vmov s7, r11

    polymul_10x10_negative_cyclic_c5 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c7 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c5,c7
    vmov s8, r11

    polymul_10x10_negative_cyclic_c9 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0

    permute_09_21_43_65_87 r12, r6, r7, r8, r9, r10
    
    polymul_10x10_negative_cyclic_c8 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c8,c9
    vmov s9, r10

    polymul_10x10_negative_cyclic_c4 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c6 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c4,c6
    vmov s10, r10

    polymul_10x10_negative_cyclic_c0 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c2 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c0,c2
    vmov s11, r10

    vmov r0, s5
    ldr.w r6, [r0]
    ldr.w r7, [r0, #1*basesize*2]
    ldr.w r8, [r0, #2*basesize*2]
    ldr.w r9, [r0, #3*basesize*2]
    ldr.w r10, [r0, #4*basesize*2]
    polymul_10x10_negative_cyclic_c1 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c3 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c1,c3
    vmov s12, r11

    polymul_10x10_negative_cyclic_c5 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c7 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c5,c7
    vmov s13, r11

    polymul_10x10_negative_cyclic_c9 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0

    permute_09_21_43_65_87 r12, r6, r7, r8, r9, r10
    
    polymul_10x10_negative_cyclic_c8 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c8,c9
    vmov s14, r10

    polymul_10x10_negative_cyclic_c4 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c6 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c4,c6
    vmov s15, r10

    polymul_10x10_negative_cyclic_c0 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c2 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c0,c2

    vmov r0, r6, s5, s6
    vmov r11, r12, s7, s8
    vmov r8, r9, s12, s13
    pkhbt r7, r8, r11, lsl #16 @ 1
    pkhtb r11, r11, r8, asr #16 @ 3
    pkhbt r8, r9, r12, lsl #16 @ 5
    pkhtb r12, r12, r9, asr #16 @ 7

    str.w r7, [r0, #1*basesize*2]
    str.w r11, [r0, #3*basesize*2]
    str.w r8, [r0, #5*basesize*2]
    str.w r12, [r0, #7*basesize*2]

    vmov r11, r12, s9, s10
    vmov r8, r9, s14, s15
    pkhbt r7, r8, r11, lsl #16 @ 8
    pkhtb r11, r11, r8, asr #16 @ 9
    pkhbt r8, r9, r12, lsl #16 @ 4
    pkhtb r12, r12, r9, asr #16 @ 6
    
    str.w r7, [r0, #8*basesize*2]
    str.w r11, [r0, #9*basesize*2]
    str.w r8, [r0, #4*basesize*2]
    str.w r12, [r0, #6*basesize*2]

    vmov r11, s11
    pkhbt r8, r10, r11, lsl #16 @ 0
    pkhtb r9, r11, r10, asr #16 @ 2
    str.w r9, [r0, #2*basesize*2]
    str.w r8, [r0], #4
    vmov s5, r0
    cmp.w r0, r6
    bne.w ntt41_rader_1148_20x20_negative_karatsuba_low

    vmov r0, s0
    vmov r12, s2
    ldm r12!, {r1-r5}
    vmov s2, r12
    add.w r0, r0, #31*basesize*2
    add.w r12, r0, #1*basesize*2
    vmov s5, s6, r0, r12
ntt41_rader_1148_20x20_negative_karatsuba_high:
    ldr.w r6, [r0, #5*basesize*2]
    ldr.w r7, [r0, #6*basesize*2]
    ldr.w r8, [r0, #7*basesize*2]
    ldr.w r9, [r0, #8*basesize*2]
    ldr.w r10, [r0, #9*basesize*2]
    polymul_10x10_negative_cyclic_c1 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c3 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c1,c3
    vmov s7, r11

    polymul_10x10_negative_cyclic_c5 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c7 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c5,c7
    vmov s8, r11

    polymul_10x10_negative_cyclic_c9 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0

    permute_09_21_43_65_87 r12, r6, r7, r8, r9, r10
    
    polymul_10x10_negative_cyclic_c8 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c8,c9
    vmov s9, r10

    polymul_10x10_negative_cyclic_c4 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c6 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c4,c6
    vmov s10, r10

    polymul_10x10_negative_cyclic_c0 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c2 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c0,c2
    vmov s11, r10

    vmov r0, s5
    ldr.w r6, [r0]
    ldr.w r7, [r0, #1*basesize*2]
    ldr.w r8, [r0, #2*basesize*2]
    ldr.w r9, [r0, #3*basesize*2]
    ldr.w r10, [r0, #4*basesize*2]
    polymul_10x10_negative_cyclic_c1 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c3 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c1,c3
    vmov s12, r11

    polymul_10x10_negative_cyclic_c5 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c7 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c5,c7
    vmov s13, r11

    polymul_10x10_negative_cyclic_c9 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0

    permute_09_21_43_65_87 r12, r6, r7, r8, r9, r10
    
    polymul_10x10_negative_cyclic_c8 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c8,c9
    vmov s14, r10

    polymul_10x10_negative_cyclic_c4 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c6 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c4,c6
    vmov s15, r10

    polymul_10x10_negative_cyclic_c0 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c2 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c0,c2

    vmov r0, r6, s5, s6
    vmov r11, r12, s7, s8
    vmov r8, r9, s12, s13
    pkhbt r7, r8, r11, lsl #16 @ 1
    pkhtb r11, r11, r8, asr #16 @ 3
    pkhbt r8, r9, r12, lsl #16 @ 5
    pkhtb r12, r12, r9, asr #16 @ 7

    str.w r7, [r0, #1*basesize*2]
    str.w r11, [r0, #3*basesize*2]
    str.w r8, [r0, #5*basesize*2]
    str.w r12, [r0, #7*basesize*2]

    vmov r11, r12, s9, s10
    vmov r8, r9, s14, s15
    pkhbt r7, r8, r11, lsl #16 @ 8
    pkhtb r11, r11, r8, asr #16 @ 9
    pkhbt r8, r9, r12, lsl #16 @ 4
    pkhtb r12, r12, r9, asr #16 @ 6
    
    str.w r7, [r0, #8*basesize*2]
    str.w r11, [r0, #9*basesize*2]
    str.w r8, [r0, #4*basesize*2]
    str.w r12, [r0, #6*basesize*2]

    vmov r11, s11
    pkhbt r8, r10, r11, lsl #16 @ 0
    pkhtb r9, r11, r10, asr #16 @ 2
    str.w r9, [r0, #2*basesize*2]
    str.w r8, [r0], #4
    vmov s5, r0
    cmp.w r0, r6
    bne.w ntt41_rader_1148_20x20_negative_karatsuba_high

    vmov r0, s0
    vmov r12, s2
    ldm r12!, {r1-r5}
    vmov s2, r12
    add.w r0, r0, #41*basesize*2
    add.w r12, r0, #1*basesize*2
    vmov s5, s6, r0, r12
ntt41_rader_1148_20x20_negative_karatsuba_mixed:
    ldr.w r6, [r0, #5*basesize*2]
    ldr.w r7, [r0, #6*basesize*2]
    ldr.w r8, [r0, #7*basesize*2]
    ldr.w r9, [r0, #8*basesize*2]
    ldr.w r10, [r0, #9*basesize*2]
    polymul_10x10_negative_cyclic_c1 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c3 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c1,c3
    vmov s7, r11

    polymul_10x10_negative_cyclic_c5 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c7 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c5,c7
    vmov s8, r11

    polymul_10x10_negative_cyclic_c9 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0

    permute_09_21_43_65_87 r12, r6, r7, r8, r9, r10
    
    polymul_10x10_negative_cyclic_c8 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c8,c9
    vmov s9, r10

    polymul_10x10_negative_cyclic_c4 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c6 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c4,c6
    vmov s10, r10

    polymul_10x10_negative_cyclic_c0 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c2 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c0,c2
    vmov s11, r10

    vmov r0, s5
    ldr.w r6, [r0]
    ldr.w r7, [r0, #1*basesize*2]
    ldr.w r8, [r0, #2*basesize*2]
    ldr.w r9, [r0, #3*basesize*2]
    ldr.w r10, [r0, #4*basesize*2]
    polymul_10x10_negative_cyclic_c1 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c3 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c1,c3
    vmov s12, r11

    polymul_10x10_negative_cyclic_c5 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    polymul_10x10_negative_cyclic_c7 r12, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r11, r12, r11, asr #16 @ c5,c7
    vmov s13, r11

    polymul_10x10_negative_cyclic_c9 r11, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r0
    montgomery_reduce r11, lr, r0

    permute_09_21_43_65_87 r12, r6, r7, r8, r9, r10
    
    polymul_10x10_negative_cyclic_c8 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c8,c9
    vmov s14, r10

    polymul_10x10_negative_cyclic_c4 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c6 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c4,c6
    vmov s15, r10

    polymul_10x10_negative_cyclic_c0 r10, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    polymul_10x10_negative_cyclic_c2 r11, r1, r2, r3, r4, r5, r12, r6, r7, r8, r9, r0
    montgomery_reduce r10, lr, r0
    montgomery_reduce r11, lr, r0
    pkhtb r10, r11, r10, asr #16 @ c0,c2

    vmov r0, r6, s5, s6
    vmov r11, r12, s7, s8
    vmov r8, r9, s12, s13
    pkhbt r7, r8, r11, lsl #16 @ 1
    pkhtb r11, r11, r8, asr #16 @ 3
    pkhbt r8, r9, r12, lsl #16 @ 5
    pkhtb r12, r12, r9, asr #16 @ 7

    str.w r7, [r0, #1*basesize*2]
    str.w r11, [r0, #3*basesize*2]
    str.w r8, [r0, #5*basesize*2]
    str.w r12, [r0, #7*basesize*2]

    vmov r11, r12, s9, s10
    vmov r8, r9, s14, s15
    pkhbt r7, r8, r11, lsl #16 @ 8
    pkhtb r11, r11, r8, asr #16 @ 9
    pkhbt r8, r9, r12, lsl #16 @ 4
    pkhtb r12, r12, r9, asr #16 @ 6
    
    str.w r7, [r0, #8*basesize*2]
    str.w r11, [r0, #9*basesize*2]
    str.w r8, [r0, #4*basesize*2]
    str.w r12, [r0, #6*basesize*2]

    vmov r11, s11
    pkhbt r8, r10, r11, lsl #16 @ 0
    pkhtb r9, r11, r10, asr #16 @ 2
    str.w r9, [r0, #2*basesize*2]
    str.w r8, [r0], #4
    vmov s5, r0
    cmp.w r0, r6
    bne.w ntt41_rader_1148_20x20_negative_karatsuba_mixed

@ w_seq = 
@ [34, 33, 26, 18, 3, 21, 24, 4, 28, 32, 19, 10, 29, 39, 27, 25, 11, 36, 6, 1, 
@  7, 8, 15, 23, 38, 20, 17, 37, 13, 9, 22, 31, 12, 2, 14, 16, 30, 5, 35, 40]
    vmov r1, r2, s0, s1
    vmov r0, s16
    add.w r12, r0, #1*basesize*2
ntt41_rader_1148_output:
    ldr.w r3, [r2], #4
    ldr.w r4, [r1, #1*basesize*2] @ mod (x^10 - 1) 0
    ldr.w r5, [r1, #11*basesize*2] @ mod (x^10 + 1) 0
    ldr.w r6, [r1, #21*basesize*2] @ l0
    ldr.w r7, [r1, #26*basesize*2] @ l5
    ldr.w r8, [r1, #40*basesize*2] @ h9
    ldr.w r9, [r1, #35*basesize*2] @ h4
    vmov s13, s14, r8, r9 @ h9, h4
    sadd16 r10, r4, r5 @ mod (x^20 - 1) 0
    ssub16 r11, r4, r5 @ mod (x^20 - 1) 10
    ssub16 r8, r6, r8 @ mod (x^20 + 1) 0
    sadd16 r9, r7, r9 @ mod (x^20 + 1) 10
    sadd16 r4, r10, r8 @ mod (x^40 - 1) 0
    ssub16 r10, r10, r8 @ mod (x^40 - 1) 20
    sadd16 r5, r11, r9 @ mod (x^40 - 1) 10
    ssub16 r11, r11, r9 @ mod (x^40 - 1) 30
    sadd16 r4, r4, r3 @ ans 1, str to 34
    sadd16 r5, r5, r3 @ ans 11, str to 19
    sadd16 r10, r10, r3 @ ans 21, str to 7
    sadd16 r11, r11, r3 @ ans 31, str to 22
    str.w r4, [r0, #34*basesize*2]
    str.w r5, [r0, #19*basesize*2]
    str.w r10, [r0, #7*basesize*2]
    str.w r11, [r0, #22*basesize*2]

    ldr.w r4, [r1, #2*basesize*2] @ mod (x^10 - 1) 1
    ldr.w r5, [r1, #12*basesize*2] @ mod (x^10 + 1) 1
    ldr.w r8, [r1, #31*basesize*2] @ h0
    ldr.w r9, [r1, #36*basesize*2] @ h5
    ldr.w r10, [r1, #41*basesize*2] @ m0
    ldr.w r11, [r1, #46*basesize*2] @ m5
    ssub16 r6, r10, r6
    ssub16 r6, r6, r8 @ mod (x^20 + 1) 1
    ssub16 r7, r11, r7
    ssub16 r7, r7, r9 @ mod (x^20 + 1) 11
    sadd16 r10, r4, r5 @ mod (x^20 - 1) 1
    ssub16 r11, r4, r5 @ mod (x^20 - 1) 11
    sadd16 r4, r10, r6 @ mod (x^40 - 1) 1
    ssub16 r10, r10, r6 @ mod (x^40 - 1) 21
    sadd16 r5, r11, r7 @ mod (x^40 - 1) 11
    ssub16 r11, r11, r7 @ mod (x^40 - 1) 31
    sadd16 r4, r4, r3 @ ans 2, str to 33
    sadd16 r5, r5, r3 @ ans 12, str to 10
    sadd16 r10, r10, r3 @ ans 22, str to 8
    sadd16 r11, r11, r3 @ ans 32, str to 31
    str.w r4, [r0, #33*basesize*2]
    str.w r5, [r0, #10*basesize*2]
    str.w r10, [r0, #8*basesize*2]
    str.w r11, [r0, #31*basesize*2]

    ldr.w r4, [r1, #3*basesize*2] @ mod (x^10 - 1) 2
    ldr.w r5, [r1, #13*basesize*2] @ mod (x^10 + 1) 2
    ldr.w r6, [r1, #22*basesize*2] @ l1
    ldr.w r7, [r1, #27*basesize*2] @ l6
    sadd16 r10, r4, r5 @ mod (x^20 - 1) 2
    ssub16 r11, r4, r5 @ mod (x^20 - 1) 12
    sadd16 r8, r8, r6 @ mod (x^20 + 1) 2
    sadd16 r9, r9, r7 @ mod (x^20 + 1) 12
    sadd16 r4, r10, r8 @ mod (x^40 - 1) 2
    ssub16 r10, r10, r8 @ mod (x^40 - 1) 22
    sadd16 r5, r11, r9 @ mod (x^40 - 1) 12
    ssub16 r11, r11, r9 @ mod (x^40 - 1) 32
    sadd16 r4, r4, r3 @ ans 3, str to 26
    sadd16 r5, r5, r3 @ ans 13, str to 29
    sadd16 r10, r10, r3 @ ans 23, str to 15
    sadd16 r11, r11, r3 @ ans 33, str to 12
    str.w r4, [r0, #26*basesize*2]
    str.w r5, [r0, #29*basesize*2]
    str.w r10, [r0, #15*basesize*2]
    str.w r11, [r0, #12*basesize*2]

    ldr.w r4, [r1, #4*basesize*2] @ mod (x^10 - 1) 3
    ldr.w r5, [r1, #14*basesize*2] @ mod (x^10 + 1) 3
    ldr.w r8, [r1, #32*basesize*2] @ h1
    ldr.w r9, [r1, #37*basesize*2] @ h6
    ldr.w r10, [r1, #42*basesize*2] @ m1
    ldr.w r11, [r1, #47*basesize*2] @ m6
    ssub16 r6, r10, r6
    ssub16 r6, r6, r8 @ mod (x^20 + 1) 3
    ssub16 r7, r11, r7
    ssub16 r7, r7, r9 @ mod (x^20 + 1) 13
    sadd16 r10, r4, r5 @ mod (x^20 - 1) 3
    ssub16 r11, r4, r5 @ mod (x^20 - 1) 13
    sadd16 r4, r10, r6 @ mod (x^40 - 1) 3
    ssub16 r10, r10, r6 @ mod (x^40 - 1) 23
    sadd16 r5, r11, r7 @ mod (x^40 - 1) 13
    ssub16 r11, r11, r7 @ mod (x^40 - 1) 33
    sadd16 r4, r4, r3 @ ans 4, str to 18
    sadd16 r5, r5, r3 @ ans 14, str to 39
    sadd16 r10, r10, r3 @ ans 24, str to 23
    sadd16 r11, r11, r3 @ ans 34, str to 2
    str.w r4, [r0, #18*basesize*2]
    str.w r5, [r0, #39*basesize*2]
    str.w r10, [r0, #23*basesize*2]
    str.w r11, [r0, #2*basesize*2]

    ldr.w r4, [r1, #5*basesize*2] @ mod (x^10 - 1) 4
    ldr.w r5, [r1, #15*basesize*2] @ mod (x^10 + 1) 4
    ldr.w r6, [r1, #23*basesize*2] @ l2
    ldr.w r7, [r1, #28*basesize*2] @ l7
    sadd16 r10, r4, r5 @ mod (x^20 - 1) 4
    ssub16 r11, r4, r5 @ mod (x^20 - 1) 14
    sadd16 r8, r8, r6 @ mod (x^20 + 1) 4
    sadd16 r9, r9, r7 @ mod (x^20 + 1) 14
    sadd16 r4, r10, r8 @ mod (x^40 - 1) 4
    ssub16 r10, r10, r8 @ mod (x^40 - 1) 24
    sadd16 r5, r11, r9 @ mod (x^40 - 1) 14
    ssub16 r11, r11, r9 @ mod (x^40 - 1) 34
    sadd16 r4, r4, r3 @ ans 5, str to 3
    sadd16 r5, r5, r3 @ ans 15, str to 27
    sadd16 r10, r10, r3 @ ans 25, str to 38
    sadd16 r11, r11, r3 @ ans 35, str to 14
    str.w r4, [r0, #3*basesize*2]
    str.w r5, [r0, #27*basesize*2]
    str.w r10, [r0, #38*basesize*2]
    str.w r11, [r0, #14*basesize*2]

    ldr.w r4, [r1, #6*basesize*2] @ mod (x^10 - 1) 5
    ldr.w r5, [r1, #16*basesize*2] @ mod (x^10 + 1) 5
    ldr.w r8, [r1, #33*basesize*2] @ h2
    ldr.w r9, [r1, #38*basesize*2] @ h7
    ldr.w r10, [r1, #43*basesize*2] @ m2
    ldr.w r11, [r1, #48*basesize*2] @ m7
    ssub16 r6, r10, r6
    ssub16 r6, r6, r8 @ mod (x^20 + 1) 5
    ssub16 r7, r11, r7
    ssub16 r7, r7, r9 @ mod (x^20 + 1) 15
    sadd16 r10, r4, r5 @ mod (x^20 - 1) 5
    ssub16 r11, r4, r5 @ mod (x^20 - 1) 15
    sadd16 r4, r10, r6 @ mod (x^40 - 1) 5
    ssub16 r10, r10, r6 @ mod (x^40 - 1) 25
    sadd16 r5, r11, r7 @ mod (x^40 - 1) 15
    ssub16 r11, r11, r7 @ mod (x^40 - 1) 35
    sadd16 r4, r4, r3 @ ans 6, str to 21
    sadd16 r5, r5, r3 @ ans 16, str to 25
    sadd16 r10, r10, r3 @ ans 26, str to 20
    sadd16 r11, r11, r3 @ ans 36, str to 16
    str.w r4, [r0, #21*basesize*2]
    str.w r5, [r0, #25*basesize*2]
    str.w r10, [r0, #20*basesize*2]
    str.w r11, [r0, #16*basesize*2]

    ldr.w r4, [r1, #7*basesize*2] @ mod (x^10 - 1) 6
    ldr.w r5, [r1, #17*basesize*2] @ mod (x^10 + 1) 6
    ldr.w r6, [r1, #24*basesize*2] @ l3
    ldr.w r7, [r1, #29*basesize*2] @ l8
    sadd16 r10, r4, r5 @ mod (x^20 - 1) 6
    ssub16 r11, r4, r5 @ mod (x^20 - 1) 16
    sadd16 r8, r8, r6 @ mod (x^20 + 1) 6
    sadd16 r9, r9, r7 @ mod (x^20 + 1) 16
    sadd16 r4, r10, r8 @ mod (x^40 - 1) 6
    ssub16 r10, r10, r8 @ mod (x^40 - 1) 26
    sadd16 r5, r11, r9 @ mod (x^40 - 1) 16
    ssub16 r11, r11, r9 @ mod (x^40 - 1) 36
    sadd16 r4, r4, r3 @ ans 7, str to 24
    sadd16 r5, r5, r3 @ ans 17, str to 11
    sadd16 r10, r10, r3 @ ans 27, str to 17
    sadd16 r11, r11, r3 @ ans 37, str to 30
    str.w r4, [r0, #24*basesize*2]
    str.w r5, [r0, #11*basesize*2]
    str.w r10, [r0, #17*basesize*2]
    str.w r11, [r0, #30*basesize*2]

    ldr.w r4, [r1, #8*basesize*2] @ mod (x^10 - 1) 7
    ldr.w r5, [r1, #18*basesize*2] @ mod (x^10 + 1) 7
    add.w r1, r1, #20*basesize*2
    ldr.w r8, [r1, #14*basesize*2] @ h3
    ldr.w r9, [r1, #19*basesize*2] @ h8
    ldr.w r10, [r1, #24*basesize*2] @ m3
    ldr.w r11, [r1, #29*basesize*2] @ m8
    sub.w r1, r1, #20*basesize*2
    ssub16 r6, r10, r6
    ssub16 r6, r6, r8 @ mod (x^20 + 1) 7
    ssub16 r7, r11, r7
    ssub16 r7, r7, r9 @ mod (x^20 + 1) 17
    sadd16 r10, r4, r5 @ mod (x^20 - 1) 7
    ssub16 r11, r4, r5 @ mod (x^20 - 1) 17
    sadd16 r4, r10, r6 @ mod (x^40 - 1) 7
    ssub16 r10, r10, r6 @ mod (x^40 - 1) 27
    sadd16 r5, r11, r7 @ mod (x^40 - 1) 17
    ssub16 r11, r11, r7 @ mod (x^40 - 1) 37
    sadd16 r4, r4, r3 @ ans 8, str to 4
    sadd16 r5, r5, r3 @ ans 18, str to 36
    sadd16 r10, r10, r3 @ ans 28, str to 37
    sadd16 r11, r11, r3 @ ans 38, str to 5
    str.w r4, [r0, #4*basesize*2]
    str.w r5, [r0, #36*basesize*2]
    str.w r10, [r0, #37*basesize*2]
    str.w r11, [r0, #5*basesize*2]

    ldr.w r4, [r1, #9*basesize*2] @ mod (x^10 - 1) 8
    ldr.w r5, [r1, #19*basesize*2] @ mod (x^10 + 1) 8
    ldr.w r6, [r1, #25*basesize*2] @ l4
    ldr.w r7, [r1, #30*basesize*2] @ l9
    sadd16 r10, r4, r5 @ mod (x^20 - 1) 8
    ssub16 r11, r4, r5 @ mod (x^20 - 1) 18
    sadd16 r8, r8, r6 @ mod (x^20 + 1) 8
    sadd16 r9, r9, r7 @ mod (x^20 + 1) 18
    sadd16 r4, r10, r8 @ mod (x^40 - 1) 8
    ssub16 r10, r10, r8 @ mod (x^40 - 1) 28
    sadd16 r5, r11, r9 @ mod (x^40 - 1) 18
    ssub16 r11, r11, r9 @ mod (x^40 - 1) 38
    sadd16 r4, r4, r3 @ ans 9, str to 28
    sadd16 r5, r5, r3 @ ans 19, str to 6
    sadd16 r10, r10, r3 @ ans 29, str to 13
    sadd16 r11, r11, r3 @ ans 39, str to 35
    str.w r4, [r0, #28*basesize*2]
    str.w r5, [r0, #6*basesize*2]
    str.w r10, [r0, #13*basesize*2]
    str.w r11, [r0, #35*basesize*2]

    ldr.w r4, [r1, #10*basesize*2] @ mod (x^10 - 1) 9
    ldr.w r5, [r1, #20*basesize*2] @ mod (x^10 + 1) 9
    vmov r9, r8, s13, s14
    add.w r1, r1, #20*basesize*2
    ldr.w r10, [r1, #25*basesize*2] @ m4
    ldr.w r11, [r1, #30*basesize*2] @ m9
    sub.w r1, r1, #20*basesize*2
    ssub16 r6, r10, r6
    ssub16 r6, r6, r8 @ mod (x^20 + 1) 9
    ssub16 r7, r11, r7
    ssub16 r7, r7, r9 @ mod (x^20 + 1) 19
    sadd16 r10, r4, r5 @ mod (x^20 - 1) 9
    ssub16 r11, r4, r5 @ mod (x^20 - 1) 19
    sadd16 r4, r10, r6 @ mod (x^40 - 1) 9
    ssub16 r10, r10, r6 @ mod (x^40 - 1) 29
    sadd16 r5, r11, r7 @ mod (x^40 - 1) 19
    ssub16 r11, r11, r7 @ mod (x^40 - 1) 39
    sadd16 r4, r4, r3 @ ans 10, str to 32
    sadd16 r5, r5, r3 @ ans 20, str to 1
    sadd16 r10, r10, r3 @ ans 30, str to 9
    sadd16 r11, r11, r3 @ ans 40, str to 40
    str.w r4, [r0, #32*basesize*2]
    str.w r5, [r0, #1*basesize*2]
    str.w r10, [r0, #9*basesize*2]
    str.w r11, [r0, #40*basesize*2]

    ldr.w r4, [r1], #4
    sadd16 r4, r4, r3
    str.w r4, [r0], #4
    cmp.w r0, r12
    bne.w ntt41_rader_1148_output
    add.w sp, sp, #26*basesize*2
    add.w sp, sp, #25*basesize*2
    vpop {s16}
    pop {r4-r11, pc}