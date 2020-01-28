#include "macros.i"
#include "macros_invntt.i"

.syntax unified
.cpu cortex-m4
.thumb


.macro fullmontgomery a0, a1, a2, a3, a4, a5, a6, a7, tmp, tmp2, q, qinv, montconst
  movw \montconst, #4091
  doublemontgomery \a0, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a1, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a2, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a3, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a4, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a5, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a6, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a7, \tmp, \tmp2, \q, \qinv, \montconst
.endm

.macro halfmontgomery a0, a1, a2, a3, tmp, tmp2, q, qinv, montconst
  movw \montconst, #4091
  doublemontgomery \a0, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a1, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a2, \tmp, \tmp2, \q, \qinv, \montconst
  doublemontgomery \a3, \tmp, \tmp2, \q, \qinv, \montconst
.endm

.global asm_invntt
.type asm_invntt,%function
.align 2
asm_invntt:
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
  montconst   .req r10
  qinv        .req r11
  q           .req r11
  tmp         .req r12
  tmp2        .req r14

  movw q, #12289
  movt qinv, #12287  // gp command: Mod(-12289^-1, 2^16)

  .equ distance, 512

  .equ loopcount, 32

  /* stages 9 & 8 & 7 for n=512 */
#ifdef USE_REPT
  .rept loopcount
#else
  movw tmp, #loopcount
  1:
    push {tmp}
