#include "matacc.i"
.extern aes256xof_squeezeblocks

.syntax unified
.cpu cortex-m4
.thumb

.macro update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, buflenval
  // if (pos + 3 > buflen 
  vmov \tmp2, \buflenval // get buflen value
  vmov \tmp, s1
  sub \tmp3, \bufptr, \tmp // compute pos
  add \tmp3, #3 // pos + 3
  cmp.w \tmp3, \tmp2
  ble.w 3f
  // && ctr < KYBER_N/4) {
  cmp.w \ctr, #256/4
  bge.w 3f
    // tmp = buffer start
    // tmp2 = buffer end
    add \tmp2, \tmp, \tmp2 // buffer start + buf len = last address of xof output byte

    // copy remaining bytes to start of buffer
    ldr.w \tmp3, [\bufptr]
    str.w \tmp3, [\tmp]
    sub \tmp3, \tmp2, \bufptr
    add \tmp, \tmp, \tmp3
    
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
    
    mov r0, \tmp // buf + off implicitly after copying loop
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

// void matacc_asm(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state)
.global matacc_asm
.type matacc_asm, %function
.align 2
matacc_asm:
  push {r0-r11, r14}
  rptr .req r0 
  bptr .req r1
  cptr .req r2
  bufptr .req r3
  zetaptr .req r4
  val0 .req r5
  val1 .req r6
  tmp .req r7
  tmp2 .req r8
  tmp3 .req r9
  k .req r10
  q .req r11
  qqinv .req r12
  ctr .req r14

  movw  qqinv, #3329
  movt qqinv, #3327
  
  ldr.w zetaptr, [sp, #13*4] // load zetaptr from stack
  ldr.w tmp, [sp, #14*4] // load state from stack
  vmov s10, tmp

  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s11, tmp2

  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
    
    second_if doublebasemul_asm, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, s11
  pop {r0-r11, pc}
.size matacc_asm, . - matacc_asm

// void matacc_asm(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state)
.global matacc_asm_acc
.type matacc_asm_acc, %function
.align 2
matacc_asm_acc:
  push {r0-r11, r14}
  rptr .req r0 
  bptr .req r1
  cptr .req r2
  bufptr .req r3
  zetaptr .req r4
  val0 .req r5
  val1 .req r6
  tmp .req r7
  tmp2 .req r8
  tmp3 .req r9
  k .req r10
  q .req r11
  qqinv .req r12
  ctr .req r14

  movw  qqinv, #3329
  movt qqinv, #3327
  
  ldr.w zetaptr, [sp, #13*4] // load zetaptr from stack
  ldr.w tmp, [sp, #14*4] // load state from stack
  vmov s10, tmp
  
  movw tmp2, #64 // XOF_BLOCKBYTES
  vmov s11, tmp2
  
  movw q, #3329
  movw k, #0

  // outer while loop
  movw ctr, #0
  vmov s1, bufptr // save bufptr to check later
  1:

    load_vals val0, val1, bufptr, tmp

    first_if doublebasemul_asm_acc, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
    
    second_if doublebasemul_asm_acc, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr

    update_buf_loop_finish tmp, tmp2, tmp3, val0, val1, bufptr, ctr, s11

  pop {r0-r11, pc}
.size matacc_asm_acc, . - matacc_asm_acc
