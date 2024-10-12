#include "macros.i"
.syntax unified
.cpu cortex-m4
.thumb

// void basemul_asm_opt_16_32(int32_t *, const int16_t *, const int16_t *, const int16_t *)
.global basemul_asm_opt_16_32
.type basemul_asm_opt_16_32, %function
.align 2
basemul_asm_opt_16_32:
  push {r4-r11, lr}
  
  rptr_tmp  .req r0
  aptr      .req r1
  bptr      .req r2
  aprimeptr .req r3
  poly0     .req r4
  poly1     .req r6
  poly2     .req r5
  poly3     .req r7
  q         .req r8
  qa        .req r9
  qinv      .req r10
  tmp       .req r11
  tmp2      .req r12
  loop      .req r14

  //movw qa, #26632
	//movt  q, #3329
	### qinv=0x6ba8f301
	//movw qinv, #62209
	//movt qinv, #27560

  movw loop, #64
  1:
    ldr poly0, [aptr], #4
    ldr poly1, [bptr], #4
    ldr poly2, [aptr], #4
    ldr poly3, [bptr], #4
    ldr.w tmp, [aprimeptr, #4]
    ldr tmp2, [aprimeptr], #8
    
    // (poly0_t * zeta) * poly1_t + poly0_b * poly1_b
    smuad tmp2, tmp2, poly1
    str tmp2, [rptr_tmp], #4

    // poly1_t * poly0_b + poly1_b * poly0_t
    smuadx tmp2, poly0, poly1
    str tmp2, [rptr_tmp], #4
    
    smuad tmp2, tmp, poly3
    str tmp2, [rptr_tmp], #4

    smuadx tmp2, poly2, poly3
    str tmp2, [rptr_tmp], #4

    subs.w loop, #1
  bne.w 1b

  pop {r4-r11, pc}

// void basemul_asm_acc_opt_32_32(int32_t *, const int16_t *, const int16_t *, const int16_t *)
.global basemul_asm_acc_opt_32_32
.type basemul_asm_acc_opt_32_32, %function
.align 2
basemul_asm_acc_opt_32_32:
  push {r4-r11, lr}

  rptr_tmp  .req r0
  aptr      .req r1
  bptr      .req r2
  aprimeptr .req r3
  poly0     .req r4
  poly1     .req r6
  res0      .req r5
  res1      .req r7
  q         .req r8
  qa        .req r9
  qinv      .req r10
  tmp       .req r11
  tmp2      .req r12
  loop      .req r14

  //movw qa, #26632
	//movt  q, #3329
	### qinv=0x6ba8f301
	//movw qinv, #62209
	//movt qinv, #27560

  movw loop, #64
  1:
    ldr poly0, [aptr], #4
    ldr poly1, [bptr], #4
    ldr.w res0, [rptr_tmp]
    ldr tmp2, [aprimeptr], #4
    ldr.w res1, [rptr_tmp, #4]

    // (poly0_t * zeta) * poly1_t + poly0_b * poly0_t + res
    smlad tmp2, tmp2, poly1, res0
    str tmp2, [rptr_tmp], #4

    // poly1_t * poly0_b + poly1_b * poly0_t + res
    smladx tmp, poly0, poly1, res1
    str tmp, [rptr_tmp], #4

    ldr poly0, [aptr], #4
    ldr poly1, [bptr], #4
    ldr.w res0, [rptr_tmp]
    ldr tmp2, [aprimeptr], #4
    ldr.w res1, [rptr_tmp, #4]
    
    smlad tmp2, tmp2, poly1, res0
    str tmp2, [rptr_tmp], #4

    smladx tmp, poly0, poly1, res1
    str tmp, [rptr_tmp], #4

    subs.w loop, #1
  bne.w 1b

  pop {r4-r11, pc}

.unreq rptr_tmp


// void basemul_asm_acc_opt_32_16(int16_t *, const int16_t *, const int16_t *, const int16_t *, const int32_t *)
.global basemul_asm_acc_opt_32_16
.type basemul_asm_acc_opt_32_16, %function
.align 2
basemul_asm_acc_opt_32_16:
  push {r4-r11, lr}

  rptr      .req r0
  aptr      .req r1
  bptr      .req r2
  aprimeptr .req r3
  poly0     .req r4
  poly1     .req r6
  res0      .req r5
  res1      .req r7
  q         .req r8
  qa        .req r9
  qinv      .req r10
  //tmp       .req r11
  tmp2      .req r12
  rptr_tmp  .req r11
  loop      .req r14

  movw qa, #26632
	movt  q, #3329
	### qinv=0x6ba8f301
	movw qinv, #62209
	movt qinv, #27560

  ldr rptr_tmp, [sp, #9*4]
  movw loop, #64
  1:
    ldr poly0, [aptr], #4
    ldr poly1, [bptr], #4
    ldr.w res0, [rptr_tmp], #4
    ldr tmp2, [aprimeptr], #4
    ldr.w res1, [rptr_tmp], #4

    // (poly0_t * zeta) * poly1_t + poly0_b * poly0_b + res
    smlad res0, tmp2, poly1, res0
    plant_red q, qa, qinv, res0

    // poly1_t * poly0_b + poly1_b * poly0_t + res
    smladx res1, poly0, poly1, res1
    plant_red q, qa, qinv, res1

    pkhtb res0, res1, res0, asr#16
    str res0, [rptr], #4

    ldr poly0, [aptr], #4
    ldr poly1, [bptr], #4
    ldr.w res0, [rptr_tmp], #4
    ldr tmp2, [aprimeptr], #4     
    ldr.w res1, [rptr_tmp], #4
    
    smlad res0, tmp2, poly1, res0
    plant_red q, qa, qinv, res0
    
    smladx res1, poly0, poly1, res1
    plant_red q, qa, qinv, res1

    pkhtb res0, res1, res0, asr#16
    str res0, [rptr], #4

    subs.w loop, #1
  bne.w 1b

  pop {r4-r11, pc}