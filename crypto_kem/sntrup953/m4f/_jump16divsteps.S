
.p2align 2,,3
.syntax unified
.text

.global __gf_polymul_8x8_2x2_x2p2
.type __gf_polymul_8x8_2x2_x2p2, %function
__gf_polymul_8x8_2x2_x2p2:
    push {r4-r12, lr}
    vpush {s16-s19}

    movw.w r4, #21759
    movt.w r4, #10

    vmov.w s2, s3, r2, r3
    vmov.w s0, s1, r0, r4

    ldrsh.w r3, [r1]
    strh.w r3, [r0]

    ldr.w r3, [r1, #32]
    ldr.w r4, [r1, #36]
    ldr.w r5, [r2]
    ldr.w r6, [r2, #4]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s4, s5, r7, r8
    vmov.w s6, s7, r9, r10
    ldr.w r3, [r1, #40]
    ldr.w r4, [r1, #44]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    ldr.w r3, [r1, #32]
    ldr.w r4, [r1, #36]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w s8, s9, r11, r12
    vmov.w s10, s11, lr, r10
    ldr.w r3, [r1, #40]
    ldr.w r4, [r1, #44]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    movw.w r3, #0
    vmov.w s12, s13, r7, r8
    vmov.w s14, s15, r9, r10
    vmov.w s16, s17, r11, r12
    vmov.w s18, s19, lr, r3

    vmov.w r2, s3

    ldr.w r3, [r1, #48]
    ldr.w r4, [r1, #52]
    ldr.w r5, [r2]
    ldr.w r6, [r2, #4]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s4, s5
    add r7, r3
    add r8, r4
    ldrsh.w r3, [r1, #2]
    ldrsh.w r4, [r1, #4]
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s6, s7
    add r9, r3
    add r10, r4
    ldrsh.w r3, [r1, #6]
    ldrsh.w r4, [r1, #8]
    add r9, r3
    add r10, r4
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r7, r3
    mls.w r7, r4, r0, r7
    smmulr.w r0, r8, r3
    mls.w r8, r4, r0, r8
    smmulr.w r0, r9, r3
    mls.w r9, r4, r0, r9
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    vmov.w r0, s0
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    str.w r7, [r0, #2]
    str.w r9, [r0, #6]
    ldr.w r3, [r1, #56]
    ldr.w r4, [r1, #60]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    ldr.w r3, [r1, #48]
    ldr.w r4, [r1, #52]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w r3, r4, s8, s9
    add r11, r3
    add r12, r4
    ldrsh.w r3, [r1, #10]
    ldrsh.w r4, [r1, #12]
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s10, s11
    add lr, r3
    add r10, r4
    ldrsh.w r3, [r1, #14]
    add.w lr, r3
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r11, r3
    mls.w r11, r4, r0, r11
    smmulr.w r0, r12, r3
    mls.w r12, r4, r0, r12
    smmulr.w r0, lr, r3
    mls.w lr, r4, r0, lr
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    vmov.w r0, s0
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    str.w r11, [r0, #10]
    str.w lr, [r0, #14]
    ldr.w r3, [r1, #56]
    ldr.w r4, [r1, #60]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r5, r6, s12, s13
    add r7, r5
    add r8, r6
    vmov.w r5, r6, s14, s15
    add r9, r5
    add r10, r6
    vmov.w r5, r6, s16, s17
    add r11, r5
    add r12, r6
    vmov.w r5, r6, s18, s19
    add lr, r5
    add r3, r6
    movw.w r3, #0
    vmov.w r4, s1
    mov.w r5, 6343
    smmulr.w r6, r7, r4
    mls.w r7, r5, r6, r7
    smmulr.w r6, r8, r4
    mls.w r8, r5, r6, r8
    smmulr.w r6, r9, r4
    mls.w r9, r5, r6, r9
    smmulr.w r6, r10, r4
    mls.w r10, r5, r6, r10
    smmulr.w r6, r11, r4
    mls.w r11, r5, r6, r11
    smmulr.w r6, r12, r4
    mls.w r12, r5, r6, r12
    smmulr.w r6, lr, r4
    mls.w lr, r5, r6, lr
    smmulr.w r6, r3, r4
    mls.w r3, r5, r6, r3
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r3, lsl #16
    str.w r7, [r0, #18]
    str.w r9, [r0, #22]
    str.w r11, [r0, #26]
    str.w lr, [r0, #30]

// ================

    vmov.w r2, s2

    ldr.w r3, [r1, #64]
    ldr.w r4, [r1, #68]
    ldr.w r5, [r2]
    ldr.w r6, [r2, #4]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s4, s5, r7, r8
    vmov.w s6, s7, r9, r10
    ldr.w r3, [r1, #72]
    ldr.w r4, [r1, #76]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    ldr.w r3, [r1, #64]
    ldr.w r4, [r1, #68]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w s8, s9, r11, r12
    vmov.w s10, s11, lr, r10
    ldr.w r3, [r1, #72]
    ldr.w r4, [r1, #76]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    movw.w r3, #0
    vmov.w s12, s13, r7, r8
    vmov.w s14, s15, r9, r10
    vmov.w s16, s17, r11, r12
    vmov.w s18, s19, lr, r3

    vmov.w r2, s3

    ldr.w r3, [r1, #80]
    ldr.w r4, [r1, #84]
    ldr.w r5, [r2]
    ldr.w r6, [r2, #4]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s4, s5
    add r7, r3
    add r8, r4
    ldrsh.w r3, [r1, #16]
    ldrsh.w r4, [r1, #18]
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s6, s7
    add r9, r3
    add r10, r4
    ldrsh.w r3, [r1, #20]
    ldrsh.w r4, [r1, #22]
    add r9, r3
    add r10, r4
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r7, r3
    mls.w r7, r4, r0, r7
    smmulr.w r0, r8, r3
    mls.w r8, r4, r0, r8
    smmulr.w r0, r9, r3
    mls.w r9, r4, r0, r9
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    vmov.w r0, s0
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    str.w r7, [r0, #32]
    str.w r9, [r0, #36]
    ldr.w r3, [r1, #88]
    ldr.w r4, [r1, #92]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    ldr.w r3, [r1, #80]
    ldr.w r4, [r1, #84]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w r3, r4, s8, s9
    add r11, r3
    add r12, r4
    ldrsh.w r3, [r1, #24]
    ldrsh.w r4, [r1, #26]
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s10, s11
    add lr, r3
    add r10, r4
    ldrsh.w r3, [r1, #28]
    ldrsh.w r4, [r1, #30]
    add lr, r3
    add r10, r4
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r11, r3
    mls.w r11, r4, r0, r11
    smmulr.w r0, r12, r3
    mls.w r12, r4, r0, r12
    smmulr.w r0, lr, r3
    mls.w lr, r4, r0, lr
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    vmov.w r0, s0
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    str.w r11, [r0, #40]
    str.w lr, [r0, #44]
    ldr.w r3, [r1, #88]
    ldr.w r4, [r1, #92]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r5, r6, s12, s13
    add r7, r5
    add r8, r6
    vmov.w r5, r6, s14, s15
    add r9, r5
    add r10, r6
    vmov.w r5, r6, s16, s17
    add r11, r5
    add r12, r6
    vmov.w r5, r6, s18, s19
    add lr, r5
    add r3, r6
    movw.w r3, #0
    vmov.w r4, s1
    mov.w r5, 6343
    smmulr.w r6, r7, r4
    mls.w r7, r5, r6, r7
    smmulr.w r6, r8, r4
    mls.w r8, r5, r6, r8
    smmulr.w r6, r9, r4
    mls.w r9, r5, r6, r9
    smmulr.w r6, r10, r4
    mls.w r10, r5, r6, r10
    smmulr.w r6, r11, r4
    mls.w r11, r5, r6, r11
    smmulr.w r6, r12, r4
    mls.w r12, r5, r6, r12
    smmulr.w r6, lr, r4
    mls.w lr, r5, r6, lr
    smmulr.w r6, r3, r4
    mls.w r3, r5, r6, r3
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r3, lsl #16
    str.w r7, [r0, #48]
    str.w r9, [r0, #52]
    str.w r11, [r0, #56]
    str.w lr, [r0, #60]

    


    vpop {s16-s19}
    pop {r4-r12, pc}


.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_8x8_2x2_x_2x2
.type __gf_polymul_8x8_2x2_x_2x2, %function
__gf_polymul_8x8_2x2_x_2x2:
    push {r4-r12, lr}
    vpush {s16-s17}

    movw.w lr, #21759
    movt.w lr, #10
    vmov.w s0, s1, r0, lr

    ldr.w r3, [r2, #0]
    ldr.w r4, [r2, #4]
    ldr.w r5, [r1, #0]
    ldr.w r6, [r1, #4]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s4, s5, r7, r8
    vmov.w s6, s7, r9, r10
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    ldr.w r3, [r2, #0]
    ldr.w r4, [r2, #4]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w s8, s9, r11, r12
    vmov.w s10, s11, lr, r10
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s12, s13, r7, r8
    vmov.w s14, s15, r9, r10
    vmov.w s16, s17, r11, r12
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r7, lr, r3
    mls.w lr, r4, r7, lr
    strh.w lr, [r0, #30]

    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #32]
    ldr.w r6, [r1, #36]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s4, s5
    add r8, r3
    add r9, r4
    vmov.w r3, s6
    add.w r10, r3
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r7, r3
    mls.w r7, r4, r0, r7
    smmulr.w r0, r8, r3
    mls.w r8, r4, r0, r8
    smmulr.w r0, r9, r3
    mls.w r9, r4, r0, r9
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #0]
    str.w r9, [r0, #4]
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r1, #40]
    ldr.w r6, [r1, #44]
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w r3, r4, s7, s8
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s9, s10
    add lr, r3
    add r10, r4
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r11, r3
    mls.w r11, r4, r0, r11
    smmulr.w r0, r12, r3
    mls.w r12, r4, r0, r12
    smmulr.w r0, lr, r3
    mls.w lr, r4, r0, lr
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #8]
    str.w lr, [r0, #12]
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r5, r4, s11, s12
    add r7, r5
    add r8, r4
    vmov.w r5, r4, s13, s14
    add r9, r5
    add r10, r4
    vmov.w r5, r4, s15, s16
    add r11, r5
    add r12, r4
    vmov.w r5, s17
    add.w lr, r5
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r5, r7, r3
    mls.w r7, r4, r5, r7
    smmulr.w r5, r8, r3
    mls.w r8, r4, r5, r8
    smmulr.w r5, r9, r3
    mls.w r9, r4, r5, r9
    smmulr.w r5, r10, r3
    mls.w r10, r4, r5, r10
    smmulr.w r5, r11, r3
    mls.w r11, r4, r5, r11
    smmulr.w r5, r12, r3
    mls.w r12, r4, r5, r12
    smmulr.w r5, lr, r3
    mls.w lr, r4, r5, lr
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r11, r11, r12, lsl #16
    str.w r7, [r0, #16]
    str.w r9, [r0, #20]
    str.w r11, [r0, #24]
    strh.w lr, [r0, #28]

// ================

    ldr.w r3, [r2, #0]
    ldr.w r4, [r2, #4]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s4, s5, r7, r8
    vmov.w s6, s7, r9, r10
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r1, #24]
    ldr.w r6, [r1, #28]
    ldr.w r3, [r2, #0]
    ldr.w r4, [r2, #4]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w s8, s9, r11, r12
    vmov.w s10, s11, lr, r10
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s12, s13, r7, r8
    vmov.w s14, s15, r9, r10
    vmov.w s16, s17, r11, r12
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r7, lr, r3
    mls.w lr, r4, r7, lr
    strh.w lr, [r0, #62]

    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #48]
    ldr.w r6, [r1, #52]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s4, s5
    add r8, r3
    add r9, r4
    vmov.w r3, s6
    add.w r10, r3
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r7, r3
    mls.w r7, r4, r0, r7
    smmulr.w r0, r8, r3
    mls.w r8, r4, r0, r8
    smmulr.w r0, r9, r3
    mls.w r9, r4, r0, r9
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #32]
    str.w r9, [r0, #36]
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r1, #56]
    ldr.w r6, [r1, #60]
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w r3, r4, s7, s8
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s9, s10
    add lr, r3
    add r10, r4
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r11, r3
    mls.w r11, r4, r0, r11
    smmulr.w r0, r12, r3
    mls.w r12, r4, r0, r12
    smmulr.w r0, lr, r3
    mls.w lr, r4, r0, lr
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #40]
    str.w lr, [r0, #44]
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r5, r4, s11, s12
    add r7, r5
    add r8, r4
    vmov.w r5, r4, s13, s14
    add r9, r5
    add r10, r4
    vmov.w r5, r4, s15, s16
    add r11, r5
    add r12, r4
    vmov.w r5, s17
    add.w lr, r5
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r5, r7, r3
    mls.w r7, r4, r5, r7
    smmulr.w r5, r8, r3
    mls.w r8, r4, r5, r8
    smmulr.w r5, r9, r3
    mls.w r9, r4, r5, r9
    smmulr.w r5, r10, r3
    mls.w r10, r4, r5, r10
    smmulr.w r5, r11, r3
    mls.w r11, r4, r5, r11
    smmulr.w r5, r12, r3
    mls.w r12, r4, r5, r12
    smmulr.w r5, lr, r3
    mls.w lr, r4, r5, lr
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r11, r11, r12, lsl #16
    str.w r7, [r0, #48]
    str.w r9, [r0, #52]
    str.w r11, [r0, #56]
    strh.w lr, [r0, #60]

// ================

    ldr.w r3, [r2, #32]
    ldr.w r4, [r2, #36]
    ldr.w r5, [r1, #0]
    ldr.w r6, [r1, #4]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s4, s5, r7, r8
    vmov.w s6, s7, r9, r10
    ldr.w r3, [r2, #40]
    ldr.w r4, [r2, #44]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    ldr.w r3, [r2, #32]
    ldr.w r4, [r2, #36]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w s8, s9, r11, r12
    vmov.w s10, s11, lr, r10
    ldr.w r3, [r2, #40]
    ldr.w r4, [r2, #44]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s12, s13, r7, r8
    vmov.w s14, s15, r9, r10
    vmov.w s16, s17, r11, r12
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r7, lr, r3
    mls.w lr, r4, r7, lr
    strh.w lr, [r0, #94]

    ldr.w r3, [r2, #48]
    ldr.w r4, [r2, #52]
    ldr.w r5, [r1, #32]
    ldr.w r6, [r1, #36]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s4, s5
    add r8, r3
    add r9, r4
    vmov.w r3, s6
    add.w r10, r3
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r7, r3
    mls.w r7, r4, r0, r7
    smmulr.w r0, r8, r3
    mls.w r8, r4, r0, r8
    smmulr.w r0, r9, r3
    mls.w r9, r4, r0, r9
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #64]
    str.w r9, [r0, #68]
    ldr.w r3, [r2, #56]
    ldr.w r4, [r2, #60]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r1, #40]
    ldr.w r6, [r1, #44]
    ldr.w r3, [r2, #48]
    ldr.w r4, [r2, #52]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w r3, r4, s7, s8
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s9, s10
    add lr, r3
    add r10, r4
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r11, r3
    mls.w r11, r4, r0, r11
    smmulr.w r0, r12, r3
    mls.w r12, r4, r0, r12
    smmulr.w r0, lr, r3
    mls.w lr, r4, r0, lr
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #72]
    str.w lr, [r0, #76]
    ldr.w r3, [r2, #56]
    ldr.w r4, [r2, #60]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r5, r4, s11, s12
    add r7, r5
    add r8, r4
    vmov.w r5, r4, s13, s14
    add r9, r5
    add r10, r4
    vmov.w r5, r4, s15, s16
    add r11, r5
    add r12, r4
    vmov.w r5, s17
    add.w lr, r5
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r5, r7, r3
    mls.w r7, r4, r5, r7
    smmulr.w r5, r8, r3
    mls.w r8, r4, r5, r8
    smmulr.w r5, r9, r3
    mls.w r9, r4, r5, r9
    smmulr.w r5, r10, r3
    mls.w r10, r4, r5, r10
    smmulr.w r5, r11, r3
    mls.w r11, r4, r5, r11
    smmulr.w r5, r12, r3
    mls.w r12, r4, r5, r12
    smmulr.w r5, lr, r3
    mls.w lr, r4, r5, lr
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r11, r11, r12, lsl #16
    str.w r7, [r0, #80]
    str.w r9, [r0, #84]
    str.w r11, [r0, #88]
    strh.w lr, [r0, #92]

// ================

    ldr.w r3, [r2, #32]
    ldr.w r4, [r2, #36]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s4, s5, r7, r8
    vmov.w s6, s7, r9, r10
    ldr.w r3, [r2, #40]
    ldr.w r4, [r2, #44]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r1, #24]
    ldr.w r6, [r1, #28]
    ldr.w r3, [r2, #32]
    ldr.w r4, [r2, #36]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w s8, s9, r11, r12
    vmov.w s10, s11, lr, r10
    ldr.w r3, [r2, #40]
    ldr.w r4, [r2, #44]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s12, s13, r7, r8
    vmov.w s14, s15, r9, r10
    vmov.w s16, s17, r11, r12
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r7, lr, r3
    mls.w lr, r4, r7, lr
    strh.w lr, [r0, #126]

    ldr.w r3, [r2, #48]
    ldr.w r4, [r2, #52]
    ldr.w r5, [r1, #48]
    ldr.w r6, [r1, #52]
    smulbb.w r7, r3, r5
    smulbb.w r9, r3, r6
    smuadx.w r8, r3, r5
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s4, s5
    add r8, r3
    add r9, r4
    vmov.w r3, s6
    add.w r10, r3
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r7, r3
    mls.w r7, r4, r0, r7
    smmulr.w r0, r8, r3
    mls.w r8, r4, r0, r8
    smmulr.w r0, r9, r3
    mls.w r9, r4, r0, r9
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #96]
    str.w r9, [r0, #100]
    ldr.w r3, [r2, #56]
    ldr.w r4, [r2, #60]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smuadx.w r10, r3, r6
    smuadx.w r8, r4, r6
    smultt.w r7, r4, r5
    smultt.w r9, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    ldr.w r5, [r1, #56]
    ldr.w r6, [r1, #60]
    ldr.w r3, [r2, #48]
    ldr.w r4, [r2, #52]
    smlabb.w r11, r3, r5, r11
    smlabb.w lr, r3, r6, lr
    smladx.w r12, r3, r5, r12
    smladx.w r10, r3, r6, r10
    smladx.w r8, r4, r6, r8
    smlatt.w r7, r4, r5, r7
    smlatt.w r9, r4, r6, r9
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w lr, r3, r5, lr
    smlad.w r7, r3, r6, r7
    vmov.w r3, r4, s7, s8
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s9, s10
    add lr, r3
    add r10, r4
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r0, r11, r3
    mls.w r11, r4, r0, r11
    smmulr.w r0, r12, r3
    mls.w r12, r4, r0, r12
    smmulr.w r0, lr, r3
    mls.w lr, r4, r0, lr
    smmulr.w r0, r10, r3
    mls.w r10, r4, r0, r10
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #104]
    str.w lr, [r0, #108]
    ldr.w r3, [r2, #56]
    ldr.w r4, [r2, #60]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smuadx.w r10, r3, r6
    smuadx.w r12, r4, r6
    smultt.w r11, r4, r5
    smultt.w lr, r4, r6
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r5, r4, s11, s12
    add r7, r5
    add r8, r4
    vmov.w r5, r4, s13, s14
    add r9, r5
    add r10, r4
    vmov.w r5, r4, s15, s16
    add r11, r5
    add r12, r4
    vmov.w r5, s17
    add.w lr, r5
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r5, r7, r3
    mls.w r7, r4, r5, r7
    smmulr.w r5, r8, r3
    mls.w r8, r4, r5, r8
    smmulr.w r5, r9, r3
    mls.w r9, r4, r5, r9
    smmulr.w r5, r10, r3
    mls.w r10, r4, r5, r10
    smmulr.w r5, r11, r3
    mls.w r11, r4, r5, r11
    smmulr.w r5, r12, r3
    mls.w r12, r4, r5, r12
    smmulr.w r5, lr, r3
    mls.w lr, r4, r5, lr
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    pkhbt r11, r11, r12, lsl #16
    str.w r7, [r0, #112]
    str.w r9, [r0, #116]
    str.w r11, [r0, #120]
    strh.w lr, [r0, #124]

    vpop {s16-s17}
    pop {r4-r12, pc}
