#include "rader13_macro.S"
.align
.syntax unified
.text
wpad:
    .word 598435
    .word 7177
@ for butterfly3
    .word 65537
    .word 4161341430
    .word 133625865
    .word 4163374329
    .word 224264479
    .word 4202302961
    .word 4202625064
    .word 4099275386
    .word 4112780638
    .word 232192913
    .word 4158977960
    .word 4198894791
    .word 4717182
    .word 4214486308
    .word 75953237
    .word 63763322
    .word 4225824058
    .word 5569347
    .word 24120790
    .word 211941958
    .word 234420196
    .word 18874247
    .word 217708012
    .word 233900685
    .word 4154982471
    .word 4220585094
    .word 214432563
    .word 4114283494
    .word 4084923262
    .word 4215474332
    .word 4125885388
    .word 4287037524
    .word 177077216
    .word 4219402650
    .word 4226219093
    .word 144443921
    .word 4233429360
    .word 4187622904
    .word 168889505
@ for butterfly4
    .word 1
    .word 128778241
    .word 2039
    .word 133562464
    .word 2038
    .word 122488823
    .word 2580
    .word 63765630
    .word 7056
    .word 786348
    .word 4476
    .word 69270665
    .word 3321
    .word 179440148
    .word 3608
    .word 4118016581
    .word 287
    .word 4234477447
    .word 6019
    .word 195757363
    .word 71
    .word 4273535614
    .word 1229
    .word 4112778219
    .word 5169
    .word 122686713
    .word 3755
    .word 18811860
    .word 5763
    .word 4219269647
    .word 1154
    .word 4187622702
    .word 6127
    .word 42337195
    .word 4973
    .word 4126143403
    .word 6042
    .word 4271373178
    .word 3906
    .word 80605767
    .word 5041
    .word 206569543
    .word 7093
    .word 79559923
    .word 972
    .word 105968506
    .word 1056
    .word 4114219843
    .word 5767
    .word 106887208
    .word 2987
    .word 4202300403
    .word 4397
    .word 40628898
    .word 939
    .word 24119005
    .word 5539
    .word 4258525704
    .word 4600
    .word 4083090608
    .word 3971
    .word 4273865858
    .word 1213
    .word 4150529081
    .word 4419
    .word 4068867046
    .word 3601
    .word 136115468
    .word 368
    .word 4186181078
    .word 3944
    .word 4198894233
    .word 3542
    .word 116194193
    .word 2076
    .word 4155046631
    .word 5711
    .word 201716537
@ for butterfly2
    @ .word 1
    @ .word 1965
    @ .word 1581
    @ .word 6201
    @ .word 2035
    @ .word 1186
    @ .word 2039
    @ .word 1869
    @ .word 96
    @ .word 2038
    @ .word 1059
    @ .word 6782
    @ .word 116
    @ .word 5453
    @ .word 3971
    @ .word 1616
    @ .word 6396
    @ .word 1213
    @ .word 6860
    @ .word 1494
    @ .word 3959
    @ .word 6744
    @ .word 835
    @ .word 4419
    @ .word 6279
    @ .word 972
    @ .word 1308
    @ .word 854
    @ .word 2705
    @ .word 4345
    @ .word 6290
    @ .word 1056
    @ .word 7093
    @ .word 11
    @ .word 3559
    @ .word 3037
    @ .word 3487
    @ .word 5097
    @ .word 1011
    @ .word 5763
    @ .word 5169
    @ .word 1630
    @ .word 4763
    @ .word 487
    @ .word 4610
    @ .word 1276
    @ .word 3755
    @ .word 619
    @ .word 2580
    @ .word 2738
    @ .word 2444
    @ .word 1047
    @ .word 3913
    @ .word 2478
    @ .word 7056
    @ .word 6253
    @ .word 3662
    @ .word 4476
    @ .word 4960
    @ .word 34
    @ .word 5023
    @ .word 1820
    @ .word 3601
    @ .word 6620
    @ .word 1757
    @ .word 368
    @ .word 318
    @ .word 471
    @ .word 1349
    @ .word 2472
    @ .word 1200
    @ .word 3944
    @ .word 1331
    @ .word 2987
    @ .word 1450
    @ .word 7158
    @ .word 2856
    @ .word 6803
    @ .word 1003
    @ .word 4397
    @ .word 5767
    @ .word 6849
    @ .word 2837
    @ .word 5353
    @ .word 3679
    @ .word 1996
    @ .word 3129
    @ .word 4973
    @ .word 1154
    @ .word 6855
    @ .word 1516
    @ .word 485
    @ .word 1511
    @ .word 5014
    @ .word 6127
    @ .word 3726
    @ .word 3321
    @ .word 1872
    @ .word 4114
    @ .word 2708
    @ .word 4678
    @ .word 5710
    @ .word 3608
    @ .word 6021
    @ .word 3028
    @ .word 287
    @ .word 209
    @ .word 1596
    @ .word 4855
    @ .word 1842
    @ .word 3542
    @ .word 5517
    @ .word 4373
    @ .word 2076
    @ .word 2262
    @ .word 2267
    @ .word 6752
    @ .word 4584
    @ .word 2713
    @ .word 5711
    @ .word 3374
    @ .word 5539
    @ .word 1783
    @ .word 1219
    @ .word 4878
    @ .word 3975
    @ .word 4020
    @ .word 4600
    @ .word 939
    @ .word 646
    @ .word 6097
    @ .word 2192
    @ .word 3826
    @ .word 3771
    @ .word 5872
    @ .word 5041
    @ .word 6042
    @ .word 1772
    @ .word 6992
    @ .word 2502
    @ .word 1269
    @ .word 3166
    @ .word 3906
    @ .word 3077
    @ .word 6019
    @ .word 6816
    @ .word 6514
    @ .word 3419
    @ .word 4703
    @ .word 4596
    @ .word 71
    @ .word 3152
    @ .word 3664
    @ .word 1229
    @ .word 945
    @ .word 5259
