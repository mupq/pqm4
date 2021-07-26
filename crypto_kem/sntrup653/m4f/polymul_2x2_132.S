.p2align 2,,3
.syntax unified

.text
.global polymul_2x2_132
.type polymul_2x2_132, %function
@ polymul_2x2_132(fpad, gpad), fpad = fpad * gpad, 10x10 polynomial multiplication * 132 times
polymul_2x2_132:
    push {r4-r11, lr}
    adr lr, wpad
    movw.w r12, #4621
    movt.w r12, #29499
    add r11, r0, #528
polymul_2x2_132_body:
    ldr.w r10, [lr, #4]
    ldr.w r9, [lr], #8
    ldr.w r4, [r1, #4]
    ldr.w r3, [r1], #8
    ldr.w r6, [r2, #4]
    ldr.w r5, [r2], #8
    smultt r7, r3, r5
    smulbt r8, r7, r12
    smlabb r7, r8, r12, r7
    smulbb r8, r3, r5
    smlabt r7, r9, r7, r8
    smulbt r8, r7, r12
    smlabb r7, r8, r12, r7
    smuadx r8, r3, r5
    smulbt r3, r8, r12
    smlabb r8, r3, r12, r8
    pkhtb r3, r8, r7, asr #16
    smultt r7, r4, r6
    smulbt r8, r7, r12
    smlabb r7, r8, r12, r7
    smulbb r8, r4, r6
    smlabt r7, r10, r7, r8
    smulbt r8, r7, r12
    smlabb r7, r8, r12, r7
    smuadx r8, r4, r6
    smulbt r4, r8, r12
    smlabb r8, r4, r12, r8
    pkhtb r4, r8, r7, asr #16
    str.w r4, [r0, #4]
    str.w r3, [r0], #8
    ldr.w r10, [lr, #4]
    ldr.w r9, [lr], #8
    ldr.w r4, [r1, #4]
    ldr.w r3, [r1], #8
    ldr.w r6, [r2, #4]
    ldr.w r5, [r2], #8
    smultt r7, r3, r5
    smulbt r8, r7, r12
    smlabb r7, r8, r12, r7
    smulbb r8, r3, r5
    smlabt r7, r9, r7, r8
    smulbt r8, r7, r12
    smlabb r7, r8, r12, r7
    smuadx r8, r3, r5
    smulbt r3, r8, r12
    smlabb r8, r3, r12, r8
    pkhtb r3, r8, r7, asr #16
    smultt r7, r4, r6
    smulbt r8, r7, r12
    smlabb r7, r8, r12, r7
    smulbb r8, r4, r6
    smlabt r7, r10, r7, r8
    smulbt r8, r7, r12
    smlabb r7, r8, r12, r7
    smuadx r8, r4, r6
    smulbt r4, r8, r12
    smlabb r8, r4, r12, r8
    pkhtb r4, r8, r7, asr #16
    str.w r4, [r0, #4]
    str.w r3, [r0], #8
    cmp.w r0, r11
    bne.w polymul_2x2_132_body
    pop {r4-r11, pc}

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