#include "matacc.i"
.extern shake128_squeezeblocks

.syntax unified
.cpu cortex-m4
.thumb

// shake128_squeezeblocks into buffer if all bytes have been used
.macro third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr
// if (pos + 3 > buflen && ctr < KYBER_N/4)
  vmov \tmp, s17
  add \tmp, #168 // XOF_BLOCKBYTES=168
  add \tmp2, \bufptr, #3
  cmp.w \tmp2, \tmp  // pos + 3 > buflen
  ble.w 2f
    cmp.w \ctr, #256/4
    bge.w 2f
      vmov \bufptr, s17

      vmov s16, r12
      vmov s18, \rptr
      vmov s19, \bptr
      vmov s20, \cptr
      vmov s21, \ctr

      mov \rptr, \bufptr
      movw \bptr, #1
      vmov \cptr, s26 // load state

      bl shake128_squeezeblocks

      vmov r12, s16
      vmov \rptr, s18
      vmov \bptr, s19
      vmov \cptr, s20
      vmov \ctr, s21
      vmov \bufptr, s17
    2:
.endm

// void matacc_asm_cache_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int32_t zetas[64], xof_state *state, int16_t *aprimeptr)
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
  k       .req r9
	q       .req r10
	qa      .req r11
	qinv    .req r12
	ctr     .req r14

  movw qa, #26632
	movw q, #3329
	### qinv=0x6ba8f301
	movw qinv, #62209
	movt qinv, #27560
  movw k, #0
  
  ldr.w zetaptr, [sp, #13*4] // load zetaptr from stack
  ldr.w tmp, [sp, #14*4] // load state from stack
  vmov s26, tmp

  ldr.w tmp, [sp, #15*4] // load aprimeptr from stack
  vmov s27, tmp

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_cache_16_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr
    
    second_if doublebasemul_asm_cache_16_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  pop {r0-r11, pc}
.size matacc_asm_cache_16_32, . - matacc_asm_cache_16_32

// void matacc_asm_cache_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int32_t zetas[64], xof_state *state, int16_t *aprimeptr)
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
  k       .req r9
	q       .req r10
	qa      .req r11
	qinv    .req r12
	ctr     .req r14

  movw qa, #26632
	movw q, #3329
	### qinv=0x6ba8f301
	movw qinv, #62209
	movt qinv, #27560
  movw k, #0

  ldr.w zetaptr, [sp, #13*4] // load zetaptr from stack
  ldr.w tmp, [sp, #14*4] // load state from stack
  vmov s26, tmp

  ldr.w tmp, [sp, #15*4] // load aprimeptr from stack
  vmov s27, tmp

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_cache_32_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr
    
    second_if doublebasemul_asm_acc_cache_32_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  pop {r0-r11, pc}
.size matacc_asm_cache_32_32, . - matacc_asm_cache_32_32

// void matacc_asm_cache_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int32_t zetas[64], xof_state *state, int16_t *aprimeptr, const int32_t *r_tmp)
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
  k       .req r9
	q       .req r10
	qa      .req r11
	qinv    .req r12
	ctr     .req r14

  movw qa, #26632
	movw q, #3329
	### qinv=0x6ba8f301
	movw qinv, #62209
	movt qinv, #27560
  movw k, #0
  
  ldr.w zetaptr, [sp, #13*4] // load zetaptr from stack

  ldr.w tmp, [sp, #14*4] // load state from stack
  vmov s26, tmp

  ldr.w tmp, [sp, #15*4] // load aprimeptr from stack
  vmov s27, tmp

  vmov s28, rptr // store "real" destinaton in FP
  vmov s29, rptr // backup
  ldr.w rptr, [sp, #16*4]

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:
    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_cache_32_16, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr
    
    second_if doublebasemul_asm_acc_cache_32_16, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  vmov rptr, s29

  pop {r0-r11, pc}
.size matacc_asm_cache_32_16, . - matacc_asm_cache_32_16

.unreq zetaptr

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
  tmp3   .req r4
  val0   .req r5
  val1   .req r6
  tmp    .req r7
  tmp2   .req r8
  k      .req r9
  q      .req r10
  qa     .req r11
  qinv   .req r12
  ctr    .req r14

  movw qa, #26632
	movw q, #3329
	### qinv=0x6ba8f301
	movw qinv, #62209
	movt qinv, #27560
  movw k, #0
  
  ldr.w tmp, [sp, #13*4] // load state from stack
  vmov s26, tmp

  ldr.w tmp, [sp, #14*4] // load aprimeptr from stack
  vmov s27, tmp

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_opt_16_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr
    
    second_if doublebasemul_asm_opt_16_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  pop {r0-r11, pc}
.size matacc_asm_opt_16_32, . - matacc_asm_opt_16_32

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
  tmp3   .req r4
  val0   .req r5
  val1   .req r6
  tmp    .req r7
  tmp2   .req r8
  k      .req r9
  q      .req r10
  qa     .req r11
  qinv   .req r12
  ctr    .req r14

  movw qa, #26632
	movw q, #3329
	### qinv=0x6ba8f301
	movw qinv, #62209
	movt qinv, #27560
  movw k, #0
  
  ldr.w tmp, [sp, #13*4] // load state from stack
  vmov s26, tmp

  ldr.w tmp, [sp, #14*4] // load aprimeptr from stack
  vmov s27, tmp

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_opt_32_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr
    
    second_if doublebasemul_asm_acc_opt_32_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  pop {r0-r11, pc}
.size matacc_asm_opt_32_32, . - matacc_asm_opt_32_32

.unreq tmp3


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
  tmp3    .req r4
  val0    .req r5
  val1    .req r6
  tmp     .req r7
  tmp2    .req r8
  k       .req r9
  q       .req r10
  qa      .req r11
  qinv    .req r12
  ctr     .req r14

  movw qa, #26632
	movw q, #3329
	### qinv=0x6ba8f301
	movw qinv, #62209
	movt qinv, #27560
  movw k, #0
  
  ldr.w tmp, [sp, #13*4] // load state from stack
  vmov s26, tmp

  ldr.w tmp, [sp, #14*4] // load aprimeptr from stack
  vmov s27, tmp

  vmov s28, rptr // store "real" destinaton in FP
  vmov s29, rptr // backup
  ldr.w rptr, [sp, #15*4]

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_opt_32_16, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr
    
    second_if doublebasemul_asm_acc_opt_32_16, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr

    third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr

    cmp ctr, #256/4
    blt.w 1b

  vmov rptr, s29

  pop {r0-r11, pc}
.size matacc_asm_opt_32_16, . - matacc_asm_opt_32_16