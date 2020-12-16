
.syntax unified
.cpu cortex-m4

.global mul
.type mul, %function
mul:
    push.w {r4-r12,lr}

    mul_out     .req r0
    lower       .req r0
    upper       .req r1
    tmp1        .req r4
    counter     .req r1

    poly1       .req r0
    root_table  .req r1
    M           .req r2
    M_inv       .req r3
    poly2       .req r4
    K0          .req r5
    K1          .req r6
    K2          .req r7
    K3          .req r8
    B0          .req r9
    B1          .req r10
    B2          .req r11
    B3          .req r12
    root        .req r14

    c0_fp          .req s0
    c1_fp          .req s1
    c2_fp          .req s2
    tmp_poly1      .req s3
    tmp_root_table .req s4
    tmp_poly2      .req s5
    tmp_mul_out    .req s6
    tmp_counter    .req s7

    vmov.w tmp_poly1, tmp_root_table, poly1, root_table
    vldr.w tmp_poly2, [sp, #40]
    ldr.w mul_out, [sp, #44]
    vmov.w tmp_mul_out, mul_out

    add.w mul_out, mul_out, #1024  // set counter
    vmov.w tmp_counter, mul_out

    multiply:

        // poly1 * poly2
        vmov.w poly1, root_table, tmp_poly1, tmp_root_table
        vmov.w poly2, tmp_poly2
        ldm.w poly1!, {K0-K3}              @ r5~r8  <- K0 + K1*x + K2*x^2 + K3*x^3
        ldm.w poly2!, {B0-B3}              @ r9~r12 <- B0 + B1*x + B2*x^2 + B3*x^3
        ldr.w root, [root_table], #4
        vmov.w tmp_poly1, tmp_root_table, poly1, root_table
        vmov.w tmp_poly2, poly2

        // for c0 = K0B0 + root*(K1B3 + K2B2 + K3B1)
        smull.w lower, upper, K1, B3
        smlal.w lower, upper, K2, B2
        smlal.w lower, upper, K3, B1       @ K1B3 + K2B2 + K3B1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        smull.w lower, upper, upper, root  @ root*(K1B3 + K2B2 + K3B1)
        smlal.w lower, upper, K0, B0       @ K0B0 + root*(K1B3 + K2B2 + K3B1)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w c0_fp, upper

        // for c1 = K0B1 + K1B0 + root*(K2B3 + K3B2)
        smull.w lower, upper, K2, B3
        smlal.w lower, upper, K3, B2       @ K2B3 + K3B2
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        smull.w lower, upper, upper, root  @ root*(K2B3 + K3B2)
        smlal.w lower, upper, K0, B1
        smlal.w lower, upper, K1, B0       @ K0B1 + K1B0 + root*(K2B3 + K3B2)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w c1_fp, upper

        // for c2 = K0B2 + K2B0 + K1B1 + root*(K3B3)
        smull.w lower, upper, K3, B3       @ K3B3
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        smull.w lower, upper, upper, root  @ root*(K3B3)
        smlal.w lower, upper, K0, B2
        smlal.w lower, upper, K1, B1
        smlal.w lower, upper, K2, B0       @ K0B2 + K2B0 + K1B1 + root*(K3B3)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w c2_fp, upper

        // for c3 = K0B3 + K3B0 + K1B2 + K2B1
        smull.w lower, upper, K0, B3
        smlal.w lower, upper, K3, B0
        smlal.w lower, upper, K1, B2
        smlal.w lower, upper, K2, B1       @ K0B3 + K3B0 + K1B2 + K2B1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M

        // save
        vmov.w mul_out, tmp_mul_out
        vstr.w c0_fp, [mul_out, #0]
        vstr.w c1_fp, [mul_out, #4]
        vstr.w c2_fp, [mul_out, #8]
        str.w upper, [mul_out, #12]
        add.w mul_out, #16
        vmov.w tmp_mul_out, mul_out

        vmov.w counter, tmp_counter
        cmp.w mul_out, counter
        bne.w multiply

pop.w {r4-r12, pc}

.global mul_acc
.type mul_acc, %function
mul_acc:
    push.w {r4-r12,lr}

    mul_out     .req r0
    lower       .req r0
    upper       .req r1
    tmp1        .req r4
    counter     .req r1

    poly1       .req r0
    root_table  .req r1
    M           .req r2
    M_inv       .req r3
    poly2       .req r4
    K0          .req r5
    K1          .req r6
    K2          .req r7
    K3          .req r8
    B0          .req r9
    B1          .req r10
    B2          .req r11
    B3          .req r12
    root        .req r14

    c0_fp          .req s0
    c1_fp          .req s1
    c2_fp          .req s2
    tmp_poly1      .req s3
    tmp_root_table .req s4
    tmp_poly2      .req s5
    tmp_mul_out    .req s6
    tmp_counter    .req s7

    vmov.w tmp_poly1, tmp_root_table, poly1, root_table
    vldr.w tmp_poly2, [sp, #40]
    ldr.w mul_out, [sp, #44]
    vmov.w tmp_mul_out, mul_out

    add.w mul_out, mul_out, #1024  // set counter
    vmov.w tmp_counter, mul_out

    multiply_acc:

        // poly1 * poly2
        vmov.w poly1, root_table, tmp_poly1, tmp_root_table
        vmov.w poly2, tmp_poly2
        ldm.w poly1!, {K0-K3}              @ r5~r8  <- K0 + K1*x + K2*x^2 + K3*x^3
        ldm.w poly2!, {B0-B3}              @ r9~r12 <- B0 + B1*x + B2*x^2 + B3*x^3
        ldr.w root, [root_table], #4
        vmov.w tmp_poly1, tmp_root_table, poly1, root_table
        vmov.w tmp_poly2, poly2

        // for c0 = K0B0 + root*(K1B3 + K2B2 + K3B1)
        smull.w lower, upper, K1, B3
        smlal.w lower, upper, K2, B2
        smlal.w lower, upper, K3, B1       @ K1B3 + K2B2 + K3B1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        smull.w lower, upper, upper, root  @ root*(K1B3 + K2B2 + K3B1)
        smlal.w lower, upper, K0, B0       @ K0B0 + root*(K1B3 + K2B2 + K3B1)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w c0_fp, upper

        // for c1 = K0B1 + K1B0 + root*(K2B3 + K3B2)
        smull.w lower, upper, K2, B3
        smlal.w lower, upper, K3, B2       @ K2B3 + K3B2
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        smull.w lower, upper, upper, root  @ root*(K2B3 + K3B2)
        smlal.w lower, upper, K0, B1
        smlal.w lower, upper, K1, B0       @ K0B1 + K1B0 + root*(K2B3 + K3B2)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w c1_fp, upper

        // for c2 = K0B2 + K2B0 + K1B1 + root*(K3B3)
        smull.w lower, upper, K3, B3       @ K3B3
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        smull.w lower, upper, upper, root  @ root*(K3B3)
        smlal.w lower, upper, K0, B2
        smlal.w lower, upper, K1, B1
        smlal.w lower, upper, K2, B0       @ K0B2 + K2B0 + K1B1 + root*(K3B3)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w c2_fp, upper

        // for c3 = K0B3 + K3B0 + K1B2 + K2B1
        smull.w lower, upper, K0, B3
        smlal.w lower, upper, K3, B0
        smlal.w lower, upper, K1, B2
        smlal.w lower, upper, K2, B1       @ K0B3 + K3B0 + K1B2 + K2B1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M

        // save
        vmov.w mul_out, tmp_mul_out

        vmov.w K0, K1, c0_fp, c1_fp
        vmov.w K2, c2_fp
        ldm.w mul_out, {B0-B3}
        add B0, K0
        add B1, K1
        add B2, K2
        add B3, upper
        stm.w mul_out!, {B0-B3}

        vmov.w tmp_mul_out, mul_out

        vmov.w counter, tmp_counter
        cmp.w mul_out, counter
        bne.w multiply_acc

pop.w {r4-r12, pc}

