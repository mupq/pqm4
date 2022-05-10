#include "macros.i"

.syntax unified
.cpu cortex-m4
.thumb

// general macros
.macro load a, a0, a1, a2, a3, mem0, mem1, mem2, mem3
  ldr.w \a0, [\a, \mem0]
  ldr.w \a1, [\a, \mem1]
  ldr.w \a2, [\a, \mem2]
  ldr.w \a3, [\a, \mem3]
.endm

.macro store a, a0, a1, a2, a3, mem0, mem1, mem2, mem3
  str.w \a0, [\a, \mem0]
  str.w \a1, [\a, \mem1]
  str.w \a2, [\a, \mem2]
  str.w \a3, [\a, \mem3]
.endm

.macro montgomery q, qinv, a, tmp
  smulbt \tmp, \a, \qinv
  smlabb \tmp, \q, \tmp, \a
.endm

.macro montgomery_inplace q, qinv, a, tmp
  smulbt \tmp, \a, \qinv
  smlabb \a, \q, \tmp, \a
.endm

.macro doublemontgomery a, tmp, tmp2, q, qinv, montconst
  smulbb \tmp2, \a, \montconst
  montgomery \q, \qinv, \tmp2, \tmp
  smultb \a, \a, \montconst
  montgomery \q, \qinv, \a, \tmp2
  pkhtb \a, \tmp2, \tmp, asr#16
.endm

// #######
// #######
// # NTT #
// #######
// #######

.macro mul_twiddle tb, a, twiddle, tmp, tmp2, q, qinv
    smulb\tb \tmp, \a, \twiddle
    smult\tb \a, \a, \twiddle
    montgomery \q, \qinv, \tmp, \tmp2 // reduce -> result in tmp2
    montgomery \q, \qinv, \a, \tmp // reduce -> result in tmp2
    pkhtb \a, \tmp, \tmp2, asr#16 // combine results from above in one register as 16bit halves
.endm

.macro doublebutterfly tb, a0, a1, twiddle, tmp, tmp2, q, qinv
  smulb\tb \tmp, \a1, \twiddle // a1_b * twiddle_tb
  smult\tb \a1, \a1, \twiddle // a1_t * twiddle_tb
  montgomery \q, \qinv, \tmp, \tmp2 // reduce -> result in tmp2
  montgomery \q, \qinv, \a1, \tmp // reduce -> result in tmp
  pkhtb \tmp2, \tmp, \tmp2, asr#16 // combine results from above in one register as 16bit halves
  usub16 \a1, \a0, \tmp2 // a0 - a1 * twiddle (a0, a1 contain 2 coeffs)
  uadd16 \a0, \a0, \tmp2 // a0 + a1 * twiddle (a0, a1 contain 2 coeffs)
.endm

.macro two_doublebutterfly tb1, tb2, a0, a1, a2, a3, twiddle, tmp, tmp2, q, qinv
  doublebutterfly \tb1, \a0, \a1, \twiddle, \tmp, \tmp2, \q, \qinv
  doublebutterfly \tb2, \a2, \a3, \twiddle, \tmp, \tmp2, \q, \qinv
.endm

.macro _3_layer_double_CT_16 c0, c1, c2, c3, c4, c5, c6, c7, twiddle, twiddle_ptr, Qprime, Q, tmp, tmp2
    // layer 3
    ldrh.w \twiddle, [\twiddle_ptr], #2
    two_doublebutterfly b, b, \c0, \c4, \c1, \c5, \twiddle, \tmp, \tmp2, \Q, \Qprime
    two_doublebutterfly b, b, \c2, \c6, \c3, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime

    // layer 2
    ldr.w \twiddle, [\twiddle_ptr], #4
    two_doublebutterfly b, b, \c0, \c2, \c1, \c3, \twiddle, \tmp, \tmp2, \Q, \Qprime

    two_doublebutterfly t, t, \c4, \c6, \c5, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime

    // layer 1
    ldr.w \twiddle, [\twiddle_ptr], #4
    two_doublebutterfly b, t, \c0, \c1, \c2, \c3, \twiddle, \tmp, \tmp2, \Q, \Qprime

    ldr.w \twiddle, [\twiddle_ptr], #4
    two_doublebutterfly b, t, \c4, \c5, \c6, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime
.endm

