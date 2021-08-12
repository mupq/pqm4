#include "rader11_macro.S"
.p2align 2,,3
.syntax unified

.text
.global polymul_10x10_132
.type polymul_10x10_132, %function
@ polymul_10x10_132(fpad, gpad), fpad = fpad * gpad, 10x10 polynomial multiplication * 132 times
polymul_10x10_132:
    push {r2-r12, lr}
    vpush {s16}
    adr lr, wpad
    movw.w r12, #4621
    movt.w r12, #29499
    vmov s14, lr
    vmov s15, r12
    add r10, r0, #2640
    vmov s16, r10
polymul_10x10_132_body:
    ldr r8, [r1, #4]
    ldr r9, [r1, #8]
    ldr r10, [r1, #12]
    ldr r11, [r1, #16]
    ldr r7, [r1], #20
    ldm r0, {r2-r6}
    vmov s0, r0
    vmov s1, r1
    smuadx r0, r2, r11
    smladx r0, r3, r10, r0
    smladx r0, r4, r9, r0
    smladx r0, r5, r8, r0
    smladx r0, r6, r7, r0
    smuadx r1, r2, r10
    smladx r1, r3, r9, r1
    smladx r1, r4, r8, r1
    smladx r1, r5, r7, r1
    smuadx r12, r2, r9
    smladx r12, r3, r8, r12
    smladx r12, r4, r7, r12
    smuadx lr, r2, r8
    smladx lr, r3, r7, lr
    vmov s2, r0 @ c9
    vmov s3, r1 @ c7
    vmov s4, r12 @ c5
    vmov s5, lr @ c3
    smuadx r0, r2, r7
    smuadx r1, r3, r11
    smladx r1, r4, r10, r1
    smladx r1, r5, r9, r1
    smladx r1, r6, r8, r1
    smuadx r12, r4, r11
    smladx r12, r5, r10, r12
    smladx r12, r6, r9, r12
    smuadx lr, r5, r11
    smladx lr, r6, r10, lr
    vmov s6, r0 @ c1
    vmov s7, r1 @ c11
    vmov s8, r12 @ c13
    vmov s9, lr @ c15
    smuadx r0, r6, r11
    pkhbt r12, r7, r11 @ b09
    pkhbt r11, r11, r10 @ b87
    pkhbt r10, r10, r9 @ b65
    pkhbt r9, r9, r8 @ b43
    pkhbt r8, r8, r7 @ b21
    smulbb r1, r6, r12
    smlad r1, r2, r11, r1
    smlad r1, r3, r10, r1
    smlad r1, r4, r9, r1
    smlad r1, r5, r8, r1
    smulbb r7, r5, r12
    smlad r7, r2, r10, r7
    smlad r7, r3, r9, r7
    smlad r7, r4, r8, r7
    smulbb lr, r4, r12
    smlad lr, r2, r9, lr
    smlad lr, r3, r8, lr
    vmov s10, r0 @ c17
    vmov s11, r1 @ c8
    vmov s12, r7 @ c6
    vmov s13, lr @ c4
    smulbb r0, r3, r12
    smlad r0, r2, r8, r0
    smultt r1, r2, r12
    smlad r1, r3, r11, r1
    smlad r1, r4, r10, r1
    smlad r1, r5, r9, r1
    smlad r1, r6, r8, r1
    smultt r7, r3, r12
    smlad r7, r4, r11, r7
    smlad r7, r5, r10, r7
    smlad r7, r6, r9, r7
    smultt lr, r4, r12
    smlad lr, r5, r11, lr
    smlad lr, r6, r10, lr
    smultt r3, r5, r12
    smlad r3, r6, r11, r3 @ c16
    smultt r4, r6, r12 @ c18
    smulbb r5, r2, r12 @ c0
@ r0 = c2, r1 = c10, r3 = c16, r4 = c18, r5 = c0, r7 = c12, lr = c14
    vmov r2, s14
    ldr r11, [r2], #4 @ wi
    vmov s14, r2
    vmov r12, s15 @ mr q, qinv
    vmov r2, s6 @ c1
    vmov r6, s7 @ c11
    vmov r8, s5 @ c3
    vmov r9, s8 @ c13
    smulbt r10, r1, r12
    smlabb r1, r10, r12, r1
    smlabt r1, r11, r1, r5
    smulbt r10, r1, r12
    smlabb r1, r10, r12, r1 @ d0/R
    smulbt r10, r6, r12
    smlabb r6, r10, r12, r6
    smlabt r6, r11, r6, r2
    smulbt r10, r6, r12
    smlabb r6, r10, r12, r6 @ d1/R
    pkhtb r1, r6, r1, asr #16
    smulbt r10, r7, r12
    smlabb r7, r10, r12, r7
    smlabt r7, r11, r7, r0
    smulbt r10, r7, r12
    smlabb r7, r10, r12, r7 @ d2/R
    smulbt r10, r9, r12
    smlabb r9, r10, r12, r9
    smlabt r9, r11, r9, r8
    smulbt r10, r9, r12
    smlabb r9, r10, r12, r9 @ d3/R
    pkhtb r2, r9, r7, asr #16
@ r3 = c16, r4 = c18, lr = c14
    vmov r0, s13 @ c4
    vmov r5, s4 @ c5
    vmov r6, s9 @ c15
    vmov r7, s12 @ c6
    vmov r8, s3 @ c7
    vmov r9, s10 @ c17
    smulbt r10, lr, r12
    smlabb lr, r10, r12, lr
    smlabt lr, r11, lr, r0
    smulbt r10, lr, r12
    smlabb lr, r10, r12, lr @ d4/R
    smulbt r10, r6, r12
    smlabb r6, r10, r12, r6
    smlabt r6, r11, r6, r5
    smulbt r10, r6, r12
    smlabb r6, r10, r12, r6 @ d5/R
    pkhtb lr, r6, lr, asr #16
    smulbt r10, r3, r12
    smlabb r3, r10, r12, r3
    smlabt r3, r11, r3, r7
    smulbt r10, r3, r12
    smlabb r3, r10, r12, r3 @ d6/R
    smulbt r10, r9, r12
    smlabb r9, r10, r12, r9
    smlabt r9, r11, r9, r8
    smulbt r10, r9, r12
    smlabb r9, r10, r12, r9 @ d7/R
    pkhtb r3, r9, r3, asr #16
    vmov r0, s0
    vmov r5, s11 @ c8
    vmov r6, s2 @ c9
    smulbt r10, r4, r12
    smlabb r4, r10, r12, r4
    smlabt r4, r11, r4, r5
    smulbt r10, r4, r12
    smlabb r4, r10, r12, r4 @ d8/R
    smulbt r10, r6, r12
    smlabb r6, r10, r12, r6 @ d9/R
    pkhtb r4, r6, r4, asr #16
    str.w r2, [r0, #4]
    str.w lr, [r0, #8]
    str.w r3, [r0, #12]
    str.w r4, [r0, #16]
    str.w r1, [r0], #20
    vmov r1, s1
    vmov r2, s16
    cmp.w r0, r2
    bne.w polymul_10x10_132_body
    vpop {s16}
    pop {r2-r12, pc}

wpad:
    .word 842   @ x^10 - w^0
    .word -842  @ x^10 - w^330
    .word 1404  @ x^10 - w^165
    .word -1404 @ x^10 - w^495
    .word -200  @ x^10 - w^55
    .word 200   @ x^10 - w^385
    .word -1947 @ x^10 - w^220
    .word 1947  @ x^10 - w^550
    .word -1105 @ x^10 - w^110
    .word 1105  @ x^10 - w^440
    .word 1604  @ x^10 - w^275
    .word -1604 @ x^10 - w^605
    .word 1964  @ x^10 - w^5
    .word -1964 @ x^10 - w^335
    .word 1837  @ x^10 - w^170
    .word -1837 @ x^10 - w^500
    .word 1147  @ x^10 - w^60
    .word -1147 @ x^10 - w^390
    .word 1254  @ x^10 - w^225
    .word -1254 @ x^10 - w^555
    .word -1403 @ x^10 - w^115
    .word 1403  @ x^10 - w^445
    .word 690   @ x^10 - w^280
    .word -690  @ x^10 - w^610
    .word 1398  @ x^10 - w^10
    .word -1398 @ x^10 - w^340
    .word 70    @ x^10 - w^175
    .word -70   @ x^10 - w^505
    .word -1287 @ x^10 - w^65
    .word 1287  @ x^10 - w^395
    .word 1542  @ x^10 - w^230
    .word -1542 @ x^10 - w^560
    .word -1681 @ x^10 - w^120
    .word 1681  @ x^10 - w^450
    .word 1357  @ x^10 - w^285
    .word -1357 @ x^10 - w^615
    .word 901   @ x^10 - w^15
    .word -901  @ x^10 - w^345
    .word 1678  @ x^10 - w^180
    .word -1678 @ x^10 - w^510
    .word -2069 @ x^10 - w^70
    .word 2069  @ x^10 - w^400
    .word 260   @ x^10 - w^235
    .word -260  @ x^10 - w^565
    .word 1161  @ x^10 - w^125
    .word -1161 @ x^10 - w^455
    .word -874  @ x^10 - w^290
    .word 874   @ x^10 - w^620
    .word 1926  @ x^10 - w^20
    .word -1926 @ x^10 - w^350
    .word -1629 @ x^10 - w^185
    .word 1629  @ x^10 - w^515
    .word 706   @ x^10 - w^75
    .word -706  @ x^10 - w^405
    .word -1029 @ x^10 - w^240
    .word 1029  @ x^10 - w^570
    .word 897   @ x^10 - w^130
    .word -897  @ x^10 - w^460
    .word 2286  @ x^10 - w^295
    .word -2286 @ x^10 - w^625
    .word 91    @ x^10 - w^25
    .word -91   @ x^10 - w^355
    .word 31    @ x^10 - w^190
    .word -31   @ x^10 - w^520
    .word -768  @ x^10 - w^80
    .word 768   @ x^10 - w^410
    .word 1211  @ x^10 - w^245
    .word -1211 @ x^10 - w^575
    .word 1302  @ x^10 - w^135
    .word -1302 @ x^10 - w^465
    .word 799   @ x^10 - w^300
    .word -799  @ x^10 - w^630
    .word 333   @ x^10 - w^30
    .word -333  @ x^10 - w^360
    .word 215   @ x^10 - w^195
    .word -215  @ x^10 - w^525
    .word 338   @ x^10 - w^85
    .word -338  @ x^10 - w^415
    .word -545  @ x^10 - w^250
    .word 545   @ x^10 - w^580
    .word -212  @ x^10 - w^140
    .word 212   @ x^10 - w^470
    .word -123  @ x^10 - w^305
    .word 123   @ x^10 - w^635
    .word 1117  @ x^10 - w^35
    .word -1117 @ x^10 - w^365
    .word 1193  @ x^10 - w^200
    .word -1193 @ x^10 - w^530
    .word 1897  @ x^10 - w^90
    .word -1897 @ x^10 - w^420
    .word -1842 @ x^10 - w^255
    .word 1842  @ x^10 - w^585
    .word -725  @ x^10 - w^145
    .word 725   @ x^10 - w^475
    .word -704  @ x^10 - w^310
    .word 704   @ x^10 - w^640
    .word -1346 @ x^10 - w^40
    .word 1346  @ x^10 - w^370
    .word 1268  @ x^10 - w^205
    .word -1268 @ x^10 - w^535
    .word 188   @ x^10 - w^95
    .word -188  @ x^10 - w^425
    .word -850  @ x^10 - w^260
    .word 850   @ x^10 - w^590
    .word -2196 @ x^10 - w^150
    .word 2196  @ x^10 - w^480
    .word 1080  @ x^10 - w^315
    .word -1080 @ x^10 - w^645
    .word -2031 @ x^10 - w^45
    .word 2031  @ x^10 - w^375
    .word -895  @ x^10 - w^210
    .word 895   @ x^10 - w^540
    .word 1602  @ x^10 - w^100
    .word -1602 @ x^10 - w^430
    .word 1409  @ x^10 - w^265
    .word -1409 @ x^10 - w^595
    .word -622  @ x^10 - w^155
    .word 622   @ x^10 - w^485
    .word 2124  @ x^10 - w^320
    .word -2124 @ x^10 - w^650
    .word 2013  @ x^10 - w^50
    .word -2013 @ x^10 - w^380
    .word -990  @ x^10 - w^215
    .word 990   @ x^10 - w^545
    .word 378   @ x^10 - w^105
    .word -378  @ x^10 - w^435
    .word -2004 @ x^10 - w^270
    .word 2004  @ x^10 - w^600
    .word 9     @ x^10 - w^160
    .word -9    @ x^10 - w^490
    .word -1368 @ x^10 - w^325
    .word 1368  @ x^10 - w^655