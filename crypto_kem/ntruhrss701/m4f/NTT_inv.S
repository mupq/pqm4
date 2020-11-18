.macro montgomery_mul a, b, lower, upper, tmp, Mprime, M
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \lower, \Mprime
    smlal.w \lower, \upper, \tmp, \M
.endm

.macro add_sub4 a1, b1, a2, b2, a3, b3, a4, b4
    add \a1, \b1
    add \a2, \b2
    add \a3, \b3
    add \a4, \b4
    sub.w \b1, \a1, \b1, lsl #1
    sub.w \b2, \a2, \b2, lsl #1
    sub.w \b3, \a3, \b3, lsl #1
    sub.w \b4, \a4, \b4, lsl #1
.endm

.syntax unified
.cpu cortex-m4

// ================================================================

.align 2
.global __asm_NTT_inv_1_2_3
.type __asm_NTT_inv_1_2_3, %function
__asm_NTT_inv_1_2_3:

    push.w {r4-r12, lr}

    mov.w r14, r0
    add.w r0, #2048
    vmov.w s0, r0
    vldm.w r1, {s4-s9}

    add.w r4, r14, #64
    vmov.w s1, r4

    first_inv_3_layer_init_loop:

// ================================

    ldm.w r14, {r4-r11}

    vmov.w r12, s4
    montgomery_mul r4, r12, r0, r4, r1, r2, r3
    montgomery_mul r5, r12, r0, r5, r1, r2, r3
    montgomery_mul r6, r12, r0, r6, r1, r2, r3
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r8, r12, r0, r8, r1, r2, r3
    montgomery_mul r9, r12, r0, r9, r1, r2, r3
    montgomery_mul r10, r12, r0, r10, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s5
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s9
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    vmov.w r12, s7
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    stm.w r14, {r4-r11}

    add.w r14, #2048

// ================================

    ldm.w r14, {r4-r11}

    vmov.w r12, s4
    montgomery_mul r4, r12, r0, r4, r1, r2, r3
    montgomery_mul r5, r12, r0, r5, r1, r2, r3
    montgomery_mul r6, r12, r0, r6, r1, r2, r3
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r8, r12, r0, r8, r1, r2, r3
    montgomery_mul r9, r12, r0, r9, r1, r2, r3
    montgomery_mul r10, r12, r0, r10, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s5
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s9
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    vmov.w r12, s7
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    stm.w r14, {r4-r11}

    add.w r14, #2048

// ================================

    ldm.w r14, {r4-r11}

    vmov.w r12, s4
    montgomery_mul r4, r12, r0, r4, r1, r2, r3
    montgomery_mul r5, r12, r0, r5, r1, r2, r3
    montgomery_mul r6, r12, r0, r6, r1, r2, r3
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r8, r12, r0, r8, r1, r2, r3
    montgomery_mul r9, r12, r0, r9, r1, r2, r3
    montgomery_mul r10, r12, r0, r10, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s5
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s9
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    vmov.w r12, s7
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    stm.w r14, {r4-r11}

    sub.w r14, #4064

// ================================

    vmov.w r4, s1
    cmp.w r4, r14
    bne.w first_inv_3_layer_init_loop

    first_inv_3_layer_loop:

// ================================

    ldm.w r14, {r4-r11}

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s5
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s9
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    vmov.w r12, s7
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    stm.w r14, {r4-r11}

    add.w r14, #2048

// ================================

    ldm.w r14, {r4-r11}

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s5
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s9
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    vmov.w r12, s7
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    stm.w r14, {r4-r11}

    add.w r14, #2048

// ================================

    ldm.w r14, {r4-r11}

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s5
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s9
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    vmov.w r12, s7
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    stm.w r14, {r4-r11}

    sub.w r14, #4064

// ================================

    vmov.w r0, s0
    cmp.w r0, r14
    bne.w first_inv_3_layer_loop

    pop.w {r4-r12, pc}

// ================================================================

.align 2
.global __asm_NTT_inv_4_5_6
.type __asm_NTT_inv_4_5_6, %function
__asm_NTT_inv_4_5_6:

    push.w {r4-r12, lr}

    vldm.w r1!, {s9-s15}
    vmov.w s1, r1

    add.w r14, r0, #228

    add.w r4, r14, #2048
    vmov.w s0, r4

    second_inv_3_layer_inner_init_loop:

