#include "rader11_macro.S"

.p2align 2,,3
.syntax unified

.text
wpad:
    .word 302871355 @ qinv bot / q top
    .word 143917855
    .word 4184865787
    .word 4273144955
    .word 4170647182
    .word 131335039

.equ basesize, 72
.global ntt11_rader_792
.type ntt11_rader_792, %function
@ ntt11_rader_792(int16_t* fpad, int16_t* f); fpad : output, f : input
ntt11_rader_792:
    push {r4-r11, lr}
    vpush {s16-s18}
    adr r2, wpad
    ldr.w lr, [r2], #4
    vldm r2, {s11-s15}
    add.w r3, r0, #1*basesize*2
    vmov s2, r3
@f_seq :　[1, 2, 4, 8, 5, 10, 9, 7, 3, 6]
ntt11_rader_792_body:
    ldr.w r2, [r1, #1*basesize*2]
    ldr.w r7, [r1, #2*basesize*2]
    ldr.w r3, [r1, #4*basesize*2]
    ldr.w r8, [r1, #8*basesize*2]
    ldr.w r4, [r1, #5*basesize*2]
    ldr.w r9, [r1, #10*basesize*2]
    ldr.w r5, [r1, #9*basesize*2]
    ldr.w r10, [r1, #7*basesize*2]
    ldr.w r6, [r1, #3*basesize*2]
    ldr.w r11, [r1, #6*basesize*2]
    vmov s0, s1, r0, r1

    sadd16 r12, r2, r3
    sadd16 r12, r12, r4
    sadd16 r12, r12, r5
    sadd16 r12, r12, r6
    sadd16 r12, r12, r7
    sadd16 r12, r12, r8
    sadd16 r12, r12, r9
    sadd16 r12, r12, r10
    sadd16 r12, r12, r11

    pkhbt r1, r2, r7, lsl #16
    pkhtb r7, r7, r2, asr #16
    pkhbt r2, r3, r8, lsl #16
    pkhtb r8, r8, r3, asr #16
    pkhbt r3, r4, r9, lsl #16
    pkhtb r9, r9, r4, asr #16
    pkhbt r4, r5, r10, lsl #16
    pkhtb r10, r10, r5, asr #16
    pkhbt r5, r6, r11, lsl #16
    pkhtb r11, r11, r6, asr #16
@ s5 = sum(a1-a10), s6-s10 = b1-b10
    vmov s5, s6, r12, r7
    vmov s7, s8, r8, r9
    vmov s9, s10, r10, r11
    vmov r6, r7, s11, s12
    vmov r8, r9, s13, s14
    vmov r10, s15
    polymul_10x10_positive_cyclic_c1 r11, r6, r7, r8, r9, r10, r1, r2, r3, r4, r5
    polymul_10x10_positive_cyclic_c3 r12, r6, r7, r8, r9, r10, r1, r2, r3, r4, r5
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r0, r12, r11, asr #16 @ c1c3
    vmov s3, r0
    polymul_10x10_positive_cyclic_c5 r11, r6, r7, r8, r9, r10, r1, r2, r3, r4, r5
    polymul_10x10_positive_cyclic_c7 r12, r6, r7, r8, r9, r10, r1, r2, r3, r4, r5
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r0, r12, r11, asr #16 @ c5c7
    vmov s4, r0
    polymul_10x10_positive_cyclic_c9 r11, r6, r7, r8, r9, r10, r1, r2, r3, r4, r5
    montgomery_reduce r11, lr, r0
    permute10_09_21_43_65_87 r0, r1, r2, r3, r4, r5
    polymul_10x10_positive_cyclic_c8 r12, r6, r7, r8, r9, r10, r0, r1, r2, r3, r4
    montgomery_reduce r12, lr, r5
    pkhtb r5, r11, r12, asr #16 @ c8c9
    vmov s16, r5
    polymul_10x10_positive_cyclic_c0 r11, r6, r7, r8, r9, r10, r0, r1, r2, r3, r4
    polymul_10x10_positive_cyclic_c2 r12, r6, r7, r8, r9, r10, r0, r1, r2, r3, r4
    montgomery_reduce r11, lr, r5
    montgomery_reduce r12, lr, r5
    pkhtb r5, r12, r11, asr #16 @ c0c2
    polymul_10x10_positive_cyclic_c4 r11, r6, r7, r8, r9, r10, r0, r1, r2, r3, r4
    polymul_10x10_positive_cyclic_c6 r12, r6, r7, r8, r9, r10, r0, r1, r2, r3, r4
    montgomery_reduce r11, lr, r4
    montgomery_reduce r12, lr, r4
    pkhtb r4, r12, r11, asr #16 @ c4c6
    vmov s17, s18, r5, r4 @ c0c2 c4c6
@ s3 = c1c3, s4 = c5c7, s16 = c8c9, s17 = c0c2, s18 = c4c6
    vmov r1, r2, s6, s7
    vmov r3, r4, s8, s9
    vmov r5, s10
    polymul_10x10_positive_cyclic_c1 r11, r6, r7, r8, r9, r10, r1, r2, r3, r4, r5
    polymul_10x10_positive_cyclic_c3 r12, r6, r7, r8, r9, r10, r1, r2, r3, r4, r5
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r0, r12, r11, asr #16 @ d1d3
    vmov s6, r0
    polymul_10x10_positive_cyclic_c5 r11, r6, r7, r8, r9, r10, r1, r2, r3, r4, r5
    polymul_10x10_positive_cyclic_c7 r12, r6, r7, r8, r9, r10, r1, r2, r3, r4, r5
    montgomery_reduce r11, lr, r0
    montgomery_reduce r12, lr, r0
    pkhtb r0, r12, r11, asr #16 @ d5d7
    vmov s7, r0
    polymul_10x10_positive_cyclic_c9 r11, r6, r7, r8, r9, r10, r1, r2, r3, r4, r5
    montgomery_reduce r11, lr, r0
    permute10_09_21_43_65_87 r0, r1, r2, r3, r4, r5
    polymul_10x10_positive_cyclic_c8 r12, r6, r7, r8, r9, r10, r0, r1, r2, r3, r4
    montgomery_reduce r12, lr, r5
    pkhtb r5, r11, r12, asr #16 @ d8d9
    vmov s8, r5
    polymul_10x10_positive_cyclic_c0 r11, r6, r7, r8, r9, r10, r0, r1, r2, r3, r4
    polymul_10x10_positive_cyclic_c2 r12, r6, r7, r8, r9, r10, r0, r1, r2, r3, r4
    montgomery_reduce r11, lr, r5
    montgomery_reduce r12, lr, r5
    pkhtb r5, r12, r11, asr #16 @ d0d2
    polymul_10x10_positive_cyclic_c4 r11, r6, r7, r8, r9, r10, r0, r1, r2, r3, r4
    polymul_10x10_positive_cyclic_c6 r12, r6, r7, r8, r9, r10, r0, r1, r2, r3, r4
    montgomery_reduce r11, lr, r4
    montgomery_reduce r12, lr, r4
    pkhtb r6, r12, r11, asr #16 @ d4d6
@ s3 = c1c3, s4 = c5c7, s16 = c8c9, s17 = c0c2, s18 = c4c6, s6 = d1d3, s7 = d5d7, s8 = d8d9
    vmov r0, r1, s0, s1
    vmov r7, r8, s17, s18 @ c0c2, c4c6
    vmov r9, r10, s3, s4 @ c1c3, c5c7
    vmov r11, r12, s6, s7 @ d1d3, d5d7
    ldr.w r2, [r1], #4
    pkhbt r3, r7, r5, lsl #16 @ C0
    pkhtb r4, r5, r7, asr #16 @ C2
    pkhbt r5, r8, r6, lsl #16 @ C4
    pkhtb r6, r6, r8, asr #16 @ C6
    pkhbt r7, r9, r11, lsl #16 @ C1
    pkhtb r8, r11, r9, asr #16 @ C3
    pkhbt r9, r10, r12, lsl #16 @ C5
    pkhtb r10, r12, r10, asr #16 @ C7
    sadd16 r3, r3, r2
    sadd16 r4, r4, r2
    sadd16 r5, r5, r2
    sadd16 r6, r6, r2
    sadd16 r7, r7, r2
    sadd16 r8, r8, r2
    sadd16 r9, r9, r2
    sadd16 r10, r10, r2
    str.w r3, [r0, #5*basesize*2]
    str.w r4, [r0, #4*basesize*2]
    str.w r5, [r0, #1*basesize*2]
    str.w r6, [r0, #3*basesize*2]
    str.w r7, [r0, #8*basesize*2]
    str.w r8, [r0, #2*basesize*2]
    str.w r9, [r0, #6*basesize*2]
    str.w r10, [r0, #7*basesize*2]
    vmov r12, s2
    vmov r3, s5
    vmov r4, s16
    vmov r5, s8
    pkhbt r6, r4, r5, lsl #16 @ C8
    pkhtb r7, r5, r4, asr #16 @ C9
    sadd16 r3, r3, r2
    sadd16 r6, r6, r2
    sadd16 r7, r7, r2
    str.w r6, [r0, #9*basesize*2]
    str.w r7, [r0, #10*basesize*2]
    str.w r3, [r0], #4
    cmp.w r0, r12
    bne.w ntt11_rader_792_body
    vpop {s16-s18}
    pop {r4-r11, pc}





