.p2align 2,,3
.syntax unified
.text

.global __gf_polymul_16x16_2x2_x2p2
.type __gf_polymul_16x16_2x2_x2p2, %function
__gf_polymul_16x16_2x2_x2p2:
    push {r4-r12, lr}
    vpush {s16-s31}
    sub.w sp, sp, #12
    movw.w lr, #21759
    movt.w lr, #10
    vmov.w s0, s1, r0, lr
    vmov.w s2, s3, r2, r3

    ldrsh.w r4, [r1, #0]
    strh.w r4, [r0, #0]

// ================

    ldr.w r3, [r1, #64]
    ldr.w r4, [r1, #68]
    ldr.w r5, [r2, #0]
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
    ldr.w r3, [r1, #64]
    vmov.w s8, s9, r11, r12
    vmov.w s10, s11, lr, r10
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
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
    ldr.w r3, [r1, #72]
    ldr.w r4, [r1, #76]
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #80]
    ldr.w r4, [r1, #84]
    ldr.w r5, [r2, #0]
    ldr.w r6, [r2, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s12, s13, r7, r8
    vmov.w s14, s15, r9, r10
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
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
    ldr.w r3, [r1, #72]
    ldr.w r4, [r1, #76]
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
    ldr.w r5, [r2, #24]
    ldr.w r6, [r2, #28]
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
    vmov.w s16, s17, r11, r12
    vmov.w s18, s19, lr, r10
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
    ldr.w r3, [r1, #80]
    ldr.w r4, [r1, #84]
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #88]
    ldr.w r4, [r1, #92]
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #88]
    vmov.w s20, s21, r7, r8
    vmov.w s22, s23, r9, r10
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
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
    ldr.w r5, [r2, #24]
    ldr.w r6, [r2, #28]
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
    vmov.w s24, s25, r11, r12
    vmov.w s26, s27, lr, r10
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
    vmov.w s28, s29, r7, r8
    vmov.w s30, s31, r9, r10
    str.w r11, [sp, #0]
    str.w r12, [sp, #4]
    str.w lr, [sp, #8]

// ================

    vmov.w r2, s3

    ldr.w r3, [r1, #96]
    ldr.w r4, [r1, #100]
    ldr.w r5, [r2, #0]
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
    vmov.w r3, r4, s6, s7
    add r9, r3
    add r10, r4
    ldrsh.w r3, [r1, #2]
    ldrsh.w r4, [r1, #4]
    add r7, r3
    add r8, r4
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
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #2]
    str.w r9, [r0, #6]
    ldr.w r3, [r1, #104]
    ldr.w r4, [r1, #108]
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
    ldr.w r3, [r1, #96]
    ldr.w r4, [r1, #100]
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
    ldr.w r3, [r1, #96]
    vmov.w r5, r6, s8, s9
    add r11, r5
    add r12, r6
    vmov.w r5, r6, s10, s11
    add lr, r5
    add r10, r6
    ldrsh.w r5, [r1, #10]
    ldrsh.w r6, [r1, #12]
    add r11, r5
    add r12, r6
    ldrsh.w r5, [r1, #14]
    ldrsh.w r6, [r1, #16]
    add lr, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r11, r5
    mls.w r11, r6, r0, r11
    smmulr.w r0, r12, r5
    mls.w r12, r6, r0, r12
    smmulr.w r0, lr, r5
    mls.w lr, r6, r0, lr
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #10]
    str.w lr, [r0, #14]
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
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
    ldr.w r3, [r1, #104]
    ldr.w r4, [r1, #108]
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #112]
    ldr.w r4, [r1, #116]
    ldr.w r5, [r2, #0]
    ldr.w r6, [r2, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s12, s13
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s14, s15
    add r9, r3
    add r10, r4
    ldrsh.w r3, [r1, #18]
    ldrsh.w r4, [r1, #20]
    add r7, r3
    add r8, r4
    ldrsh.w r3, [r1, #22]
    ldrsh.w r4, [r1, #24]
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
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #18]
    str.w r9, [r0, #22]
    ldr.w r3, [r1, #120]
    ldr.w r4, [r1, #124]
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
    ldr.w r3, [r1, #112]
    ldr.w r4, [r1, #116]
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
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
    ldr.w r3, [r1, #104]
    ldr.w r4, [r1, #108]
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
    ldr.w r5, [r2, #24]
    ldr.w r6, [r2, #28]
    ldr.w r3, [r1, #96]
    ldr.w r4, [r1, #100]
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
    vmov.w r3, r4, s16, s17
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s18, s19
    add lr, r3
    add r10, r4
    ldrsh.w r3, [r1, #26]
    ldrsh.w r4, [r1, #28]
    add r11, r3
    add r12, r4
    ldrsh.w r3, [r1, #30]
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
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #26]
    str.w lr, [r0, #30]
    ldr.w r3, [r1, #104]
    ldr.w r4, [r1, #108]
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
    ldr.w r3, [r1, #112]
    ldr.w r4, [r1, #116]
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #120]
    ldr.w r4, [r1, #124]
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #120]
    vmov.w r5, r6, s20, s21
    add r7, r5
    add r8, r6
    vmov.w r5, r6, s22, s23
    add r9, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r7, r5
    mls.w r7, r6, r0, r7
    smmulr.w r0, r8, r5
    mls.w r8, r6, r0, r8
    smmulr.w r0, r9, r5
    mls.w r9, r6, r0, r9
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #34]
    str.w r9, [r0, #38]
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
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
    ldr.w r5, [r2, #24]
    ldr.w r6, [r2, #28]
    ldr.w r3, [r1, #112]
    ldr.w r4, [r1, #116]
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
    vmov.w r3, r4, s24, s25
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s26, s27
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
    str.w r11, [r0, #42]
    str.w lr, [r0, #46]
    ldr.w r3, [r1, #120]
    ldr.w r4, [r1, #124]
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
    vmov.w r3, r4, s28, s29
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s30, s31
    add r9, r3
    add r10, r4
    ldr.w r3, [sp, #0]
    ldr.w r4, [sp, #4]
    ldr.w r5, [sp, #8]
    add r11, r3
    add r12, r4
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
    str.w r7, [r0, #50]
    str.w r9, [r0, #54]
    str.w r11, [r0, #58]
    strh.w lr, [r0, #62]

// ================================

    vmov.w r2, s2

    ldr.w r3, [r1, #128]
    ldr.w r4, [r1, #132]
    ldr.w r5, [r2, #0]
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
    ldr.w r3, [r1, #136]
    ldr.w r4, [r1, #140]
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
    ldr.w r3, [r1, #128]
    ldr.w r4, [r1, #132]
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
    ldr.w r3, [r1, #128]
    vmov.w s8, s9, r11, r12
    vmov.w s10, s11, lr, r10
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
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
    ldr.w r3, [r1, #136]
    ldr.w r4, [r1, #140]
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #144]
    ldr.w r4, [r1, #148]
    ldr.w r5, [r2, #0]
    ldr.w r6, [r2, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s12, s13, r7, r8
    vmov.w s14, s15, r9, r10
    ldr.w r3, [r1, #152]
    ldr.w r4, [r1, #156]
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
    ldr.w r3, [r1, #144]
    ldr.w r4, [r1, #148]
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
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
    ldr.w r3, [r1, #136]
    ldr.w r4, [r1, #140]
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
    ldr.w r5, [r2, #24]
    ldr.w r6, [r2, #28]
    ldr.w r3, [r1, #128]
    ldr.w r4, [r1, #132]
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
    vmov.w s16, s17, r11, r12
    vmov.w s18, s19, lr, r10
    ldr.w r3, [r1, #136]
    ldr.w r4, [r1, #140]
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
    ldr.w r3, [r1, #144]
    ldr.w r4, [r1, #148]
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #152]
    ldr.w r4, [r1, #156]
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #152]
    vmov.w s20, s21, r7, r8
    vmov.w s22, s23, r9, r10
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
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
    ldr.w r5, [r2, #24]
    ldr.w r6, [r2, #28]
    ldr.w r3, [r1, #144]
    ldr.w r4, [r1, #148]
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
    vmov.w s24, s25, r11, r12
    vmov.w s26, s27, lr, r10
    ldr.w r3, [r1, #152]
    ldr.w r4, [r1, #156]
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
    vmov.w s28, s29, r7, r8
    vmov.w s30, s31, r9, r10
    str.w r11, [sp, #0]
    str.w r12, [sp, #4]
    str.w lr, [sp, #8]

// ================

    vmov.w r2, s3

    ldr.w r3, [r1, #160]
    ldr.w r4, [r1, #164]
    ldr.w r5, [r2, #0]
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
    vmov.w r3, r4, s6, s7
    add r9, r3
    add r10, r4
    ldrsh.w r3, [r1, #32]
    ldrsh.w r4, [r1, #34]
    add r7, r3
    add r8, r4
    ldrsh.w r3, [r1, #36]
    ldrsh.w r4, [r1, #38]
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
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #64]
    str.w r9, [r0, #68]
    ldr.w r3, [r1, #168]
    ldr.w r4, [r1, #172]
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
    ldr.w r3, [r1, #160]
    ldr.w r4, [r1, #164]
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
    ldr.w r3, [r1, #160]
    vmov.w r5, r6, s8, s9
    add r11, r5
    add r12, r6
    vmov.w r5, r6, s10, s11
    add lr, r5
    add r10, r6
    ldrsh.w r5, [r1, #40]
    ldrsh.w r6, [r1, #42]
    add r11, r5
    add r12, r6
    ldrsh.w r5, [r1, #44]
    ldrsh.w r6, [r1, #46]
    add lr, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r11, r5
    mls.w r11, r6, r0, r11
    smmulr.w r0, r12, r5
    mls.w r12, r6, r0, r12
    smmulr.w r0, lr, r5
    mls.w lr, r6, r0, lr
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #72]
    str.w lr, [r0, #76]
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
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
    ldr.w r3, [r1, #168]
    ldr.w r4, [r1, #172]
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #176]
    ldr.w r4, [r1, #180]
    ldr.w r5, [r2, #0]
    ldr.w r6, [r2, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s12, s13
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s14, s15
    add r9, r3
    add r10, r4
    ldrsh.w r3, [r1, #48]
    ldrsh.w r4, [r1, #50]
    add r7, r3
    add r8, r4
    ldrsh.w r3, [r1, #52]
    ldrsh.w r4, [r1, #54]
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
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #80]
    str.w r9, [r0, #84]
    ldr.w r3, [r1, #184]
    ldr.w r4, [r1, #188]
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
    ldr.w r3, [r1, #176]
    ldr.w r4, [r1, #180]
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
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
    ldr.w r3, [r1, #168]
    ldr.w r4, [r1, #172]
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
    ldr.w r5, [r2, #24]
    ldr.w r6, [r2, #28]
    ldr.w r3, [r1, #160]
    ldr.w r4, [r1, #164]
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
    vmov.w r3, r4, s16, s17
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s18, s19
    add lr, r3
    add r10, r4
    ldrsh.w r3, [r1, #56]
    ldrsh.w r4, [r1, #58]
    add r11, r3
    add r12, r4
    ldrsh.w r3, [r1, #60]
    ldrsh.w r4, [r1, #62]
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
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #88]
    str.w lr, [r0, #92]
    ldr.w r3, [r1, #168]
    ldr.w r4, [r1, #172]
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
    ldr.w r3, [r1, #176]
    ldr.w r4, [r1, #180]
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #184]
    ldr.w r4, [r1, #188]
    ldr.w r5, [r2, #8]
    ldr.w r6, [r2, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r1, #184]
    vmov.w r5, r6, s20, s21
    add r7, r5
    add r8, r6
    vmov.w r5, r6, s22, s23
    add r9, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r7, r5
    mls.w r7, r6, r0, r7
    smmulr.w r0, r8, r5
    mls.w r8, r6, r0, r8
    smmulr.w r0, r9, r5
    mls.w r9, r6, r0, r9
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #96]
    str.w r9, [r0, #100]
    ldr.w r5, [r2, #16]
    ldr.w r6, [r2, #20]
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
    ldr.w r5, [r2, #24]
    ldr.w r6, [r2, #28]
    ldr.w r3, [r1, #176]
    ldr.w r4, [r1, #180]
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
    vmov.w r3, r4, s24, s25
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s26, s27
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
    ldr.w r3, [r1, #184]
    ldr.w r4, [r1, #188]
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
    vmov.w r3, r4, s28, s29
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s30, s31
    add r9, r3
    add r10, r4
    ldr.w r3, [sp, #0]
    ldr.w r4, [sp, #4]
    ldr.w r5, [sp, #8]
    add r11, r3
    add r12, r4
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
    movt.w lr, 0
    str.w r7, [r0, #112]
    str.w r9, [r0, #116]
    str.w r11, [r0, #120]
    str.w lr, [r0, #124]


    add.w sp, sp, #12
    vpop {s16-s31}
    pop {r4-r12, pc}


.p2align 2,,3
.syntax unified
.text

.global __gf_polymul_16x16_2x2_x_2x2
.type __gf_polymul_16x16_2x2_x_2x2, %function
__gf_polymul_16x16_2x2_x_2x2:
    push.w {r4-r12, lr}
    vpush.w {s16-s31}
    movw.w lr, #21759
    movt.w lr, #10
    vmov.w s0, s1, r0, lr

// ================

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
    vmov.w s2, s3, r7, r8
    vmov.w s4, s5, r9, r10
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
    ldr.w r3, [r2, #0]
    vmov.w s6, s7, r11, r12
    vmov.w s8, s9, lr, r10
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #0]
    ldr.w r6, [r1, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s10, s11, r7, r8
    vmov.w s12, s13, r9, r10
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
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
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
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
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
    vmov.w s14, s15, r11, r12
    vmov.w s16, s17, lr, r10
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
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    vmov.w s18, s19, r7, r8
    vmov.w s20, s21, r9, r10
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    vmov.w s22, s23, r11, r12
    vmov.w s24, s25, lr, r10
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
    vmov.w s26, s27, r7, r8
    vmov.w s28, s29, r9, r10
    vmov.w s30, s31, r11, r12
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r7, lr, r3
    mls.w lr, r4, r7, lr
    strh.w lr, [r0, #62]

// ================

    add.w r2, #32
    add.w r1, #64

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
    vmov.w r3, r4, s2, s3
    add r8, r3
    add r9, r4
    vmov.w r3, s4
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
    ldr.w r3, [r2, #0]
    vmov.w r5, r6, s5, s6
    add r11, r5
    add r12, r6
    vmov.w r5, r6, s7, s8
    add lr, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r11, r5
    mls.w r11, r6, r0, r11
    smmulr.w r0, r12, r5
    mls.w r12, r6, r0, r12
    smmulr.w r0, lr, r5
    mls.w lr, r6, r0, lr
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #8]
    str.w lr, [r0, #12]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #0]
    ldr.w r6, [r1, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s9, s10
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s11, s12
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
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #16]
    str.w r9, [r0, #20]
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
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
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
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
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
    vmov.w r3, r4, s13, s14
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s15, s16
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
    str.w r11, [r0, #24]
    str.w lr, [r0, #28]
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
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    vmov.w r5, r6, s17, s18
    add r7, r5
    add r8, r6
    vmov.w r5, r6, s19, s20
    add r9, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r7, r5
    mls.w r7, r6, r0, r7
    smmulr.w r0, r8, r5
    mls.w r8, r6, r0, r8
    smmulr.w r0, r9, r5
    mls.w r9, r6, r0, r9
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #32]
    str.w r9, [r0, #36]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    vmov.w r3, r4, s21, s22
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s23, s24
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
    vmov.w r3, r4, s25, s26
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s27, s28
    add r9, r3
    add r10, r4
    vmov.w r3, r4, s29, s30
    add r11, r3
    add r12, r4
    vmov.w r3, s31
    add.w lr, r3
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

// ================================

    add.w r0, #64
    vmov.w s0, r0
    sub.w r2, #32
    sub.w r1, #32

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
    vmov.w s2, s3, r7, r8
    vmov.w s4, s5, r9, r10
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
    ldr.w r3, [r2, #0]
    vmov.w s6, s7, r11, r12
    vmov.w s8, s9, lr, r10
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #0]
    ldr.w r6, [r1, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s10, s11, r7, r8
    vmov.w s12, s13, r9, r10
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
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
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
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
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
    vmov.w s14, s15, r11, r12
    vmov.w s16, s17, lr, r10
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
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    vmov.w s18, s19, r7, r8
    vmov.w s20, s21, r9, r10
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    vmov.w s22, s23, r11, r12
    vmov.w s24, s25, lr, r10
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
    vmov.w s26, s27, r7, r8
    vmov.w s28, s29, r9, r10
    vmov.w s30, s31, r11, r12
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r7, lr, r3
    mls.w lr, r4, r7, lr
    strh.w lr, [r0, #62]

// ================

    add.w r2, #32
    add.w r1, #64

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
    vmov.w r3, r4, s2, s3
    add r8, r3
    add r9, r4
    vmov.w r3, s4
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
    ldr.w r3, [r2, #0]
    vmov.w r5, r6, s5, s6
    add r11, r5
    add r12, r6
    vmov.w r5, r6, s7, s8
    add lr, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r11, r5
    mls.w r11, r6, r0, r11
    smmulr.w r0, r12, r5
    mls.w r12, r6, r0, r12
    smmulr.w r0, lr, r5
    mls.w lr, r6, r0, lr
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #8]
    str.w lr, [r0, #12]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #0]
    ldr.w r6, [r1, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s9, s10
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s11, s12
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
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #16]
    str.w r9, [r0, #20]
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
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
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
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
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
    vmov.w r3, r4, s13, s14
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s15, s16
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
    str.w r11, [r0, #24]
    str.w lr, [r0, #28]
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
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    vmov.w r5, r6, s17, s18
    add r7, r5
    add r8, r6
    vmov.w r5, r6, s19, s20
    add r9, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r7, r5
    mls.w r7, r6, r0, r7
    smmulr.w r0, r8, r5
    mls.w r8, r6, r0, r8
    smmulr.w r0, r9, r5
    mls.w r9, r6, r0, r9
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #32]
    str.w r9, [r0, #36]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    vmov.w r3, r4, s21, s22
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s23, s24
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
    vmov.w r3, r4, s25, s26
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s27, s28
    add r9, r3
    add r10, r4
    vmov.w r3, r4, s29, s30
    add r11, r3
    add r12, r4
    vmov.w r3, s31
    add.w lr, r3
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

// ================================

    add.w r0, #64
    vmov.w s0, r0
    add.w r2, #32
    sub.w r1, #96

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
    vmov.w s2, s3, r7, r8
    vmov.w s4, s5, r9, r10
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
    ldr.w r3, [r2, #0]
    vmov.w s6, s7, r11, r12
    vmov.w s8, s9, lr, r10
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #0]
    ldr.w r6, [r1, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s10, s11, r7, r8
    vmov.w s12, s13, r9, r10
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
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
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
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
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
    vmov.w s14, s15, r11, r12
    vmov.w s16, s17, lr, r10
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
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    vmov.w s18, s19, r7, r8
    vmov.w s20, s21, r9, r10
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    vmov.w s22, s23, r11, r12
    vmov.w s24, s25, lr, r10
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
    vmov.w s26, s27, r7, r8
    vmov.w s28, s29, r9, r10
    vmov.w s30, s31, r11, r12
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r7, lr, r3
    mls.w lr, r4, r7, lr
    strh.w lr, [r0, #62]

// ================

    add.w r2, #32
    add.w r1, #64

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
    vmov.w r3, r4, s2, s3
    add r8, r3
    add r9, r4
    vmov.w r3, s4
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
    ldr.w r3, [r2, #0]
    vmov.w r5, r6, s5, s6
    add r11, r5
    add r12, r6
    vmov.w r5, r6, s7, s8
    add lr, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r11, r5
    mls.w r11, r6, r0, r11
    smmulr.w r0, r12, r5
    mls.w r12, r6, r0, r12
    smmulr.w r0, lr, r5
    mls.w lr, r6, r0, lr
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #8]
    str.w lr, [r0, #12]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #0]
    ldr.w r6, [r1, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s9, s10
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s11, s12
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
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #16]
    str.w r9, [r0, #20]
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
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
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
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
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
    vmov.w r3, r4, s13, s14
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s15, s16
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
    str.w r11, [r0, #24]
    str.w lr, [r0, #28]
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
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    vmov.w r5, r6, s17, s18
    add r7, r5
    add r8, r6
    vmov.w r5, r6, s19, s20
    add r9, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r7, r5
    mls.w r7, r6, r0, r7
    smmulr.w r0, r8, r5
    mls.w r8, r6, r0, r8
    smmulr.w r0, r9, r5
    mls.w r9, r6, r0, r9
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #32]
    str.w r9, [r0, #36]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    vmov.w r3, r4, s21, s22
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s23, s24
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
    vmov.w r3, r4, s25, s26
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s27, s28
    add r9, r3
    add r10, r4
    vmov.w r3, r4, s29, s30
    add r11, r3
    add r12, r4
    vmov.w r3, s31
    add.w lr, r3
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

// ================================

    add.w r0, #64
    vmov.w s0, r0
    sub.w r2, #32
    sub.w r1, #32

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
    vmov.w s2, s3, r7, r8
    vmov.w s4, s5, r9, r10
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
    ldr.w r3, [r2, #0]
    vmov.w s6, s7, r11, r12
    vmov.w s8, s9, lr, r10
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #0]
    ldr.w r6, [r1, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w s10, s11, r7, r8
    vmov.w s12, s13, r9, r10
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
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
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
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
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
    vmov.w s14, s15, r11, r12
    vmov.w s16, s17, lr, r10
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
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    vmov.w s18, s19, r7, r8
    vmov.w s20, s21, r9, r10
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    vmov.w s22, s23, r11, r12
    vmov.w s24, s25, lr, r10
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
    vmov.w s26, s27, r7, r8
    vmov.w s28, s29, r9, r10
    vmov.w s30, s31, r11, r12
    vmov.w r3, s1
    mov.w r4, 6343
    smmulr.w r7, lr, r3
    mls.w lr, r4, r7, lr
    strh.w lr, [r0, #62]

// ================

    add.w r2, #32
    add.w r1, #64

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
    vmov.w r3, r4, s2, s3
    add r8, r3
    add r9, r4
    vmov.w r3, s4
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
    ldr.w r3, [r2, #0]
    vmov.w r5, r6, s5, s6
    add r11, r5
    add r12, r6
    vmov.w r5, r6, s7, s8
    add lr, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r11, r5
    mls.w r11, r6, r0, r11
    smmulr.w r0, r12, r5
    mls.w r12, r6, r0, r12
    smmulr.w r0, lr, r5
    mls.w lr, r6, r0, lr
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r11, r11, r12, lsl #16
    pkhbt lr, lr, r10, lsl #16
    vmov.w r0, s0
    str.w r11, [r0, #8]
    str.w lr, [r0, #12]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #0]
    ldr.w r6, [r1, #4]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    vmov.w r3, r4, s9, s10
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s11, s12
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
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #16]
    str.w r9, [r0, #20]
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
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
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
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    ldr.w r3, [r2, #8]
    ldr.w r4, [r2, #12]
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
    vmov.w r3, r4, s13, s14
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s15, s16
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
    str.w r11, [r0, #24]
    str.w lr, [r0, #28]
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
    ldr.w r3, [r2, #16]
    ldr.w r4, [r2, #20]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    ldr.w r4, [r2, #28]
    ldr.w r5, [r1, #8]
    ldr.w r6, [r1, #12]
    smlabb.w r7, r3, r5, r7
    smlabb.w r9, r3, r6, r9
    smladx.w r8, r3, r5, r8
    smladx.w r10, r3, r6, r10
    smladx.w r12, r4, r6, r12
    smlatt.w r11, r4, r5, r11
    smlatt.w lr, r4, r6, lr
    smladx.w r10, r4, r5, r10
    pkhbt.w r3, r4, r3
    smlad.w r9, r3, r5, r9
    smlad.w r11, r3, r6, r11
    ldr.w r3, [r2, #24]
    vmov.w r5, r6, s17, s18
    add r7, r5
    add r8, r6
    vmov.w r5, r6, s19, s20
    add r9, r5
    add r10, r6
    vmov.w r5, s1
    mov.w r6, 6343
    smmulr.w r0, r7, r5
    mls.w r7, r6, r0, r7
    smmulr.w r0, r8, r5
    mls.w r8, r6, r0, r8
    smmulr.w r0, r9, r5
    mls.w r9, r6, r0, r9
    smmulr.w r0, r10, r5
    mls.w r10, r6, r0, r10
    pkhbt r7, r7, r8, lsl #16
    pkhbt r9, r9, r10, lsl #16
    vmov.w r0, s0
    str.w r7, [r0, #32]
    str.w r9, [r0, #36]
    ldr.w r5, [r1, #16]
    ldr.w r6, [r1, #20]
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
    vmov.w r3, r4, s21, s22
    add r11, r3
    add r12, r4
    vmov.w r3, r4, s23, s24
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
    vmov.w r3, r4, s25, s26
    add r7, r3
    add r8, r4
    vmov.w r3, r4, s27, s28
    add r9, r3
    add r10, r4
    vmov.w r3, r4, s29, s30
    add r11, r3
    add r12, r4
    vmov.w r3, s31
    add.w lr, r3
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

    vpop.w {s16-s31}
    pop.w {r4-r12, pc}
