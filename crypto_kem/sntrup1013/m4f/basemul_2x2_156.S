#include "rader13_macro.S"
.align
.syntax unified
.text
wpad:
    .word 470404551
    .word 943
    .word 6234
    .word 1329
    .word 5848
    .word 4404
    .word 2773
    .word 5575
    .word 1602
    .word 6518
    .word 659
    .word 4102
    .word 3075
    .word 72
    .word 7105
    .word 5117
    .word 2060
    .word 6912
    .word 265
    .word 3196
    .word 3981
    .word 3268
    .word 3909
    .word 5382
    .word 1795
    .word 7114
    .word 63
    .word 5391
    .word 1786
    .word 1129
    .word 6048
    .word 792
    .word 6385
    .word 729
    .word 6448
    .word 4262
    .word 2915
    .word 6335
    .word 842
    .word 3357
    .word 3820
    .word 5292
    .word 1885
    .word 6484
    .word 693
    .word 5642
    .word 1535
    .word 5242
    .word 1935
    .word 2531
    .word 4646
    .word 6931
    .word 246
    .word 6135
    .word 1042
    .word 5092
    .word 2085
    .word 446
    .word 6731
    .word 796
    .word 6381
    .word 2271
    .word 4906
    .word 5598
    .word 1579
    .word 2706
    .word 4471
    .word 6310
    .word 867
    .word 1404
    .word 5773
    .word 2892
    .word 4285
    .word 6087
    .word 1090
    .word 4073
    .word 3104
    .word 3015
    .word 4162
    .word 3450
    .word 3727
    .word 2360
    .word 4817
    .word 1058
    .word 6119
    .word 2748
    .word 4429
    .word 2716
    .word 4461
    .word 5436
    .word 1741
    .word 2364
    .word 4813
    .word 5112
    .word 2065
    .word 4457
    .word 2720
    .word 1184
    .word 5993
    .word 1212
    .word 5965
    .word 6009
    .word 1168
    .word 1520
    .word 5657
    .word 2704
    .word 4473
    .word 2380
    .word 4797
    .word 6141
    .word 1036
    .word 2528
    .word 4649
    .word 1022
    .word 6155
    .word 5847
    .word 1330
    .word 4811
    .word 2366
    .word 1506
    .word 5671
    .word 4495
    .word 2682
    .word 4965
    .word 2212
    .word 900
    .word 6277
    .word 2958
    .word 4219
    .word 276
    .word 6901
    .word 4065
    .word 3112
    .word 4141
    .word 3036
    .word 5524
    .word 1653
    .word 2801
    .word 4376
    .word 6383
    .word 794
    .word 3347
    .word 3830
    .word 2723
    .word 4454
    .word 6245
    .word 932
    .word 5932
    .word 1245
    .word 3829
    .word 3348
    .word 2489
    .word 4688
    .word 1557
    .word 5620
    .word 2103
    .word 5074

.equ basesize, 2
.global basemul_2x2_156
.type basemul_2x2_156, %function
basemul_2x2_156:
    push {r4-r11, lr}
    adr.w lr, wpad
    ldr.w r12, [lr], #4
    add.w r11, r0, #156*basesize*2
basemul_2x2_156_body:
    ldr.w r10, [lr], #4
    ldr.w r3, [r1], #4
    ldr.w r4, [r2], #4

    smuadx r5, r3, r4
    montgomery_reduce r5, r12, r9

    smultt r6, r3, r4
    montgomery_reduce r6, r12, r9
    smulbb r7, r3, r4
    smlabt r6, r10, r6, r7
    montgomery_reduce r6, r12, r9
    pkhtb r5, r5, r6, asr #16
    str.w r5, [r0], #4
    cmp.w r0, r11
    bne.w basemul_2x2_156_body
    pop {r4-r11, pc}
