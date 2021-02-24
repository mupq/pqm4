#include "ifft9_aux.h"

.p2align 2,,3
.syntax unified

.text
.global ifft9
.type ifft9, %function
ifft9:
    push {r1-r12, lr}
    movw.w r12, #18015
    movt.w r12, #14
    mov.w r11, #4591
    add.w r10, r0, #3060
    vmov s1, r10
    adr lr, wpadi9
ifft9_body:
    vmov s0, r0
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r1, [lr], #12
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #44
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r1, [lr], #12
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #44
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r1, [lr], #12
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #20]
    ldr.w r7, [r0, #40]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #20]
    str.w r8, [r0, #40]
    str.w r10, [r0], #44
    vmov r0, s0
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r1, [lr], #12
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #4
    ldr.w r4, [r0]
    ldr.w r6, [r0, #60]
    ldr.w r7, [r0, #120]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    sbfx r8, r10, #0, #16
    sbfx r9, r10, #16, #16
    smmulr r10, r8, r12
    mls r8, r10, r11, r8
    smmulr r10, r9, r12
    mls r9, r10, r11, r9
    pkhbt r10, r8, r9, lsl #16
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16
    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    smmulr r9, r7, r12
    mls r7, r9, r11, r7
    smmulr r9, r8, r12
    mls r8, r9, r11, r8
    pkhbt r7, r7, r8, lsl #16
    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    smmulr r4, r8, r12
    mls r8, r4, r11, r8
    smmulr r4, r9, r12
    mls r9, r4, r11, r9
    pkhbt r8, r8, r9, lsl #16
    str.w r7, [r0, #60]
    str.w r8, [r0, #120]
    str.w r10, [r0], #124
    vmov r1, s1
    cmp.w r0, r1
    bne.w ifft9_body
    pop {r1-r12, pc}
