#include "macros.i"

.syntax unified
.cpu cortex-m4
.thumb

.macro doublebutterfly tb, a0, a1, twiddle, tmp, tmp2, q, qinv
  smulb\tb \tmp, \a1, \twiddle
  smult\tb \a1, \a1, \twiddle
  montgomery \q, \qinv, \tmp, \tmp2
  montgomery \q, \qinv, \a1, \tmp
  pkhtb \tmp2, \tmp, \tmp2, asr#16
  usub16 \a1, \a0, \tmp2
  uadd16 \a0, \a0, \tmp2
.endm

.macro two_doublebutterfly tb1, tb2, a0, a1, a2, a3, twiddle, tmp, tmp2, q, qinv
  doublebutterfly \tb1, \a0, \a1, \twiddle, \tmp, \tmp2, \q, \qinv
  doublebutterfly \tb2, \a2, \a3, \twiddle, \tmp, \tmp2, \q, \qinv
.endm

.global ntt_fast
.type ntt_fast, %function
.align 2
ntt_fast:
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
  barrettconst .req r10
  qinv        .req r11
  q           .req r11
  tmp         .req r12
  tmp2        .req r14

  movw q, #3329
  movt qinv, #3327

  .equ barrett_constant, 20159
  .equ distance, 256

  ### LAYER 7+6+5
  movw tmp, #16
  1:
    push {tmp}

    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    ldrh twiddle, [twiddle_ptr]
    two_doublebutterfly b, b, poly0, poly4, poly1, poly5, twiddle, tmp, tmp2, q, qinv
    two_doublebutterfly b, b, poly2, poly6, poly3, poly7, twiddle, tmp, tmp2, q, qinv

    ldr.w twiddle, [twiddle_ptr, #2]
    two_doublebutterfly b, b, poly0, poly2, poly1, poly3, twiddle, tmp, tmp2, q, qinv
    two_doublebutterfly t, t, poly4, poly6, poly5, poly7, twiddle, tmp, tmp2, q, qinv

    ldr.w twiddle, [twiddle_ptr, #6]
    two_doublebutterfly b, t, poly0, poly1, poly2, poly3, twiddle, tmp, tmp2, q, qinv

    ldr.w twiddle, [twiddle_ptr, #10]
    two_doublebutterfly b, t, poly4, poly5, poly6, poly7, twiddle, tmp, tmp2, q, qinv

    store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    str.w poly1, [poly, #distance/4]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #3*distance/4]
    str.w poly0, [poly], #4

    pop {tmp}
    subs.w tmp, #1
  bne.w 1b

  sub.w poly, #64
  add.w twiddle_ptr, #14

  .equ distance, distance/8

  ### LAYER 4+3+2
  movw tmp, #8
  2:
    push {tmp}

    movw tmp, #2
    3:
      push {tmp}

      load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
      load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4


      ldrh twiddle, [twiddle_ptr]
      two_doublebutterfly b, b, poly0, poly4, poly1, poly5, twiddle, tmp, tmp2, q, qinv
      two_doublebutterfly b, b, poly2, poly6, poly3, poly7, twiddle, tmp, tmp2, q, qinv

      ldr.w twiddle, [twiddle_ptr, #2]
      two_doublebutterfly b, b, poly0, poly2, poly1, poly3, twiddle, tmp, tmp2, q, qinv
      two_doublebutterfly t, t, poly4, poly6, poly5, poly7, twiddle, tmp, tmp2, q, qinv

      ldr.w twiddle, [twiddle_ptr, #6]
      two_doublebutterfly b, t, poly0, poly1, poly2, poly3, twiddle, tmp, tmp2, q, qinv

      ldr.w twiddle, [twiddle_ptr, #10]
      two_doublebutterfly b, t, poly4, poly5, poly6, poly7, twiddle, tmp, tmp2, q, qinv

      store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
      str.w poly1, [poly, #distance/4]
      str.w poly2, [poly, #2*distance/4]
      str.w poly3, [poly, #3*distance/4]
      str.w poly0, [poly], #4

      pop {tmp}
      subs.w tmp, #1
    bne.w 3b

    add.w poly, #56
    add.w twiddle_ptr, #14

    pop {tmp}
    subs.w tmp, #1
  bne.w 2b

  sub poly, #512

  ### LAYER 1 (skip layer 0)
  movw tmp, #16
  4:
    push {tmp}

    ldm poly, {poly0-poly7}

    ldr.w twiddle, [twiddle_ptr], #4
    two_doublebutterfly b, t, poly0, poly1, poly2, poly3, twiddle, tmp, tmp2, q, qinv

    ldr.w twiddle, [twiddle_ptr], #4
    two_doublebutterfly b, t, poly4, poly5, poly6, poly7, twiddle, tmp, tmp2, q, qinv

    movw barrettconst, #barrett_constant
    doublebarrett poly0, tmp, tmp2, q, barrettconst
    doublebarrett poly1, tmp, tmp2, q, barrettconst
    doublebarrett poly2, tmp, tmp2, q, barrettconst
    doublebarrett poly3, tmp, tmp2, q, barrettconst
    doublebarrett poly4, tmp, tmp2, q, barrettconst
    doublebarrett poly5, tmp, tmp2, q, barrettconst
    doublebarrett poly6, tmp, tmp2, q, barrettconst
    doublebarrett poly7, tmp, tmp2, q, barrettconst

    stm poly!, {poly0-poly7}

    pop {tmp}
    subs.w tmp, #1
  bne.w 4b

  pop {r4-r11, pc}
