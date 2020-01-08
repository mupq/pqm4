.syntax unified
.cpu cortex-m4
.thumb

.macro montgomery q, qinv, a, tmp
  smulbt \tmp, \a, \qinv
  smlabb \tmp, \q, \tmp, \a
.endm


.global doublebasemul_asm
.type doublebasemul_asm, %function
.align 2
doublebasemul_asm:
  push {r4-r11, lr}

  rptr  .req r0
  aptr  .req r1
  bptr  .req r2
  zeta  .req r3
  poly0 .req r4
  poly1 .req r6
  poly2 .req r5
  poly3 .req r7
  q     .req r8
  qinv  .req r8
  tmp   .req r9
  tmp2  .req r10
  tmp3  .req r11

  movw  q, #3329
  movt qinv, #3327

  ldrd poly0, poly2, [aptr], #8
  ldrd poly1, poly3, [bptr], #8

  //basemul(r->coeffs + 4 * i, a->coeffs + 4 * i, b->coeffs + 4 * i, zetas[64 + i]);
  smultt tmp, poly0, poly1
  montgomery q, qinv, tmp, tmp2
  smultb tmp2, tmp2, zeta
  smlabb tmp2, poly0, poly1, tmp2
  montgomery q, qinv, tmp2, tmp
  // r[0] in upper half of tmp

  smuadx tmp2, poly0, poly1
  montgomery q, qinv, tmp2, tmp3
  // r[1] in upper half of tmp3
  pkhtb tmp, tmp3, tmp, asr#16
  str tmp, [rptr], #4

  neg zeta, zeta

  //basemul(r->coeffs + 4 * i + 2, a->coeffs + 4 * i + 2, b->coeffs + 4 * i + 2, - zetas[64 + i]);
  smultt tmp, poly2, poly3
  montgomery q, qinv, tmp, tmp2
  smultb tmp2, tmp2, zeta
  smlabb tmp2, poly2, poly3, tmp2
  montgomery q, qinv, tmp2, tmp
  // r[0] in upper half of tmp

  smuadx tmp2, poly2, poly3
  montgomery q, qinv, tmp2, tmp3
  // r[1] in upper half of tmp3
  pkhtb tmp, tmp3, tmp, asr#16
  str tmp, [rptr], #4

  pop {r4-r11, pc}


.global doublebasemul_asm_acc
.type doublebasemul_asm_acc, %function
.align 2
doublebasemul_asm_acc:
  push {r4-r11, lr}

  rptr  .req r0
  aptr  .req r1
  bptr  .req r2
  zeta  .req r3
  poly0 .req r4
  poly1 .req r6
  poly2 .req r5
  poly3 .req r7
  q     .req r8
  qinv  .req r8
  tmp   .req r9
  tmp2  .req r10
  tmp3  .req r11
  r0r1  .req r12
  r2r3  .req r14

  movw  q, #3329
  movt qinv, #3327

  ldrd poly0, poly2, [aptr], #8
  ldrd poly1, poly3, [bptr], #8
  ldrd r0r1, r2r3, [rptr]

  //basemul(r->coeffs + 4 * i, a->coeffs + 4 * i, b->coeffs + 4 * i, zetas[64 + i]);
  smultt tmp, poly0, poly1
  montgomery q, qinv, tmp, tmp2
  smultb tmp2, tmp2, zeta
  smlabb tmp2, poly0, poly1, tmp2
  montgomery q, qinv, tmp2, tmp
  // r[0] in upper half of tmp

  smuadx tmp2, poly0, poly1
  montgomery q, qinv, tmp2, tmp3
  // r[1] in upper half of tmp3
  pkhtb tmp, tmp3, tmp, asr#16
  uadd16 r0r1, r0r1, tmp
  str r0r1, [rptr], #4

  neg zeta, zeta

  //basemul(r->coeffs + 4 * i + 2, a->coeffs + 4 * i + 2, b->coeffs + 4 * i + 2, - zetas[64 + i]);
  smultt tmp, poly2, poly3
  montgomery q, qinv, tmp, tmp2
  smultb tmp2, tmp2, zeta
  smlabb tmp2, poly2, poly3, tmp2
  montgomery q, qinv, tmp2, tmp
  // r[0] in upper half of tmp

  smuadx tmp2, poly2, poly3
  montgomery q, qinv, tmp2, tmp3
  // r[1] in upper half of tmp3
  pkhtb tmp, tmp3, tmp, asr#16
  uadd16 r2r3, r2r3, tmp
  str r2r3, [rptr], #4

  pop {r4-r11, pc}


