#include "macros.i"

.syntax unified
.cpu cortex-m4
.thumb

.global asm_barrett_reduce
.type asm_barrett_reduce,%function
.align 2
asm_barrett_reduce:
  push    {r4-r11, r14}

  poly        .req r0
  poly0       .req r1
  poly1       .req r2
  poly2       .req r3
  poly3       .req r4
  poly4       .req r5
  poly5       .req r6
  poly6       .req r7
  poly7       .req r8
  loop        .req r9
  barrettconst .req r10
  q           .req r11
  tmp         .req r12
  tmp2        .req r14

  movw barrettconst, #20159
  movw q, #3329

  movw loop, #16
  1:
    ldm poly, {poly0-poly7}

    doublebarrett poly0, tmp, tmp2, q, barrettconst
    doublebarrett poly1, tmp, tmp2, q, barrettconst
    doublebarrett poly2, tmp, tmp2, q, barrettconst
    doublebarrett poly3, tmp, tmp2, q, barrettconst
    doublebarrett poly4, tmp, tmp2, q, barrettconst
    doublebarrett poly5, tmp, tmp2, q, barrettconst
    doublebarrett poly6, tmp, tmp2, q, barrettconst
    doublebarrett poly7, tmp, tmp2, q, barrettconst

    stm poly!, {poly0-poly7}

    subs.w loop, #1
  bne.w 1b

  pop     {r4-r11, pc}


.macro from_mont q, qinv, a, c, tmp, tmp2
  smulbb \tmp, \a, \c
  montgomery \q, \qinv, \tmp, \tmp2
  smultb \a, \a, \c
  montgomery \q, \qinv, \a, \tmp
  pkhtb \a, \tmp, \tmp2, asr#16
.endm

.global asm_frommont
.type asm_frommont,%function
.align 2
asm_frommont:
  push    {r4-r11, r14}

  poly        .req r0
  poly0       .req r1
  poly1       .req r2
  poly2       .req r3
  poly3       .req r4
  poly4       .req r5
  poly5       .req r6
  poly6       .req r7
  poly7       .req r8
  loop        .req r9
  constant    .req r10
  qinv        .req r11
  q           .req r11
  tmp         .req r12
  tmp2        .req r14

  movw q, #3329
  movt qinv, #3327

  movw constant, #1353

  movw loop, #16
  1:
    ldm poly, {poly0-poly7}

    from_mont q, qinv, poly0, constant, tmp, tmp2
    from_mont q, qinv, poly1, constant, tmp, tmp2
    from_mont q, qinv, poly2, constant, tmp, tmp2
    from_mont q, qinv, poly3, constant, tmp, tmp2
    from_mont q, qinv, poly4, constant, tmp, tmp2
    from_mont q, qinv, poly5, constant, tmp, tmp2
    from_mont q, qinv, poly6, constant, tmp, tmp2
    from_mont q, qinv, poly7, constant, tmp, tmp2

    stm poly!, {poly0-poly7}

    subs.w loop, #1
  bne.w 1b

  pop     {r4-r11, pc}
