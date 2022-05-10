#include "matacc.i"
.extern aes256xof_squeezeblocks

.syntax unified
.cpu cortex-m4
.thumb

// aes256xof_squeezeblocks into buffer if (almost) all bytes have been used
.macro update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, buflenval
  // if (pos + 3 > buflen 
  vmov \tmp2, \buflenval // get buflen value
  vmov \tmp, s1
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
    vmov \val0, s1 // get buf addr
    sub \val0, tmp, \val0
    add.w \val0, #64 // XOF_BLOCKBYTES=64
    vmov \buflenval, \val0
    
    vmov s2, r0
    vmov s3, r1
    vmov s4, r2
    vmov s6, r12
    vmov s7, lr
    
    mov.w r0, \tmp // buf + off implicitly after copying loop
    mov r1, #1
    vmov r2, s10 // get state ptr
    bl aes256xof_squeezeblocks
    
    vmov r0, s2
    vmov r1, s3
    vmov r2, s4
    vmov r12, s6
    vmov lr, s7
    // pos = 0;
    vmov \bufptr, s1 // reset buffer pointer to start -> only after squeezeblocks
  3:

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

  ldr.w tmp, [sp, #15*4] // load aprimeptr from stack
  vmov s11, tmp

  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s13, tmp2

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_cache_16_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_cache_16_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, s13

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

  ldr.w tmp, [sp, #15*4] // load aprimeptr from stack
  vmov s11, tmp

  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s13, tmp2

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_cache_32_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_acc_cache_32_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, s13

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

  ldr.w tmp, [sp, #15*4] // load aprimeptr from stack
  vmov s11, tmp

  vmov s12, rptr // store "real" destinaton in FP
  vmov s13, rptr // backup
  ldr.w rptr, [sp, #16*4] 
  
  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s15, tmp2

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_cache_32_16, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    second_if doublebasemul_asm_acc_cache_32_16, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, s15

  vmov rptr, s13

  pop {r0-r11, pc}
.size matacc_asm_cache_32_16, . - matacc_asm_cache_32_16

.unreq zetaptr
// OPT
.unreq ctr
.unreq tmp
.unreq tmp2
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
  vmov s10, tmp

  ldr.w tmp, [sp, #14*4] // load aprimeptr from stack
  vmov s11, tmp

  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s13, tmp2

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_opt_16_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr

    second_if doublebasemul_asm_opt_16_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr

    update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, s13

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
  vmov s10, tmp

  ldr.w tmp, [sp, #14*4] // load aprimeptr from stack
  vmov s11, tmp

  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s13, tmp2

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_opt_32_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_acc_opt_32_32, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr

    update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, s13

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
  tmp4    .req r4
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
  vmov s10, tmp

  ldr.w tmp, [sp, #14*4] // load aprimeptr from stack
  vmov s11, tmp

  vmov s12, rptr // store "real" destinaton in FP
  vmov s13, rptr // backup
  ldr.w rptr, [sp, #15*4] 
  
  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s15, tmp2

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc_opt_32_16, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_acc_opt_32_16, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, tmp4, k, q, qqinv, ctr

    update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, s15

  vmov rptr, s13

  pop {r0-r11, pc}
.size matacc_asm_opt_32_16, . - matacc_asm_opt_32_16