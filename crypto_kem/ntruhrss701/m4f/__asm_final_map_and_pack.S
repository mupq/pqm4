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

    add.w r4, r0, #624
    vmov.w s0, r4

    loop1:

// ================================

    ldr.w r4, [r3, #0]
    ldr.w r5, [r3, #2052]
    ldr.w r6, [r2, #8]
    ldr.w r7, [r3, #12]
    ldr.w r8, [r2, #756]
    ldr.w r9, [r3, #760]
    ldr.w r10, [r3, #2812]
    ldr.w r11, [r2, #768]

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
    ldr.w r8, [r3, #772]
    ldr.w r9, [r3, #2824]
    ldr.w r10, [r2, #780]
    ldr.w r11, [r3, #784]

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
    ldr.w r8, [r3, #2836]
    ldr.w r9, [r2, #792]
    ldr.w r10, [r3, #796]
    ldr.w r11, [r3, #2848]

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

    sub.w r3, #1248
    sub.w r2, #1248

// ================================

    ldr.w r4, [r3, #1248]
    ldr.w r5, [r3, #3300]
    ldr.w r6, [r2, #1256]
    ldr.w r7, [r3, #1260]
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

    ldr.w r4, [r3, #3312]
    ldr.w r5, [r2, #1268]
    ldr.w r6, [r3, #1272]
    ldr.w r7, [r3, #3324]
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

    ldr.w r4, [r2, #1280]
    ldr.w r5, [r3, #1284]
    ldr.w r6, [r3, #3336]
    ldr.w r7, [r2, #1292]
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

    add.w r4, r0, #360
    vmov.w s0, r4

    loop2:

// ================================

    ldr.w r4, [r3, #1296]
    ldr.w r5, [r3, #3348]
    ldr.w r6, [r2, #1304]
    ldr.w r7, [r3, #1308]
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

    ldr.w r4, [r3, #3360]
    ldr.w r5, [r2, #1316]
    ldr.w r6, [r3, #1320]
    ldr.w r7, [r3, #3372]
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

    ldr.w r4, [r2, #1328]
    ldr.w r5, [r3, #1332]
    ldr.w r6, [r3, #3384]
    ldr.w r7, [r2, #1340]
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

    sub.w r3, #720
    sub.w r2, #720

// ================================

    ldr.w r4, [r3, #2016]
    ldr.w r5, [r3, #4068]
    ldr.w r6, [r2, #2024]
    ldr.w r7, [r3, #2028]
    ldr.w r8, [r2, #724]
    ldr.w r9, [r3, #728]
    ldr.w r10, [r3, #2780]
    ldr.w r11, [r2, #736]

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
    ldr.w r8, [r3, #740]
    ldr.w r9, [r3, #2792]
    ldr.w r10, [r2, #748]
    ldr.w r11, [r3, #752]

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
    ldr.w r8, [r3, #2804]
    ldr.w r9, [r2, #760]
    ldr.w r10, [r3, #764]
    ldr.w r11, [r3, #2816]

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

    add.w r4, r0, #360
    vmov.w s0, r4

    loop3:

// ================================

    ldr.w r4, [r3, #16]
    ldr.w r5, [r3, #2068]
    ldr.w r6, [r2, #24]
    ldr.w r7, [r3, #28]
    ldr.w r8, [r2, #772]
    ldr.w r9, [r3, #776]
    ldr.w r10, [r3, #2828]
    ldr.w r11, [r2, #784]

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
    ldr.w r8, [r3, #788]
    ldr.w r9, [r3, #2840]
    ldr.w r10, [r2, #796]
    ldr.w r11, [r3, #800]

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
    ldr.w r8, [r3, #2852]
    ldr.w r9, [r2, #808]
    ldr.w r10, [r3, #812]
    ldr.w r11, [r3, #2864]

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

    sub.w r3, #720
    sub.w r2, #720

// ================================

    ldr.w r4, [r3, #736]
    ldr.w r5, [r3, #2788]
    ldr.w r6, [r2, #744]
    ldr.w r7, [r3, #748]
    ldr.w r8, [r2, #1492]
    ldr.w r9, [r3, #1496]
    ldr.w r10, [r3, #3548]
    ldr.w r11, [r2, #1504]

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

    ldr.w r4, [r3, #2800]
    montgomery_mul r4, r1, r8, r4, r9, r12, r14
    central_reduce r4, r11, r14
    and r4, r4, r10, lsr #16
    strh r4, [r0]

// ================================

    pop.w {r4-r12, pc}

