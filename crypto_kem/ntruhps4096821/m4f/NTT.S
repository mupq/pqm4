
.syntax unified
.cpu cortex-m4

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

.align 8
.global __asm_forward_NTT_6layers
.type __asm_forward_NTT_6layers, %function
__asm_forward_NTT_6layers:
    push.w {r4-r12, lr}

    src                          .req r0
    M                            .req r1
    Mprime                       .req r2
    t_a0                         .req r3
    t_a24                        .req r4
    t_a48                        .req r5
    t_a72                        .req r6
    t_a96                        .req r7
    t_a120                       .req r8
    t_a144                       .req r9
    t_a168                       .req r10
    temp                         .req r11
    lower                        .req r12
    ctemp                        .req r14

    s_root_table                 .req s15
    s_counter                    .req s14
    s_origin_src                 .req s13
    s_outer_counter              .req s12

    vmov.w s_root_table, r3

    add.w temp, src, #6912
    vmov.w s_outer_counter, temp

    forward_nine_6_5_4_loop:

    vmov.w temp, s_root_table
    vldm.w temp!, {s0-s6}
    vmov.w s_root_table, temp

    add.w temp, src, #96
    vmov.w s_counter, temp

    forward_6_5_4_loop:

        ldr.w t_a0, [src, #8]
        ldr.w t_a24, [src, #104]
        ldr.w t_a48, [src, #200]
        ldr.w t_a72, [src, #296]
        ldr.w t_a96, [src, #392]
        ldr.w t_a120, [src, #488]
        ldr.w t_a144, [src, #584]
        ldr.w t_a168, [src, #680]

        //level 6
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a96, lower, t_a96, temp, Mprime, M
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M
        add_sub t_a0, t_a96, t_a24, t_a120, t_a48, t_a144, t_a72, t_a168

        //level 5
        vmov.w ctemp, s1
        montgomery_mul ctemp, t_a48, lower, t_a48, temp, Mprime, M
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M
        add_sub t_a0, t_a48, t_a24, t_a72, t_a96, t_a144, t_a120, t_a168

        //level 4
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a24, lower, t_a24, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M
        add_sub t_a0, t_a24, t_a48, t_a72, t_a96, t_a120, t_a144, t_a168

        str.w t_a24, [src, #104]
        str.w t_a48, [src, #200]
        str.w t_a72, [src, #296]
        str.w t_a96, [src, #392]
        str.w t_a120, [src, #488]
        str.w t_a144, [src, #584]
        str.w t_a168, [src, #680]
        str.w t_a0, [src, #8]

        ldr.w t_a0, [src, #4]
        ldr.w t_a24, [src, #100]
        ldr.w t_a48, [src, #196]
        ldr.w t_a72, [src, #292]
        ldr.w t_a96, [src, #388]
        ldr.w t_a120, [src, #484]
        ldr.w t_a144, [src, #580]
        ldr.w t_a168, [src, #676]

        //level 6
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a96, lower, t_a96, temp, Mprime, M
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M
        add_sub t_a0, t_a96, t_a24, t_a120, t_a48, t_a144, t_a72, t_a168

        //level 5
        vmov.w ctemp, s1
        montgomery_mul ctemp, t_a48, lower, t_a48, temp, Mprime, M
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M
        add_sub t_a0, t_a48, t_a24, t_a72, t_a96, t_a144, t_a120, t_a168

        //level 4
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a24, lower, t_a24, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M
        add_sub t_a0, t_a24, t_a48, t_a72, t_a96, t_a120, t_a144, t_a168

        str.w t_a24, [src, #100]
        str.w t_a48, [src, #196]
        str.w t_a72, [src, #292]
        str.w t_a96, [src, #388]
        str.w t_a120, [src, #484]
        str.w t_a144, [src, #580]
        str.w t_a168, [src, #676]
        str.w t_a0, [src, #4]

        ldr.w t_a0, [src, #0]
        ldr.w t_a24, [src, #96]
        ldr.w t_a48, [src, #192]
        ldr.w t_a72, [src, #288]
        ldr.w t_a96, [src, #384]
        ldr.w t_a120, [src, #480]
        ldr.w t_a144, [src, #576]
        ldr.w t_a168, [src, #672]

        //level 6
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a96, lower, t_a96, temp, Mprime, M
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M
        add_sub t_a0, t_a96, t_a24, t_a120, t_a48, t_a144, t_a72, t_a168

        //level 5
        vmov.w ctemp, s1
        montgomery_mul ctemp, t_a48, lower, t_a48, temp, Mprime, M
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M
        add_sub t_a0, t_a48, t_a24, t_a72, t_a96, t_a144, t_a120, t_a168

        //level 4
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a24, lower, t_a24, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M
        add_sub t_a0, t_a24, t_a48, t_a72, t_a96, t_a120, t_a144, t_a168

        str.w t_a24, [src, #96]
        str.w t_a48, [src, #192]
        str.w t_a72, [src, #288]
        str.w t_a96, [src, #384]
        str.w t_a120, [src, #480]
        str.w t_a144, [src, #576]
        str.w t_a168, [src, #672]
        str.w t_a0, [src], #12

        vmov.w temp, s_counter
        cmp.w src, temp
        bne.w forward_6_5_4_loop

    add.w src, #672

    vmov.w temp, s_outer_counter
    cmp.w src, temp
    bne.w forward_nine_6_5_4_loop

    sub.w src, #6912

    //3, 2, 1

    src                          .req r0  @already defined
    M                            .req r1  @already defined
    Mprime                       .req r2  @already defined
    t_a0                         .req r3
    t_a3                         .req r4
    t_a6                         .req r5
    t_a9                         .req r6
    t_a12                        .req r7
    t_a15                        .req r8
    t_a18                        .req r9
    t_a21                        .req r10
    temp                         .req r11 @already defined
    lower                        .req r12 @already defined
    ctemp                        .req r14 @already defined

    s_root_table                 .req s15 @already defined
    s_counter                    .req s14 @already defined
    s_origin_src                 .req s13 @already defined


    forward_3_2_1_loop:
        vmov.w temp, s_root_table
        vldm.w temp!, {s0-s6}
        vmov.w s_root_table, temp

        ldr t_a0, [src, #8]
        ldr t_a3, [src, #20]
        ldr t_a6, [src, #32]
        ldr t_a9, [src, #44]
        ldr.w t_a12, [src, #56]
        ldr.w t_a15, [src, #68]
        ldr.w t_a18, [src, #80]
        ldr.w t_a21, [src, #92]

        //level 3
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a12, lower, t_a12, temp, Mprime, M
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M
        add_sub t_a0, t_a12, t_a3, t_a15, t_a6, t_a18, t_a9, t_a21

        //level 2
        vmov.w  ctemp, s1
        montgomery_mul ctemp, t_a6, lower, t_a6, temp, Mprime, M
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M
        add_sub t_a0, t_a6, t_a3, t_a9, t_a12, t_a18, t_a15, t_a21

        //level 1
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a3, lower, t_a3, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M
        add_sub t_a0, t_a3, t_a6, t_a9, t_a12, t_a15, t_a18, t_a21


        str.w t_a12, [src, #56]
        str.w t_a15, [src, #68]
        str.w t_a18, [src, #80]
        str.w t_a21, [src, #92]
        str t_a3, [src, #20]
        str t_a6, [src, #32]
        str t_a9, [src, #44]
        str t_a0, [src, #8]

        ldr t_a0, [src, #4]
        ldr t_a3, [src, #16]
        ldr t_a6, [src, #28]
        ldr t_a9, [src, #40]
        ldr.w t_a12, [src, #52]
        ldr.w t_a15, [src, #64]
        ldr.w t_a18, [src, #76]
        ldr.w t_a21, [src, #88]

        //level 3
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a12, lower, t_a12, temp, Mprime, M
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M
        add_sub t_a0, t_a12, t_a3, t_a15, t_a6, t_a18, t_a9, t_a21

        //level 2
        vmov.w  ctemp, s1
        montgomery_mul ctemp, t_a6, lower, t_a6, temp, Mprime, M
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M
        add_sub t_a0, t_a6, t_a3, t_a9, t_a12, t_a18, t_a15, t_a21

        //level 1
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a3, lower, t_a3, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M
        add_sub t_a0, t_a3, t_a6, t_a9, t_a12, t_a15, t_a18, t_a21


        str.w t_a12, [src, #52]
        str.w t_a15, [src, #64]
        str.w t_a18, [src, #76]
        str.w t_a21, [src, #88]
        str t_a3, [src, #16]
        str t_a6, [src, #28]
        str t_a9, [src, #40]
        str t_a0, [src, #4]

        ldr t_a0, [src, #0]
        ldr t_a3, [src, #12]
        ldr t_a6, [src, #24]
        ldr t_a9, [src, #36]
        ldr.w t_a12, [src, #48]
        ldr.w t_a15, [src, #60]
        ldr.w t_a18, [src, #72]
        ldr.w t_a21, [src, #84]

        //level 3
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a12, lower, t_a12, temp, Mprime, M
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M
        add_sub t_a0, t_a12, t_a3, t_a15, t_a6, t_a18, t_a9, t_a21

        //level 2
        vmov.w  ctemp, s1
        montgomery_mul ctemp, t_a6, lower, t_a6, temp, Mprime, M
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M
        add_sub t_a0, t_a6, t_a3, t_a9, t_a12, t_a18, t_a15, t_a21

        //level 1
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a3, lower, t_a3, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M
        add_sub t_a0, t_a3, t_a6, t_a9, t_a12, t_a15, t_a18, t_a21


        str.w t_a12, [src, #48]
        str.w t_a15, [src, #60]
        str.w t_a18, [src, #72]
        str.w t_a21, [src, #84]
        str.w t_a3, [src, #12]
        str.w t_a6, [src, #24]
        str.w t_a9, [src, #36]
        str.w t_a0, [src], #96

        vmov.w temp, s_outer_counter
        cmp.w src, temp
        bne.w forward_3_2_1_loop

    pop.w {r4-r12, pc}

.align 8
.global __asm_inv_NTT_6layers
.type __asm_inv_NTT_6layers, %function
__asm_inv_NTT_6layers:
    push.w {r4-r12, lr}
    //1, 2, 3

    src                          .req r0  @already defined
    M                            .req r1  @already defined
    Mprime                       .req r2  @already defined
    t_a0                         .req r3  @already defined
    t_a3                         .req r4  @already defined
    t_a6                         .req r5  @already defined
    t_a9                         .req r6  @already defined
    t_a12                        .req r7  @already defined
    t_a15                        .req r8  @already defined
    t_a18                        .req r9  @already defined
    t_a21                        .req r10 @already defined
    temp                         .req r11 @already defined
    lower                        .req r12 @already defined
    ctemp                        .req r14 @already defined

    s_root_table                 .req s15 @already defined
    s_counter                    .req s14 @already defined
    s_origin_src                 .req s13 @already defined


    vmov.w s_root_table, r3

    add.w temp, src, #6912
    vmov.w s_outer_counter, temp

    inv_1_2_3_loop:
        vmov.w temp, s_root_table
        vldm.w temp!, {s0-s6}
        vmov.w s_root_table, temp

        ldr t_a0, [src, #8]
        ldr t_a3, [src, #20]
        ldr t_a6, [src, #32]
        ldr t_a9, [src, #44]
        ldr.w t_a12, [src, #56]
        ldr.w t_a15, [src, #68]
        ldr.w t_a18, [src, #80]
        ldr.w t_a21, [src, #92]

        //level 1
        add_sub t_a0, t_a3, t_a6, t_a9, t_a12, t_a15, t_a18, t_a21
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a3, lower, t_a3, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M

        //level 2
        add_sub t_a0, t_a6, t_a3, t_a9, t_a12, t_a18, t_a15, t_a21
        vmov.w  ctemp, s1
        montgomery_mul ctemp, t_a6, lower, t_a6, temp, Mprime, M
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M

        //level 3
        add_sub t_a0, t_a12, t_a3, t_a15, t_a6, t_a18, t_a9, t_a21
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a12, lower, t_a12, temp, Mprime, M
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M

        str.w t_a12, [src, #56]
        str.w t_a15, [src, #68]
        str.w t_a18, [src, #80]
        str.w t_a21, [src, #92]
        str t_a3, [src, #20]
        str t_a6, [src, #32]
        str t_a9, [src, #44]
        str t_a0, [src, #8]

        ldr t_a0, [src, #4]
        ldr t_a3, [src, #16]
        ldr t_a6, [src, #28]
        ldr t_a9, [src, #40]
        ldr.w t_a12, [src, #52]
        ldr.w t_a15, [src, #64]
        ldr.w t_a18, [src, #76]
        ldr.w t_a21, [src, #88]

        //level 1
        add_sub t_a0, t_a3, t_a6, t_a9, t_a12, t_a15, t_a18, t_a21
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a3, lower, t_a3, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M

        //level 2
        add_sub t_a0, t_a6, t_a3, t_a9, t_a12, t_a18, t_a15, t_a21
        vmov.w  ctemp, s1
        montgomery_mul ctemp, t_a6, lower, t_a6, temp, Mprime, M
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M

        //level 3
        add_sub t_a0, t_a12, t_a3, t_a15, t_a6, t_a18, t_a9, t_a21
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a12, lower, t_a12, temp, Mprime, M
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M

        str.w t_a12, [src, #52]
        str.w t_a15, [src, #64]
        str.w t_a18, [src, #76]
        str.w t_a21, [src, #88]
        str t_a3, [src, #16]
        str t_a6, [src, #28]
        str t_a9, [src, #40]
        str t_a0, [src, #4]

        ldr t_a0, [src, #0]
        ldr t_a3, [src, #12]
        ldr t_a6, [src, #24]
        ldr t_a9, [src, #36]
        ldr.w t_a12, [src, #48]
        ldr.w t_a15, [src, #60]
        ldr.w t_a18, [src, #72]
        ldr.w t_a21, [src, #84]

        //level 1
        add_sub t_a0, t_a3, t_a6, t_a9, t_a12, t_a15, t_a18, t_a21
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a3, lower, t_a3, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M

        //level 2
        add_sub t_a0, t_a6, t_a3, t_a9, t_a12, t_a18, t_a15, t_a21
        vmov.w  ctemp, s1
        montgomery_mul ctemp, t_a6, lower, t_a6, temp, Mprime, M
        montgomery_mul ctemp, t_a9, lower, t_a9, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M

        //level 3
        add_sub t_a0, t_a12, t_a3, t_a15, t_a6, t_a18, t_a9, t_a21
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a12, lower, t_a12, temp, Mprime, M
        montgomery_mul ctemp, t_a15, lower, t_a15, temp, Mprime, M
        montgomery_mul ctemp, t_a18, lower, t_a18, temp, Mprime, M
        montgomery_mul ctemp, t_a21, lower, t_a21, temp, Mprime, M

        str.w t_a12, [src, #48]
        str.w t_a15, [src, #60]
        str.w t_a18, [src, #72]
        str.w t_a21, [src, #84]
        str.w t_a3, [src, #12]
        str.w t_a6, [src, #24]
        str.w t_a9, [src, #36]
        str.w t_a0, [src], #96

        vmov.w temp, s_outer_counter
        cmp.w src, temp
        bne.w inv_1_2_3_loop

        sub.w src, #6912

    //4_5_6

    src                          .req r0
    M                            .req r1
    Mprime                       .req r2
    t_a0                         .req r3
    t_a24                        .req r4
    t_a48                        .req r5
    t_a72                        .req r6
    t_a96                        .req r7
    t_a120                       .req r8
    t_a144                       .req r9
    t_a168                       .req r10
    temp                         .req r11
    lower                        .req r12
    ctemp                        .req r14

    s_root_table                 .req s15 @already defined
    s_counter                    .req s14 @already defined
    s_origin_src                 .req s13 @already defined

    nine_inv_4_5_6_loop:

    vmov.w temp, s_root_table
    vldm.w temp!, {s0-s6}
    vmov.w s_root_table, temp

    add.w temp, src, #96
    vmov.w s_counter, temp

    inv_4_5_6_loop:

        ldr.w t_a0, [src, #8]
        ldr.w t_a24, [src, #104]
        ldr.w t_a48, [src, #200]
        ldr.w t_a72, [src, #296]
        ldr.w t_a96, [src, #392]
        ldr.w t_a120, [src, #488]
        ldr.w t_a144, [src, #584]
        ldr.w t_a168, [src, #680]

        //level 4
        add_sub t_a0, t_a24, t_a48, t_a72, t_a96, t_a120, t_a144, t_a168
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a24, lower, t_a24, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M

        //level 5
        add_sub t_a0, t_a48, t_a24, t_a72, t_a96, t_a144, t_a120, t_a168
        vmov.w ctemp, s1
        montgomery_mul ctemp, t_a48, lower, t_a48, temp, Mprime, M
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M

        //level 6
        add_sub t_a0, t_a96, t_a24, t_a120, t_a48, t_a144, t_a72, t_a168
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a96, lower, t_a96, temp, Mprime, M
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M


        str.w t_a24, [src, #104]
        str.w t_a48, [src, #200]
        str.w t_a72, [src, #296]
        str.w t_a96, [src, #392]
        str.w t_a120, [src, #488]
        str.w t_a144, [src, #584]
        str.w t_a168, [src, #680]
        str.w t_a0, [src, #8]

        ldr.w t_a0, [src, #4]
        ldr.w t_a24, [src, #100]
        ldr.w t_a48, [src, #196]
        ldr.w t_a72, [src, #292]
        ldr.w t_a96, [src, #388]
        ldr.w t_a120, [src, #484]
        ldr.w t_a144, [src, #580]
        ldr.w t_a168, [src, #676]

        //level 4
        add_sub t_a0, t_a24, t_a48, t_a72, t_a96, t_a120, t_a144, t_a168
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a24, lower, t_a24, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M

        //level 5
        add_sub t_a0, t_a48, t_a24, t_a72, t_a96, t_a144, t_a120, t_a168
        vmov.w ctemp, s1
        montgomery_mul ctemp, t_a48, lower, t_a48, temp, Mprime, M
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M

        //level 6
        add_sub t_a0, t_a96, t_a24, t_a120, t_a48, t_a144, t_a72, t_a168
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a96, lower, t_a96, temp, Mprime, M
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M


        str.w t_a24, [src, #100]
        str.w t_a48, [src, #196]
        str.w t_a72, [src, #292]
        str.w t_a96, [src, #388]
        str.w t_a120, [src, #484]
        str.w t_a144, [src, #580]
        str.w t_a168, [src, #676]
        str.w t_a0, [src, #4]

        ldr.w t_a0, [src, #0]
        ldr.w t_a24, [src, #96]
        ldr.w t_a48, [src, #192]
        ldr.w t_a72, [src, #288]
        ldr.w t_a96, [src, #384]
        ldr.w t_a120, [src, #480]
        ldr.w t_a144, [src, #576]
        ldr.w t_a168, [src, #672]

        //level 4
        add_sub t_a0, t_a24, t_a48, t_a72, t_a96, t_a120, t_a144, t_a168
        vmov.w ctemp, s3
        montgomery_mul ctemp, t_a24, lower, t_a24, temp, Mprime, M
        vmov.w ctemp, s4
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s5
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        vmov.w ctemp, s6
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M

        //level 5
        add_sub t_a0, t_a48, t_a24, t_a72, t_a96, t_a144, t_a120, t_a168
        vmov.w ctemp, s1
        montgomery_mul ctemp, t_a48, lower, t_a48, temp, Mprime, M
        montgomery_mul ctemp, t_a72, lower, t_a72, temp, Mprime, M
        vmov.w ctemp, s2
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M

        //level 6
        add_sub t_a0, t_a96, t_a24, t_a120, t_a48, t_a144, t_a72, t_a168
        vmov.w  ctemp, s0
        montgomery_mul ctemp, t_a96, lower, t_a96, temp, Mprime, M
        montgomery_mul ctemp, t_a120, lower, t_a120, temp, Mprime, M
        montgomery_mul ctemp, t_a144, lower, t_a144, temp, Mprime, M
        montgomery_mul ctemp, t_a168, lower, t_a168, temp, Mprime, M


        str.w t_a24, [src, #96]
        str.w t_a48, [src, #192]
        str.w t_a72, [src, #288]
        str.w t_a96, [src, #384]
        str.w t_a120, [src, #480]
        str.w t_a144, [src, #576]
        str.w t_a168, [src, #672]
        str.w t_a0, [src], #12

        vmov.w temp, s_counter
        cmp.w src, temp
        bne.w inv_4_5_6_loop

        add.w src, #672

    vmov.w temp, s_outer_counter
    cmp.w src, temp
    bne.w nine_inv_4_5_6_loop

    pop.w {r4-r12, pc}

