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
.endm

.syntax unified
.cpu cortex-m4

.align 2
.global NTT_forward
.type NTT_forward, %function

// r0 --> src
// r1 --> root
// r2 --> M
// r3 --> M_inv
// sp --> dest

NTT_forward:
push.w {r4-r12, r14}
vldr.w s8, [sp, #40]
vldm.w r1!, {s0-s6}
vmov.w s7, r1

.align 2
_1_2_3:

// s7 --> root
// s8 --> dest
// s10 --> outer counter
// s11 --> inner counter

add.w r12, r0, #1536 // set outer counter
vmov.w s10, r12

// 828 bytes
.align 2
outer_loop_1_2_3:

    add.w r12, r0, #64 // set inner counter
    vmov.w s11, r12

    inner_loop_1_2_3:

        ldrsh.w r4, [r0, #0]
        ldrsh.w r5, [r0, #64]
        ldrsh.w r6, [r0, #128]
        ldrsh.w r7, [r0, #192]
        ldrsh.w r8, [r0, #256]
        ldrsh.w r9, [r0, #320]
        ldrsh.w r10, [r0, #384]
        ldrsh.w r11, [r0, #448]

        // level 1
        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        // level 2
        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        // level 3
        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r1, s8
        str.w r4, [r1, #0]
        str.w r5, [r1, #128]
        str.w r6, [r1, #256]
        str.w r7, [r1, #384]
        str.w r8, [r1, #512]
        str.w r9, [r1, #640]
        str.w r10, [r1, #768]
        str.w r11, [r1, #896]

        ldrsh.w r4, [r0, #2]
        ldrsh.w r5, [r0, #66]
        ldrsh.w r6, [r0, #130]
        ldrsh.w r7, [r0, #194]
        ldrsh.w r8, [r0, #258]
        ldrsh.w r9, [r0, #322]
        ldrsh.w r10, [r0, #386]
        ldrsh.w r11, [r0, #450]

        // level 1
        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        // level 2
        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        // level 3
        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r1, s8
        str.w r4, [r1, #4]
        str.w r5, [r1, #132]
        str.w r6, [r1, #260]
        str.w r7, [r1, #388]
        str.w r8, [r1, #516]
        str.w r9, [r1, #644]
        str.w r10, [r1, #772]
        str.w r11, [r1, #900]

        add.w r1, #8
        vmov.w s8, r1

        add.w r0, #4
        vmov.w r5, s11
        cmp.w r0, r5
        bne.w inner_loop_1_2_3

    vmov.w r1, s8
    add.w r1, #896
    vmov.w s8, r1
    add.w r0, #448
    vmov.w r5, s10
    cmp.w r0, r5
    bne.w outer_loop_1_2_3

.align 2
_4_5_6:

vmov.w r0, s8
sub.w r0, #3072 // reset pointer
add.w r1, r0, #1024   // outer iteration set counter
vmov.w s10, r1

// 976 bytes
.align 2
normal_4_5_6_outer:
    vmov.w r1, s7
    vldm.w r1!, {s0-s6}
    vmov.w s7, r1

    add.w r4, r0, #16 // inner iteration set counter
    vmov.w s11, r4

    normal_4_5_6_inner:

        ldr.w r4, [r0, #0]
        ldr.w r5, [r0, #16]
        ldr.w r6, [r0, #32]
        ldr.w r7, [r0, #48]
        ldr.w r8, [r0, #64]
        ldr.w r9, [r0, #80]
        ldr.w r10, [r0, #96]
        ldr.w r11, [r0, #112]

        // level 4
        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        // level 5
        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        // level 6
        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r5, r6, r7, r8, r9, r10, r11

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

        // level 4
        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        // level 5
        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        // level 6
        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r5, r6, r7, r8, r9, r10, r11

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

        // level 4
        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        // level 5
        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        // level 6
        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r5, r6, r7, r8, r9, r10, r11

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
        bne.w normal_4_5_6_inner

    add.w r0, #112
    vmov.w r4, s10
    cmp.w r4, r0
    bne.w normal_4_5_6_outer

pop.w {r4-r12, pc}

