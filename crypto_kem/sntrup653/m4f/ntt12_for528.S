#include "rader11_macro.S"
.align
.syntax unified
.text
wpad:
    .word 929445
    .word 4621
@ for butterfly3
    .word 65537
    .word 115542825
    .word 187238115
    .word 42340550
    .word 139726576
    .word 120783972
    .word 93454982
    .word 14026547
    .word 195364948
    .word 105973036
    .word 277547650
    .word 222167647
    .word 15467922
    .word 11668389
    .word 275710166
    .word 300417443
    .word 267649268
    .word 37621622
    .word 250611281
    .word 281414974
    .word 73666699
    .word 176294496
    .word 86770174
    .word 39781807
    .word 15991020
    .word 27463791
    .word 259391666
    .word 33424745
    .word 174064985
    .word 95356747
    .word 89723368
    .word 90767934
    .word 122359796
@ for butterfly4
    .word 1
    .word 292880385
    .word 2858
    .word 187240863
    .word 2857
    .word 300092202
    .word 1231
    .word 263061660
    .word 1617
    .word 136054060
    .word 386
    .word 176294072
    .word 4294
    .word 153945295
    .word 3497
    .word 25300116
    .word 3824
    .word 245761617
    .word 4111
    .word 90769935
    .word 2656
    .word 9374900
    .word 3166
    .word 180488862
    .word 646
    .word 228987078
    .word 2489
    .word 250613287
    .word 1843
    .word 294391209
    .word 414
    .word 288821592
    .word 236
    .word 28509586
    .word 4443
    .word 195363070
    .word 1324
    .word 234885135
    .word 4014
    .word 207487624
    .word 2690
    .word 192416352
    .word 3252
    .word 300420642
    .word 1385
    .word 266735567
    .word 2754
    .word 35195899
    .word 1426
    .word 227410566
    .word 4407
    .word 120785724
    .word 2981
    .word 38930873
    .word 4047
    .word 43454103
    .word 4584
    .word 65929635
    .word 537
    .word 15990904
    .word 419
    .word 115736990
    .word 663
    .word 291177118
    .word 244
    .word 71827692

.equ basesize, 4
.global ntt12_for528
.type ntt12_for528, %function
ntt12_for528:
    push {r4-r11, lr}
    adr.w lr, wpad
    ldm lr!, {r11-r12}
    vmov s0, s1, r0, lr
    add.w r1, r0, #132*basesize*2
    vmov s2, r1
butterfly3:
    vmov lr, s1
    ldm lr!, {r1-r3}
    vmov s1, lr
    add.w lr, r0, #4*basesize*2
butterfly3_body:
    ldr.w r7, [r0]
    ldr.w r8, [r0, #4*basesize*2]
    ldr.w r9, [r0, #8*basesize*2]
    sbfx r4, r7, #0, #16
    pkhbt r5, r8, r9, lsl #16
    sbfx r6, r7, #16, #16
    pkhtb r7, r9, r8, asr #16
@ r4 = a0, r5 = a1a2 , r6 = b0, r7 = b1b2
    smlad r8, r5, r1, r4 @ c0
    smlad r9, r5, r2, r4 @ c1
    smlad r10, r5, r3, r4 @ c2
    smlad r4, r7, r1, r6 @ d0
    smlad r5, r7, r2, r6 @ d1
    smlad r6, r7, r3, r6 @ d2
    barrett_reduce r8, r11, r12, r7
    barrett_reduce r9, r11, r12, r7
    barrett_reduce r10, r11, r12, r7
    barrett_reduce r4, r11, r12, r7
    barrett_reduce r5, r11, r12, r7
    barrett_reduce r6, r11, r12, r7
    pkhbt r8, r8, r4, lsl #16
    pkhbt r9, r9, r5, lsl #16
    pkhbt r10, r10, r6, lsl #16
    str.w r9, [r0, #4*basesize*2]
    str.w r10, [r0, #8*basesize*2]
    str.w r8, [r0], #4
    cmp.w r0, lr
    bne.w butterfly3_body
    add.w r0, r0, #8*basesize*2
    vmov r10, s2
    cmp.w r0, r10
    bne.w butterfly3

    vmov r0, lr, s0, s1
ntt4:
    add.w r9, r0, #1*basesize*2
    ldm lr!, {r7-r8}
ntt4_body:
@ .rept 4
    ldr.w r1, [r0]
    ldr.w r2, [r0, #1*basesize*2]
    ldr.w r3, [r0, #2*basesize*2]
    ldr.w r4, [r0, #3*basesize*2]
    coef_multiply_w_16bitx2_wbot r3, r3, r7, r11, r12, r5, r6
    coef_multiply_w_16bitx2_wbot r4, r4, r7, r11, r12, r5, r6
    ssub16 r5, r1, r3
    ssub16 r6, r2, r4
    sadd16 r3, r1, r3
    sadd16 r4, r2, r4
    coef_multiply_w_16bitx2_wbot r4, r4, r8, r11, r12, r1, r2
    coef_multiply_w_16bitx2_wtop r6, r6, r8, r11, r12, r1, r2
    sadd16 r1, r3, r4
    ssub16 r2, r3, r4
    sadd16 r3, r5, r6
    ssub16 r4, r5, r6
    str.w r2, [r0, #1*basesize*2]
    str.w r3, [r0, #2*basesize*2]
    str.w r4, [r0, #3*basesize*2]
    str.w r1, [r0], #4
@ .endr
    cmp.w r0, r9
    bne.w ntt4_body
    add.w r0, r0, #3*basesize*2
    cmp.w r0, r10
    bne.w ntt4

    pop {r4-r11, pc}