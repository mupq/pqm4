#include "macros.i"

.syntax unified
.cpu cortex-m4
.thumb

.macro doublebasemul_frombytes_asm_16_32 rptr_tmp, bptr, zeta, poly0, poly2, poly1, poly3, tmp, tmp2, q, qinv
  ldr \poly0, [\bptr], #4
  ldr \poly2, [\bptr], #4

  smultt \tmp, \poly0, \poly1
  montgomery \q, \qinv, \tmp, \tmp2
  smultb \tmp2, \tmp2, \zeta
  smlabb \tmp2, \poly0, \poly1, \tmp2
  str \tmp2, [\rptr_tmp], #4

  smuadx \tmp, \poly0, \poly1
  str \tmp, [\rptr_tmp], #4

  neg \zeta, \zeta

  smultt \tmp, \poly2, \poly3
  montgomery \q, \qinv, \tmp, \tmp2
  smultb \tmp2, \tmp2, \zeta
  smlabb \tmp2, \poly2, \poly3, \tmp2
  str \tmp2, [\rptr_tmp], #4

  smuadx \tmp2, \poly2, \poly3
  str \tmp2, [\rptr_tmp], #4
.endm

.macro doublebasemul_frombytes_asm_acc_32_32 rptr_tmp, bptr, zeta, poly0, poly1, poly3, res0, res1, tmp, tmp2, q, qinv
  ldr \poly0, [\bptr], #4
  ldr \res0, [\rptr_tmp]
  ldr \res1, [\rptr_tmp, #4]

  smultt \tmp, \poly0, \poly1
  montgomery \q, \qinv, \tmp, \tmp2
  smlatb \tmp2, \tmp2, \zeta, \res0
  smlabb \tmp2, \poly0, \poly1, \tmp2
  str \tmp2, [\rptr_tmp], #4

  smladx \tmp, \poly0, \poly1, \res1
  str \tmp, [\rptr_tmp], #4

  neg \zeta, \zeta

  ldr \poly0, [\bptr], #4
  ldr \res0, [\rptr_tmp]
  ldr \res1, [\rptr_tmp, #4]

  smultt \tmp, \poly0, \poly3
  montgomery \q, \qinv, \tmp, \tmp2
  smlatb \tmp2, \tmp2, \zeta, \res0
  smlabb \tmp2, \poly0, \poly3, \tmp2
  str \tmp2, [\rptr_tmp], #4

  smladx \tmp2, \poly0, \poly3, \res1
  str \tmp2, [\rptr_tmp], #4
.endm

.macro doublebasemul_frombytes_asm_acc_32_16 rptr_tmp, rptr, bptr, zeta, poly0, poly1, poly3, res0, res1, tmp, tmp2, q, qinv
  ldr \poly0, [\bptr], #4
  ldr \res0, [\rptr_tmp], #4
  ldr \res1, [\rptr_tmp], #4
  
  smultt \tmp, \poly0, \poly1
  montgomery \q, \qinv, \tmp, \tmp2
  smlatb \tmp2, \tmp2, \zeta, \res0
  smlabb \tmp2, \poly0, \poly1, \tmp2
  montgomery \q, \qinv, \tmp2, \res0

  smladx \tmp, \poly0, \poly1, \res1
  montgomery \q, \qinv, \tmp, \res1

  pkhtb \res0, \res1, \res0, asr#16
  str \res0, [\rptr], #4

  neg \zeta, \zeta

  ldr \poly0, [\bptr], #4
  ldr \res0, [\rptr_tmp], #4
  ldr \res1, [\rptr_tmp], #4

  smultt \tmp, \poly0, \poly3
  montgomery \q, \qinv, \tmp, \tmp2
  smlatb \tmp2, \tmp2, \zeta, \res0
  smlabb \tmp2, \poly0, \poly3, \tmp2
  montgomery \q, \qinv, \tmp2, \res0

  smladx \tmp2, \poly0, \poly3, \res1
  montgomery \q, \qinv, \tmp2, \res1

  pkhtb \res0, \res1, \res0, asr#16
  str \res0, [\rptr], #4
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

// void frombytes_mul_asm_16_32(int32_t *r_tmp, const int16_t *b, const unsigned char *c, const int16_t zetas[64])
.global frombytes_mul_asm_16_32
.type frombytes_mul_asm_16_32, %function
.align 2
frombytes_mul_asm_16_32:
  push {r4-r11, r14}

  rptr_tmp .req r0
  bptr     .req r1
  aptr     .req r2
  zetaptr  .req r3
  t0       .req r4
  t1       .req r5
  tmp3     .req r6
  tmp4     .req r7
  tmp      .req r8
  tmp5     .req r9
  tmp2     .req r10
  zeta     .req r11
  qqinv    .req r12
  ctr      .req r14

  movw  qqinv, #3329
  movt qqinv, #3327

  add ctr, rptr_tmp, #64*4*4
  1:
    ldrh.w zeta, [zetaptr], #2
    deserialize aptr, tmp, tmp2, tmp3, tmp4, tmp5, t0, t1

    doublebasemul_frombytes_asm_16_32 rptr_tmp, bptr, zeta, tmp3, tmp4, t0, t1, tmp, tmp2, qqinv, qqinv

    cmp.w rptr_tmp, ctr
    bne.w 1b

pop {r4-r11, pc}
.size frombytes_mul_asm_16_32, . -frombytes_mul_asm_16_32

// void frombytes_mul_asm_acc_32_32(int32_t *r_tmp, const int16_t *b, const unsigned char *c, const int16_t zetas[64])
.global frombytes_mul_asm_acc_32_32
.type frombytes_mul_asm_acc_32_32, %function
.align 2
frombytes_mul_asm_acc_32_32:
  push {r4-r11, r14}

  rptr_tmp .req r0
  bptr     .req r1
  aptr     .req r2
  zetaptr  .req r3
  t0       .req r4
  t1       .req r5
  tmp3     .req r6
  tmp4     .req r7
  tmp      .req r8
  tmp5     .req r9
  tmp2     .req r10
  zeta     .req r11
  qqinv    .req r12
  ctr      .req r14

  movw  qqinv, #3329
  movt qqinv, #3327

  add ctr, rptr_tmp, #64*4*4
  1:
    ldrh.w zeta, [zetaptr], #2
    deserialize aptr, tmp, tmp2, tmp3, tmp4, tmp5, t0, t1

    doublebasemul_frombytes_asm_acc_32_32 rptr_tmp, bptr, zeta, tmp3, t0, t1, tmp4, tmp5, tmp, tmp2, qqinv, qqinv
    cmp.w rptr_tmp, ctr
    bne.w 1b

pop {r4-r11, pc}
.size frombytes_mul_asm_acc_32_32, . - frombytes_mul_asm_acc_32_32

.unreq bptr
.unreq ctr
.unreq rptr_tmp

// void frombytes_mul_asm_acc_32_16(int16_t *r, const int16_t *b, const unsigned char *c, const int16_t zetas[64], const int32_t *r_tmp)
.global frombytes_mul_asm_acc_32_16
.type frombytes_mul_asm_acc_32_16, %function
.align 2
frombytes_mul_asm_acc_32_16:
  push {r4-r11, r14}

  rptr     .req r0
  bptr     .req r1
  aptr     .req r2
  zetaptr  .req r3
  t0       .req r4
  t1       .req r5
  tmp3     .req r6
  tmp4     .req r7
  tmp      .req r8
  tmp5     .req r9
  tmp2     .req r10
  zeta     .req r11
  qqinv    .req r12
  ctr      .req r11
  rptr_tmp .req r14

  movw  qqinv, #3329
  movt qqinv, #3327

  ldr.w rptr_tmp, [sp, #9*4] // load rptr_tmp from stack

  add ctr, rptr_tmp, #64*4*4
  vmov s0, ctr
  1:
    ldrh.w zeta, [zetaptr], #2
    deserialize aptr, tmp, tmp2, tmp3, tmp4, tmp5, t0, t1

    doublebasemul_frombytes_asm_acc_32_16 rptr_tmp, rptr, bptr, zeta, tmp3, t0, t1, tmp4, tmp5, tmp, tmp2, qqinv, qqinv
    vmov ctr, s0
    cmp.w rptr_tmp, ctr
    bne.w 1b

pop {r4-r11, pc}
.size frombytes_mul_asm_acc_32_16, . - frombytes_mul_asm_acc_32_16