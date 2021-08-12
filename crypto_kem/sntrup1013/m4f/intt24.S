#include "rader13_macro.S"
.align
.syntax unified
.text
wpad:
    .word 598435
    .word 7177
@ for butterfly2
    .word 1
    .word 5212
    .word 976
    .word 5596
    .word 395
    .word 6118
    .word 5139
    .word 7081
    .word 5308
    .word 5138
    .word 5991
    .word 5142
    .word 1918
    .word 6232
    .word 5948
    .word 3513
    .word 4025
    .word 7106
    .word 2581
    .word 2474
    .word 3758
    .word 663
    .word 361
    .word 1158
    .word 4100
    .word 3271
    .word 4011
    .word 5908
    .word 4675
    .word 185
    .word 5405
    .word 1135
    .word 2136
    .word 1305
    .word 3406
    .word 3351
    .word 4985
    .word 1080
    .word 6531
    .word 6238
    .word 2577
    .word 3157
    .word 3202
    .word 2299
    .word 5958
    .word 5394
    .word 1638
    .word 3803
    .word 1466
    .word 4464
    .word 2593
    .word 425
    .word 4910
    .word 4915
    .word 5101
    .word 2804
    .word 1660
    .word 3635
    .word 5335
    .word 2322
    .word 5581
    .word 6968
    .word 6890
    .word 4149
    .word 1156
    .word 3569
    .word 1467
    .word 2499
    .word 4469
    .word 3063
    .word 5305
    .word 3856
    .word 3451
    .word 1050
    .word 2163
    .word 5666
    .word 6692
    .word 5661
    .word 322
    .word 6023
    .word 2204
    .word 4048
    .word 5181
    .word 3498
    .word 1824
    .word 4340
    .word 328
    .word 1410
    .word 2780
    .word 6174
    .word 374
    .word 4321
    .word 19
    .word 5727
    .word 4190
    .word 5846
    .word 3233
    .word 5977
    .word 4705
    .word 5828
    .word 6706
    .word 6859
    .word 6809
    .word 5420
    .word 557
    .word 3576
    .word 5357
    .word 2154
    .word 7143
    .word 2217
    .word 2701
    .word 3515
    .word 924
    .word 121
    .word 4699
    .word 3264
    .word 6130
    .word 4733
    .word 4439
    .word 4597
    .word 6558
    .word 3422
    .word 5901
    .word 2567
    .word 6690
    .word 2414
    .word 5547
    .word 2008
    .word 1414
    .word 6166
    .word 2080
    .word 3690
    .word 4140
    .word 3618
    .word 7166
    .word 84
    .word 6121
    .word 887
    .word 2832
    .word 4472
    .word 6323
    .word 5869
    .word 6205
    .word 898
    .word 2758
    .word 6342
    .word 433
    .word 3218
    .word 5683
    .word 317
    .word 5964
    .word 781
    .word 5561
    .word 3206
    .word 1724
    .word 7061
@ @ for butterfly4
    .word 4166189057
    .word 1
    .word 4161403059
    .word 5139
    .word 4288739338
    .word 5138
    .word 214430715
    .word 1466
    .word 85526616
    .word 5101
    .word 74447124
    .word 3635
    .word 4117169594
    .word 3233
    .word 4062840444
    .word 6809
    .word 183826404
    .word 3576
    .word 68816251
    .word 2758
    .word 4089907356
    .word 5964
    .word 4219339074
    .word 3206
    .word 4216327329
    .word 2577
    .word 234357293
    .word 1638
    .word 4179885712
    .word 6238
    .word 224329109
    .word 2780
    .word 4228711814
    .word 4190
    .word 131660194
    .word 1410
    .word 4240247494
    .word 6121
    .word 210172336
    .word 6205
    .word 51247939
    .word 84
    .word 4290376624
    .word 2136
    .word 230292275
    .word 3271
    .word 75891049
    .word 1135
    .word 206899729
    .word 2204
    .word 4233493882
    .word 1050
    .word 4073850470
    .word 6023
    .word 233899140
    .word 1414
    .word 4096589537
    .word 3422
    .word 4077385904
    .word 2008
    .word 4229237468
    .word 5948
    .word 92406088
    .word 7106
    .word 4207801429
    .word 1158
    .word 7930780
    .word 6890
    .word 230361741
    .word 3569
    .word 4125947214
    .word 3856
    .word 58194912
    .word 2701
    .word 5570549
    .word 121
    .word 58915892
    .word 4597
