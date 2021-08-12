.p2align 2,,3
.syntax unified

.text
.global mod_reduce_857
.type mod_reduce_857, %function
@mod_reduce_857(int16_t* h, int16_t* hpad)
mod_reduce_857:
    push {r2-r12, lr}
    add.w r2, r1, #1714
    add.w r3, r1, #3426
    vmov s0, r0
    mov.w lr, #0
    movw.w r10, #11941
    movt.w r10, #14
    mov.w r12, #4621
    ldr.w r4, [r1], #4
loop:
    ldr.w r5, [r1], #4
    ldr.w r6, [r2], #4
    sadd16 r4, r4, r6
    pkhtb r7, lr, r6, asr #16
    pkhbt r6, lr, r6, lsl #16
    sadd16 r4, r4, r6
    sadd16 r5, r5, r7
    sbfx r6, r4, #0, #16
    sbfx r7, r4, #16, #16
    smmulr r8, r6, r10
    mls r6, r8, r12, r6
    smmulr r8, r7, r10
    mls r7, r8, r12, r7
    pkhbt r4, r6, r7, lsl #16
    str.w r4, [r0], #4
    ldr.w r4, [r1], #4
    ldr.w r6, [r2], #4
    sadd16 r5, r5, r6
    pkhtb r7, lr, r6, asr #16
    pkhbt r6, lr, r6, lsl #16
    sadd16 r5, r5, r6
    sadd16 r4, r4, r7
    sbfx r6, r5, #0, #16
    sbfx r7, r5, #16, #16
    smmulr r8, r6, r10
    mls r6, r8, r12, r6
    smmulr r8, r7, r10
    mls r7, r8, r12, r7
    pkhbt r5, r6, r7, lsl #16
    str.w r5, [r0], #4
    cmp.w r2, r3
    bne.w loop
    sbfx r4, r4, #0, #16
    smmulr r8, r4, r10
    mls r4, r8, r12, r4
    strh.w r4, [r0]
    @ vmov r0, s0
    @ ldr.w r5, [r0, #1518]
    @ pkhbt r5, r5, r4, lsl #16
    @ str.w r5, [r0, #1518]
    pop {r2-r12, pc}

.global mod3_857
.type mod3_857, %function
@mod3_857(int8_t* h, int16_t* hpad)
mod3_857:
    push {r2-r12, lr}
    add.w r2, r1, #1712
    mov.w r10, #0x55555555
    mov.w r12, #3
loop857:
    ldr.w r4, [r1, #4]
    ldr.w r3, [r1], #8
    sbfx r5, r3, #0, #16
    sbfx r6, r3, #16, #16
    sbfx r7, r4, #0, #16
    sbfx r8, r4, #16, #16
    smmulr r9, r5, r10
    mls r5, r9, r12, r5
    smmulr r9, r6, r10
    mls r6, r9, r12, r6
    smmulr r9, r7, r10
    mls r7, r9, r12, r7
    smmulr r9, r8, r10
    mls r8, r9, r12, r8
    bfi r11, r5, #0, #8
    bfi r11, r6, #8, #8
    bfi r11, r7, #16, #8
    bfi r11, r8, #24, #8
    str.w r11, [r0], #4
    cmp.w r1, r2
    bne.w loop857
    ldr.w r3, [r1]
    sbfx r5, r3, #0, #16
    smmulr r9, r5, r10
    mls r5, r9, r12, r5
    strb r5, [r0]
    pop {r2-r12, pc}