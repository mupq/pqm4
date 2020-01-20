#include "macros.i"

.syntax unified
.cpu cortex-m4
.thumb

.macro doubleinvbutterfly tb, a0, a1, twiddle, tmp, tmp2, q, qinv
  usub16 \tmp, \a0, \a1
  uadd16 \a0, \a0, \a1

  smulb\tb \a1, \tmp, \twiddle
  smult\tb \tmp, \tmp, \twiddle
  montgomery \q, \qinv, \a1, \tmp2
  montgomery \q, \qinv, \tmp, \a1
  pkhtb \a1, \a1, \tmp2, asr#16
.endm

.macro two_doubleinvbutterfly tb1, tb2, a0, a1, a2, a3, twiddle, tmp, tmp2, q, qinv
  doubleinvbutterfly \tb1, \a0, \a1, \twiddle, \tmp, \tmp2, \q, \qinv
  doubleinvbutterfly \tb2, \a2, \a3, \twiddle, \tmp, \tmp2, \q, \qinv
.endm

.macro fqmulprecomp a, twiddle, tmp, tmp2, q, qinv
  smulbt \tmp, \a, \twiddle
  smultt \a, \a, \twiddle
  montgomery \q, \qinv, \a, \tmp2
  montgomery \q, \qinv, \tmp, \a
  pkhtb \a, \tmp2, \a, asr#16
.endm

.macro fullmontgomery a0, a1, a2, a3, tmp, tmp2, q, qinv, montconst
  movw \montconst, #2285
  doublemontgomery \a0, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a1, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a2, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a3, \tmp, \tmp2, \q, \qinv, \montconst
.endm

.global invntt_fast
.type invntt_fast, %function
.align 2
invntt_fast:
  push {r4-r11, lr}

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
  montconst   .req r10
  qinv        .req r11
  q           .req r11
  tmp         .req r12
  tmp2        .req r14

  movw q, #3329
  movt qinv, #3327

  ### LAYER 1 (skip layer 0)
  movw tmp, #16
  1:
    push {tmp}

    ldm poly, {poly0-poly7}

    ldr.w twiddle, [twiddle_ptr], #4
    two_doubleinvbutterfly b, t, poly0, poly1, poly2, poly3, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr], #4
    two_doubleinvbutterfly b, t, poly4, poly5, poly6, poly7, twiddle, tmp, tmp2, q, qinv

    fullmontgomery poly0, poly2, poly4, poly6, tmp, tmp2, q, qinv, montconst

    stm poly!, {poly0-poly7}

    pop {tmp}
    subs.w tmp, #1
  bne.w 1b

  sub.w poly, #512

  .equ distance, 32

  ### LAYER 2+3+4
  movw tmp, #8
  2:
    push {tmp}

    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    ldr.w twiddle, [twiddle_ptr]
    two_doubleinvbutterfly b, t, poly0, poly1, poly2, poly3, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr, #4]
    two_doubleinvbutterfly b, t, poly4, poly5, poly6, poly7, twiddle, tmp, tmp2, q, qinv

    ldr.w twiddle, [twiddle_ptr, #8]
    two_doubleinvbutterfly b, b, poly0, poly2, poly1, poly3, twiddle, tmp, tmp2, q, qinv
    two_doubleinvbutterfly t, t, poly4, poly6, poly5, poly7, twiddle, tmp, tmp2, q, qinv

    ldrh twiddle, [twiddle_ptr, #12]
    two_doubleinvbutterfly b, b, poly0, poly4, poly1, poly5, twiddle, tmp, tmp2, q, qinv
    two_doubleinvbutterfly b, b, poly2, poly6, poly3, poly7, twiddle, tmp, tmp2, q, qinv

    fullmontgomery poly0, poly1, poly2, poly3, tmp, tmp2, q, qinv, montconst

    store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    str.w poly1, [poly, #distance/4]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #3*distance/4]
    str.w poly0, [poly], #4

    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    ldr.w twiddle, [twiddle_ptr], #4
    two_doubleinvbutterfly b, t, poly0, poly1, poly2, poly3, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr], #4
    two_doubleinvbutterfly b, t, poly4, poly5, poly6, poly7, twiddle, tmp, tmp2, q, qinv

    ldr.w twiddle, [twiddle_ptr], #4
    two_doubleinvbutterfly b, b, poly0, poly2, poly1, poly3, twiddle, tmp, tmp2, q, qinv
    two_doubleinvbutterfly t, t, poly4, poly6, poly5, poly7, twiddle, tmp, tmp2, q, qinv

    ldrh twiddle, [twiddle_ptr], #2
    two_doubleinvbutterfly b, b, poly0, poly4, poly1, poly5, twiddle, tmp, tmp2, q, qinv
    two_doubleinvbutterfly b, b, poly2, poly6, poly3, poly7, twiddle, tmp, tmp2, q, qinv

	  fullmontgomery poly0, poly1, poly2, poly3, tmp, tmp2, q, qinv, montconst

    store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    str.w poly1, [poly, #distance/4]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #3*distance/4]
    str.w poly0, [poly], #60

    pop {tmp}
    subs.w tmp, #1
  bne.w 2b

  sub.w poly, #512

  .equ distance, 8*distance

  ### LAYER 5+6+7
  movw tmp, #16
  3:
    push {tmp}

    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    ldr.w twiddle, [twiddle_ptr]
    two_doubleinvbutterfly b, t, poly0, poly1, poly2, poly3, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr, #4]
    two_doubleinvbutterfly b, t, poly4, poly5, poly6, poly7, twiddle, tmp, tmp2, q, qinv

    ldr.w twiddle, [twiddle_ptr, #8]
    two_doubleinvbutterfly b, b, poly0, poly2, poly1, poly3, twiddle, tmp, tmp2, q, qinv
    two_doubleinvbutterfly t, t, poly4, poly6, poly5, poly7, twiddle, tmp, tmp2, q, qinv

    ldr.w twiddle, [twiddle_ptr, #12]
    two_doubleinvbutterfly b, b, poly0, poly4, poly1, poly5, twiddle, tmp, tmp2, q, qinv
    two_doubleinvbutterfly b, b, poly2, poly6, poly3, poly7, twiddle, tmp, tmp2, q, qinv

    fqmulprecomp poly0, twiddle, tmp, tmp2, q, qinv
    fqmulprecomp poly1, twiddle, tmp, tmp2, q, qinv
    fqmulprecomp poly2, twiddle, tmp, tmp2, q, qinv
    fqmulprecomp poly3, twiddle, tmp, tmp2, q, qinv

    store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    str.w poly1, [poly, #distance/4]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #3*distance/4]
    str.w poly0, [poly], #4

    pop {tmp}
    subs.w tmp, #1
  bne.w 3b

  pop {r4-r11, pc}
