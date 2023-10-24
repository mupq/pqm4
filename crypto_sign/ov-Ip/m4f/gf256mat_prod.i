#include "gf256_madd.i"

.macro shift_fpu f0, f1, f2, f3, f4, f5, f6, f7, tmp
  vmov.w \tmp, \f0
  lsr.w \tmp, #8
  vmov.w \f0, \tmp

  vmov.w \tmp, \f1
  lsr.w \tmp, #8
  vmov.w \f1, \tmp

  vmov.w \tmp, \f2
  lsr.w \tmp, #8
  vmov.w \f2, \tmp

  vmov.w \tmp, \f3
  lsr.w \tmp, #8
  vmov.w \f3, \tmp

  vmov.w \tmp, \f4
  lsr.w \tmp, #8
  vmov.w \f4, \tmp

  vmov.w \tmp, \f5
  lsr.w \tmp, #8
  vmov.w \f5, \tmp

  vmov.w \tmp, \f6
  lsr.w \tmp, #8
  vmov.w \f6, \tmp

  vmov.w \tmp, \f7
  lsr.w \tmp, #8
  vmov.w \f7, \tmp
.endm

.macro gf256_mat_prod_x n_A_vec_byte
  push {r4-r11, lr}
  vpush {s16-s23}

  cptr .req r0
  aptr .req r1
  bptr .req r2
  n_A_width .req r3
  bb .req r3


  tmp1 .req r12
  tmp2 .req r14
  tmp3 .req r2
  tmp4 .req r0

  accuf0 .req s0
  accuf1 .req s1
  accuf2 .req s2
  accuf3 .req s3
  accuf4 .req s4
  accuf5 .req s5
  accuf6 .req s6
  accuf7 .req s7

  fbx0  .req s8
  fbx1  .req s9
  fbx2  .req s10
  fbx3  .req s11
  fbx4  .req s12
  fbx5  .req s13
  fbx6  .req s14
  fbx7  .req s15

  zerof .req s16
  b_ptr_orig_f .req s17
  b_ptr_f .req s18
  c_ptr_f .req s19
  ctrf0 .req s20
  ctrf1 .req s21
  offsetf .req s22

  n_A_widthf .req s23


  vmov.w b_ptr_orig_f, bptr
  vmov.w b_ptr_f, bptr
  vmov.w c_ptr_f, cptr
  vmov.w n_A_widthf, n_A_width

  add.w r4, cptr, #\n_A_vec_byte - (\n_A_vec_byte%32)
  vmov.w ctrf0, r4

  mov.w r4, #0
  vmov.w zerof, r4

  mov.w r4, #\n_A_vec_byte
  mul.w r4, r4, n_A_width
  sub.w r4, r4, #32
  vmov.w offsetf, r4

  mov.w r12, #0x01010101
  mov.w r14, #0x1b
   1:

    vmov.w accuf0, zerof
    vmov.w accuf1, zerof
    vmov.w accuf2, zerof
    vmov.w accuf3, zerof
    vmov.w accuf4, zerof
    vmov.w accuf5, zerof
    vmov.w accuf6, zerof
    vmov.w accuf7, zerof

    vmov.w r4, n_A_widthf
    2:
        ldr.w bb, [bptr], #4
        vmov.w b_ptr_f, bptr
        gf256_madd_precompb fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, bb, r12, r14, tmp3

        // check if more than 4 elements
        cmp.w r4, #4
        bge.w 3f

        4:
        vmov.w ctrf1, r4

        ldr.w r4, [aptr, #0*4]
        ldr.w r5, [aptr, #1*4]
        ldr.w r6, [aptr, #2*4]
        ldr.w r7, [aptr, #3*4]

        vmov.w r8, accuf0
        vmov.w r9, accuf1
        vmov.w r10, accuf2
        vmov.w r11, accuf3

        gf256_madd_x4 4, 0, r8, r9, r10, r11, r4, r5, r6, r7, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, r12, tmp3, tmp4

        vmov.w accuf0, r8
        vmov.w accuf1, r9
        vmov.w accuf2, r10
        vmov.w accuf3, r11

        ldr.w r4, [aptr, #4*4]
        ldr.w r5, [aptr, #5*4]
        ldr.w r6, [aptr, #6*4]
        ldr.w r7, [aptr, #7*4]

        vmov.w r8, accuf4
        vmov.w r9, accuf5
        vmov.w r10, accuf6
        vmov.w r11, accuf7
        gf256_madd_x4 4, 0, r8, r9, r10, r11, r4, r5, r6, r7, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, r12, tmp3, tmp4

        vmov.w accuf4, r8
        vmov.w accuf5, r9
        vmov.w accuf6, r10
        vmov.w accuf7, r11

        add.w aptr, #\n_A_vec_byte
        shift_fpu fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, tmp2


        vmov.w r4, ctrf1
        subs.w r4, r4, #1
        bne 4b
        b 5f

        3:
        vmov.w ctrf1, r4
        .set k, 0
        .rept 4
        ldr.w r4, [aptr, #0*4]
        ldr.w r5, [aptr, #1*4]
        ldr.w r6, [aptr, #2*4]
        ldr.w r7, [aptr, #3*4]

        vmov.w r8, accuf0
        vmov.w r9, accuf1
        vmov.w r10, accuf2
        vmov.w r11, accuf3

        gf256_madd_x4 4, k, r8, r9, r10, r11, r4, r5, r6, r7, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, r12, tmp3, tmp4

        vmov.w accuf0, r8
        vmov.w accuf1, r9
        vmov.w accuf2, r10
        vmov.w accuf3, r11

        ldr.w r4, [aptr, #4*4]
        ldr.w r5, [aptr, #5*4]
        ldr.w r6, [aptr, #6*4]
        ldr.w r7, [aptr, #7*4]

        vmov.w r8, accuf4
        vmov.w r9, accuf5
        vmov.w r10, accuf6
        vmov.w r11, accuf7

        gf256_madd_x4 4, k, r8, r9, r10, r11, r4, r5, r6, r7, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, r12, tmp3, tmp4

        vmov.w accuf4, r8
        vmov.w accuf5, r9
        vmov.w accuf6, r10
        vmov.w accuf7, r11

        add.w aptr, #\n_A_vec_byte
        .set k, k+1
        .endr

        vmov.w bptr, b_ptr_f
        vmov.w r4, ctrf1
        subs.w r4, r4, #4
        bne 2b

    5:
    vmov.w bptr, b_ptr_orig_f

    // (\n_A_vec_byte*\n_A_width-32)
    vmov.w r4, offsetf
    sub.w aptr, r4
    vmov.w cptr, c_ptr_f
    vstr.w accuf0, [cptr, #0*4]
    vstr.w accuf1, [cptr, #1*4]
    vstr.w accuf2, [cptr, #2*4]
    vstr.w accuf3, [cptr, #3*4]
    vstr.w accuf4, [cptr, #4*4]
    vstr.w accuf5, [cptr, #5*4]
    vstr.w accuf6, [cptr, #6*4]
    vstr.w accuf7, [cptr, #7*4]
    add.w cptr, #8*4
    vmov.w c_ptr_f, cptr

    vmov.w r4, ctrf0
    cmp.w r0, r4
    bne.w 1b

    .if \n_A_vec_byte % 32 != 0
    .if \n_A_vec_byte % 4 == 0
    .set num_words, (\n_A_vec_byte % 32)/4
    .if num_words > 4
        ERROR (not implemented yet)
    .endif



    mov.w r8, #0
    .if num_words >= 2
    mov.w r9, #0
    .endif
    .if num_words >= 3
    mov.w r10, #0
    .endif
    .if num_words >= 4
    mov.w r11, #0
    .endif

    mov.w r12, #0x1b
    mov.w r7, #0x01010101

    vmov.w r4, n_A_widthf



    .if num_words >= 4
    vmov.w b_ptr_f, bptr
    .endif
    2:

        ldr.w bb, [bptr], #4
        gf256_madd_precompb fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, bb, r7, r12, tmp2
        // check if more than 4 elements
        cmp.w r4, #4
        bge.w 3f

        4:
        vmov.w ctrf1, r4

        ldr.w r4, [aptr]
        .if num_words >= 2
        ldr.w r5, [aptr, #4]
        .endif
        .if num_words >= 3
        ldr.w r6, [aptr, #8]
        .endif
        .if num_words >= 4
        ldr.w r2, [aptr, #12]
        .endif
        add.w aptr, #\n_A_vec_byte
        gf256_madd_x4 num_words, 0, r8, r9, r10, r11, r4, r5, r6, r2, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, r7, tmp2, tmp4

        shift_fpu fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, tmp2

        vmov.w r4, ctrf1
        subs.w r4, r4, #1
        bne 4b
        b 5f


        3:
        .if num_words >= 4
        vmov.w b_ptr_f, bptr
        .endif

        vmov.w ctrf1, r4
        .set k, 0
        .rept 4
        ldr.w r4, [aptr]
        .if num_words >= 2
        ldr.w r5, [aptr, #4]
        .endif
        .if num_words >= 3
        ldr.w r6, [aptr, #8]
        .endif
        .if num_words >= 4
        ldr.w r2, [aptr, #12]
        .endif
        add.w aptr, #\n_A_vec_byte
        gf256_madd_x4 num_words, k, r8, r9, r10, r11, r4, r5, r6, r2, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, r7, tmp2, tmp4
        .set k,k+1
        .endr


        .if num_words >= 4
        vmov.w bptr, b_ptr_f
        .endif
        vmov.w r4, ctrf1
        subs.w r4, #4
        bne 2b
    5:

    vmov.w cptr, c_ptr_f
    str.w r8, [cptr], #4
    .if num_words >= 2
    str.w r9, [cptr], #4
    .endif
    .if num_words >= 3
    str.w r10, [cptr], #4
    .endif
    .if num_words >= 4
    str.w r11, [cptr], #4
    .endif
    .else
    ERROR
    .endif
    .endif

  vpop {s16-s23}
  pop {r4-r11, pc}
.endm


.macro gf256_mat_prod n_A_vec_byte, n_A_width
  .if \n_A_width % 4 != 0
    ERROR (not implemented yet)
  .endif

  push {r4-r11, lr}
  vpush {s16-s22}

  cptr .req r0
  aptr .req r1
  bptr .req r2

  bb .req r3


  tmp1 .req r12
  tmp2 .req r14
  tmp3 .req r2
  tmp4 .req r0

  accuf0 .req s0
  accuf1 .req s1
  accuf2 .req s2
  accuf3 .req s3
  accuf4 .req s4
  accuf5 .req s5
  accuf6 .req s6
  accuf7 .req s7

  fbx0  .req s8
  fbx1  .req s9
  fbx2  .req s10
  fbx3  .req s11
  fbx4  .req s12
  fbx5  .req s13
  fbx6  .req s14
  fbx7  .req s15

  zerof .req s16
  b_ptr_orig_f .req s17
  b_ptr_f .req s18
  c_ptr_f .req s19
  ctrf0 .req s20
  ctrf1 .req s21
  offsetf .req s22


  vmov.w b_ptr_orig_f, bptr
  vmov.w b_ptr_f, bptr
  vmov.w c_ptr_f, cptr

  add.w r4, cptr, #\n_A_vec_byte - (\n_A_vec_byte%32)
  vmov.w ctrf0, r4

  mov.w r4, #0
  vmov.w zerof, r4

  movw.w r4, #:lower16:(\n_A_vec_byte*\n_A_width-32)
  movt.w r4, #:upper16:(\n_A_vec_byte*\n_A_width-32)
  vmov.w offsetf, r4
  mov.w r12, #0x01010101
  mov.w r14, #0x1b
   1:

    vmov.w accuf0, zerof
    vmov.w accuf1, zerof
    vmov.w accuf2, zerof
    vmov.w accuf3, zerof
    vmov.w accuf4, zerof
    vmov.w accuf5, zerof
    vmov.w accuf6, zerof
    vmov.w accuf7, zerof

    add.w r4, bptr, #\n_A_width
    vmov.w ctrf1, r4

    2:
        ldr.w bb, [bptr], #4
        vmov.w b_ptr_f, bptr
        gf256_madd_precompb fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, bb, r12, r14, tmp3

        .set k, 0
        .rept 4
        ldr.w r4, [aptr, #0*4]
        ldr.w r5, [aptr, #1*4]
        ldr.w r6, [aptr, #2*4]
        ldr.w r7, [aptr, #3*4]

        vmov.w r8, accuf0
        vmov.w r9, accuf1
        vmov.w r10, accuf2
        vmov.w r11, accuf3

        gf256_madd_x4 4, k, r8, r9, r10, r11, r4, r5, r6, r7, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, r12, tmp3, tmp4

        vmov.w accuf0, r8
        vmov.w accuf1, r9
        vmov.w accuf2, r10
        vmov.w accuf3, r11

        ldr.w r4, [aptr, #4*4]
        ldr.w r5, [aptr, #5*4]
        ldr.w r6, [aptr, #6*4]
        ldr.w r7, [aptr, #7*4]

        vmov.w r8, accuf4
        vmov.w r9, accuf5
        vmov.w r10, accuf6
        vmov.w r11, accuf7

        gf256_madd_x4 4, k, r8, r9, r10, r11, r4, r5, r6, r7, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, r12, tmp3, tmp4

        vmov.w accuf4, r8
        vmov.w accuf5, r9
        vmov.w accuf6, r10
        vmov.w accuf7, r11

        add.w aptr, #\n_A_vec_byte
        .set k, k+1
        .endr

        vmov.w bptr, b_ptr_f
        vmov.w r4, ctrf1
        cmp.w bptr, r4
        bne 2b

    vmov.w bptr, b_ptr_orig_f

    // (\n_A_vec_byte*\n_A_width-32)
    vmov.w r4, offsetf
    sub.w aptr, r4
    vmov.w cptr, c_ptr_f
    vstr.w accuf0, [cptr, #0*4]
    vstr.w accuf1, [cptr, #1*4]
    vstr.w accuf2, [cptr, #2*4]
    vstr.w accuf3, [cptr, #3*4]
    vstr.w accuf4, [cptr, #4*4]
    vstr.w accuf5, [cptr, #5*4]
    vstr.w accuf6, [cptr, #6*4]
    vstr.w accuf7, [cptr, #7*4]
    add.w cptr, #8*4
    vmov.w c_ptr_f, cptr

    vmov.w r4, ctrf0
    cmp.w r0, r4
    bne.w 1b

    .if \n_A_vec_byte % 32 != 0
    .if \n_A_vec_byte % 4 == 0
    .set num_words, (\n_A_vec_byte % 32)/4
    .if num_words > 4
        ERROR (not implemented yet)
    .endif



    mov.w r8, #0
    .if num_words >= 2
    mov.w r9, #0
    .endif
    .if num_words >= 3
    mov.w r10, #0
    .endif
    .if num_words >= 4
    mov.w r11, #0
    .endif

    mov.w r12, #0x1b
    mov.w r7, #0x01010101
    add.w r4, bptr, #\n_A_width
    vmov.w ctrf1, r4
    .if num_words >= 4
    vmov.w b_ptr_f, bptr
    .endif
    2:

        ldr.w bb, [bptr], #4
        gf256_madd_precompb fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, bb, r7, r12, tmp2
        .if num_words >= 4
        vmov.w b_ptr_f, bptr
        .endif

        .set k, 0
        .rept 4

        ldr.w r4, [aptr]
        .if num_words >= 2
        ldr.w r5, [aptr, #4]
        .endif
        .if num_words >= 3
        ldr.w r6, [aptr, #8]
        .endif
        .if num_words >= 4
        ldr.w r2, [aptr, #12]
        .endif
        add.w aptr, #\n_A_vec_byte
        gf256_madd_x4 num_words, k, r8, r9, r10, r11, r4, r5, r6, r2, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, r7, tmp2, tmp4
        .set k,k+1
        .endr

        vmov.w r4, ctrf1
        .if num_words >= 4
        vmov.w bptr, b_ptr_f
        .endif
        cmp.w bptr, r4
        bne 2b

    vmov.w cptr, c_ptr_f
    str.w r8, [cptr], #4
    .if num_words >= 2
    str.w r9, [cptr], #4
    .endif
    .if num_words >= 3
    str.w r10, [cptr], #4
    .endif
    .if num_words >= 4
    str.w r11, [cptr], #4
    .endif
    .else
    ERROR
    .endif
    .endif

  vpop {s16-s22}
  pop {r4-r11, pc}
.endm