#endif

    // ldm poly, {poly0-poly7} // This line is slower than below by 8 cycles.
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    // Stage 9
    ldr.w twiddle, [twiddle_ptr], #4
    doubleinvbutterfly b, t, poly0, poly4, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr], #4
    doubleinvbutterfly b, t, poly1, poly5, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr], #4
    doubleinvbutterfly b, t, poly2, poly6, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr], #4
    doubleinvbutterfly b, t, poly3, poly7, twiddle, tmp, tmp2, q, qinv
    halfmontgomery poly0, poly1, poly2, poly3, tmp, tmp2, q, qinv, montconst

    // Stage 8
    ldr.w twiddle, [twiddle_ptr], #4
    two_doubleinvbutterfly b, t, poly0, poly2, poly4, poly6, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr], #4
    two_doubleinvbutterfly b, t, poly1, poly3, poly5, poly7, twiddle, tmp, tmp2, q, qinv
    halfmontgomery poly0, poly4, poly1, poly5, tmp, tmp2, q, qinv, montconst

    store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    str.w poly1, [poly, #distance/4]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #3*distance/4]
    str.w poly0, [poly], #4

#ifdef USE_REPT
  .endr
#else
    pop {tmp}
    subs.w tmp, #1
    bne.w 1b
#endif

  sub poly, #distance/4

  .equ distance, 128
  /* stage 6 & 5 & 4 */
  .equ loopcount2, 4

#ifdef USE_REPT
  .rept loopcount2
#else
  movw tmp, #loopcount2
  2:
    push {tmp}
#endif

#ifdef USE_REPT
    .rept 8
#else
    movw tmp, #8
    3:
      push {tmp}
#endif

      load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
      load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

      // Stage 7
      ldr.w twiddle, [twiddle_ptr]
      doubleinvbutterfly b, t, poly0, poly4, twiddle, tmp, tmp2, q, qinv
      ldr.w twiddle, [twiddle_ptr, #4]
      doubleinvbutterfly b, t, poly1, poly5, twiddle, tmp, tmp2, q, qinv
      ldr.w twiddle, [twiddle_ptr, #8]
      doubleinvbutterfly b, t, poly2, poly6, twiddle, tmp, tmp2, q, qinv
      ldr.w twiddle, [twiddle_ptr, #12]
      doubleinvbutterfly b, t, poly3, poly7, twiddle, tmp, tmp2, q, qinv
      halfmontgomery poly0, poly1, poly2, poly3, tmp, tmp2, q, qinv, montconst

      // Stage 6
      ldr.w twiddle, [twiddle_ptr, #16]
      two_doubleinvbutterfly b, t, poly0, poly2, poly4, poly6, twiddle, tmp, tmp2, q, qinv
      ldr.w twiddle, [twiddle_ptr, #20]
      two_doubleinvbutterfly b, t, poly1, poly3, poly5, poly7, twiddle, tmp, tmp2, q, qinv
      halfmontgomery poly0, poly1, poly4, poly5, tmp, tmp2, q, qinv, montconst

      // Stage 5
      ldr.w twiddle, [twiddle_ptr, #24]
      two_doubleinvbutterfly b, t, poly0, poly1, poly2, poly3, twiddle, tmp, tmp2, q, qinv
      two_doubleinvbutterfly b, t, poly4, poly5, poly6, poly7, twiddle, tmp, tmp2, q, qinv
      halfmontgomery poly0, poly2, poly4, poly6, tmp, tmp2, q, qinv, montconst

      store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
      str.w poly1, [poly, #distance/4]
      str.w poly2, [poly, #2*distance/4]
      str.w poly3, [poly, #3*distance/4]
      str.w poly0, [poly], #4

      add twiddle_ptr, #28
#ifdef USE_REPT
    .endr
#else
      pop {tmp}
      subs.w tmp, #1
      bne.w 3b
#endif

    add poly, #7*distance/4
    sub twiddle_ptr, #224
#ifdef USE_REPT
  .endr
#else
    pop {tmp}
    subs.w tmp, #1
    bne.w 2b
#endif

  sub poly, #1024
  add twiddle_ptr, #224
  .equ distance, 16

  /* stage 3 & 2 & 1 */
#ifdef USE_REPT
  .rept loopcount
#else
  movw tmp, #loopcount
  4:
    push {tmp}
#endif

    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    // Stage 4
    ldr.w twiddle, [twiddle_ptr]
    doubleinvbutterfly b, t, poly0, poly4, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr, #4]
    doubleinvbutterfly b, t, poly1, poly5, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr, #8]
    doubleinvbutterfly b, t, poly2, poly6, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr, #12]
    doubleinvbutterfly b, t, poly3, poly7, twiddle, tmp, tmp2, q, qinv
    halfmontgomery poly0, poly1, poly2, poly3, tmp, tmp2, q, qinv, montconst

    // Stage 3
    ldr.w twiddle, [twiddle_ptr, #16]
    two_doubleinvbutterfly b, t, poly0, poly2, poly4, poly6, twiddle, tmp, tmp2, q, qinv
    ldr.w twiddle, [twiddle_ptr, #20]
    two_doubleinvbutterfly b, t, poly1, poly3, poly5, poly7, twiddle, tmp, tmp2, q, qinv
    halfmontgomery poly0, poly4, poly1, poly5, tmp, tmp2, q, qinv, montconst

    // Stage 2
    ldr.w twiddle, [twiddle_ptr, #24]
    two_doubleinvbutterfly b, t, poly0, poly1, poly2, poly3, twiddle, tmp, tmp2, q, qinv
    two_doubleinvbutterfly b, t, poly4, poly5, poly6, poly7, twiddle, tmp, tmp2, q, qinv
    halfmontgomery poly0, poly2, poly4, poly6, tmp, tmp2, q, qinv, montconst

    // Stage 1
    ldr.w twiddle, [twiddle_ptr, #28]
    doubleinvbutterfly_last_stage poly0, poly1, twiddle, tmp, tmp2, q, qinv
    doubleinvbutterfly_last_stage poly2, poly3, twiddle, tmp, tmp2, q, qinv
    doubleinvbutterfly_last_stage poly4, poly5, twiddle, tmp, tmp2, q, qinv
    doubleinvbutterfly_last_stage poly6, poly7, twiddle, tmp, tmp2, q, qinv

    stm poly!, {poly0-poly7}

#ifdef USE_REPT
  .endr
#else
    pop {tmp}
    subs.w tmp, #1
    bne.w 4b
#endif

  pop {r4-r11, pc}
