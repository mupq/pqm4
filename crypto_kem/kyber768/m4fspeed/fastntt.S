#include "macros.i"

.syntax unified
.cpu cortex-m4
.thumb

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

.macro half_barrett poly0, poly1, poly2, poly3, barrettconst, barrettconst2, tmp, tmp2, q
  doublebarrett_fast \poly0, \tmp, \tmp2, \q, \barrettconst, \barrettconst2
  doublebarrett_fast \poly1, \tmp, \tmp2, \q, \barrettconst, \barrettconst2
  doublebarrett_fast \poly2, \tmp, \tmp2, \q, \barrettconst, \barrettconst2
  doublebarrett_fast \poly3, \tmp, \tmp2, \q, \barrettconst, \barrettconst2
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

.global ntt_fast
.type ntt_fast, %function
.align 2
ntt_fast:
  push {r4-r11, r14}
  vpush.w {s16}
  poly         .req r0
  twiddle_ptr  .req r1
  poly0        .req r2
  poly1        .req r3
  poly2        .req r4
  poly3        .req r5
  poly4        .req r6
  poly5        .req r7
  poly6        .req r8
  poly7        .req r9
  twiddle      .req r10
  barrettconst .req r10
  qinv         .req r11
  q            .req r11
  tmp          .req r12
  tmp2         .req r14

  movw q, #3329
  movt qinv, #3327
  
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

    // load a0, a2, ..., a14
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    
    // 8-NTT on a0, a2, ..., a14
    _3_layer_double_CT_16_fp poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s8, s9, s10, s11, twiddle, qinv, q, tmp, tmp2

    // layer 4 - 1
    // addsub: (a2, a6, a10, a14), (a3, a7, a11, a15)
    vmov tmp2, s1 // load a3
    uadd16 tmp, poly1, tmp2
    usub16 poly1, poly1, tmp2
    str.w tmp, [poly, #1*distance/4]
    str.w poly1, [poly, #1*distance/4+offset]

    vmov tmp2, s3 // load a7
    uadd16 tmp, poly3, tmp2
    usub16 poly3, poly3, tmp2
    str.w tmp, [poly, #3*distance/4]
    str.w poly3, [poly, #3*distance/4+offset]
    
    vmov tmp2, s5 // load a11
    uadd16 tmp, poly5, tmp2
    usub16 poly5, poly5, tmp2
    str.w tmp, [poly, #5*distance/4]
    str.w poly5, [poly, #5*distance/4+offset]
    
    vmov tmp2, s7 // load a15
    uadd16 tmp, poly7, tmp2
    usub16 poly7, poly7, tmp2
    str.w tmp, [poly, #7*distance/4]
    str.w poly7, [poly, #7*distance/4+offset]
    
    // layer 4 - 2    
    // addsub: (a0, a4, a8, a12), (a1, a5, a9, a13)
    vmov poly3, s2 // load a5
    uadd16 tmp, poly2, poly3
    usub16 tmp2, poly2, poly3
    str.w tmp, [poly, #2*distance/4]
    str.w tmp2, [poly, #2*distance/4+offset]

    vmov poly5, s4 // load a9
    uadd16 tmp, poly4, poly5
    usub16 tmp2, poly4, poly5
    str.w tmp, [poly, #4*distance/4]
    str.w tmp2, [poly, #4*distance/4+offset]

    vmov poly7, s6 // load a13
    uadd16 tmp, poly6, poly7
    usub16 tmp2, poly6, poly7
    str.w tmp, [poly, #6*distance/4]
    str.w tmp2, [poly, #6*distance/4+offset]
    
    vmov poly1, s0 // load a1
    uadd16 tmp, poly0, poly1
    usub16 tmp2, poly0, poly1
    str.w tmp2, [poly, #offset]    
    str.w tmp, [poly], #4

    vmov tmp, s16
    cmp.w poly, tmp
  bne.w 1b

  sub.w poly, #8*strincr

  ### LAYER 3+2+1

  // barrettconst = -(2^(32)/KYBER_Q)
  movw barrettconst, #0x5049
  movt barrettconst, #0xffec
  vmov s10, barrettconst

  // barrettconst2 = 2^(15)
  movw barrettconst, #32768
  vmov s11, barrettconst

  .equ distance, distance/16
  .equ strincr, 32

  add.w tmp, poly, #strincr*16
  vmov s13, tmp

  2:
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    _3_layer_double_CT_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

    // load barrettconst = -(2^(32)/KYBER_Q)
    vmov barrettconst, s10

    // load barrettconst2 = 2^(15)
    vmov s2, poly
    vmov poly, s11
    half_barrett poly0, poly1, poly2, poly3, barrettconst, poly, tmp, tmp2, q
    half_barrett poly4, poly5, poly6, poly7, barrettconst, poly, tmp, tmp2, q
    vmov poly, s2
    
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
