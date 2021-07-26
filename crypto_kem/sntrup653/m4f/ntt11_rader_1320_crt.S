#include "rader11_macro.S"

.p2align 2,,3
.syntax unified

.text
wpad:
    .word 302871355 @ qinv bot / q top
    .word 126943465
    .word 4269275721
    .word 37158177
    .word 28442883
    .word 123403000

.equ basesize, 120
.global ntt11_rader_1320_crt1
.type ntt11_rader_1320_crt1, %function
@ ntt11_rader_1320_crt1(int16_t* fpad, int16_t* f); fpad : output, f : input
ntt11_rader_1320_crt1:
    push {r4-r11, lr}
    adr.w r2, wpad
    ldr.w lr, [r2], #4
    vldm r2, {s3-s7}
    add.w r2, r0, #1*basesize*2
    vmov s0, s1, r0, r1
    vmov s2, r2
@ f_seq :　[1, 2, 4, 8, 5, 10, 9, 7, 3, 6]
@ w_seq :　[5, 8, 4, 2, 1, 6, 3, 7, 9, 10]
ntt11_rader_1320_crt1_crt_positive_5x5:
    ldr.w r2, [r1, #1*basesize*2]
    ldr.w r3, [r1, #2*basesize*2]
    ldr.w r4, [r1, #4*basesize*2]
    ldr.w r5, [r1, #8*basesize*2]
    ldr.w r6, [r1, #5*basesize*2]
    ldr.w r7, [r1, #10*basesize*2]
    ldr.w r8, [r1, #9*basesize*2]
    ldr.w r9, [r1, #7*basesize*2]
    ldr.w r10, [r1, #3*basesize*2]
    ldr.w r11, [r1, #6*basesize*2]
    
    ssub16 r12, r6, r11
    sadd16 r6, r6, r11
    ssub16 r11, r5, r10
    sadd16 r5, r5, r10
    ssub16 r10, r4, r9
    sadd16 r4, r4, r9
    ssub16 r9, r3, r8
    sadd16 r3, r3, r8
    ssub16 r8, r2, r7
    sadd16 r2, r2, r7

    sadd16 r7, r2, r3
    sadd16 r7, r7, r4
    sadd16 r7, r7, r5
    sadd16 r7, r7, r6

    str.w r8, [r0, #6*basesize*2]
    str.w r9, [r0, #7*basesize*2]
    str.w r10, [r0, #8*basesize*2]
    str.w r11, [r0, #9*basesize*2]
    str.w r12, [r0, #10*basesize*2]

    ldr.w r8, [r1], #4
    sadd16 r7, r7, r8
    str.w r7, [r0]

    vmov r7, r8, s3, s4
    vmov r9, s5

    polymul_5x5_positive_cyclic_c0_bot r10, r2, r3, r4, r5, r6, r7, r8, r9
    polymul_5x5_positive_cyclic_c0_top r11, r2, r3, r4, r5, r6, r7, r8, r9
    montgomery_reduce r10, lr, r12
    montgomery_reduce r11, lr, r12
    pkhtb r10, r11, r10, asr #16
    str.w r10, [r0, #1*basesize*2]

    polymul_5x5_positive_cyclic_c1_bot r10, r2, r3, r4, r5, r6, r7, r8, r9
    polymul_5x5_positive_cyclic_c1_top r11, r2, r3, r4, r5, r6, r7, r8, r9
    montgomery_reduce r10, lr, r12
    montgomery_reduce r11, lr, r12
    pkhtb r10, r11, r10, asr #16
    str.w r10, [r0, #2*basesize*2]

    polymul_5x5_positive_cyclic_c2_bot r10, r2, r3, r4, r5, r6, r7, r8, r9
    polymul_5x5_positive_cyclic_c2_top r11, r2, r3, r4, r5, r6, r7, r8, r9
    montgomery_reduce r10, lr, r12
    montgomery_reduce r11, lr, r12
    pkhtb r10, r11, r10, asr #16
    str.w r10, [r0, #3*basesize*2]

    polymul_5x5_positive_cyclic_c3_bot r10, r2, r3, r4, r5, r6, r7, r8, r9
    polymul_5x5_positive_cyclic_c3_top r11, r2, r3, r4, r5, r6, r7, r8, r9
    montgomery_reduce r10, lr, r12
    montgomery_reduce r11, lr, r12
    pkhtb r10, r11, r10, asr #16
    str.w r10, [r0, #4*basesize*2]

    polymul_5x5_positive_cyclic_c4_bot r10, r2, r3, r4, r5, r6, r7, r8, r9
    polymul_5x5_positive_cyclic_c4_top r11, r2, r3, r4, r5, r6, r7, r8, r9
    montgomery_reduce r10, lr, r12
    montgomery_reduce r11, lr, r12
    pkhtb r10, r11, r10, asr #16
    str.w r10, [r0, #5*basesize*2]

    vmov r2, s2
    add.w r0, r0, #4
    cmp.w r0, r2
    bne.w ntt11_rader_1320_crt1_crt_positive_5x5

    vmov r0, r1, s0, s1
    vmov r7, r8, s6, s7
@ r7 = w12, r8 = w34, r9 = w0_top
@ w_seq :　[5, 8, 4, 2, 1, 6, 3, 7, 9, 10]
ntt11_rader_1320_crt1_negative_5x5_output:
    ldr.w r2, [r0, #6*basesize*2]
    ldr.w r3, [r0, #7*basesize*2]
    ldr.w r4, [r0, #8*basesize*2]
    ldr.w r5, [r0, #9*basesize*2]
    ldr.w r6, [r0, #10*basesize*2]

    polymul_5x5_negative_cyclic_c0_bot r10, r2, r3, r4, r5, r6, r7, r8, r9, r12
    polymul_5x5_negative_cyclic_c0_top r11, r2, r3, r4, r5, r6, r7, r8, r9, r12
    montgomery_reduce r10, lr, r12
    montgomery_reduce r11, lr, r12
    pkhtb r10, r11, r10, asr #16
    str.w r10, [r0, #6*basesize*2]

    polymul_5x5_negative_cyclic_c1_bot r10, r2, r3, r4, r5, r6, r7, r8, r9, r12
    polymul_5x5_negative_cyclic_c1_top r11, r2, r3, r4, r5, r6, r7, r8, r9, r12
    montgomery_reduce r10, lr, r12
    montgomery_reduce r11, lr, r12
    pkhtb r10, r11, r10, asr #16
    str.w r10, [r0, #7*basesize*2]

    polymul_5x5_negative_cyclic_c2_bot r10, r2, r3, r4, r5, r6, r7, r8, r9, r12
    polymul_5x5_negative_cyclic_c2_top r11, r2, r3, r4, r5, r6, r7, r8, r9, r12
    montgomery_reduce r10, lr, r12
    montgomery_reduce r11, lr, r12
    pkhtb r10, r11, r10, asr #16
    str.w r10, [r0, #8*basesize*2]

    polymul_5x5_negative_cyclic_c3_bot r10, r2, r3, r4, r5, r6, r7, r8, r9, r12
    polymul_5x5_negative_cyclic_c3_top r11, r2, r3, r4, r5, r6, r7, r8, r9, r12
    montgomery_reduce r10, lr, r12
    montgomery_reduce r11, lr, r12
    pkhtb r10, r11, r10, asr #16

    polymul_5x5_negative_cyclic_c4_bot r11, r2, r3, r4, r5, r6, r7, r8, r9, noneed
    polymul_5x5_negative_cyclic_c4_top r12, r2, r3, r4, r5, r6, r7, r8, r9, noneed
    montgomery_reduce r11, lr, r2
    montgomery_reduce r12, lr, r2
    pkhtb r11, r12, r11, asr #16

    ldr.w r2, [r1], #4
    ldr.w r5, [r0, #4*basesize*2]
    ldr.w r6, [r0, #5*basesize*2]
    
    sadd16 r3, r5, r10
    sadd16 r4, r6, r11
    ssub16 r5, r5, r10
    ssub16 r6, r6, r11

    sadd16 r3, r3, r2
    sadd16 r4, r4, r2
    sadd16 r5, r5, r2
    sadd16 r6, r6, r2

    str.w r5, [r0, #9*basesize*2]
    str.w r6, [r0, #10*basesize*2]

    ldr.w r5, [r0, #1*basesize*2]
    ldr.w r6, [r0, #2*basesize*2]

    str.w r3, [r0, #2*basesize*2]
    str.w r4, [r0, #1*basesize*2]
    
    ldr.w r10, [r0, #6*basesize*2]
    ldr.w r11, [r0, #7*basesize*2]

    sadd16 r3, r5, r10
    sadd16 r4, r6, r11
    ssub16 r5, r5, r10
    ssub16 r6, r6, r11

    sadd16 r3, r3, r2
    sadd16 r4, r4, r2
    sadd16 r5, r5, r2
    sadd16 r6, r6, r2

    ldr.w r10, [r0, #3*basesize*2]
    ldr.w r11, [r0, #8*basesize*2]

    str.w r3, [r0, #5*basesize*2]
    str.w r4, [r0, #8*basesize*2]
    str.w r5, [r0, #6*basesize*2]
    str.w r6, [r0, #3*basesize*2]
    
    sadd16 r3, r10, r11
    ssub16 r4, r10, r11
    sadd16 r3, r3, r2
    sadd16 r4, r4, r2
    str.w r3, [r0, #4*basesize*2]
    str.w r4, [r0, #7*basesize*2]
    
    vmov r2, s2
    add.w r0, r0, #4
    cmp.w r0, r2
    bne.w ntt11_rader_1320_crt1_negative_5x5_output

    pop {r4-r11, pc}





