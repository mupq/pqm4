#include "matacc.i"
.extern kyber_shake128_squeezeblocks

.syntax unified
.cpu cortex-m4
.thumb

// kyber_shake128_squeezeblocks into buffer if all bytes have been used
.macro third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr
// if (pos + 3 > buflen && ctr < KYBER_N/4)
  vmov \tmp, s1
  add \tmp, #168 // XOF_BLOCKBYTES=168
  add \tmp2, \bufptr, #3
  cmp.w \tmp2, \tmp  // pos + 3 > buflen
  ble.w 2f
    cmp.w \ctr, #256/4
    bge.w 2f
      vmov \bufptr, s1

      vmov s2, \rptr
      vmov s3, \bptr
      vmov s4, \cptr
      vmov s5, \ctr

      mov \rptr, \bufptr
      movw \bptr, #1
      vmov \cptr, s20 // load state
      bl kyber_shake128_squeezeblocks
      vmov \rptr, s2
      vmov \bptr, s3
      vmov \cptr, s4
      vmov \ctr, s5
      vmov \bufptr, s1
    2:
.endm

// void matacc_asm_cache_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, int16_t *aprimeptr)
.global matacc_asm_cache_16_32
.type matacc_asm_cache_16_32, %function
.align 2
matacc_asm_cache_16_32:
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
  vmov s20, tmp

  ldr.w tmp, [sp, #15*4] // load aprimeptr from stack
  vmov s21, tmp

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_cache_16_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_cache_16_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  pop {r0-r11, pc}
.size matacc_asm_cache_16_32, . - matacc_asm_cache_16_32

// void matacc_asm_cache_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, int16_t *aprimeptr)
.global matacc_asm_cache_32_32
.type matacc_asm_cache_32_32, %function
.align 2
matacc_asm_cache_32_32:
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
  vmov s20, tmp

  ldr.w tmp, [sp, #15*4] // load aprimeptr from stack
  vmov s21, tmp

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_cache_32_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_acc_cache_32_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  pop {r0-r11, pc}
.size matacc_asm_cache_32_32, . - matacc_asm_cache_32_32

// void matacc_asm_cache_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, int16_t *aprimeptr, const int32_t *r_tmp)
.global matacc_asm_cache_32_16
.type matacc_asm_cache_32_16, %function
.align 2
matacc_asm_cache_32_16:
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
  vmov s20, tmp

  ldr.w tmp, [sp, #15*4] // load aprimeptr from stack
  vmov s21, tmp

  vmov s22, rptr // store "real" destinaton in FP
  vmov s23, rptr // backup
  ldr.w rptr, [sp, #16*4]
  
  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:
    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_cache_32_16, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_acc_cache_32_16, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  vmov rptr, s23

  pop {r0-r11, pc}
.size matacc_asm_cache_32_16, . - matacc_asm_cache_32_16

.unreq zetaptr

.unreq ctr
.unreq tmp
.unreq tmp2
// void matacc_asm_opt_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr)
.global matacc_asm_opt_16_32
.type matacc_asm_opt_16_32, %function
.align 2
matacc_asm_opt_16_32:
  push {r0-r11, r14}
  rptr   .req r0 
  bptr   .req r1
  cptr   .req r2
  bufptr .req r3
  tmp4   .req r4
  val0   .req r5
  val1   .req r6
  tmp2   .req r7
  ctr    .req r8
  tmp3   .req r9
  k      .req r10
  q      .req r11
  qqinv  .req r12
  tmp    .req r14

  movw  qqinv, #3329
  movt qqinv, #3327
  
  ldr.w tmp, [sp, #13*4] // load state from stack
  vmov s20, tmp

  ldr.w tmp, [sp, #14*4] // load aprimeptr from stack
  vmov s21, tmp

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_opt_16_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_opt_16_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  pop {r0-r11, pc}
.size matacc_asm_opt_16_32, . - matacc_asm_opt_16_32



.unreq ctr
.unreq tmp
.unreq tmp2

// void matacc_asm_opt_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr)
.global matacc_asm_opt_32_32
.type matacc_asm_opt_32_32, %function
.align 2
matacc_asm_opt_32_32:
  push {r0-r11, r14}
  rptr   .req r0
  bptr   .req r1
  cptr   .req r2
  bufptr .req r3
  tmp4   .req r4
  val0   .req r5
  val1   .req r6
  tmp2   .req r7
  ctr    .req r8
  tmp3   .req r9
  k      .req r10
  q      .req r11
  qqinv  .req r12
  tmp    .req r14

  movw qqinv, #3329
  movt qqinv, #3327
  
  ldr.w tmp, [sp, #13*4] // load state from stack
  vmov s20, tmp

  ldr.w tmp, [sp, #14*4] // load aprimeptr from stack
  vmov s21, tmp

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_opt_32_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_acc_opt_32_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  pop {r0-r11, pc}
.size matacc_asm_opt_32_32, . - matacc_asm_opt_32_32

.unreq ctr
.unreq tmp
.unreq tmp2

// void matacc_asm_opt_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr, const int32_t *r_tmp)
.global matacc_asm_opt_32_16
.type matacc_asm_opt_32_16, %function
.align 2
matacc_asm_opt_32_16:
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
  
  ldr.w tmp, [sp, #13*4] // load state from stack
  vmov s20, tmp

  ldr.w tmp, [sp, #14*4] // load aprimeptr from stack
  vmov s21, tmp

  vmov s22, rptr // store "real" destinaton in FP
  vmov s23, rptr // backup
  ldr.w rptr, [sp, #15*4]
  
  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_opt_32_16, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_acc_opt_32_16, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  vmov rptr, s23

  pop {r0-r11, pc}
.size matacc_asm_opt_32_16, . - matacc_asm_opt_32_16