.p2align 2,,3
.syntax unified
.cpu cortex-m4
.text
.thumb

// void Rq_fromR3(int16 *h, int8 *f)
.global Rq_fromR3
.type Rq_fromR3, %function
Rq_fromR3:
  push {r4-r10}
  mov r10, #95
Rq_fromR3_0:
  ldr r6, [r1, #4]
  ldr r4, [r1], #8
  sxtb16 r8, r4
  sxtb16 r9, r4, ror#8
  pkhbt r4, r8, r9, lsl#16
  pkhtb r5, r9, r8, asr#16
  sxtb16 r8, r6
  sxtb16 r9, r6, ror#8
  pkhbt r6, r8, r9, lsl#16
  pkhtb r7, r9, r8, asr#16
  str r5, [r0, #4]
  str r6, [r0, #8]
  str r7, [r0, #12]
  str r4, [r0], #16
  subs.w r10, #1
  bne Rq_fromR3_0
Rq_fromR3_1:
  ldrb r4, [r1]
  sxtb16 r4, r4
  str r10, [r0, #4]
  str r10, [r0, #8]
  str r10, [r0, #12]
  str r4, [r0]
  pop {r4-r10}
  bx lr