@ for butterfly3
    .word 65537
    .word 133625865
    .word 4161341430
    .word 168889505
    .word 24120824
    .word 4233492890
    .word 144443921
    .word 4187683925
    .word 4219403238
    .word 177077216
    .word 63701076
    .word 4125949831
    .word 4215474332
    .word 4226218878
    .word 4114281338
    .word 214432563
    .word 4654214
    .word 4155046801
    .word 233900685
    .word 4287100396
    .word 18812153
    .word 234420196
    .word 232192582
    .word 24120481
    .word 5569347
    .word 4084921658
    .word 63765472
    .word 75953237
    .word 4202624292
    .word 4717363
    .word 4198894791
    .word 4220647336
    .word 232191972
    .word 4112780638
    .word 4163435130
    .word 4202624085
    .word 4202302961
    .word 217645343
    .word 4163374430
@ [1, 2, 4, 8, 3, 6, 12, 11, 9, 5, 10, 7]
@ [6, 3, 8, 4, 2, 1, 7, 10, 5, 9, 11, 12]
.equ basesize, 7
.global intt24
.type intt24, %function
intt24:
    push {r4-r11, lr}
    adr.w lr, wpad
    ldm lr!, {r11-r12}
    vmov s0, s1, r0, lr
    add.w r10, r0, #156*basesize*2
    add.w r10, r10, #156*basesize*2
    vmov s2, r10
intt2:
    ldr.w r9, [lr], #4
.rept basesize/2
    ldr.w r1, [r0]
    ldr.w r2, [r0, #1*basesize*2]
    sadd16 r3, r1, r2
    ssub16 r4, r1, r2
    coef_multiply_w_16bitx2_wbot r4, r4, r9, r11, r12, r5, r6
    sbfx r1, r3, #0, #16
    sbfx r2, r3, #16, #16
    barrett_reduce r1, r11, r12, r5
    barrett_reduce r2, r11, r12, r5
    pkhbt r3, r1, r2, lsl #16
    str.w r4, [r0, #1*basesize*2]
    str.w r3, [r0], #4
.endr
    ldrh.w r1, [r0]
    ldrh.w r2, [r0, #14]
    sadd16 r3, r1, r2
    ssub16 r4, r1, r2
    smulbb r5, r9, r4
    smmulr r6, r5, r11
    mls r4, r6, r12, r5
    sbfx r1, r3, #0, #16
    smmulr r6, r1, r11
    mls r3, r6, r12, r1
    @ coef_multiply_w_16bitx2_wbot r4, r4, r9, r11, r12, r5, r6
    strh.w r4, [r0, #14]
    strh.w r3, [r0], #2

    add.w r0, r0, #1*basesize*2
    cmp.w r0, r10
    bne.w intt2

    vmov r0, s0
intt4:
    add.w r9, r0, #2*basesize*2
    ldm lr!, {r7-r8}
intt4_body:
@ .rept 4
    ldr.w r3, [r0]
    ldr.w r4, [r0, #2*basesize*2]
    ldr.w r5, [r0, #4*basesize*2]
    ldr.w r6, [r0, #6*basesize*2]
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
    str.w r2, [r0, #2*basesize*2]
    str.w r4, [r0, #4*basesize*2]
    str.w r5, [r0, #6*basesize*2]
    str.w r1, [r0], #4
@ .endr
    cmp.w r0, r9
    bne.w intt4_body
    add.w r0, r0, #6*basesize*2
    cmp.w r0, r10
    bne.w intt4

    vmov r0, s0
    vmov s1, lr
ibutterfly3:
    vmov lr, s1
    ldm lr!, {r1-r3}
    vmov s1, lr
    add.w lr, r0, #8*basesize*2
ibutterfly3_body:
    ldr.w r4, [r0]
    ldr.w r6, [r0, #8*basesize*2]
    ldr.w r7, [r0, #16*basesize*2]
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

    str.w r7, [r0, #8*basesize*2]
    str.w r8, [r0, #16*basesize*2]
    str.w r10, [r0], #4
    cmp.w r0, lr
    bne.w ibutterfly3_body
    add.w r0, r0, #16*basesize*2
    vmov r10, s2
    cmp.w r0, r10
    bne.w ibutterfly3
    pop {r4-r11, pc}
