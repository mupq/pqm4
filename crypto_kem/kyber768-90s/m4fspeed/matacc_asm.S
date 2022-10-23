#include "matacc.i"
.extern aes256xof_squeezeblocks

.syntax unified
.cpu cortex-m4
.thumb

// aes256xof_squeezeblocks into buffer if (almost) all bytes have been used
.macro update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, buflenval
  // if (pos + 3 > buflen 
  vmov s23, \tmp3
  vmov \tmp2, \buflenval // get buflen value
  vmov \tmp, s17
  sub \tmp3, \bufptr, \tmp // compute pos
  add \tmp3, #3 // pos + 3
  cmp.w \tmp3, \tmp2
  ble.w 3f
  // && ctr < KYBER_N/4)
  cmp.w \ctr, #256/4
  bge.w 3f
    // tmp = buffer start
    // tmp2 = buffer end
    add.w \tmp2, \tmp, \tmp2 // buffer start + buf len = last address of xof output byte

    // copy remaining bytes to start of buffer
    ldr.w \tmp3, [\bufptr]
    str.w \tmp3, [\tmp]
    sub \tmp3, \tmp2, \bufptr
    add.w \tmp, \tmp, \tmp3
    
    // compute buflen
    vmov \val0, s17 // get buf addr
    sub \val0, tmp, \val0
    add.w \val0, #64 // XOF_BLOCKBYTES=64
    vmov \buflenval, \val0
    
    vmov s18, r0
    vmov s19, r1
    vmov s20, r2
    vmov s21, r12
    vmov s22, lr
    
    mov.w r0, \tmp // buf + off implicitly after copying loop
    mov r1, #1
    vmov r2, s26 // get state ptr
    bl aes256xof_squeezeblocks
    
    vmov r0, s18
    vmov r1, s19
    vmov r2, s20
    vmov r12, s21
    vmov lr, s22
    // pos = 0;
    vmov \bufptr, s17 // reset buffer pointer to start -> only after squeezeblocks
  3:
  vmov \tmp3, s23
  cmp \ctr, #256/4
  blt.w 1b
.endm

// void matacc_asm_cache_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, int16_t *aprimeptr, unsigned int *buflen)
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

  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s29, tmp2

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_cache_16_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr
    
    second_if doublebasemul_asm_cache_16_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr

    update_buf_loop_finish tmp, tmp2, k, val0, val1, bufptr, ctr, s29

  pop {r0-r11, pc}
.size matacc_asm_cache_16_32, . - matacc_asm_cache_16_32

// void matacc_asm_cache_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, int16_t *aprimeptr, unsigned int *buflen)
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

  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s29, tmp2

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_cache_32_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr
    
    second_if doublebasemul_asm_acc_cache_32_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr

    update_buf_loop_finish tmp, tmp2, k, val0, val1, bufptr, ctr, s29

  pop {r0-r11, pc}
.size matacc_asm_cache_32_32, . - matacc_asm_cache_32_32

// void matacc_asm_cache_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, int16_t *aprimeptr, const int32_t *r_tmp, unsigned int *buflen)
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
  
  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s16, tmp2

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_cache_32_16, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr

    second_if doublebasemul_asm_acc_cache_32_16, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr

    update_buf_loop_finish tmp, tmp2, k, val0, val1, bufptr, ctr, s16

  vmov rptr, s29

  pop {r0-r11, pc}
.size matacc_asm_cache_32_16, . - matacc_asm_cache_32_16

.unreq zetaptr

// void matacc_asm_opt_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr, unsigned int *buflen)
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

  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s29, tmp2

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_opt_16_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr

    second_if doublebasemul_asm_opt_16_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr

    update_buf_loop_finish tmp, tmp2, k, val0, val1, bufptr, ctr, s29

  pop {r0-r11, pc}
.size matacc_asm_opt_16_32, . - matacc_asm_opt_16_32

.unreq ctr
.unreq tmp
.unreq tmp2

// void matacc_asm_opt_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr, unsigned int *buflen)
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

  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s29, tmp2

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_opt_32_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr
    
    second_if doublebasemul_asm_acc_opt_32_32, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr

    update_buf_loop_finish tmp, tmp2, k, val0, val1, bufptr, ctr, s29

  pop {r0-r11, pc}
.size matacc_asm_opt_32_32, . - matacc_asm_opt_32_32

.unreq ctr
.unreq tmp
.unreq tmp2

// void matacc_asm_opt_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr, const int32_t *r_tmp, unsigned int *buflen)
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
  
  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s16, tmp2

  // outer while loop
  movw ctr, #0
  vmov s17, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_opt_32_16, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr
    
    second_if doublebasemul_asm_acc_opt_32_16, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, tmp3, k, q, qa, qinv, ctr

    update_buf_loop_finish tmp, tmp2, k, val0, val1, bufptr, ctr, s16

  vmov rptr, s29

  pop {r0-r11, pc}
.size matacc_asm_opt_32_16, . - matacc_asm_opt_32_16