.macro montgomery_mul a, b, lower, upper, tmp, M_inv, M
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \lower, \M_inv
    smlal.w \lower, \upper, \tmp, \M
.endm

.macro add_sub a0, b0, a1, b1, a2, b2, a3, b3
    add \a0, \b0
    add \a1, \b1
    add \a2, \b2
    add \a3, \b3
    sub.w \b0, \a0, \b0, lsl #1
    sub.w \b1, \a1, \b1, lsl #1
    sub.w \b2, \a2, \b2, lsl #1
    sub.w \b3, \a3, \b3, lsl #1
.endm

.macro central_reduce target, Mhalf, M
    cmp \target, \Mhalf
    it hi
    subhi \target, \M
    cmn \target, \Mhalf
    it lt
    addlt \target, \M
.endm

.syntax unified
.cpu cortex-m4

// gentleman
// r0 -> src
// r1 -> root
// r2 -> M
// r3 -> M_inv
// sp -> output
// sp + 4 --> 8191

.align 2
.global NTT_inv
.type NTT_inv, %function
NTT_inv:

// s9 --> root
// s12 --> output
// s13 --> 8191

push.w {r4-r12, lr}
vldr.w s12, [sp, #40]
vldr.w s13, [sp, #44]
vmov.w s9, r1

.align 2
_6_5_4:

add.w r1, r0, #1024   // outer iteration set counter
vmov.w s10, r1

// 976 bytes
.align 2
normal_6_5_4_outer:
    vmov.w r1, s9
    vldm.w r1!, {s0-s6}
    vmov.w s9, r1

    add.w r4, r0, #16 // inner iteration set counter
    vmov.w s11, r4

    normal_6_5_4_inner:

        ldr.w r4, [r0, #0]
        ldr.w r5, [r0, #16]
        ldr.w r6, [r0, #32]
        ldr.w r7, [r0, #48]
        ldr.w r8, [r0, #64]
        ldr.w r9, [r0, #80]
        ldr.w r10, [r0, #96]
        ldr.w r11, [r0, #112]

        // level 6
        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 5
        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 4
        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // save
        str.w r4, [r0, #0]
        str.w r5, [r0, #16]
        str.w r6, [r0, #32]
        str.w r7, [r0, #48]
        str.w r8, [r0, #64]
        str.w r9, [r0, #80]
        str.w r10, [r0, #96]
        str.w r11, [r0, #112]

        ldr.w r4, [r0, #1024]
        ldr.w r5, [r0, #1040]
        ldr.w r6, [r0, #1056]
        ldr.w r7, [r0, #1072]
        ldr.w r8, [r0, #1088]
        ldr.w r9, [r0, #1104]
        ldr.w r10, [r0, #1120]
        ldr.w r11, [r0, #1136]

        // level 6
        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 5
        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 4
        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // save
        str.w r4, [r0, #1024]
        str.w r5, [r0, #1040]
        str.w r6, [r0, #1056]
        str.w r7, [r0, #1072]
        str.w r8, [r0, #1088]
        str.w r9, [r0, #1104]
        str.w r10, [r0, #1120]
        str.w r11, [r0, #1136]

        ldr.w r4, [r0, #2048]
        ldr.w r5, [r0, #2064]
        ldr.w r6, [r0, #2080]
        ldr.w r7, [r0, #2096]
        ldr.w r8, [r0, #2112]
        ldr.w r9, [r0, #2128]
        ldr.w r10, [r0, #2144]
        ldr.w r11, [r0, #2160]

        // level 6
        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 5
        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 4
        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // save
        str.w r4, [r0, #2048]
        str.w r5, [r0, #2064]
        str.w r6, [r0, #2080]
        str.w r7, [r0, #2096]
        str.w r8, [r0, #2112]
        str.w r9, [r0, #2128]
        str.w r10, [r0, #2144]
        str.w r11, [r0, #2160]

        add.w r0, #4
        vmov.w r4, s11
        cmp.w r4, r0
        bne.w normal_6_5_4_inner

    add.w r0, #112
    vmov.w r4, s10
    cmp.w r4, r0
    bne.w normal_6_5_4_outer

sub.w r0, #1024
vmov.w r4, s9
vldm.w r4, {s0-s8}

add.w r12, r0, #3072 // set outer counter
vmov.w s10, r12

// avoid overflow
vmov.w r1, s8
ldr.w r4, [r0, #0]
ldr.w r8, [r0, #512]
ldr.w r5, [r0, #1024]
ldr.w r9, [r0, #1536]
ldr.w r6, [r0, #2048]
ldr.w r10, [r0, #2560]
montgomery_mul r4, r1, r12, r4, r14, r3, r2
montgomery_mul r8, r1, r12, r8, r14, r3, r2
montgomery_mul r5, r1, r12, r5, r14, r3, r2
montgomery_mul r9, r1, r12, r9, r14, r3, r2
montgomery_mul r6, r1, r12, r6, r14, r3, r2
montgomery_mul r10, r1, r12, r10, r14, r3, r2
str.w r4, [r0, #0]
str.w r8, [r0, #512]
str.w r5, [r0, #1024]
str.w r9, [r0, #1536]
str.w r6, [r0, #2048]
str.w r10, [r0, #2560]

// 988 bytes
.align 2
_3_2_1:
outer_loop_3_2_1:
    add.w r12, r0, #128 // set inner counter
    vmov.w s11, r12

    .align 2
    inner_loop_3_2_1:

        ldr.w r4, [r0, #0]
        ldr.w r5, [r0, #128]
        ldr.w r6, [r0, #256]
        ldr.w r7, [r0, #384]
        ldr.w r8, [r0, #512]
        ldr.w r9, [r0, #640]
        ldr.w r10, [r0, #768]
        ldr.w r11, [r0, #896]

        // level 3
        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 2
        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 1
        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        vmov.w r1, s7 // 1/N
        montgomery_mul r4, r1, r12, r4, r14, r3, r2
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2

        // reduce and back to unsigned
        mov.w r1, r2, lsr #1  // Mhalf
        central_reduce r4, r1, r2
        central_reduce r5, r1, r2
        central_reduce r6, r1, r2
        central_reduce r7, r1, r2
        central_reduce r8, r1, r2
        central_reduce r9, r1, r2
        central_reduce r10, r1, r2
        central_reduce r11, r1, r2

        // & lower 13 bits
        vmov.w r1, s13
        and.w r4, r4, r1
        and.w r5, r5, r1
        and.w r6, r6, r1
        and.w r7, r7, r1
        and.w r8, r8, r1
        and.w r9, r9, r1
        and.w r10, r10, r1
        and.w r11, r11, r1

        vmov.w r1, s12
        strh.w r4, [r1, #0]
        strh.w r5, [r1, #64]
        strh.w r6, [r1, #128]
        strh.w r7, [r1, #192]
        strh.w r8, [r1, #256]
        strh.w r9, [r1, #320]
        strh.w r10, [r1, #384]
        strh.w r11, [r1, #448]

        add.w r1, #2
        vmov.w s12, r1

        add.w r0, #4
        vmov.w r5, s11
        cmp.w r0, r5
        bne.w inner_loop_3_2_1

    vmov.w r1, s12
    add.w r1, #448
    vmov.w s12, r1
    add.w r0, #896
    vmov.w r5, s10
    cmp.w r0, r5
    bne.w outer_loop_3_2_1

pop.w {r4-r12, pc}

