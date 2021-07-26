.p2align 2,,3
.syntax unified

.text
wpad:
    .word 929445
    .word 99615807
    .word 4287889782
    .word 86964271
    .word 87031631
    .word 77071466

.global intt11_rader_mr
.type intt11_rader_mr, %function
@ intt11_rader_mr(int16_t* hpad, int16_t* fpad); hpad : output, fpad : input
intt11_rader_mr:
    push {r2- r12, lr}
    add.w r2, r0, #240
    adr r4, wpad
    vmov s0, r0 @ s0 = output address
    vmov s1, r1 @ s1 = input address
    vmov s2, r2 @ s2 = loop end
    vldm r4, {s4-s9}
@f_seq :　[1, 2, 4, 8, 5, 10, 9, 7, 3, 6]
intt11_rader_mr_body_1:
    ldr.w r2, [r1, #240]
    ldr.w r3, [r1, #480]
    ldr.w r4, [r1, #960]
    ldr.w r5, [r1, #1920]
    ldr.w r6, [r1, #1200]
    ldr.w r7, [r1, #2400]
    ldr.w r8, [r1, #2160]
    ldr.w r9, [r1, #1680]
    ldr.w r10, [r1, #720]
    ldr.w r11, [r1, #1440]
    ldr.w r12, [r1], #4
    vmov s3, r1
    sadd16 lr, r2, r3
    sadd16 lr, lr, r4
    sadd16 lr, lr, r5
    sadd16 lr, lr, r6
    sadd16 lr, lr, r7
    sadd16 lr, lr, r8
    sadd16 lr, lr, r9
    sadd16 lr, lr, r10
    sadd16 lr, lr, r11
    sadd16 lr, lr, r12
    sadd16 r1, r2, r7 @ 1
    ssub16 r7, r2, r7 @ 6
    sadd16 r2, r3, r8 @ 2
    ssub16 r8, r3, r8 @ 7
    sadd16 r3, r4, r9 @ 3
    ssub16 r9, r4, r9 @ 8
    sadd16 r4, r5, r10 @ 4
    ssub16 r10, r5, r10 @ 9
    sadd16 r5, r6, r11 @ 5
    ssub16 r11, r6, r11 @ 10
    str.w lr, [r0]
    str.w r7, [r0, #1440]
    str.w r8, [r0, #1680]
    str.w r9, [r0, #1920]
    str.w r10, [r0, #2160]
    str.w r11, [r0, #2400]
    vmov r6, s5 @ w1w2
    vmov r7, s6 @ w3w4
    vmov r8, s7 @ w5w6
    vmov r9, s4 @ qinv
    mov.w r10, #4621
    smulbb r11, r1, r6
    smlabb r11, r2, r8, r11
    smlabt r11, r3, r7, r11
    smlabb r11, r4, r7, r11
    smlabt r11, r5, r6, r11 @ b1
    smultb r12, r1, r6
    smlatb r12, r2, r8, r12
    smlatt r12, r3, r7, r12
    smlatb r12, r4, r7, r12
    smlatt r12, r5, r6, r12 @ b'1
    smmulr lr, r11, r9
    mls r11, lr, r10, r11
    smmulr lr, r12, r9
    mls r12, lr, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d1
    str.w r11, [r0, #240]
    smulbt r11, r1, r6
    smlabb r11, r2, r6, r11
    smlabb r11, r3, r8, r11
    smlabt r11, r4, r7, r11
    smlabb r11, r5, r7, r11 @ b2
    smultt r12, r1, r6
    smlatb r12, r2, r6, r12
    smlatb r12, r3, r8, r12
    smlatt r12, r4, r7, r12
    smlatb r12, r5, r7, r12 @ b'2
    smmulr lr, r11, r9
    mls r11, lr, r10, r11
    smmulr lr, r12, r9
    mls r12, lr, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d2
    str.w r11, [r0, #480]
    smulbb r11, r1, r7
    smlabt r11, r2, r6, r11
    smlabb r11, r3, r6, r11
    smlabb r11, r4, r8, r11
    smlabt r11, r5, r7, r11 @ b3
    smultb r12, r1, r7
    smlatt r12, r2, r6, r12
    smlatb r12, r3, r6, r12
    smlatb r12, r4, r8, r12
    smlatt r12, r5, r7, r12 @ b'3
    smmulr lr, r11, r9
    mls r11, lr, r10, r11
    smmulr lr, r12, r9
    mls r12, lr, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d3
    str.w r11, [r0, #720]
    smulbt r11, r1, r7
    smlabb r11, r2, r7, r11
    smlabt r11, r3, r6, r11
    smlabb r11, r4, r6, r11
    smlabb r11, r5, r8, r11 @ b4
    smultt r12, r1, r7
    smlatb r12, r2, r7, r12
    smlatt r12, r3, r6, r12
    smlatb r12, r4, r6, r12
    smlatb r12, r5, r8, r12 @ b'4
    smmulr lr, r11, r9
    mls r11, lr, r10, r11
    smmulr lr, r12, r9
    mls r12, lr, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d4
    str.w r11, [r0, #960]
    smulbb r11, r1, r8
    smlabt r11, r2, r7, r11
    smlabb r11, r3, r7, r11
    smlabt r11, r4, r6, r11
    smlabb r11, r5, r6, r11 @ b5
    smultb r12, r1, r8
    smlatt r12, r2, r7, r12
    smlatb r12, r3, r7, r12
    smlatt r12, r4, r6, r12
    smlatb r12, r5, r6, r12 @ b'5
    smmulr lr, r11, r9
    mls r11, lr, r10, r11
    smmulr lr, r12, r9
    mls r12, lr, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d5
    str.w r11, [r0, #1200]
    add.w r0, r0, #4
    vmov r1, s3
    vmov r2, s2
    cmp.w r0, r2
    bne.w intt11_rader_mr_body_1
    vmov r0, s0
    vmov r1, s1
    vmov s3, r1
intt11_rader_mr_body_2:
    ldr.w r1, [r0, #1440]
    ldr.w r2, [r0, #1680]
    ldr.w r3, [r0, #1920]
    ldr.w r4, [r0, #2160]
    ldr.w r5, [r0, #2400]
    vmov r6, s8 @ w7w8
    vmov r7, s9 @ w9w10
    vmov r8, s7
    vmov r9, s4
    mov.w r10, #4621
    smulbt r11, r1, r8
    smulbt r12, r2, r7
    smlabb r12, r3, r7, r12
    smlabt r12, r4, r6, r12
    smlabb r12, r5, r6, r12
    sub.w r11, r11, r12 @ b6
    smultt r12, r1, r8
    smultt lr, r2, r7
    smlatb lr, r3, r7, lr
    smlatt lr, r4, r6, lr
    smlatb lr, r5, r6, lr
    sub.w r12, r12, lr @ b'6
    smmulr lr, r11, r9
    mls r11, lr, r10, r11
    smmulr lr, r12, r9
    mls r12, lr, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d6
    str.w r11, [r0, #1440]
    smulbb r11, r1, r6
    smlabt r11, r2, r8, r11
    smulbt r12, r3, r7
    smlabb r12, r4, r7, r12
    smlabt r12, r5, r6, r12
    sub.w r11, r11, r12 @ b7
    smultb r12, r1, r6
    smlatt r12, r2, r8, r12
    smultt lr, r3, r7
    smlatb lr, r4, r7, lr
    smlatt lr, r5, r6, lr
    sub.w r12, r12, lr @ b'7
    smmulr lr, r11, r9
    mls r11, lr, r10, r11
    smmulr lr, r12, r9
    mls r12, lr, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d7
    str.w r11, [r0, #1680]
    smulbt r11, r1, r6
    smlabb r11, r2, r6, r11
    smlabt r11, r3, r8, r11
    smulbt r12, r4, r7
    smlabb r12, r5, r7, r12
    sub.w r11, r11, r12 @ b8
    smultt r12, r1, r6
    smlatb r12, r2, r6, r12
    smlatt r12, r3, r8, r12
    smultt lr, r4, r7
    smlatb lr, r5, r7, lr
    sub.w r12, r12, lr @ b'8
    smmulr lr, r11, r9
    mls r11, lr, r10, r11
    smmulr lr, r12, r9
    mls r12, lr, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d8
    str.w r11, [r0, #1920]
    smulbb r11, r1, r7
    smlabt r11, r2, r6, r11
    smlabb r11, r3, r6, r11
    smlabt r11, r4, r8, r11
    smulbt r12, r5, r7
    sub.w r11, r11, r12 @ b9
    smultb r12, r1, r7
    smlatt r12, r2, r6, r12
    smlatb r12, r3, r6, r12
    smlatt r12, r4, r8, r12
    smultt lr, r5, r7
    sub.w r12, r12, lr @ b'9
    smmulr lr, r11, r9
    mls r11, lr, r10, r11
    smmulr lr, r12, r9
    mls r12, lr, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d9
    smulbt r12, r1, r7
    smlabb r12, r2, r7, r12
    smlabt r12, r3, r6, r12
    smlabb r12, r4, r6, r12
    smlabt r12, r5, r8, r12 @ b10
    smultt lr, r1, r7
    smlatb lr, r2, r7, lr
    smlatt lr, r3, r6, lr
    smlatb lr, r4, r6, lr
    smlatt lr, r5, r8, lr @ b'10
    smmulr r8, r12, r9
    mls r12, r8, r10, r12
    smmulr r8, lr, r9
    mls lr, r8, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d10
    vmov r1, s3
    ldr.w r2, [r1], #4
    vmov s3, r1
    mov.w r1, #2877 @ 65536 / 132
    ldr.w r3, [r0]
    ldr.w r7, [r0, #960]
    ldr.w r8, [r0, #1200]
    smulbb r4, r1, r2
    smulbt r5, r1, r2
    smmulr r6, r4, r9
    mls r4, r6, r10, r4
    smmulr r6, r5, r9
    mls r5, r6, r10, r5
    pkhbt r2, r4, r5, lsl #16 @ a0
    smulbb r4, r1, r3
    smulbt r5, r1, r3
    smmulr r6, r4, r9
    mls r4, r6, r10, r4
    smmulr r6, r5, r9
    mls r5, r6, r10, r5
    pkhbt r3, r4, r5, lsl #16 @ b0
    ssub16 lr, r8, r12 @ 10
    sadd16 r8, r8, r12 @ 5, stroe to 1
    ssub16 r12, r7, r11 @ 9
    sadd16 r7, r7, r11 @ 4, stroe to 2
    sadd16 r7, r7, r2
    sadd16 r8, r8, r2
    sadd16 r12, r12, r2
    sadd16 lr, lr, r2
    str.w r12, [r0, #2160]
    str.w lr, [r0, #2400]
    ldr.w r1, [r0, #240]
    ldr.w r4, [r0, #480]
    str.w r7, [r0, #480]
    str.w r8, [r0, #240]
    ldr.w r5, [r0, #720]
    ldr.w r6, [r0, #1440]
    ldr.w r7, [r0, #1680]
    ldr.w r8, [r0, #1920]
    sadd16 r11, r1, r6 @ 1
    ssub16 r12, r1, r6 @ 6
    sadd16 r1, r4, r7 @ 2
    ssub16 r4, r4, r7 @ 7
    sadd16 r6, r5, r8 @ 3
    ssub16 r5, r5, r8 @ 8
    sadd16 r1, r1, r2
    sadd16 r4, r4, r2
    sadd16 r5, r5, r2
    sadd16 r6, r6, r2
    sadd16 r11, r11, r2
    sadd16 r12, r12, r2
    str.w r11, [r0, #1200]
    str.w r12, [r0, #1440]
    str.w r1, [r0, #1920]
    str.w r4, [r0, #720]
    str.w r6, [r0, #960]
    str.w r5, [r0, #1680]
    str.w r3, [r0], #4
    vmov r2, s2
    cmp.w r0, r2
    bne.w intt11_rader_mr_body_2
    pop {r2-r12, pc}