.p2align 2,,3
.syntax unified

.text
.global polymul_6x6_153_mr
.type polymul_6x6_153_mr, %function
@ polymul_6x6_153_mr(fpad, gpad), fpad = fpad * gpad, 10x10 polynomial multiplication * 153 times
polymul_6x6_153_mr:
    push {r4-r11, lr}
    adr lr, wpad
    movw.w r12, #4591
    movt.w r12, #49905
    add r11, r0, #1836
polymul_6x6_153_mr_body:
    ldr.w r10, [lr], #4
    ldr.w r4, [r1, #4]
    ldr.w r5, [r1, #8]
    ldr.w r3, [r1], #12
    ldr.w r7, [r2, #4]
    ldr.w r8, [r2, #8]
    ldr.w r6, [r2], #12
    vmov s1, s2, r1, r2
    smuadx r1, r5, r8 @ c9
    smulbt r9, r1, r12
    smlabb r1, r9, r12, r1
    smuadx r2, r3, r7
    smladx r2, r4, r6, r2 @ c3
    smlabt r1, r10, r1, r2
    smulbt r9, r1, r12
    smlabb r1, r9, r12, r1 @ C3
    smuadx r2, r4, r8
    smladx r2, r5, r7, r2
    smulbt r9, r2, r12
    smlabb r2, r9, r12, r2
    smuadx r9, r3, r6
    smlabt r2, r10, r2, r9
    smulbt r9, r2, r12
    smlabb r2, r9, r12, r2 @ C1
    pkhtb r1, r1, r2, asr #16 @ C1C3
    smuadx r2, r3, r8
    smladx r2, r4, r7, r2
    smladx r2, r5, r6, r2 @ c5
    smulbt r9, r2, r12
    smlabb r2, r9, r12, r2 @ C5
    pkhbt r9, r6, r8 @ b0b5
    pkhtb r6, r6, r7 @ b2b1
    pkhtb r7, r7, r8 @ b4b3
    vmov s3, r1 @ C1C3
    smultt r1, r5, r9 @ c10
    smulbt r8, r1, r12
    smlabb r1, r8, r12, r1
    smuad r8, r3, r7
    smlad r8, r4, r6, r8
    smlabb r8, r5, r9, r8
    smlabt r1, r10, r1, r8
    smulbt r8, r1, r12
    smlabb r1, r8, r12, r1 @ C4
    pkhtb r1, r2, r1, asr #16 @ C4C5
    str.w r1, [r0, #8]
    smuad r1, r4, r7
    smlad r1, r5, r6, r1
    smlatt r1, r3, r9, r1
    smulbt r8, r1, r12
    smlabb r1, r8, r12, r1
    smulbb r2, r3, r9
    smlabt r1, r10, r1, r2
    smulbt r8, r1, r12
    smlabb r1, r8, r12, r1 @ C0
    smuad r2, r5, r7
    smlatt r2, r4, r9, r2
    smulbt r8, r2, r12
    smlabb r2, r8, r12, r2
    smuad r8, r3, r6
    smlabb r8, r4, r9, r8
    smlabt r2, r10, r2, r8
    smulbt r8, r2, r12
    smlabb r2, r8, r12, r2 @ C2
    pkhtb r3, r2, r1, asr #16 @ C0C2
    vmov r4, s3 @ C1C3
    vmov r1, r2, s1, s2
    pkhbt r5, r3, r4, lsl #16 @ C0C1
    pkhtb r6, r4, r3, asr #16 @ C2C3
    str.w r6, [r0, #4]
    str.w r5, [r0], #12
    cmp.w r0, r11
    bne.w polymul_6x6_153_mr_body
    pop {r4-r11, pc}

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