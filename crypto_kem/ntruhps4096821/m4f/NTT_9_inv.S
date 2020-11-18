.macro montgomery_mul a, b, lower, upper, tmp, M_inv, M
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \lower, \M_inv
    smlal.w \lower, \upper, \tmp, \M
.endm
.macro central_reduce target, Mhalf, M
    cmp \target, \Mhalf
    it hi
    subhi \target, \M
.endm

root_9_inv_table:
    .word 980652 @ omega_3
    .word -1481904 @ omega_6
    .word 1587783 @ omega_1
    .word -1033921 @ omega_4
    .word -553862 @ omega_7
    .word -1619741 @ omega_2
    .word 1639017 @ omega_5
    .word -19276 @ omega_8
    .word 3365569 @ MOD
    .word 1205062335 @ M_inv

.syntax unified
.cpu cortex-m4


// NTT_9_inv(int32 *input[1728], int16 *output[821])
.global NTT_9_inv
.type NTT_9_inv, %function
NTT_9_inv:
    push.w {r4-r12, lr}

    in2         .req r11
    in          .req r10
    out         .req r10
    M           .req r12
    M_inv       .req r14
    counter     .req r4

    tmp_counter .req s0
    tmp_in2     .req s1
    tmp_in      .req s2
    tmp_omega_3 .req s4
    tmp_omega_6 .req s5
    tmp_omega_1 .req s6
    tmp_omega_4 .req s7
    tmp_omega_7 .req s8
    tmp_omega_2 .req s9
    tmp_omega_5 .req s10
    tmp_omega_8 .req s11
    tmp2        .req s12
    tmp3        .req s13
    tmp4        .req s14

    vmov.w tmp_in, r0
    add.w in2, r0, #2304
    vmov.w tmp_in2, in2

    add.w counter, in2, #768
    vmov.w tmp_counter, counter // set counter

    adr.w lr, root_9_inv_table
    vldm.w lr, {tmp_omega_3-tmp_omega_8}
    ldr.w M, [lr, #32]
    ldr.w M_inv, [lr, #36]

    NTT_9_inv_loop:
        // do a0, a1, a2 last
        ldr.w r0, [in2, #4]
        ldr.w r1, [in2, #772]
        ldr.w r2, [in2, #1540]
        ldr.w r3, [in2, #2308]
        ldr.w r4, [in2, #3076]
        ldr.w r5, [in2, #3844]

        vmov.w r7, tmp_omega_1
        vmov.w r8, r9, tmp_omega_4, tmp_omega_7

        smull.w r11, r6, r7, r0           @ r6|r11 = a3*omega1
        smlal.w r11, r6, r8, r1           @ r6|r11 = a3*omega1 + a4*omega4
        smlal.w r11, r6, r9, r2           @ r6|r11 = a3*omega1 + a4*omega4 + a5*omega7
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a4' = a3*omega1 + a4*omega4 + a5*omega7

        smull.w r11, r8, r8, r3           @ r8|r11 = a6*omega4
        smlal.w r11, r8, r7, r4           @ r8|r11 = a6*omega4 + a7*omega1
        smlal.w r11, r8, r9, r5           @ r8|r11 = a6*omega4 + a7*omega1 + a8*omega7
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r8, r10, M           @ r8 = a8' = a3*omega0 + a4*omega1 + a5*omega2

        vmov.w tmp2, r8                   @ save out a8'

        vmov.w r9, tmp_omega_2            @ r9 = omega2
        smull.w r11, r7, r9, r0           @ r7|r11 = a3*omega2
        smull.w r10, r9, r9, r3           @ r9|r10 = a6*omega2
        vmov.w r8, tmp_omega_5            @ r8 = omega5
        smlal.w r11, r7, r8, r2           @ r7|r11 = a3*omega2 + a5*omega5
        smlal.w r10, r9, r8, r4           @ r9|r10 = a6*omega2 + a7*omega5
        vmov.w r8, tmp_omega_8            @ r8 = omega8
        smlal.w r11, r7, r8, r1           @ r7|r11 = a3*omega2 + a5*omega5 + a4*omega8
        smlal.w r10, r9, r8, r5           @ r9|r10 = a6*omega2 + a7*omega5 + a8*omega8
        mul.w r8, r11, M_inv              @ reduce
        smlal.w r11, r7, r8, M            @ r7 = a5' = a3*omega2 + a5*omega5 + a4*omega8
        mul.w r8, r10, M_inv              @ reduce
        smlal.w r10, r9, r8, M            @ r9 = a7' = a6*omega2 + a7*omega5 + a8*omega8

        add r0, r1                        @ r0 = a3 + a4
        add r0, r2                        @ r0 = a3' = a3 + a4 + a5
        add r3, r4                        @ r3 = a6 + a7
        add r3, r5                        @ r3 = a6' = a6 + a7 + a8

        vmov.w tmp3, r7

        // (a3', a4', a5', a6', a7', a8') = (r0, r6, tmp3, r3, r9, tmp2)
        // r1, r2, r4, r5, r7, r8 available

        vmov.w in, tmp_in
        ldr.w r1, [in, #4]
        ldr.w r2, [in, #772]
        ldr.w r4, [in, #1540]

        vmov.w r7, r8, tmp_omega_3, tmp_omega_6

        smull.w r11, r5, r2, r8           @ r5|r11 = a1*omega6
        smlal.w r11, r5, r4, r7           @ r5|r11 = a1*omega6 + a2*omega3
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a1*omega6 + a2*omega3
        add.w r5, r5, r1                  @ r5 = a2' = a0 + a1*omega6 + a2*omega3

        vmov.w tmp4, r5                   @ save out

        smull.w r11, r5, r2, r7           @ r5|r11 = a1*omega3
        smlal.w r11, r5, r4, r8           @ r5|r11 = a1*omega3 + a2*omega6
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a1*omega3 + a2*omega6
        add.w r5, r5, r1                  @ r5 = a1' = a0 + a1*omega3 + a2*omega6

        add.w r1, r2                      @ r1 = a0 + a1
        add.w r1, r4                      @ r1 = a0' = a0 + a1 + a2

        //   (a0', a1', a2', a3', a4', a5', a6', a7', a8')
        // = (r1, r5, tmp4, r0, r6, tmp3, r3, r9, tmp2)
        // r2, r4 available

        add.w r2, r1, r0                  @ r2 = a0' + a3'
        add.w r2, r2, r3                  @ r2 = a0'' = a0' + a3' + a6'

        smull.w r11, r4, r0, r7           @ r4|r11 = a3'*omega3
        smlal.w r11, r4, r3, r8           @ r4|r11 = a3'*omega3 + a6'*omega6
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r4, r10, M           @ r4 = a3'*omega3 + a6'*omega6
        add.w r4, r4, r1                  @ r4 = a3'' = a0' + a3'*omega3 + a6'*omega6

        smlal.w r11, r1, r3, r7           @ r1|r11 = a0' + a6'*omega3
        smlal.w r11, r1, r0, r8           @ r1|r11 = a0' + a6'*omega3 + a3'*omega6
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r1, r10, M           @ r1 = a6'' = a0' + a6'*omega3 + a3'*omega6

        // r0, r3 available

        add.w r0, r5, r6                  @ r0 = a1' + a4'
        add.w r0, r0, r9                  @ r0 = a1'' = a1' + a4' + a7'

        smull.w r11, r3, r6, r7           @ r3|r11 = a4'*omega3
        smlal.w r11, r3, r9, r8           @ r3|r11 = a4'*omega3 + a7'*omega6
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = a4'*omega3 + a7'*omega6
        add.w r3, r3, r5                  @ r3 = a4'' = a1' + a4'*omega3 + a7'*omega6

        smlal.w r11, r5, r6, r8           @ r5|r11 = a1' + a4'*omega6
        smlal.w r11, r5, r9, r7           @ r5|r11 = a1' + a4'*omega6 + a7'*omega3
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a7'' = a1' + a4'*omega6 + a7'*omega3

        vmov.w r11, r10, tmp2, tmp3       @ r10 = a5', r11 = a8'
        vmov.w r9, tmp4                   @ r9 = a2'

        add.w r6, r10, r11                @ r6 = a5' + a8'
        add.w r6, r6, r9                  @ r6 = a2'' = a2' + a5' + a8'

        vmov.w r9, tmp_in // overwrite
        str.w r0, [r9, #772] @ a1''
        str.w r6, [r9, #1540] @ a2''
        str.w r2, [r9, #4] @ a0''

        // r0, r2, r6, r9, r10, r11 available
        vmov.w r9, tmp4                   @ r9 = a2' // move back

        smull.w r0, r6, r10, r7           @ r6|r0 = a5'*omega3
        smlal.w r0, r6, r11, r8           @ r6|r0 = a5'*omega3 + a8'*omega6
        mul.w r2, r0, M_inv               @ reduce
        smlal.w r0, r6, r2, M             @ r6 = a5'*omega3 + a8'*omega6
        add.w r6, r6, r9                  @ r6 = a5'' = a2' + a5'*omega3 + a8'*omega6

        smlal.w r0, r9, r10, r8           @ r9|r0 = a2' + a5'*omega6
        smlal.w r0, r9, r11, r7           @ r9|r0 = a2' + a5'*omega6 + a8'*omega3
        mul.w r2, r0, M_inv               @ reduce
        smlal.w r0, r9, r2, M             @ r9 = a8'' = a2' + a5'*omega6 + a8'*omega3

        vmov.w in2, tmp_in2
        str.w r3, [in2, #772] @ a4''
        str.w r6, [in2, #1540] @ a5''
        str.w r1, [in2, #2308] @ a6''
        str.w r5, [in2, #3076] @ a7''
        str.w r9, [in2, #3844] @ a8''
        str.w r4, [in2, #4] @ a3''

        // do a0, a1, a2 last
        ldr.w r0, [in2, #0]
        ldr.w r1, [in2, #768]
        ldr.w r2, [in2, #1536]
        ldr.w r3, [in2, #2304]
        ldr.w r4, [in2, #3072]
        ldr.w r5, [in2, #3840]

        vmov.w r7, tmp_omega_1
        vmov.w r8, r9, tmp_omega_4, tmp_omega_7

        smull.w r11, r6, r7, r0           @ r6|r11 = a3*omega1
        smlal.w r11, r6, r8, r1           @ r6|r11 = a3*omega1 + a4*omega4
        smlal.w r11, r6, r9, r2           @ r6|r11 = a3*omega1 + a4*omega4 + a5*omega7
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r6, r10, M           @ r6 = a4' = a3*omega1 + a4*omega4 + a5*omega7

        smull.w r11, r8, r8, r3           @ r8|r11 = a6*omega4
        smlal.w r11, r8, r7, r4           @ r8|r11 = a6*omega4 + a7*omega1
        smlal.w r11, r8, r9, r5           @ r8|r11 = a6*omega4 + a7*omega1 + a8*omega7
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r8, r10, M           @ r8 = a8' = a3*omega0 + a4*omega1 + a5*omega2

        vmov.w tmp2, r8                   @ save out a8'

        vmov.w r9, tmp_omega_2            @ r9 = omega2
        smull.w r11, r7, r9, r0           @ r7|r11 = a3*omega2
        smull.w r10, r9, r9, r3           @ r9|r10 = a6*omega2
        vmov.w r8, tmp_omega_5            @ r8 = omega5
        smlal.w r11, r7, r8, r2           @ r7|r11 = a3*omega2 + a5*omega5
        smlal.w r10, r9, r8, r4           @ r9|r10 = a6*omega2 + a7*omega5
        vmov.w r8, tmp_omega_8            @ r8 = omega8
        smlal.w r11, r7, r8, r1           @ r7|r11 = a3*omega2 + a5*omega5 + a4*omega8
        smlal.w r10, r9, r8, r5           @ r9|r10 = a6*omega2 + a7*omega5 + a8*omega8
        mul.w r8, r11, M_inv              @ reduce
        smlal.w r11, r7, r8, M            @ r7 = a5' = a3*omega2 + a5*omega5 + a4*omega8
        mul.w r8, r10, M_inv              @ reduce
        smlal.w r10, r9, r8, M            @ r9 = a7' = a6*omega2 + a7*omega5 + a8*omega8

        add r0, r1                        @ r0 = a3 + a4
        add r0, r2                        @ r0 = a3' = a3 + a4 + a5
        add r3, r4                        @ r3 = a6 + a7
        add r3, r5                        @ r3 = a6' = a6 + a7 + a8

        vmov.w tmp3, r7

        // (a3', a4', a5', a6', a7', a8') = (r0, r6, tmp3, r3, r9, tmp2)
        // r1, r2, r4, r5, r7, r8 available

        vmov.w in, tmp_in
        ldr.w r1, [in, #0]
        ldr.w r2, [in, #768]
        ldr.w r4, [in, #1536]

        vmov.w r7, r8, tmp_omega_3, tmp_omega_6

        smull.w r11, r5, r2, r8           @ r5|r11 = a1*omega6
        smlal.w r11, r5, r4, r7           @ r5|r11 = a1*omega6 + a2*omega3
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a1*omega6 + a2*omega3
        add.w r5, r5, r1                  @ r5 = a2' = a0 + a1*omega6 + a2*omega3

        vmov.w tmp4, r5                   @ save out

        smull.w r11, r5, r2, r7           @ r5|r11 = a1*omega3
        smlal.w r11, r5, r4, r8           @ r5|r11 = a1*omega3 + a2*omega6
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a1*omega3 + a2*omega6
        add.w r5, r5, r1                  @ r5 = a1' = a0 + a1*omega3 + a2*omega6

        add.w r1, r2                      @ r1 = a0 + a1
        add.w r1, r4                      @ r1 = a0' = a0 + a1 + a2

        //   (a0', a1', a2', a3', a4', a5', a6', a7', a8')
        // = (r1, r5, tmp4, r0, r6, tmp3, r3, r9, tmp2)
        // r2, r4 available

        add.w r2, r1, r0                  @ r2 = a0' + a3'
        add.w r2, r2, r3                  @ r2 = a0'' = a0' + a3' + a6'

        smull.w r11, r4, r0, r7           @ r4|r11 = a3'*omega3
        smlal.w r11, r4, r3, r8           @ r4|r11 = a3'*omega3 + a6'*omega6
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r4, r10, M           @ r4 = a3'*omega3 + a6'*omega6
        add.w r4, r4, r1                  @ r4 = a3'' = a0' + a3'*omega3 + a6'*omega6

        smlal.w r11, r1, r3, r7           @ r1|r11 = a0' + a6'*omega3
        smlal.w r11, r1, r0, r8           @ r1|r11 = a0' + a6'*omega3 + a3'*omega6
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r1, r10, M           @ r1 = a6'' = a0' + a6'*omega3 + a3'*omega6

        // r0, r3 available

        add.w r0, r5, r6                  @ r0 = a1' + a4'
        add.w r0, r0, r9                  @ r0 = a1'' = a1' + a4' + a7'

        smull.w r11, r3, r6, r7           @ r3|r11 = a4'*omega3
        smlal.w r11, r3, r9, r8           @ r3|r11 = a4'*omega3 + a7'*omega6
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r3, r10, M           @ r3 = a4'*omega3 + a7'*omega6
        add.w r3, r3, r5                  @ r3 = a4'' = a1' + a4'*omega3 + a7'*omega6

        smlal.w r11, r5, r6, r8           @ r5|r11 = a1' + a4'*omega6
        smlal.w r11, r5, r9, r7           @ r5|r11 = a1' + a4'*omega6 + a7'*omega3
        mul.w r10, r11, M_inv             @ reduce
        smlal.w r11, r5, r10, M           @ r5 = a7'' = a1' + a4'*omega6 + a7'*omega3

        vmov.w r11, r10, tmp2, tmp3       @ r10 = a5', r11 = a8'
        vmov.w r9, tmp4                   @ r9 = a2'

        add.w r6, r10, r11                @ r6 = a5' + a8'
        add.w r6, r6, r9                  @ r6 = a2'' = a2' + a5' + a8'

        vmov.w r9, tmp_in // overwrite
        str.w r0, [r9, #768] @ a1''
        str.w r6, [r9, #1536] @ a2''
        str.w r2, [r9], #8 @ a0''
        vmov.w tmp_in, r9

        // r0, r2, r6, r9, r10, r11 available
        vmov.w r9, tmp4                   @ r9 = a2' // move back

        smull.w r0, r6, r10, r7           @ r6|r0 = a5'*omega3
        smlal.w r0, r6, r11, r8           @ r6|r0 = a5'*omega3 + a8'*omega6
        mul.w r2, r0, M_inv               @ reduce
        smlal.w r0, r6, r2, M             @ r6 = a5'*omega3 + a8'*omega6
        add.w r6, r6, r9                  @ r6 = a5'' = a2' + a5'*omega3 + a8'*omega6

        smlal.w r0, r9, r10, r8           @ r9|r0 = a2' + a5'*omega6
        smlal.w r0, r9, r11, r7           @ r9|r0 = a2' + a5'*omega6 + a8'*omega3
        mul.w r2, r0, M_inv               @ reduce
        smlal.w r0, r9, r2, M             @ r9 = a8'' = a2' + a5'*omega6 + a8'*omega3

        vmov.w in2, tmp_in2
        str.w r3, [in2, #768] @ a4''
        str.w r6, [in2, #1536] @ a5''
        str.w r1, [in2, #2304] @ a6''
        str.w r5, [in2, #3072] @ a7''
        str.w r9, [in2, #3840] @ a8''
        str.w r4, [in2], #8 @ a3''
        vmov.w tmp_in2, in2

        vmov.w counter, tmp_counter
       	cmp.w counter, in2
       	bne.w NTT_9_inv_loop

pop {r4-r12, pc}

