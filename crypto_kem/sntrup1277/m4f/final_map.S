
#include "macros.S"

.macro ldr_and_add a_0, a_1, a_1277, a_1278, src_0, src_1, src_1277, src_1278, mem_0, mem_1, mem_1277, mem_1278
    ldr.w \a_0, [\src_0, \mem_0];
    ldr.w \a_1, [\src_1, \mem_1];
    ldr.w \a_1277, [\src_1277, \mem_1277];
    add \a_0, \a_1278
    add \a_0, \a_1277
    ldr.w \a_1278, [\src_1278, \mem_1278];
    add \a_1, \a_1277
    add \a_1, \a_1278
.endm

.macro reduce_and_str des, a_0, a_1, twiddle, Qprime, Q, Qhalf, O_Mbar, O_M, tmp0, tmp1, tmp2
    montgomery_mul \a_0, \twiddle, \tmp0, \a_0, \Qprime, \Q, \tmp1
    montgomery_mul \a_1, \twiddle, \tmp0, \a_1, \Qprime, \Q, \tmp1
    central_reduce \a_0, \Qhalf, \Q
    central_reduce \a_1, \Qhalf, \Q
    vmov.w \tmp0, \tmp1, \O_Mbar, \O_M
    barrett \a_0, \tmp0, \tmp1, \tmp2
    barrett \a_1, \tmp0, \tmp1, \tmp2
    pkhbt \a_0, \a_0, \a_1, lsl #16
    str.w \a_0, [\des], #4
.endm

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_final_map
.type __asm_final_map, %function
__asm_final_map:
    push {r4-r12, lr}

    ldr.w r11, [sp, #40]

    // invN_R2modM
    movw r12, #38372
    movt r12, #49

    // O_Mbar
    movw r14, #20828
    movt r14, #8

    // O_M
    movw r7, #7879

    vmov.w s14, s15, r14, r7

    add.w r9, r0, #4096
    add.w r10, r9, #4096

    movw r8, #0

#ifdef LOOP
    add.w r14, r0, #5120
    sub.w r14, r14, #120
    vmov.w s0, r14
    _loop1:
#else
.rept 25
#endif

// ================================

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #0, #24, #972, #996
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #48, #72, #1020, #1024
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #96, #100, #1048, #1072
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #124, #148, #1096, #1120
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #172, #196, #1124, #1148
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

// ================================

    add.w r0, r0, #200
    add.w r9, r9, #200

#ifdef LOOP
    vmov.w r14, s0
    cmp.w r0, r14
    bne.w _loop1
#else
.endr
#endif

    sub.w r0, r0, #5120
    sub.w r9, r9, #5120
    add.w r0, r0, #120
    add.w r9, r9, #120

    ldr_and_add r4, r5, r7, r8, r9, r9, r10, r10, #904, #928, #1876, #1900
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r10, r10, #952, #976, #1924, #1928
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r10, r10, #1000, #1004, #1952, #1976
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r10, r10, #1028, #1052, #2000, #2024
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r10, r0, #1076, #1100, #2028, #4
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

#ifdef LOOP
    add.w r14, r0, #5120
    sub.w r14, r14, #120
    vmov.w s0, r14
    _loop2:
#else
.rept 25
#endif

// ================================

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1104, #1128, #28, #52
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1152, #1176, #76, #80
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1200, #1204, #104, #128
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1228, #1252, #152, #176
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1276, #1300, #180, #204
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

// ================================

    add.w r0, r0, #200
    add.w r9, r9, #200

#ifdef LOOP
    vmov.w r14, s0
    cmp.w r0, r14
    bne.w _loop2
#else
.endr
#endif

    sub.w r0, r0, #5120
    sub.w r9, r9, #5120
    add.w r0, r0, #120
    add.w r9, r9, #120

    ldr_and_add r4, r5, r7, r8, r10, r10, r9, r9, #2008, #2032, #932, #956
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #8, #32, #980, #984
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #56, #60, #1008, #1032
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #84, #108, #1056, #1080
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #132, #156, #1084, #1108
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

#ifdef LOOP
    add.w r14, r0, #5120
    sub.w r14, r14, #120
    vmov.w s0, r14
    _loop3:
#else
.rept 25
#endif

// ================================

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #160, #184, #1132, #1156
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #208, #232, #1180, #1184
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #256, #260, #1208, #1232
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #284, #308, #1256, #1280
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #332, #356, #1284, #1308
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

// ================================

    add.w r0, r0, #200
    add.w r9, r9, #200

#ifdef LOOP
    vmov.w r14, s0
    cmp.w r0, r14
    bne.w _loop3
#else
.endr
#endif

    sub.w r0, r0, #5120
    sub.w r9, r9, #5120
    add.w r0, r0, #120
    add.w r9, r9, #120

    ldr_and_add r4, r5, r7, r8, r9, r9, r10, r0, #1064, #1088, #2036, #12
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1112, #1136, #36, #40
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1160, #1164, #64, #88
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1188, #1212, #112, #136
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1236, #1260, #140, #164
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

#ifdef LOOP
    add.w r14, r0, #4800
    vmov.w s0, r14
    _loop4:
#else
.rept 24
#endif

// ================================

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1264, #1288, #188, #212
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1312, #1336, #236, #240
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1360, #1364, #264, #288
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1388, #1412, #312, #336
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r9, r9, r0, r0, #1436, #1460, #340, #364
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

// ================================

    add.w r0, r0, #200
    add.w r9, r9, #200

#ifdef LOOP
    vmov.w r14, s0
    cmp.w r0, r14
    bne.w _loop4
#else
.endr
#endif

    sub.w r0, r0, #4800
    sub.w r9, r9, #4800

    ldr_and_add r4, r5, r7, r8, r10, r10, r9, r9, #1968, #1992, #892, #916
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r10, r10, r9, r9, #2016, #2040, #940, #944
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #16, #20, #968, #992
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #44, #68, #1016, #1040
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #92, #116, #1044, #1068
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

#ifdef LOOP
    add.w r14, r0, #4800
    vmov.w s0, r14
    _loop5:
#else
.rept 24
#endif

// ================================

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #120, #144, #1092, #1116
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #168, #192, #1140, #1144
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #216, #220, #1168, #1192
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #244, #268, #1216, #1240
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #292, #316, #1244, #1268
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

// ================================

    add.w r0, r0, #200
    add.w r9, r9, #200

#ifdef LOOP
    vmov.w r14, s0
    cmp.w r0, r14
    bne.w _loop5
#else
.endr
#endif

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #120, #144, #1092, #1116
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #168, #192, #1140, #1144
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr_and_add r4, r5, r7, r8, r0, r0, r9, r9, #216, #220, #1168, #1192
    reduce_and_str r11, r4, r5, r12, r2, r3, r1, s14, s15, r14, r7, r6

    ldr.w r4, [r0, #244]
    ldr.w r7, [r9, #1216]
    add r4, r8
    add r4, r7
    montgomery_mul r4, r12, r14, r4, r2, r3, r7
    central_reduce r4, r1, r3
    vmov.w r14, r7, s14, s15
    barrett r4, r14, r7, r6
    strh.w r4, [r11]






    pop {r4-r12, pc}

