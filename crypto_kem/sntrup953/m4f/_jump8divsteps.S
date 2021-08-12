.p2align 2,,3   
.syntax unified
.text

.global __polymul_4x4_2x2_x2p2
.type   __polymul_4x4_2x2_x2p2, %function
__polymul_4x4_2x2_x2p2:
    push {r4-r12, lr}

    movw.w r12, #21759
    movt.w r12, #10

    vmov.w s0, r0
    vmov.w s2, s3, r2, r3

    ldr.w r4, [r1, #16]
    ldr.w r5, [r1, #20]
    ldr.w r6, [r2]
    ldr.w r7, [r2, #4]
    ldr.w r8, [r2, #2]
    smulbb  r3, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    vmov.w s4, s5, r3, r14
    vmov.w s6, s7, r9, r10
    vmov.w s8, s9, r6, r4
    vmov.w s10, r7

    vmov.w r3, s3

    ldr.w r4, [r1, #24]
    ldr.w r5, [r1, #28]
    ldr.w r6, [r3]
    ldr.w r7, [r3, #4]
    ldr.w r8, [r3, #2]
    smulbb  r2, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    vmov.w r5, r11, s4, s5
    add r2, r5
    add r14, r11
    ldrsh.w r5, [r1, #2]
    ldrsh.w r11, [r1, #4]
    add r2, r5
    add r14, r11
    vmov.w r5, r11, s6, s7
    add r9, r5
    add r10, r11
    ldrsh.w r5, [r1, #6]
    add.w r9, r5
    vmov.w r5, r11, s8, s9
    add r6, r5
    add r4, r11
    vmov.w r5, s10
    add.w r7, r5

    mov.w r11, 6343

    smmulr.w r5, r2, r12
    mls.w r2, r11, r5, r2
    smmulr.w r5, r14, r12
    mls.w r14, r11, r5, r14
    smmulr.w r5, r9, r12
    mls.w r9, r11, r5, r9
    smmulr.w r5, r10, r12
    mls.w r10, r11, r5, r10
    smmulr.w r5, r6, r12
    mls.w r6, r11, r5, r6
    smmulr.w r5, r4, r12
    mls.w r4, r11, r5, r4
    smmulr.w r5, r7, r12
    mls.w r7, r11, r5, r7

    ldr.w r5, [r1]

    pkhbt r2, r5, r2, lsl #16
    pkhbt r14, r14, r9, lsl #16
    pkhbt r10, r10, r6, lsl #16
    pkhbt r4, r4, r7, lsl #16
    
    str.w r2, [r0, #0]
    str.w r14, [r0, #4]
    str.w r10, [r0, #8]
    str.w r4, [r0, #12]

    vmov.w r2, s2

    ldr.w r4, [r1, #32]
    ldr.w r5, [r1, #36]
    ldr.w r6, [r2]
    ldr.w r7, [r2, #4]
    ldr.w r8, [r2, #2]
    smulbb  r3, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    vmov.w s4, s5, r3, r14
    vmov.w s6, s7, r9, r10
    vmov.w s8, s9, r6, r4
    vmov.w s10, r7

    vmov.w r3, s3

    ldr.w r4, [r1, #40]
    ldr.w r5, [r1, #44]
    ldr.w r6, [r3]
    ldr.w r7, [r3, #4]
    ldr.w r8, [r3, #2]
    smulbb  r2, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    vmov.w r5, r11, s4, s5
    add r2, r5
    add r14, r11
    ldrsh.w r5, [r1, #8]
    ldrsh.w r11, [r1, #10]
    add r2, r5
    add r14, r11
    vmov.w r5, r11, s6, s7
    add r9, r5
    add r10, r11
    ldrsh.w r5, [r1, #12]
    ldrsh.w r11, [r1, #14]
    add r9, r5
    add r10, r11
    vmov.w r5, r11, s8, s9
    add r6, r5
    add r4, r11
    vmov.w r5, s10
    add.w r7, r5

    mov.w r11, 6343

    smmulr.w r5, r2, r12
    mls.w r2, r11, r5, r2
    smmulr.w r5, r14, r12
    mls.w r14, r11, r5, r14
    smmulr.w r5, r9, r12
    mls.w r9, r11, r5, r9
    smmulr.w r5, r10, r12
    mls.w r10, r11, r5, r10
    smmulr.w r5, r6, r12
    mls.w r6, r11, r5, r6
    smmulr.w r5, r4, r12
    mls.w r4, r11, r5, r4
    smmulr.w r5, r7, r12
    mls.w r7, r11, r5, r7

    pkhbt r2, r2, r14, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r6, r6, r4, lsl #16
    lsl r7, r7, #16
    lsr r7, r7, #16

    str.w r2, [r0, #16]
    str.w r9, [r0, #20]
    str.w r6, [r0, #24]
    str.w r7, [r0, #28]

    pop {r4-r12, pc}

.p2align 2,,3   
.syntax unified
.text

.global __polymul_4x4_2x2_x_2x2
.type   __polymul_4x4_2x2_x_2x2, %function
__polymul_4x4_2x2_x_2x2:
    push {r4-r12, lr}

    movw.w r12, #21759
    movt.w r12, #10

    ldr.w r4, [r2]
    ldr.w r5, [r2, #4]
    ldr.w r6, [r1]
    ldr.w r7, [r1, #4]
    ldr.w r8, [r1, #2]
    smulbb  r3, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    mov.w r11, 6343
    smmulr.w r5, r7, r12
    mls.w r7, r11, r5, r7

    vmov.w s4, s5, r3, r14
    vmov.w s6, s7, r9, r10
    vmov.w s8, s9, r6, r4
    strh.w r7, [r0, #14]

    ldr.w r4, [r2, #8]
    ldr.w r5, [r2, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #18]
    smulbb  r3, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    vmov.w r5, r11, s4, s5
    add r14, r5
    add r9, r11
    vmov.w r5, r11, s6, s7
    add r10, r5
    add r6, r11
    vmov.w r5, r11, s8, s9
    add r4, r5
    add r7, r11

    mov.w r11, 6343
    smmulr.w r5, r3, r12
    mls.w r3, r11, r5, r3
    smmulr.w r5, r14, r12
    mls.w r14, r11, r5, r14
    smmulr.w r5, r9, r12
    mls.w r9, r11, r5, r9
    smmulr.w r5, r10, r12
    mls.w r10, r11, r5, r10
    smmulr.w r5, r6, r12
    mls.w r6, r11, r5, r6
    smmulr.w r5, r4, r12
    mls.w r4, r11, r5, r4
    smmulr.w r5, r7, r12
    mls.w r7, r11, r5, r7

    pkhbt r3, r3, r14, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r6, r6, r4, lsl #16
    str.w r3, [r0, #0]
    str.w r9, [r0, #4]
    str.w r6, [r0, #8]
    strh.w r7, [r0, #12]

// ================================

    ldr.w r4, [r2]
    ldr.w r5, [r2, #4]
    ldr.w r6, [r1, #8]
    ldr.w r7, [r1, #12]
    ldr.w r8, [r1, #10]
    smulbb  r3, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    mov.w r11, 6343
    smmulr.w r5, r7, r12
    mls.w r7, r11, r5, r7

    vmov.w s4, s5, r3, r14
    vmov.w s6, s7, r9, r10
    vmov.w s8, s9, r6, r4
    strh.w r7, [r0, #30]

    ldr.w r4, [r2, #8]
    ldr.w r5, [r2, #12]
    ldr.w r6, [r1, #24]
    ldr.w r7, [r1, #28]
    ldr.w r8, [r1, #26]
    smulbb  r3, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    vmov.w r5, r11, s4, s5
    add r14, r5
    add r9, r11
    vmov.w r5, r11, s6, s7
    add r10, r5
    add r6, r11
    vmov.w r5, r11, s8, s9
    add r4, r5
    add r7, r11
    
    mov.w r11, 6343
    smmulr.w r5, r3, r12
    mls.w r3, r11, r5, r3
    smmulr.w r5, r14, r12
    mls.w r14, r11, r5, r14
    smmulr.w r5, r9, r12
    mls.w r9, r11, r5, r9
    smmulr.w r5, r10, r12
    mls.w r10, r11, r5, r10
    smmulr.w r5, r6, r12
    mls.w r6, r11, r5, r6
    smmulr.w r5, r4, r12
    mls.w r4, r11, r5, r4
    smmulr.w r5, r7, r12
    mls.w r7, r11, r5, r7

    pkhbt r3, r3, r14, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r6, r6, r4, lsl #16
    str.w r3, [r0, #16]
    str.w r9, [r0, #20]
    str.w r6, [r0, #24]
    strh.w r7, [r0, #28]

// ================================

    ldr.w r4, [r2, #16]
    ldr.w r5, [r2, #20]
    ldr.w r6, [r1, #0]
    ldr.w r7, [r1, #4]
    ldr.w r8, [r1, #2]
    smulbb  r3, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    mov.w r11, 6343
    smmulr.w r5, r7, r12
    mls.w r7, r11, r5, r7

    vmov.w s4, s5, r3, r14
    vmov.w s6, s7, r9, r10
    vmov.w s8, s9, r6, r4
    strh.w r7, [r0, #46]

    ldr.w r4, [r2, #24]
    ldr.w r5, [r2, #28]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #18]
    smulbb  r3, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    vmov.w r5, r11, s4, s5
    add r14, r5
    add r9, r11
    vmov.w r5, r11, s6, s7
    add r10, r5
    add r6, r11
    vmov.w r5, r11, s8, s9
    add r4, r5
    add r7, r11
    
    mov.w r11, 6343
    smmulr.w r5, r3, r12
    mls.w r3, r11, r5, r3
    smmulr.w r5, r14, r12
    mls.w r14, r11, r5, r14
    smmulr.w r5, r9, r12
    mls.w r9, r11, r5, r9
    smmulr.w r5, r10, r12
    mls.w r10, r11, r5, r10
    smmulr.w r5, r6, r12
    mls.w r6, r11, r5, r6
    smmulr.w r5, r4, r12
    mls.w r4, r11, r5, r4
    smmulr.w r5, r7, r12
    mls.w r7, r11, r5, r7

    pkhbt r3, r3, r14, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r6, r6, r4, lsl #16
    str.w r3, [r0, #32]
    str.w r9, [r0, #36]
    str.w r6, [r0, #40]
    strh.w r7, [r0, #44]

// ================================

    ldr.w r4, [r2, #16]
    ldr.w r5, [r2, #20]
    ldr.w r6, [r1, #8]
    ldr.w r7, [r1, #12]
    ldr.w r8, [r1, #10]
    smulbb  r3, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    mov.w r11, 6343
    smmulr.w r5, r7, r12
    mls.w r7, r11, r5, r7

    vmov.w s4, s5, r3, r14
    vmov.w s6, s7, r9, r10
    vmov.w s8, s9, r6, r4
    strh.w r7, [r0, #62]

    ldr.w r4, [r2, #24]
    ldr.w r5, [r2, #28]
    ldr.w r6, [r1, #24]
    ldr.w r7, [r1, #28]
    ldr.w r8, [r1, #26]
    smulbb  r3, r4, r6
    smuadx  r14, r4, r6
    smuadx  r10, r4, r7
    smulbb  r9, r5, r6
    smladx  r10, r5, r6, r10
    smladx  r9, r4, r8, r9
    smultt  r6, r4, r7
    smuadx  r4, r5, r7
    smultt  r7, r5, r7
    smladx  r6, r5, r8, r6

    vmov.w r5, r11, s4, s5
    add r14, r5
    add r9, r11
    vmov.w r5, r11, s6, s7
    add r10, r5
    add r6, r11
    vmov.w r5, r11, s8, s9
    add r4, r5
    add r7, r11
    
    mov.w r11, 6343
    smmulr.w r5, r3, r12
    mls.w r3, r11, r5, r3
    smmulr.w r5, r14, r12
    mls.w r14, r11, r5, r14
    smmulr.w r5, r9, r12
    mls.w r9, r11, r5, r9
    smmulr.w r5, r10, r12
    mls.w r10, r11, r5, r10
    smmulr.w r5, r6, r12
    mls.w r6, r11, r5, r6
    smmulr.w r5, r4, r12
    mls.w r4, r11, r5, r4
    smmulr.w r5, r7, r12
    mls.w r7, r11, r5, r7

    pkhbt r3, r3, r14, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r6, r6, r4, lsl #16
    str.w r3, [r0, #48]
    str.w r9, [r0, #52]
    str.w r6, [r0, #56]
    strh.w r7, [r0, #60]

    pop {r4-r12, pc}





















