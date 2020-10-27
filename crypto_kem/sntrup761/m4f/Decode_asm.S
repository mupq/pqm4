.p2align 2,,3
.syntax unified
.text



.global Decode_Rq_asm
.type Decode_Rq_asm, %function
@ void Decode_Rq_asm(int16 *R,const unsigned char *s)
Decode_Rq_asm:
  push.w {r4-r12, lr}

  sub.w lr, r0, #96
  add.w r2, r0, #92
  movw.w r4, #0xFEF0
  movt.w r4, #644
  movw.w r5, #0x9A3C
  movw.w r11, #0xE361
  movw.w r12, #0xFD7C
  movt.w r12, #0xFFFF
  movw.w r3, #0xEE11
  movt.w r3, #0xFFFF

Decode_Rq_asm_radix644:
  ldr.w r6, [r0], #-4
  ldrh.w r7, [r1], #-2
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #8
  add.w r8, r9, r8, asr #16

  smlabt.w r8, r12, r8, r8
  sxth.w r9, r6, ror #16
  rsb.w r9, r8, r9, lsl #8
  uxtab.w r9, r9, r7, ror #8
  asr.w r9, r9, #2

  smulbb.w r9, r11, r9
  sxtah.w r9, r3, r9
  smlabt.w r9, r3, r9, r9
  mov.w r3, r12
  pkhbt.w r8, r8, r9, lsl #16


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9
  sxth.w r10, r6
  rsb.w r10, r9, r10, lsl #8
  uxtab.w r10, r10, r7
  asr.w r10, r10, #2

  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  str.w r8, [r2, #4]
  str.w r9, [r2], #-8
  cmp.w r0, lr
  bne.w Decode_Rq_asm_radix644

  add.w r0, r0, #190
  ldrh.w r2, [r0, #4]
  strh.w r2, [r0, #194]

  sub.w lr, r0, #188
  add.w r2, r0, #186
  movw.w r4, #78
  movt.w r4, #406
  movw.w r5, #24213
  movw.w r11, #25827
  movw.w r12, #0xFE6A
  movt.w r12, #0xFFFF

Decode_Rq_asm_radix406:
  ldr.w r6, [r0], #-4
  ldrh.w r7, [r1], #-2
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtab.w r9, r12, r7, ror #8
  add.w r8, r9, r8, asr #16

  smlabt.w r8, r12, r8, r8
  smlabt.w r8, r12, r8, r8
  sxth.w r9, r6, ror #16
  rsb.w r9, r8, r9, lsl #8
  uxtab.w r9, r9, r7, ror #8
  asr.w r9, r9, #1

  smulbb.w r9, r11, r9
  sxtah.w r9, r12, r9
  smlabt.w r9, r12, r9, r9
  pkhbt.w r8, r8, r9, lsl #16


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtab.w r10, r12, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9
  smlabt.w r9, r12, r9, r9
  sxth.w r10, r6
  rsb.w r10, r9, r10, lsl #8
  uxtab.w r10, r10, r7
  asr.w r10, r10, #1

  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  str.w r8, [r2, #4]
  str.w r9, [r2], #-8
  cmp.w r0, lr
  bne.w Decode_Rq_asm_radix406

  ldrsh.w r6, [r0, #2]
  ldrb.w r7, [r1, #1]
  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtab.w r10, r12, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9
  smlabt.w r9, r12, r9, r9
  rsb.w r10, r9, r6, lsl #8
  uxtab.w r10, r10, r7
  asr.w r10, r10, #1

  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  add.w r0, #378
  sub.w r1, #1
  ldrh.w r3, [r0, #4]
  strh.w r3, [r0, #384]
  str.w r9, [r2, #4]

  sub.w lr, r0, #380
  add.w r2, r0, #376
  movw.w r4, #50
  movt.w r4, #322
  movw.w r5, #13433
  movw.w r11, #0xE361
  movw.w r12, #0xFEBE
  movt.w r12, #0xFFFF

Decode_Rq_asm_radix322:
  ldr.w r6, [r0], #-4
  ldrh.w r7, [r1], #-2
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtab.w r9, r12, r7, ror #8
  add.w r8, r9, r8, asr #16

  smlabt.w r8, r12, r8, r8
  smlabt.w r8, r12, r8, r8
  sxth.w r9, r6, ror #16
  rsb.w r9, r8, r9, lsl #8
  uxtab.w r9, r9, r7, ror #8
  asr.w r9, r9, #1

  smulbb.w r9, r11, r9
  sxtah.w r9, r12, r9
  smlabt.w r9, r12, r9, r9
  pkhbt.w r8, r8, r9, lsl #16


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtab.w r10, r12, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9
  smlabt.w r9, r12, r9, r9
  sxth.w r10, r6
  rsb.w r10, r9, r10, lsl #8
  uxtab.w r10, r10, r7
  asr.w r10, r10, #1

  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  str.w r8, [r2, #4]
  str.w r9, [r2], #-8
  cmp.w r0, lr
  bne.w Decode_Rq_asm_radix322

  add.w r0, #760
  sub.w r1, #2
  ldrsh.w r2, [r0, #4]
  sub.w r2, r2, #2295
  strh.w r2, [r0, #764]

  sub.w lr, r0, #760
  add.w r2, r0, #756
  movw.w r3, #2295
  movt.w r3, #2295
  movw.w r4, #1702
  movt.w r4, #4591
  movw.w r5, #0xF1BA
  movw.w r11, #15631
  movw.w r12, #0xEE11
  movt.w r12, #0xFFFF

Decode_Rq_asm_radix4591:
  ldr.w r6, [r0], #-4
  ldr.w r7, [r1], #-4
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #24
  add.w r8, r9, r8, asr #16

  smulbb.w r9, r5, r8
  pkhbt.w r9, r9, r8, lsl #16
  smusdx.w r8, r4, r9
  uxtb.w r9, r7, ror #16
  add.w r8, r9, r8, asr #16

  smlabt.w r8, r12, r8, r8
  rsb.w r9, r8, r7, lsr #16
  smulbb.w r9, r11, r9
  sxtah.w r9, r12, r9
  smlabt.w r9, r12, r9, r9

  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r8, r8, r3


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7, ror #8
  add.w r9, r10, r9, asr #16

  smulbb.w r10, r5, r9
  pkhbt.w r10, r10, r9, lsl #16
  smusdx.w r9, r4, r10
  uxtb.w r10, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9
  uxth.w r7, r7
  rsb.w r10, r9, r7
  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10

  pkhbt.w r9, r9, r10, lsl #16
  ssub16.w r9, r9, r3
  str.w r8, [r2, #4]
  str.w r9, [r2], #-8

  cmp.w r0, lr
  bne.w Decode_Rq_asm_radix4591

  pop.w {r4-r12, pc}



.global Decode_Rounded_asm
.type Decode_Rounded_asm, %function
@ void Decode_Rounded_asm(int16 *R,const unsigned char *s)
Decode_Rounded_asm:
  push.w {r4-r12, lr}

  sub.w lr, r0, #12
  add.w r2, r0, #8
  movw.w r4, #2348
  movt.w r4, #9097
  movw.w r5, #0xF8CC
  movw.w r11, #17081
  movw.w r12, #0xDC77
  movt.w r12, #0xFFFF
  movw.w r3, #0xF774
  movt.w r3, #0xFFFF

Decode_Rounded_asm_radix9097:
  ldr.w r6, [r0], #-4
  ldr.w r7, [r1], #-4
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #24
  add.w r8, r9, r8, asr #16

  smulbb.w r9, r5, r8
  pkhbt.w r8, r9, r8, lsl #16
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #16
  add.w r8, r9, r8, asr #16

  smlabt.w r8, r12, r8, r8
  uxth.w r9, r7, ror #16
  sub.w r9, r9, r8

  smulbb.w r9, r11, r9
  sxtah.w r9, r3, r9
  smlabt.w r9, r3, r9, r9
  mov.w r3, r12
  pkhbt.w r8, r8, r9, lsl #16


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7, ror #8
  add.w r9, r10, r9, asr #16

  smulbb.w r10, r5, r9
  pkhbt.w r9, r10, r9, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9
  uxth.w r10, r7
  sub.w r10, r10, r9

  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  str.w r8, [r2, #4]
  str.w r9, [r2], #-8
  cmp.w r0, lr
  bne.w Decode_Rounded_asm_radix9097

  add.w r0, r0, #24
  add.w r1, r1, #2
  sub.w lr, r0, #24
  add.w r2, r0, #20
  movw.w r4, #372
  movt.w r4, #1526
  movw.w r5, #0xD50E
  movw.w r11, #0xB833
  movw.w r12, #0xFA0A
  movt.w r12, #0xFFFF
  movw.w r3, #0xFE91
  movt.w r3, #0xFFFF

Decode_Rounded_asm_radix1526:
  ldr.w r6, [r0], #-4
  ldrh.w r7, [r1], #-2
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #8
  add.w r8, r9, r8, asr #16

  smlabt.w r8, r12, r8, r8
  sxth.w r9, r6, ror #16
  rsb.w r9, r8, r9, lsl #8
  uxtab.w r9, r9, r7, ror #8
  asr.w r9, r9, #1

  smulbb.w r9, r11, r9
  sxtah.w r9, r3, r9
  smlabt.w r9, r3, r9, r9
  mov.w r3, r12
  pkhbt.w r8, r8, r9, lsl #16


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9
  sxth.w r10, r6
  rsb.w r10, r9, r10, lsl #8
  uxtab.w r10, r10, r7
  asr.w r10, r10, #1

  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  str.w r8, [r2, #4]
  str.w r9, [r2], #-8
  cmp.w r0, lr
  bne.w Decode_Rounded_asm_radix1526

  add.w r0, r0, #48
  sub.w lr, r0, #48
  add.w r2, r0, #44
  movw.w r4, #0xFEE4
  movt.w r4, #625
  movw.w r5, #0x9724
  movw.w r11, #32401
  movw.w r12, #0xFD8F
  movt.w r12, #0xFFFF
  movw.w r3, #0xFF6A
  movt.w r3, #0xFFFF

Decode_Rounded_asm_radix625:
  ldr.w r6, [r0], #-4
  ldrh.w r7, [r1], #-2
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #8
  add.w r8, r9, r8, asr #16

  smlabt.w r8, r12, r8, r8
  sxth.w r9, r6, ror #16
  rsb.w r9, r8, r9, lsl #8
  uxtab.w r9, r9, r7, ror #8

  smulbb.w r9, r11, r9
  sxtah.w r9, r3, r9
  smlabt.w r9, r3, r9, r9
  mov.w r3, r12
  pkhbt.w r8, r8, r9, lsl #16


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9
  sxth.w r10, r6
  rsb.w r10, r9, r10, lsl #8
  uxtab.w r10, r10, r7

  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  str.w r8, [r2, #4]
  str.w r9, [r2], #-8
  cmp.w r0, lr
  bne.w Decode_Rounded_asm_radix625

  add.w r0, r0, #96
  sub.w r1, r1, #2
  sub.w lr, r0, #96
  add.w r2, r0, #92
  movw.w r4, #2816
  movt.w r4, #6400
  movw.w r5, #0xF5C3
  movw.w r11, #23593
  movw.w r12, #0xE700
  movt.w r12, #0xFFFF
  movw.w r3, #0xFA05
  movt.w r3, #0xFFFF

Decode_Rounded_asm_radix6400:
  ldr.w r6, [r0], #-4
  ldr.w r7, [r1], #-4
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #24
  add.w r8, r9, r8, asr #16

  smulbb.w r9, r5, r8
  pkhbt.w r8, r9, r8, lsl #16
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #16
  add.w r8, r9, r8, asr #16

  smlabt.w r8, r12, r8, r8

  sxth.w r9, r6, ror #16
  rsb.w r9, r8, r9, lsl #16
  uxtah.w r9, r9, r7, ror #16
  asr.w r9, r9, #8

  smulbb.w r9, r11, r9
  sxtah.w r9, r3, r9
  smlabt.w r9, r3, r9, r9
  mov.w r3, r12
  pkhbt.w r8, r8, r9, lsl #16


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7, ror #8
  add.w r9, r10, r9, asr #16

  smulbb.w r10, r5, r9
  pkhbt.w r9, r10, r9, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9

  sxth.w r10, r6
  rsb.w r10, r9, r10, lsl #16
  uxtah.w r10, r10, r7
  asr.w r10, r10, #8

  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  str.w r8, [r2, #4]
  str.w r9, [r2], #-8
  cmp.w r0, lr
  bne.w Decode_Rounded_asm_radix6400

  add.w r0, r0, #190
  add.w r1, r1, #2
  ldrh.w r2, [r0, #4]
  strh.w r2, [r0, #194]

  sub.w lr, r0, #188
  add.w r2, r0, #186
  movw.w r4, #256
  movt.w r4, #1280
  movw.w r5, #0xCCCD
  movw.w r12, #0xFB00
  movt.w r12, #0xFFFF

Decode_Rounded_asm_radix1280:
  ldr.w r6, [r0], #-4
  ldrh.w r7, [r1], #-2
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #8
  add.w r8, r9, r8, asr #16

  smlabt.w r8, r12, r8, r8
  sxth.w r9, r6, ror #16
  rsb.w r9, r8, r9, lsl #8
  uxtab.w r9, r9, r7, ror #8
  asr.w r9, r9, #8

  smulbb.w r9, r5, r9
  sxtah.w r9, r12, r9
  smlabt.w r9, r12, r9, r9
  pkhbt.w r8, r8, r9, lsl #16


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9
  sxth.w r10, r6
  rsb.w r10, r9, r10, lsl #8
  uxtab.w r10, r10, r7
  asr.w r10, r10, #8

  smulbb.w r10, r5, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  str.w r8, [r2, #4]
  str.w r9, [r2], #-8
  cmp.w r0, lr
  bne.w Decode_Rounded_asm_radix1280

  ldrsh.w r6, [r0, #2]
  ldrb.w r7, [r1, #1]
  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  add.w r9, r7, r9, asr #16

  smlabt.w r9, r12, r9, r9
  sub.w r10, r7, r9
  add.w r10, r6, r10, asr #8

  smulbb.w r10, r5, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  add.w r0, #378
  sub.w r1, #3
  ldrh.w r3, [r0, #4]
  strh.w r3, [r0, #384]
  str.w r9, [r2, #4]

  sub.w lr, r0, #380
  add.w r2, r0, #376
  movw.w r4, #1592
  movt.w r4, #9157
  movw.w r5, #0xF8D8
  movw.w r11, #25357
  movw.w r12, #0xDC3B
  movt.w r12, #0xFFFF

Decode_Rounded_asm_radix9157:
  ldr.w r6, [r0], #-4
  ldr.w r7, [r1], #-4
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #24
  add.w r8, r9, r8, asr #16

  smulbb.w r9, r5, r8
  pkhbt.w r9, r9, r8, lsl #16
  smusdx.w r8, r4, r9
  uxtb.w r9, r7, ror #16
  add.w r8, r9, r8, asr #16

  smlabt.w r8, r12, r8, r8
  rsb.w r9, r8, r7, lsr #16
  smulbb.w r9, r11, r9
  sxtah.w r9, r12, r9
  smlabt.w r9, r12, r9, r9
  pkhbt.w r8, r8, r9, lsl #16


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7, ror #8
  add.w r9, r10, r9, asr #16

  smulbb.w r10, r5, r9
  pkhbt.w r10, r10, r9, lsl #16
  smusdx.w r9, r4, r10
  uxtb.w r10, r7
  add.w r9, r10, r9, asr #16

  smlabt.w r9, r12, r9, r9
  uxth.w r7, r7
  rsb.w r10, r9, r7
  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16

  str.w r8, [r2, #4]
  str.w r9, [r2], #-8

  cmp.w r0, lr
  bne.w Decode_Rounded_asm_radix9157

  add.w r0, #760
  add.w r1, #2
  ldrsh.w r6, [r0, #4]
  add.w r6, r6, r6, lsl #1
  sub.w r6, r6, #2295
  strh.w r6, [r0, #764]

  sub.w lr, r0, #760
  add.w r2, r0, #756
  movw.w r3, #2295
  movt.w r3, #2295
  movw.w r4, #518
  movt.w r4, #1531
  movw.w r5, #0xD532
  movw.w r11, #15667
  movw.w r12, #0xFA05
  movt.w r12, #0xFFFF

Decode_Rounded_asm_radix1531:
  ldr.w r6, [r0], #-4
  ldrh.w r7, [r1], #-2
  smulbt.w r8, r5, r6
  pkhbt.w r8, r8, r6
  smusdx.w r8, r4, r8
  uxtb.w r9, r7, ror #8
  add.w r8, r9, r8, asr #16
  smlabt.w r8, r12, r8, r8

  sxth.w r9, r6, ror #16
  rsb.w r9, r8, r9, lsl #8
  uxtab.w r9, r9, r7, ror #8

  smulbb.w r9, r11, r9
  sxtah.w r9, r12, r9
  smlabt.w r9, r12, r9, r9
  pkhbt.w r8, r8, r9, lsl #16
  add.w r8, r8, r8, lsl #1
  ssub16.w r8, r8, r3


  smulbb.w r9, r5, r6
  pkhbt.w r9, r9, r6, lsl #16
  smusdx.w r9, r4, r9
  uxtb.w r10, r7
  add.w r9, r10, r9, asr #16
  smlabt.w r9, r12, r9, r9

  sxth.w r10, r6
  rsb.w r10, r9, r10, lsl #8
  uxtab.w r10, r10, r7

  smulbb.w r10, r11, r10
  sxtah.w r10, r12, r10
  smlabt.w r10, r12, r10, r10
  pkhbt.w r9, r9, r10, lsl #16
  add.w r9, r9, r9, lsl #1
  ssub16.w r9, r9, r3

  str.w r8, [r2, #4]
  str.w r9, [r2], #-8
  cmp.w r0, lr
  bne.w Decode_Rounded_asm_radix1531

  pop.w {r4-r12, pc}
