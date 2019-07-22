.syntax unified
.cpu cortex-m4
.thumb

/* result in upper half word of tmp */
.macro montgomery q,qinv,a,tmp
  smulbb \tmp,\a,\qinv
  smulbb \tmp,\tmp,\q
  usub16 \tmp,\a,\tmp
.endm

.macro doublebarrett a, tmp,tmp2, q, barrettconst
  smulbt \tmp, \a, \barrettconst
  smultt \tmp2, \a, \barrettconst
  asr \tmp, \tmp, #26
  asr \tmp2, \tmp2, #26
  smulbb \tmp, \tmp, \q
  smulbb \tmp2, \tmp2, \q
  pkhbt \tmp, \tmp, \tmp2, lsl#16
  usub16 \a, \a, \tmp
.endm

.macro butterfly_nobarrett tb, a0, a1, twiddle, tmp, q, qinv
  smulb\tb \a1, \a1, \twiddle
  montgomery \q, \qinv, \a1, \tmp
  sasx \a1,\a0,\tmp
  ssax \a0,\a0,\tmp
.endm

.macro doublebutterfly_nobarrett tb, a0, a1, twiddle, tmp, tmp2, q, qinv
  smulb\tb \tmp, \a1, \twiddle
  smult\tb \a1, \a1, \twiddle
  montgomery \q, \qinv, \tmp, \tmp2
  montgomery \q, \qinv, \a1, \tmp
  pkhtb \tmp2, \tmp, \tmp2, asr#16
  usub16 \a1,\a0,\tmp2
  uadd16 \a0,\a0,\tmp2
.endm



