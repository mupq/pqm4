.p2align 2,,3
.syntax unified

.text
wpad:
    .word 1933251085
    .word 143917855
    .word 4184865787
    .word 4273144955
    .word 4170647182
    .word 131335039

.global ntt11_rader
.type ntt11_rader, %function
@ ntt11_rader(int16_t* fpad, int16_t* f); fpad : output, f : input
ntt11_rader:
    push {r2- r12, lr}
    @ vpush {s16-s18}
    add.w r2, r1, #104
    add.w r3, r1, #240
    adr r4, wpad
    @ vmov s0, r0 @ s0 = output address
    @ vmov s1, r1 @ s1 = input address
    vmov s2, r2 @ s3 = loop1 end
    vmov s3, r3 @ s4 = loop2 end
    ldr.w lr, [r4], #4
    ldm r4, {r7-r11}
    @ vmov s4, lr
    @ vldm r4, {s4-s9}
@f_seq :　[1, 2, 4, 8, 5, 10, 9, 7, 3, 6]
ntt11_rader_body1:
    ldr.w r2, [r1, #240]
    ldr.w r3, [r1, #480]
    ldr.w r4, [r1, #960]
    ldr.w r5, [r1, #1200]
    ldr.w r6, [r1, #720]
    ldr.w r12, [r1], #4
    vmov s1, r1
    sadd16 r1, r12, r2
    sadd16 r1, r1, r3
    sadd16 r1, r1, r4
    sadd16 r1, r1, r5
    sadd16 r1, r1, r6
    str.w r1, [r0], #4
    vmov s0, r0
    vmov s5, r12 @a0a1
    pkhbt r0, r2, r3, lsl #16 @f0f1
    pkhtb r1, r3, r2, asr #16 @g0g1
    @ free : r2, r3, r12
    @ 1
    smuadx r2, r0, r7
    smlabt r2, r4, r11, r2
    smlabt r2, r5, r10, r2
    smlabt r2, r6, r8, r2
    smuadx r3, r1, r7
    smlatt r3, r4, r11, r3
    smlatt r3, r5, r10, r3
    smlatt r3, r6, r8, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s6, r2
    @ 3
    smuadx r2, r0, r8
    smlabt r2, r4, r7, r2
    smlabt r2, r5, r11, r2
    smlabt r2, r6, r9, r2
    smuadx r3, r1, r8
    smlatt r3, r4, r7, r3
    smlatt r3, r5, r11, r3
    smlatt r3, r6, r9, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s7, r2
    @ 5
    smuadx r2, r0, r9
    smlabt r2, r4, r8, r2
    smlabt r2, r5, r7, r2
    smlabt r2, r6, r10, r2
    smuadx r3, r1, r9
    smlatt r3, r4, r8, r3
    smlatt r3, r5, r7, r3
    smlatt r3, r6, r10, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s8, r2
    @ 7
    smuadx r2, r0, r10
    smlabt r2, r4, r9, r2
    smlabt r2, r5, r8, r2
    smlabt r2, r6, r11, r2
    smuadx r3, r1, r10
    smlatt r3, r4, r9, r3
    smlatt r3, r5, r8, r3
    smlatt r3, r6, r11, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s9, r2
    @ 9
    smuadx r2, r0, r11
    smlabt r2, r4, r10, r2
    smlabt r2, r5, r9, r2
    smlabt r2, r6, r7, r2
    smuadx r3, r1, r11
    smlatt r3, r4, r10, r3
    smlatt r3, r5, r9, r3
    smlatt r3, r6, r7, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s10, r2
    pkhtb r2, r0, r4 @f2f1
    pkhtb r3, r1, r4, asr #16 @g2g1
    pkhbt r4, r0, r1, lsl #16 @f0g0
    @ 0
    smulbb r0, r4, r7
    smlad r0, r2, r11, r0
    smlabb r0, r5, r10, r0
    smlabb r0, r6, r8, r0
    smultb r1, r4, r7
    smlad r1, r3, r11, r1
    smlatb r1, r5, r10, r1
    smlatb r1, r6, r8, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s11, r0
    @ 2
    smulbb r0, r4, r8
    smlad r0, r2, r7, r0
    smlabb r0, r5, r11, r0
    smlabb r0, r6, r9, r0
    smultb r1, r4, r8
    smlad r1, r3, r7, r1
    smlatb r1, r5, r11, r1
    smlatb r1, r6, r9, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s12, r0
    @ 4
    smulbb r0, r4, r9
    smlad r0, r2, r8, r0
    smlabb r0, r5, r7, r0
    smlabb r0, r6, r10, r0
    smultb r1, r4, r9
    smlad r1, r3, r8, r1
    smlatb r1, r5, r7, r1
    smlatb r1, r6, r10, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s13, r0
    @ 6
    smulbb r0, r4, r10
    smlad r0, r2, r9, r0
    smlabb r0, r5, r8, r0
    smlabb r0, r6, r11, r0
    smultb r1, r4, r10
    smlad r1, r3, r9, r1
    smlatb r1, r5, r8, r1
    smlatb r1, r6, r11, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s14, r0
    @ 8
    smulbb r0, r4, r11
    smlad r0, r2, r10, r0
    smlabb r0, r5, r9, r0
    smlabb r0, r6, r7, r0
    smultb r1, r4, r11
    smlad r1, r3, r10, r1
    smlatb r1, r5, r9, r1
    smlatb r1, r6, r7, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r12, r1, r0, asr #16
    @ free r0~r6
    vmov r0, s0
    vmov r6, s5 @ a0a1
    vmov r1, s11 @ 0
    vmov r2, s6 @ 1
    vmov r3, s12 @ 2
    vmov r4, s7 @ 3
    vmov r5, s13 @ 4
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    sadd16 r5, r5, r6
    sadd16 r12, r12, r6
    str.w r1, [r0, #1196]
    str.w r2, [r0, #1916]
    str.w r3, [r0, #956]
    str.w r4, [r0, #476]
    str.w r5, [r0, #236]
    str.w r12, [r0, #2156]
    vmov r1, s1
    vmov r2, s8 @ 5
    vmov r3, s14 @ 6
    vmov r4, s9 @ 7
    vmov r5, s10 @ 9
    vmov r12, s2
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    sadd16 r5, r5, r6
    str.w r2, [r0, #1436]
    str.w r3, [r0, #716]
    str.w r4, [r0, #1676]
    str.w r5, [r0, #2396]
    cmp.w r1, r12
    bne.w ntt11_rader_body1
@ a652a653
    ldr.w r2, [r1, #240]
    ldr.w r3, [r1, #480]
    ldr.w r4, [r1, #960]
    ldr.w r5, [r1, #1200]
    ldr.w r6, [r1, #720]
    ldr.w r12, [r1], #4
    vmov s1, r1
    ubfx r5, r5, #0, #16
    sadd16 r1, r12, r2
    sadd16 r1, r1, r3
    sadd16 r1, r1, r4
    sadd16 r1, r1, r5
    sadd16 r1, r1, r6
    str.w r1, [r0], #4
    vmov s0, r0
    vmov s5, r12 @a0a1
    pkhbt r0, r2, r3, lsl #16 @f0f1
    pkhtb r1, r3, r2, asr #16 @g0g1
    @ free : r2, r3, r12
    @ 1
    smuadx r2, r0, r7
    smlabt r2, r4, r11, r2
    smlabt r2, r5, r10, r2
    smlabt r2, r6, r8, r2
    smuadx r3, r1, r7
    smlatt r3, r4, r11, r3
    @ smlatt r3, r5, r10, r3
    smlatt r3, r6, r8, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s6, r2
    @ 3
    smuadx r2, r0, r8
    smlabt r2, r4, r7, r2
    smlabt r2, r5, r11, r2
    smlabt r2, r6, r9, r2
    smuadx r3, r1, r8
    smlatt r3, r4, r7, r3
    @ smlatt r3, r5, r11, r3
    smlatt r3, r6, r9, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s7, r2
    @ 5
    smuadx r2, r0, r9
    smlabt r2, r4, r8, r2
    smlabt r2, r5, r7, r2
    smlabt r2, r6, r10, r2
    smuadx r3, r1, r9
    smlatt r3, r4, r8, r3
    @ smlatt r3, r5, r7, r3
    smlatt r3, r6, r10, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s8, r2
    @ 7
    smuadx r2, r0, r10
    smlabt r2, r4, r9, r2
    smlabt r2, r5, r8, r2
    smlabt r2, r6, r11, r2
    smuadx r3, r1, r10
    smlatt r3, r4, r9, r3
    @ smlatt r3, r5, r8, r3
    smlatt r3, r6, r11, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s9, r2
    @ 9
    smuadx r2, r0, r11
    smlabt r2, r4, r10, r2
    smlabt r2, r5, r9, r2
    smlabt r2, r6, r7, r2
    smuadx r3, r1, r11
    smlatt r3, r4, r10, r3
    @ smlatt r3, r5, r9, r3
    smlatt r3, r6, r7, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s10, r2
    pkhtb r2, r0, r4 @f2f1
    pkhtb r3, r1, r4, asr #16 @g2g1
    pkhbt r4, r0, r1, lsl #16 @f0g0
    @ 0
    smulbb r0, r4, r7
    smlad r0, r2, r11, r0
    smlabb r0, r5, r10, r0
    smlabb r0, r6, r8, r0
    smultb r1, r4, r7
    smlad r1, r3, r11, r1
    @ smlatb r1, r5, r10, r1
    smlatb r1, r6, r8, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s11, r0
    @ 2
    smulbb r0, r4, r8
    smlad r0, r2, r7, r0
    smlabb r0, r5, r11, r0
    smlabb r0, r6, r9, r0
    smultb r1, r4, r8
    smlad r1, r3, r7, r1
    @ smlatb r1, r5, r11, r1
    smlatb r1, r6, r9, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s12, r0
    @ 4
    smulbb r0, r4, r9
    smlad r0, r2, r8, r0
    smlabb r0, r5, r7, r0
    smlabb r0, r6, r10, r0
    smultb r1, r4, r9
    smlad r1, r3, r8, r1
    @ smlatb r1, r5, r7, r1
    smlatb r1, r6, r10, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s13, r0
    @ 6
    smulbb r0, r4, r10
    smlad r0, r2, r9, r0
    smlabb r0, r5, r8, r0
    smlabb r0, r6, r11, r0
    smultb r1, r4, r10
    smlad r1, r3, r9, r1
    @ smlatb r1, r5, r8, r1
    smlatb r1, r6, r11, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s14, r0
    @ 8
    smulbb r0, r4, r11
    smlad r0, r2, r10, r0
    smlabb r0, r5, r9, r0
    smlabb r0, r6, r7, r0
    smultb r1, r4, r11
    smlad r1, r3, r10, r1
    @ smlatb r1, r5, r9, r1
    smlatb r1, r6, r7, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r12, r1, r0, asr #16
    @ free r0~r6
    vmov r0, s0
    vmov r6, s5 @ a0a1
    vmov r1, s11 @ 0
    vmov r2, s6 @ 1
    vmov r3, s12 @ 2
    vmov r4, s7 @ 3
    vmov r5, s13 @ 4
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    sadd16 r5, r5, r6
    sadd16 r12, r12, r6
    str.w r1, [r0, #1196]
    str.w r2, [r0, #1916]
    str.w r3, [r0, #956]
    str.w r4, [r0, #476]
    str.w r5, [r0, #236]
    str.w r12, [r0, #2156]
    vmov r1, s1
    vmov r2, s8 @ 5
    vmov r3, s14 @ 6
    vmov r4, s9 @ 7
    vmov r5, s10 @ 9
    @ vmov r12, s2
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    sadd16 r5, r5, r6
    str.w r2, [r0, #1436]
    str.w r3, [r0, #716]
    str.w r4, [r0, #1676]
    str.w r5, [r0, #2396]
    @ cmp.w r1, r12
ntt11_rader_body2:
    ldr.w r2, [r1, #240]
    ldr.w r3, [r1, #480]
    ldr.w r4, [r1, #960]
    @ ldr.w r5, [r1, #1200]
    ldr.w r6, [r1, #720]
    ldr.w r12, [r1], #4
    vmov s1, r1
    sadd16 r1, r12, r2
    sadd16 r1, r1, r3
    sadd16 r1, r1, r4
    @ sadd16 r1, r1, r5
    sadd16 r1, r1, r6
    str.w r1, [r0], #4
    vmov s0, r0
    vmov s5, r12 @a0a1
    pkhbt r0, r2, r3, lsl #16 @f0f1
    pkhtb r1, r3, r2, asr #16 @g0g1
    @ free : r2, r3, r12
    @ 1
    smuadx r2, r0, r7
    smlabt r2, r4, r11, r2
    @ smlabt r2, r5, r10, r2
    smlabt r2, r6, r8, r2
    smuadx r3, r1, r7
    smlatt r3, r4, r11, r3
    @ smlatt r3, r5, r10, r3
    smlatt r3, r6, r8, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s6, r2
    @ 3
    smuadx r2, r0, r8
    smlabt r2, r4, r7, r2
    @ smlabt r2, r5, r11, r2
    smlabt r2, r6, r9, r2
    smuadx r3, r1, r8
    smlatt r3, r4, r7, r3
    @ smlatt r3, r5, r11, r3
    smlatt r3, r6, r9, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s7, r2
    @ 5
    smuadx r2, r0, r9
    smlabt r2, r4, r8, r2
    @ smlabt r2, r5, r7, r2
    smlabt r2, r6, r10, r2
    smuadx r3, r1, r9
    smlatt r3, r4, r8, r3
    @ smlatt r3, r5, r7, r3
    smlatt r3, r6, r10, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s8, r2
    @ 7
    smuadx r2, r0, r10
    smlabt r2, r4, r9, r2
    @ smlabt r2, r5, r8, r2
    smlabt r2, r6, r11, r2
    smuadx r3, r1, r10
    smlatt r3, r4, r9, r3
    @ smlatt r3, r5, r8, r3
    smlatt r3, r6, r11, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s9, r2
    @ 9
    smuadx r2, r0, r11
    smlabt r2, r4, r10, r2
    @ smlabt r2, r5, r9, r2
    smlabt r2, r6, r7, r2
    smuadx r3, r1, r11
    smlatt r3, r4, r10, r3
    @ smlatt r3, r5, r9, r3
    smlatt r3, r6, r7, r3
    smulbt r12, r2, lr
    smlabb r2, r12, lr, r2
    smulbt r12, r3, lr
    smlabb r3, r12, lr, r3
    pkhtb r2, r3, r2, asr #16
    vmov s10, r2
    pkhtb r2, r0, r4 @f2f1
    pkhtb r3, r1, r4, asr #16 @g2g1
    pkhbt r4, r0, r1, lsl #16 @f0g0
    @ 0
    smulbb r0, r4, r7
    smlad r0, r2, r11, r0
    @ smlabb r0, r5, r10, r0
    smlabb r0, r6, r8, r0
    smultb r1, r4, r7
    smlad r1, r3, r11, r1
    @ smlatb r1, r5, r10, r1
    smlatb r1, r6, r8, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s11, r0
    @ 2
    smulbb r0, r4, r8
    smlad r0, r2, r7, r0
    @ smlabb r0, r5, r11, r0
    smlabb r0, r6, r9, r0
    smultb r1, r4, r8
    smlad r1, r3, r7, r1
    @ smlatb r1, r5, r11, r1
    smlatb r1, r6, r9, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s12, r0
    @ 4
    smulbb r0, r4, r9
    smlad r0, r2, r8, r0
    @ smlabb r0, r5, r7, r0
    smlabb r0, r6, r10, r0
    smultb r1, r4, r9
    smlad r1, r3, r8, r1
    @ smlatb r1, r5, r7, r1
    smlatb r1, r6, r10, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s13, r0
    @ 6
    smulbb r0, r4, r10
    smlad r0, r2, r9, r0
    @ smlabb r0, r5, r8, r0
    smlabb r0, r6, r11, r0
    smultb r1, r4, r10
    smlad r1, r3, r9, r1
    @ smlatb r1, r5, r8, r1
    smlatb r1, r6, r11, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r0, r1, r0, asr #16
    vmov s14, r0
    @ 8
    smulbb r0, r4, r11
    smlad r0, r2, r10, r0
    @ smlabb r0, r5, r9, r0
    smlabb r0, r6, r7, r0
    smultb r1, r4, r11
    smlad r1, r3, r10, r1
    @ smlatb r1, r5, r9, r1
    smlatb r1, r6, r7, r1
    smulbt r12, r0, lr
    smlabb r0, r12, lr, r0
    smulbt r12, r1, lr
    smlabb r1, r12, lr, r1
    pkhtb r12, r1, r0, asr #16
    @ free r0~r6
    vmov r0, s0
    vmov r6, s5 @ a0a1
    vmov r1, s11 @ 0
    vmov r2, s6 @ 1
    vmov r3, s12 @ 2
    vmov r4, s7 @ 3
    vmov r5, s13 @ 4
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    sadd16 r5, r5, r6
    sadd16 r12, r12, r6
    str.w r1, [r0, #1196]
    str.w r2, [r0, #1916]
    str.w r3, [r0, #956]
    str.w r4, [r0, #476]
    str.w r5, [r0, #236]
    str.w r12, [r0, #2156]
    vmov r1, s1
    vmov r2, s8 @ 5
    vmov r3, s14 @ 6
    vmov r4, s9 @ 7
    vmov r5, s10 @ 9
    vmov r12, s3
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    sadd16 r5, r5, r6
    str.w r2, [r0, #1436]
    str.w r3, [r0, #716]
    str.w r4, [r0, #1676]
    str.w r5, [r0, #2396]
    cmp.w r1, r12
    bne.w ntt11_rader_body2
    pop {r2-r12, pc}