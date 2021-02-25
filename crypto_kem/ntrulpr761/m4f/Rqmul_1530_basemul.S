.p2align 2,,3
.syntax unified

.text
.global polymul_10x10_153_mr
.type polymul_10x10_153_mr, %function
@ polymul_10x10_153_mr(fpad, gpad), fpad = fpad * gpad, 10x10 polynomial multiplication * 153 times
polymul_10x10_153_mr:
    push {r2-r12, lr}
    vpush {s16}
    adr lr, wpad
    movw.w r12, #4591
    movt.w r12, #49905
    vmov s14, lr
    vmov s15, r12
    add r10, r0, #3060
    vmov s16, r10
polymul_10x10_153_mr_body:
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
    bne.w polymul_10x10_153_mr_body
    vpop {s16}
    pop {r2-r12, pc}

wpad:
    .word 1262  @ x^10 - w^0
    .word -2247 @ x^10 - w^510
    .word 985   @ x^10 - w^1020
    .word 1985  @ x^10 - w^170
    .word -2141 @ x^10 - w^680
    .word 156   @ x^10 - w^1190
    .word 1969  @ x^10 - w^340
    .word -1756 @ x^10 - w^850
    .word -213  @ x^10 - w^1360
    .word -1235 @ x^10 - w^10
    .word -1559 @ x^10 - w^520
    .word -1797 @ x^10 - w^1030
    .word -1757 @ x^10 - w^180
    .word 98    @ x^10 - w^690
    .word 1659  @ x^10 - w^1200
    .word -1574 @ x^10 - w^350
    .word -1723 @ x^10 - w^860
    .word -1294 @ x^10 - w^1370
    .word 1787  @ x^10 - w^20
    .word -246  @ x^10 - w^530
    .word -1541 @ x^10 - w^1040
    .word 297   @ x^10 - w^190
    .word -547  @ x^10 - w^700
    .word 250   @ x^10 - w^1210
    .word -2083 @ x^10 - w^360
    .word 482   @ x^10 - w^870
    .word 1601  @ x^10 - w^1380
    .word -1214 @ x^10 - w^30
    .word 1092  @ x^10 - w^540
    .word 122   @ x^10 - w^1050
    .word 1481  @ x^10 - w^200
    .word -1491 @ x^10 - w^710
    .word 10    @ x^10 - w^1220
    .word -2287 @ x^10 - w^370
    .word -348  @ x^10 - w^880
    .word -1956 @ x^10 - w^1390
    .word 686   @ x^10 - w^40
    .word -2160 @ x^10 - w^550
    .word 1474  @ x^10 - w^1060
    .word 1712  @ x^10 - w^210
    .word 124   @ x^10 - w^720
    .word -1836 @ x^10 - w^1230
    .word 1194  @ x^10 - w^380
    .word 537   @ x^10 - w^890
    .word -1731 @ x^10 - w^1400
    .word 762   @ x^10 - w^50
    .word 1750  @ x^10 - w^560
    .word 2079  @ x^10 - w^1070
    .word -1217 @ x^10 - w^220
    .word 2025  @ x^10 - w^730
    .word -808  @ x^10 - w^1240
    .word -1605 @ x^10 - w^390
    .word -1264 @ x^10 - w^900
    .word -1722 @ x^10 - w^1410
    .word -1255 @ x^10 - w^60
    .word 70    @ x^10 - w^570
    .word 1185  @ x^10 - w^1080
    .word 2155  @ x^10 - w^230
    .word 81    @ x^10 - w^740
    .word -2236 @ x^10 - w^1250
    .word 854   @ x^10 - w^400
    .word 684   @ x^10 - w^910
    .word -1538 @ x^10 - w^1420
    .word 868   @ x^10 - w^70
    .word 921   @ x^10 - w^580
    .word -1789 @ x^10 - w^1090
    .word -832  @ x^10 - w^240
    .word 1656  @ x^10 - w^750
    .word -824  @ x^10 - w^1260
    .word 1136  @ x^10 - w^410
    .word 211   @ x^10 - w^920
    .word -1347 @ x^10 - w^1430
    .word 402   @ x^10 - w^80
    .word -1065 @ x^10 - w^590
    .word 663   @ x^10 - w^1100
    .word 334   @ x^10 - w^250
    .word 1719  @ x^10 - w^760
    .word -2053 @ x^10 - w^1270
    .word 780   @ x^10 - w^420
    .word 743   @ x^10 - w^930
    .word -1523 @ x^10 - w^1440
    .word 567   @ x^10 - w^90
    .word -1879 @ x^10 - w^600
    .word 1312  @ x^10 - w^1110
    .word 197   @ x^10 - w^260
    .word -1584 @ x^10 - w^770
    .word 1387  @ x^10 - w^1280
    .word -887  @ x^10 - w^430
    .word 397   @ x^10 - w^940
    .word 490   @ x^10 - w^1450
    .word -2181 @ x^10 - w^100
    .word -1177 @ x^10 - w^610
    .word -1233 @ x^10 - w^1120
    .word 1477  @ x^10 - w^270
    .word -247  @ x^10 - w^780
    .word -1230 @ x^10 - w^1290
    .word 1250  @ x^10 - w^440
    .word 1485  @ x^10 - w^950
    .word 1856  @ x^10 - w^1460
    .word -1740 @ x^10 - w^110
    .word -598  @ x^10 - w^620
    .word -2253 @ x^10 - w^1130
    .word 610   @ x^10 - w^280
    .word -1479 @ x^10 - w^790
    .word 869   @ x^10 - w^1300
    .word 50    @ x^10 - w^450
    .word -1777 @ x^10 - w^960
    .word 1727  @ x^10 - w^1470
    .word -1906 @ x^10 - w^120
    .word 527   @ x^10 - w^630
    .word 1379  @ x^10 - w^1140
    .word -1812 @ x^10 - w^290
    .word -1161 @ x^10 - w^800
    .word -1618 @ x^10 - w^1310
    .word 2     @ x^10 - w^460
    .word -622  @ x^10 - w^970
    .word 620   @ x^10 - w^1480
    .word -1729 @ x^10 - w^130
    .word 572   @ x^10 - w^640
    .word 1157  @ x^10 - w^1150
    .word 1213  @ x^10 - w^300
    .word -781  @ x^10 - w^810
    .word -432  @ x^10 - w^1320
    .word 551   @ x^10 - w^470
    .word -1494 @ x^10 - w^980
    .word 943   @ x^10 - w^1490
    .word -1171 @ x^10 - w^140
    .word 1492  @ x^10 - w^650
    .word -321  @ x^10 - w^1160
    .word 1334  @ x^10 - w^310
    .word -1684 @ x^10 - w^820
    .word 350   @ x^10 - w^1330
    .word -1998 @ x^10 - w^480
    .word 1593  @ x^10 - w^990
    .word 405   @ x^10 - w^1500
    .word 1055  @ x^10 - w^150
    .word -2144 @ x^10 - w^660
    .word 1089  @ x^10 - w^1170
    .word 237   @ x^10 - w^320
    .word -251  @ x^10 - w^830
    .word 14    @ x^10 - w^1340
    .word 471   @ x^10 - w^490
    .word 431   @ x^10 - w^1000
    .word -902  @ x^10 - w^1510
    .word -876  @ x^10 - w^160
    .word 1567  @ x^10 - w^670
    .word -691  @ x^10 - w^1180
    .word -1276 @ x^10 - w^330
    .word 2010  @ x^10 - w^840
    .word -734  @ x^10 - w^1350
    .word -1083 @ x^10 - w^500
    .word 1670  @ x^10 - w^1010
    .word -587  @ x^10 - w^1520