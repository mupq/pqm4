#include "red-asm.h"

.p2align 2,,3
.syntax unified
.text
.cpu cortex-m4
.thumb

//void Rq_redp(int16 *h, int16 *f)
.global Rq_redp
.type Rq_redp, %function
Rq_redp:
  push {r4-r12}

  dest          .req r0
  src           .req r1
  poly0         .req r2
  poly1         .req r3
  polyhigh0     .req r4
  polyhigh1     .req r5
  tmp3          .req r6
  tmp2          .req r7
  tmp           .req r8
  loopctr       .req r9
  twop15         .req r10
  mq            .req r11
  barrettconst  .req r12

  mov loopctr, #379
  mov twop15, #32768
  mov mq, #4591
  neg mq, mq
  movw barrettconst, #0x465f
  movt barrettconst, #0xe
Rq_redp_0: // f[0]
  ldrsh polyhigh0, [src, #1522] // (f[761])
  ldrsh poly0, [src], #2 // f[0]
  add poly0, poly0, polyhigh0
  br_32 poly0, mq, barrettconst, tmp
  strh poly0, [dest], #2
Rq_redp_1: // main loop
  ldr polyhigh0, [src, #1520] // (f[762])(f[761])
  ldr polyhigh1, [src, #1522] // (f[763])(f[762])
  ldr poly0, [src], #4  // (f[2])(f[1])

  sadd16 tmp3, polyhigh0, poly0 // (f[2]+f[762])(f[1]+f[761])
  br_16x2 tmp3, mq, barrettconst, twop15, tmp, tmp2
  sadd16 poly0, polyhigh1, tmp3 // (f[2]+f[762]+f[763])(f[1]+f[761]+f[762])
  br_16x2 poly0, mq, barrettconst, twop15, tmp, tmp2

  str poly0, [dest], #4
  subs.w loopctr, #1
  bne Rq_redp_1
Rq_redp_2: // f[759] and f[760]
  ldr polyhigh0, [src, #1520] // (f[1520])(f[1519])
  ldrh polyhigh1, [src, #1522] // (0)(f[1520])
  ldr poly0, [src], #4  // (f[760])(f[759])

  sadd16 tmp3, polyhigh0, poly0 // (f[760]+f[1520])(f[759]+f[1519])
  br_16x2 tmp3, mq, barrettconst, twop15, tmp, tmp2
  sadd16 poly0, polyhigh1, tmp3 // (f[760]+f[1520])(f[759]+f[1519]+f[1520])
  br_16x2 poly0, mq, barrettconst, twop15, tmp, tmp2

  str poly0, [dest], #4
  pop {r4-r12}
  bx lr
