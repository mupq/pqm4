.p2align 2,,3
.syntax unified
.text

.global Weightw_mask_asm
.type Weightw_mask_asm, %function
@ weight_of(small poly) ?= w
@ int Weightw_mask_asm(small *r)
Weightw_mask_asm:
  push.w {r4-r12, lr}
  mov.w r1, #0
  mov.w r2, #0

  mov.w r12, #0
  add.w lr, r0, #252
weight_accum_A:
  ldr.w r4, [r0, #4]
  ldr.w r5, [r0, #8]
  ldr.w r6, [r0, #12]
  ldr.w r7, [r0, #16]
  ldr.w r8, [r0, #20]
  ldr.w r9, [r0, #24]
  ldr.w r10, [r0, #28]
  ldr.w r11, [r0, #32]
  ldr.w r3, [r0], #36
  usada8.w r12, r3, r2, r12
  usada8.w r12, r4, r2, r12
  usada8.w r12, r5, r2, r12
  usada8.w r12, r6, r2, r12
  usada8.w r12, r7, r2, r12
  usada8.w r12, r8, r2, r12
  usada8.w r12, r9, r2, r12
  usada8.w r12, r10, r2, r12
  usada8.w r12, r11, r2, r12
  cmp.w r0, lr
  bne.w weight_accum_A

  add.w r3, r12, r12, lsr #8
  add.w r3, r3, #1
  lsr.w r3, r3, #8
  add.w r12, r12, r3, lsl #1
  uxtb.w r12, r12
  add.w r1, r1, r12

  mov.w r12, #0
  add.w lr, r0, #252
weight_accum_B:
  ldr.w r4, [r0, #4]
  ldr.w r5, [r0, #8]
  ldr.w r6, [r0, #12]
  ldr.w r7, [r0, #16]
  ldr.w r8, [r0, #20]
  ldr.w r9, [r0, #24]
  ldr.w r10, [r0, #28]
  ldr.w r11, [r0, #32]
  ldr.w r3, [r0], #36
  usada8.w r12, r3, r2, r12
  usada8.w r12, r4, r2, r12
  usada8.w r12, r5, r2, r12
  usada8.w r12, r6, r2, r12
  usada8.w r12, r7, r2, r12
  usada8.w r12, r8, r2, r12
  usada8.w r12, r9, r2, r12
  usada8.w r12, r10, r2, r12
  usada8.w r12, r11, r2, r12
  cmp.w r0, lr
  bne.w weight_accum_B

  add.w r3, r12, r12, lsr #8
  add.w r3, r3, #1
  lsr.w r3, r3, #8
  add.w r12, r12, r3, lsl #1
  uxtb.w r12, r12
  add.w r1, r1, r12

  mov.w r12, #0
  add.w lr, r0, #252
weight_accum_C:
  ldr.w r4, [r0, #4]
  ldr.w r5, [r0, #8]
  ldr.w r6, [r0, #12]
  ldr.w r7, [r0, #16]
  ldr.w r8, [r0, #20]
  ldr.w r9, [r0, #24]
  ldr.w r10, [r0, #28]
  ldr.w r11, [r0, #32]
  ldr.w r3, [r0], #36
  usada8.w r12, r3, r2, r12
  usada8.w r12, r4, r2, r12
  usada8.w r12, r5, r2, r12
  usada8.w r12, r6, r2, r12
  usada8.w r12, r7, r2, r12
  usada8.w r12, r8, r2, r12
  usada8.w r12, r9, r2, r12
  usada8.w r12, r10, r2, r12
  usada8.w r12, r11, r2, r12
  cmp.w r0, lr
  bne.w weight_accum_C

  add.w r3, r12, r12, lsr #8
  add.w r3, r3, #1
  lsr.w r3, r3, #8
  add.w r12, r12, r3, lsl #1
  uxtb.w r12, r12
  add.w r1, r1, r12

  ldr.w r3, [r0]
  ldrb.w r4, [r0, #4]
  and.w r3, r3, #0x01010101
  usada8.w r1, r3, r2, r1
  and.w r4, r4, #0x00000001
  add.w r1, r1, r4

  sub.w r1, r1, #286 @ w=286
  mov.w r3, #0xFFFFFFFF
  usub8.w r1, r2, r1
  sel.w r0, r2, r3
  orr.w r0, r0, r0, lsr #16
  orr.w r0, r0, r0, lsr #8
  sxtb.w r0, r0

  pop.w {r4-r12, pc}
