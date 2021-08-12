.p2align 2,,3
.syntax unified

.text
wpad:
    .word 929445
    .word 4258856395
    .word 31262871
    .word 4224516847
    .word 106559599
    .word 37553268

.global ntt11_rader
.type ntt11_rader, %function
@ ntt11_rader(int16_t* fpad, int16_t* f); fpad : output, f : input
ntt11_rader:
    push {r2- r12, lr}
    vpush {s16-s18}
    add.w r2, r1, #104
    add.w r3, r1, #240
    adr r4, wpad
    vmov s0, r0 @ s0 = output address
    vmov s1, r1 @ s1 = input address
    vmov s2, r2 @ s3 = loop1 end
    vmov s3, r3 @ s4 = loop2 end
    vldm r4, {s4-s9}
    vmov r0, s1 @ r0 = input address
@f_seq :　[1, 2, 4, 8, 5, 10, 9, 7, 3, 6]
ntt11_rader_body1:
    ldr.w r1, [r0, #240]
    ldr.w r2, [r0, #480]
    ldr.w r3, [r0, #960]
    ldr.w r4, [r0, #720]
    ldr.w r5, [r0, #1200]
    ldr.w r6, [r0], #4
    sadd16 r7, r6, r1
    sadd16 r7, r7, r2
    sadd16 r7, r7, r3
    sadd16 r7, r7, r4
    sadd16 r7, r7, r5
    vmov s1, r0
    vmov s10, r6 @ a0a1
    vmov s11, r7 @ b0b1, need store
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
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d1
    smulbt r12, r1, r6
    smlabb r12, r2, r6, r12
    smlabb r12, r3, r8, r12
    smlabt r12, r4, r7, r12
    smlabb r12, r5, r7, r12 @ b2
    smultt lr, r1, r6
    smlatb lr, r2, r6, lr
    smlatb lr, r3, r8, lr
    smlatt lr, r4, r7, lr
    smlatb lr, r5, r7, lr @ b'2
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d2
    vmov s12, r11 @ d1
    vmov s13, r12 @ d2
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
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d3
    smulbt r12, r1, r7
    smlabb r12, r2, r7, r12
    smlabt r12, r3, r6, r12
    smlabb r12, r4, r6, r12
    smlabb r12, r5, r8, r12 @ b4
    smultt lr, r1, r7
    smlatb lr, r2, r7, lr
    smlatt lr, r3, r6, lr
    smlatb lr, r4, r6, lr
    smlatb lr, r5, r8, lr @ b'4
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d4
    smulbb lr, r1, r8
    smlabt lr, r2, r7, lr
    smlabb lr, r3, r7, lr
    smlabt lr, r4, r6, lr
    smlabb lr, r5, r6, lr @ b5
    smultb r0, r1, r8
    smlatt r0, r2, r7, r0
    smlatb r0, r3, r7, r0
    smlatt r0, r4, r6, r0
    smlatb r0, r5, r6, r0 @ b'5
    smmulr r6, lr, r9
    mls lr, r6, r10, lr
    smmulr r6, r0, r9
    mls r0, r6, r10, r0
    pkhbt lr, lr, r0, lsl #16 @ d5
    vmov s14, r11 @ d3
    vmov s15, r12 @ d4
    vmov s16, lr @ d5
    @ r8 = w5w6
    vmov r6, s8 @ w7w8
    vmov r7, s9 @ w9w10
    mov.w r0, #0
    ssub16 r4, r0, r4
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
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d6
    smulbb r12, r1, r6
    smlabt r12, r2, r8, r12
    smulbt lr, r3, r7
    smlabb lr, r4, r7, lr
    smlabt lr, r5, r6, lr
    sub.w r12, r12, lr @ b7
    smultb lr, r1, r6
    smlatt lr, r2, r8, lr
    smultt r0, r3, r7
    smlatb r0, r4, r7, r0
    smlatt r0, r5, r6, r0
    sub.w lr, lr, r0 @ b'7
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d7
    vmov s17, r11 @ d6
    vmov s18, r12 @ d7
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
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d8
    smulbb r12, r1, r7
    smlabt r12, r2, r6, r12
    smlabb r12, r3, r6, r12
    smlabt r12, r4, r8, r12
    smulbt lr, r5, r7
    sub.w r12, r12, lr @ b9
    smultb lr, r1, r7
    smlatt lr, r2, r6, lr
    smlatb lr, r3, r6, lr
    smlatt lr, r4, r8, lr
    smultt r0, r5, r7
    sub.w lr, lr, r0 @ b'9
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d9
    smulbt lr, r1, r7
    smlabb lr, r2, r7, lr
    smlabt lr, r3, r6, lr
    smlabb lr, r4, r6, lr
    smlabt lr, r5, r8, lr @ b10
    smultt r0, r1, r7
    smlatb r0, r2, r7, r0
    smlatt r0, r3, r6, r0
    smlatb r0, r4, r6, r0
    smlatt r0, r5, r8, r0 @ b'10
    smmulr r6, lr, r9
    mls lr, r6, r10, lr
    smmulr r6, r0, r9
    mls r0, r6, r10, r0
    pkhbt lr, lr, r0, lsl #16 @ d10
    vmov r10, s18 @ d7
    vmov r9, s17 @ d6
    vmov r8, s16 @ d5
    vmov r7, s15 @ d4
    vmov r6, s14 @ d3
    vmov r5, s13 @ d2
    vmov r4, s12 @ d1
    vmov r0, s10
    sadd16 r1, r4, r9 @ p1
    ssub16 r2, r4, r9 @ p6
    sadd16 r3, r5, r10 @ p2
    ssub16 r4, r5, r10 @ p7
    sadd16 r5, r6, r11 @ p3
    ssub16 r6, r6, r11 @ p8
    sadd16 r9, r7, r12 @ p4
    ssub16 r10, r7, r12 @ p9
    sadd16 r11, r8, lr @ p5
    ssub16 r12, r8, lr @ p10
    sadd16 r1, r1, r0
    sadd16 r2, r2, r0
    sadd16 r3, r3, r0
    sadd16 r4, r4, r0
    sadd16 r5, r5, r0
    sadd16 r6, r6, r0
    sadd16 r9, r9, r0
    sadd16 r10, r10, r0
    sadd16 r11, r11, r0
    sadd16 r12, r12, r0
    vmov r0, s0
    vmov r7, s11
    str.w r1, [r0, #1200]
    str.w r3, [r0, #1920]
    str.w r5, [r0, #960]
    str.w r9, [r0, #480]
    str.w r11, [r0, #240]
    str.w r2, [r0, #1440]
    str.w r4, [r0, #720]
    str.w r6, [r0, #1680]
    str.w r10, [r0, #2160]
    str.w r12, [r0, #2400]
    str.w r7, [r0], #4
    vmov s0, r0
    vmov r0, s1
    vmov r1, s2
    cmp.w r0, r1
    bne.w ntt11_rader_body1
@o_seq :　[9, 7, 3, 6, 1, 2, 4, 8, 5, 10]
@ a652a653
    ldr.w r1, [r0, #240]
    ldr.w r2, [r0, #480]
    ldr.w r3, [r0, #960]
    ldr.w r4, [r0, #720]
    ldr.w r5, [r0, #1200] @ high 16 bits = 0
    ldr.w r6, [r0], #4
    ubfx r5, r5, #0, #16
    sadd16 r7, r6, r1
    sadd16 r7, r7, r2
    sadd16 r7, r7, r3
    sadd16 r7, r7, r4
    sadd16 r7, r7, r5
    vmov s1, r0
    vmov s10, r6 @ a0a1
    vmov s11, r7 @ b0b1, need store
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
    @ smlatt r12, r5, r6, r12 @ b'1
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d1
    smulbt r12, r1, r6
    smlabb r12, r2, r6, r12
    smlabb r12, r3, r8, r12
    smlabt r12, r4, r7, r12
    smlabb r12, r5, r7, r12 @ b2
    smultt lr, r1, r6
    smlatb lr, r2, r6, lr
    smlatb lr, r3, r8, lr
    smlatt lr, r4, r7, lr
    @ smlatb lr, r5, r7, lr @ b'2
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d2
    vmov s12, r11 @ d1
    vmov s13, r12 @ d2
    smulbb r11, r1, r7
    smlabt r11, r2, r6, r11
    smlabb r11, r3, r6, r11
    smlabb r11, r4, r8, r11
    smlabt r11, r5, r7, r11 @ b3
    smultb r12, r1, r7
    smlatt r12, r2, r6, r12
    smlatb r12, r3, r6, r12
    smlatb r12, r4, r8, r12
    @ smlatt r12, r5, r7, r12 @ b'3
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d3
    smulbt r12, r1, r7
    smlabb r12, r2, r7, r12
    smlabt r12, r3, r6, r12
    smlabb r12, r4, r6, r12
    smlabb r12, r5, r8, r12 @ b4
    smultt lr, r1, r7
    smlatb lr, r2, r7, lr
    smlatt lr, r3, r6, lr
    smlatb lr, r4, r6, lr
    @ smlatb lr, r5, r8, lr @ b'4
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d4
    smulbb lr, r1, r8
    smlabt lr, r2, r7, lr
    smlabb lr, r3, r7, lr
    smlabt lr, r4, r6, lr
    smlabb lr, r5, r6, lr @ b5
    smultb r0, r1, r8
    smlatt r0, r2, r7, r0
    smlatb r0, r3, r7, r0
    smlatt r0, r4, r6, r0
    @ smlatb r0, r5, r6, r0 @ b'5
    smmulr r6, lr, r9
    mls lr, r6, r10, lr
    smmulr r6, r0, r9
    mls r0, r6, r10, r0
    pkhbt lr, lr, r0, lsl #16 @ d5
    vmov s14, r11 @ d3
    vmov s15, r12 @ d4
    vmov s16, lr @ d5
    @ r8 = w5w6
    vmov r6, s8 @ w7w8
    vmov r7, s9 @ w9w10
    mov.w r0, #0
    ssub16 r4, r0, r4
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
    @ smlatb lr, r5, r6, lr
    sub.w r12, r12, lr @ b'6
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d6
    smulbb r12, r1, r6
    smlabt r12, r2, r8, r12
    smulbt lr, r3, r7
    smlabb lr, r4, r7, lr
    smlabt lr, r5, r6, lr
    sub.w r12, r12, lr @ b7
    smultb lr, r1, r6
    smlatt lr, r2, r8, lr
    smultt r0, r3, r7
    smlatb r0, r4, r7, r0
    @ smlatt r0, r5, r6, r0
    sub.w lr, lr, r0 @ b'7
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d7
    vmov s17, r11 @ d6
    vmov s18, r12 @ d7
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
    @ smlatb lr, r5, r7, lr
    sub.w r12, r12, lr @ b'8
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d8
    smulbb r12, r1, r7
    smlabt r12, r2, r6, r12
    smlabb r12, r3, r6, r12
    smlabt r12, r4, r8, r12
    smulbt lr, r5, r7
    sub.w r12, r12, lr @ b9
    smultb lr, r1, r7
    smlatt lr, r2, r6, lr
    smlatb lr, r3, r6, lr
    smlatt lr, r4, r8, lr
    @ smultt r0, r5, r7
    @ sub.w lr, lr, r0 @ b'9
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d9
    smulbt lr, r1, r7
    smlabb lr, r2, r7, lr
    smlabt lr, r3, r6, lr
    smlabb lr, r4, r6, lr
    smlabt lr, r5, r8, lr @ b10
    smultt r0, r1, r7
    smlatb r0, r2, r7, r0
    smlatt r0, r3, r6, r0
    smlatb r0, r4, r6, r0
    @ smlatt r0, r5, r8, r0 @ b'10
    smmulr r6, lr, r9
    mls lr, r6, r10, lr
    smmulr r6, r0, r9
    mls r0, r6, r10, r0
    pkhbt lr, lr, r0, lsl #16 @ d10
    vmov r10, s18 @ d7
    vmov r9, s17 @ d6
    vmov r8, s16 @ d5
    vmov r7, s15 @ d4
    vmov r6, s14 @ d3
    vmov r5, s13 @ d2
    vmov r4, s12 @ d1
    vmov r0, s10
    sadd16 r1, r4, r9 @ p1
    ssub16 r2, r4, r9 @ p6
    sadd16 r3, r5, r10 @ p2
    ssub16 r4, r5, r10 @ p7
    sadd16 r5, r6, r11 @ p3
    ssub16 r6, r6, r11 @ p8
    sadd16 r9, r7, r12 @ p4
    ssub16 r10, r7, r12 @ p9
    sadd16 r11, r8, lr @ p5
    ssub16 r12, r8, lr @ p10
    sadd16 r1, r1, r0
    sadd16 r2, r2, r0
    sadd16 r3, r3, r0
    sadd16 r4, r4, r0
    sadd16 r5, r5, r0
    sadd16 r6, r6, r0
    sadd16 r9, r9, r0
    sadd16 r10, r10, r0
    sadd16 r11, r11, r0
    sadd16 r12, r12, r0
    vmov r0, s0
    vmov r7, s11
    str.w r1, [r0, #1200]
    str.w r3, [r0, #1920]
    str.w r5, [r0, #960]
    str.w r9, [r0, #480]
    str.w r11, [r0, #240]
    str.w r2, [r0, #1440]
    str.w r4, [r0, #720]
    str.w r6, [r0, #1680]
    str.w r10, [r0, #2160]
    str.w r12, [r0, #2400]
    str.w r7, [r0], #4
    vmov s0, r0
    vmov r0, s1
ntt11_rader_body2:
    ldr.w r1, [r0, #240]
    ldr.w r2, [r0, #480]
    ldr.w r3, [r0, #960]
    ldr.w r4, [r0, #720]
    @ ldr.w r5, [r0, #1200]
    ldr.w r6, [r0], #4
    sadd16 r7, r6, r1
    sadd16 r7, r7, r2
    sadd16 r7, r7, r3
    sadd16 r7, r7, r4
    @ sadd16 r7, r7, r5
    vmov s1, r0
    vmov s10, r6 @ a0a1
    vmov s11, r7 @ b0b1, need store
    vmov r6, s5 @ w1w2
    vmov r7, s6 @ w3w4
    vmov r8, s7 @ w5w6
    vmov r9, s4 @ qinv
    mov.w r10, #4621
    smulbb r11, r1, r6
    smlabb r11, r2, r8, r11
    smlabt r11, r3, r7, r11
    smlabb r11, r4, r7, r11
    @ smlabt r11, r5, r6, r11 @ b1
    smultb r12, r1, r6
    smlatb r12, r2, r8, r12
    smlatt r12, r3, r7, r12
    smlatb r12, r4, r7, r12
    @ smlatt r12, r5, r6, r12 @ b'1
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d1
    smulbt r12, r1, r6
    smlabb r12, r2, r6, r12
    smlabb r12, r3, r8, r12
    smlabt r12, r4, r7, r12
    @ smlabb r12, r5, r7, r12 @ b2
    smultt lr, r1, r6
    smlatb lr, r2, r6, lr
    smlatb lr, r3, r8, lr
    smlatt lr, r4, r7, lr
    @ smlatb lr, r5, r7, lr @ b'2
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d2
    vmov s12, r11 @ d1
    vmov s13, r12 @ d2
    smulbb r11, r1, r7
    smlabt r11, r2, r6, r11
    smlabb r11, r3, r6, r11
    smlabb r11, r4, r8, r11
    @ smlabt r11, r5, r7, r11 @ b3
    smultb r12, r1, r7
    smlatt r12, r2, r6, r12
    smlatb r12, r3, r6, r12
    smlatb r12, r4, r8, r12
    @ smlatt r12, r5, r7, r12 @ b'3
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d3
    smulbt r12, r1, r7
    smlabb r12, r2, r7, r12
    smlabt r12, r3, r6, r12
    smlabb r12, r4, r6, r12
    @ smlabb r12, r5, r8, r12 @ b4
    smultt lr, r1, r7
    smlatb lr, r2, r7, lr
    smlatt lr, r3, r6, lr
    smlatb lr, r4, r6, lr
    @ smlatb lr, r5, r8, lr @ b'4
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d4
    smulbb lr, r1, r8
    smlabt lr, r2, r7, lr
    smlabb lr, r3, r7, lr
    smlabt lr, r4, r6, lr
    @ smlabb lr, r5, r6, lr @ b5
    smultb r0, r1, r8
    smlatt r0, r2, r7, r0
    smlatb r0, r3, r7, r0
    smlatt r0, r4, r6, r0
    @ smlatb r0, r5, r6, r0 @ b'5
    smmulr r6, lr, r9
    mls lr, r6, r10, lr
    smmulr r6, r0, r9
    mls r0, r6, r10, r0
    pkhbt lr, lr, r0, lsl #16 @ d5
    vmov s14, r11 @ d3
    vmov s15, r12 @ d4
    vmov s16, lr @ d5
    @ r8 = w5w6
    vmov r6, s8 @ w7w8
    vmov r7, s9 @ w9w10
    mov.w r0, #0
    ssub16 r4, r0, r4
    smulbt r11, r1, r8
    smulbt r12, r2, r7
    smlabb r12, r3, r7, r12
    smlabt r12, r4, r6, r12
    @ smlabb r12, r5, r6, r12
    sub.w r11, r11, r12 @ b6
    smultt r12, r1, r8
    smultt lr, r2, r7
    smlatb lr, r3, r7, lr
    smlatt lr, r4, r6, lr
    @ smlatb lr, r5, r6, lr
    sub.w r12, r12, lr @ b'6
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d6
    smulbb r12, r1, r6
    smlabt r12, r2, r8, r12
    smulbt lr, r3, r7
    smlabb lr, r4, r7, lr
    @ smlabt lr, r5, r6, lr
    sub.w r12, r12, lr @ b7
    smultb lr, r1, r6
    smlatt lr, r2, r8, lr
    smultt r0, r3, r7
    smlatb r0, r4, r7, r0
    @ smlatt r0, r5, r6, r0
    sub.w lr, lr, r0 @ b'7
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d7
    vmov s17, r11 @ d6
    vmov s18, r12 @ d7
    smulbt r11, r1, r6
    smlabb r11, r2, r6, r11
    smlabt r11, r3, r8, r11
    smulbt r12, r4, r7
    @ smlabb r12, r5, r7, r12
    sub.w r11, r11, r12 @ b8
    smultt r12, r1, r6
    smlatb r12, r2, r6, r12
    smlatt r12, r3, r8, r12
    smultt lr, r4, r7
    @ smlatb lr, r5, r7, lr
    sub.w r12, r12, lr @ b'8
    smmulr r0, r11, r9
    mls r11, r0, r10, r11
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    pkhbt r11, r11, r12, lsl #16 @ d8
    smulbb r12, r1, r7
    smlabt r12, r2, r6, r12
    smlabb r12, r3, r6, r12
    smlabt r12, r4, r8, r12
    @ smulbt lr, r5, r7
    @ sub.w r12, r12, lr @ b9
    smultb lr, r1, r7
    smlatt lr, r2, r6, lr
    smlatb lr, r3, r6, lr
    smlatt lr, r4, r8, lr
    @ smultt r0, r5, r7
    @ sub.w lr, lr, r0 @ b'9
    smmulr r0, r12, r9
    mls r12, r0, r10, r12
    smmulr r0, lr, r9
    mls lr, r0, r10, lr
    pkhbt r12, r12, lr, lsl #16 @ d9
    smulbt lr, r1, r7
    smlabb lr, r2, r7, lr
    smlabt lr, r3, r6, lr
    smlabb lr, r4, r6, lr
    @ smlabt lr, r5, r8, lr @ b10
    smultt r0, r1, r7
    smlatb r0, r2, r7, r0
    smlatt r0, r3, r6, r0
    smlatb r0, r4, r6, r0
    @ smlatt r0, r5, r8, r0 @ b'10
    smmulr r6, lr, r9
    mls lr, r6, r10, lr
    smmulr r6, r0, r9
    mls r0, r6, r10, r0
    pkhbt lr, lr, r0, lsl #16 @ d10
    vmov r10, s18 @ d7
    vmov r9, s17 @ d6
    vmov r8, s16 @ d5
    vmov r7, s15 @ d4
    vmov r6, s14 @ d3
    vmov r5, s13 @ d2
    vmov r4, s12 @ d1
    vmov r0, s10
    sadd16 r1, r4, r9 @ p1
    ssub16 r2, r4, r9 @ p6
    sadd16 r3, r5, r10 @ p2
    ssub16 r4, r5, r10 @ p7
    sadd16 r5, r6, r11 @ p3
    ssub16 r6, r6, r11 @ p8
    sadd16 r9, r7, r12 @ p4
    ssub16 r10, r7, r12 @ p9
    sadd16 r11, r8, lr @ p5
    ssub16 r12, r8, lr @ p10
    sadd16 r1, r1, r0
    sadd16 r2, r2, r0
    sadd16 r3, r3, r0
    sadd16 r4, r4, r0
    sadd16 r5, r5, r0
    sadd16 r6, r6, r0
    sadd16 r9, r9, r0
    sadd16 r10, r10, r0
    sadd16 r11, r11, r0
    sadd16 r12, r12, r0
    vmov r0, s0
    vmov r7, s11
    str.w r1, [r0, #1200]
    str.w r3, [r0, #1920]
    str.w r5, [r0, #960]
    str.w r9, [r0, #480]
    str.w r11, [r0, #240]
    str.w r2, [r0, #1440]
    str.w r4, [r0, #720]
    str.w r6, [r0, #1680]
    str.w r10, [r0, #2160]
    str.w r12, [r0, #2400]
    str.w r7, [r0], #4
    vmov s0, r0
    vmov r0, s1
    vmov r1, s3
    cmp.w r0, r1
    bne.w ntt11_rader_body2
    vpop {s16-s18}
    pop {r2-r12, pc}