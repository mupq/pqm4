
.syntax unified
.cpu cortex-m4

.global __asm_mul3x3
.type __asm_mul3x3, %function
__asm_mul3x3:

    a0_pos        .req r0
    b0_pos        .req r1
    M             .req r8
    Mprime        .req r9
    t_a0          .req r2
    t_a1          .req r3
    t_a2          .req r4
    t_b0          .req r5
    t_b1          .req r6
    t_b2          .req r7
    lower         .req r10
    upper         .req r11

    rootxR        .req r12
    temp          .req r14

    s_counter     .req s22
    s_mul_table   .req s23

    @s0-s9 is occupied due to unroll 4

    push.w {r4-r12, lr}
    vpush.w {s16-s23}
    mov.w r8, r2
    mov.w r9, r3

    vldr.w s_mul_table, [sp, #72]

    add.w temp, r0, #6912
    vmov.w s_counter, temp        //set counter

    mul_loop:

        vmov.w temp, s_mul_table

        ldr t_a0, [a0_pos, #0]
        ldr t_a1, [a0_pos, #4]
        ldr t_a2, [a0_pos, #8]
        ldr t_b0, [b0_pos, #0]
        ldr t_b1, [b0_pos, #4]
        ldr t_b2, [b0_pos, #8]
        ldr.w rootxR, [temp, #0]

        // a0b0 + root*(a1b2+a2b1)
        smull.w lower, upper, t_a1, t_b2       @ a1b2
        smlal.w lower, upper, t_a2, t_b1       @ a1b3 + a2b1
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a1b3 + a2b1)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a1b3 + a2b1)/R % M
        smlal.w lower, upper, t_a0, t_b0       @ a0b0 + root*(a1b3 + a2b1)
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s0, upper      @ [a0b0 + root*(a1b3 + a2b1)]/R % M

        // a0b1 + a1b0 + root*(a2b2)
        smull.w lower, upper, t_a2, t_b2       @ a2b2
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a2b2)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a2b2)/R % M
        smlal.w lower, upper, t_a0, t_b1
        smlal.w lower, upper, t_a1, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s1, upper

        // a1b1 + a0b2 + a2b0
        smull.w lower, upper, t_a1, t_b1
        smlal.w lower, upper, t_a0, t_b2
        smlal.w lower, upper, t_a2, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s2, upper

        ldr t_a0, [a0_pos, #12]
        ldr t_a1, [a0_pos, #16]
        ldr t_a2, [a0_pos, #20]
        ldr t_b0, [b0_pos, #12]
        ldr t_b1, [b0_pos, #16]
        ldr t_b2, [b0_pos, #20]
        neg.w rootxR, rootxR

        // a0b0 + root*(a1b2+a2b1)
        smull.w lower, upper, t_a1, t_b2       @ a1b2
        smlal.w lower, upper, t_a2, t_b1       @ a1b3 + a2b1
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a1b3 + a2b1)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a1b3 + a2b1)/R % M
        smlal.w lower, upper, t_a0, t_b0       @ a0b0 + root*(a1b3 + a2b1)
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s3, upper      @ [a0b0 + root*(a1b3 + a2b1)]/R % M

        // a0b1 + a1b0 + root*(a2b2)
        smull.w lower, upper, t_a2, t_b2       @ a2b2
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a2b2)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a2b2)/R % M
        smlal.w lower, upper, t_a0, t_b1
        smlal.w lower, upper, t_a1, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s4, upper

        // a1b1 + a0b2 + a2b0
        smull.w lower, upper, t_a1, t_b1
        smlal.w lower, upper, t_a0, t_b2
        smlal.w lower, upper, t_a2, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s5, upper

        vmov.w temp, s_mul_table

        ldr t_a0, [a0_pos, #24]
        ldr t_a1, [a0_pos, #28]
        ldr t_a2, [a0_pos, #32]
        ldr t_b0, [b0_pos, #24]
        ldr t_b1, [b0_pos, #28]
        ldr t_b2, [b0_pos, #32]
        ldr.w rootxR, [temp, #4]

        // a0b0 + root*(a1b2+a2b1)
        smull.w lower, upper, t_a1, t_b2       @ a1b2
        smlal.w lower, upper, t_a2, t_b1       @ a1b3 + a2b1
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a1b3 + a2b1)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a1b3 + a2b1)/R % M
        smlal.w lower, upper, t_a0, t_b0       @ a0b0 + root*(a1b3 + a2b1)
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s6, upper      @ [a0b0 + root*(a1b3 + a2b1)]/R % M

        // a0b1 + a1b0 + root*(a2b2)
        smull.w lower, upper, t_a2, t_b2       @ a2b2
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a2b2)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a2b2)/R % M
        smlal.w lower, upper, t_a0, t_b1
        smlal.w lower, upper, t_a1, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s7, upper

        // a1b1 + a0b2 + a2b0
        smull.w lower, upper, t_a1, t_b1
        smlal.w lower, upper, t_a0, t_b2
        smlal.w lower, upper, t_a2, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s8, upper

        ldr t_a0, [a0_pos, #36]
        ldr t_a1, [a0_pos, #40]
        ldr t_a2, [a0_pos, #44]
        ldr t_b0, [b0_pos, #36]
        ldr t_b1, [b0_pos, #40]
        ldr t_b2, [b0_pos, #44]
        neg.w rootxR, rootxR

        // a0b0 + root*(a1b2+a2b1)
        smull.w lower, upper, t_a1, t_b2       @ a1b2
        smlal.w lower, upper, t_a2, t_b1       @ a1b3 + a2b1
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a1b3 + a2b1)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a1b3 + a2b1)/R % M
        smlal.w lower, upper, t_a0, t_b0       @ a0b0 + root*(a1b3 + a2b1)
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s9, upper      @ [a0b0 + root*(a1b3 + a2b1)]/R % M

        // a0b1 + a1b0 + root*(a2b2)
        smull.w lower, upper, t_a2, t_b2       @ a2b2
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a2b2)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a2b2)/R % M
        smlal.w lower, upper, t_a0, t_b1
        smlal.w lower, upper, t_a1, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s10, upper

        // a1b1 + a0b2 + a2b0
        smull.w lower, upper, t_a1, t_b1
        smlal.w lower, upper, t_a0, t_b2
        smlal.w lower, upper, t_a2, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s11, upper

        vmov.w temp, s_mul_table

        ldr t_a0, [a0_pos, #48]
        ldr t_a1, [a0_pos, #52]
        ldr t_a2, [a0_pos, #56]
        ldr t_b0, [b0_pos, #48]
        ldr t_b1, [b0_pos, #52]
        ldr t_b2, [b0_pos, #56]
        ldr.w rootxR, [temp, #8]

        // a0b0 + root*(a1b2+a2b1)
        smull.w lower, upper, t_a1, t_b2       @ a1b2
        smlal.w lower, upper, t_a2, t_b1       @ a1b3 + a2b1
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a1b3 + a2b1)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a1b3 + a2b1)/R % M
        smlal.w lower, upper, t_a0, t_b0       @ a0b0 + root*(a1b3 + a2b1)
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s12, upper      @ [a0b0 + root*(a1b3 + a2b1)]/R % M

        // a0b1 + a1b0 + root*(a2b2)
        smull.w lower, upper, t_a2, t_b2       @ a2b2
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a2b2)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a2b2)/R % M
        smlal.w lower, upper, t_a0, t_b1
        smlal.w lower, upper, t_a1, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s13, upper

        // a1b1 + a0b2 + a2b0
        smull.w lower, upper, t_a1, t_b1
        smlal.w lower, upper, t_a0, t_b2
        smlal.w lower, upper, t_a2, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s14, upper

        ldr t_a0, [a0_pos, #60]
        ldr t_a1, [a0_pos, #64]
        ldr t_a2, [a0_pos, #68]
        ldr t_b0, [b0_pos, #60]
        ldr t_b1, [b0_pos, #64]
        ldr t_b2, [b0_pos, #68]
        neg.w rootxR, rootxR

        // a0b0 + root*(a1b2+a2b1)
        smull.w lower, upper, t_a1, t_b2       @ a1b2
        smlal.w lower, upper, t_a2, t_b1       @ a1b3 + a2b1
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a1b3 + a2b1)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a1b3 + a2b1)/R % M
        smlal.w lower, upper, t_a0, t_b0       @ a0b0 + root*(a1b3 + a2b1)
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s15, upper      @ [a0b0 + root*(a1b3 + a2b1)]/R % M

        // a0b1 + a1b0 + root*(a2b2)
        smull.w lower, upper, t_a2, t_b2       @ a2b2
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a2b2)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a2b2)/R % M
        smlal.w lower, upper, t_a0, t_b1
        smlal.w lower, upper, t_a1, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s16, upper

        // a1b1 + a0b2 + a2b0
        smull.w lower, upper, t_a1, t_b1
        smlal.w lower, upper, t_a0, t_b2
        smlal.w lower, upper, t_a2, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s17, upper

        vmov.w temp, s_mul_table

        ldr t_a0, [a0_pos, #72]
        ldr t_a1, [a0_pos, #76]
        ldr t_a2, [a0_pos, #80]
        ldr t_b0, [b0_pos, #72]
        ldr t_b1, [b0_pos, #76]
        ldr t_b2, [b0_pos, #80]
        ldr.w rootxR, [temp, #12]
        add.w temp, #16     @next root*R
        vmov.w s_mul_table, temp

        // a0b0 + root*(a1b2+a2b1)
        smull.w lower, upper, t_a1, t_b2       @ a1b2
        smlal.w lower, upper, t_a2, t_b1       @ a1b3 + a2b1
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a1b3 + a2b1)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a1b3 + a2b1)/R % M
        smlal.w lower, upper, t_a0, t_b0       @ a0b0 + root*(a1b3 + a2b1)
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s18, upper      @ [a0b0 + root*(a1b3 + a2b1)]/R % M

        // a0b1 + a1b0 + root*(a2b2)
        smull.w lower, upper, t_a2, t_b2       @ a2b2
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a2b2)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a2b2)/R % M
        smlal.w lower, upper, t_a0, t_b1
        smlal.w lower, upper, t_a1, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s19, upper

        // a1b1 + a0b2 + a2b0
        smull.w lower, upper, t_a1, t_b1
        smlal.w lower, upper, t_a0, t_b2
        smlal.w lower, upper, t_a2, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s20, upper

        ldr t_a0, [a0_pos, #84]
        ldr t_a1, [a0_pos, #88]
        ldr t_a2, [a0_pos, #92]
        ldr t_b0, [b0_pos, #84]
        ldr t_b1, [b0_pos, #88]
        ldr t_b2, [b0_pos, #92]
        neg.w rootxR, rootxR

        // a0b0 + root*(a1b2+a2b1)
        smull.w lower, upper, t_a1, t_b2       @ a1b2
        smlal.w lower, upper, t_a2, t_b1       @ a1b3 + a2b1
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a1b3 + a2b1)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a1b3 + a2b1)/R % M
        smlal.w lower, upper, t_a0, t_b0       @ a0b0 + root*(a1b3 + a2b1)
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        vmov.w s21, upper      @ [a0b0 + root*(a1b3 + a2b1)]/R % M

        // a0b1 + a1b0 + root*(a2b2)
        smull.w lower, upper, t_a2, t_b2       @ a2b2
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M          @ upper = (a2b2)/R % M
        smull.w lower, upper, upper, rootxR    @ root*R*(a2b2)/R % M
        smlal.w lower, upper, t_a0, t_b1
        smlal.w lower, upper, t_a1, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, upper, temp, M
        // a1b1 + a0b2 + a2b0
        smull.w lower, rootxR, t_a1, t_b1
        smlal.w lower, rootxR, t_a0, t_b2
        smlal.w lower, rootxR, t_a2, t_b0
        mul.w temp, lower, Mprime
        smlal.w lower, rootxR, temp, M


        vstm.w a0_pos, {s0-s21}
        str.w upper, [a0_pos, #88]
        str.w rootxR, [a0_pos, #92]

        add.w a0_pos, #96
        add.w b0_pos, #96

        vmov.w temp, s_counter
        cmp.w a0_pos, temp
        bne.w mul_loop

vpop.w {s16-s23}
pop.w {r4-r12, pc}

