#include "fft9_aux.h"

.p2align 2,,3
.syntax unified

.text
.global fft9
.type fft9, %function
fft9:
    push {r1-r12, lr}
    @ adr lr, wpad
    @ vldm lr, {s1-s12}
    movw.w lr, #18015
    movt.w lr, #14
    vmov s13, lr
    mov r12, #4591
    add.w r1, r0, #3060
    vmov s15, r1
    adr lr, wpad
@ lr = 935519, r12 = 4591
fft9_body:
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r1, [lr], #12
    vmov s0, r0
    vmov s14, lr
    vmov lr, s13
    @ vmov r1, s1
    @ vmov r2, s2
    @ vmov r3, s3
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #60]
    ldr.w r6, [r0, #120]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #60]
    str.w r6, [r0, #120]
    str.w r4, [r0], #4

    vmov r0, s0
    @ vmov r1, s4
    @ vmov r2, s5
    @ vmov r3, s6
    vmov lr, s14
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r1, [lr], #12
    vmov s14, lr
    vmov lr, s13

    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #44

    @ vmov r1, s7
    @ vmov r2, s8
    @ vmov r3, s9
    vmov lr, s14
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r1, [lr], #12
    vmov s14, lr
    vmov lr, s13

    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #44

    @ vmov r1, s10
    @ vmov r2, s11
    @ vmov r3, s12
    vmov lr, s14
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r1, [lr], #12
    vmov s14, lr
    vmov lr, s13

    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #4
    ldr.w r4, [r0]
    ldr.w r5, [r0, #20]
    ldr.w r6, [r0, #40]
    sbfx r7, r4, #0, #16
    pkhbt r8, r5, r6, lsl #16
    sbfx r9, r4, #16, #16
    pkhtb r10, r6, r5, asr #16
    smlad r4, r8, r1, r7
    smlad r5, r8, r2, r7
    smlad r6, r8, r3, r7
    smmulr r11, r4, lr
    mls r4, r11, r12, r4
    smmulr r11, r5, lr
    mls r5, r11, r12, r5
    smmulr r11, r6, lr
    mls r6, r11, r12, r6
    smlad r7, r10, r1, r9
    smlad r8, r10, r2, r9
    smlad r9, r10, r3, r9
    smmulr r11, r7, lr
    mls r7, r11, r12, r7
    smmulr r11, r8, lr
    mls r8, r11, r12, r8
    smmulr r11, r9, lr
    mls r9, r11, r12, r9
    pkhbt r4, r4, r7, lsl #16
    pkhbt r5, r5, r8, lsl #16
    pkhbt r6, r6, r9, lsl #16
    str.w r5, [r0, #20]
    str.w r6, [r0, #40]
    str.w r4, [r0], #44

    vmov r1, s15
    vmov lr, s14
    cmp.w r0, r1
    bne.w fft9_body
    
    pop {r1-r12, pc}