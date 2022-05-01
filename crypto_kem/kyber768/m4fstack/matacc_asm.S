#include "matacc.i"
.extern kyber_shake128_squeezeblocks

.syntax unified
.cpu cortex-m4
.thumb

// void matacc_asm(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state)
.global matacc_asm
.type matacc_asm, %function
.align 2
matacc_asm:
  push {r0-r11, r14}
  rptr    .req r0
  bptr    .req r1
  cptr    .req r2
  bufptr  .req r3
  zetaptr .req r4
  val0    .req r5
  val1    .req r6
  tmp     .req r7
  tmp2    .req r8
  tmp3    .req r9
  k       .req r10
  q       .req r11
  qqinv   .req r12
  ctr     .req r14

  movw  qqinv, #3329
  movt qqinv, #3327
  
  ldr.w zetaptr, [sp, #13*4] // load zetaptr from stack
  ldr.w tmp, [sp, #14*4] // load state from stack
  vmov s10, tmp

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    ldrh val0, [bufptr], #2
    ldrb val1, [bufptr], #1
    ubfx tmp, val0, #12, #4
    orr val1, tmp, val1, lsl #4
    ubfx val0, val0, #0, #12
    ubfx val1, val1, #0, #12

    first_if doublebasemul_asm, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
    
    second_if doublebasemul_asm, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b
  
  pop {r0-r11, pc}
.size matacc_asm, . - matacc_asm

// void matacc_asm(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state)
.global matacc_asm_acc
.type matacc_asm_acc, %function
.align 2
matacc_asm_acc:
  push {r0-r11, r14}
  rptr    .req r0
  bptr    .req r1
  cptr    .req r2
  bufptr  .req r3
  zetaptr .req r4
  val0    .req r5
  val1    .req r6
  tmp     .req r7
  tmp2    .req r8
  tmp3    .req r9
  k       .req r10
  q       .req r11
  qqinv   .req r12
  ctr     .req r14

  movw  qqinv, #3329
  movt qqinv, #3327
  
  ldr.w zetaptr, [sp, #13*4] // load zetaptr from stack
  ldr.w tmp, [sp, #14*4] // load state from stack
  vmov s10, tmp

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    ldrh val0, [bufptr], #2
    ldrb val1, [bufptr], #1
    ubfx tmp, val0, #12, #4
    orr val1, tmp, val1, lsl #4
    ubfx val0, val0, #0, #12
    ubfx val1, val1, #0, #12

    first_if doublebasemul_asm_acc, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_acc, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b
  
  pop {r0-r11, pc}
.size matacc_asm_acc, . - matacc_asm_acc