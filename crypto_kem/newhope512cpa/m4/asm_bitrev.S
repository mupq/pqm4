#include "params.h"

.syntax unified
.cpu cortex-m4
.thumb



.global bitrev
.type bitrev,%function
.align 2
bitrev:
  push    {r4-r11, r14}
  poly        .req r0
  ind         .req r1
  indrev      .req r2
  next        .req r3
  poly0       .req r4
  poly1       .req r5
  poly2       .req r6
  poly3       .req r7
  tmp0        .req r8
  tmp1        .req r9
  polyhalf    .req r10
  add polyhalf, poly, #NEWHOPE_N
  movw ind, #0
  mov indrev, ind
loop:

  ldr poly0, [poly, ind]
  ldr poly1, [polyhalf, ind]
  ldr poly2, [poly, indrev]
  ldr poly3, [polyhalf, indrev]

  pkhbt tmp0, poly0, poly1, lsl#16
  pkhtb tmp1, poly1, poly0, asr#16
  pkhbt poly0, poly2, poly3, lsl#16
  pkhtb poly1, poly3, poly2, asr#16

  str poly0, [poly, ind]
  str poly1, [polyhalf, ind]
  str tmp0,  [poly, indrev]
  str tmp1,  [polyhalf, indrev]
	
skip:  
  add ind, ind, #4
  lsl indrev, ind, #21
  rbit indrev, indrev
  cmp indrev, ind
  bgt skip
  cmp ind, #NEWHOPE_N
  bne loop
  pop {r4-r11,pc}
