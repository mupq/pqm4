.p2align 2,,3
.syntax unified
wpad:
    .word 935519
    .word 4274585910
    .word 4161799859
    .word 4232576215
    .word 4189781110
.text
.global intt9_rader_306
.type intt9_rader_306, %function
intt9_rader_306:
    push.w {r1-r12, lr}
    vpush.w {s16-s17}
    adr.w lr, wpad
    vldm lr, {s2-s6}
    vmov r12, s2
    mov.w r11, #4591
    add.w lr, r0, #612
    vmov s1, lr
    mov.w r1, #65537
    vmov r2, s3 @ w^3 w^6
intt9_rader_outer:
    add.w lr, r0, #4
    vmov s0, lr
intt9_rader_inner:
    ldr.w r6, [r0, #4] @ 1
    ldr.w r7, [r0, #8] @ 2
    ldr.w r8, [r0, #16] @ 4
    ldr.w r9, [r0, #20] @ 5
    ldr.w r10, [r0, #28] @ 7
    ldr.w lr, [r0, #32] @ 8
    pkhbt r3, r6, r7, lsl #16 @ a1a2
    pkhbt r4, r8, lr, lsl #16 @ a4a8
    pkhbt r5, r10, r9, lsl #16 @ a7a5
    pkhtb r6, r7, r6, asr #16 @ b1b2
    pkhtb r7, lr, r8, asr #16 @ b4b5
    pkhtb r8, r9, r10, asr #16 @ b7b8
    vmov s7, r6 @ b1b2
    vmov s8, r7 @ b4b8
    vmov s9, r8 @ b7b5
@ free : r6-r10, lr
    ldr.w r6, [r0]
    ldr.w r9, [r0, #12]
    ldr.w r10, [r0, #24]
    pkhbt r7, r9, r10, lsl #16 @ a3a6
    pkhtb r9, r10, r9, asr #16 @ b3b6
    sbfx r8, r6, #16, #16 @ b0
    sbfx r6, r6, #0, #16 @ a0
@ free : r10, lr
    smlad r10, r1, r9, r8
    smlad lr, r2, r9, r8
    smladx r8, r2, r9, r8
    vmov s10, r10 @ b0 + b3 + b6
    vmov s11, lr @ b0 + b3w^3 + b6w^6
    vmov s12, r8 @ b0 + b3w^6 + b6w^3
@ r3 = a1a2, r4 = a4a8, r5 = a7a5, r6 = a0, r7 = a3a6
@ free : r8-r10, lr
    smlad r8, r1, r7, r6 @ a0 + a3 + a6
    smlad r9, r2, r7, r6 @ a0 + a3w^3 + a6w^6
    smladx r10, r2, r7, r6 @ a0 + a3w^6 + a6w^3
@ free : r6-r7, lr
    smlad r6, r1, r3, r8
    smlad r6, r1, r4, r6
    smlad r6, r1, r5, r6 @ A0
    smlad r7, r2, r3, r8
    smlad r7, r2, r4, r7
    smlad r7, r2, r5, r7 @ A3
    smmulr lr, r6, r12
    mls r6, lr, r11, r6
    smmulr lr, r7, r12
    mls r7, lr, r11, r7
    pkhbt r6, r6, r7, lsl #16 @ A0A3
    smladx r7, r2, r3, r8
    smladx r7, r2, r4, r7
    smladx r7, r2, r5, r7 @ A6
    smmulr lr, r7, r12
    mls r7, lr, r11, r7
    vmov s13, r6 @ A0A3
    vmov s14, r7 @ A6
@ free : r1-r2, r6-r8, lr
@ r9 = a0 + a3w^3 + a6w^6
@ r10 = a0 + a3w^6 + a6w^3
@ r3 = a1a2, r4 = a4a8, r5 = a7a5
@ r3 = c0c1, r4 = c2c3, r5 = c4c5 for 6x6 mod x^6-1
    vmov r6, s4 @ 01
    vmov r7, s5 @ 23
    vmov r8, s6 @ 45
@ free : r1-r2, lr
    smladx r1, r6, r3, r10
    smladx r1, r7, r5, r1
    smladx r1, r8, r4, r1 @ A2
    smladx r2, r6, r4, r10
    smladx r2, r7, r3, r2
    smladx r2, r8, r5, r2 @ A5
    smmulr lr, r1, r12
    mls r1, lr, r11, r1
    smmulr lr, r2, r12
    mls r2, lr, r11, r2
    pkhbt r1, r1, r2, lsl #16 @ A2A5
    smladx r2, r6, r5, r10
    smladx r2, r7, r4, r2
    smladx r2, r8, r3, r2 @ A8
    smmulr lr, r2, r12
    mls r2, lr, r11, r2
@ free : r10, lr
    pkhbt r10, r3, r5 @ c0c5
    pkhtb r3, r3, r4 @ c2c1
    pkhtb r4, r4, r5 @ c4c3
@ free : r5, lr
    smlad r5, r6, r10, r9
    smlad r5, r7, r4, r5
    smlad r5, r8, r3, r5 @ A4
    smmulr lr, r5, r12
    mls r5, lr, r11, r5
    pkhbt r2, r2, r5, lsl #16 @ A8A4
    smlad r5, r6, r3, r9
    smlad r5, r7, r10, r5
    smlad r5, r8, r4, r5 @ A1
    smlad r9, r6, r4, r9
    smlad r9, r7, r3, r9
    smlad r9, r8, r10, r9 @ A7
    smmulr lr, r5, r12
    mls r5, lr, r11, r5
    smmulr lr, r9, r12
    mls r9, lr, r11, r9
    pkhbt r5, r5, r9, lsl #16 @ A1A7
    vmov s15, r1 @ A2A5
    vmov s16, r2 @ A8A4
    vmov s17, r5 @ A1A7
@ free : r1-r5, r9-r10, lr
    vmov r9, s11 @ b0 + b3w^3 + b6w^6
    vmov r10, s12 @ b0 + b3w^6 + b6w^3
    vmov r3, s7
    vmov r4, s8
    vmov r5, s9
    smladx r1, r6, r3, r10
    smladx r1, r7, r5, r1
    smladx r1, r8, r4, r1 @ B2
    smladx r2, r6, r4, r10
    smladx r2, r7, r3, r2
    smladx r2, r8, r5, r2 @ B5
    smmulr lr, r1, r12
    mls r1, lr, r11, r1
    smmulr lr, r2, r12
    mls r2, lr, r11, r2
    pkhbt r1, r1, r2, lsl #16 @ B2B5
    smladx r2, r6, r5, r10
    smladx r2, r7, r4, r2
    smladx r2, r8, r3, r2 @ B8
    smmulr lr, r2, r12
    mls r2, lr, r11, r2
@ free : r10, lr
    pkhbt r10, r3, r5 @ c0c5
    pkhtb r3, r3, r4 @ c2c1
    pkhtb r4, r4, r5 @ c4c3
@ free : r5, lr
    smlad r5, r6, r10, r9
    smlad r5, r7, r4, r5
    smlad r5, r8, r3, r5 @ B4
    smmulr lr, r5, r12
    mls r5, lr, r11, r5
    pkhbt r2, r2, r5, lsl #16 @ B8B4
    smlad r5, r6, r3, r9
    smlad r5, r7, r10, r5
    smlad r5, r8, r4, r5 @ B1
    smlad r9, r6, r4, r9
    smlad r9, r7, r3, r9
    smlad r9, r8, r10, r9 @ B7
    smmulr lr, r5, r12
    mls r5, lr, r11, r5
    smmulr lr, r9, r12
    mls r9, lr, r11, r9
    pkhbt r5, r5, r9, lsl #16 @ B1B7
@ free : r6-r8, lr
    vmov r6, s15 @ A2A5
    vmov r7, s16 @ A8A4
    vmov r8, s17 @ A1A7
    pkhbt lr, r8, r5, lsl #16 @ A1B1
    pkhtb r5, r5, r8, asr #16 @ A7B7
    pkhbt r8, r6, r1, lsl #16 @ A2B2
    pkhtb r1, r1, r6, asr #16 @ A5B5
    pkhbt r6, r7, r2, lsl #16 @ A8B8
    pkhtb r2, r2, r7, asr #16 @ A4B4
    str.w lr, [r0, #4]
    str.w r8, [r0, #8]
    str.w r2, [r0, #16]
    str.w r1, [r0, #20]
    str.w r5, [r0, #28]
    str.w r6, [r0, #32]
    mov.w r1, #65537
    vmov r2, s3
@ r3 = b4b2, r4 = b7b8, r10 = b1b5
    vmov r6, s10 @ b0 + b3 + b6
    vmov r7, s13 @ A0A3
    vmov r8, s14 @ A6
    smlad r5, r1, r3, r6
    smlad r5, r1, r4, r5
    smlad r5, r1, r10, r5 @ B0
    smlad r9, r2, r3, r6
    smlad r9, r2, r4, r9
    smlad r9, r2, r10, r9 @ B3
    smmulr lr, r5, r12
    mls r5, lr, r11, r5
    smmulr lr, r9, r12
    mls r9, lr, r11, r9
    pkhbt r5, r5, r9, lsl #16 @ B0B3
    smladx r9, r2, r3, r6
    smladx r9, r2, r4, r9
    smladx r9, r2, r10, r9 @ B6
    smmulr lr, r9, r12
    mls r9, lr, r11, r9
    pkhbt r8, r8, r9, lsl #16 @ A6B6
    pkhbt r10, r7, r5, lsl #16 @ A0B0
    pkhtb r7, r5, r7, asr #16 @ A3B3
    str.w r7, [r0, #12]
    str.w r8, [r0, #24]
    str.w r10, [r0], #4
    vmov lr, s0
    cmp.w r0, lr
    bne.w intt9_rader_inner
    add.w r0, #32
    vmov lr, s1
    cmp.w r0, lr
    bne.w intt9_rader_outer
    vpop.w {s16-s17}
    pop.w {r1-r12, pc}