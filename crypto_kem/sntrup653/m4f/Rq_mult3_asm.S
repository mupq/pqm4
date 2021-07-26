#include "red-asm.h"

.p2align 2,,3
.syntax unified
.cpu cortex-m4
.thumb

.global Rq_mult3_asm
.type Rq_mult3_asm, %function
@static void Rq_mult3_asm(int16_t *h, const int16_t *f)
Rq_mult3_asm:
  push {r4-r12, lr}

  dest            .req r0
  src             .req r1
  poly0           .req r2
  poly1           .req r3
  poly2           .req r4
  poly3           .req r5
  bot             .req r6
  top             .req r7
  tmp2            .req r8
  tmp             .req r9
  loopctr         .req r10
  three           .req r11
  mq              .req r12
  barrettconst    .req r14

  movw loopctr, #81
  movw three, #3
  mov mq, #4621
  neg mq, mq
  movw barrettconst, #11941
  movt barrettconst, #14
Rq_mult3_asm_0:
  ldr poly0, [src, #4]
  ldr poly1, [src, #8]
  ldr.w poly2, [src, #12]
  ldr poly3, [src], #16

  smulbb bot, poly0, three
  smultb top, poly0, three
  br_32 bot, mq, barrettconst, tmp
  br_32 top, mq, barrettconst, tmp2
  pkhbt poly0, bot, top, lsl#16

  smulbb bot, poly1, three
  smultb top, poly1, three
  br_32 bot, mq, barrettconst, tmp
  br_32 top, mq, barrettconst, tmp2
  pkhbt poly1, bot, top, lsl#16

  smulbb bot, poly2, three
  smultb top, poly2, three
  br_32 bot, mq, barrettconst, tmp
  br_32 top, mq, barrettconst, tmp2
  pkhbt poly2, bot, top, lsl#16

  smulbb bot, poly3, three
  smultb top, poly3, three
  br_32 bot, mq, barrettconst, tmp
  br_32 top, mq, barrettconst, tmp2
  pkhbt poly3, bot, top, lsl#16

  str poly0, [dest, #4]
  str poly1, [dest, #8]
  str poly2, [dest, #12]
  str poly3, [dest], #16
  subs loopctr, #1
  bne Rq_mult3_asm_0
Rq_mult3_asm_1:
  ldr poly0, [src]
  ldr poly1, [src, #4]
  ldr poly2, [src, #8]

  smulbb bot, poly0, three
  smultb top, poly0, three
  br_32 bot, mq, barrettconst, tmp
  br_32 top, mq, barrettconst, tmp2
  pkhbt poly0, bot, top, lsl#16

    smulbb bot, poly1, three
  smultb top, poly1, three
  br_32 bot, mq, barrettconst, tmp
  br_32 top, mq, barrettconst, tmp2
  pkhbt poly1, bot, top, lsl#16

  smulbb bot, poly2, three
  smultb top, poly2, three
  br_32 bot, mq, barrettconst, tmp
  br_32 top, mq, barrettconst, tmp2
  pkhbt poly2, bot, top, lsl#16

  str poly0, [dest]
  str poly1, [dest, #4]
  str poly2, [dest, #8]
  
  pop {r4-r12, lr}
  bx lr
