#include "params.h"

.syntax unified
.cpu cortex-m4
.thumb

.text

.align  2
.global AIMER_NAMESPACE(GF_to_bytes)
.global AIMER_NAMESPACE(GF_from_bytes)
.global AIMER_NAMESPACE(GF_copy)
.type   AIMER_NAMESPACE(GF_to_bytes), %function
.type   AIMER_NAMESPACE(GF_from_bytes), %function
.type   AIMER_NAMESPACE(GF_copy), %function
AIMER_NAMESPACE(GF_to_bytes):
AIMER_NAMESPACE(GF_from_bytes):
AIMER_NAMESPACE(GF_copy):
  out_p       .req R0
  in_p        .req R1

  .equ width, 4

  ldr.w R2, [in_p, #0 * width]
  ldr.w R3, [in_p, #1 * width]
  str.w R2, [out_p, #0 * width]
  str.w R3, [out_p, #1 * width]

  ldr.w R2, [in_p, #2 * width]
  ldr.w R3, [in_p, #3 * width]
  str.w R2, [out_p, #2 * width]
  str.w R3, [out_p, #3 * width]

  ldr.w R2, [in_p, #4 * width]
  ldr.w R3, [in_p, #5 * width]
  str.w R2, [out_p, #4 * width]
  str.w R3, [out_p, #5 * width]

  bx    lr

  .unreq in_p
  .unreq out_p

.align  2
.global AIMER_NAMESPACE(GF_set0)
.type   AIMER_NAMESPACE(GF_set0), %function
AIMER_NAMESPACE(GF_set0):
  out_p       .req R0

  .equ width, 4

  mov.w R2, #0
  str.w R2, [out_p, #0 * width]
  str.w R2, [out_p, #1 * width]
  str.w R2, [out_p, #2 * width]
  str.w R2, [out_p, #3 * width]
  str.w R2, [out_p, #4 * width]
  str.w R2, [out_p, #5 * width]

  bx    lr

  .unreq out_p

.align  2
.global AIMER_NAMESPACE(GF_add)
.type   AIMER_NAMESPACE(GF_add), %function
AIMER_NAMESPACE(GF_add):
  out_p       .req R0
  in0_p       .req R1
  in1_p       .req R2

  .equ width, 4

  ldr.w R3,  [in0_p, #0 * width]
  ldr.w R12, [in1_p, #0 * width]
  eor.w R3, R3, R12
  str.w R3,  [out_p, #0 * width]

  ldr.w R3,  [in0_p, #1 * width]
  ldr.w R12, [in1_p, #1 * width]
  eor.w R3, R3, R12
  str.w R3,  [out_p, #1 * width]

  ldr.w R3,  [in0_p, #2 * width]
  ldr.w R12, [in1_p, #2 * width]
  eor.w R3, R3, R12
  str.w R3,  [out_p, #2 * width]

  ldr.w R3,  [in0_p, #3 * width]
  ldr.w R12, [in1_p, #3 * width]
  eor.w R3, R3, R12
  str.w R3,  [out_p, #3 * width]

  ldr.w R3,  [in0_p, #4 * width]
  ldr.w R12, [in1_p, #4 * width]
  eor.w R3, R3, R12
  str.w R3,  [out_p, #4 * width]

  ldr.w R3,  [in0_p, #5 * width]
  ldr.w R12, [in1_p, #5 * width]
  eor.w R3, R3, R12
  str.w R3,  [out_p, #5 * width]

  bx    lr

  .unreq out_p
  .unreq in0_p
  .unreq in1_p

.macro or_shift_and in_a, con_a, off_a
  orr.w \in_a, \in_a, \in_a, lsl #\off_a
  and.w \in_a, \in_a, \con_a
.endm

.align  2
.global AIMER_NAMESPACE(GF_sqr_s)
.type   AIMER_NAMESPACE(GF_sqr_s), %function
AIMER_NAMESPACE(GF_sqr_s):
  out_p       .req R0
  in_p        .req R1

  in0         .req R2
  in1         .req R3
  in2         .req R4
  in3         .req R5
  in4         .req R6
  in5         .req R7
  in6         .req R8
  in7         .req R9

  .equ C0,    1431655765  // 0x55555555
  .equ C1,    858993459   // 0x33333333
  .equ C2,    252645135   // 0x0F0F0F0F
  .equ C3,    16711935    // 0x00FF00FF
  .equ C4,    4294967295  // 0xFFFFFFFF
  .equ width, 4

  push.w {R4-R10, lr}

  ldr.w in0, [in_p, #2 * width]  // a[1]
  ldr.w in2, [in_p, #3 * width]
  ldr.w in4, [in_p, #4 * width]  // a[2]
  ldr.w in6, [in_p, #5 * width]

  lsr.w in1, in0, #16
  lsr.w in3, in2, #16
  lsr.w in5, in4, #16
  lsr.w in7, in6, #16

  mov.w R10, C4

  and.w in0, in0, R10, lsr #16
  and.w in2, in2, R10, lsr #16
  and.w in4, in4, R10, lsr #16
  and.w in6, in6, R10, lsr #16

  or_shift_and in0, C3, 8
  or_shift_and in1, C3, 8
  or_shift_and in2, C3, 8
  or_shift_and in3, C3, 8
  or_shift_and in4, C3, 8
  or_shift_and in5, C3, 8
  or_shift_and in6, C3, 8
  or_shift_and in7, C3, 8

  or_shift_and in0, C2, 4
  or_shift_and in1, C2, 4
  or_shift_and in2, C2, 4
  or_shift_and in3, C2, 4
  or_shift_and in4, C2, 4
  or_shift_and in5, C2, 4
  or_shift_and in6, C2, 4
  or_shift_and in7, C2, 4

  or_shift_and in0, C1, 2
  or_shift_and in1, C1, 2
  or_shift_and in2, C1, 2
  or_shift_and in3, C1, 2
  or_shift_and in4, C1, 2
  or_shift_and in5, C1, 2
  or_shift_and in6, C1, 2
  or_shift_and in7, C1, 2

  or_shift_and in0, C0, 1
  or_shift_and in1, C0, 1
  or_shift_and in2, C0, 1
  or_shift_and in3, C0, 1
  or_shift_and in4, C0, 1
  or_shift_and in5, C0, 1
  or_shift_and in6, C0, 1
  or_shift_and in7, C0, 1

  // t = temp[3] ^ ((temp[5] >> 57) ^ (temp[5] >> 62) ^ (temp[5] >> 63));
  eor.w in2, in2, in7, lsr #25
  eor.w in2, in2, in7, lsr #30
  eor.w in2, in2, in7, lsr #31

  // c[2] = temp[2] ^ temp[5];
  eor.w in0, in0, in6
  eor.w in1, in1, in7

  // c[2] ^= (temp[5] << 7) | ((temp[4] >> 57);
  // c[2] ^= (temp[5] << 2) | ((temp[4] >> 62);
  // c[2] ^= (temp[5] << 1) | ((temp[4] >> 63);
  eor.w in0, in0, in5, lsr #25
  eor.w in0, in0, in5, lsr #30
  eor.w in0, in0, in5, lsr #31

  eor.w in0, in0, in6, lsl #7
  eor.w in0, in0, in6, lsl #2
  eor.w in0, in0, in6, lsl #1

  eor.w in1, in1, in6, lsr #25
  eor.w in1, in1, in6, lsr #30
  eor.w in1, in1, in6, lsr #31

  eor.w in1, in1, in7, lsl #7
  eor.w in1, in1, in7, lsl #2
  eor.w in1, in1, in7, lsl #1

  str.w in0, [out_p, #4 * width]
  str.w in1, [out_p, #5 * width]

  ldr.w in0, [in_p, #0 * width]  // a[0]
  ldr.w in6, [in_p, #1 * width]

  lsr.w in1, in0, #16
  lsr.w in7, in6, #16

  and.w in0, in0, R10, lsr #16
  and.w in6, in6, R10, lsr #16

  or_shift_and in0, C3, 8
  or_shift_and in1, C3, 8
  or_shift_and in6, C3, 8
  or_shift_and in7, C3, 8

  or_shift_and in0, C2, 4
  or_shift_and in1, C2, 4
  or_shift_and in6, C2, 4
  or_shift_and in7, C2, 4

  or_shift_and in0, C1, 2
  or_shift_and in1, C1, 2
  or_shift_and in6, C1, 2
  or_shift_and in7, C1, 2

  or_shift_and in0, C0, 1
  or_shift_and in1, C0, 1
  or_shift_and in6, C0, 1
  or_shift_and in7, C0, 1

  // c[1] = temp[1] ^ temp[4];
  eor.w in6, in6, in4
  eor.w in7, in7, in5

  // c[1] ^= (temp[4] << 7) | (t >> 57);
  // c[1] ^= (temp[4] << 2) | (t >> 62);
  // c[1] ^= (temp[4] << 1) | (t >> 63);
  eor.w in6, in6, in3, lsr #25
  eor.w in6, in6, in3, lsr #30
  eor.w in6, in6, in3, lsr #31

  eor.w in6, in6, in4, lsl #7
  eor.w in6, in6, in4, lsl #2
  eor.w in6, in6, in4, lsl #1

  eor.w in7, in7, in4, lsr #25
  eor.w in7, in7, in4, lsr #30
  eor.w in7, in7, in4, lsr #31

  eor.w in7, in7, in5, lsl #7
  eor.w in7, in7, in5, lsl #2
  eor.w in7, in7, in5, lsl #1

  str.w in6, [out_p, #2 * width]
  str.w in7, [out_p, #3 * width]

  // c[0] = temp[0] ^ t;
  eor.w in0, in0, in2
  eor.w in1, in1, in3

  // c[0] ^= (t << 7);
  // c[0] ^= (t << 2);
  // c[0] ^= (t << 1);
  eor.w in0, in0, in2, lsl #7
  eor.w in0, in0, in2, lsl #2
  eor.w in0, in0, in2, lsl #1

  eor.w in1, in1, in2, lsr #25
  eor.w in1, in1, in2, lsr #30
  eor.w in1, in1, in2, lsr #31

  eor.w in1, in1, in3, lsl #7
  eor.w in1, in1, in3, lsl #2
  eor.w in1, in1, in3, lsl #1

  str.w in0, [out_p, #0 * width]
  str.w in1, [out_p, #1 * width]

  pop.w {R4-R10, pc}

  // unlink register name
  .unreq in_p
  .unreq out_p

.macro lut_access0_0 sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, offset
  and \sp1, \mask, \b0_1, lsr #\offset
  and \sp0, \mask, \b0_0, lsr #\offset
  add \sp1, \sp1, sp
  add \sp0, \sp0, sp

  ldr \out1_0, [\sp1, #0]
  ldr \in0_2, [\sp1, #4]

  ldr \in0_0, [\sp0, #0]
  ldr \in0_1, [\sp0, #4]
  eor \in0_1, \in0_1, \out1_0
.endm

.macro lut_access0_1_0 sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, offset
  and \sp1, \mask, \b0_1, lsr #\offset
  and \sp0, \mask, \b0_0, lsr #\offset
  add \sp1, \sp1, sp
  add \sp0, \sp0, sp

  lsr \in0_3, \in0_2, #28
  ldr \out1_0, [\sp1, #0]
  ldr \out1_1, [\sp1, #4]

  lsl \in0_2, \in0_2, #4
  ldr \out0_0, [\sp0, #0]
  ldr \out0_1, [\sp0, #4]

  orr \in0_2, \in0_2, \in0_1, lsr #28
  lsl \in0_1, \in0_1, #4
  orr \in0_1, \in0_1, \in0_0, lsr #28
  lsl \in0_0, \in0_0, #4

  eor \in0_1, \in0_1, \out1_0
  eor \in0_2, \in0_2, \out1_1
  eor \in0_0, \in0_0, \out0_0
  eor \in0_1, \in0_1, \out0_1
.endm

.macro lut_access0_1 sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, offset
  and \sp1, \mask, \b0_1, lsr #\offset
  and \sp0, \mask, \b0_0, lsr #\offset
  lsl \in0_3, \in0_3, #4
  add \sp1, \sp1, sp
  add \sp0, \sp0, sp

  orr \in0_3, \in0_3, \in0_2, lsr #28
  ldr \out1_0, [\sp1, #0]
  ldr \out1_1, [\sp1, #4]

  lsl \in0_2, \in0_2, #4
  ldr \out0_0, [\sp0, #0]
  ldr \out0_1, [\sp0, #4]

  orr \in0_2, \in0_2, \in0_1, lsr #28
  lsl \in0_1, \in0_1, #4
  orr \in0_1, \in0_1, \in0_0, lsr #28
  lsl \in0_0, \in0_0, #4

  eor \in0_1, \in0_1, \out1_0
  eor \in0_2, \in0_2, \out1_1
  eor \in0_0, \in0_0, \out0_0
  eor \in0_1, \in0_1, \out0_1
.endm

.macro lut_access1 sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, offset
  lsl \in0_3, \in0_3, #4
  and \sp1, \mask, \b0_1, lsl #\offset
  orr \in0_3, \in0_3, \in0_2, lsr #28
  and \sp0, \mask, \b0_0, lsl #\offset

  lsl \in0_2, \in0_2, #4
  add \sp1, \sp1, sp
  orr \in0_2, \in0_2, \in0_1, lsr #28
  add \sp0, \sp0, sp

  lsl   \in0_1, \in0_1, #4
  ldmia \sp1, {\out1_0-\out1_1}
  orr   \in0_1, \in0_1, \in0_0, lsr #28
  ldmia \sp0, {\out0_0-\out0_1}
  lsl   \in0_0, \in0_0, #4

  eor \in0_1, \in0_1, \out1_0
  eor \in0_2, \in0_2, \out1_1
  eor \in0_0, \in0_0, \out0_0
  eor \in0_1, \in0_1, \out0_1
.endm

.macro last_mask0 mask, one, r0_ret, zero, mask0_0, mask0_1, mask0_2, b0_0, b0_1, in0_1, in0_2, in0_3, offset
  and \mask, \one, \r0_ret, lsr #\offset
  sub \mask, \zero, \mask
  and \mask0_1, \b0_0, \mask
  and \mask0_2, \b0_1, \mask

  lsl \mask0_0, \mask0_1, #\offset
  lsr \mask0_1, \mask0_1, #32 - \offset
  orr \mask0_1, \mask0_1, \mask0_2, lsl #\offset
  lsr \mask0_2, \mask0_2, #32 - \offset

  eor \in0_1, \in0_1, \mask0_0
  eor \in0_2, \in0_2, \mask0_1
  eor \in0_3, \in0_3, \mask0_2
.endm

.macro last_mask1 mask, one, r0_ret, zero, mask0_0, mask0_1, mask0_2, b0_0, b0_1, in0_1, in0_2, in0_3, offset
  sub \mask, \zero, \r0_ret, lsr #\offset
  and \mask0_1, \b0_0, \mask
  and \mask0_2, \b0_1, \mask

  lsl \mask0_0, \mask0_1, #\offset
  lsr \mask0_1, \mask0_1, #32 - \offset
  orr \mask0_1, \mask0_1, \mask0_2, lsl #\offset
  lsr \mask0_2, \mask0_2, #32 - \offset

  eor \in0_1, \in0_1, \mask0_0
  eor \in0_2, \in0_2, \mask0_1
  eor \in0_3, \in0_3, \mask0_2
.endm

.global AIMER_NAMESPACE(poly64_mul)
.type   AIMER_NAMESPACE(poly64_mul), %function
AIMER_NAMESPACE(poly64_mul):
  t0_0    .req R0
  t0_1    .req R1
  t1_0    .req R2
  t1_1    .req R3
  t2_0    .req R4
  t2_1    .req R5
  t3_0    .req R6
  t3_1    .req R7
  t4_0    .req R8
  t4_1    .req R9
  t5_0    .req R10
  t5_1    .req R11

  r1_copy .req R12
  t_base  .req R14 

  sp0     .req R12
  sp1     .req R14

  b0_0    .req R0
  b0_1    .req R1

  in0_0   .req R2
  in0_1   .req R3
  in0_2   .req R4
  in0_3   .req R5

  out0_0  .req R6
  out0_1  .req R7
  out1_0  .req R8
  out1_1  .req R9

  mask    .req R10

  zero    .req R6
  one     .req R7

  r0_ret  .req R8

  mask0_0 .req R9
  mask0_1 .req R11
  mask0_2 .req R12

  push  {R4-R11, lr}
  push  {R2-R3}

  ldr   t1_0, [R0, #0]
  ldr   t1_1, [R0, #4]
  push  {t1_1}

  sub   sp, #128  // allocating space in the stack
                  // 8 bytes * 16 = 128 bytes
  mov   t_base, sp
  mov   r1_copy, R1

  mov   t0_0, #0
  mov   t0_1, #0

  and   t1_1, #0x1FFFFFFF

  lsl   t2_1, t1_1, #1
  orr   t2_1, t2_1, t1_0, lsr #31
  lsl   t2_0, t1_0, #1

  eor   t3_0, t1_0, t2_0
  eor   t3_1, t1_1, t2_1

  lsl   t4_1, t2_1, #1
  orr   t4_1, t4_1, t2_0, lsr #31
  lsl   t4_0, t2_0, #1

  eor   t5_0, t1_0, t4_0
  eor   t5_1, t1_1, t4_1

  stmia t_base!, {t0_0-t5_1}  // 4 bytes X 12 elements  = 48 bytes

  eor   t0_0, t2_0, t4_0
  eor   t0_1, t2_1, t4_1

  lsl   t2_1, t4_1, #1
  orr   t2_1, t2_1, t4_0, lsr #31
  lsl   t2_0, t4_0, #1

  eor   t5_0, t2_0, t3_0
  eor   t5_1, t2_1, t3_1

  eor   t3_0, t2_0, t1_0
  eor   t3_1, t2_1, t1_1

  eor   t4_0, t4_0, t0_0
  eor   t4_1, t4_1, t0_1

  eor   t4_0, t4_0, t2_0
  eor   t4_1, t4_1, t2_1

  eor   t1_0, t1_0, t0_0
  eor   t1_1, t1_1, t0_1

  stmia t_base!, {t0_0-t5_1}  // 4 bytes X 12 elements  = 48 bytes

  eor   t1_0, t5_0, t0_0
  eor   t1_1, t5_1, t0_1

  eor   t2_0, t2_0, t0_0
  eor   t2_1, t2_1, t0_1

  eor   t3_0, t3_0, t0_0
  eor   t3_1, t3_1, t0_1

  eor   t0_0, t4_0, t0_0
  eor   t0_1, t4_1, t0_1

  stmia t_base, {t0_0-t3_1}  // 4 bytes X 8 elements  = 32 bytes

  ldmia r1_copy, {b0_0-b0_1}
  mov   mask, #0x00000078

  lut_access0_0   sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, 25
  lut_access0_1_0 sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, 21
  lut_access0_1   sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, 17
  lut_access0_1   sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, 13
  lut_access0_1   sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, 9
  lut_access0_1   sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, 5
  lut_access0_1   sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, 1
  lut_access1     sp0, sp1, mask, b0_0, b0_1, out0_0, out0_1, out1_0, out1_1, in0_0, in0_1, in0_2, in0_3, 3

  mov   zero, #0
  mov   one,  #1
  ldr   r0_ret, [sp, #128]

  last_mask0 mask, one, r0_ret, zero, mask0_0, mask0_1, mask0_2, b0_0, b0_1, in0_1, in0_2, in0_3, 29
  last_mask0 mask, one, r0_ret, zero, mask0_0, mask0_1, mask0_2, b0_0, b0_1, in0_1, in0_2, in0_3, 30
  last_mask1 mask, one, r0_ret, zero, mask0_0, mask0_1, mask0_2, b0_0, b0_1, in0_1, in0_2, in0_3, 31

  ldr   R0, [sp, #132]
  ldr   R1, [sp, #136]
  add   sp, #140  // restoring stack

  str   in0_0, [R1, #0]
  str   in0_1, [R1, #4]

  str   in0_2, [R0, #0]
  str   in0_3, [R0, #4]

  pop   {R4-R11, pc}

  // unlink register name
  .unreq t0_0
  .unreq t0_1
  .unreq t1_0
  .unreq t1_1
  .unreq t2_0
  .unreq t2_1
  .unreq t3_0
  .unreq t3_1
  .unreq t4_0
  .unreq t4_1
  .unreq t5_0
  .unreq t5_1

  .unreq r1_copy
  .unreq t_base

  .unreq sp0
  .unreq sp1

  .unreq b0_0
  .unreq b0_1

  .unreq in0_0
  .unreq in0_1
  .unreq in0_2
  .unreq in0_3

  .unreq out0_0
  .unreq out0_1
  .unreq out1_0
  .unreq out1_1

  .unreq mask

  .unreq zero
  .unreq one

  .unreq r0_ret

  .unreq mask0_0
  .unreq mask0_1
  .unreq mask0_2
