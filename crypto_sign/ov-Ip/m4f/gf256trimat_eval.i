#include "gf256_madd.i"

.macro gf256_trimat_eval dim, batch_size
  push {r4-r11, lr}
  vpush {s16-s31}
  .if \batch_size != 44
     ERROR: batch_size not implemented yet
  .endif

  tmp0 .req r4
  tmp1 .req r5
  tmp2 .req r6
  tmp3 .req r7
  tmp4 .req r8
  tmp5 .req r9
  tmp6 .req r10
  tmp7 .req r11
  tmp8 .req r3
  tmp9 .req r12
  tmp10 .req r14
  tmp11 .req r0
  iii .req r5
  jjj .req r6

  bb .req r2

  // 44 elements
  yf0 .req s0
  yf1 .req s1
  yf2 .req s2
  yf3 .req s3
  yf4 .req s4
  yf5 .req s5
  yf6 .req s6
  yf7 .req s7
  yf8 .req s8
  yf9 .req s9
  yf10 .req s10

  tf0 .req s11
  tf1 .req s12
  tf2 .req s13
  tf3 .req s14
  tf4 .req s15
  tf5 .req s16
  tf6 .req s17
  tf7 .req s18
  tf8 .req s19
  tf9 .req s20
  tf10 .req s21

  fbx0 .req s22
  fbx1 .req s23
  fbx2 .req s24
  fbx3 .req s25
  fbx4 .req s26
  fbx5 .req s27
  fbx6 .req s28
  fbx7 .req s29

  iiif .req s30
  jjjf .req s31

  // stack: y, x
  sub.w sp, sp, #2*4
  str.w r0, [sp, #0*4]
  str.w r2, [sp, #1*4]

  // set y to 0
  mov.w r4, #0
  vmov.w yf0, r4
  vmov.w yf1, r4
  vmov.w yf2, r4
  vmov.w yf3, r4
  vmov.w yf4, r4
  vmov.w yf5, r4
  vmov.w yf6, r4
  vmov.w yf7, r4
  vmov.w yf8, r4
  vmov.w yf9, r4
  vmov.w yf10, r4


  // TODO: rename
  mov.w tmp9,  #0x01010101
  mov.w tmp10, #0x1b

  mov.w iii, #0
  vmov.w iiif, iii
  1:
    // set tmp to 0
    mov.w r4, #0
    vmov.w tf0, r4
    vmov.w tf1, r4
    vmov.w tf2, r4
    vmov.w tf3, r4
    vmov.w tf4, r4
    vmov.w tf5, r4
    vmov.w tf6, r4
    vmov.w tf7, r4
    vmov.w tf8, r4
    vmov.w tf9, r4
    vmov.w tf10, r4

    mov.w jjj, iii
    vmov.w jjjf, jjj
    2:
        ldr.w bb, [sp, #1*4]
        ldrb.w bb, [bb, jjj]


        gf256_madd_precompb fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, bb, tmp9, tmp10, tmp11

        // first 16 elements
        ldr.w tmp1, [r1, #1*4]
        ldr.w tmp2, [r1, #2*4]
        ldr.w tmp3, [r1, #3*4]
        ldr.w tmp0, [r1], #4*4

        vmov.w tmp4, tf0
        vmov.w tmp5, tf1
        vmov.w tmp6, tf2
        vmov.w tmp7, tf3

        gf256_madd 4, tmp4, tmp5, tmp6, tmp7, tmp0, tmp1, tmp2, tmp3, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, tmp9, tmp11, bb

        vmov.w tf0, tmp4
        vmov.w tf1, tmp5
        vmov.w tf2, tmp6
        vmov.w tf3, tmp7

        // second 16 elements
        ldr.w tmp1, [r1, #1*4]
        ldr.w tmp2, [r1, #2*4]
        ldr.w tmp3, [r1, #3*4]
        ldr.w tmp0, [r1], #4*4


        vmov.w tmp4, tf4
        vmov.w tmp5, tf5
        vmov.w tmp6, tf6
        vmov.w tmp7, tf7
  
        gf256_madd 4, tmp4, tmp5, tmp6, tmp7, tmp0, tmp1, tmp2, tmp3, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, tmp9, tmp11, bb

        vmov.w tf4, tmp4
        vmov.w tf5, tmp5
        vmov.w tf6, tmp6
        vmov.w tf7, tmp7

        // last 12 elements
        ldr.w tmp1, [r1, #1*4]
        ldr.w tmp2, [r1, #2*4]
        ldr.w tmp0, [r1], #4*3

        vmov.w tmp4, tf8
        vmov.w tmp5, tf9
        vmov.w tmp6, tf10

        gf256_madd 3, tmp4, tmp5, tmp6, xxx, tmp0, tmp1, tmp2, xxx, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, tmp9, tmp11, bb

        vmov.w tf8, tmp4
        vmov.w tf9, tmp5
        vmov.w tf10, tmp6

    vmov.w jjj, jjjf
    add.w jjj, #1
    vmov.w jjjf, jjj
    cmp.w jjj, #\dim
    bne.w 2b

  vmov.w iii, iiif
  ldr.w bb, [sp, #1*4]
  ldrb.w bb, [bb, iii]

  gf256_madd_precompb fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, bb, tmp9, tmp10, tmp11
  // first 16 elements
  vmov.w tmp0, tf0
  vmov.w tmp1, tf1
  vmov.w tmp2, tf2
  vmov.w tmp3, tf3

  vmov.w tmp4, yf0
  vmov.w tmp5, yf1
  vmov.w tmp6, yf2
  vmov.w tmp7, yf3

  gf256_madd 4, tmp4, tmp5, tmp6, tmp7, tmp0, tmp1, tmp2, tmp3, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, tmp9, tmp11, bb

  vmov.w yf0, tmp4
  vmov.w yf1, tmp5
  vmov.w yf2, tmp6
  vmov.w yf3, tmp7

  // second 16 elements
  vmov.w tmp0, tf4
  vmov.w tmp1, tf5
  vmov.w tmp2, tf6
  vmov.w tmp3, tf7

  vmov.w tmp4, yf4
  vmov.w tmp5, yf5
  vmov.w tmp6, yf6
  vmov.w tmp7, yf7

  gf256_madd 4, tmp4, tmp5, tmp6, tmp7, tmp0, tmp1, tmp2, tmp3, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, tmp9, tmp11, bb

  vmov.w yf4, tmp4
  vmov.w yf5, tmp5
  vmov.w yf6, tmp6
  vmov.w yf7, tmp7

  // last 12 elements
  vmov.w tmp0, tf8
  vmov.w tmp1, tf9
  vmov.w tmp2, tf10

  vmov.w tmp4, yf8
  vmov.w tmp5, yf9
  vmov.w tmp6, yf10

  gf256_madd 3, tmp4, tmp5, tmp6, xxx, tmp0, tmp1, tmp2, xxx, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, tmp9, tmp11, bb

  vmov.w yf8, tmp4
  vmov.w yf9, tmp5
  vmov.w yf10, tmp6

  vmov.w iii, iiif
  add.w iii, #1
  vmov.w iiif, iii
  cmp.w iii, #\dim
  bne.w 1b

  // store y
  ldr.w r0, [sp, #0*4]
  vstr.w yf0,  [r0, #0*4]
  vstr.w yf1,  [r0, #1*4]
  vstr.w yf2,  [r0, #2*4]
  vstr.w yf3,  [r0, #3*4]
  vstr.w yf4,  [r0, #4*4]
  vstr.w yf5,  [r0, #5*4]
  vstr.w yf6,  [r0, #6*4]
  vstr.w yf7,  [r0, #7*4]
  vstr.w yf8,  [r0, #8*4]
  vstr.w yf9,  [r0, #9*4]
  vstr.w yf10, [r0, #10*4]

  add.w sp, sp, #2*4
  vpop.w {s16-s31}
  pop.w {r4-r11, pc}
.endm