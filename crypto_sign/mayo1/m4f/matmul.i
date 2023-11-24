
#include "gf16_madd_bitsliced.i"


.macro bitsliced_32_vec_mul_add m_legs, acc0, acc1, acc2, acc3, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2, incr
    ldr.w \mat1, [\mat, #4*1*\m_legs]
    ldr.w \mat2, [\mat, #4*2*\m_legs]
    ldr.w \mat3, [\mat, #4*3*\m_legs]
    .if \incr < 256
    ldr.w \mat0, [\mat], \incr
    .else
    ldr.w \mat0, [\mat]
    add.w \mat, \mat, \incr
    .endif

    gf16_madd_bitsliced \acc0, \acc1, \acc2, \acc3, \mat0, \mat1, \mat2, \mat3, \bbb, \tmp0, \tmp1, \tmp2
.endm



/*
void mul_add_bitsliced_m_upper_triangular_mat_x_mat_m4f(int m_legs, const uint32_t *bs_mat, const unsigned char *mat, uint32_t *acc, int bs_mat_rows, int bs_mat_cols, int mat_cols, int triangular) {
    int bs_mat_entries_used;
    for(int i = 0; i < m_legs; i++){
        bs_mat_entries_used = 0;
        for (int r = 0; r < bs_mat_rows; r++) {
            for (int k = 0; k < mat_cols; k += 1) {
                for (int c = triangular * r; c < bs_mat_cols; c++) {

                    #ifdef transpose
                    bitsliced_32_vec_mul_add(m_legs, bs_mat + m_legs * 4 * bs_mat_entries_used + i, mat[k * bs_mat_cols + c], acc + m_legs * 4 * (r * mat_cols + k) + i);
                    #else
                    bitsliced_32_vec_mul_add(m_legs, bs_mat + m_legs * 4 * bs_mat_entries_used + i, mat[c * mat_cols + k], acc + m_legs * 4 * (r * mat_cols + k) + i);
                    #endif
                    bs_mat_entries_used += 1;
                }
                bs_mat_entries_used -= bs_mat_cols - triangular * r;
            }
            bs_mat_entries_used += bs_mat_cols - triangular * r;
        }
    }
}
*/

.macro mul_add_bitsliced_m_upper_triangular_mat_x_mat_m4f dim1, transpose, triangular, dim3, m
    .set m_legs, (\m/32)
    push {r4-r11, r14}
    acc .req r0
    ctr .req r0
    mat .req r1
    bbb .req r2

    accu0 .req r3
    accu1 .req r4
    accu2 .req r5
    accu3 .req r6

    mat0 .req r7
    mat1 .req r8
    mat2 .req r9
    mat3 .req r10

    tmp0 .req r11
    tmp1 .req r12
    tmp2 .req r14



    ctr4f    .req s0
    ctr3f    .req s1
    ctr2f    .req s2

    acc_orig .req s3
    mat_orig .req s4
    bbb_orig .req s5

    accf     .req s6
    matf     .req s7
    bbbf     .req s8

    bbb_cur .req s9

    vmov mat_orig, mat
    vmov acc_orig, acc
    vmov.w bbb_orig, bbb

    mov.w tmp0, m_legs
    4:
    vmov.w ctr4f, tmp0
    vmov.w accf, acc

    mov.w tmp0, \dim1
    3:
      vmov.w ctr3f, tmp0
      vmov.w matf, mat
      vmov.w bbb_cur, bbb_orig

      mov.w tmp0, \dim3
      2:
        vmov.w ctr2f, tmp0
        vmov.w mat, matf

        ldr.w accu0, [acc, 0*m_legs*4]
        ldr.w accu1, [acc, 1*m_legs*4]
        ldr.w accu2, [acc, 2*m_legs*4]
        ldr.w accu3, [acc, 3*m_legs*4]

        vmov.w tmp0, bbb_cur
        vmov.w bbbf, tmp0
        .if \transpose == 0
          add.w tmp0, #1
        .else
          add.w tmp0, \dim1
        .endif
        vmov.w bbb_cur, tmp0

        .if \triangular == 0
          mov ctr, \dim1
        .else
          vmov.w tmp1, bbbf
          vmov.w ctr, ctr3f
          rsb.w tmp0, ctr, \dim1
          .if \transpose == 0
            mov.w tmp2, \dim3
            mla.w tmp1, tmp0, tmp2, tmp1
          .else
            add.w tmp1, tmp0
          .endif
          vmov bbbf, tmp1
        .endif
        1:
          vmov.w tmp0, bbbf
          .if \transpose == 0
            ldrb bbb, [tmp0], \dim3
          .else
            ldrb bbb, [tmp0], #1
          .endif
          vmov.w bbbf, tmp0

          bitsliced_32_vec_mul_add m_legs, accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2, 4*m_legs*4
          subs.w ctr, ctr, #1
          bne.w 1b

        vmov.w acc, accf
        str.w accu1, [acc, 1*m_legs*4]
        str.w accu2, [acc, 2*m_legs*4]
        str.w accu3, [acc, 3*m_legs*4]
        str.w accu0, [acc], 4*m_legs*4

        vmov.w accf, acc

        vmov.w tmp0, ctr2f
        subs.w tmp0, tmp0, #1
        bne.w 2b
      vmov.w tmp0, ctr3f
      subs.w tmp0, tmp0, #1
      bne.w 3b

      vmov.w mat, mat_orig
      add.w mat, mat, #4
      vmov.w mat_orig, mat

      vmov.w acc, acc_orig
      add.w acc, acc, #4
      vmov.w acc_orig, acc

     vmov.w tmp0, ctr4f
     subs.w tmp0, tmp0, #1
     bne.w 4b
    pop.w {r4-r11, pc}


    .unreq acc
    .unreq ctr
    .unreq mat
    .unreq bbb
    .unreq accu0
    .unreq accu1
    .unreq accu2
    .unreq accu3
    .unreq mat0
    .unreq mat1
    .unreq mat2
    .unreq mat3
    .unreq tmp0
    .unreq tmp1
    .unreq tmp2
    .unreq ctr4f
    .unreq ctr3f
    .unreq ctr2f
    .unreq acc_orig
    .unreq mat_orig
    .unreq bbb_orig
    .unreq accf
    .unreq matf
    .unreq bbbf
    .unreq bbb_cur
.endm

.macro mul_add_mat_x_bitsliced_m_mat_m4f mat_rows, mat_cols, bs_mat_cols, m
  .set m_legs, (\m/32)
    push {r4-r11, r14}
    acc .req r0
    ctr .req r0
    bbb .req r1
    mat .req r2

    accu0 .req r3
    accu1 .req r4
    accu2 .req r5
    accu3 .req r6

    mat0 .req r7
    mat1 .req r8
    mat2 .req r9
    mat3 .req r10

    tmp0 .req r11
    tmp1 .req r12
    tmp2 .req r14

    ctr4f    .req s0
    ctr3f    .req s1
    ctr2f    .req s2

    acc_orig .req s3
    mat_orig .req s4
    bbb_orig .req s5

    accf     .req s6
    matf     .req s7
    bbbf     .req s8

    bbb_cur .req s9
    mat_cur .req s10

    vmov.w mat_orig, mat
    vmov.w mat_cur, mat
    vmov acc_orig, acc
    vmov.w bbb_orig, bbb

    mov.w tmp0, m_legs
    4:
      vmov.w ctr4f, tmp0
      vmov.w accf, acc
      vmov.w bbb_cur, bbb_orig

      mov.w tmp0, \mat_rows
      3:
        vmov.w ctr3f, tmp0

        mov.w tmp0, \bs_mat_cols
        2:
          vmov.w ctr2f, tmp0

          ldr.w accu0, [acc, 0*m_legs*4]
          ldr.w accu1, [acc, 1*m_legs*4]
          ldr.w accu2, [acc, 2*m_legs*4]
          ldr.w accu3, [acc, 3*m_legs*4]

          vmov.w bbbf, bbb_cur

          mov ctr, \mat_cols
          1:
            vmov.w tmp0, bbbf
            ldrb bbb, [tmp0], #1
            vmov.w bbbf, tmp0

            bitsliced_32_vec_mul_add m_legs, accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2, 4*m_legs*4*\bs_mat_cols

            subs.w ctr, ctr, #1
            bne.w 1b

          vmov.w acc, accf
          str.w accu1, [acc, 1*m_legs*4]
          str.w accu2, [acc, 2*m_legs*4]
          str.w accu3, [acc, 3*m_legs*4]
          str.w accu0, [acc], 4*m_legs*4
          vmov.w accf, acc

          vmov.w mat, mat_cur
          add.w mat, mat, 4*m_legs*4
          vmov.w mat_cur, mat

          vmov.w tmp0, ctr2f
          subs.w tmp0, tmp0, #1
          bne 2b

        vmov.w mat_cur, mat_orig
        vmov.w mat, mat_cur

        vmov.w tmp0, bbb_cur
        add.w tmp0, \mat_cols
        vmov.w bbb_cur, tmp0

        vmov.w tmp0, ctr3f
        subs.w tmp0, tmp0, #1
        bne 3b

      vmov.w acc, acc_orig
      add.w acc, acc, #4
      vmov.w acc_orig, acc

      vmov.w mat, mat_orig
      add.w mat, mat, #4
      vmov.w mat_orig, mat
      vmov.w mat_cur, mat

      vmov.w tmp0, ctr4f
      subs.w tmp0, tmp0, #1
      bne 4b
    pop.w {r4-r11, pc}

    .unreq acc
    .unreq ctr
    .unreq bbb
    .unreq mat
    .unreq accu0
    .unreq accu1
    .unreq accu2
    .unreq accu3
    .unreq mat0
    .unreq mat1
    .unreq mat2
    .unreq mat3
    .unreq tmp0
    .unreq tmp1
    .unreq tmp2
    .unreq ctr4f
    .unreq ctr3f
    .unreq ctr2f
    .unreq acc_orig
    .unreq mat_orig
    .unreq bbb_orig
    .unreq accf
    .unreq matf
    .unreq bbbf
    .unreq bbb_cur
    .unreq mat_cur
.endm


.macro mayo_expand_sk_computeL_inner1_m4f m, o
    .set m_legs, (\m/32)
    push.w {r4-r11, r14}
    mat .req r1
    bbb_ptr .req r2

    accu0 .req r3
    accu1 .req r4
    accu2 .req r5
    accu3 .req r6

    mat0 .req r7
    mat1 .req r8
    mat2 .req r9
    mat3 .req r10

    bbb_ptr_max .req s0
    acc_ptr .req s1
    acc_ptr_max .req s2

    mat_orig .req s3
    bbb_ptr_orig .req s4

    bbb .req r0

    add.w r12, r0, \o*16*m_legs
    vmov.w acc_ptr_max, r12
    vmov.w mat_orig, r1
    vmov.w bbb_ptr_max, r3
    vmov.w acc_ptr, r0
    vmov.w bbb_ptr_orig, bbb_ptr

    2:
        ldr.w accu0, [r0, 0*4*m_legs]
        ldr.w accu1, [r0, 1*4*m_legs]
        ldr.w accu2, [r0, 2*4*m_legs]
        ldr.w accu3, [r0, 3*4*m_legs]



        1:
            ldr.w mat1, [mat, 1*4*m_legs]
            ldr.w mat2, [mat, 2*4*m_legs]
            ldr.w mat3, [mat, 3*4*m_legs]
            ldr.w mat0, [mat], 4*4*m_legs

            ldrb.w bbb, [bbb_ptr], \o
            gf16_madd_bitsliced accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, bbb, r11, r12, r14


            vmov.w r12, bbb_ptr_max
            cmp.w r12, bbb_ptr
            bne.w 1b

        vmov.w r0, acc_ptr
        str.w accu1, [r0, 1*4*m_legs]
        str.w accu2, [r0, 2*4*m_legs]
        str.w accu3, [r0, 3*4*m_legs]
        str.w accu0, [r0], 16*m_legs
        vmov.w acc_ptr, r0

        vmov.w mat, mat_orig
        vmov.w r11, bbb_ptr_max
        add.w r11, r11, #1
        vmov.w bbb_ptr_max, r11
        vmov.w bbb_ptr, bbb_ptr_orig
        add.w bbb_ptr, #1
        vmov.w bbb_ptr_orig, bbb_ptr


        vmov.w r12, acc_ptr_max
        cmp.w r12, r0
        bne 2b

    pop.w {r4-r11, pc}

    .unreq mat
    .unreq bbb_ptr
    .unreq accu0
    .unreq accu1
    .unreq accu2
    .unreq accu3
    .unreq mat0
    .unreq mat1
    .unreq mat2
    .unreq mat3
    .unreq bbb_ptr_max
    .unreq acc_ptr
    .unreq acc_ptr_max
    .unreq mat_orig
    .unreq bbb_ptr_orig
    .unreq bbb
.endm


.macro mayo_expand_sk_computeL_inner2_m4f m, o, v
    .set m_legs, (\m/32)
    push.w {r4-r11, r14}

    mat .req r1
    bbb_ptr .req r2

    accu0 .req r3
    accu1 .req r4
    accu2 .req r5
    accu3 .req r6

    mat0 .req r7
    mat1 .req r8
    mat2 .req r9
    mat3 .req r10

    acc_ptr .req s1
    acc_ptr_max .req s2

    mat_orig .req s3
    bbb_ptr_orig .req s4

    bbb .req r0
    offset .req s0
    min_offset .req s7


    // offset = 16*m_legs*(param_v-1)
    // min_offset = 16*m_legs*(param_v - c - 1)
    mov.w r12, 16*m_legs
    rsb.w r11, r3, (\v-1)
    mul.w r12, r11, r12
    vmov.w min_offset, r12

    add.w r12, r0, \o*16*m_legs
    vmov.w acc_ptr_max, r12
    vmov.w acc_ptr, r0

    vmov.w mat_orig, r1
    vmov.w bbb_ptr_orig, bbb_ptr

    2:
    mov.w r12, 16*m_legs*(\v-1)
    vmov.w offset, r12


    ldr.w accu0, [r0, 0*4*m_legs]
    ldr.w accu1, [r0, 1*4*m_legs]
    ldr.w accu2, [r0, 2*4*m_legs]
    ldr.w accu3, [r0, 3*4*m_legs]
    1:
        ldr.w mat0, [mat, 0*4*m_legs]
        ldr.w mat1, [mat, 1*4*m_legs]
        ldr.w mat2, [mat, 2*4*m_legs]
        ldr.w mat3, [mat, 3*4*m_legs]


        ldrb.w bbb, [bbb_ptr], \o
        gf16_madd_bitsliced accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, bbb, r11, r12, r14


        vmov.w r12, offset
        add.w mat, r12
        sub.w r12, r12, 16*m_legs
        vmov.w offset, r12


        vmov.w r11, min_offset
        cmp.w r12, r11
        bne.w 1b

    vmov.w r0, acc_ptr
    str.w accu1, [r0, 1*4*m_legs]
    str.w accu2, [r0, 2*4*m_legs]
    str.w accu3, [r0, 3*4*m_legs]
    str.w accu0, [r0], 16*m_legs
    vmov.w acc_ptr, r0


    vmov.w mat, mat_orig
    vmov.w bbb_ptr, bbb_ptr_orig
    add.w bbb_ptr, #1
    vmov.w bbb_ptr_orig, bbb_ptr


    vmov.w r12, acc_ptr_max
    cmp.w r12, r0
    bne 2b


    pop.w {r4-r11, pc}
.endm