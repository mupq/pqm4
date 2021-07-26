#include "rader11_macro.S"
.align
.syntax unified
.text
wpad:
    .word 929445
    .word 4621
@ @ for butterfly4
    .word 9961473
    .word 1
    .word 115540010
    .word 1764
    .word 7210724
    .word 1763
    .word 287378885
    .word 4377
    .word 258932914
    .word 3958
    .word 275712807
    .word 4202
    .word 294981913
    .word 4084
    .word 275385887
    .word 37
    .word 58068854
    .word 574
    .word 139726779
    .word 1640
    .word 114363098
    .word 214
    .word 260506751
    .word 3195
    .word 101847028
    .word 1867
    .word 37618215
    .word 3236
    .word 65732645
    .word 1369
    .word 128779925
    .word 1931
    .word 260375983
    .word 607
    .word 33424397
    .word 3297
    .word 286197352
    .word 178
    .word 209391706
    .word 4385
    .word 11862230
    .word 4207
    .word 73662593
    .word 2778
    .word 65405725
    .word 2132
    .word 21431399
    .word 3975
    .word 124716875
    .word 1455
    .word 89723262
    .word 1965
    .word 134089892
    .word 510
    .word 196871015
    .word 797
    .word 91820171
    .word 1124
    .word 222169312
    .word 327
    .word 156567435
    .word 4235
    .word 216074737
    .word 3004
    .word 292618847
    .word 3390
@ for butterfly3
    .word 65537
    .word 187238115
    .word 115542825
    .word 122359796
    .word 300417598
    .word 89720169
    .word 95356747
    .word 90768729
    .word 33426016
    .word 259391666
    .word 15470703
    .word 15991203
    .word 39781807
    .word 174064126
    .word 176293164
    .word 73666699
    .word 105975102
    .word 250613958
    .word 37621622
    .word 27459828
    .word 300421108
    .word 275710166
    .word 93457317
    .word 15466674
    .word 222167647
    .word 86772354
    .word 105975947
    .word 195364948
    .word 42338099
    .word 93454550
    .word 120783972
    .word 281415408
    .word 42338388

.equ basesize, 2
.global intt12_for264
.type intt12_for264, %function
intt12_for264:
    push {r4-r11, lr}
    adr.w lr, wpad
    ldm lr!, {r11-r12}
    vmov s0, s1, r0, lr
    add.w r10, r0, #132*basesize*2
    vmov s2, r10
intt4:
    add.w r9, r0, #1*basesize*2
    ldm lr!, {r7-r8}
intt4_body:
@ .rept 4
    ldr.w r3, [r0]
    ldr.w r4, [r0, #1*basesize*2]
    ldr.w r5, [r0, #2*basesize*2]
    ldr.w r6, [r0, #3*basesize*2]
    sadd16 r2, r3, r4
    ssub16 r3, r3, r4
    sadd16 r4, r5, r6
    ssub16 r5, r5, r6
    coef_multiply_w_16bitx2_wbot r3, r3, r7, r11, r12, r1, r6
    coef_multiply_w_16bitx2_wtop r5, r5, r7, r11, r12, r1, r6
    sadd16 r1, r2, r4
    ssub16 r4, r2, r4
    sadd16 r2, r3, r5
    ssub16 r5, r3, r5
    coef_multiply_w_16bitx2_wbot r4, r4, r8, r11, r12, r3, r6
    coef_multiply_w_16bitx2_wbot r5, r5, r8, r11, r12, r3, r6
    sbfx r3, r1, #0, #16
    sbfx r6, r1, #16, #16
    barrett_reduce r3, r11, r12, r1
    barrett_reduce r6, r11, r12, r1
    pkhbt r1, r3, r6, lsl #16
    str.w r2, [r0, #1*basesize*2]
    str.w r4, [r0, #2*basesize*2]
    str.w r5, [r0, #3*basesize*2]
    str.w r1, [r0], #4
@ .endr
    cmp.w r0, r9
    bne.w intt4_body
    add.w r0, r0, #3*basesize*2
    cmp.w r0, r10
    bne.w intt4

    vmov r0, s0
    vmov s1, lr
ibutterfly3:
    vmov lr, s1
    ldm lr!, {r1-r3}
    vmov s1, lr
    add.w lr, r0, #4*basesize*2
ibutterfly3_body:
    ldr.w r4, [r0]
    ldr.w r6, [r0, #4*basesize*2]
    ldr.w r7, [r0, #8*basesize*2]
    sadd16 r10, r4, r6
    sadd16 r10, r10, r7
    pkhbt r5, r6, r7, lsl #16
    pkhtb r6, r7, r6, asr #16

    smuad r7, r2, r5
    smlabb r7, r1, r4, r7
    smuad r8, r2, r6
    smlabt r8, r1, r4, r8
    barrett_reduce r7, r11, r12, r9
    barrett_reduce r8, r11, r12, r9
    pkhbt r7, r7, r8, lsl #16

    smuad r8, r3, r5
    smlatb r8, r1, r4, r8
    smuad r9, r3, r6
    smlatt r9, r1, r4, r9
    barrett_reduce r8, r11, r12, r4
    barrett_reduce r9, r11, r12, r4
    pkhbt r8, r8, r9, lsl #16

    sbfx r4, r10, #0, #16
    sbfx r5, r10, #16, #16
    barrett_reduce r4, r11, r12, r6
    barrett_reduce r5, r11, r12, r6
    pkhbt r10, r4, r5, lsl #16

    str.w r7, [r0, #4*basesize*2]
    str.w r8, [r0, #8*basesize*2]
    str.w r10, [r0], #4
    cmp.w r0, lr
    bne.w ibutterfly3_body
    add.w r0, r0, #8*basesize*2
    vmov r10, s2
    cmp.w r0, r10
    bne.w ibutterfly3
    pop {r4-r11, pc}