.global ntt_fast
.type ntt_fast, %function
.align 2
ntt_fast:
  push {r4-r11, r14}

  poly        .req r0
  twiddle_ptr .req r1
  loopctr     .req r2
  poly0       .req r3
  poly1       .req r4
  poly2       .req r5
  poly3       .req r6
  twiddle2    .req r7
  tmp3        .req r8
  tmp2        .req r9
  tmp         .req r10
  twiddle     .req r11
  qinv        .req r12
  q           .req r14
  barrettconst .req r12

  movw q, #3329
  # contains qinv in lower halfword, and 20159 in upper halfword (constant used in barrett)
  movw  qinv, #62209
  movt barrettconst, #20159

  ### LAYER 7+6
  mov loopctr, #32
  ldrh twiddle, [twiddle_ptr], #2
  ldr twiddle2, [twiddle_ptr], #4
  1:
    ldr.w poly0, [poly]
    ldr.w poly1, [poly, #128]
    ldr.w poly2, [poly, #256]
    ldr.w poly3, [poly, #384]

    doublebutterfly_nobarrett b, poly0, poly2, twiddle, tmp, tmp2, q, qinv
    doublebutterfly_nobarrett b, poly1, poly3, twiddle, tmp, tmp2, q, qinv
    doublebutterfly_nobarrett b, poly0, poly1, twiddle2, tmp, tmp2, q, qinv
    doublebutterfly_nobarrett t, poly2, poly3, twiddle2, tmp, tmp2, q, qinv

    str.w poly1, [poly, #128]
    str.w poly2, [poly, #256]
    str.w poly3, [poly, #384]
    str.w poly0, [poly], #4

  subs.w loopctr, #1
  bne.w 1b

  sub.w poly, #128

  ### LAYER 5+4
  .rept 4
    mov loopctr, #8
    ldrh twiddle, [twiddle_ptr], #2
    ldr twiddle2, [twiddle_ptr], #4
    1:
      ldr.w poly0, [poly]
      ldr.w poly1, [poly, #32]
      ldr.w poly2, [poly, #64]
      ldr.w poly3, [poly, #96]

      doublebutterfly_nobarrett b, poly0, poly2, twiddle, tmp,tmp2, q, qinv
      doublebutterfly_nobarrett b, poly1, poly3, twiddle, tmp,tmp2, q, qinv

      doublebutterfly_nobarrett b, poly0, poly1, twiddle2, tmp,tmp2 q, qinv
      doublebutterfly_nobarrett t, poly2, poly3, twiddle2, tmp,tmp2, q, qinv

      str.w poly1, [poly, #32]
      str.w poly2, [poly, #64]
      str.w poly3, [poly, #96]
      str.w poly0, [poly], #4
    subs.w loopctr, #1
    bne.w 1b
  add.w poly, #96
  .endr

  sub.w poly, #512

  ### LAYER 3+2
  mov loopctr, #16
  1:
    ldrh twiddle, [twiddle_ptr], #2
    ldr twiddle2, [twiddle_ptr], #4

    .rept 2
      ldr.w poly0, [poly]
      ldr.w poly1, [poly, #8]
      ldr.w poly2, [poly, #16]
      ldr.w poly3, [poly, #24]

      doublebutterfly_nobarrett b, poly0, poly2, twiddle, tmp, tmp2, q, qinv
      doublebutterfly_nobarrett b, poly1, poly3, twiddle, tmp, tmp2, q, qinv
      doublebutterfly_nobarrett b, poly0, poly1, twiddle2, tmp, tmp2, q, qinv
      doublebutterfly_nobarrett t, poly2, poly3, twiddle2, tmp, tmp2, q, qinv

      str.w poly1, [poly, #8]
      str.w poly2, [poly, #16]
      str.w poly3, [poly, #24]
      str.w poly0, [poly], #4
      .endr
  add.w poly, #24
  subs.w loopctr, #1
  bne.w 1b

  sub poly, #512
  ### LAYER 1 (skip layer 0)
  mov loopctr, #32
  1:
    ldr twiddle, [twiddle_ptr], #4
    ldr poly0, [poly]
    ldr poly1, [poly, #4]
    ldr poly2, [poly, #8]
    ldr poly3, [poly, #12]

    doublebutterfly_nobarrett b, poly0, poly1, twiddle, tmp, tmp2, q, qinv
    doublebutterfly_nobarrett t, poly2, poly3, twiddle, tmp, tmp2, q, qinv

    doublebarrett poly0, tmp, tmp2, q, barrettconst
    doublebarrett poly1, tmp, tmp2, q, barrettconst
    doublebarrett poly2, tmp, tmp2, q, barrettconst
    doublebarrett poly3, tmp, tmp2, q, barrettconst

    str.w poly1, [poly, #4]
    str.w poly2, [poly, #8]
    str.w poly3, [poly, #12]
    str.w poly0, [poly], #16
    subs.w loopctr, #1
    bne.w 1b
  pop {r4-r11, pc}

.macro doubleinvbutterfly_nobarrett tb, a0, a1, twiddle, tmp, tmp2, q, qinv
  usub16 \tmp, \a0, \a1
  uadd16 \a0, \a0, \a1

  smulb\tb \a1, \tmp, \twiddle
  smult\tb \tmp, \tmp, \twiddle
  # result in tmp2
  montgomery \q, \qinv, \a1, \tmp2
  # result in a1
  montgomery \q, \qinv, \tmp, \a1
  pkhtb \a1, \a1, \tmp2, asr#16
.endm


.macro doubleinvbutterfly_barrett tb, a0, a1, twiddle, tmp, tmp2, q, qinv, barrettconst
  doubleinvbutterfly_nobarrett \tb, \a0, \a1, \twiddle, \tmp, \tmp2, \q, \qinv
  doublebarrett \a0, \tmp, \tmp2, \q, \barrettconst
.endm

.macro fqmulprecomp a, twiddle, tmp, tmp2, q, qinv
  smulbt \tmp, \a, \twiddle
  smultt \a, \a, \twiddle
  montgomery \q, \qinv, \a, \tmp2
  montgomery \q, \qinv, \tmp, \a
  pkhtb \a, \tmp2, \a, asr#16
.endm

.global invntt_fast
.type invntt_fast, %function
.align 2
invntt_fast:
  push {r4-r11, lr}

  poly                .req r0
  twiddle_ptr         .req r1
  loopctr             .req r2
  poly0               .req r3
  poly1               .req r4
  poly2               .req r5
  poly3               .req r6
  twiddle2            .req r7
  tmp3                .req r8
  tmp2                .req r9
  tmp                 .req r10
  twiddle             .req r11
  qinv                .req r12
  barrettconst        .req r12
  q                   .req r14

  movw  q, #3329
  movt q, #3329
  # contains qinv in lower halfword, and 20159 in upper halfword (constant used in barrett)
  movw  qinv, #62209
  movt barrettconst, #20159
  ### LAYER 1 (skip layer 0)
  mov loopctr, #32
  1:
    ldr twiddle, [twiddle_ptr], #4

    ldr poly0, [poly]
    ldr poly1, [poly, #4]
    ldr poly2, [poly, #8]
    ldr poly3, [poly, #12]

    doubleinvbutterfly_nobarrett b, poly0, poly1, twiddle, tmp, tmp2, q, qinv
    doubleinvbutterfly_nobarrett t, poly2, poly3, twiddle, tmp, tmp2, q, qinv

    str.w poly1, [poly, #4]
    str.w poly2, [poly, #8]
    str.w poly3, [poly, #12]
    str.w poly0, [poly], #16
    subs.w loopctr, #1
    bne.w 1b
  sub poly, #512


  ### LAYER 2+3
  mov loopctr, #16
  1:
    ldr twiddle, [twiddle_ptr], #4
    ldrh twiddle2, [twiddle_ptr], #2

    .rept 2
      ldr poly0, [poly]
      ldr poly1, [poly, #8]
      ldr poly2, [poly, #16]
      ldr poly3, [poly, #24]

      doubleinvbutterfly_nobarrett b, poly0, poly1, twiddle, tmp, tmp2, q, qinv
      doubleinvbutterfly_nobarrett t, poly2, poly3, twiddle, tmp, tmp2, q, qinv

      doubleinvbutterfly_barrett b, poly0, poly2, twiddle2, tmp, tmp2, q, qinv, barrettconst
      doubleinvbutterfly_barrett b, poly1, poly3, twiddle2, tmp, tmp2, q, qinv, barrettconst

      str.w poly1, [poly, #8]
      str.w poly2, [poly, #16]
      str.w poly3, [poly, #24]
      str.w poly0, [poly], #4
    .endr
    add poly, #24
  subs.w loopctr, #1
  bne.w 1b
  sub poly, #512


  ### LAYER 4+5
  .rept 4
      ldr twiddle, [twiddle_ptr], #4
      ldrh twiddle2, [twiddle_ptr], #2
      mov loopctr, #8
      1:
          ldr poly0, [poly]
          ldr poly1, [poly, #32]
          ldr poly2, [poly, #64]
          ldr poly3, [poly, #96]

          doubleinvbutterfly_nobarrett b, poly0, poly1, twiddle, tmp, tmp2, q, qinv
          doubleinvbutterfly_nobarrett t, poly2, poly3, twiddle, tmp, tmp2, q, qinv
          doubleinvbutterfly_barrett b, poly0, poly2, twiddle2, tmp, tmp2, q, qinv, barrettconst
          doubleinvbutterfly_barrett b, poly1, poly3, twiddle2, tmp, tmp2,  q, qinv, barrettconst

          str.w poly1, [poly, #32]
          str.w poly2, [poly, #64]
          str.w poly3, [poly, #96]
          str.w poly0, [poly], #4

        subs.w loopctr, #1
      bne.w 1b
      add poly, #96
  .endr

  mov tmp3, #256
  sub poly, #512
  ### LAYER 6+7
  ldr twiddle, [twiddle_ptr], #4
  ldr twiddle2, [twiddle_ptr], #4
  mov loopctr, #32
  1:
    ldr.w poly0, [poly]
    ldr.w poly1, [poly, #128]
    ldr.w poly2, [poly, #256]
    ldr.w poly3, [poly, #384]

    doubleinvbutterfly_nobarrett b, poly0, poly1, twiddle, tmp,tmp2, q, qinv
    doubleinvbutterfly_nobarrett t, poly2, poly3, twiddle, tmp,tmp2, q, qinv
    doubleinvbutterfly_barrett b, poly0, poly2, twiddle2, tmp, tmp2, q, qinv, barrettconst
    doubleinvbutterfly_barrett b, poly1, poly3, twiddle2, tmp, tmp2,  q, qinv, barrettconst

    fqmulprecomp poly0, twiddle2, tmp, tmp2, q, qinv
    fqmulprecomp poly1, twiddle2, tmp, tmp2, q, qinv
    fqmulprecomp poly2, twiddle2, tmp, tmp2, q, qinv
    fqmulprecomp poly3, twiddle2, tmp, tmp2, q, qinv

    str.w poly1, [poly, #128]
    str.w poly2, [poly, #256]
    str.w poly3, [poly, #384]
    str.w poly0, [poly], #4

  subs.w loopctr, #1
  bne.w 1b
  pop {r4-r11, pc}

/* result in upper half word of tmp
   q = qinv|q
*/
.macro montgomery_packed q, a,tmp
  smulbt \tmp,\a,\q
  smulbb \tmp,\tmp,\q
  usub16 \tmp,\a,\tmp
.endm


.global doublebasemul_asm
.type doublebasemul_asm, %function
.align 2
doublebasemul_asm:
  push {r4-r11, lr}

  .unreq poly0
  .unreq poly1
  .unreq poly2
  .unreq poly3
  .unreq q
  .unreq qinv
  .unreq tmp
  .unreq tmp2
  .unreq tmp3
  .unreq loopctr
  rptr .req r0
  aptr .req r1
  bptr .req r2
  zeta .req r3
  poly0 .req r4
  poly1 .req r5
  q    .req r6
  poly2 .req r7
  tmp  .req r8
  tmp2 .req r9
  tmp3 .req r10

  loopctr .req r11
  poly3 .req r14
  movw  q, #3329
  movt q, #62209
  ldr poly0, [aptr], #4
  ldr poly1, [bptr], #4
  ldr poly2, [aptr], #4
  ldr poly3, [bptr], #4

  //basemul(r->coeffs + 4 * i, a->coeffs + 4 * i, b->coeffs + 4 * i, zetas[64 + i]);
  smultt tmp, poly0, poly1
  montgomery_packed q, tmp, tmp2
  smultb tmp2, tmp2, zeta
  montgomery_packed q, tmp2, tmp
  smulbb tmp2, poly0, poly1
  montgomery_packed q, tmp2, tmp3
  // r[0] in upper half of tmp

  uadd16 tmp, tmp, tmp3

  smuadx tmp2, poly0, poly1
  montgomery_packed q, tmp2, tmp3
  // r[1] in upper half of tmp3
  pkhtb tmp, tmp3, tmp, asr#16
  str tmp, [rptr], #4

  //basemul(r->coeffs + 4 * i + 2, a->coeffs + 4 * i + 2, b->coeffs + 4 * i + 2, - zetas[64 + i]);
  smultt tmp, poly2, poly3
  montgomery_packed q, tmp, tmp2
  smultb tmp2, tmp2, zeta
  montgomery_packed q, tmp2, tmp
  smulbb tmp2, poly2, poly3
  montgomery_packed q, tmp2, tmp3
  // r[0] in upper half of tmp

  usub16 tmp, tmp3, tmp

  smuadx tmp2, poly2, poly3
  montgomery_packed q, tmp2, tmp3
  // r[1] in upper half of tmp3
  pkhtb tmp, tmp3, tmp, asr#16
  str tmp, [rptr], #4

  pop {r4-r11, pc}

.global basemul_asm
.type basemul_asm, %function
.align 2
basemul_asm:
    push {r4-r11, lr}

    .unreq poly0
    .unreq poly1
    .unreq poly2
    .unreq poly3
    .unreq q
    .unreq tmp
    .unreq tmp2
    .unreq tmp3
    .unreq loopctr
    .unreq zeta
    rptr .req r0
    aptr .req r1
    bptr .req r2
    zetaptr .req r3
    poly0 .req r4
    poly1 .req r5
    q    .req r6
    poly2 .req r7
    tmp  .req r8
    tmp2 .req r9
    tmp3 .req r10

    loopctr .req r11
    zeta    .req r12
    poly3 .req r14

    movw  q, #3329
    movt q, #62209

    mov loopctr, #64
    loop:
        ldr poly0, [aptr], #4
        ldr poly1, [bptr], #4
        ldr poly2, [aptr], #4
        ldr poly3, [bptr], #4
        ldrh zeta, [zetaptr], #2

        //basemul(r->coeffs + 4 * i, a->coeffs + 4 * i, b->coeffs + 4 * i, zetas[64 + i]);
        smultt tmp, poly0, poly1
        montgomery_packed q, tmp, tmp2
        smultb tmp2, tmp2, zeta
        montgomery_packed q, tmp2, tmp
        smulbb tmp2, poly0, poly1
        montgomery_packed q, tmp2, tmp3
        // r[0] in upper half of tmp

        uadd16 tmp, tmp, tmp3

        smuadx tmp2, poly0, poly1
        montgomery_packed q, tmp2, tmp3
        // r[1] in upper half of tmp3
        pkhtb tmp, tmp3, tmp, asr#16
        str tmp, [rptr], #4

        //basemul(r->coeffs + 4 * i + 2, a->coeffs + 4 * i + 2, b->coeffs + 4 * i + 2, - zetas[64 + i]);
        smultt tmp, poly2, poly3
        montgomery_packed q, tmp, tmp2
        smultb tmp2, tmp2, zeta
        montgomery_packed q, tmp2, tmp
        smulbb tmp2, poly2, poly3
        montgomery_packed q, tmp2, tmp3
        // r[0] in upper half of tmp

        usub16 tmp, tmp3, tmp

        smuadx tmp2, poly2, poly3
        montgomery_packed q, tmp2, tmp3
        // r[1] in upper half of tmp3
        pkhtb tmp, tmp3, tmp, asr#16
        str tmp, [rptr], #4
    subs loopctr, #1
    bne loop
    pop {r4-r11, pc}

.global basemul_asm_acc
.type basemul_asm_acc, %function
.align 2
basemul_asm_acc:
    push {r4-r11, lr}

    .unreq poly0
    .unreq poly1
    .unreq poly2
    .unreq poly3
    .unreq q
    .unreq tmp
    .unreq tmp2
    .unreq tmp3
    .unreq loopctr
    .unreq zeta
    rptr .req r0
    aptr .req r1
    bptr .req r2
    zetaptr .req r3
    poly0 .req r4
    poly1 .req r5
    q    .req r6
    poly2 .req r7
    tmp  .req r8
    tmp2 .req r9
    tmp3 .req r10

    loopctr .req r11
    zeta    .req r12
    poly3 .req r14

    movw  q, #3329
    movt q, #62209

    mov loopctr, #64
    loop2:
        ldr poly0, [aptr], #4
        ldr poly1, [bptr], #4
        ldr poly2, [aptr], #4
        ldr poly3, [bptr], #4
        ldrh zeta, [zetaptr], #2

        //basemul(r->coeffs + 4 * i, a->coeffs + 4 * i, b->coeffs + 4 * i, zetas[64 + i]);
        smultt tmp, poly0, poly1
        montgomery_packed q, tmp, tmp2
        smultb tmp2, tmp2, zeta
        montgomery_packed q, tmp2, tmp
        smulbb tmp2, poly0, poly1
        montgomery_packed q, tmp2, tmp3
        // r[0] in upper half of tmp

        uadd16 tmp, tmp, tmp3

        smuadx tmp2, poly0, poly1
        montgomery_packed q, tmp2, tmp3
        // r[1] in upper half of tmp3
        pkhtb tmp, tmp3, tmp, asr#16
        ldr tmp3, [rptr]
        uadd16 tmp, tmp, tmp3
        str tmp, [rptr], #4

        //basemul(r->coeffs + 4 * i + 2, a->coeffs + 4 * i + 2, b->coeffs + 4 * i + 2, - zetas[64 + i]);
        smultt tmp, poly2, poly3
        montgomery_packed q, tmp, tmp2
        smultb tmp2, tmp2, zeta
        montgomery_packed q, tmp2, tmp
        smulbb tmp2, poly2, poly3
        montgomery_packed q, tmp2, tmp3
        // r[0] in upper half of tmp

        usub16 tmp, tmp3, tmp

        smuadx tmp2, poly2, poly3
        montgomery_packed q, tmp2, tmp3
        // r[1] in upper half of tmp3
        pkhtb tmp, tmp3, tmp, asr#16
        ldr tmp3, [rptr]
        uadd16 tmp, tmp, tmp3
        str tmp, [rptr], #4
    subs loopctr, #1
    bne loop2
    pop {r4-r11, pc}

.align 2
.global pointwise_sub
.type pointwise_sub, %function
pointwise_sub:
  push {r4-r11, lr}

  mov r14, #25
  1:
      ldm r1!, {r3-r7}
      ldm r2!, {r8-r12}
      usub16 r3, r3, r8
      usub16 r4, r4, r9
      usub16 r5, r5, r10
      usub16 r6, r6, r11
      usub16 r7, r7, r12
      stm r0!, {r3-r7}
  subs r14, #1
  bne 1b

  ldm r1!, {r3-r5}
  ldm r2!, {r8-r10}
  usub16 r3, r3, r8
  usub16 r4, r4, r9
  usub16 r5, r5, r10
  stm r0!, {r3-r5}
  pop {r4-r11, pc}

.align 2
.global pointwise_add
.type pointwise_add, %function
pointwise_add:
  push {r4-r11, lr}
  mov r14, #25
  1:
      ldm r1!, {r3-r7}
      ldm r2!, {r8-r12}
      uadd16 r3, r3, r8
      uadd16 r4, r4, r9
      uadd16 r5, r5, r10
      uadd16 r6, r6, r11
      uadd16 r7, r7, r12
      stm r0!, {r3-r7}
  subs r14, #1
  bne 1b

  ldm r1!, {r3-r5}
  ldm r2!, {r8-r10}
  uadd16 r3, r3, r8
  uadd16 r4, r4, r9
  uadd16 r5, r5, r10
  stm r0!, {r3-r5}
  pop {r4-r11, pc}
