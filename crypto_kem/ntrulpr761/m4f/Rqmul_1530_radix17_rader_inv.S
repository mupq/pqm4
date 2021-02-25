.p2align 2,,3
.syntax unified

.data
buffer: .space 64

.text
buffer_bridge:
    .word buffer
wpad:
    .word 935519
    .word 4254923258
    .word 14808939
    .word 4280221411
    .word 4171694098
    .word 4150000877
    .word 44630214
    .word 87754374
    .word 4185720356

.global intt17_rader_mr
.type intt17_rader_mr, %function
intt17_rader_mr:
@ intt17_rader_mr(int16_t* fpad, int16_t* hpad)
    push {r2-r12, lr}
    vpush {s16-s18}
    add.w r2, r0, #180
    ldr.w lr, buffer_bridge
    adr r3, wpad
    vldm r3, {s4-s12}
    @ s0 for input address
    vmov s1, r1 @ output address
    vmov s2, r2 @ loop1 end
intt17_rader_mr_body:
    ldr.w r1, [r0, #1800]
    ldr.w r2, [r0, #1620]
    ldr.w r3, [r0, #540]
    ldr.w r4, [r0, #180]
    ldr.w r5, [r0, #1260]
    ldr.w r6, [r0, #1440]
    ldr.w r7, [r0, #2520]
    ldr.w r8, [r0, #2880]
    sadd16 r12, r1, r2
    sadd16 r12, r12, r3
    sadd16 r12, r12, r4
    sadd16 r12, r12, r5
    sadd16 r12, r12, r6
    sadd16 r12, r12, r7
    sadd16 r12, r12, r8
    pkhbt r9, r1, r2, lsl #16 @ a10a9
    pkhtb r10, r2, r1, asr #16
    pkhbt r11, r3, r4, lsl #16 @ a3a1
    pkhtb r1, r4, r3, asr #16
    pkhbt r2, r5, r6, lsl #16 @ a7a8
    pkhtb r3, r6, r5, asr #16
    pkhbt r4, r7, r8, lsl #16 @ a14a16
    pkhtb r5, r8, r7, asr #16
    @ r9, r11 +- r2, r4
    @ r10, r1 +- r3, r5
    sadd16 r6, r9, r2 @ #8
    ssub16 r7, r9, r2 @ #24
    sadd16 r8, r11, r4 @ #12
    ssub16 r9, r11, r4 @ #28
    sadd16 r2, r10, r3 @ #40
    ssub16 r3, r10, r3 @ #56
    sadd16 r4, r1, r5 @ #44
    ssub16 r5, r1, r5 @ #60
    str.w r7, [lr, #24]
    str.w r9, [lr, #28]
    str.w r3, [lr, #56]
    str.w r5, [lr, #60]
    vmov s13, r12
    @ r6 r8 r2 r4 : #8, #12, #40, #44
    ldr.w r1, [r0, #900] @ a5
    ldr.w r3, [r0, #2340] @ a13
    ldr.w r5, [r0, #2160] @ a12
    ldr.w r7, [r0, #720] @ a4
    sadd16 r12, r1, r3
    sadd16 r12, r12, r5
    sadd16 r12, r12, r7
    pkhbt r9, r1, r3, lsl #16 @ a5a13
    pkhtb r10, r3, r1, asr #16
    pkhbt r11, r5, r7, lsl #16 @ a12a4
    pkhtb r1, r7, r5, asr #16
    sadd16 r3, r9, r11 @ #4
    ssub16 r5, r9, r11 @ #20, str
    sadd16 r7, r10, r1 @ #36
    ssub16 r9, r10, r1 @ #52, str
    @ free r1, r10, r11
    sadd16 r1, r3, r8 @ #4
    ssub16 r10, r3, r8 @ #12, str
    sadd16 r11, r7, r4 @ #36
    ssub16 r8, r7, r4 @ #44, str
    str.w r5, [lr, #20]
    str.w r9, [lr, #52]
    str.w r10, [lr, #12]
    str.w r8, [lr, #44]
    @ r1, r6, r11, r2 : #4, #8, #36, #40
    ldr.w r3, [r0, #1980] @ a11
    ldr.w r4, [r0, #2700] @ a15
    ldr.w r5, [r0, #1080] @ a6
    ldr.w r7, [r0, #360] @ a2
    ldr.w r10, [r0], #4 @ a0
    vmov s0, r0
    vmov s3, r10 @ a0a1 for add
    sadd16 r12, r12, r3
    sadd16 r12, r12, r4
    sadd16 r12, r12, r5
    sadd16 r12, r12, r7
    sadd16 r12, r12, r10
    pkhbt r8, r3, r4, lsl #16 @ a11a15
    pkhtb r9, r4, r3, asr #16
    pkhbt r10, r5, r7, lsl #16 @ a6a2
    pkhtb r3, r7, r5, asr #16
    sadd16 r4, r8, r10 @ #0
    ssub16 r5, r8, r10 @ #16, str
    sadd16 r7, r9, r3 @ #32
    ssub16 r8, r9, r3 @ #48, str
    @free : r3, r9, r10
    sadd16 r3, r4, r6 @ #0
    ssub16 r9, r4, r6 @ #8, str
    sadd16 r4, r7, r2 @ #32
    ssub16 r6, r7, r2 @ #40, str
    @ r3, r1, r4, r11 : #0, #4, #32, #36 mod x^4 - 1
    vmov s14, r12
    str.w r5, [lr, #16]
    str.w r8, [lr, #48]
    str.w r9, [lr, #8]
    str.w r6, [lr, #40]
    vmov r5, s5 @ w0w1 for x^2 - 1
    vmov r6, s6 @ w0w1 for x^2 + 1
    vmov r9, s4
    mov.w r10, #4591
    ssub16 r2, r3, r1 @ mod x^2 + 1
    sadd16 r1, r3, r1 @ mod x^2 - 1
    sadd16 r3, r4, r11 @ mod x^2 - 1
    ssub16 r4, r4, r11 @ mod x^2 + 1
    @ r1, r2 : a0 a1 a2 a3 : 1
    @ r3, r4 : a0 a1 a2 a3 : 2
    @ 4x4 mod x^4 - 1 : 1
    @ free r0, r7, r8, r11, r12
    smuad r7, r1, r5 @ a0b0 + a1b1
    smuadx r8, r1, r5 @ a0b1 + a1b0
    smmulr r0, r7, r9
    mls r7, r0, r10, r7
    smmulr r0, r8, r9
    mls r8, r0, r10, r8
    pkhbt r7, r7, r8, lsl #16 @ 2x2 mod x^2 - 1 done : 1
    smuad r8, r3, r5 @ a0b0 + a1b1
    smuadx r11, r3, r5 @ a0b1 + a1b0
    smmulr r0, r8, r9
    mls r8, r0, r10, r8
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    pkhbt r8, r8, r11, lsl #16 @ 2x2 mod x^2 - 1 done : 2
    smusd r1, r2, r6 @ a0b0 - a1b1
    smuadx r3, r2, r6 @ a0b1 + a1b0
    smmulr r0, r1, r9
    mls r1, r0, r10, r1 
    smmulr r0, r3, r9
    mls r3, r0, r10, r3
    pkhbt r1, r1, r3, lsl #16 @ 2x2 mod x^2 + 1 done : 1
    smusd r3, r4, r6
    smuadx r4, r4, r6
    smmulr r0, r3, r9
    mls r3, r0, r10, r3
    smmulr r0, r4, r9
    mls r4, r0, r10, r4
    pkhbt r3, r3, r4, lsl #16 @ 2x2 mod x^2 + 1 done : 2
    sadd16 r5, r7, r1
    ssub16 r6, r7, r1 @ r5r6 = 4x4 mod x^4 - 1
    sadd16 r7, r8, r3
    ssub16 r8, r8, r3
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
    vmov r1, s4 @ qinv
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
    vmov r3, s3 @ a0a1
    mov.w r4, #3459
    smulbb r5, r4, r3
    smulbt r6, r4, r3
    smmulr r7, r5, r1
    mls r5, r7, r2, r5
    smmulr r7, r6, r1
    mls r6, r7, r2, r6
    pkhbt r3, r5, r6, lsl #16 @ a0a1 * 65536/153
    @ r1 = qinv, r2 = 4591, r3 = a0a1, r4 = 3459 for mr
    ldr.w r5, [lr, #32]
    ldr.w r6, [lr, #36]
    ldr.w r7, [lr, #40]
    ldr.w r8, [lr, #44]
    sadd16 r0, r5, r9 @ # 32 + 0
    ssub16 r9, r5, r9 @ # 32 + 16
    sadd16 r5, r6, r10 @ # 32 + 4
    ssub16 r10, r6, r10 @ # 32 + 20
    sadd16 r6, r7, r11 @ # 32 + 8
    ssub16 r11, r7, r11 @ # 32 + 24
    sadd16 r7, r8, r12 @ # 32 + 12
    ssub16 r12, r8, r12 @ # 32 + 28
    pkhtb r8, r3, r3, asr #16 @ a1a1
    sadd16 r0, r0, r8 @ b1b2 : 2
    sadd16 r5, r5, r8 @ b3b4 : 2
    sadd16 r6, r6, r8 @ b5b6 : 2
    sadd16 r7, r7, r8 @ b7b8 : 2
    sadd16 r9, r9, r8 @ b9b10 : 2
    sadd16 r10, r10, r8 @ b11b12 : 2
    sadd16 r11, r11, r8 @ b13b14 : 2
    sadd16 r12, r12, r8 @ b15b16 : 2
    pkhbt r3, r3, r3, lsl #16 @ a0a0
    str.w r10, [lr, #52]
    str.w r11, [lr, #56]
    str.w r12, [lr, #60]
    ldr.w r8, [lr]
    @ free r10, r11, r12
    sadd16 r8, r8, r3 @ b1b2 : 1
    pkhbt r10, r8, r0, lsl #16 @ d1
    pkhtb r8, r0, r8, asr #16 @ d2
    @ free : r0, r11, r12
    vmov r0, s1
    str.w r10, [r0, #2520]
    str.w r8, [r0, #1440]
    ldr.w r8, [lr, #4]
    @ free : r10, r11, r12
    sadd16 r8, r8, r3 @ b3b4 : 1
    pkhbt r10, r8, r5, lsl #16 @ d3
    pkhtb r8, r5, r8, asr #16 @ d4
    str.w r10, [r0, #1260]
    str.w r8, [r0, #720]
    @ free : r5, r8, r10, r11, r12
    ldr.w r5, [lr, #8]
    ldr.w r8, [lr, #12]
    sadd16 r5, r5, r3 @ b5b6 : 1
    sadd16 r8, r8, r3 @ b7b8 : 1
    pkhbt r10, r5, r6, lsl #16 @ d5
    pkhtb r5, r6, r5, asr #16 @ d6
    pkhbt r6, r8, r7, lsl #16 @ d7
    pkhtb r8, r7, r8, asr #16 @ d8
    str.w r10, [r0, #2160]
    str.w r5, [r0, #360]
    str.w r6, [r0, #1080]
    str.w r8, [r0, #180]
    @ free r5, r6, r7, r8, r10, r11, r12; r9 = b9b10 : 2
    ldr.w r5, [lr, #16]
    ldr.w r6, [lr, #20]
    ldr.w r7, [lr, #24]
    ldr.w r8, [lr, #28]
    ldr.w r10, [lr, #52] @ b11b12 : 2
    sadd16 r5, r5, r3 @ b9b10 : 1
    sadd16 r6, r6, r3 @ b11b12 : 1
    sadd16 r7, r7, r3 @ b13b14 : 1
    sadd16 r8, r8, r3 @ b15b16 : 1
    pkhbt r11, r5, r9, lsl #16 @ d9
    pkhtb r5, r9, r5, asr #16 @ d10
    pkhbt r12, r6, r10, lsl #16 @ d11
    pkhtb r6, r10, r6, asr #16 @ d12
    str.w r11, [r0, #540]
    str.w r5, [r0, #1620]
    str.w r12, [r0, #1800]
    str.w r6, [r0, #2340]
    ldr.w r9, [lr, #56] @ b13b14 : 2
    ldr.w r10, [lr, #60] @ b15b16 : 2
    @ r7 r8 = b13~16 : 1; r9 r10 = b13~16 : 2
    @ free : r3, r5, r6, r11, r12
    vmov r5, s13
    vmov r6, s14 @ r5 + r6 = b0b1
    pkhbt r11, r7, r9, lsl #16 @ d13
    pkhtb r7, r9, r7, asr #16 @ d14
    pkhbt r12, r8, r10, lsl #16 @ d15
    pkhtb r8, r10, r8, asr #16 @ d16
    @ free : r3, r9, r10 
    smulbb r3, r4, r5
    smlabb r3, r4, r6, r3
    smmulr r10, r3, r1
    mls r3, r10, r2, r3 @ a0
    smulbt r5, r4, r5
    smlabt r5, r4, r6, r5
    smmulr r10, r5, r1
    mls r5, r10, r2, r5
    pkhbt r3, r3, r5, lsl #16 @ d0
    str.w r11, [r0, #900]
    str.w r7, [r0, #2700]
    str.w r12, [r0, #1980]
    str.w r8, [r0, #2880]
    str.w r3, [r0], #4
    vmov s1, r0
    vmov r0, s0
    vmov r1, s2
    cmp.w r0, r1
    bne.w intt17_rader_mr_body
    vpop {s16-s18}
    pop {r2-r12, pc}