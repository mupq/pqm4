.macro barrett_reduce tar, qinv, q, tmp
    smmulr \tmp, \tar, \qinv
    mls \tar, \tmp, \q, \tar
.endm

.macro coef_multiply_w_16bitx2_wbot coef, w, qinv, q, tmp0, tmp1
    smulbb \tmp0, \w, \coef
    smulbt \tmp1, \w, \coef
    barrett_reduce \tmp0, \qinv, \q, \coef
    barrett_reduce \tmp1, \qinv, \q, \coef
    pkhbt \coef, \tmp0, \tmp1, lsl #16
.endm

.macro coef_multiply_w_16bitx2_wtop coef, w, qinv, q, tmp0, tmp1
    smultb \tmp0, \w, \coef
    smultt \tmp1, \w, \coef
    barrett_reduce \tmp0, \qinv, \q, \coef
    barrett_reduce \tmp1, \qinv, \q, \coef
    pkhbt \coef, \tmp0, \tmp1, lsl #16
.endm


.p2align 2,,3
.syntax unified
.text
wpad:
    .word 545116
    .word 89586345
    .word 89523543

.equ basesize, 36
.global intt6
.type intt6, %function
intt6:
    push {r4-r11, lr}
    adr.w lr, wpad
    mov.w r10, #65537
    ldr.w r11, [lr], #4
    mov.w r12, #7879
    vldm lr, {s1-s2}
    add.w lr, r0, #48*basesize*2
    add.w lr, lr, #30*basesize*2
    vmov s3, lr
    vmov s0, r0
intt6_body_1:
    add.w lr, r0, #1*basesize*2
    vmov s4, lr
intt6_body_2:
    ldr.w r2, [r0]
    ldr.w r3, [r0, #1*basesize*2]
    ldr.w r4, [r0, #2*basesize*2]
    ldr.w r5, [r0, #3*basesize*2]
    ldr.w r6, [r0, #4*basesize*2]
    ldr.w r7, [r0, #5*basesize*2]
    vmov r0, s2
    sadd16 r1, r2, r3
    ssub16 r2, r2, r3
    sadd16 r3, r4, r5
    ssub16 r4, r4, r5
    sadd16 r5, r6, r7
    ssub16 r6, r6, r7
    coef_multiply_w_16bitx2_wbot r4, r0, r11, r12, r7, r8
    coef_multiply_w_16bitx2_wtop r6, r0, r11, r12, r7, r8
    pkhbt r8, r4, r6, lsl #16 @ 35a
    pkhtb r9, r6, r4, asr #16 @ 35b
    pkhbt r6, r3, r5, lsl #16 @ 24a
    pkhtb r7, r5, r3, asr #16 @ 24b
    vmov r0, s1
    smuadx r3, r0, r6
    smlabb r3, r10, r1, r3
    smuadx r4, r0, r7
    smlabt r4, r10, r1, r4
    barrett_reduce r3, r11, r12, lr
    barrett_reduce r4, r11, r12, lr
    pkhbt r3, r3, r4, lsl #16 @ 2
    smuad r4, r0, r6
    smlabb r4, r10, r1, r4
    smuad r5, r0, r7
    smlabt r5, r10, r1, r5
    barrett_reduce r4, r11, r12, lr
    barrett_reduce r5, r11, r12, lr
    pkhbt r5, r4, r5, lsl #16 @ 4
    smuad r6, r10, r6
    smlabb r6, r10, r1, r6
    smuad r7, r10, r7
    smlabt r7, r10, r1, r7
    barrett_reduce r6, r11, r12, lr
    barrett_reduce r7, r11, r12, lr
    pkhbt r1, r6, r7, lsl #16 @ 0
    smuadx r4, r0, r8
    smlabb r4, r10, r2, r4
    smuadx r6, r0, r9
    smlabt r6, r10, r2, r6
    barrett_reduce r4, r11, r12, lr
    barrett_reduce r6, r11, r12, lr
    pkhbt r4, r4, r6, lsl #16 @ 3
    smuad r6, r0, r8
    smlabb r6, r10, r2, r6
    smuad r7, r0, r9
    smlabt r7, r10, r2, r7
    barrett_reduce r6, r11, r12, lr
    barrett_reduce r7, r11, r12, lr
    pkhbt r6, r6, r7, lsl #16 @ 5
    smuad r8, r10, r8
    smlabb r8, r10, r2, r8
    smuad r9, r10, r9
    smlabt r9, r10, r2, r9
    barrett_reduce r8, r11, r12, lr
    barrett_reduce r9, r11, r12, lr
    pkhbt r2, r8, r9, lsl #16 @ 1

    vmov r0, s0
    vmov lr, s4
    str.w r2, [r0, #1*basesize*2]
    str.w r3, [r0, #2*basesize*2]
    str.w r4, [r0, #3*basesize*2]
    str.w r5, [r0, #4*basesize*2]
    str.w r6, [r0, #5*basesize*2]
    str.w r1, [r0], #4
    vmov s0, r0
    cmp.w r0, lr
    bne.w intt6_body_2
    add.w r0, r0, #5*basesize*2
    vmov lr, s3
    vmov s0, r0
    cmp.w r0, lr
    bne.w intt6_body_1
    pop {r4-r11, pc}

    