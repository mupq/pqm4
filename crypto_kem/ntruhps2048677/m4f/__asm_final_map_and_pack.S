.macro montgomery_mul a, b, lower, upper, tmp, Mprime, M
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \lower, \Mprime
    smlal.w \lower, \upper, \tmp, \M
.endm

.macro central_reduce target, Mhalf, M
    cmp \target, \Mhalf
    it gt
    subgt \target, \M
    cmn \target, \Mhalf
    it lt
    addlt \target, \M
.endm

// ================================================================

.syntax unified
.cpu cortex-m4

table:
   .word 2873600

// ================================================================

.align 2
.global __asm_final_map_and_pack
.type __asm_final_map_and_pack, %function
__asm_final_map_and_pack:
    vldm.w sp, {s4-s6}
    push.w {r4-r12, lr}

    vmov.w r12, r14, s4, s5
    adr.w r11, table
    vldr.w s7, [r11]

    add.w r4, r0, #672
    vmov.w s0, r4

    loop1:

// ================================

    ldr.w r4, [r3, #0]
    ldr.w r5, [r3, #2052]
    ldr.w r6, [r2, #8]
    ldr.w r7, [r3, #12]
    ldr.w r8, [r2, #660]
    ldr.w r9, [r3, #664]
    ldr.w r10, [r3, #2716]
    ldr.w r11, [r2, #672]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r3, #2064]
    ldr.w r5, [r2, #20]
    ldr.w r6, [r3, #24]
    ldr.w r7, [r3, #2076]
    ldr.w r8, [r3, #676]
    ldr.w r9, [r3, #2728]
    ldr.w r10, [r2, #684]
    ldr.w r11, [r3, #688]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r2, #32]
    ldr.w r5, [r3, #36]
    ldr.w r6, [r3, #2088]
    ldr.w r7, [r2, #44]
    ldr.w r8, [r3, #2740]
    ldr.w r9, [r2, #696]
    ldr.w r10, [r3, #700]
    ldr.w r11, [r3, #2752]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    add.w r3, #48
    add.w r2, #48

    vmov.w r4, s0
    cmp.w r0, r4
    bne.w loop1

    sub.w r3, #1344
    sub.w r2, #1344

// ================================

    ldr.w r4, [r3, #1344]
    ldr.w r5, [r3, #3396]
    ldr.w r6, [r2, #1352]
    ldr.w r7, [r3, #1356]
    ldr.w r8, [r2, #2004]
    ldr.w r9, [r3, #2008]
    ldr.w r10, [r3, #4060]
    ldr.w r11, [r2, #2016]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r3, #3408]
    ldr.w r5, [r2, #1364]
    ldr.w r6, [r3, #1368]
    ldr.w r7, [r3, #3420]
    ldr.w r8, [r3, #2020]
    ldr.w r9, [r3, #4072]
    ldr.w r10, [r2, #2028]
    ldr.w r11, [r3, #2032]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r2, #1376]
    ldr.w r5, [r3, #1380]
    ldr.w r6, [r3, #3432]
    ldr.w r7, [r2, #1388]
    ldr.w r8, [r3, #4084]
    ldr.w r9, [r2, #2040]
    ldr.w r10, [r3, #2044]
    ldr.w r11, [r3, #2048]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    add.w r4, r0, #312
    vmov.w s0, r4

    loop2:

// ================================

    ldr.w r4, [r3, #1392]
    ldr.w r5, [r3, #3444]
    ldr.w r6, [r2, #1400]
    ldr.w r7, [r3, #1404]
    ldr.w r8, [r2, #4]
    ldr.w r9, [r3, #8]
    ldr.w r10, [r3, #2060]
    ldr.w r11, [r2, #16]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r3, #3456]
    ldr.w r5, [r2, #1412]
    ldr.w r6, [r3, #1416]
    ldr.w r7, [r3, #3468]
    ldr.w r8, [r3, #20]
    ldr.w r9, [r3, #2072]
    ldr.w r10, [r2, #28]
    ldr.w r11, [r3, #32]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r2, #1424]
    ldr.w r5, [r3, #1428]
    ldr.w r6, [r3, #3480]
    ldr.w r7, [r2, #1436]
    ldr.w r8, [r3, #2084]
    ldr.w r9, [r2, #40]
    ldr.w r10, [r3, #44]
    ldr.w r11, [r3, #2096]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    add.w r3, #48
    add.w r2, #48

    vmov.w r4, s0
    cmp.w r0, r4
    bne.w loop2

    sub.w r3, #624
    sub.w r2, #624

// ================================

    ldr.w r4, [r3, #2016]
    ldr.w r5, [r3, #4068]
    ldr.w r6, [r2, #2024]
    ldr.w r7, [r3, #2028]
    ldr.w r8, [r2, #628]
    ldr.w r9, [r3, #632]
    ldr.w r10, [r3, #2684]
    ldr.w r11, [r2, #640]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r3, #4080]
    ldr.w r5, [r2, #2036]
    ldr.w r6, [r3, #2040]
    ldr.w r7, [r3, #4092]
    ldr.w r8, [r3, #644]
    ldr.w r9, [r3, #2696]
    ldr.w r10, [r2, #652]
    ldr.w r11, [r3, #656]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r2, #0]
    ldr.w r5, [r3, #4]
    ldr.w r6, [r3, #2056]
    ldr.w r7, [r2, #12]
    ldr.w r8, [r3, #2708]
    ldr.w r9, [r2, #664]
    ldr.w r10, [r3, #668]
    ldr.w r11, [r3, #2720]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    add.w r4, r0, #312
    vmov.w s0, r4

    loop3:

// ================================

    ldr.w r4, [r3, #16]
    ldr.w r5, [r3, #2068]
    ldr.w r6, [r2, #24]
    ldr.w r7, [r3, #28]
    ldr.w r8, [r2, #676]
    ldr.w r9, [r3, #680]
    ldr.w r10, [r3, #2732]
    ldr.w r11, [r2, #688]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r3, #2080]
    ldr.w r5, [r2, #36]
    ldr.w r6, [r3, #40]
    ldr.w r7, [r3, #2092]
    ldr.w r8, [r3, #692]
    ldr.w r9, [r3, #2744]
    ldr.w r10, [r2, #700]
    ldr.w r11, [r3, #704]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r2, #48]
    ldr.w r5, [r3, #52]
    ldr.w r6, [r3, #2104]
    ldr.w r7, [r2, #60]
    ldr.w r8, [r3, #2756]
    ldr.w r9, [r2, #712]
    ldr.w r10, [r3, #716]
    ldr.w r11, [r3, #2768]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    add.w r3, #48
    add.w r2, #48

    vmov.w r4, s0
    cmp.w r0, r4
    bne.w loop3

    sub.w r3, #624
    sub.w r2, #624

// ================================

    ldr.w r4, [r3, #640]
    ldr.w r5, [r3, #2692]
    ldr.w r6, [r2, #648]
    ldr.w r7, [r3, #652]
    ldr.w r8, [r2, #1300]
    ldr.w r9, [r3, #1304]
    ldr.w r10, [r3, #3356]
    ldr.w r11, [r2, #1312]

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11

    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    montgomery_mul r5, r1, r8, r5, r9, r12, r14
    montgomery_mul r6, r1, r8, r6, r9, r12, r14
    montgomery_mul r7, r1, r8, r7, r9, r12, r14

    vmov.w r10, r11, s6, s7
    central_reduce r4, r11, r14
    central_reduce r5, r11, r14
    central_reduce r6, r11, r14
    central_reduce r7, r11, r14

    pkhbt r4, r4, r5, lsl #16
    pkhbt r6, r6, r7, lsl #16

    and r4, r4, r10
    and r6, r6, r10

    str.w r6, [r0, #4]
    str.w r4, [r0], #8

// ================================

    ldr.w r4, [r3, #2704]
    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    central_reduce r4, r11, r14
    and r4, r4, r10, lsr #16
    strh r4, [r0]

// ================================

    pop.w {r4-r12, pc}

