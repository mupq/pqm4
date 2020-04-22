.p2align 2,,3
.syntax unified
.cpu cortex-m4
.text
.thumb

// void Rq_mov(int16 *h, int16 *f)
.global Rq_mov
.type Rq_mov, %function
Rq_mov:
  push {r4-r8}
  mov r8, #95
Rq_mov_0:
  ldr r5, [r1, #4]
  ldr r6, [r1, #8]
  ldr.w r7, [r1, #12]
  ldr r4, [r1], #16
  str r5, [r0, #4]
  str r6, [r0, #8]
  str r7, [r0, #12]
  str r4, [r0], #16
  subs.w r8, #1
  bne Rq_mov_0
Rq_mov_1:
  ldrh r4, [r1]
  str r8, [r0, #4]
  str r8, [r0, #8]
  str r8, [r0, #12]
  str r4, [r0]
  pop {r4-r8}
  bx lr