@ [1, 2, 4, 8, 3, 6, 12, 11, 9, 5, 10, 7]
@ [6, 3, 8, 4, 2, 1, 7, 10, 5, 9, 11, 12]
.equ basesize, 1
.global ntt12_for312
.type ntt12_for312, %function
ntt12_for312:
    push {r4-r11, lr}
    adr.w lr, wpad
    ldm lr!, {r11-r12}
    vmov s0, s1, r0, lr
    add.w r1, r0, #312*basesize*2
    vmov s2, r1
butterfly3:
    vmov lr, s1
    ldm lr!, {r1-r3}
    vmov s1, lr
    add.w lr, r0, #8*basesize*2
butterfly3_body:
    ldr.w r7, [r0]
    ldr.w r8, [r0, #8*basesize*2]
    ldr.w r9, [r0, #16*basesize*2]
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
    str.w r9, [r0, #8*basesize*2]
    str.w r10, [r0, #16*basesize*2]
    str.w r8, [r0], #4
    cmp.w r0, lr
    bne.w butterfly3_body
    add.w r0, r0, #16*basesize*2
    vmov r10, s2
    cmp.w r0, r10
    bne.w butterfly3

    vmov r0, lr, s0, s1
ntt4:
    add.w r9, r0, #2*basesize*2
    ldm lr!, {r7-r8}
ntt4_body:
@ .rept 4
    ldr.w r1, [r0]
    ldr.w r2, [r0, #2*basesize*2]
    ldr.w r3, [r0, #4*basesize*2]
    ldr.w r4, [r0, #6*basesize*2]
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
    str.w r2, [r0, #2*basesize*2]
    str.w r3, [r0, #4*basesize*2]
    str.w r4, [r0, #6*basesize*2]
    str.w r1, [r0], #4
@ .endr
    cmp.w r0, r9
    bne.w ntt4_body
    add.w r0, r0, #6*basesize*2
    cmp.w r0, r10
    bne.w ntt4

@     vmov r0, s0
@ ntt2:
@     ldr.w r9, [lr], #4
@ .rept basesize/2
@     ldr.w r1, [r0]
@     ldr.w r2, [r0, #1*basesize*2]
@     coef_multiply_w_16bitx2_wbot r2, r2, r9, r11, r12, r5, r6
@     sadd16 r3, r1, r2
@     ssub16 r4, r1, r2
@     str.w r4, [r0, #1*basesize*2]
@     str.w r3, [r0], #4
@ .endr
@     add.w r0, r0, #1*basesize*2
@     cmp.w r0, r10
@     bne.w ntt2

    pop {r4-r11, pc}