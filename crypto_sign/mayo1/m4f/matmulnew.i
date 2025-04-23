#include "gf16_madd_bitsliced.i"
#include "gf16_bitslice.i"


.macro bitsliced_32_vec_mul_add acc0, acc1, acc2, acc3, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2, tmp3, incr
    ldr.w \tmp1, [\mat, #4*1]
    ldr.w \tmp2, [\mat, #4*2]
    ldr.w \tmp3, [\mat, #4*3]
    .if \incr < 256
    ldr.w \tmp0, [\mat], \incr
    .else
    ldr.w \tmp0, [\mat]
    add.w \mat, \mat, \incr
    .endif

    gf16_bitslice \mat0, \mat1, \mat2, \mat3, \tmp0, \tmp1, \tmp2, \tmp3

    gf16_madd_bitsliced \acc0, \acc1, \acc2, \acc3, \mat0, \mat1, \mat2, \mat3, \bbb, \tmp0, \tmp1, \tmp2
.endm


// specialized version of bitsliced_32_vec_mul_add only processing two instead of 4 words of mat
.macro bitsliced_32_vec_mul_add_dual acc0, acc1, acc2, acc3, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2, tmp3, incr
    ldr.w \tmp1, [\mat, #4*1]
    .if \incr < 256
    ldr.w \tmp0, [\mat], \incr
    .else
    ldr.w \tmp0, [\mat]
    add.w \mat, \mat, \incr
    .endif

    gf16_bitslice_dual \mat0, \mat1, \mat2, \mat3, \tmp0, \tmp1

    gf16_madd_bitsliced \acc0, \acc1, \acc2, \acc3, \mat0, \mat1, \mat2, \mat3, \bbb, \tmp0, \tmp1, \tmp2
.endm


.macro mul_add_mat_x_m_mat_m4f mat_rows, mat_cols, bs_mat_cols, m
    .set m_vec_limbs, ((\m + 15)/16)
    push {r4-r11, r14}
    acc .req r0
    ctr .req r7
    bbb .req r1
    mat .req r2

    accu0 .req r3
    accu1 .req r4
    accu2 .req r5
    accu3 .req r6

    mat0 .req r0
    mat1 .req r8
    mat2 .req r9
    mat3 .req r10

    tmp0 .req r11
    tmp1 .req r12
    tmp2 .req r14
    tmp3 .req r7

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
    ctr1f .req s11

    acc_in .req s12
    mat_in .req s13
    bbb_in .req s14

    .if m_vec_limbs % 2 != 0
    vmov.w acc_in, acc
    vmov.w mat_in, mat
    vmov.w bbb_in, bbb
    .endif

    vmov.w mat_orig, mat
    vmov.w mat_cur, mat
    vmov acc_orig, acc
    vmov.w bbb_orig, bbb


    // first loop processes m_vec_limbs/2 limbs such that bitslicing is straightforward
    // if m_vec_limbs is odd (as for MAYO1,3), the last limb is processed separately
    mov.w tmp0, m_vec_limbs/2
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

          // MAYO code does not need the accumulating version; can just initiatilze to zero here
          //ldr.w tmp0, [acc]
          //ldr.w tmp1, [acc, #4]
          //ldr.w tmp2, [acc, #8]
          //ldr.w tmp3, [acc, #12]
          //gf16_bitslice accu0, accu1, accu2, accu3, tmp0, tmp1, tmp2, tmp3
          mov.w accu0, #0
          mov.w accu1, #0
          mov.w accu2, #0
          mov.w accu3, #0

          vmov.w bbbf, bbb_cur

          mov.w ctr, \mat_cols
          vmov.w ctr1f, ctr
          1:
            vmov.w tmp0, bbbf
            ldrb.w bbb, [tmp0], #1
            vmov.w bbbf, tmp0

            bitsliced_32_vec_mul_add accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2, tmp3, m_vec_limbs*8*\bs_mat_cols

            vmov.w ctr, ctr1f
            subs.w ctr, ctr, #1
            vmov.w ctr1f, ctr
            bne.w 1b


          gf16_bitslice tmp0, tmp1, tmp2, tmp3, accu0, accu1, accu2, accu3,

          vmov.w acc, accf
          str.w tmp1, [acc, #1*4]
          str.w tmp2, [acc, #2*4]
          str.w tmp3, [acc, #3*4]
          str.w tmp0, [acc], m_vec_limbs * 8
          vmov.w accf, acc


          vmov.w mat, mat_cur
          add.w mat, mat, 8*m_vec_limbs
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
      add.w acc, acc,  #16
      vmov.w acc_orig, acc

      vmov.w mat, mat_orig
      add.w mat, mat, #16
      vmov.w mat_orig, mat
      vmov.w mat_cur, mat

      vmov.w tmp0, ctr4f
      subs.w tmp0, tmp0, #1
      bne 4b

    // handle odd case
    .if m_vec_limbs % 2 != 0
    vmov.w acc, acc_in
    vmov.w mat, mat_in
    vmov.w bbb, bbb_in

    // TODO: try to just compute this relative to the previous values
    add acc, (m_vec_limbs/2)*16
    add mat, (m_vec_limbs/2)*16


    vmov.w mat_orig, mat
    vmov.w mat_cur, mat
    vmov acc_orig, acc
    vmov.w bbb_orig, bbb

    vmov.w ctr4f, tmp0
    vmov.w accf, acc
    vmov.w bbb_cur, bbb_orig

    mov.w tmp0, \mat_rows
    3:
      vmov.w ctr3f, tmp0

      mov.w tmp0, \bs_mat_cols
      2:
        vmov.w ctr2f, tmp0


        // MAYO code does not need the accumulating version; can just initiatilze to zero here
        //ldr.w tmp0, [acc]
        //ldr.w tmp1, [acc, #4]
        //ldr.w tmp2, [acc, #8]
        //ldr.w tmp3, [acc, #12]
        //gf16_bitslice accu0, accu1, accu2, accu3, tmp0, tmp1, tmp2, tmp3
        mov.w accu0, #0
        mov.w accu1, #0
        mov.w accu2, #0
        mov.w accu3, #0

        vmov.w bbbf, bbb_cur

        mov.w ctr, \mat_cols
        vmov.w ctr1f, ctr
        1:
          vmov.w tmp0, bbbf
          ldrb.w bbb, [tmp0], #1
          vmov.w bbbf, tmp0
          bitsliced_32_vec_mul_add_dual accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2, tmp3, m_vec_limbs*8*\bs_mat_cols

          vmov.w ctr, ctr1f
          subs.w ctr, ctr, #1
          vmov.w ctr1f, ctr
          bne.w 1b

        gf16_unbitslice_dual tmp0, tmp1, accu0, accu1, accu2, accu3

        vmov.w acc, accf
        str.w tmp1, [acc, #1*4]
        str.w tmp0, [acc], m_vec_limbs * 8
        vmov.w accf, acc

        vmov.w mat, mat_cur
        add.w mat, mat, 8*m_vec_limbs
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

    .endif
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
    .unreq ctr1f
    .unreq acc_orig
    .unreq mat_orig
    .unreq bbb_orig
    .unreq accf
    .unreq matf
    .unreq bbbf
    .unreq bbb_cur
    .unreq mat_cur
    .unreq acc_in
    .unreq mat_in
    .unreq bbb_in

.endm

.macro mul_add_mat_trans_x_m_mat_m4f mat_rows, mat_cols, bs_mat_cols, m
    .set m_vec_limbs, ((\m + 15)/16)
    push {r4-r11, r14}
    acc .req r0
    ctr .req r7
    mat .req r2
    bbb .req r1

    accu0 .req r3
    accu1 .req r4
    accu2 .req r5
    accu3 .req r6

    mat0 .req r0
    mat1 .req r8
    mat2 .req r9
    mat3 .req r10

    tmp0 .req r11
    tmp1 .req r12
    tmp2 .req r14
    tmp3 .req r7

    ctr1f    .req s0
    ctr2f    .req s1
    ctr3f    .req s2
    ctr4f    .req s3
    bbbf     .req s4
    acc_orig .req s5
    mat_orig .req s6
    acc_cur  .req s7
    bbb_orig .req s8
    acc_x    .req s9
    acc_in   .req s10
    mat_in   .req s11
    bbb_in   .req s12

    .if m_vec_limbs % 2 != 0
    vmov.w acc_in, acc
    vmov.w mat_in, mat
    vmov.w bbb_in, bbb
    .endif

    vmov.w acc_x, acc


    // first loop processes m_vec_limbs/2 limbs such that bitslicing is straightforward
    // if m_vec_limbs is odd (as for MAYO1,3), the last limb is processed separately
    mov.w ctr, m_vec_limbs/2
    vmov.w ctr4f, ctr
    4:


    vmov.w acc_orig, acc
    vmov.w mat_orig, mat
    vmov.w bbb_orig, bbb

    mov.w ctr, \mat_cols
    vmov.w ctr3f, ctr
    3:
      vmov.w acc_cur, acc
      mov.w ctr, \bs_mat_cols
      vmov.w ctr2f, ctr
      2:


        vmov.w bbbf, bbb_orig

        // MAYO code does not need the accumulating version; can just initiatilze to zero here
        //ldr.w tmp0, [acc]
        //ldr.w tmp1, [acc, #4]
        //ldr.w tmp2, [acc, #8]
        //ldr.w tmp3, [acc, #12]
        //gf16_bitslice accu0, accu1, accu2, accu3, tmp0, tmp1, tmp2, tmp3
        mov.w accu0, #0
        mov.w accu1, #0
        mov.w accu2, #0
        mov.w accu3, #0

        mov.w ctr, \mat_rows
        vmov.w ctr1f, ctr
        1:
            vmov.w tmp0, bbbf
            ldrb.w bbb, [tmp0], \mat_cols
            vmov.w bbbf, tmp0


            bitsliced_32_vec_mul_add accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2, tmp3, m_vec_limbs*8*\bs_mat_cols

            vmov.w ctr, ctr1f
            subs.w ctr, ctr, #1
            vmov.w ctr1f, ctr
            bne.w 1b


        gf16_bitslice tmp0, tmp1, tmp2, tmp3, accu0, accu1, accu2, accu3

        vmov.w acc, acc_cur
        str.w tmp1, [acc, #4]
        str.w tmp2, [acc, #8]
        str.w tmp3, [acc, #12]
        str.w tmp0, [acc], m_vec_limbs * 8
        vmov.w acc_cur, acc


        vmov.w mat, mat_orig
        add.w mat, #8*m_vec_limbs
        vmov.w mat_orig, mat

        vmov.w ctr, ctr2f
        subs.w ctr, ctr, #1
        vmov.w ctr2f, ctr
        bne.w 2b

        vmov.w mat, mat_orig
        sub.w mat, #8*m_vec_limbs * \bs_mat_cols
        vmov.w mat_orig, mat

        vmov.w bbb, bbb_orig
        add.w bbb, #1
        vmov.w bbb_orig, bbb

        vmov.w ctr, ctr3f
        subs.w ctr, ctr, #1
        vmov.w ctr3f, ctr
        bne.w 3b


        vmov.w acc, acc_x
        add.w acc, #16
        vmov.w acc_x, acc


        sub.w bbb, \mat_cols
        add.w mat, #16


        vmov.w ctr, ctr4f
        subs.w ctr, ctr, #1
        vmov.w ctr4f, ctr
        bne.w 4b

    // handle odd case
    .if m_vec_limbs % 2 != 0
    vmov.w acc, acc_in
    vmov.w mat, mat_in
    vmov.w bbb, bbb_in

    // TODO: try to just compute this relative to the previous values
    add acc, (m_vec_limbs/2)*16
    add mat, (m_vec_limbs/2)*16

    vmov.w acc_x, acc
    vmov.w acc_orig, acc
    vmov.w mat_orig, mat
    vmov.w bbb_orig, bbb

    mov.w ctr, \mat_cols
    vmov.w ctr3f, ctr
    3:
      vmov.w acc_cur, acc
      mov.w ctr, \bs_mat_cols
      vmov.w ctr2f, ctr
      2:


        vmov.w bbbf, bbb_orig

        // MAYO code does not need the accumulating version; can just initiatilze to zero here
        //ldr.w tmp0, [acc]
        //ldr.w tmp1, [acc, #4]
        //ldr.w tmp2, [acc, #8]
        //ldr.w tmp3, [acc, #12]
        //gf16_bitslice accu0, accu1, accu2, accu3, tmp0, tmp1, tmp2, tmp3
        mov.w accu0, #0
        mov.w accu1, #0
        mov.w accu2, #0
        mov.w accu3, #0

        mov.w ctr, \mat_rows
        vmov.w ctr1f, ctr
        1:
            vmov.w tmp0, bbbf
            ldrb.w bbb, [tmp0], \mat_cols
            vmov.w bbbf, tmp0

            bitsliced_32_vec_mul_add_dual accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, mat, bbb, tmp0, tmp1, tmp2, tmp3, m_vec_limbs*8*\bs_mat_cols

            vmov.w ctr, ctr1f
            subs.w ctr, ctr, #1
            vmov.w ctr1f, ctr
            bne.w 1b

        gf16_unbitslice_dual tmp0, tmp1, accu0, accu1, accu2, accu3

        vmov.w acc, acc_cur
        str.w tmp1, [acc, #4]
        str.w tmp0, [acc], m_vec_limbs * 8
        vmov.w acc_cur, acc


        vmov.w mat, mat_orig
        add.w mat, #8*m_vec_limbs
        vmov.w mat_orig, mat

        vmov.w ctr, ctr2f
        subs.w ctr, ctr, #1
        vmov.w ctr2f, ctr
        bne.w 2b

        vmov.w mat, mat_orig
        sub.w mat, #8*m_vec_limbs * \bs_mat_cols
        vmov.w mat_orig, mat

        vmov.w bbb, bbb_orig
        add.w bbb, #1
        vmov.w bbb_orig, bbb

        vmov.w ctr, ctr3f
        subs.w ctr, ctr, #1
        vmov.w ctr3f, ctr
        bne.w 3b
    .endif
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
    .unreq tmp3

    .unreq ctr1f
    .unreq ctr2f
    .unreq ctr3f
    .unreq ctr4f
    .unreq bbbf
    .unreq acc_orig
    .unreq mat_orig
    .unreq acc_cur
    .unreq bbb_orig
    .unreq acc_x
    .unreq acc_in
    .unreq mat_in
    .unreq bbb_in
.endm