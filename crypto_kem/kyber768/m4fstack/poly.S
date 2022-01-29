#include "matacc.i"

.syntax unified
.cpu cortex-m4
.thumb

.macro doublebasemul_frombytes_asm rptr, bptr, zeta, poly0, poly2, poly1, poly3, tmp, tmp2, q, qinv

  ldr.w \poly2, [\bptr, #4]
  ldr \poly0, [\bptr], #8

  smultt \tmp, \poly0, \poly1
  montgomery \q, \qinv, \tmp, \tmp2
  smultb \tmp2, \tmp2, \zeta
  smlabb \tmp2, \poly0, \poly1, \tmp2
  montgomery \q, \qinv, \tmp2, \tmp

  smuadx \tmp2, \poly0, \poly1
  montgomery \q, \qinv, \tmp2, \poly0
  pkhtb \tmp, \poly0, \tmp, asr#16
  str \tmp, [\rptr], #4

  neg \zeta, \zeta

  smultt \tmp, \poly2, \poly3
  montgomery \q, \qinv, \tmp, \tmp2
  smultb \tmp2, \tmp2, \zeta
  smlabb \tmp2, \poly2, \poly3, \tmp2
  montgomery \q, \qinv, \tmp2, \tmp

  smuadx \tmp2, \poly2, \poly3
  montgomery \q, \qinv, \tmp2, \poly0
  pkhtb \tmp, \poly0, \tmp, asr#16
  str \tmp, [\rptr], #4
.endm

.macro doublebasemul_frombytes_asm_acc rptr, bptr, zeta, poly0, poly1, poly3, res0, res1, tmp, tmp2, q, qinv

  ldr \poly0, [\bptr], #4
  
  ldr \res0, [\rptr]
  ldr \res1, [\rptr, #4]

  smultt \tmp, \poly0, \poly1
  montgomery \q, \qinv, \tmp, \tmp2
  smultb \tmp2, \tmp2, \zeta
  smlabb \tmp2, \poly0, \poly1, \tmp2
  montgomery \q, \qinv, \tmp2, \tmp

  smuadx \tmp2, \poly0, \poly1
  montgomery \q, \qinv, \tmp2, \poly0
  pkhtb \tmp, \poly0, \tmp, asr#16
  uadd16 \res0, \res0, \tmp
  str \res0, [\rptr], #4

  neg \zeta, \zeta
  ldr \poly0, [\bptr], #4

  smultt \tmp, \poly0, \poly3
  montgomery \q, \qinv, \tmp, \tmp2
  smultb \tmp2, \tmp2, \zeta
  smlabb \tmp2, \poly0, \poly3, \tmp2
  montgomery \q, \qinv, \tmp2, \tmp

  smuadx \tmp2, \poly0, \poly3
  montgomery \q, \qinv, \tmp2, \poly0
  pkhtb \tmp, \poly0, \tmp, asr#16
  uadd16 \res1, \res1, \tmp
  str \res1, [\rptr], #4
.endm

.macro deserialize aptr, tmp, tmp2, tmp3, tmp4, tmp5, t0, t1
    ldrb.w \tmp3, [\aptr, #2]
    ldrh.w \tmp4, [\aptr, #3]
    ldrb.w \tmp5, [\aptr, #5]
    ldrh.w \tmp2, [\aptr], #6

    ubfx.w \t1, \tmp2, #12, #4
    ubfx.w \t0, \tmp2, #0, #12
    orr \t1, \t1, \tmp3, lsl #4
    orr \t0, \t0, \t1, lsl #16

    ubfx.w \t1, \tmp4, #12, #4
    ubfx.w \tmp, \tmp4, #0, #12
    orr \t1, \t1, \tmp5, lsl #4
    orr \t1, \tmp, \t1, lsl #16
.endm

// void frombytes_mul_asm(int16_t *r, const int16_t *b, const unsigned char *c, const int16_t zetas[64])
.global frombytes_mul_asm
.type frombytes_mul_asm, %function
.align 2
frombytes_mul_asm:
  push {r4-r11, r14}

  rptr    .req r0
  bptr    .req r1
  aptr    .req r2
  zetaptr .req r3
  t0      .req r4
  t1      .req r5
  tmp3    .req r6
  tmp4    .req r7
  tmp     .req r8
  tmp5    .req r9
  tmp2    .req r10
  zeta    .req r11
  qqinv   .req r12
  ctr     .req r14

  movw  qqinv, #3329
  movt qqinv, #3327

  add ctr, rptr, #64*4*2
  1:
    ldrh.w zeta, [zetaptr], #2
    deserialize aptr, tmp, tmp2, tmp3, tmp4, tmp5, t0, t1

    doublebasemul_frombytes_asm rptr, bptr, zeta, tmp3, tmp4, t0, t1, tmp, tmp2, qqinv, qqinv

    cmp.w rptr, ctr
    bne.w 1b

pop {r4-r11, pc}
.size frombytes_mul_asm, . -frombytes_mul_asm

// void frombytes_mul_asm_acc(int16_t *r, const int16_t *b, const unsigned char *c, const int16_t zetas[64])
.global frombytes_mul_asm_acc
.type frombytes_mul_asm_acc, %function
.align 2
frombytes_mul_asm_acc:
  push {r4-r11, r14}

  rptr    .req r0
  bptr    .req r1
  aptr    .req r2
  zetaptr .req r3
  t0      .req r4
  t1      .req r5
  tmp3    .req r6
  tmp4    .req r7
  tmp     .req r8
  tmp5    .req r9
  tmp2    .req r10
  zeta    .req r11
  qqinv   .req r12
  ctr     .req r14

  movw  qqinv, #3329
  movt qqinv, #3327

  add ctr, rptr, #64*4*2
  1:
    ldrh.w zeta, [zetaptr], #2
    deserialize aptr, tmp, tmp2, tmp3, tmp4, tmp5, t0, t1   

    doublebasemul_frombytes_asm_acc rptr, bptr, zeta, tmp3, t0, t1, tmp4, tmp5, tmp, tmp2, qqinv, qqinv
    cmp.w rptr, ctr
    bne.w 1b

pop {r4-r11, pc}
.size frombytes_mul_asm_acc, . - frombytes_mul_asm_acc 