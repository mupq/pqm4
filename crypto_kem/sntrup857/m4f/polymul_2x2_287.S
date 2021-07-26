.macro barrett_reduce tar, qinv, q, tmp
    smmulr \tmp, \tar, \qinv
    mls \tar, \tmp, \q, \tar
.endm

.p2align 2,,3
.syntax unified
.text
.global polymul_2x2_287
.type polymul_2x2_287, %function
polymul_2x2_287:
    push {r4-r11, lr}
    adr.w lr, wpad
    movw.w r11, #44798
    movt.w r11, #12
    mov.w r12, #5167
    add.w r10, r0, #1148
polymul_2x2_287_body:
.rept 7
    ldr.w r9, [lr], #4
    ldr.w r3, [r1], #4
    ldr.w r4, [r2], #4
    smulbb r5, r3, r4
    smuadx r6, r3, r4
    smultt r7, r3, r4
    barrett_reduce r7, r11, r12, r8
    smlabb r5, r9, r7, r5
    barrett_reduce r5, r11, r12, r8
    barrett_reduce r6, r11, r12, r8
    pkhbt r5, r5, r6, lsl #16
    str.w r5, [r0], #4
.endr
    cmp.w r0, r10
    bne.w polymul_2x2_287_body
    pop {r4-r11, pc}

wpad:
    .word 1
    .word 3477
    .word 3916
    .word 887
    .word 4567
    .word 1268
    .word 1385
    .word 1731
    .word 4299
    .word 4659
    .word 798
    .word 5134
    .word 4100
    .word 5114
    .word 4668
    .word 1089
    .word 4209
    .word 1749
    .word 4881
    .word 2809
    .word 1263
    .word 4287
    .word 4271
    .word 309
    .word 4824
    .word 966
    .word 232
    .word 612
    .word 985
    .word 4291
    .word 2678
    .word 472
    .word 3205
    .word 3733
    .word 137
    .word 5092
    .word 2742
    .word 819
    .word 646
    .word 3664
    .word 3073
    .word 4632
    .word 4517
    .word 3096
    .word 1931
    .word 2154
    .word 2475
    .word 2520
    .word 3975
    .word 1256
    .word 997
    .word 4679
    .word 3167
    .word 782
    .word 1172
    .word 3448
    .word 3996
    .word 29
    .word 2660
    .word 5057
    .word 5055
    .word 3268
    .word 603
    .word 3630
    .word 3696
    .word 663
    .word 769
    .word 2474
    .word 4210
    .word 59
    .word 458
    .word 1030
    .word 579
    .word 3220
    .word 4218
    .word 2040
    .word 3956
    .word 2247
    .word 315
    .word 5018
    .word 3794
    .word 387
    .word 2179
    .word 1561
    .word 3973
    .word 2730
    .word 431
    .word 157
    .word 3354
    .word 5106
    .word 4917
    .word 5153
    .word 2992
    .word 2013
    .word 3083
    .word 3233
    .word 2916
    .word 1278
    .word 1601
    .word 1818
    .word 1945
    .word 4329
    .word 462
    .word 4604
    .word 742
    .word 1819
    .word 255
    .word 3078
    .word 1349
    .word 4004
    .word 2010
    .word 2986
    .word 1986
    .word 2210
    .word 841
    .word 4802
    .word 1977
    .word 1919
    .word 1766
    .word 1711
    .word 1930
    .word 3844
    .word 3726
    .word 1633
    .word 4575
    .word 3249
    .word 1050
    .word 2948
    .word 4035
    .word 1290
    .word 374
    .word 3481
    .word 2323
    .word 3933
    .word 3159
    .word 3968
    .word 846
    .word 1519
    .word 889
    .word 1187
    .word 3084
    .word 1543
    .word 1665
    .word 2165
    .word 4553
    .word 4260
    .word 3398
    .word 893
    .word 4761
    .word 4096
    .word 1540
    .word 1568
    .word 751
    .word 1892
    .word 850
    .word 5093
    .word 1052
    .word 4735
    .word 1533
    .word 3064
    .word 4341
    .word 3922
    .word 1081
    .word 2228
    .word 1423
    .word 2952
    .word 2442
    .word 1453
    .word 4711
    .word 757
    .word 2086
    .word 3721
    .word 4916
    .word 496
    .word 3981
    .word 1215
    .word 3116
    .word 4300
    .word 2969
    .word 4714
    .word 854
    .word 3500
    .word 196
    .word 4615
    .word 2820
    .word 3341
    .word 1241
    .word 512
    .word 2776
    .word 3421
    .word 383
    .word 3772
    .word 1398
    .word 3866
    .word 2715
    .word 5113
    .word 369
    .word 1597
    .word 3411
    .word 1782
    .word 781
    .word 2862
    .word 4699
    .word 3198
    .word 62
    .word 3727
    .word 5110
    .word 3324
    .word 4136
    .word 1111
    .word 1881
    .word 3982
    .word 3021
    .word 4673
    .word 2973
    .word 3121
    .word 1017
    .word 801
    .word 64
    .word 347
    .word 2608
    .word 5098
    .word 2936
    .word 3647
    .word 1775
    .word 2277
    .word 1285
    .word 3657
    .word 4569
    .word 3055
    .word 4050
    .word 3327
    .word 4233
    .word 2525
    .word 692
    .word 3429
    .word 2364
    .word 4098
    .word 2999
    .word 517
    .word 4660
    .word 4275
    .word 3883
    .word 4987
    .word 4514
    .word 3601
    .word 1036
    .word 773
    .word 881
    .word 4373
    .word 3607
    .word 1230
    .word 1929
    .word 367
    .word 4977
    .word 746
    .word 8
    .word 1981
    .word 326
    .word 1217
    .word 4903
    .word 1798
    .word 4743
    .word 3514
    .word 3390
    .word 1103
    .word 3658
    .word 2879
    .word 1804
    .word 4937
    .word 1175
    .word 3545
    .word 2670
    .word 2423
    .word 2561
    .word 1856
    .word 4896
    .word 3294
    .word 3166
    .word 2472
    .word 3776
    .word 4972
    .word 4029
    .word 1096
    .word 2713
    .word 3326
    .word 756