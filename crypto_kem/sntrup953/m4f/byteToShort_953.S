.p2align 2,,3
.syntax unified
.text
.global byteToShort_953
.type byteToShort_953, %function
byteToShort_953:
    push {r2-r12, lr}
    add.w r2, r1, #940
body:
    ldr.w r4, [r1, #4]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    ldr.w r7, [r1, #16]
    ldr.w r3, [r1], #20
    sbfx r8, r3, #0, #8
    sbfx r9, r3, #8, #8
    pkhbt r8, r8, r9, lsl #16 @ 0
    sbfx r9, r3, #16, #8
    sbfx r10, r3, #24, #8
    pkhbt r9, r9, r10, lsl #16 @ 4
    sbfx r10, r4, #0, #8
    sbfx r11, r4, #8, #8
    pkhbt r10, r10, r11, lsl #16 @ 8
    sbfx r11, r4, #16, #8
    sbfx r12, r4, #24, #8
    pkhbt r11, r11, r12, lsl #16 @ 12
    sbfx r12, r5, #0, #8
    sbfx lr, r5, #8, #8
    pkhbt r12, r12, lr, lsl #16 @ 16
    sbfx lr, r5, #16, #8
    sbfx r3, r5, #24, #8
    pkhbt lr, lr, r3, lsl #16 @ 20
    sbfx r3, r6, #0, #8
    sbfx r4, r6, #8, #8
    pkhbt r3, r3, r4, lsl #16 @ 24
    sbfx r4, r6, #16, #8
    sbfx r5, r6, #24, #8
    pkhbt r4, r4, r5, lsl #16 @ 28
    sbfx r5, r7, #0, #8
    sbfx r6, r7, #8, #8
    pkhbt r5, r5, r6, lsl #16
    sbfx r6, r7, #16, #8
    sbfx r7, r7, #24, #8
    pkhbt r6, r6, r7, lsl #16
    str.w r9, [r0, #4]
    str.w r10, [r0, #8]
    str.w r11, [r0, #12]
    str.w r12, [r0, #16]
    str.w lr, [r0, #20]
    str.w r3, [r0, #24]
    str.w r4, [r0, #28]
    str.w r5, [r0, #32]
    str.w r6, [r0, #36]
    str.w r8, [r0], #40
    cmp.w r1, r2
    bne.w body
    ldr.w r3, [r1]
    ldr.w r4, [r1, #4]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    sbfx r8, r3, #0, #8
    sbfx r9, r3, #8, #8
    pkhbt r8, r8, r9, lsl #16 @ 0
    sbfx r9, r3, #16, #8
    sbfx r10, r3, #24, #8
    pkhbt r9, r9, r10, lsl #16 @ 4
    sbfx r10, r4, #0, #8
    sbfx r11, r4, #8, #8
    pkhbt r10, r10, r11, lsl #16 @ 8
    sbfx r11, r4, #16, #8
    sbfx r12, r4, #24, #8
    pkhbt r11, r11, r12, lsl #16 @ 12
    sbfx r12, r5, #0, #8
    sbfx lr, r5, #8, #8
    pkhbt r12, r12, lr, lsl #16 @ 16
    sbfx lr, r5, #16, #8
    sbfx r3, r5, #24, #8
    pkhbt lr, lr, r3, lsl #16 @ 20
    sbfx r3, r6, #0, #8
    ubfx r3, r3, #0, #16
    str.w r8, [r0]
    str.w r9, [r0, #4]
    str.w r10, [r0, #8]
    str.w r11, [r0, #12]
    str.w r12, [r0, #16]
    str.w lr, [r0, #20]
    strh.w r3, [r0, #24]
    pop {r2-r12, pc}

.global mod3_953
.type mod3_953, %function
@mod3_953(int8_t* h, int16_t* hpad)
mod3_953:
    push {r2-r12, lr}
    add.w r2, r1, #1904
    mov.w r10, #0x55555555
    mov.w r12, #3
mod3_953_loop:
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
    bne.w mod3_953_loop
    ldr.w r3, [r1]
    sbfx r5, r3, #0, #16
    smmulr r9, r5, r10
    mls r5, r9, r12, r5
    strb r5, [r0]
    pop {r2-r12, pc}