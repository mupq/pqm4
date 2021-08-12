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
    .word 1262      @ x^10 - w^0
    .word 2450      @ x^10 - w^17
    .word 4378      @ x^10 - w^34
    .word 2344      @ x^10 - w^51
    .word 156       @ x^10 - w^68
    .word 1969      @ x^10 - w^85
    .word 985       @ x^10 - w^102
    .word 1985      @ x^10 - w^119
    .word 2835      @ x^10 - w^136
    .word 124       @ x^10 - w^9
    .word 2860      @ x^10 - w^26
    .word 2431      @ x^10 - w^43
    .word 2755      @ x^10 - w^60
    .word 1194      @ x^10 - w^77
    .word 1474      @ x^10 - w^94
    .word 1712      @ x^10 - w^111
    .word 537       @ x^10 - w^128
    .word 686       @ x^10 - w^145
    .word 3068      @ x^10 - w^18
    .word 3526      @ x^10 - w^35
    .word 2538      @ x^10 - w^52
    .word 780       @ x^10 - w^69
    .word 663       @ x^10 - w^86
    .word 334       @ x^10 - w^103
    .word 743       @ x^10 - w^120
    .word 402       @ x^10 - w^137
    .word 1719      @ x^10 - w^1
    .word 527       @ x^10 - w^27
    .word 2973      @ x^10 - w^44
    .word 2         @ x^10 - w^61
    .word 1379      @ x^10 - w^78
    .word 2779      @ x^10 - w^95
    .word 3969      @ x^10 - w^112
    .word 2685      @ x^10 - w^129
    .word 3430      @ x^10 - w^146
    .word 620       @ x^10 - w^10
    .word 3857      @ x^10 - w^36
    .word 3508      @ x^10 - w^53
    .word 3900      @ x^10 - w^70
    .word 3315      @ x^10 - w^87
    .word 1670      @ x^10 - w^104
    .word 3715      @ x^10 - w^121
    .word 2010      @ x^10 - w^138
    .word 4004      @ x^10 - w^2
    .word 1567      @ x^10 - w^19
    .word 1092      @ x^10 - w^45
    .word 10        @ x^10 - w^62
    .word 2304      @ x^10 - w^79
    .word 122       @ x^10 - w^96
    .word 1481      @ x^10 - w^113
    .word 4243      @ x^10 - w^130
    .word 3377      @ x^10 - w^147
    .word 3100      @ x^10 - w^11
    .word 2635      @ x^10 - w^28
    .word 3767      @ x^10 - w^54
    .word 1136      @ x^10 - w^71
    .word 2802      @ x^10 - w^88
    .word 3759      @ x^10 - w^105
    .word 211       @ x^10 - w^122
    .word 868       @ x^10 - w^139
    .word 1656      @ x^10 - w^3
    .word 3244      @ x^10 - w^20
    .word 921       @ x^10 - w^37
    .word 50        @ x^10 - w^63
    .word 2338      @ x^10 - w^80
    .word 610       @ x^10 - w^97
    .word 2814      @ x^10 - w^114
    .word 2851      @ x^10 - w^131
    .word 3112      @ x^10 - w^148
    .word 1727      @ x^10 - w^12
    .word 3993      @ x^10 - w^29
    .word 869       @ x^10 - w^46
    .word 1089      @ x^10 - w^72
    .word 237       @ x^10 - w^89
    .word 431       @ x^10 - w^106
    .word 1055      @ x^10 - w^123
    .word 4340      @ x^10 - w^140
    .word 3689      @ x^10 - w^4
    .word 2447      @ x^10 - w^21
    .word 14        @ x^10 - w^38
    .word 471       @ x^10 - w^55
    .word 2508      @ x^10 - w^81
    .word 3050      @ x^10 - w^98
    .word 297       @ x^10 - w^115
    .word 482       @ x^10 - w^132
    .word 1787      @ x^10 - w^149
    .word 4044      @ x^10 - w^13
    .word 1601      @ x^10 - w^30
    .word 4345      @ x^10 - w^47
    .word 250       @ x^10 - w^64
    .word 1185      @ x^10 - w^90
    .word 2155      @ x^10 - w^107
    .word 684       @ x^10 - w^124
    .word 3336      @ x^10 - w^141
    .word 81        @ x^10 - w^5
    .word 3053      @ x^10 - w^22
    .word 70        @ x^10 - w^39
    .word 2355      @ x^10 - w^56
    .word 854       @ x^10 - w^73
    .word 1477      @ x^10 - w^99
    .word 1485      @ x^10 - w^116
    .word 2410      @ x^10 - w^133
    .word 4344      @ x^10 - w^150
    .word 1856      @ x^10 - w^14
    .word 3414      @ x^10 - w^31
    .word 3361      @ x^10 - w^48
    .word 1250      @ x^10 - w^65
    .word 3358      @ x^10 - w^82
    .word 1593      @ x^10 - w^108
    .word 3420      @ x^10 - w^125
    .word 2907      @ x^10 - w^142
    .word 405       @ x^10 - w^6
    .word 1492      @ x^10 - w^23
    .word 350       @ x^10 - w^40
    .word 2593      @ x^10 - w^57
    .word 4270      @ x^10 - w^74
    .word 1334      @ x^10 - w^91
    .word 2834      @ x^10 - w^117
    .word 2868      @ x^10 - w^134
    .word 3356      @ x^10 - w^151
    .word 98        @ x^10 - w^15
    .word 3297      @ x^10 - w^32
    .word 3032      @ x^10 - w^49
    .word 1659      @ x^10 - w^66
    .word 3017      @ x^10 - w^83
    .word 2794      @ x^10 - w^100
    .word 3327      @ x^10 - w^126
    .word 762       @ x^10 - w^143
    .word 2025      @ x^10 - w^7
    .word 2869      @ x^10 - w^24
    .word 1750      @ x^10 - w^41
    .word 3783      @ x^10 - w^58
    .word 2986      @ x^10 - w^75
    .word 2079      @ x^10 - w^92
    .word 3374      @ x^10 - w^109
    .word 567       @ x^10 - w^135
    .word 3007      @ x^10 - w^152
    .word 490       @ x^10 - w^16
    .word 2712      @ x^10 - w^33
    .word 1387      @ x^10 - w^50
    .word 3704      @ x^10 - w^67
    .word 1312      @ x^10 - w^84
    .word 197       @ x^10 - w^101
    .word 397       @ x^10 - w^118
    .word 3810      @ x^10 - w^144
    .word 943       @ x^10 - w^8
    .word 572       @ x^10 - w^25
    .word 4159      @ x^10 - w^42
    .word 551       @ x^10 - w^59
    .word 1157      @ x^10 - w^76
    .word 1213      @ x^10 - w^93
    .word 3097      @ x^10 - w^110
    .word 2862      @ x^10 - w^127