// ================================

    ldr.w r4, [r14, #-228]
    ldr.w r5, [r14, #-196]
    ldr.w r6, [r14, #-164]
    ldr.w r7, [r14, #-132]
    ldr.w r8, [r14, #-100]
    ldr.w r9, [r14, #-68]
    ldr.w r10, [r14, #-36]
    ldr.w r11, [r14, #-4]

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #-228]
    str.w r5, [r14, #-196]
    str.w r6, [r14, #-164]
    str.w r7, [r14, #-132]
    str.w r8, [r14, #-100]
    str.w r9, [r14, #-68]
    str.w r10, [r14, #-36]
    str.w r11, [r14, #-4]

// ================================

    ldr.w r4, [r14, #1820]
    ldr.w r5, [r14, #1852]
    ldr.w r6, [r14, #1884]
    ldr.w r7, [r14, #1916]
    ldr.w r8, [r14, #1948]
    ldr.w r9, [r14, #1980]
    ldr.w r10, [r14, #2012]
    ldr.w r11, [r14, #2044]

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #1820]
    str.w r5, [r14, #1852]
    str.w r6, [r14, #1884]
    str.w r7, [r14, #1916]
    str.w r8, [r14, #1948]
    str.w r9, [r14, #1980]
    str.w r10, [r14, #2012]
    str.w r11, [r14, #2044]

// ================================

    ldr.w r4, [r14, #3868]
    ldr.w r5, [r14, #3900]
    ldr.w r6, [r14, #3932]
    ldr.w r7, [r14, #3964]
    ldr.w r8, [r14, #3996]
    ldr.w r9, [r14, #4028]
    ldr.w r10, [r14, #4060]
    ldr.w r11, [r14, #4092]

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #3868]
    str.w r5, [r14, #3900]
    str.w r6, [r14, #3932]
    str.w r7, [r14, #3964]
    str.w r8, [r14, #3996]
    str.w r9, [r14, #4028]
    str.w r10, [r14, #4060]
    str.w r11, [r14, #4092]

    add.w r14, #256

// ================================

    vmov.w r4, s0
    cmp.w r4, r14
    bne.w second_inv_3_layer_inner_init_loop

    sub.w r14, #2272

    vmov.w r1, s1
    add.w r7, r1, #196
    vmov.w s7, r7

    second_inv_3_layer_outer_loop:

    vldm.w r1!, {s9-s15}

    add.w r14, #228

    add.w r4, r14, #2048
    vmov.w s0, s1, r4, r1

    second_inv_3_layer_inner_loop:

// ================================

    ldr.w r4, [r14, #-228]
    ldr.w r5, [r14, #-196]
    ldr.w r6, [r14, #-164]
    ldr.w r7, [r14, #-132]
    ldr.w r8, [r14, #-100]
    ldr.w r9, [r14, #-68]
    ldr.w r10, [r14, #-36]
    ldr.w r11, [r14, #-4]

    vmov.w r12, s9
    montgomery_mul r5, r12, r0, r5, r1, r2, r3
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r9, r12, r0, r9, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s10
    montgomery_mul r6, r12, r0, r6, r1, r2, r3
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    vmov.w r12, s12
    montgomery_mul r8, r12, r0, r8, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s14
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #-228]
    str.w r5, [r14, #-196]
    str.w r6, [r14, #-164]
    str.w r7, [r14, #-132]
    str.w r8, [r14, #-100]
    str.w r9, [r14, #-68]
    str.w r10, [r14, #-36]
    str.w r11, [r14, #-4]

// ================================

    ldr.w r4, [r14, #1820]
    ldr.w r5, [r14, #1852]
    ldr.w r6, [r14, #1884]
    ldr.w r7, [r14, #1916]
    ldr.w r8, [r14, #1948]
    ldr.w r9, [r14, #1980]
    ldr.w r10, [r14, #2012]
    ldr.w r11, [r14, #2044]

    vmov.w r12, s9
    montgomery_mul r5, r12, r0, r5, r1, r2, r3
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r9, r12, r0, r9, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s10
    montgomery_mul r6, r12, r0, r6, r1, r2, r3
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    vmov.w r12, s12
    montgomery_mul r8, r12, r0, r8, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s14
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #1820]
    str.w r5, [r14, #1852]
    str.w r6, [r14, #1884]
    str.w r7, [r14, #1916]
    str.w r8, [r14, #1948]
    str.w r9, [r14, #1980]
    str.w r10, [r14, #2012]
    str.w r11, [r14, #2044]

// ================================

    ldr.w r4, [r14, #3868]
    ldr.w r5, [r14, #3900]
    ldr.w r6, [r14, #3932]
    ldr.w r7, [r14, #3964]
    ldr.w r8, [r14, #3996]
    ldr.w r9, [r14, #4028]
    ldr.w r10, [r14, #4060]
    ldr.w r11, [r14, #4092]

    vmov.w r12, s9
    montgomery_mul r5, r12, r0, r5, r1, r2, r3
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r9, r12, r0, r9, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s10
    montgomery_mul r6, r12, r0, r6, r1, r2, r3
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    vmov.w r12, s12
    montgomery_mul r8, r12, r0, r8, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s14
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #3868]
    str.w r5, [r14, #3900]
    str.w r6, [r14, #3932]
    str.w r7, [r14, #3964]
    str.w r8, [r14, #3996]
    str.w r9, [r14, #4028]
    str.w r10, [r14, #4060]
    str.w r11, [r14, #4092]

    add.w r14, #256

// ================================

    vmov.w r4, s0
    cmp.w r4, r14
    bne.w second_inv_3_layer_inner_loop

    sub.w r14, #2272

    vmov.w r1, s1
    vmov.w r7, s7
    cmp.w r7, r1
    bne.w second_inv_3_layer_outer_loop

    pop.w {r4-r12, pc}

// ================================================================

.align 2
.global __asm_NTT_inv_7_8_9
.type __asm_NTT_inv_7_8_9, %function
__asm_NTT_inv_7_8_9:

    push.w {r4-r12, lr}

    mov.w r14, r0

    vldm.w r1!, {s9-s15}
    vmov.w s1, r1
    vmov.w r12, s9

    ldr.w r4, [r14, #0]
    ldr.w r5, [r14, #1024]
    ldr.w r6, [r14, #2048]
    ldr.w r7, [r14, #3072]

    montgomery_mul r4, r12, r8, r4, r9, r2, r3
    montgomery_mul r5, r12, r8, r5, r9, r2, r3
    montgomery_mul r6, r12, r8, r6, r9, r2, r3
    montgomery_mul r7, r12, r8, r7, r9, r2, r3

    str.w r4, [r14, #0]
    str.w r5, [r14, #1024]
    str.w r6, [r14, #2048]
    str.w r7, [r14, #3072]

    add.w r14, #2048

    ldr.w r4, [r14, #2048]
    ldr.w r5, [r14, #3072]

    montgomery_mul r4, r12, r8, r4, r9, r2, r3
    montgomery_mul r5, r12, r8, r5, r9, r2, r3

    str.w r4, [r14, #2048]
    str.w r5, [r14, #3072]

    sub.w r14, #2048

// ================================

    ldr.w r4, [r14, #0]
    ldr.w r5, [r14, #256]
    ldr.w r6, [r14, #512]
    ldr.w r7, [r14, #768]
    ldr.w r8, [r14, #1024]
    ldr.w r9, [r14, #1280]
    ldr.w r10, [r14, #1536]
    ldr.w r11, [r14, #1792]

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #0]
    str.w r5, [r14, #256]
    str.w r6, [r14, #512]
    str.w r7, [r14, #768]
    str.w r8, [r14, #1024]
    str.w r9, [r14, #1280]
    str.w r10, [r14, #1536]
    str.w r11, [r14, #1792]

// ================================

    ldr.w r4, [r14, #2048]
    ldr.w r5, [r14, #2304]
    ldr.w r6, [r14, #2560]
    ldr.w r7, [r14, #2816]
    ldr.w r8, [r14, #3072]
    ldr.w r9, [r14, #3328]
    ldr.w r10, [r14, #3584]
    ldr.w r11, [r14, #3840]

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #2048]
    str.w r5, [r14, #2304]
    str.w r6, [r14, #2560]
    str.w r7, [r14, #2816]
    str.w r8, [r14, #3072]
    str.w r9, [r14, #3328]
    str.w r10, [r14, #3584]
    str.w r11, [r14, #3840]

    add.w r14, #4096

// ================================

    ldr.w r4, [r14, #0]
    ldr.w r5, [r14, #256]
    ldr.w r6, [r14, #512]
    ldr.w r7, [r14, #768]
    ldr.w r8, [r14, #1024]
    ldr.w r9, [r14, #1280]
    ldr.w r10, [r14, #1536]
    ldr.w r11, [r14, #1792]

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #0]
    str.w r5, [r14, #256]
    str.w r6, [r14, #512]
    str.w r7, [r14, #768]
    str.w r8, [r14, #1024]
    str.w r9, [r14, #1280]
    str.w r10, [r14, #1536]
    str.w r11, [r14, #1792]

// ================================

    sub.w r14, #4092

    add.w r0, r14, #252

    vmov.w s0, r0

    third_inv_3_layer_loop:

    vmov.w r1, s1
    vldm.w r1!, {s9-s15}
    vmov.w s1, r1

// ================================

    ldr.w r4, [r14, #0]
    ldr.w r5, [r14, #256]
    ldr.w r6, [r14, #512]
    ldr.w r7, [r14, #768]
    ldr.w r8, [r14, #1024]
    ldr.w r9, [r14, #1280]
    ldr.w r10, [r14, #1536]
    ldr.w r11, [r14, #1792]

    vmov.w r12, s9
    montgomery_mul r5, r12, r0, r5, r1, r2, r3
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r9, r12, r0, r9, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s10
    montgomery_mul r6, r12, r0, r6, r1, r2, r3
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    vmov.w r12, s12
    montgomery_mul r8, r12, r0, r8, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s14
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #0]
    str.w r5, [r14, #256]
    str.w r6, [r14, #512]
    str.w r7, [r14, #768]
    str.w r8, [r14, #1024]
    str.w r9, [r14, #1280]
    str.w r10, [r14, #1536]
    str.w r11, [r14, #1792]

// ================================

    ldr.w r4, [r14, #2048]
    ldr.w r5, [r14, #2304]
    ldr.w r6, [r14, #2560]
    ldr.w r7, [r14, #2816]
    ldr.w r8, [r14, #3072]
    ldr.w r9, [r14, #3328]
    ldr.w r10, [r14, #3584]
    ldr.w r11, [r14, #3840]

    vmov.w r12, s9
    montgomery_mul r5, r12, r0, r5, r1, r2, r3
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r9, r12, r0, r9, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s10
    montgomery_mul r6, r12, r0, r6, r1, r2, r3
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    vmov.w r12, s12
    montgomery_mul r8, r12, r0, r8, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s14
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #2048]
    str.w r5, [r14, #2304]
    str.w r6, [r14, #2560]
    str.w r7, [r14, #2816]
    str.w r8, [r14, #3072]
    str.w r9, [r14, #3328]
    str.w r10, [r14, #3584]
    str.w r11, [r14, #3840]

    add.w r14, #4096

// ================================

    ldr.w r4, [r14, #0]
    ldr.w r5, [r14, #256]
    ldr.w r6, [r14, #512]
    ldr.w r7, [r14, #768]
    ldr.w r8, [r14, #1024]
    ldr.w r9, [r14, #1280]
    ldr.w r10, [r14, #1536]
    ldr.w r11, [r14, #1792]

    vmov.w r12, s9
    montgomery_mul r5, r12, r0, r5, r1, r2, r3
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r9, r12, r0, r9, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, s10
    montgomery_mul r6, r12, r0, r6, r1, r2, r3
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s11
    montgomery_mul r7, r12, r0, r7, r1, r2, r3
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11

    vmov.w r12, s12
    montgomery_mul r8, r12, r0, r8, r1, r2, r3

    vmov.w r12, s13
    montgomery_mul r9, r12, r0, r9, r1, r2, r3

    vmov.w r12, s14
    montgomery_mul r10, r12, r0, r10, r1, r2, r3

    vmov.w r12, s15
    montgomery_mul r11, r12, r0, r11, r1, r2, r3

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    str.w r4, [r14, #0]
    str.w r5, [r14, #256]
    str.w r6, [r14, #512]
    str.w r7, [r14, #768]
    str.w r8, [r14, #1024]
    str.w r9, [r14, #1280]
    str.w r10, [r14, #1536]
    str.w r11, [r14, #1792]

// ================================

    sub.w r14, #4092

    vmov.w r0, s0
    cmp.w r0, r14
    bne.w third_inv_3_layer_loop

    pop.w {r4-r12, pc}