.global basemul_asm
.type basemul_asm, %function
.align 2
basemul_asm:
    push {r4-r11, lr}

    .unreq zeta
    rptr    .req r0
    aptr    .req r1
    bptr    .req r2
    zetaptr .req r3
    poly0   .req r4
    poly1   .req r6
    poly2   .req r5
    poly3   .req r7
    q       .req r8
    qinv    .req r8
    tmp     .req r9
    tmp2    .req r10
    tmp3    .req r11
    zeta    .req r12
    loop    .req r14

    movw q, #3329
    movt qinv, #3327

    movw loop, #64
    1:
      ldr poly0, [aptr], #4
      ldr poly1, [bptr], #4
      ldr poly2, [aptr], #4
      ldr poly3, [bptr], #4

      ldrh zeta, [zetaptr], #2

      // basemul(r->coeffs + 4 * i, a->coeffs + 4 * i, b->coeffs + 4 * i, zetas[64 + i]);
      smultt tmp, poly0, poly1
      montgomery q, qinv, tmp, tmp2
      smultb tmp2, tmp2, zeta
      smlabb tmp2, poly0, poly1, tmp2
      montgomery q, qinv, tmp2, tmp
      // r[0] in upper half of tmp

      smuadx tmp2, poly0, poly1
      montgomery q, qinv, tmp2, tmp3
      // r[1] in upper half of tmp3
      pkhtb tmp, tmp3, tmp, asr#16
      str tmp, [rptr], #4

      neg zeta, zeta

      // basemul(r->coeffs + 4 * i + 2, a->coeffs + 4 * i + 2, b->coeffs + 4 * i + 2, - zetas[64 + i]);
      smultt tmp, poly2, poly3
      montgomery q, qinv, tmp, tmp2
      smultb tmp2, tmp2, zeta
      smlabb tmp2, poly2, poly3, tmp2
      montgomery q, qinv, tmp2, tmp
      // r[0] in upper half of tmp

      smuadx tmp2, poly2, poly3
      montgomery q, qinv, tmp2, tmp3
      // r[1] in upper half of tmp3
      pkhtb tmp, tmp3, tmp, asr#16
      str tmp, [rptr], #4

      subs.w loop, #1
    bne.w 1b

    pop {r4-r11, pc}


.global basemul_asm_acc
.type basemul_asm_acc, %function
.align 2
basemul_asm_acc:
    push {r4-r11, lr}

    rptr    .req r0
    aptr    .req r1
    bptr    .req r2
    zetaptr .req r3
    poly0   .req r4
    poly1   .req r6
    poly2   .req r5
    poly3   .req r7
    q       .req r8
    qinv    .req r8
    tmp     .req r9
    tmp2    .req r10
    tmp3    .req r11
    zeta    .req r12
    loop    .req r14

    movw q, #3329
    movt qinv, #3327

    movw loop, #64
    1:

      ldrd poly0, poly2, [aptr], #8
      ldrd poly1, poly3, [bptr], #8

      ldrh zeta, [zetaptr], #2

      //basemul(r->coeffs + 4 * i, a->coeffs + 4 * i, b->coeffs + 4 * i, zetas[64 + i]);
      smultt tmp, poly0, poly1
      montgomery q, qinv, tmp, tmp2
      smultb tmp2, tmp2, zeta
      smlabb tmp2, poly0, poly1, tmp2
      montgomery q, qinv, tmp2, tmp
      // r[0] in upper half of tmp

      smuadx tmp2, poly0, poly1
      montgomery q, qinv, tmp2, tmp3
      // r[1] in upper half of tmp3
      pkhtb tmp, tmp3, tmp, asr#16
      ldr tmp3, [rptr]
      uadd16 tmp, tmp, tmp3
      str tmp, [rptr], #4

      neg zeta, zeta

      //basemul(r->coeffs + 4 * i + 2, a->coeffs + 4 * i + 2, b->coeffs + 4 * i + 2, - zetas[64 + i]);
      smultt tmp, poly2, poly3
      montgomery q, qinv, tmp, tmp2
      smultb tmp2, tmp2, zeta
      smlabb tmp2, poly2, poly3, tmp2
      montgomery q, qinv, tmp2, tmp
      // r[0] in upper half of tmp

      smuadx tmp2, poly2, poly3
      montgomery q, qinv, tmp2, tmp3
      // r[1] in upper half of tmp3
      pkhtb tmp, tmp3, tmp, asr#16
      ldr tmp3, [rptr]
      uadd16 tmp, tmp, tmp3
      str tmp, [rptr], #4

      subs.w loop, #1
    bne.w 1b

    pop {r4-r11, pc}
