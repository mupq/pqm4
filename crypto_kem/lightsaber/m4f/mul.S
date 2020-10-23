
.syntax unified
.cpu cortex-m4

.global my_mul
.type my_mul, %function
my_mul:
    push.w {r4-r12,lr}

    mul_out     .req r0
    lower       .req r0
    upper       .req r1
    tmp1        .req r4
    counter     .req r1

    vector      .req r0
    root_table  .req r1
    M           .req r2
    M_inv       .req r3
    Matrix_0    .req r4
    Matrix_1    .req r4
    K0          .req r5
    K1          .req r6
    K2          .req r7
    K3          .req r8
    B0          .req r9
    B1          .req r10
    B2          .req r11
    B3          .req r12
    root        .req r14

    c0_lower       .req s0
    c0_upper       .req s1
    c1_lower       .req s2
    c1_upper       .req s3
    c2_lower       .req s4
    c2_upper       .req s5
    c3_lower       .req s6
    c3_upper       .req s7
    tmp_vector     .req s8
    tmp_root_table .req s9
    tmp_Matrix_0   .req s10
    tmp_Matrix_1   .req s11
    tmp_mul_out    .req s12
    tmp_counter    .req s13

    vmov.w tmp_vector, tmp_root_table, vector, root_table
    vldr.w tmp_Matrix_0, [sp, #40]
    vldr.w tmp_Matrix_1, [sp, #44]
    ldr.w mul_out, [sp, #48]
    vmov.w tmp_mul_out, mul_out

    add.w mul_out, mul_out, #1024  // set counter
    vmov.w tmp_counter, mul_out

    my_multiply:

        // small[0] * Matrix_0
        vmov.w vector, tmp_vector
        vmov.w root_table, tmp_root_table
        vmov.w Matrix_0, tmp_Matrix_0
        ldm.w vector, {K0-K3}              @ r5~r8  <- K0 + K1*x + K2*x^2 + K3*x^3
        ldm.w Matrix_0!, {B0-B3}           @ r9~r12 <- B0 + B1*x + B2*x^2 + B3*x^3
        ldr.w root, [root_table], #4
        vmov.w tmp_root_table, root_table
        vmov.w tmp_Matrix_0, Matrix_0

        // for c0 = K0B0 + root*(K1B3 + K2B2 + K3B1)
        smull.w lower, upper, K1, B3
        smlal.w lower, upper, K2, B2
        smlal.w lower, upper, K3, B1       @ K1B3 + K2B2 + K3B1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        smull.w lower, upper, upper, root  @ root*(K1B3 + K2B2 + K3B1)
        smlal.w lower, upper, K0, B0       @ K0B0 + root*(K1B3 + K2B2 + K3B1)
        vmov.w c0_lower, c0_upper, lower, upper

        // for c1 = K0B1 + K1B0 + root*(K2B3 + K3B2)
        smull.w lower, upper, K2, B3
        smlal.w lower, upper, K3, B2       @ K2B3 + K3B2
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        smull.w lower, upper, upper, root  @ root*(K2B3 + K3B2)
        smlal.w lower, upper, K0, B1
        smlal.w lower, upper, K1, B0       @ K0B1 + K1B0 + root*(K2B3 + K3B2)
        vmov.w c1_lower, c1_upper, lower, upper

        // for c2 = K0B2 + K2B0 + K1B1 + root*(K3B3)
        smull.w lower, upper, K3, B3       @ K3B3
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        smull.w lower, upper, upper, root  @ root*(K3B3)
        smlal.w lower, upper, K0, B2
        smlal.w lower, upper, K1, B1
        smlal.w lower, upper, K2, B0       @ K0B2 + K2B0 + K1B1 + root*(K3B3)
        vmov.w c2_lower, c2_upper, lower, upper

        // for c3 = K0B3 + K3B0 + K1B2 + K2B1
        smull.w lower, upper, K0, B3
        smlal.w lower, upper, K3, B0
        smlal.w lower, upper, K1, B2
        smlal.w lower, upper, K2, B1       @ K0B3 + K3B0 + K1B2 + K2B1
        vmov.w c3_lower, c3_upper, lower, upper

        // small[1] * Matrix_1
        vmov.w vector, tmp_vector
        vmov.w Matrix_1, tmp_Matrix_1
        ldr.w K0, [vector, #1024]
        ldr.w K1, [vector, #1028]
        ldr.w K2, [vector, #1032]
        ldr.w K3, [vector, #1036]
        ldm.w Matrix_1!, {B0-B3}
        add.w vector, #16
        vmov.w tmp_vector, vector
        vmov.w tmp_Matrix_1, Matrix_1

        // for c0 = K0B0 + root*(K1B3 + K2B2 + K3B1)
        smull.w lower, upper, K1, B3
        smlal.w lower, upper, K2, B2
        smlal.w lower, upper, K3, B1       @ K1B3 + K2B2 + K3B1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        vmov.w lower, tmp1, c0_lower, c0_upper
        smlal.w lower, tmp1, upper, root   @ root*(K1B3 + K2B2 + K3B1)
        smlal.w lower, tmp1, K0, B0        @ K0B0 + root*(K1B3 + K2B2 + K3B1)
        mul.w upper, lower, M_inv
        smlal.w lower, tmp1, upper, M
        vmov.w c0_upper, tmp1

        // for c1 = K0B1 + K1B0 + root*(K2B3 + K3B2)
        smull.w lower, upper, K2, B3
        smlal.w lower, upper, K3, B2       @ K2B3 + K3B2
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        vmov.w lower, tmp1, c1_lower, c1_upper
        smlal.w lower, tmp1, upper, root   @ root*(K2B3 + K3B2)
        smlal.w lower, tmp1, K0, B1
        smlal.w lower, tmp1, K1, B0        @ K0B1 + K1B0 + root*(K2B3 + K3B2)
        mul.w upper, lower, M_inv
        smlal.w lower, tmp1, upper, M
        vmov.w c1_upper, tmp1

        // for c2 = K0B2 + K2B0 + K1B1 + root*(K3B3)
        smull.w lower, upper, K3, B3       @ K3B3
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M      @ reduction
        vmov.w lower, tmp1, c2_lower, c2_upper
        smlal.w lower, tmp1, upper, root   @ root*(K3B3)
        smlal.w lower, tmp1, K0, B2
        smlal.w lower, tmp1, K1, B1
        smlal.w lower, tmp1, K2, B0        @ K0B2 + K2B0 + K1B1 + root*(K3B3)
        mul.w upper, lower, M_inv
        smlal.w lower, tmp1, upper, M
        @ c2 result in tmp1

        // for c3 = K0B3 + K3B0 + K1B2 + K2B1
        vmov.w lower, upper, c3_lower, c3_upper
        smlal.w lower, upper, K0, B3
        smlal.w lower, upper, K3, B0
        smlal.w lower, upper, K1, B2
        smlal.w lower, upper, K2, B1       @ K0B3 + K3B0 + K1B2 + K2B1
        mul.w K0, lower, M_inv
        smlal.w lower, upper, K0, M
        @ c3 result in upper


        vmov.w mul_out, tmp_mul_out
        vstr.w c0_upper, [mul_out, #0]
        vstr.w c1_upper, [mul_out, #4]
        str.w tmp1, [mul_out, #8]
        str.w upper, [mul_out, #12]
        add.w mul_out, #16
        vmov.w tmp_mul_out, mul_out

        vmov.w counter, tmp_counter
        cmp.w mul_out, counter
        bne.w my_multiply

pop.w {r4-r12, pc}

