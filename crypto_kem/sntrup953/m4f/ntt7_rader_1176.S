#include "rader7_macro.S"

.p2align 2,,3
.syntax unified
.text
wpad:
    .word 415749897 @ qinv / q for montgomery reduce
    .word 4199549503
    .word 137821068
    .word 55706858

.equ basesize, 168
.global ntt7_rader_1176
.type ntt7_rader_1176, %function
@ f_seq = [1, 3, 2, 6, 4, 5]
@ w_seq = [2, 3, 1, 5, 4, 6]
@ 1722 / 41 = 42
@ 42 / 7 = 6
ntt7_rader_1176:
    push {r4-r11, lr}
    adr.w lr, wpad
    ldr.w r12, [lr], #4
    ldm lr, {r9-r11}
    add.w lr, r0, #1*basesize*2
    vmov s0, s1, r0, lr
ntt7_rader_1176_body:
    ldr.w r2, [r1, #1*basesize*2]
    ldr.w r3, [r1, #3*basesize*2]
    ldr.w r4, [r1, #2*basesize*2]
    ldr.w r5, [r1, #6*basesize*2]
    ldr.w r6, [r1, #4*basesize*2]
    ldr.w r7, [r1, #5*basesize*2]

    sadd16 r8, r2, r3
    sadd16 r8, r8, r4
    sadd16 r8, r8, r5
    sadd16 r8, r8, r6
    sadd16 r8, r8, r7
    vmov s4, r8

    pkhtb r8, r7, r6, asr #16
    pkhbt r7, r6, r7, lsl #16
    pkhtb r6, r5, r4, asr #16
    pkhbt r5, r4, r5, lsl #16
    pkhtb r4, r3, r2, asr #16
    pkhbt r3, r2, r3, lsl #16
@ free: 0, 2, lr
    polymul_6x6_positive_cyclic_c1 r0, r9, r10, r11, r3, r5, r7
    polymul_6x6_positive_cyclic_c1 r2, r9, r10, r11, r4, r6, r8
    montgomery_reduce r0, r12, lr
    montgomery_reduce r2, r12, lr
    pkhtb r0, r2, r0, asr #16
    vmov s5, r0 @ c1

    polymul_6x6_positive_cyclic_c3 r0, r9, r10, r11, r3, r5, r7
    polymul_6x6_positive_cyclic_c3 r2, r9, r10, r11, r4, r6, r8
    montgomery_reduce r0, r12, lr
    montgomery_reduce r2, r12, lr
    pkhtb r0, r2, r0, asr #16
    vmov s6, r0 @ c3

    polymul_6x6_positive_cyclic_c5 r0, r9, r10, r11, r3, r5, r7
    polymul_6x6_positive_cyclic_c5 r2, r9, r10, r11, r4, r6, r8
    montgomery_reduce r0, r12, lr
    montgomery_reduce r2, r12, lr
    pkhtb r0, r2, r0, asr #16
    vmov s7, r0 @ c5

    permute_05_21_43 r0, r3, r5, r7
    permute_05_21_43 r2, r4, r6, r8

    polymul_6x6_positive_cyclic_c0 r7, r9, r10, r11, r0, r3, r5
    polymul_6x6_positive_cyclic_c0 r8, r9, r10, r11, r2, r4, r6
    montgomery_reduce r7, r12, lr
    montgomery_reduce r8, r12, lr
    pkhtb r7, r8, r7, asr #16
    vmov s8, r7 @ c0

    polymul_6x6_positive_cyclic_c2 r7, r9, r10, r11, r0, r3, r5
    polymul_6x6_positive_cyclic_c2 r8, r9, r10, r11, r2, r4, r6
    montgomery_reduce r7, r12, lr
    montgomery_reduce r8, r12, lr
    pkhtb r7, r8, r7, asr #16
    vmov s9, r7 @ c2

    polymul_6x6_positive_cyclic_c4 r7, r9, r10, r11, r0, r3, r5
    polymul_6x6_positive_cyclic_c4 r8, r9, r10, r11, r2, r4, r6
    montgomery_reduce r7, r12, lr
    montgomery_reduce r8, r12, lr
    pkhtb r7, r8, r7, asr #16
    @ vmov s10, r7 @ c4

    ldr.w r2, [r1], #4
    vmov r0, lr, s0, s1
    vmov r3, r4, s4, s5
    vmov r5, r6, s6, s7

    sadd16 r3, r3, r2
    sadd16 r4, r4, r2
    sadd16 r5, r5, r2
    sadd16 r6, r6, r2
    sadd16 r7, r7, r2
    str.w r4, [r0, #3*basesize*2]
    str.w r5, [r0, #5*basesize*2]
    str.w r6, [r0, #6*basesize*2]
    str.w r7, [r0, #4*basesize*2]
    vmov r4, r5, s8, s9
    sadd16 r4, r4, r2
    sadd16 r5, r5, r2
    str.w r4, [r0, #2*basesize*2]
    str.w r5, [r0, #1*basesize*2]
    str.w r3, [r0], #4
    vmov s0, r0
    cmp.w r0, lr
    bne.w ntt7_rader_1176_body
    pop {r4-r11, pc}