.macro _3_layer_double_CT_16_fp c0, c1, c2, c3, c4, c5, c6, c7, xi01, xi23, xi45, xi67, twiddle, Qprime, Q, tmp, tmp2
    // layer 3
    vmov \twiddle, \xi01
    two_doublebutterfly t, t, \c0, \c4, \c1, \c5, \twiddle, \tmp, \tmp2, \Q, \Qprime
    two_doublebutterfly t, t, \c2, \c6, \c3, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime

    // layer 2
    vmov \twiddle, \xi23
    two_doublebutterfly b, b, \c0, \c2, \c1, \c3, \twiddle, \tmp, \tmp2, \Q, \Qprime

    two_doublebutterfly t, t, \c4, \c6, \c5, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime

    // layer 1
    vmov \twiddle, \xi45
    two_doublebutterfly b, t, \c0, \c1, \c2, \c3, \twiddle, \tmp, \tmp2, \Q, \Qprime

    vmov \twiddle, \xi67
    two_doublebutterfly b, t, \c4, \c5, \c6, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime
.endm

.global small_ntt_asm
.type small_ntt_asm, %function
.align 2
small_ntt_asm:
  push {r4-r11, r14}
  vpush.w {s16}

  poly        .req r0
  twiddle_ptr .req r1
  poly0       .req r2
  poly1       .req r3
  poly2       .req r4
  poly3       .req r5
  poly4       .req r6
  poly5       .req r7
  poly6       .req r8
  poly7       .req r9
  twiddle     .req r10
  qinv        .req r11
  q           .req r11
  tmp         .req r12
  tmp2        .req r14

  movw q, #769
  movt qinv, #767

  ### LAYER 7+6+5+4
  .equ distance, 256
  .equ offset, 32
  .equ strincr, 4
  // pre-load twiddle factors to FPU registers
  vldm twiddle_ptr!, {s8-s15}


  add tmp, poly, #strincr*8
  vmov s16, tmp
  1:
    // load a1, a3, ..., a15
    load poly, poly0, poly1, poly2, poly3, #offset, #distance/4+offset, #2*distance/4+offset, #3*distance/4+offset
    load poly, poly4, poly5, poly6, poly7, #distance+offset, #5*distance/4+offset, #6*distance/4+offset, #7*distance/4+offset

    // 8-NTT on a1, a3, ..., a15
    _3_layer_double_CT_16_fp poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s8, s9, s10, s11, twiddle, qinv, q, tmp, tmp2

    // multiply coeffs by layer 4 twiddles for later use
    vmov twiddle, s12
    mul_twiddle b, poly0, twiddle, tmp, tmp2, q, qinv
    mul_twiddle t, poly1, twiddle, tmp, tmp2, q, qinv

    vmov twiddle, s13
    mul_twiddle b, poly2, twiddle, tmp, tmp2, q, qinv
    mul_twiddle t, poly3, twiddle, tmp, tmp2, q, qinv

    vmov twiddle, s14
    mul_twiddle b, poly4, twiddle, tmp, tmp2, q, qinv
    mul_twiddle t, poly5, twiddle, tmp, tmp2, q, qinv

    vmov twiddle, s15
    mul_twiddle b, poly6, twiddle, tmp, tmp2, q, qinv
    mul_twiddle t, poly7, twiddle, tmp, tmp2, q, qinv

    vmov s0, poly0 // a1
    vmov s1, poly1 // a3
    vmov s2, poly2 // a5
    vmov s3, poly3 // a7
    vmov s4, poly4 // a9
    vmov s5, poly5 // a11
    vmov s6, poly6 // a13
    vmov s7, poly7 // a15

    // ----------

    // load a0, a2, ..., a14
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    // 8-NTT on a0, a2, ..., a14
    _3_layer_double_CT_16_fp poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s8, s9, s10, s11, twiddle, qinv, q, tmp, tmp2

    // layer 4 - 1
    // addsub: (a2, a6, a10, a14), (a3, a7, a11, a15)
    vmov tmp2, s1 // load a3
    vmov s1, poly0 // preserve a0
    uadd16 poly0, poly1, tmp2
    usub16 poly1, poly1, tmp2

    vmov tmp2, s3 // load a7
    vmov s3, poly2 // preserve a4
    uadd16 poly2, poly3, tmp2
    usub16 poly3, poly3, tmp2

    vmov tmp2, s5 // load a11
    vmov s5, poly4 // preserve a8
    uadd16 poly4, poly5, tmp2
    usub16 poly5, poly5, tmp2

    vmov tmp2, s7 // load a15
    vmov s7, poly6 // preserve a12
    uadd16 poly6, poly7, tmp2
    usub16 poly7, poly7, tmp2

    str.w poly0, [poly, #1*distance/4]
    str.w poly1, [poly, #1*distance/4+offset]
    str.w poly2, [poly, #3*distance/4]
    str.w poly3, [poly, #3*distance/4+offset]
    str.w poly4, [poly, #5*distance/4]
    str.w poly5, [poly, #5*distance/4+offset]
    str.w poly6, [poly, #7*distance/4]
    str.w poly7, [poly, #7*distance/4+offset]

    // layer 4 - 2
    // addsub: (a0, a4, a8, a12), (a1, a5, a9, a13)
    vmov tmp2, s1 // load a0
    vmov poly1, s0 // load a1
    uadd16 poly0, tmp2, poly1
    usub16 poly1, tmp2, poly1

    vmov tmp2, s3 // load a4
    vmov poly3, s2 // load a5
    uadd16 poly2, tmp2, poly3
    usub16 poly3, tmp2, poly3

    vmov tmp2, s5 // load a8
    vmov poly5, s4 // load a9
    uadd16 poly4, tmp2, poly5
    usub16 poly5, tmp2, poly5

    vmov tmp2, s7 // load a12
    vmov poly7, s6 // load a13
    uadd16 poly6, tmp2, poly7
    usub16 poly7, tmp2, poly7

    str.w poly1, [poly, #offset]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #2*distance/4+offset]
    str.w poly4, [poly, #4*distance/4]
    str.w poly5, [poly, #4*distance/4+offset]
    str.w poly6, [poly, #6*distance/4]
    str.w poly7, [poly, #6*distance/4+offset]
    str.w poly0, [poly], #4

    vmov tmp, s16
    cmp.w poly, tmp
  bne.w 1b

  sub.w poly, #8*strincr

  ### LAYER 3+2+1

  .equ distance, distance/16
  .equ strincr, 32

  add.w tmp, poly, #strincr*16
  vmov s13, tmp

  2:
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    _3_layer_double_CT_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

    store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    str.w poly1, [poly, #distance/4]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #3*distance/4]
    str.w poly0, [poly], #strincr

    vmov tmp, s13
    cmp.w poly, tmp
  bne.w 2b

  vpop.w {s16}
  pop {r4-r11, pc}


.unreq poly
.unreq twiddle_ptr
.unreq poly0
.unreq poly1
.unreq poly2
.unreq poly3
.unreq poly4
.unreq poly5
.unreq poly6
.unreq poly7
.unreq twiddle
.unreq qinv
.unreq q
.unreq tmp
.unreq tmp2

// ########
// ########
// # INTT #
// ########
// ########

.macro doublebutterfly_light a0, a1, tmp, tmp2, q, qinv
  uadd16 \tmp, \a0, \a1
  usub16 \a1, \a0, \a1
  mov.w \a0, \tmp
.endm

.macro two_doublebutterfly_light a0, a1, a2, a3, tmp, tmp2, q, qinv
  doublebutterfly_light \a0, \a1, \tmp, \tmp2, \q, \qinv
  doublebutterfly_light \a2, \a3, \tmp, \tmp2, \q, \qinv
.endm

.macro _3_layer_double_inv_CT_16_light c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi12, xi34, xi56, twiddle, q, qinv, tmp, tmp2

  // layer 1
  sadd16.w \tmp, \c0, \c1 // c0, c1
  ssub16.w \c1, \c0, \c1
  sadd16.w \tmp2, \c2, \c3 // c2, c3
  ssub16.w \c3, \c2, \c3

  sadd16.w \c0, \c4, \c5 // c4, c5
  ssub16.w \c5, \c4, \c5
  sadd16.w \c2, \c6, \c7 // c6, c7
  ssub16.w \c7, \c6, \c7
  // c4, c6 are free at this point

  // layer 2
  sadd16.w \c6, \tmp, \tmp2 // c0, c2
  ssub16.w \tmp2, \tmp, \tmp2
  sadd16.w \c4, \c0, \c2 // c4, c6
  ssub16.w \c2, \c0, \c2

  vmov.w \twiddle, \xi12
  doublebutterfly t, \c1, \c3, \twiddle, \tmp, \c0, \q, \qinv // c0 has been used and c6 still free
  doublebutterfly t, \c5, \c7, \twiddle, \tmp, \c0, \q, \qinv
  // c0, c6 are free at this point

  // layer 3
  sadd16.w \c0, \c6, \c4 // c0, c4
  ssub16.w \c4, \c6, \c4

  vmov.w \twiddle, \xi34
  doublebutterfly t, \c1, \c5, \twiddle, \tmp, \c6, \q, \qinv

  vmov.w \twiddle, \xi56
  // this block is one doublebutterfly
  smulbb \tmp, \c2, \twiddle // c2, c6
  smultb \c2, \c2, \twiddle
  montgomery_inplace \q, \qinv, \tmp, \c6
  montgomery_inplace \q, \qinv, \c2, \c6
  pkhtb \tmp, \c2, \tmp, asr #16
  ssub16.w \c6, \tmp2, \tmp
  sadd16.w \c2, \tmp2, \tmp

  doublebutterfly t, \c3, \c7, \twiddle, \tmp, \tmp2, \q, \qinv

.endm

.macro _3_layer_double_inv_CT_16_light_reduce c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi12, xi34, xi56, twiddle, q, qinv, tmp, tmp2

  // layer 1
  sadd16.w \tmp, \c0, \c1 // c0, c1
  ssub16.w \c1, \c0, \c1
  sadd16.w \tmp2, \c2, \c3 // c2, c3
  ssub16.w \c3, \c2, \c3

  sadd16.w \c0, \c4, \c5 // c4, c5
  ssub16.w \c5, \c4, \c5
  sadd16.w \c2, \c6, \c7 // c6, c7
  ssub16.w \c7, \c6, \c7
  // c4, c6 are free at this point

  mov.w \c6, \tmp
  mov.w \c4, \c0

  // layer 2
  vmov.w \twiddle, \xi12
  doublebutterfly b, \c6, \tmp2, \twiddle, \tmp, \c0, \q, \qinv
  doublebutterfly b, \c4, \c2, \twiddle, \tmp, \c0, \q, \qinv
  doublebutterfly t, \c1, \c3, \twiddle, \tmp, \c0, \q, \qinv // c0 has been used and c6 still free
  doublebutterfly t, \c5, \c7, \twiddle, \tmp, \c0, \q, \qinv
  // c0, c6 are free at this point

  // layer 3
  sadd16.w \c0, \c6, \c4 // c0, c4
  ssub16.w \c4, \c6, \c4

  vmov.w \twiddle, \xi34
  doublebutterfly t, \c1, \c5, \twiddle, \tmp, \c6, \q, \qinv

  vmov.w \twiddle, \xi56
  // this block is one doublebutterfly
  smulbb \tmp, \c2, \twiddle // c2, c6
  smultb \c2, \c2, \twiddle
  montgomery_inplace \q, \qinv, \tmp, \c6
  montgomery_inplace \q, \qinv, \c2, \c6
  pkhtb \tmp, \c2, \tmp, asr #16
  ssub16.w \c6, \tmp2, \tmp
  sadd16.w \c2, \tmp2, \tmp

  doublebutterfly t, \c3, \c7, \twiddle, \tmp, \tmp2, \q, \qinv

.endm

.macro _3_layer_double_inv_CT_16 c0, c1, c2, c3, c4, c5, c6, c7, twiddle, twiddle_ptr, Qprime, Q, tmp, tmp2
    // layer 3
    ldrh.w twiddle, [twiddle_ptr], #2
    two_doublebutterfly b, b, \c0, \c1, \c2, \c3, \twiddle, \tmp, \tmp2, \Q, \Qprime
    two_doublebutterfly b, b, \c4, \c5, \c6, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime

    // layer 2
    ldr.w twiddle, [twiddle_ptr], #4
    two_doublebutterfly b, t, \c0, \c2, \c1, \c3, \twiddle, \tmp, \tmp2, \Q, \Qprime

    two_doublebutterfly b, t, \c4, \c6, \c5, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime

    // layer 1
    ldr.w twiddle, [twiddle_ptr], #4
    two_doublebutterfly b, t, \c0, \c4, \c1, \c5, \twiddle, \tmp, \tmp2, \Q, \Qprime

    ldr.w twiddle, [twiddle_ptr], #4
    two_doublebutterfly b, t, \c2, \c6, \c3, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime
.endm

.macro mul_twiddle_barrett_32 tb a, twiddle, Qbar, Q, tmp, tmp2
    smulb\tb \tmp, \a, \twiddle
    smmulr.w \tmp2, \tmp, \Qbar
    mls.w \tmp, \tmp2, \Q, \tmp
    smult\tb \a, \a, \twiddle
    smmulr.w \tmp2, \a, \Qbar
    mls.w \a, \tmp2, \Q, \a
    pkhbt \a, \tmp, \a, lsl #16
.endm

.macro _3_layer_double_inv_twist_16 c0, c1, c2, c3, c4, c5, c6, c7, twiddle, twiddle_ptr, Qbar, Q, tmp, tmp2

    movt \Q, #0

    ldr.w \twiddle, [\twiddle_ptr], #4

    mul_twiddle_barrett_32 b, \c0, \twiddle, \Qbar, \Q, \tmp, \tmp2
    mul_twiddle_barrett_32 t, \c1, \twiddle, \Qbar, \Q, \tmp, \tmp2

    ldr.w \twiddle, [\twiddle_ptr], #4

    mul_twiddle_barrett_32 b, \c2, \twiddle, \Qbar, \Q, \tmp, \tmp2
    mul_twiddle_barrett_32 t, \c3, \twiddle, \Qbar, \Q, \tmp, \tmp2

    ldr.w \twiddle, [\twiddle_ptr], #4

    mul_twiddle_barrett_32 b, \c4, \twiddle, \Qbar, \Q, \tmp, \tmp2
    mul_twiddle_barrett_32 t, \c5, \twiddle, \Qbar, \Q, \tmp, \tmp2

    ldr.w \twiddle, [\twiddle_ptr], #4

    mul_twiddle_barrett_32 b, \c6, \twiddle, \Qbar, \Q, \tmp, \tmp2
    mul_twiddle_barrett_32 t, \c7, \twiddle, \Qbar, \Q, \tmp, \tmp2

    movt \Q, #767

.endm

.global small_invntt_tomont_asm
.type small_invntt_tomont_asm, %function
.align 2
small_invntt_tomont_asm:
  push {r4-r11, r14}

  poly        .req r0
  twiddle_ptr .req r1
  poly0       .req r2
  poly1       .req r3
  poly2       .req r4
  poly3       .req r5
  poly4       .req r6
  poly5       .req r7
  poly6       .req r8
  poly7       .req r9
  twiddle     .req r10
  qinv        .req r11
  q           .req r11
  tmp         .req r12
  tmp2        .req r14

  movw q, #769
  movt qinv, #767

  ### LAYER 7+6+5+4
  .equ distance, 16
  .equ offset, 32
  .equ strincr, 64

  // pre-load twiddle factors to FPU registers
  vldm twiddle_ptr!, {s8-s15}

  add.w tmp, poly, #8*strincr
  vmov s8, tmp
  1:
    // load a1, a3, ..., a15
    load poly, poly0, poly1, poly2, poly3, #offset, #distance/4+offset, #2*distance/4+offset, #3*distance/4+offset
    load poly, poly4, poly5, poly6, poly7, #distance+offset, #5*distance/4+offset, #6*distance/4+offset, #7*distance/4+offset

    // NTT on a1, a3, ..., a15
    _3_layer_double_inv_CT_16_light poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s8, s9, s10, s11, twiddle, q, qinv, tmp, tmp2

    // multiply coeffs by layer 4 twiddles for later use
    vmov twiddle, s12
    mul_twiddle b, poly0, twiddle, tmp, tmp2, q, qinv // could be omitted but kept for reduction only
    mul_twiddle t, poly1, twiddle, tmp, tmp2, q, qinv

    vmov twiddle, s13
    mul_twiddle b, poly2, twiddle, tmp, tmp2, q, qinv
    mul_twiddle t, poly3, twiddle, tmp, tmp2, q, qinv

    vmov twiddle, s14
    mul_twiddle b, poly4, twiddle, tmp, tmp2, q, qinv
    mul_twiddle t, poly5, twiddle, tmp, tmp2, q, qinv

    vmov twiddle, s15
    mul_twiddle b, poly6, twiddle, tmp, tmp2, q, qinv
    mul_twiddle t, poly7, twiddle, tmp, tmp2, q, qinv

    vmov s0, poly0 // a1
    vmov s1, poly1 // a3
    vmov s2, poly2 // a5
    vmov s3, poly3 // a7
    vmov s4, poly4 // a9
    vmov s5, poly5 // a11
    vmov s6, poly6 // a13
    vmov s7, poly7 // a15

    // ----------

    // load a0, a2, ..., a14
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    // NTT on a0, a2, ..., a14
    _3_layer_double_inv_CT_16_light poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s8, s9, s10, s11, twiddle, q, qinv, tmp, tmp2

    // layer 4 - 1
    // addsub: (a2, a6, a10, a14), (a3, a7, a11, a15)
    vmov tmp2, s1 // load a3
    vmov s1, poly0 // preserve a0
    uadd16 poly0, poly1, tmp2
    usub16 poly1, poly1, tmp2

    vmov tmp2, s3 // load a7
    vmov s3, poly2 // preserve a4
    uadd16 poly2, poly3, tmp2
    usub16 poly3, poly3, tmp2

    vmov tmp2, s5 // load a11
    vmov s5, poly4 // preserve a8
    uadd16 poly4, poly5, tmp2
    usub16 poly5, poly5, tmp2

    vmov tmp2, s7 // load a15
    vmov s7, poly6 // preserve a12
    uadd16 poly6, poly7, tmp2
    usub16 poly7, poly7, tmp2

    str.w poly0, [poly, #1*distance/4]
    str.w poly1, [poly, #1*distance/4+offset]
    str.w poly2, [poly, #3*distance/4]
    str.w poly3, [poly, #3*distance/4+offset]
    str.w poly4, [poly, #5*distance/4]
    str.w poly5, [poly, #5*distance/4+offset]
    str.w poly6, [poly, #7*distance/4]
    str.w poly7, [poly, #7*distance/4+offset]

    // layer 4 - 2
    // addsub: (a0, a4, a8, a12), (a1, a5, a9, a13)
    vmov tmp2, s1 // load a0
    vmov poly1, s0 // load a1
    uadd16 poly0, tmp2, poly1
    usub16 poly1, tmp2, poly1

    vmov tmp2, s3 // load a4
    vmov poly3, s2 // load a5
    uadd16 poly2, tmp2, poly3
    usub16 poly3, tmp2, poly3

    vmov tmp2, s5 // load a8
    vmov poly5, s4 // load a9
    uadd16 poly4, tmp2, poly5
    usub16 poly5, tmp2, poly5

    vmov tmp2, s7 // load a12
    vmov poly7, s6 // load a13
    uadd16 poly6, tmp2, poly7
    usub16 poly7, tmp2, poly7

    str.w poly1, [poly, #offset]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #2*distance/4+offset]
    str.w poly4, [poly, #4*distance/4]
    str.w poly5, [poly, #4*distance/4+offset]
    str.w poly6, [poly, #6*distance/4]
    str.w poly7, [poly, #6*distance/4+offset]
    str.w poly0, [poly], #strincr // increase 2*8*4 = 64 (2 * 8 loads of 4 bytes each)

    vmov tmp, s8
    cmp.w poly, tmp
  bne.w 1b

  sub.w poly, #8*strincr

  ### LAYER 3+2+1
  .equ distance, distance*16
  .equ strincr, 4

  // ITER 0
  load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
  load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

  vldm twiddle_ptr!, {s5-s7}

  _3_layer_double_inv_CT_16_light_reduce poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s5, s5, s6, s7, twiddle, q, qinv, tmp, tmp2

  vmov.w s2, poly
  movw poly, #:lower16:5585133
  movt poly, #:upper16:5585133

  // twisting
  _3_layer_double_inv_twist_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, poly, q, tmp, tmp2

  vmov.w poly, s2

  store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
  str.w poly1, [poly, #distance/4]
  str.w poly2, [poly, #2*distance/4]
  str.w poly3, [poly, #3*distance/4]
  str.w poly0, [poly], #4

  // ITER 1-12
  add.w tmp, poly, #strincr*3*(3+1)
  vmov s14, tmp
  3:
    add.w tmp, poly, #strincr*3
    vmov s13, tmp
    2:
      // polys upto 6q
      load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
      load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4


      _3_layer_double_inv_CT_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

      vmov.w s2, poly
      movw poly, #:lower16:5585133
      movt poly, #:upper16:5585133

      // twisting
      _3_layer_double_inv_twist_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, poly, q, tmp, tmp2

      vmov.w poly, s2

      store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
      str.w poly1, [poly, #distance/4]
      str.w poly2, [poly, #2*distance/4]
      str.w poly3, [poly, #3*distance/4]
      str.w poly0, [poly], #4

      vmov tmp, s13
      cmp.w poly, tmp
    bne.w 2b

    // polys upto 9q
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    _3_layer_double_inv_CT_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

    vmov.w s2, poly
    movw poly, #:lower16:5585133
    movt poly, #:upper16:5585133

    // twisting
    _3_layer_double_inv_twist_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, poly, q, tmp, tmp2

    vmov.w poly, s2

    store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    str.w poly1, [poly, #distance/4]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #3*distance/4]
    str.w poly0, [poly], #4

    vmov tmp, s14
    cmp.w poly, tmp
  bne.w 3b

  // ITER 13-15
  add tmp, poly, #3*strincr
  vmov s13, tmp
  2:
    // polys upto 6q
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    _3_layer_double_inv_CT_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

    vmov.w s2, poly
    movw poly, #:lower16:5585133
    movt poly, #:upper16:5585133

    // twisting
    _3_layer_double_inv_twist_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, poly, q, tmp, tmp2

    vmov.w poly, s2

    store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    str.w poly1, [poly, #distance/4]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #3*distance/4]
    str.w poly0, [poly], #strincr

    vmov tmp, s13
    cmp.w poly, tmp
  bne.w 2b

  pop {r4-r11, pc}

.unreq poly
.unreq twiddle_ptr
.unreq poly0
.unreq poly1
.unreq poly2
.unreq poly3
.unreq poly4
.unreq poly5
.unreq poly6
.unreq poly7
.unreq twiddle
.unreq qinv
.unreq q
.unreq tmp
.unreq tmp2

.align 2
.global small_pointmul_asm
.type small_pointmul_asm, %function
small_pointmul_asm:
    push.w {r4-r11, lr}

    movw r14, #769
    movt r14, #767

    .equ width, 4

    add.w r12, r2, #64*2
    _point_mul_16_loop:

    ldr.w r7, [r1, #2*width]
    ldr.w r8, [r1, #3*width]
    ldrsh.w r9, [r2, #1*2]
    ldr.w r5, [r1, #1*width]
    ldr.w r4, [r1], #4*width
    ldrsh.w r6, [r2], #2*2

    smultb r10, r4, r6
    montgomery r14, r14, r10, r11
    pkhbt r4, r4, r11


    neg.w r6, r6

    smultb r10, r5, r6
    montgomery r14, r14, r10, r11
    pkhbt r5, r5, r11

    str.w r5, [r0, #1*width]
    str.w r4, [r0], #2*width

    smultb r10, r7, r9
    montgomery r14, r14, r10, r11
    pkhbt r7, r7, r11

    neg.w r9, r9

    smultb r10, r8, r9
    montgomery r14, r14, r10, r11
    pkhbt r8, r8, r11

    str.w r8, [r0, #1*width]
    str.w r7, [r0], #2*width

    cmp.w r2, r12
    bne.w _point_mul_16_loop

    pop.w {r4-r11, pc}

  .align 2
.global small_asymmetric_mul_asm
.type small_asymmetric_mul_asm, %function
small_asymmetric_mul_asm:
    push.w {r4-r11, lr}

    movw r14, #769
    movt r14, #767
    .equ width, 4
    add.w r12, r0, #256*2
    _asymmetric_mul_16_loop:
    ldr.w r7, [r1, #width]
    ldr.w r4, [r1], #2*width
    ldr.w r8, [r2, #width]
    ldr.w r5, [r2], #2*width
    ldr.w r9, [r3, #width]
    ldr.w r6, [r3], #2*width

    smuad r10, r4, r6
    montgomery r14, r14, r10, r6
    smuadx r11, r4, r5
    montgomery r14, r14, r11, r10

    pkhtb r10, r10, r6, asr#16

    str.w r10, [r0], #width

    smuad r10, r7, r9
    montgomery r14, r14, r10, r6
    smuadx r11, r7, r8
    montgomery r14, r14, r11, r10

    pkhtb r10, r10, r6, asr#16
    str.w r10, [r0], #width


    cmp.w r0, r12
    bne.w _asymmetric_mul_16_loop

    pop.w {r4-r11, pc}