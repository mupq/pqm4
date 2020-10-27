.p2align 2,,3
.syntax unified
.text

.global Encode_Rq_asm
.type Encode_Rq_asm, %function
@ void Encode_Rq_asm(unsigned char *out,int16 *R)
Encode_Rq_asm:
  push.w {r4-r12, lr}

  add.w lr, r1, #1520
  mov.w r2, r1
  movw.w r3, #4591
  movw.w r4, #2295
  movt.w r4, #2295
Encode_Rq_asm_radix4591:
  ldr.w r6, [r1, #4]
  ldr.w r7, [r1, #8]
  ldr.w r8, [r1, #12]
  ldr.w r5, [r1], #16
  sadd16.w r5, r5, r4
  sadd16.w r6, r6, r4
  sadd16.w r7, r7, r4
  sadd16.w r8, r8, r4
  sxth.w r9, r5
  smlabt.w r5, r3, r5, r9
  sxth.w r9, r6
  smlabt.w r6, r3, r6, r9
  sxth.w r9, r7
  smlabt.w r7, r3, r7, r9
  sxth.w r9, r8
  smlabt.w r8, r3, r8, r9
  pkhtb.w r9, r8, r7, asr #16
  pkhbt.w r8, r7, r8, lsl #16
  pkhtb.w r7, r6, r5, asr #16
  pkhbt.w r6, r5, r6, lsl #16
  str.w r8, [r0, #4]
  str.w r6, [r0], #8
  str.w r9, [r2, #4]
  str.w r7, [r2], #8
  cmp.w r1, lr
  bne.w Encode_Rq_asm_radix4591

  ldrh.w r3, [r1]
  sadd16.w r3, r3, r4
  strh.w r3, [r2]
  sub.w r1, #1520
  sub.w r2, #760

  add.w lr, r1, #736
  mov.w r3, #322
Encode_Rq_asm_radix322:
  ldr.w r5, [r1, #4]
  ldr.w r6, [r1, #8]
  ldr.w r7, [r1, #12]
  ldr.w r8, [r1, #16]
  ldr.w r9, [r1, #20]
  ldr.w r10, [r1, #24]
  ldr.w r11, [r1, #28]
  ldr.w r4, [r1], #32
  sxth.w r12, r4
  smlabt.w r4, r3, r4, r12
  sxth.w r12, r5
  smlabt.w r5, r3, r5, r12
  sxth.w r12, r6
  smlabt.w r6, r3, r6, r12
  sxth.w r12, r7
  smlabt.w r7, r3, r7, r12
  sxth.w r12, r8
  smlabt.w r8, r3, r8, r12
  sxth.w r12, r9
  smlabt.w r9, r3, r9, r12
  sxth.w r12, r10
  smlabt.w r10, r3, r10, r12
  sxth.w r12, r11
  smlabt.w r11, r3, r11, r12
  bfi.w r12, r8, #0, #8
  bfi.w r12, r9, #8, #8
  bfi.w r12, r10, #16, #8
  bfi.w r12, r11, #24, #8
  lsr.w r10, #8
  pkhbt.w r11, r10, r11, lsl #8
  lsr.w r8, #8
  pkhbt.w r10, r8, r9, lsl #8
  bfi.w r9, r4, #0, #8
  bfi.w r9, r5, #8, #8
  bfi.w r9, r6, #16, #8
  bfi.w r9, r7, #24, #8
  lsr.w r6, #8
  pkhbt.w r8, r6, r7, lsl #8
  lsr.w r4, #8
  pkhbt.w r7, r4, r5, lsl #8
  str.w r12, [r0, #4]
  str.w r9, [r0], #8
  str.w r8, [r2, #4]
  str.w r10, [r2, #8]
  str.w r11, [r2, #12]
  str.w r7, [r2], #16
  cmp.w r1, lr
  bne.w Encode_Rq_asm_radix322

  ldr.w r5, [r1, #4]
  ldr.w r6, [r1, #8]
  ldr.w r7, [r1, #12]
  ldr.w r8, [r1, #16]
  ldr.w r9, [r1, #20]
  ldr.w r4, [r1], #24
  sxth.w r12, r4
  smlabt.w r4, r3, r4, r12
  sxth.w r12, r5
  smlabt.w r5, r3, r5, r12
  sxth.w r12, r6
  smlabt.w r6, r3, r6, r12
  sxth.w r12, r7
  smlabt.w r7, r3, r7, r12
  sxth.w r12, r8
  smlabt.w r8, r3, r8, r12
  sxth.w r12, r9
  smlabt.w r9, r3, r9, r12
  bfi.w r12, r8, #0, #8
  bfi.w r12, r9, #8, #8
  lsr.w r8, #8
  pkhbt.w r11, r8, r9, lsl #8
  bfi.w r10, r4, #0, #8
  bfi.w r10, r5, #8, #8
  bfi.w r10, r6, #16, #8
  bfi.w r10, r7, #24, #8
  lsr.w r6, #8
  pkhbt.w r9, r6, r7, lsl #8
  lsr.w r4, #8
  pkhbt.w r8, r4, r5, lsl #8
  strh.w r12, [r0, #4]
  str.w r10, [r0], #6
  str.w r9, [r2, #4]
  str.w r11, [r2, #8]
  str.w r8, [r2], #12

  ldrh.w r3, [r1]
  strh.w r3, [r2]
  sub.w r1, #760
  sub.w r2, #380

  pop.w {r4-r12, pc}


.global Encode_Rounded_asm
.type Encode_Rounded_asm, %function
@ void Encode_Rounded_asm(unsigned char *out,int16 *R)
Encode_Rounded_asm:
  push.w {r4-r12, lr}

  add.w lr, r1, #1520
  mov.w r2, r1
  movw.w r3, #1531
  movw.w r4, #2295
  movt.w r4, #2295
  mov.w r5, #0x55555555
Encode_Rounded_asm_radix1531:
  ldr.w r7, [r1, #4]
  ldr.w r8, [r1, #8]
  ldr.w r9, [r1, #12]
  ldr.w r6, [r1], #16
  sadd16.w r6, r6, r4
  sadd16.w r7, r7, r4
  sadd16.w r8, r8, r4
  sadd16.w r9, r9, r4
  smulwt.w r10, r5, r6
  smulwb.w r6, r5, r6
  lsr.w r6, r6, #16
  smlabt.w r6, r3, r10, r6
  smulwt.w r10, r5, r7
  smulwb.w r7, r5, r7
  lsr.w r7, r7, #16
  smlabt.w r7, r3, r10, r7
  smulwt.w r10, r5, r8
  smulwb.w r8, r5, r8
  lsr.w r8, r8, #16
  smlabt.w r8, r3, r10, r8
  smulwt.w r10, r5, r9
  smulwb.w r9, r5, r9
  lsr.w r9, r9, #16
  smlabt.w r9, r3, r10, r9
  bfi.w r10, r6, #0, #8
  bfi.w r10, r7, #8, #8
  bfi.w r10, r8, #16, #8
  bfi.w r10, r9, #24, #8
  lsr.w r8, #8
  pkhbt.w r9, r8, r9, lsl #8
  lsr.w r6, #8
  pkhbt.w r8, r6, r7, lsl #8
  str.w r10, [r0], #4
  str.w r9, [r2, #4]
  str.w r8, [r2], #8
  cmp.w r1, lr
  bne.w Encode_Rounded_asm_radix1531

  ldrh.w r3, [r1]
  sadd16.w r3, r3, r4
  smulwb.w r3, r5, r3
  lsr.w r3, r3, #16
  strh.w r3, [r2]
  sub.w r1, #1520
  sub.w r2, #760

  add.w lr, r1, #752
  movw.w r3, #9157
Encode_Rounded_asm_radix9157:
  ldr.w r5, [r1, #4]
  ldr.w r6, [r1, #8]
  ldr.w r7, [r1, #12]
  ldr.w r4, [r1], #16
  sxth.w r8, r4
  smlabt.w r4, r3, r4, r8
  sxth.w r8, r5
  smlabt.w r5, r3, r5, r8
  sxth.w r8, r6
  smlabt.w r6, r3, r6, r8
  sxth.w r8, r7
  smlabt.w r7, r3, r7, r8
  pkhtb.w r8, r7, r6, asr #16
  pkhbt.w r7, r6, r7, lsl #16
  pkhtb.w r6, r5, r4, asr #16
  pkhbt.w r5, r4, r5, lsl #16
  str.w r7, [r0, #4]
  str.w r5, [r0], #8
  str.w r8, [r2, #4]
  str.w r6, [r2], #8
  cmp.w r1, lr
  bne.w Encode_Rounded_asm_radix9157

  ldr.w r5, [r1, #4]
  ldr.w r4, [r1], #8
  sxth.w r8, r4
  smlabt.w r4, r3, r4, r8
  sxth.w r8, r5
  smlabt.w r5, r3, r5, r8
  pkhtb.w r6, r5, r4, asr #16
  pkhbt.w r5, r4, r5, lsl #16
  str.w r5, [r0], #4
  str.w r6, [r2], #4

  ldrh.w r3, [r1]
  strh.w r3, [r2]
  sub.w r1, #760
  sub.w r2, #380

  pop.w {r4-r12, pc}
