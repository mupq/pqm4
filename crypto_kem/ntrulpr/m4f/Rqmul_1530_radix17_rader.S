.p2align 2,,3
.syntax unified

.data
buffer: .space 64

.text
buffer_bridge:
    .word buffer
wpad:
    .word 935519
    .word 40500057
    .word 86900888
    .word 61146163
    .word 4158194321
    .word 28375972
    .word 25823139
    .word 4251253512
    .word 4220778258

.global ntt17_rader
.type ntt17_rader, %function
ntt17_rader:
@ ntt17_rader(int16_t* f, int16_t* fpad
    push {r2-r12, lr}
    vpush {s16-s18}
    add.w r2, r0, #80
    add.w r3, r0, #180
    ldr.w lr, buffer_bridge
    adr r4, wpad
    vldm r4, {s4-s12}
    @ s0 for input address
    vmov s1, r1 @ output address
    vmov s2, r2 @ loop1 end
    vmov s3, r3 @ loop2 end
ntt17_rader_body1:
    ldr.w r1, [r0, #1080] @ a6 
    ldr.w r2, [r0, #360] @ a2
    ldr.w r3, [r0, #900] @ a5
    ldr.w r4, [r0, #720] @ a4
    ldr.w r5, [r0, #1260] @ a7
    ldr.w r6, [r0, #1440] @ a8
    ldr.w r7, [r0, #540] @ a3
    ldr.w r8, [r0, #180] @ a1
@ 6 2 5 4 7 8 3 1, -6 -2 5 -4 -7 -8 3 1
    ldr.w r9, [r0], #4
    vmov s13, r9 @ a0a1
    vmov s0, r0
    sadd16 r9, r9, r1
    sadd16 r9, r9, r2
    sadd16 r9, r9, r3
    sadd16 r9, r9, r4
    sadd16 r9, r9, r5
    sadd16 r9, r9, r6
    sadd16 r9, r9, r7
    sadd16 r9, r9, r8
    vmov s14, r9 @ b0b1
    mov.w r0, #0
    pkhbt r9, r7, r8, lsl #16 @ a3a1
    pkhtb r10, r8, r7, asr #16
    pkhbt r11, r3, r4, lsl #16 @ a5a4
    pkhtb r12, r4, r3, asr #16
    ssub16 r3, r0, r4 @ -a4
    pkhtb r4, r3, r12 @ a'5 -a'4
    pkhbt r3, r11, r3, lsl #16 @ a5 -a4
    ssub16 r7, r11, r9 @ a5a4 - a3a1
    ssub16 r8, r12, r10
    str.w r9, [lr, #28] @ a3a1
    str.w r10, [lr, #60]
    str.w r3, [lr, #20] @ a5 -a4
    str.w r4, [lr, #52]
    str.w r7, [lr, #12] @ a5a4 - a3a1
    str.w r8, [lr, #44]
    sadd16 r11, r11, r9 @ a5a4 + a3a1
    sadd16 r12, r12, r10
    pkhbt r3, r1, r2, lsl #16 @ a6a2
    pkhtb r4, r2 ,r1, asr #16
    pkhbt r7, r5, r6, lsl #16 @ a7a8
    pkhtb r8, r6, r5, asr #16
    ssub16 r9, r0, r7 @ -a7 -a8
    ssub16 r10, r0, r8
    ssub16 r5, r0, r3 @ -a6 -a2
    ssub16 r6, r0, r4
    ssub16 r1, r3, r7 @ a6a2 - a7a8
    ssub16 r2, r4, r8
    sadd16 r7, r3, r7 @ a6a2 + a7a8
    sadd16 r8, r4, r8
    str.w r9, [lr, #24] @ -a7 -a8
    str.w r10, [lr, #56]
    str.w r5, [lr, #16] @ -a6 -a2
    str.w r6, [lr, #48]
    str.w r1, [lr, #8] @ a6a2 - a7a8
    str.w r2, [lr, #40]
    @ 2x2 mod x^2 - 1, x^2 + 1
    @ r7 r8, r11 r12
    vmov r5, s5
    vmov r6, s6
    vmov r9, s4 @ qinv
    mov.w r10, #4591
    sadd16 r1, r7, r11 @ a6278 + a5431
    sadd16 r2, r8, r12
    ssub16 r3, r7, r11 @ a6278 - a5431
    ssub16 r4, r8, r12
    smuad r7, r1, r5 @ a0b0 + a1b1
    smuadx r8, r1, r5 @ a0b1 + a1b0
    smmulr r1, r7, r9
    mls r7, r1, r10, r7
    smmulr r1, r8, r9
    mls r8, r1, r10, r8
    pkhbt r1, r7, r8, lsl #16 @ b0b1
    smuad r7, r2, r5 @ a0b0 + a1b1
    smuadx r8, r2, r5 @ a0b1 + a1b0
    smmulr r2, r7, r9
    mls r7, r2, r10, r7
    smmulr r2, r8, r9
    mls r8, r2, r10, r8
    pkhbt r2, r7, r8, lsl #16 @ b'0b'1
    smusd r7, r3, r6 @ a0b0 - a1b1
    smuadx r8, r3, r6 @ a0b1 + a1b0
    smmulr r3, r7, r9
    mls r7, r3, r10, r7
    smmulr r3, r8, r9
    mls r8, r3, r10, r8
    pkhbt r3, r7, r8, lsl #16 @ b2b3
    smusd r7, r4, r6 @ a0b0 - a1b1
    smuadx r8, r4, r6 @ a0b1 + a1b0
    smmulr r4, r7, r9
    mls r7, r4, r10, r7
    smmulr r4, r8, r9
    mls r8, r4, r10, r8
    pkhbt r4, r7, r8, lsl #16 @ b'2b'3
    sadd16 r5, r1, r3
    ssub16 r6, r1, r3 @ r5r6 = b0b1b2b3 / x^4 -1
    sadd16 r7, r2, r4
    ssub16 r8, r2, r4
@ TODO : 4x4 mod x^4 + 1
    ldr.w r1, [lr, #8] @ a0a1
    ldr.w r2, [lr, #12] @ a2a3
    vmov r3, s7 @ b0b1
    vmov r4, s8 @ b2b3
@ free r0, r11, r12
    smuadx r11, r1, r3 @ a0b1 + a1b0
    smuadx r12, r2, r4 @ a2b3 + a3b2
    sub.w r11, r11, r12 @ c1
    smuadx r12, r1, r4
    smladx r12, r2, r3, r12 @ c3
    smmulr r0, r11, r9
    mls r11, r0, r10, r11 @ bar(c1)
    smmulr r0, r12, r9
    mls r12, r0, r10, r12 @ bar(c3)
    pkhbt r0, r1, r2 @ a0a3
    pkhtb r1, r1, r2 @ a2a1
    smusd r2, r0, r4 @ a0b2 - a3b3
    smlad r2, r1, r3, r2 @ c2
    smusd r0, r0, r3 @ a0b0 - a3b1
    smuad r1, r1, r4 @ a2b2 + a1b3
    sub.w r1, r0, r1 @ c0
    smmulr r0, r1, r9
    mls r1, r0, r10, r1 @ bar(c0)
    smmulr r0, r2, r9
    mls r2, r0, r10, r2 @ bar(c2)
    pkhbt r1, r1, r11, lsl #16 @ c0c1
    pkhbt r2, r2, r12, lsl #16 @ c2c3
    sadd16 r11, r5, r1
    sadd16 r12, r6, r2
    ssub16 r5, r5, r1
    ssub16 r6, r6, r2 @ r11 r12 r5 r6 = 8x8 mod x^8 - 1
    str.w r11, [lr]
    str.w r12, [lr, #4]
    str.w r5, [lr, #8]
    str.w r6, [lr, #12]
    ldr.w r1, [lr, #40]
    ldr.w r2, [lr, #44]
    smuadx r11, r1, r3 @ a0b1 + a1b0
    smuadx r12, r2, r4 @ a2b3 + a3b2
    sub.w r11, r11, r12 @ c1
    smuadx r12, r1, r4
    smladx r12, r2, r3, r12 @ c3
    smmulr r0, r11, r9
    mls r11, r0, r10, r11 @ bar(c1)
    smmulr r0, r12, r9
    mls r12, r0, r10, r12 @ bar(c3)
    pkhbt r0, r1, r2 @ a0a3
    pkhtb r1, r1, r2 @ a2a1
    smusd r2, r0, r4 @ a0b2 - a3b3
    smlad r2, r1, r3, r2 @ c2
    smusd r0, r0, r3 @ a0b0 - a3b1
    smuad r1, r1, r4 @ a2b2 + a1b3
    sub.w r1, r0, r1 @ c0
    smmulr r0, r1, r9
    mls r1, r0, r10, r1 @ bar(c0)
    smmulr r0, r2, r9
    mls r2, r0, r10, r2 @ bar(c2)
    pkhbt r1, r1, r11, lsl #16 @ c0c1
    pkhbt r2, r2, r12, lsl #16 @ c2c3
    sadd16 r11, r7, r1
    sadd16 r12, r8, r2
    ssub16 r5, r7, r1
    ssub16 r6, r8, r2 @ r11 r12 r5 r6 = 8x8 mod x^8 - 1
    str.w r11, [lr, #32]
    str.w r12, [lr, #36]
    str.w r5, [lr, #40]
    str.w r6, [lr, #44]
@ DONE : 4x4 mod x^4 + 1 and back to x^8 - 1
@ TODO : first 8x8 mod x^8 + 1
    ldr.w r1, [lr, #16] @ a0a1
    ldr.w r2, [lr, #20] @ a2a3
    ldr.w r3, [lr, #24] @ a4a5
    ldr.w r4, [lr, #28] @ a6a7
    vmov r5, s9 @ b0b1
    vmov r6, s10 @ b2b3
    vmov r7, s11 @ b4b5
    vmov r8, s12 @ b6b7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    sadd16 r0, r1, r9 @ #0
    ssub16 r9, r1, r9 @ #16
    sadd16 r1, r2, r10 @ #4
    ssub16 r10, r2, r10 @ #20
    sadd16 r2, r3, r11 @ #8
    ssub16 r11, r3, r11 @ #24
    sadd16 r3, r4, r12 @ #12
    ssub16 r12, r4, r12 @ #28
    str.w r0, [lr]
    str.w r1, [lr, #4]
    str.w r2, [lr, #8]
    str.w r3, [lr, #12]
    str.w r9, [lr, #16]
    str.w r10, [lr, #20]
    str.w r11, [lr, #24]
    str.w r12, [lr, #28]
    @ second 8x8 mod x^8 + 1 
    ldr.w r1, [lr, #48]
    ldr.w r2, [lr, #52]
    ldr.w r3, [lr, #56]
    ldr.w r4, [lr, #60]
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #32]
    ldr.w r2, [lr, #36]
    ldr.w r3, [lr, #40]
    ldr.w r4, [lr, #44]
    vmov r5, s13 @ a0a1
    ldr.w r6, [lr]
    ldr.w r7, [lr, #4]
    ldr.w r8, [lr, #8]
    sadd16 r0, r1, r9 @ # 32 + 0
    ssub16 r9, r1, r9 @ # 32 + 16
    sadd16 r1, r2, r10 @ # 32 + 4
    ssub16 r10, r2, r10 @ # 32 + 20
    sadd16 r2, r3, r11 @ # 32 + 8
    ssub16 r11, r3, r11 @ # 32 + 24
    sadd16 r3, r4, r12 @ # 32 + 12
    ssub16 r12, r4, r12 @ # 32 + 28
    pkhbt r4, r6, r0, lsl #16 @ d0
    pkhtb r6, r0, r6, asr #16 @ d1
    pkhbt r0, r7, r1, lsl #16 @ d2
    pkhtb r7, r1, r7, asr #16 @ d3
    pkhbt r1, r8, r2, lsl #16 @ d4
    pkhtb r8, r2, r8, asr #16 @ d5
    sadd16 r4, r4, r5
    sadd16 r6, r6, r5
    sadd16 r0, r0, r5
    sadd16 r7, r7, r5
    sadd16 r1, r1, r5
    sadd16 r8, r8, r5    
    vmov r2, s1
    str.w r4, [r2, #2520]
    str.w r6, [r2, #1440]
    str.w r0, [r2, #1260]
    str.w r7, [r2, #720]
    str.w r1, [r2, #2160]
    str.w r8, [r2, #360]
    ldr.w r0, [lr, #12]
    ldr.w r1, [lr, #16]
    ldr.w r4, [lr, #20]
    ldr.w r6, [lr, #24]
    ldr.w r7, [lr, #28]
    pkhbt r8, r0, r3, lsl #16 @ d6
    pkhtb r0, r3, r0, asr #16 @ d7
    pkhbt r3, r1, r9, lsl #16 @ d8
    pkhtb r1, r9, r1, asr #16 @ d9
    pkhbt r9, r4, r10, lsl #16 @ d10
    pkhtb r4, r10, r4, asr #16 @ d11
    pkhbt r10, r6, r11, lsl #16 @ d12
    pkhtb r6, r11, r6, asr #16 @ d13
    pkhbt r11, r7, r12, lsl #16 @ d14
    pkhtb r7, r12, r7, asr #16 @ d15
    sadd16 r8, r8, r5
    sadd16 r0, r0, r5
    sadd16 r3, r3, r5
    sadd16 r1, r1, r5
    sadd16 r9, r9, r5
    sadd16 r4, r4, r5
    sadd16 r10, r10, r5
    sadd16 r6, r6, r5
    sadd16 r11, r11, r5
    sadd16 r7, r7, r5
    vmov r5, s14
    str.w r8, [r2, #1080]
    str.w r0, [r2, #180]
    str.w r3, [r2, #540]
    str.w r1, [r2, #1620]
    str.w r9, [r2, #1800]
    str.w r4, [r2, #2340]
    str.w r10, [r2, #900]
    str.w r6, [r2, #2700]
    str.w r11, [r2, #1980]
    str.w r7, [r2, #2880]
    str.w r5, [r2], #4
    vmov s1, r2
    vmov r0, s0
    vmov r1, s2
    cmp.w r0, r1
    bne.w ntt17_rader_body1
    @ special case for a760a761
    ldr.w r1, [r0, #1080] @ a6 
    ldr.w r2, [r0, #360] @ a2
    ldr.w r3, [r0, #900] @ a5
    ldr.w r4, [r0, #720] @ a4
    ldr.w r5, [r0, #1260] @ a7
    ldr.w r6, [r0, #1440] @ a8
    ldr.w r7, [r0, #540] @ a3
    ldr.w r8, [r0, #180] @ a1
@ 6 2 5 4 7 8 3 1, -6 -2 5 -4 -7 -8 3 1
    ldr.w r9, [r0], #4
    vmov s13, r9 @ a0a1
    vmov s0, r0
    ubfx r6, r6, #0, #16
    sadd16 r9, r9, r1
    sadd16 r9, r9, r2
    sadd16 r9, r9, r3
    sadd16 r9, r9, r4
    sadd16 r9, r9, r5
    sadd16 r9, r9, r6
    sadd16 r9, r9, r7
    sadd16 r9, r9, r8
    vmov s14, r9 @ b0b1
    mov.w r0, #0
    pkhbt r9, r7, r8, lsl #16 @ a3a1
    pkhtb r10, r8, r7, asr #16
    pkhbt r11, r3, r4, lsl #16 @ a5a4
    pkhtb r12, r4, r3, asr #16
    ssub16 r3, r0, r4 @ -a4
    pkhtb r4, r3, r12 @ a'5 -a'4
    pkhbt r3, r11, r3, lsl #16 @ a5 -a4
    ssub16 r7, r11, r9 @ a5a4 - a3a1
    ssub16 r8, r12, r10
    str.w r9, [lr, #28] @ a3a1
    str.w r10, [lr, #60]
    str.w r3, [lr, #20] @ a5 -a4
    str.w r4, [lr, #52]
    str.w r7, [lr, #12] @ a5a4 - a3a1
    str.w r8, [lr, #44]
    sadd16 r11, r11, r9 @ a5a4 + a3a1
    sadd16 r12, r12, r10
    pkhbt r3, r1, r2, lsl #16 @ a6a2
    pkhtb r4, r2 ,r1, asr #16
    pkhbt r7, r5, r6, lsl #16 @ a7a8
    pkhtb r8, r6, r5, asr #16
    ssub16 r9, r0, r7 @ -a7 -a8
    ssub16 r10, r0, r8
    ssub16 r5, r0, r3 @ -a6 -a2
    ssub16 r6, r0, r4
    ssub16 r1, r3, r7 @ a6a2 - a7a8
    ssub16 r2, r4, r8
    sadd16 r7, r3, r7 @ a6a2 + a7a8
    sadd16 r8, r4, r8
    str.w r9, [lr, #24] @ -a7 -a8
    str.w r10, [lr, #56]
    str.w r5, [lr, #16] @ -a6 -a2
    str.w r6, [lr, #48]
    str.w r1, [lr, #8] @ a6a2 - a7a8
    str.w r2, [lr, #40]
    @ 2x2 mod x^2 - 1, x^2 + 1
    @ r7 r8, r11 r12
    vmov r5, s5
    vmov r6, s6
    vmov r9, s4 @ qinv
    mov.w r10, #4591
    sadd16 r1, r7, r11 @ a6278 + a5431
    sadd16 r2, r8, r12
    ssub16 r3, r7, r11 @ a6278 - a5431
    ssub16 r4, r8, r12
    smuad r7, r1, r5 @ a0b0 + a1b1
    smuadx r8, r1, r5 @ a0b1 + a1b0
    smmulr r1, r7, r9
    mls r7, r1, r10, r7
    smmulr r1, r8, r9
    mls r8, r1, r10, r8
    pkhbt r1, r7, r8, lsl #16 @ b0b1
    smuad r7, r2, r5 @ a0b0 + a1b1
    smuadx r8, r2, r5 @ a0b1 + a1b0
    smmulr r2, r7, r9
    mls r7, r2, r10, r7
    smmulr r2, r8, r9
    mls r8, r2, r10, r8
    pkhbt r2, r7, r8, lsl #16 @ b'0b'1
    smusd r7, r3, r6 @ a0b0 - a1b1
    smuadx r8, r3, r6 @ a0b1 + a1b0
    smmulr r3, r7, r9
    mls r7, r3, r10, r7
    smmulr r3, r8, r9
    mls r8, r3, r10, r8
    pkhbt r3, r7, r8, lsl #16 @ b2b3
    smusd r7, r4, r6 @ a0b0 - a1b1
    smuadx r8, r4, r6 @ a0b1 + a1b0
    smmulr r4, r7, r9
    mls r7, r4, r10, r7
    smmulr r4, r8, r9
    mls r8, r4, r10, r8
    pkhbt r4, r7, r8, lsl #16 @ b'2b'3
    sadd16 r5, r1, r3
    ssub16 r6, r1, r3 @ r5r6 = b0b1b2b3 / x^4 -1
    sadd16 r7, r2, r4
    ssub16 r8, r2, r4
@ TODO : 4x4 mod x^4 + 1
    ldr.w r1, [lr, #8] @ a0a1
    ldr.w r2, [lr, #12] @ a2a3
    vmov r3, s7 @ b0b1
    vmov r4, s8 @ b2b3
@ free r0, r11, r12
    smuadx r11, r1, r3 @ a0b1 + a1b0
    smuadx r12, r2, r4 @ a2b3 + a3b2
    sub.w r11, r11, r12 @ c1
    smuadx r12, r1, r4
    smladx r12, r2, r3, r12 @ c3
    smmulr r0, r11, r9
    mls r11, r0, r10, r11 @ bar(c1)
    smmulr r0, r12, r9
    mls r12, r0, r10, r12 @ bar(c3)
    pkhbt r0, r1, r2 @ a0a3
    pkhtb r1, r1, r2 @ a2a1
    smusd r2, r0, r4 @ a0b2 - a3b3
    smlad r2, r1, r3, r2 @ c2
    smusd r0, r0, r3 @ a0b0 - a3b1
    smuad r1, r1, r4 @ a2b2 + a1b3
    sub.w r1, r0, r1 @ c0
    smmulr r0, r1, r9
    mls r1, r0, r10, r1 @ bar(c0)
    smmulr r0, r2, r9
    mls r2, r0, r10, r2 @ bar(c2)
    pkhbt r1, r1, r11, lsl #16 @ c0c1
    pkhbt r2, r2, r12, lsl #16 @ c2c3
    sadd16 r11, r5, r1
    sadd16 r12, r6, r2
    ssub16 r5, r5, r1
    ssub16 r6, r6, r2 @ r11 r12 r5 r6 = 8x8 mod x^8 - 1
    str.w r11, [lr]
    str.w r12, [lr, #4]
    str.w r5, [lr, #8]
    str.w r6, [lr, #12]
    ldr.w r1, [lr, #40]
    ldr.w r2, [lr, #44]
    smuadx r11, r1, r3 @ a0b1 + a1b0
    smuadx r12, r2, r4 @ a2b3 + a3b2
    sub.w r11, r11, r12 @ c1
    smuadx r12, r1, r4
    smladx r12, r2, r3, r12 @ c3
    smmulr r0, r11, r9
    mls r11, r0, r10, r11 @ bar(c1)
    smmulr r0, r12, r9
    mls r12, r0, r10, r12 @ bar(c3)
    pkhbt r0, r1, r2 @ a0a3
    pkhtb r1, r1, r2 @ a2a1
    smusd r2, r0, r4 @ a0b2 - a3b3
    smlad r2, r1, r3, r2 @ c2
    smusd r0, r0, r3 @ a0b0 - a3b1
    smuad r1, r1, r4 @ a2b2 + a1b3
    sub.w r1, r0, r1 @ c0
    smmulr r0, r1, r9
    mls r1, r0, r10, r1 @ bar(c0)
    smmulr r0, r2, r9
    mls r2, r0, r10, r2 @ bar(c2)
    pkhbt r1, r1, r11, lsl #16 @ c0c1
    pkhbt r2, r2, r12, lsl #16 @ c2c3
    sadd16 r11, r7, r1
    sadd16 r12, r8, r2
    ssub16 r5, r7, r1
    ssub16 r6, r8, r2 @ r11 r12 r5 r6 = 8x8 mod x^8 - 1
    str.w r11, [lr, #32]
    str.w r12, [lr, #36]
    str.w r5, [lr, #40]
    str.w r6, [lr, #44]
@ DONE : 4x4 mod x^4 + 1 and back to x^8 - 1
@ TODO : first 8x8 mod x^8 + 1
    ldr.w r1, [lr, #16] @ a0a1
    ldr.w r2, [lr, #20] @ a2a3
    ldr.w r3, [lr, #24] @ a4a5
    ldr.w r4, [lr, #28] @ a6a7
    vmov r5, s9 @ b0b1
    vmov r6, s10 @ b2b3
    vmov r7, s11 @ b4b5
    vmov r8, s12 @ b6b7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    sadd16 r0, r1, r9 @ #0
    ssub16 r9, r1, r9 @ #16
    sadd16 r1, r2, r10 @ #4
    ssub16 r10, r2, r10 @ #20
    sadd16 r2, r3, r11 @ #8
    ssub16 r11, r3, r11 @ #24
    sadd16 r3, r4, r12 @ #12
    ssub16 r12, r4, r12 @ #28
    str.w r0, [lr]
    str.w r1, [lr, #4]
    str.w r2, [lr, #8]
    str.w r3, [lr, #12]
    str.w r9, [lr, #16]
    str.w r10, [lr, #20]
    str.w r11, [lr, #24]
    str.w r12, [lr, #28]
    @ second 8x8 mod x^8 + 1 
    ldr.w r1, [lr, #48]
    ldr.w r2, [lr, #52]
    ldr.w r3, [lr, #56]
    ldr.w r4, [lr, #60]
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #32]
    ldr.w r2, [lr, #36]
    ldr.w r3, [lr, #40]
    ldr.w r4, [lr, #44]
    vmov r5, s13 @ a0a1
    ldr.w r6, [lr]
    ldr.w r7, [lr, #4]
    ldr.w r8, [lr, #8]
    sadd16 r0, r1, r9 @ # 32 + 0
    ssub16 r9, r1, r9 @ # 32 + 16
    sadd16 r1, r2, r10 @ # 32 + 4
    ssub16 r10, r2, r10 @ # 32 + 20
    sadd16 r2, r3, r11 @ # 32 + 8
    ssub16 r11, r3, r11 @ # 32 + 24
    sadd16 r3, r4, r12 @ # 32 + 12
    ssub16 r12, r4, r12 @ # 32 + 28
    pkhbt r4, r6, r0, lsl #16 @ d0
    pkhtb r6, r0, r6, asr #16 @ d1
    pkhbt r0, r7, r1, lsl #16 @ d2
    pkhtb r7, r1, r7, asr #16 @ d3
    pkhbt r1, r8, r2, lsl #16 @ d4
    pkhtb r8, r2, r8, asr #16 @ d5
    sadd16 r4, r4, r5
    sadd16 r6, r6, r5
    sadd16 r0, r0, r5
    sadd16 r7, r7, r5
    sadd16 r1, r1, r5
    sadd16 r8, r8, r5    
    vmov r2, s1
    str.w r4, [r2, #2520]
    str.w r6, [r2, #1440]
    str.w r0, [r2, #1260]
    str.w r7, [r2, #720]
    str.w r1, [r2, #2160]
    str.w r8, [r2, #360]
    ldr.w r0, [lr, #12]
    ldr.w r1, [lr, #16]
    ldr.w r4, [lr, #20]
    ldr.w r6, [lr, #24]
    ldr.w r7, [lr, #28]
    pkhbt r8, r0, r3, lsl #16 @ d6
    pkhtb r0, r3, r0, asr #16 @ d7
    pkhbt r3, r1, r9, lsl #16 @ d8
    pkhtb r1, r9, r1, asr #16 @ d9
    pkhbt r9, r4, r10, lsl #16 @ d10
    pkhtb r4, r10, r4, asr #16 @ d11
    pkhbt r10, r6, r11, lsl #16 @ d12
    pkhtb r6, r11, r6, asr #16 @ d13
    pkhbt r11, r7, r12, lsl #16 @ d14
    pkhtb r7, r12, r7, asr #16 @ d15
    sadd16 r8, r8, r5
    sadd16 r0, r0, r5
    sadd16 r3, r3, r5
    sadd16 r1, r1, r5
    sadd16 r9, r9, r5
    sadd16 r4, r4, r5
    sadd16 r10, r10, r5
    sadd16 r6, r6, r5
    sadd16 r11, r11, r5
    sadd16 r7, r7, r5
    vmov r5, s14
    str.w r8, [r2, #1080]
    str.w r0, [r2, #180]
    str.w r3, [r2, #540]
    str.w r1, [r2, #1620]
    str.w r9, [r2, #1800]
    str.w r4, [r2, #2340]
    str.w r10, [r2, #900]
    str.w r6, [r2, #2700]
    str.w r11, [r2, #1980]
    str.w r7, [r2, #2880]
    str.w r5, [r2], #4
    vmov s1, r2
    vmov r0, s0
ntt17_rader_body2:
    ldr.w r1, [r0, #1080] @ a6 
    ldr.w r2, [r0, #360] @ a2
    ldr.w r3, [r0, #900] @ a5
    ldr.w r4, [r0, #720] @ a4
    ldr.w r5, [r0, #1260] @ a7
    mov.w r6, #0
    @ ldr.w r6, [r0, #1440] @ a8
    ldr.w r7, [r0, #540] @ a3
    ldr.w r8, [r0, #180] @ a1
@ 6 2 5 4 7 8 3 1, -6 -2 5 -4 -7 -8 3 1
    ldr.w r9, [r0], #4
    vmov s13, r9 @ a0a1
    vmov s0, r0
    sadd16 r9, r9, r1
    sadd16 r9, r9, r2
    sadd16 r9, r9, r3
    sadd16 r9, r9, r4
    sadd16 r9, r9, r5
    @ sadd16 r9, r9, r6
    sadd16 r9, r9, r7
    sadd16 r9, r9, r8
    vmov s14, r9 @ b0b1
    mov.w r0, #0
    pkhbt r9, r7, r8, lsl #16 @ a3a1
    pkhtb r10, r8, r7, asr #16
    pkhbt r11, r3, r4, lsl #16 @ a5a4
    pkhtb r12, r4, r3, asr #16
    ssub16 r3, r0, r4 @ -a4
    pkhtb r4, r3, r12 @ a'5 -a'4
    pkhbt r3, r11, r3, lsl #16 @ a5 -a4
    ssub16 r7, r11, r9 @ a5a4 - a3a1
    ssub16 r8, r12, r10
    str.w r9, [lr, #28] @ a3a1
    str.w r10, [lr, #60]
    str.w r3, [lr, #20] @ a5 -a4
    str.w r4, [lr, #52]
    str.w r7, [lr, #12] @ a5a4 - a3a1
    str.w r8, [lr, #44]
    sadd16 r11, r11, r9 @ a5a4 + a3a1
    sadd16 r12, r12, r10
    pkhbt r3, r1, r2, lsl #16 @ a6a2
    pkhtb r4, r2 ,r1, asr #16
    pkhbt r7, r5, r6, lsl #16 @ a7a8
    pkhtb r8, r6, r5, asr #16
    ssub16 r9, r0, r7 @ -a7 -a8
    ssub16 r10, r0, r8
    ssub16 r5, r0, r3 @ -a6 -a2
    ssub16 r6, r0, r4
    ssub16 r1, r3, r7 @ a6a2 - a7a8
    ssub16 r2, r4, r8
    sadd16 r7, r3, r7 @ a6a2 + a7a8
    sadd16 r8, r4, r8
    str.w r9, [lr, #24] @ -a7 -a8
    str.w r10, [lr, #56]
    str.w r5, [lr, #16] @ -a6 -a2
    str.w r6, [lr, #48]
    str.w r1, [lr, #8] @ a6a2 - a7a8
    str.w r2, [lr, #40]
    @ 2x2 mod x^2 - 1, x^2 + 1
    @ r7 r8, r11 r12
    vmov r5, s5
    vmov r6, s6
    vmov r9, s4 @ qinv
    mov.w r10, #4591
    sadd16 r1, r7, r11 @ a6278 + a5431
    sadd16 r2, r8, r12
    ssub16 r3, r7, r11 @ a6278 - a5431
    ssub16 r4, r8, r12
    smuad r7, r1, r5 @ a0b0 + a1b1
    smuadx r8, r1, r5 @ a0b1 + a1b0
    smmulr r1, r7, r9
    mls r7, r1, r10, r7
    smmulr r1, r8, r9
    mls r8, r1, r10, r8
    pkhbt r1, r7, r8, lsl #16 @ b0b1
    smuad r7, r2, r5 @ a0b0 + a1b1
    smuadx r8, r2, r5 @ a0b1 + a1b0
    smmulr r2, r7, r9
    mls r7, r2, r10, r7
    smmulr r2, r8, r9
    mls r8, r2, r10, r8
    pkhbt r2, r7, r8, lsl #16 @ b'0b'1
    smusd r7, r3, r6 @ a0b0 - a1b1
    smuadx r8, r3, r6 @ a0b1 + a1b0
    smmulr r3, r7, r9
    mls r7, r3, r10, r7
    smmulr r3, r8, r9
    mls r8, r3, r10, r8
    pkhbt r3, r7, r8, lsl #16 @ b2b3
    smusd r7, r4, r6 @ a0b0 - a1b1
    smuadx r8, r4, r6 @ a0b1 + a1b0
    smmulr r4, r7, r9
    mls r7, r4, r10, r7
    smmulr r4, r8, r9
    mls r8, r4, r10, r8
    pkhbt r4, r7, r8, lsl #16 @ b'2b'3
    sadd16 r5, r1, r3
    ssub16 r6, r1, r3 @ r5r6 = b0b1b2b3 / x^4 -1
    sadd16 r7, r2, r4
    ssub16 r8, r2, r4
@ TODO : 4x4 mod x^4 + 1
    ldr.w r1, [lr, #8] @ a0a1
    ldr.w r2, [lr, #12] @ a2a3
    vmov r3, s7 @ b0b1
    vmov r4, s8 @ b2b3
@ free r0, r11, r12
    smuadx r11, r1, r3 @ a0b1 + a1b0
    smuadx r12, r2, r4 @ a2b3 + a3b2
    sub.w r11, r11, r12 @ c1
    smuadx r12, r1, r4
    smladx r12, r2, r3, r12 @ c3
    smmulr r0, r11, r9
    mls r11, r0, r10, r11 @ bar(c1)
    smmulr r0, r12, r9
    mls r12, r0, r10, r12 @ bar(c3)
    pkhbt r0, r1, r2 @ a0a3
    pkhtb r1, r1, r2 @ a2a1
    smusd r2, r0, r4 @ a0b2 - a3b3
    smlad r2, r1, r3, r2 @ c2
    smusd r0, r0, r3 @ a0b0 - a3b1
    smuad r1, r1, r4 @ a2b2 + a1b3
    sub.w r1, r0, r1 @ c0
    smmulr r0, r1, r9
    mls r1, r0, r10, r1 @ bar(c0)
    smmulr r0, r2, r9
    mls r2, r0, r10, r2 @ bar(c2)
    pkhbt r1, r1, r11, lsl #16 @ c0c1
    pkhbt r2, r2, r12, lsl #16 @ c2c3
    sadd16 r11, r5, r1
    sadd16 r12, r6, r2
    ssub16 r5, r5, r1
    ssub16 r6, r6, r2 @ r11 r12 r5 r6 = 8x8 mod x^8 - 1
    str.w r11, [lr]
    str.w r12, [lr, #4]
    str.w r5, [lr, #8]
    str.w r6, [lr, #12]
    ldr.w r1, [lr, #40]
    ldr.w r2, [lr, #44]
    smuadx r11, r1, r3 @ a0b1 + a1b0
    smuadx r12, r2, r4 @ a2b3 + a3b2
    sub.w r11, r11, r12 @ c1
    smuadx r12, r1, r4
    smladx r12, r2, r3, r12 @ c3
    smmulr r0, r11, r9
    mls r11, r0, r10, r11 @ bar(c1)
    smmulr r0, r12, r9
    mls r12, r0, r10, r12 @ bar(c3)
    pkhbt r0, r1, r2 @ a0a3
    pkhtb r1, r1, r2 @ a2a1
    smusd r2, r0, r4 @ a0b2 - a3b3
    smlad r2, r1, r3, r2 @ c2
    smusd r0, r0, r3 @ a0b0 - a3b1
    smuad r1, r1, r4 @ a2b2 + a1b3
    sub.w r1, r0, r1 @ c0
    smmulr r0, r1, r9
    mls r1, r0, r10, r1 @ bar(c0)
    smmulr r0, r2, r9
    mls r2, r0, r10, r2 @ bar(c2)
    pkhbt r1, r1, r11, lsl #16 @ c0c1
    pkhbt r2, r2, r12, lsl #16 @ c2c3
    sadd16 r11, r7, r1
    sadd16 r12, r8, r2
    ssub16 r5, r7, r1
    ssub16 r6, r8, r2 @ r11 r12 r5 r6 = 8x8 mod x^8 - 1
    str.w r11, [lr, #32]
    str.w r12, [lr, #36]
    str.w r5, [lr, #40]
    str.w r6, [lr, #44]
@ DONE : 4x4 mod x^4 + 1 and back to x^8 - 1
@ TODO : first 8x8 mod x^8 + 1
    ldr.w r1, [lr, #16] @ a0a1
    ldr.w r2, [lr, #20] @ a2a3
    ldr.w r3, [lr, #24] @ a4a5
    ldr.w r4, [lr, #28] @ a6a7
    vmov r5, s9 @ b0b1
    vmov r6, s10 @ b2b3
    vmov r7, s11 @ b4b5
    vmov r8, s12 @ b6b7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    sadd16 r0, r1, r9 @ #0
    ssub16 r9, r1, r9 @ #16
    sadd16 r1, r2, r10 @ #4
    ssub16 r10, r2, r10 @ #20
    sadd16 r2, r3, r11 @ #8
    ssub16 r11, r3, r11 @ #24
    sadd16 r3, r4, r12 @ #12
    ssub16 r12, r4, r12 @ #28
    str.w r0, [lr]
    str.w r1, [lr, #4]
    str.w r2, [lr, #8]
    str.w r3, [lr, #12]
    str.w r9, [lr, #16]
    str.w r10, [lr, #20]
    str.w r11, [lr, #24]
    str.w r12, [lr, #28]
    @ second 8x8 mod x^8 + 1 
    ldr.w r1, [lr, #48]
    ldr.w r2, [lr, #52]
    ldr.w r3, [lr, #56]
    ldr.w r4, [lr, #60]
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #32]
    ldr.w r2, [lr, #36]
    ldr.w r3, [lr, #40]
    ldr.w r4, [lr, #44]
    vmov r5, s13 @ a0a1
    ldr.w r6, [lr]
    ldr.w r7, [lr, #4]
    ldr.w r8, [lr, #8]
    sadd16 r0, r1, r9 @ # 32 + 0
    ssub16 r9, r1, r9 @ # 32 + 16
    sadd16 r1, r2, r10 @ # 32 + 4
    ssub16 r10, r2, r10 @ # 32 + 20
    sadd16 r2, r3, r11 @ # 32 + 8
    ssub16 r11, r3, r11 @ # 32 + 24
    sadd16 r3, r4, r12 @ # 32 + 12
    ssub16 r12, r4, r12 @ # 32 + 28
    pkhbt r4, r6, r0, lsl #16 @ d0
    pkhtb r6, r0, r6, asr #16 @ d1
    pkhbt r0, r7, r1, lsl #16 @ d2
    pkhtb r7, r1, r7, asr #16 @ d3
    pkhbt r1, r8, r2, lsl #16 @ d4
    pkhtb r8, r2, r8, asr #16 @ d5
    sadd16 r4, r4, r5
    sadd16 r6, r6, r5
    sadd16 r0, r0, r5
    sadd16 r7, r7, r5
    sadd16 r1, r1, r5
    sadd16 r8, r8, r5    
    vmov r2, s1
    str.w r4, [r2, #2520]
    str.w r6, [r2, #1440]
    str.w r0, [r2, #1260]
    str.w r7, [r2, #720]
    str.w r1, [r2, #2160]
    str.w r8, [r2, #360]
    ldr.w r0, [lr, #12]
    ldr.w r1, [lr, #16]
    ldr.w r4, [lr, #20]
    ldr.w r6, [lr, #24]
    ldr.w r7, [lr, #28]
    pkhbt r8, r0, r3, lsl #16 @ d6
    pkhtb r0, r3, r0, asr #16 @ d7
    pkhbt r3, r1, r9, lsl #16 @ d8
    pkhtb r1, r9, r1, asr #16 @ d9
    pkhbt r9, r4, r10, lsl #16 @ d10
    pkhtb r4, r10, r4, asr #16 @ d11
    pkhbt r10, r6, r11, lsl #16 @ d12
    pkhtb r6, r11, r6, asr #16 @ d13
    pkhbt r11, r7, r12, lsl #16 @ d14
    pkhtb r7, r12, r7, asr #16 @ d15
    sadd16 r8, r8, r5
    sadd16 r0, r0, r5
    sadd16 r3, r3, r5
    sadd16 r1, r1, r5
    sadd16 r9, r9, r5
    sadd16 r4, r4, r5
    sadd16 r10, r10, r5
    sadd16 r6, r6, r5
    sadd16 r11, r11, r5
    sadd16 r7, r7, r5
    vmov r5, s14
    str.w r8, [r2, #1080]
    str.w r0, [r2, #180]
    str.w r3, [r2, #540]
    str.w r1, [r2, #1620]
    str.w r9, [r2, #1800]
    str.w r4, [r2, #2340]
    str.w r10, [r2, #900]
    str.w r6, [r2, #2700]
    str.w r11, [r2, #1980]
    str.w r7, [r2, #2880]
    str.w r5, [r2], #4
    vmov s1, r2
    vmov r0, s0
    vmov r1, s3
    cmp.w r0, r1
    bne.w ntt17_rader_body2
    vpop {s16-s18}
    pop {r2-r12, pc}