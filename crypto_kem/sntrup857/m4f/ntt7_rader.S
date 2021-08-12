#include "rader7_macro.S"

.p2align 2,,3
.syntax unified
.text
wpad:
    .word 338644273
    .word 110296341
    .word 4215536469
    .word 4207934758

.equ basesize, 6
.global ntt7_rader
.type ntt7_rader, %function
@ f_seq = [1, 3, 2, 6, 4, 5]
@ w_seq = [2, 3, 1, 5, 4, 6]
@ 1722 / 41 = 42
@ 42 / 7 = 6
ntt7_rader:
    push {r4-r11, lr}
    movw.w r11, #3532
    movt.w r11, #3532
    adr.w lr, wpad
    ldr.w r12, [lr], #4
    ldm lr, {r1-r3}
    add.w r4, r0, #287*basesize*2
    vmov s0, s1, r0, r4
ntt7_rader_body_1:
    add.w lr, r0, #1*basesize*2
    vmov s2, s3, r0, lr
ntt7_rader_body_2:
    ldr.w r4, [r0, #1*basesize*2]
    ldr.w r5, [r0, #3*basesize*2]
    ldr.w r6, [r0, #2*basesize*2]
    ldr.w r7, [r0, #6*basesize*2]
    ldr.w r8, [r0, #4*basesize*2]
    ldr.w r9, [r0, #5*basesize*2]

    pkhtb r10, r9, r8, asr #16 @ mod (x^6-1) 4,5 b
    pkhbt r9, r8, r9, lsl #16 @ mod (x^6-1) 4,5 a
    pkhtb r8, r7, r6, asr #16 @ mod (x^6-1) 2,3 b
    pkhbt r7, r6, r7, lsl #16 @ mod (x^6-1) 2,3 a
    pkhtb r6, r5, r4, asr #16 @ mod (x^6-1) 0,1 b
    pkhbt r5, r4, r5, lsl #16 @ mod (x^6-1) 0,1 a

    smuad r0, r11, r5
    smlad r0, r11, r7, r0
    smlad r0, r11, r9, r0
    smuad r4, r11, r6
    smlad r4, r11, r8, r4
    smlad r4, r11, r10, r4
    montgomery_reduce r0, r12, lr
    montgomery_reduce r4, r12, lr
    pkhtb r0, r4, r0, asr #16
    vmov s4, r0 @ c0-a0

    polymul_6x6_positive_cyclic_c1 r0, r1, r2, r3, r5, r7, r9
    polymul_6x6_positive_cyclic_c1 r4, r1, r2, r3, r6, r8, r10
    montgomery_reduce r0, r12, lr
    montgomery_reduce r4, r12, lr
    pkhtb r0, r4, r0, asr #16
    vmov s5, r0 @ c1

    polymul_6x6_positive_cyclic_c3 r0, r1, r2, r3, r5, r7, r9
    polymul_6x6_positive_cyclic_c3 r4, r1, r2, r3, r6, r8, r10
    montgomery_reduce r0, r12, lr
    montgomery_reduce r4, r12, lr
    pkhtb r0, r4, r0, asr #16
    vmov s6, r0 @ c3

    polymul_6x6_positive_cyclic_c5 r0, r1, r2, r3, r5, r7, r9
    polymul_6x6_positive_cyclic_c5 r4, r1, r2, r3, r6, r8, r10
    montgomery_reduce r0, r12, lr
    montgomery_reduce r4, r12, lr
    pkhtb r0, r4, r0, asr #16
    vmov s7, r0 @ c5

    permute_05_21_43 r0, r5, r7, r9
    permute_05_21_43 r4, r6, r8, r10

    polymul_6x6_positive_cyclic_c0 r9, r1, r2, r3, r0, r5, r7
    polymul_6x6_positive_cyclic_c0 r10, r1, r2, r3, r4, r6, r8
    montgomery_reduce r9, r12, lr
    montgomery_reduce r10, r12, lr
    pkhtb r9, r10, r9, asr #16
    vmov s8, r9 @ c0

    polymul_6x6_positive_cyclic_c2 r9, r1, r2, r3, r0, r5, r7
    polymul_6x6_positive_cyclic_c2 r10, r1, r2, r3, r4, r6, r8
    montgomery_reduce r9, r12, lr
    montgomery_reduce r10, r12, lr
    pkhtb r9, r10, r9, asr #16
    vmov s9, r9 @ c2

    polymul_6x6_positive_cyclic_c4 r9, r1, r2, r3, r0, r5, r7
    polymul_6x6_positive_cyclic_c4 r10, r1, r2, r3, r4, r6, r8
    montgomery_reduce r9, r12, lr
    montgomery_reduce r10, r12, lr
    pkhtb r9, r10, r9, asr #16

    vmov r10, r4, s4, s5
    vmov r5, r6, s6, s7
    vmov r7, r8, s8, s9
    vmov r0, s2

    ldr.w lr, [r0]
    sadd16 r4, r4, lr
    sadd16 r5, r5, lr
    sadd16 r6, r6, lr
    sadd16 r7, r7, lr
    sadd16 r8, r8, lr
    sadd16 r9, r9, lr
    sadd16 r10, r10, lr
    str.w r4, [r0, #3*basesize*2]
    str.w r5, [r0, #5*basesize*2]
    str.w r6, [r0, #6*basesize*2]
    str.w r7, [r0, #2*basesize*2]
    str.w r8, [r0, #1*basesize*2]
    str.w r9, [r0, #4*basesize*2]
    str.w r10, [r0], #4
    vmov s2, r0
    vmov lr, s3
    cmp.w r0, lr
    bne.w ntt7_rader_body_2
    add.w r0, r0, #6*basesize*2
    vmov lr, s1
    cmp.w r0, lr
    bne.w ntt7_rader_body_1
    pop {r4-r11, pc}