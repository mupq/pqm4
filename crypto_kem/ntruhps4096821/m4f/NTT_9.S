.macro montgomery_mul a, b, lower, upper, tmp, M_inv, M
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \r11, \M_inv
    smlal.w \lower, \upper, \tmp, \M
.endm
.macro central_reduce target, Mhalf, M
    cmp \target, \Mhalf
    it hi
    subhi \target, \M
.endm

.syntax unified
.cpu cortex-m4


root_9_table_16:
    .word -1481904 @ omega_3
    .word 980652 @ omega_6
    .word -19276 @ omega_1
    .word -1619741 @ omega_4
    .word 1587783 @ omega_7
    .word -553862 @ omega_2
    .word 1639017 @ omega_5
    .word -1033921 @ omega_8
    .word 3365569 @ MOD
    .word 1205062335 @ M_inv

// NTT_9_forward_16(int16 *input[1728], int32 *output[1728])
.global NTT_9_forward_16
.type NTT_9_forward_16, %function
NTT_9_forward_16:
    push.w {r4-r12, lr}

    in          .req r11
    out2        .req r10
    out         .req r11
    M           .req r12
    M_inv       .req r14
    counter     .req r4

    q           .req r6
    qhalf       .req r7

    tmp_counter .req s0
    tmp_in      .req s1
    tmp_out     .req s2
    tmp_out2    .req s3
    tmp_omega_3 .req s4
    tmp_omega_6 .req s5
    tmp_omega_1 .req s6
    tmp_omega_7 .req s7
    tmp_omega_8 .req s8
    tmp_omega_2 .req s9
    tmp_omega_4 .req s10
    tmp_omega_5 .req s11
    tmp2        .req s12

    vmov.w tmp_in, tmp_out, r0, r1
    add.w r7, r1, #2304
    vmov.w tmp_out2, r7
    add.w counter, r7, #208
    vmov.w tmp_counter, counter // set counter

    adr.w lr, root_9_table_16
    vldm.w lr, {tmp_omega_3-tmp_omega_5}
    ldr.w M, [lr, #32]
    ldr.w M_inv, [lr, #36]


    NTT_9_16_5_case: // 0, 192, 384, 576, 768
        vmov.w in, tmp_in
        ldrsh.w r1, [in, #386]
        ldrsh.w r2, [in, #770]
        ldrsh.w r3, [in, #1154]
        ldrsh.w r4, [in, #1538]
        ldrsh.w r0, [in, #2]

        mov.w r5, #2048
        mov.w r6, #4096
        central_reduce r0, r5, r6
        central_reduce r1, r5, r6
        central_reduce r2, r5, r6
        central_reduce r3, r5, r6
        central_reduce r4, r5, r6

        // a0_  = a0 + a3
        // a3_  = a0 + root[3]*a3
        // a6_  = a0 + root[6]*a3
        // a1_  = a1 + a4
        // a4_  = a1 + root[3]*a4
        // a7_  = a1 + root[6]*a4
        // a2_  = a2
        // a5_  = a2
        // a8_  = a2

        vmov.w r8, r9, tmp_omega_3, tmp_omega_6

    	// a5, a6, a7, a8 = 0
        add.w r5, r0, r3                  @ r5 = a0' = a0 + a3

        smull.w r11, r6, r8, r3           @ r6|r11 = a3*omega1
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a3*omega1
        add.w r6, r0                      @ r6 = a3' = a0 + a3*omega1

        smlal.w r11, r0, r9, r3           @ r0|r11 = a0 + a3*omega2
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r0, r10, M           @ r0 = a6' = a0 + a3*omega2
        // (r5, r6, r0) = (a0', a3', a6')

        add.w r3, r1, r4                  @ r3 = a1' = a1 + a4

        smull.w r11, r7, r8, r4           @ r7|r11 = a4*omega1
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r7, r10, M           @ r7 = a4*omega1
        add.w r7, r1                      @ r7 = a4' = a1 + a4*omega1

        smlal.w r11, r1, r9, r4           @ r1|r11 = a1 + a4*omega2
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r1, r10, M           @ r1 = a7' = a1 + a4*omega2
        // (r3, r7, r1) = (a1', a4', a7')

        @  (r2, r2, r2) = (a2', a5', a8')
        @ (a0_, a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r5,  r3,  r2,  r6,  r7,  r2,  r0,  r1,  r2)

        // a0__ = a0_ + a1_ + a2_
        // a1__ = a0_ + root[3]*a1_ + root[6]*a2_
        // a2__ = a0_ + root[6]*a1_ + root[3]*a2_
        // a3__ = a3_ + root[1]*a4_ + root[2]*a5_
        // a4__ = a3_ + root[4]*a4_ + root[8]*a5_
        // a5__ = a3_ + root[7]*a4_ + root[5]*a5_
        // a6__ = a6_ + root[2]*a7_ + root[4]*a8_
        // a7__ = a6_ + root[5]*a7_ + root[1]*a8_
        // a8__ = a6_ + root[8]*a7_ + root[7]*a8_

        // NTT-3

        // r4 available
        add.w r4, r5, r3                  @ r4 = a0' + a1'
        add.w r4, r4, r2                  @ r4 = a0'' = a0' + a1' + a2'

        // overwrite omega3, r8
        smull.w r11, r8, r3, r8           @ r8|r11 = a1'*omega3
        smlal.w r11, r8, r2, r9           @ r8|r11 = a1'*omega3 + a2'*omega6
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r8, M, r10           @ r8 = a1'*omega3 + a2'*omega6
        add.w r8, r8, r5                  @ r8 = a1'' = a0' + a1'*omega3 + a2'*omega6

        smlal.w r11, r5, r3, r9           @ r5|r11 = a0' + a1'*omega6
        vmov.w r9, tmp_omega_3            // mov back omega3
        smlal.w r11, r5, r2, r9           @ r5|r11 = a0' + a1'*omega6 + a2'*omega3
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a2'' = a0' + a1'*omega6 + a2'*omega3

        vmov.w out, tmp_out
        str.w r8, [out, #772]
        str.w r5, [out, #1540]
        str.w r4, [out, #4]


        @ (a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r2,  r6,  r7,  r2,  r0,  r1,  r2)

        // r3, r4, r5, r8, r9 available, calculate a5'' --> a8'' --> a7''
        vmov.w r5, tmp_omega_5
        vmov.w r8, r9, tmp_omega_7, tmp_omega_8
        smull.w r11, r3, r8, r7           @ r3|r11 = omega7*a4'
        smlal.w r11, r3, r5, r2           @ r3|r11 = omega7*a4' + omega5*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = omega7*a4' + omega5*a5'
        add.w r3, r3, r6                  @ r3 = a5'' = a3' + omega7*a4' + omega5*a5'

        smull.w r11, r4, r9, r1           @ r4|r11 = omega8*a7'
        smlal.w r11, r4, r8, r2           @ r4|r11 = omega8*a7' + omega7*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r4, r10, M           @ r4 = omega8*a7' + omega7*a8'
        add.w r4, r4, r0                  @ r4 = a8'' = a6' + omega8*a7' + omega7*a8'

        smull.w r11, r8, r5, r1           @ r8|r11 = omega5*a7'
        vmov.w r5, tmp_omega_1
        smlal.w r11, r8, r5, r2           @ r8|r11 = omega5*a7' + omega1*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r8, r10, M           @ r8 = omega5*a7' + omega1*a8'
        add.w r8, r8, r0                  @ r8 = a7'' = a6' + omega5*a7' + omega1*a8'

        vmov.w out2, tmp_out2
        str.w r3, [out2, #1540]
        str.w r8, [out2, #3076]
        str.w r4, [out2, #3844]

        // r3, r4, r8 available
        // r5 --> omega1, r9 --> omega8, calculate a3'' --> a4'' --> a6''
        @ (a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r2,  r6,  r7,  r2,  r0,  r1,  r2)

        vmov.w r4, r8, tmp_omega_2, tmp_omega_4

        smull.w r11, r3, r5, r7           @ r3|r11 = omega1*a4'
        smlal.w r11, r3, r4, r2           @ r3|r11 = omega1*a4' + omega2*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = omega1*a4' + omega2*a5'
        add.w r3, r3, r6                  @ r3 = a3'' = a3' + omega1*a4' + omega2*a5'

        smlal.w r11, r6, r8, r7           @ r6|r11 = a3' + omega4*a4'
        smlal.w r11, r6, r9, r2           @ r6|r11 = a3' + omega4*a4' + omega8*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a4'' = a3' + omega4*a4' + omega8*a5'

        smlal.w r11, r0, r4, r1           @ r0|r11 = a6' + omega2*a7'
        smlal.w r11, r0, r8, r2           @ r0|r11 = a6' + omega2*a7' + omega4*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r0, r10, M           @ r0 = a6'' = a6' + omega2*a7' + omega4*a8'

        vmov.w out2, tmp_out2
        str.w r6, [out2, #772]
        str.w r0, [out2, #2308]

        str.w r3, [out2, #4]

        vmov.w in, tmp_in
        ldrsh.w r1, [in, #384]
        ldrsh.w r2, [in, #768]
        ldrsh.w r3, [in, #1152]
        ldrsh.w r4, [in, #1536]
        ldrsh.w r0, [in], 4
        vmov.w tmp_in, in

        mov.w r5, #2048
        mov.w r6, #4096
        central_reduce r0, r5, r6
        central_reduce r1, r5, r6
        central_reduce r2, r5, r6
        central_reduce r3, r5, r6
        central_reduce r4, r5, r6

        // a0_  = a0 + a3
        // a3_  = a0 + root[3]*a3
        // a6_  = a0 + root[6]*a3
        // a1_  = a1 + a4
        // a4_  = a1 + root[3]*a4
        // a7_  = a1 + root[6]*a4
        // a2_  = a2
        // a5_  = a2
        // a8_  = a2

        vmov.w r8, r9, tmp_omega_3, tmp_omega_6

    	// a5, a6, a7, a8 = 0
        add.w r5, r0, r3                  @ r5 = a0' = a0 + a3

        smull.w r11, r6, r8, r3           @ r6|r11 = a3*omega1
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a3*omega1
        add.w r6, r0                      @ r6 = a3' = a0 + a3*omega1

        smlal.w r11, r0, r9, r3           @ r0|r11 = a0 + a3*omega2
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r0, r10, M           @ r0 = a6' = a0 + a3*omega2
        // (r5, r6, r0) = (a0', a3', a6')

        add.w r3, r1, r4                  @ r3 = a1' = a1 + a4

        smull.w r11, r7, r8, r4           @ r7|r11 = a4*omega1
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r7, r10, M           @ r7 = a4*omega1
        add.w r7, r1                      @ r7 = a4' = a1 + a4*omega1

        smlal.w r11, r1, r9, r4           @ r1|r11 = a1 + a4*omega2
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r1, r10, M           @ r1 = a7' = a1 + a4*omega2
        // (r3, r7, r1) = (a1', a4', a7')

        @  (r2, r2, r2) = (a2', a5', a8')
        @ (a0_, a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r5,  r3,  r2,  r6,  r7,  r2,  r0,  r1,  r2)

        // a0__ = a0_ + a1_ + a2_
        // a1__ = a0_ + root[3]*a1_ + root[6]*a2_
        // a2__ = a0_ + root[6]*a1_ + root[3]*a2_
        // a3__ = a3_ + root[1]*a4_ + root[2]*a5_
        // a4__ = a3_ + root[4]*a4_ + root[8]*a5_
        // a5__ = a3_ + root[7]*a4_ + root[5]*a5_
        // a6__ = a6_ + root[2]*a7_ + root[4]*a8_
        // a7__ = a6_ + root[5]*a7_ + root[1]*a8_
        // a8__ = a6_ + root[8]*a7_ + root[7]*a8_

        // NTT-3

        // r4 available
        add.w r4, r5, r3                  @ r4 = a0' + a1'
        add.w r4, r4, r2                  @ r4 = a0'' = a0' + a1' + a2'

        // overwrite omega3, r8
        smull.w r11, r8, r3, r8           @ r8|r11 = a1'*omega3
        smlal.w r11, r8, r2, r9           @ r8|r11 = a1'*omega3 + a2'*omega6
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r8, M, r10           @ r8 = a1'*omega3 + a2'*omega6
        add.w r8, r8, r5                  @ r8 = a1'' = a0' + a1'*omega3 + a2'*omega6

        smlal.w r11, r5, r3, r9           @ r5|r11 = a0' + a1'*omega6
        vmov.w r9, tmp_omega_3            // mov back omega3
        smlal.w r11, r5, r2, r9           @ r5|r11 = a0' + a1'*omega6 + a2'*omega3
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a2'' = a0' + a1'*omega6 + a2'*omega3

        vmov.w out, tmp_out
        str.w r8, [out, #768]
        str.w r5, [out, #1536]
        str.w r4, [out], #8
        vmov.w tmp_out, out


        @ (a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r2,  r6,  r7,  r2,  r0,  r1,  r2)

        // r3, r4, r5, r8, r9 available, calculate a5'' --> a8'' --> a7''
        vmov.w r5, tmp_omega_5
        vmov.w r8, r9, tmp_omega_7, tmp_omega_8
        smull.w r11, r3, r8, r7           @ r3|r11 = omega7*a4'
        smlal.w r11, r3, r5, r2           @ r3|r11 = omega7*a4' + omega5*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = omega7*a4' + omega5*a5'
        add.w r3, r3, r6                  @ r3 = a5'' = a3' + omega7*a4' + omega5*a5'

        smull.w r11, r4, r9, r1           @ r4|r11 = omega8*a7'
        smlal.w r11, r4, r8, r2           @ r4|r11 = omega8*a7' + omega7*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r4, r10, M           @ r4 = omega8*a7' + omega7*a8'
        add.w r4, r4, r0                  @ r4 = a8'' = a6' + omega8*a7' + omega7*a8'

        smull.w r11, r8, r5, r1           @ r8|r11 = omega5*a7'
        vmov.w r5, tmp_omega_1
        smlal.w r11, r8, r5, r2           @ r8|r11 = omega5*a7' + omega1*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r8, r10, M           @ r8 = omega5*a7' + omega1*a8'
        add.w r8, r8, r0                  @ r8 = a7'' = a6' + omega5*a7' + omega1*a8'

        vmov.w out2, tmp_out2
        str.w r3, [out2, #1536]
        str.w r8, [out2, #3072]
        str.w r4, [out2, #3840]

        // r3, r4, r8 available
        // r5 --> omega1, r9 --> omega8, calculate a3'' --> a4'' --> a6''
        @ (a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r2,  r6,  r7,  r2,  r0,  r1,  r2)

        vmov.w r4, r8, tmp_omega_2, tmp_omega_4

        smull.w r11, r3, r5, r7           @ r3|r11 = omega1*a4'
        smlal.w r11, r3, r4, r2           @ r3|r11 = omega1*a4' + omega2*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = omega1*a4' + omega2*a5'
        add.w r3, r3, r6                  @ r3 = a3'' = a3' + omega1*a4' + omega2*a5'

        smlal.w r11, r6, r8, r7           @ r6|r11 = a3' + omega4*a4'
        smlal.w r11, r6, r9, r2           @ r6|r11 = a3' + omega4*a4' + omega8*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a4'' = a3' + omega4*a4' + omega8*a5'

        smlal.w r11, r0, r4, r1           @ r0|r11 = a6' + omega2*a7'
        smlal.w r11, r0, r8, r2           @ r0|r11 = a6' + omega2*a7' + omega4*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r0, r10, M           @ r0 = a6'' = a6' + omega2*a7' + omega4*a8'

        vmov.w out2, tmp_out2
        str.w r6, [out2, #768]
        str.w r0, [out2, #2304]

        str.w r3, [out2], #8
        vmov.w tmp_out2, out2

        vmov.w counter, tmp_counter
       	cmp.w counter, out2
       	bne.w NTT_9_16_5_case

    vmov.w in, tmp_in
    ldrsh.w r1, [in, #384]
    ldrsh.w r2, [in, #768]
    ldrsh.w r3, [in, #1152]
    ldrsh.w r4, [in, #1536]
    ldrsh.w r0, [in], #2
    vmov.w tmp_in, in

    mov.w r10, #2048
    mov.w r11, #4096
    central_reduce r0, r10, r11
    central_reduce r1, r10, r11
    central_reduce r2, r10, r11
    central_reduce r3, r10, r11
    central_reduce r4, r10, r11

    vmov.w r8, r9, tmp_omega_3, tmp_omega_6

    add.w r5, r0, r3                  @ r5 = a0' = a0 + a3

    smull.w r11, r6, r8, r3           @ r6|r11 = a3*omega1
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r6, r10, M           @ r6 = a3*omega1
    add.w r6, r0                      @ r6 = a3' = a0 + a3*omega1

    smlal.w r11, r0, r9, r3           @ r0|r11 = a0 + a3*omega2
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r0, r10, M           @ r0 = a6' = a0 + a3*omega2

    add.w r3, r1, r4                  @ r3 = a1' = a1 + a4

    smull.w r11, r7, r8, r4           @ r7|r11 = a4*omega1
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r7, r10, M           @ r7 = a4*omega1
    add.w r7, r1                      @ r7 = a4' = a1 + a4*omega1

    smlal.w r11, r1, r9, r4           @ r1|r11 = a1 + a4*omega2
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r1, r10, M           @ r1 = a7' = a1 + a4*omega2

    add.w r4, r5, r3                  @ r4 = a0' + a1'
    add.w r4, r4, r2                  @ r4 = a0'' = a0' + a1' + a2'

    smull.w r11, r8, r3, r8           @ r8|r11 = a1'*omega3
    smlal.w r11, r8, r2, r9           @ r8|r11 = a1'*omega3 + a2'*omega6
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r8, M, r10           @ r8 = a1'*omega3 + a2'*omega6
    add.w r8, r8, r5                  @ r8 = a1'' = a0' + a1'*omega3 + a2'*omega6

    smlal.w r11, r5, r3, r9           @ r5|r11 = a0' + a1'*omega6
    vmov.w r9, tmp_omega_3            // mov back omega3
    smlal.w r11, r5, r2, r9           @ r5|r11 = a0' + a1'*omega6 + a2'*omega3
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r5, r10, M           @ r5 = a2'' = a0' + a1'*omega6 + a2'*omega3

    vmov.w out, tmp_out
    str.w r8, [out, #768]
    str.w r5, [out, #1536]
    str.w r4, [out], #4
    vmov.w tmp_out, out

    vmov.w r5, tmp_omega_5
    vmov.w r8, r9, tmp_omega_7, tmp_omega_8
    smull.w r11, r3, r8, r7           @ r3|r11 = omega7*a4'
    smlal.w r11, r3, r5, r2           @ r3|r11 = omega7*a4' + omega5*a5'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r3, r10, M           @ r3 = omega7*a4' + omega5*a5'
    add.w r3, r3, r6                  @ r3 = a5'' = a3' + omega7*a4' + omega5*a5'

    smull.w r11, r4, r9, r1           @ r4|r11 = omega8*a7'
    smlal.w r11, r4, r8, r2           @ r4|r11 = omega8*a7' + omega7*a8'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r4, r10, M           @ r4 = omega8*a7' + omega7*a8'
    add.w r4, r4, r0                  @ r4 = a8'' = a6' + omega8*a7' + omega7*a8'

    smull.w r11, r8, r5, r1           @ r8|r11 = omega5*a7'
    vmov.w r5, tmp_omega_1
    smlal.w r11, r8, r5, r2           @ r8|r11 = omega5*a7' + omega1*a8'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r8, r10, M           @ r8 = omega5*a7' + omega1*a8'
    add.w r8, r8, r0                  @ r8 = a7'' = a6' + omega5*a7' + omega1*a8'

    vmov.w out2, tmp_out2
    str.w r3, [out2, #1536]
    str.w r8, [out2, #3072]
    str.w r4, [out2, #3840]

    vmov.w r4, r8, tmp_omega_2, tmp_omega_4

    smull.w r11, r3, r5, r7           @ r3|r11 = omega1*a4'
    smlal.w r11, r3, r4, r2           @ r3|r11 = omega1*a4' + omega2*a5'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r3, r10, M           @ r3 = omega1*a4' + omega2*a5'
    add.w r3, r3, r6                  @ r3 = a3'' = a3' + omega1*a4' + omega2*a5'

    smlal.w r11, r6, r8, r7           @ r6|r11 = a3' + omega4*a4'
    smlal.w r11, r6, r9, r2           @ r6|r11 = a3' + omega4*a4' + omega8*a5'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r6, r10, M           @ r6 = a4'' = a3' + omega4*a4' + omega8*a5'

    smlal.w r11, r0, r4, r1           @ r0|r11 = a6' + omega2*a7'
    smlal.w r11, r0, r8, r2           @ r0|r11 = a6' + omega2*a7' + omega4*a8'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r0, r10, M           @ r0 = a6'' = a6' + omega2*a7' + omega4*a8'

    vmov.w out2, tmp_out2
    str.w r6, [out2, #768]
    str.w r0, [out2, #2304]
    str.w r3, [out2], #4
    vmov.w tmp_out2, out2

    add.w counter, out2, #552
    vmov.w tmp_counter, counter // set counter

    NTT_9_16_4_case: // 0, 192, 384, 576
        vmov.w in, tmp_in
        ldrsh.w r1, [in, #388]
        ldrsh.w r2, [in, #772]
        ldrsh.w r3, [in, #1156]
        ldrsh.w r0, [in, #4]


        mov.w r5, #2048
        mov.w r6, #4096
        central_reduce r0, r5, r6
        central_reduce r1, r5, r6
        central_reduce r2, r5, r6
        central_reduce r3, r5, r6

        // a0_  = a0 + a3
        // a3_  = a0 + root[3]*a3
        // a6_  = a0 + root[6]*a3
        // a1_  = a1
        // a4_  = a1
        // a7_  = a1
        // a2_  = a2
        // a5_  = a2
        // a8_  = a2

        vmov.w r8, r9, tmp_omega_3, tmp_omega_6

    	// a4, a5, a6, a7, a8 = 0
        add.w r5, r0, r3                  @ r5 = a0' = a0 + a3

        smull.w r11, r6, r8, r3           @ r6|r11 = a0 + a3*omega1
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a3*omega1
        add.w r6, r0                      @ r6 = a3' = a0 + a3*omega1

        smlal.w r11, r0, r9, r3           @ r0|r11 = a0 + a3*omega2
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r0, r10, M           @ r0 = a6' = a0 + a3*omega2
        // (r5, r6, r0) = (a0', a3', a6')

        @  (r1, r1, r1) = (a1', a4', a7')
        @  (r2, r2, r2) = (a2', a5', a8')
        // r3, r4, r7 available

        @  (r2, r2, r2) = (a2', a5', a8')
        @ (a0_, a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r5,  r1,  r2,  r6,  r1,  r2,  r0,  r1,  r2)

        // a0__ = a0_ + a1_ + a2_
        // a1__ = a0_ + root[3]*a1_ + root[6]*a2_
        // a2__ = a0_ + root[6]*a1_ + root[3]*a2_
        // a3__ = a3_ + root[1]*a4_ + root[2]*a5_
        // a4__ = a3_ + root[4]*a4_ + root[8]*a5_
        // a5__ = a3_ + root[7]*a4_ + root[5]*a5_
        // a6__ = a6_ + root[2]*a7_ + root[4]*a8_
        // a7__ = a6_ + root[5]*a7_ + root[1]*a8_
        // a8__ = a6_ + root[8]*a7_ + root[7]*a8_

        // NTT-3

        // r4 available
        add.w r3, r5, r1                  @ r3 = a0' + a1'
        add.w r3, r3, r2                  @ r3 = a0'' = a0' + a1' + a2'

        smull.w r11, r4, r1, r8           @ r8|r11 = a1'*omega1
        smlal.w r11, r4, r2, r9           @ r8|r11 = a1'*omega1 + a2'*omega2
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r4, M, r10           @ r8 = a1'*omega1 + a2'*omega2
        add.w r4, r4, r5                  @ r8 = a1'' = a0' + a1'*omega1 + a2'*omega2

        smlal.w r11, r5, r1, r9           @ r5|r11 = a0' + a1'*omega2
        smlal.w r11, r5, r2, r8           @ r5|r11 = a0' + a1'*omega2 + a2'*omega1
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a2'' = a0' + a1'*omega2 + a2'*omega1

        vmov.w out, tmp_out
        str.w r4, [out, #776]
        str.w r5, [out, #1544]
        str.w r3, [out, #8]

        @ (a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r1,  r2,  r6,  r1,  r2,  r0,  r1,  r2)

        // r3, r4, r5, r8, r7, r9 available, calculate a5'' --> a8'' --> a7''
        vmov.w r5, tmp_omega_5
        vmov.w r8, r9, tmp_omega_7, tmp_omega_8
        smull.w r11, r3, r8, r1           @ r3|r11 = omega7*a4'
        smlal.w r11, r3, r5, r2           @ r3|r11 = omega7*a4' + omega5*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = omega7*a4' + omega5*a5'
        add.w r3, r3, r6                  @ r3 = a5'' = a3' + omega7*a4' + omega5*a5'

        smull.w r11, r4, r9, r1           @ r4|r11 = omega8*a7'
        smlal.w r11, r4, r8, r2           @ r4|r11 = omega8*a7' + omega7*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r4, r10, M           @ r4 = omega8*a7' + omega7*a8'
        add.w r4, r4, r0                  @ r4 = a8'' = a6' + omega8*a7' + omega7*a8'

        smull.w r11, r8, r5, r1           @ r8|r11 = omega5*a7'
        vmov.w r5, tmp_omega_1
        smlal.w r11, r8, r5, r2           @ r8|r11 = omega5*a7' + omega1*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r8, r10, M           @ r8 = omega5*a7' + omega1*a8'
        add.w r8, r8, r0                  @ r8 = a7'' + omega5*a7' + omega1*a8'

        vmov.w out2, tmp_out2
        str.w r3, [out2, #1544]
        str.w r8, [out2, #3080]
        str.w r4, [out2, #3848]

        // r3, r4, r8 available
        // r5 --> omega1, r9 --> omega8, calculate a3'' --> a4'' --> a6''
        @ (a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r1,  r2,  r6,  r1,  r2,  r0,  r1,  r2)

        vmov.w r4, r8, tmp_omega_2, tmp_omega_4

        smull.w r11, r3, r5, r1           @ r3|r11 = omega1*a4'
        smlal.w r11, r3, r4, r2           @ r3|r11 = omega1*a4' + omega2*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = omega1*a4' + omega2*a5'
        add.w r3, r3, r6                  @ r3 = a3'' = a3' + omega1*a4' + omega2*a5'

        smlal.w r11, r6, r8, r1           @ r6|r11 = a3' + omega4*a4'
        smlal.w r11, r6, r9, r2           @ r6|r11 = a3' + omega4*a4' + omega8*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a4'' = a3' + omega4*a4' + omega8*a5'

        smlal.w r11, r0, r4, r1           @ r5|r11 = a6' + omega2*a7'
        smlal.w r11, r0, r8, r2           @ r5|r11 = a6' + omega2*a7' + omega4*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r0, r10, M           @ r5 = a6'' = a6' + omega2*a7' + omega4*a8'

        vmov.w out2, tmp_out2
        str.w r6, [out2, #776]
        str.w r0, [out2, #2312]

        str.w r3, [out2, #8]

        vmov.w in, tmp_in
        ldrsh.w r1, [in, #386]
        ldrsh.w r2, [in, #770]
        ldrsh.w r3, [in, #1154]
        ldrsh.w r0, [in, #2]


        mov.w r5, #2048
        mov.w r6, #4096
        central_reduce r0, r5, r6
        central_reduce r1, r5, r6
        central_reduce r2, r5, r6
        central_reduce r3, r5, r6

        // a0_  = a0 + a3
        // a3_  = a0 + root[3]*a3
        // a6_  = a0 + root[6]*a3
        // a1_  = a1
        // a4_  = a1
        // a7_  = a1
        // a2_  = a2
        // a5_  = a2
        // a8_  = a2

        vmov.w r8, r9, tmp_omega_3, tmp_omega_6

    	// a4, a5, a6, a7, a8 = 0
        add.w r5, r0, r3                  @ r5 = a0' = a0 + a3

        smull.w r11, r6, r8, r3           @ r6|r11 = a0 + a3*omega1
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a3*omega1
        add.w r6, r0                      @ r6 = a3' = a0 + a3*omega1

        smlal.w r11, r0, r9, r3           @ r0|r11 = a0 + a3*omega2
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r0, r10, M           @ r0 = a6' = a0 + a3*omega2
        // (r5, r6, r0) = (a0', a3', a6')

        @  (r1, r1, r1) = (a1', a4', a7')
        @  (r2, r2, r2) = (a2', a5', a8')
        // r3, r4, r7 available

        @  (r2, r2, r2) = (a2', a5', a8')
        @ (a0_, a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r5,  r1,  r2,  r6,  r1,  r2,  r0,  r1,  r2)

        // a0__ = a0_ + a1_ + a2_
        // a1__ = a0_ + root[3]*a1_ + root[6]*a2_
        // a2__ = a0_ + root[6]*a1_ + root[3]*a2_
        // a3__ = a3_ + root[1]*a4_ + root[2]*a5_
        // a4__ = a3_ + root[4]*a4_ + root[8]*a5_
        // a5__ = a3_ + root[7]*a4_ + root[5]*a5_
        // a6__ = a6_ + root[2]*a7_ + root[4]*a8_
        // a7__ = a6_ + root[5]*a7_ + root[1]*a8_
        // a8__ = a6_ + root[8]*a7_ + root[7]*a8_

        // NTT-3

        // r4 available
        add.w r3, r5, r1                  @ r3 = a0' + a1'
        add.w r3, r3, r2                  @ r3 = a0'' = a0' + a1' + a2'

        smull.w r11, r4, r1, r8           @ r8|r11 = a1'*omega1
        smlal.w r11, r4, r2, r9           @ r8|r11 = a1'*omega1 + a2'*omega2
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r4, M, r10           @ r8 = a1'*omega1 + a2'*omega2
        add.w r4, r4, r5                  @ r8 = a1'' = a0' + a1'*omega1 + a2'*omega2

        smlal.w r11, r5, r1, r9           @ r5|r11 = a0' + a1'*omega2
        smlal.w r11, r5, r2, r8           @ r5|r11 = a0' + a1'*omega2 + a2'*omega1
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a2'' = a0' + a1'*omega2 + a2'*omega1

        vmov.w out, tmp_out
        str.w r4, [out, #772]
        str.w r5, [out, #1540]
        str.w r3, [out, #4]

        @ (a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r1,  r2,  r6,  r1,  r2,  r0,  r1,  r2)

        // r3, r4, r5, r8, r7, r9 available, calculate a5'' --> a8'' --> a7''
        vmov.w r5, tmp_omega_5
        vmov.w r8, r9, tmp_omega_7, tmp_omega_8
        smull.w r11, r3, r8, r1           @ r3|r11 = omega7*a4'
        smlal.w r11, r3, r5, r2           @ r3|r11 = omega7*a4' + omega5*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = omega7*a4' + omega5*a5'
        add.w r3, r3, r6                  @ r3 = a5'' = a3' + omega7*a4' + omega5*a5'

        smull.w r11, r4, r9, r1           @ r4|r11 = omega8*a7'
        smlal.w r11, r4, r8, r2           @ r4|r11 = omega8*a7' + omega7*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r4, r10, M           @ r4 = omega8*a7' + omega7*a8'
        add.w r4, r4, r0                  @ r4 = a8'' = a6' + omega8*a7' + omega7*a8'

        smull.w r11, r8, r5, r1           @ r8|r11 = omega5*a7'
        vmov.w r5, tmp_omega_1
        smlal.w r11, r8, r5, r2           @ r8|r11 = omega5*a7' + omega1*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r8, r10, M           @ r8 = omega5*a7' + omega1*a8'
        add.w r8, r8, r0                  @ r8 = a7'' + omega5*a7' + omega1*a8'

        vmov.w out2, tmp_out2
        str.w r3, [out2, #1540]
        str.w r8, [out2, #3076]
        str.w r4, [out2, #3844]

        // r3, r4, r8 available
        // r5 --> omega1, r9 --> omega8, calculate a3'' --> a4'' --> a6''
        @ (a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r1,  r2,  r6,  r1,  r2,  r0,  r1,  r2)

        vmov.w r4, r8, tmp_omega_2, tmp_omega_4

        smull.w r11, r3, r5, r1           @ r3|r11 = omega1*a4'
        smlal.w r11, r3, r4, r2           @ r3|r11 = omega1*a4' + omega2*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = omega1*a4' + omega2*a5'
        add.w r3, r3, r6                  @ r3 = a3'' = a3' + omega1*a4' + omega2*a5'

        smlal.w r11, r6, r8, r1           @ r6|r11 = a3' + omega4*a4'
        smlal.w r11, r6, r9, r2           @ r6|r11 = a3' + omega4*a4' + omega8*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a4'' = a3' + omega4*a4' + omega8*a5'

        smlal.w r11, r0, r4, r1           @ r5|r11 = a6' + omega2*a7'
        smlal.w r11, r0, r8, r2           @ r5|r11 = a6' + omega2*a7' + omega4*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r0, r10, M           @ r5 = a6'' = a6' + omega2*a7' + omega4*a8'

        vmov.w out2, tmp_out2
        str.w r6, [out2, #772]
        str.w r0, [out2, #2308]

        str.w r3, [out2, #4]

        vmov.w in, tmp_in
        ldrsh.w r1, [in, #384]
        ldrsh.w r2, [in, #768]
        ldrsh.w r3, [in, #1152]
        ldrsh.w r0, [in], #6
        vmov.w tmp_in, in


        mov.w r5, #2048
        mov.w r6, #4096
        central_reduce r0, r5, r6
        central_reduce r1, r5, r6
        central_reduce r2, r5, r6
        central_reduce r3, r5, r6

        // a0_  = a0 + a3
        // a3_  = a0 + root[3]*a3
        // a6_  = a0 + root[6]*a3
        // a1_  = a1
        // a4_  = a1
        // a7_  = a1
        // a2_  = a2
        // a5_  = a2
        // a8_  = a2

        vmov.w r8, r9, tmp_omega_3, tmp_omega_6

    	// a4, a5, a6, a7, a8 = 0
        add.w r5, r0, r3                  @ r5 = a0' = a0 + a3

        smull.w r11, r6, r8, r3           @ r6|r11 = a0 + a3*omega1
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a3*omega1
        add.w r6, r0                      @ r6 = a3' = a0 + a3*omega1

        smlal.w r11, r0, r9, r3           @ r0|r11 = a0 + a3*omega2
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r0, r10, M           @ r0 = a6' = a0 + a3*omega2
        // (r5, r6, r0) = (a0', a3', a6')

        @  (r1, r1, r1) = (a1', a4', a7')
        @  (r2, r2, r2) = (a2', a5', a8')
        // r3, r4, r7 available

        @  (r2, r2, r2) = (a2', a5', a8')
        @ (a0_, a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r5,  r1,  r2,  r6,  r1,  r2,  r0,  r1,  r2)

        // a0__ = a0_ + a1_ + a2_
        // a1__ = a0_ + root[3]*a1_ + root[6]*a2_
        // a2__ = a0_ + root[6]*a1_ + root[3]*a2_
        // a3__ = a3_ + root[1]*a4_ + root[2]*a5_
        // a4__ = a3_ + root[4]*a4_ + root[8]*a5_
        // a5__ = a3_ + root[7]*a4_ + root[5]*a5_
        // a6__ = a6_ + root[2]*a7_ + root[4]*a8_
        // a7__ = a6_ + root[5]*a7_ + root[1]*a8_
        // a8__ = a6_ + root[8]*a7_ + root[7]*a8_

        // NTT-3

        // r4 available
        add.w r3, r5, r1                  @ r3 = a0' + a1'
        add.w r3, r3, r2                  @ r3 = a0'' = a0' + a1' + a2'

        smull.w r11, r4, r1, r8           @ r8|r11 = a1'*omega1
        smlal.w r11, r4, r2, r9           @ r8|r11 = a1'*omega1 + a2'*omega2
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r4, M, r10           @ r8 = a1'*omega1 + a2'*omega2
        add.w r4, r4, r5                  @ r8 = a1'' = a0' + a1'*omega1 + a2'*omega2

        smlal.w r11, r5, r1, r9           @ r5|r11 = a0' + a1'*omega2
        smlal.w r11, r5, r2, r8           @ r5|r11 = a0' + a1'*omega2 + a2'*omega1
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a2'' = a0' + a1'*omega2 + a2'*omega1

        vmov.w out, tmp_out
        str.w r4, [out, #768]
        str.w r5, [out, #1536]
        str.w r3, [out], #12
        vmov.w tmp_out, out

        @ (a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r1,  r2,  r6,  r1,  r2,  r0,  r1,  r2)

        // r3, r4, r5, r8, r7, r9 available, calculate a5'' --> a8'' --> a7''
        vmov.w r5, tmp_omega_5
        vmov.w r8, r9, tmp_omega_7, tmp_omega_8
        smull.w r11, r3, r8, r1           @ r3|r11 = omega7*a4'
        smlal.w r11, r3, r5, r2           @ r3|r11 = omega7*a4' + omega5*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = omega7*a4' + omega5*a5'
        add.w r3, r3, r6                  @ r3 = a5'' = a3' + omega7*a4' + omega5*a5'

        smull.w r11, r4, r9, r1           @ r4|r11 = omega8*a7'
        smlal.w r11, r4, r8, r2           @ r4|r11 = omega8*a7' + omega7*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r4, r10, M           @ r4 = omega8*a7' + omega7*a8'
        add.w r4, r4, r0                  @ r4 = a8'' = a6' + omega8*a7' + omega7*a8'

        smull.w r11, r8, r5, r1           @ r8|r11 = omega5*a7'
        vmov.w r5, tmp_omega_1
        smlal.w r11, r8, r5, r2           @ r8|r11 = omega5*a7' + omega1*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r8, r10, M           @ r8 = omega5*a7' + omega1*a8'
        add.w r8, r8, r0                  @ r8 = a7'' + omega5*a7' + omega1*a8'

        vmov.w out2, tmp_out2
        str.w r3, [out2, #1536]
        str.w r8, [out2, #3072]
        str.w r4, [out2, #3840]

        // r3, r4, r8 available
        // r5 --> omega1, r9 --> omega8, calculate a3'' --> a4'' --> a6''
        @ (a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_) =
        @ (r1,  r2,  r6,  r1,  r2,  r0,  r1,  r2)

        vmov.w r4, r8, tmp_omega_2, tmp_omega_4

        smull.w r11, r3, r5, r1           @ r3|r11 = omega1*a4'
        smlal.w r11, r3, r4, r2           @ r3|r11 = omega1*a4' + omega2*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = omega1*a4' + omega2*a5'
        add.w r3, r3, r6                  @ r3 = a3'' = a3' + omega1*a4' + omega2*a5'

        smlal.w r11, r6, r8, r1           @ r6|r11 = a3' + omega4*a4'
        smlal.w r11, r6, r9, r2           @ r6|r11 = a3' + omega4*a4' + omega8*a5'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a4'' = a3' + omega4*a4' + omega8*a5'

        smlal.w r11, r0, r4, r1           @ r5|r11 = a6' + omega2*a7'
        smlal.w r11, r0, r8, r2           @ r5|r11 = a6' + omega2*a7' + omega4*a8'
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r0, r10, M           @ r5 = a6'' = a6' + omega2*a7' + omega4*a8'

        vmov.w out2, tmp_out2
        str.w r6, [out2, #768]
        str.w r0, [out2, #2304]

        str.w r3, [out2], #12
        vmov.w tmp_out2, out2

        vmov.w counter, tmp_counter
       	cmp.w counter, out2
       	bne.w NTT_9_16_4_case

    vmov.w in, tmp_in
    ldrsh.w r0, [in, #0]
    ldrsh.w r1, [in, #384]
    ldrsh.w r2, [in, #768]
    ldrsh.w r3, [in, #1152]

    vmov.w r8, r9, tmp_omega_3, tmp_omega_6

    mov.w r5, #2048
    mov.w r6, #4096
    central_reduce r0, r5, r6
    central_reduce r1, r5, r6
    central_reduce r2, r5, r6
    central_reduce r3, r5, r6

    add.w r5, r0, r3                  @ r5 = a0' = a0 + a3

    smull.w r11, r6, r8, r3           @ r6|r11 = a0 + a3*omega1
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r6, r10, M           @ r6 = a3*omega1
    add.w r6, r0                      @ r6 = a3' = a0 + a3*omega1

    smlal.w r11, r0, r9, r3           @ r0|r11 = a0 + a3*omega2
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r0, r10, M           @ r0 = a6' = a0 + a3*omega2

    add.w r3, r5, r1                  @ r3 = a0' + a1'
    add.w r3, r3, r2                  @ r3 = a0'' = a0' + a1' + a2'

    smull.w r11, r4, r1, r8           @ r8|r11 = a1'*omega1
    smlal.w r11, r4, r2, r9           @ r8|r11 = a1'*omega1 + a2'*omega2
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r4, M, r10           @ r8 = a1'*omega1 + a2'*omega2
    add.w r4, r4, r5                  @ r8 = a1'' = a0' + a1'*omega1 + a2'*omega2

    smlal.w r11, r5, r1, r9           @ r5|r11 = a0' + a1'*omega2
    smlal.w r11, r5, r2, r8           @ r5|r11 = a0' + a1'*omega2 + a2'*omega1
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r5, r10, M           @ r5 = a2'' = a0' + a1'*omega2 + a2'*omega1

    vmov.w out, tmp_out
    str.w r3, [out, #0]
    str.w r4, [out, #768]
    str.w r5, [out, #1536]

    vmov.w r5, tmp_omega_5
    vmov.w r8, r9, tmp_omega_7, tmp_omega_8
    smull.w r11, r3, r8, r1           @ r3|r11 = omega7*a4'
    smlal.w r11, r3, r5, r2           @ r3|r11 = omega7*a4' + omega5*a5'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r3, r10, M           @ r3 = omega7*a4' + omega5*a5'
    add.w r3, r3, r6                  @ r3 = a5'' = a3' + omega7*a4' + omega5*a5'

    smull.w r11, r4, r9, r1           @ r4|r11 = omega8*a7'
    smlal.w r11, r4, r8, r2           @ r4|r11 = omega8*a7' + omega7*a8'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r4, r10, M           @ r4 = omega8*a7' + omega7*a8'
    add.w r4, r4, r0                  @ r4 = a8'' = a6' + omega8*a7' + omega7*a8'

    smull.w r11, r8, r5, r1           @ r8|r11 = omega5*a7'
    vmov.w r5, tmp_omega_1
    smlal.w r11, r8, r5, r2           @ r8|r11 = omega5*a7' + omega1*a8'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r8, r10, M           @ r8 = omega5*a7' + omega1*a8'
    add.w r8, r8, r0                  @ r8 = a7'' + omega5*a7' + omega1*a8'

    vmov.w out2, tmp_out2
    str.w r3, [out2, #1536]
    str.w r8, [out2, #3072]
    str.w r4, [out2, #3840]

    vmov.w r4, r8, tmp_omega_2, tmp_omega_4

    smull.w r11, r3, r5, r1           @ r3|r11 = omega1*a4'
    smlal.w r11, r3, r4, r2           @ r3|r11 = omega1*a4' + omega2*a5'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r3, r10, M           @ r3 = omega1*a4' + omega2*a5'
    add.w r3, r3, r6                  @ r3 = a3'' = a3' + omega1*a4' + omega2*a5'

    smlal.w r11, r6, r8, r1           @ r6|r11 = a3' + omega4*a4'
    smlal.w r11, r6, r9, r2           @ r6|r11 = a3' + omega4*a4' + omega8*a5'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r6, r10, M           @ r6 = a4'' = a3' + omega4*a4' + omega8*a5'

    smlal.w r11, r0, r4, r1           @ r5|r11 = a6' + omega2*a7'
    smlal.w r11, r0, r8, r2           @ r5|r11 = a6' + omega2*a7' + omega4*a8'
    mul.w r10, r11, M_inv             @ reduce
    smlal.w r11, r0, r10, M           @ r5 = a6'' = a6' + omega2*a7' + omega4*a8'

    vmov.w out2, tmp_out2
    str.w r3, [out2, #0]
    str.w r6, [out2, #768]
    str.w r0, [out2, #2304]

pop {r4-r12, pc}

