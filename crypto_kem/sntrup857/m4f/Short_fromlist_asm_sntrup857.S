.p2align 2,,3
.syntax unified
.text

.global Short_fromlist_asm
.type Short_fromlist_asm, %function
@ void Short_fromlist_asm(small *, const uint32 *)
Short_fromlist_asm:
  push.w {r4-r12, lr}
  sub.w sp, sp, #3428
  vmov.w s0, r0
  mov.w r0, sp
  add.w lr, r1, #1276
Short_fromlist_asm_nonzero:
  ldr.w r3, [r1, #4]
  ldr.w r4, [r1, #8]
  ldr.w r5, [r1, #12]
  ldr.w r6, [r1, #16]
  ldr.w r7, [r1, #20]
  ldr.w r8, [r1, #24]
  ldr.w r9, [r1, #28]
  ldr.w r10, [r1, #32]
  ldr.w r11, [r1, #36]
  ldr.w r12, [r1, #40]
  ldr.w r2, [r1], #44

  bic.w r2, r2, #1
  bic.w r3, r3, #1
  bic.w r4, r4, #1
  bic.w r5, r5, #1
  bic.w r6, r6, #1
  bic.w r7, r7, #1
  bic.w r8, r8, #1
  bic.w r9, r9, #1
  bic.w r10, r10, #1
  bic.w r11, r11, #1
  bic.w r12, r12, #1

  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r5, [r0, #12]
  str.w r6, [r0, #16]
  str.w r7, [r0, #20]
  str.w r8, [r0, #24]
  str.w r9, [r0, #28]
  str.w r10, [r0, #32]
  str.w r11, [r0, #36]
  str.w r12, [r0, #40]
  str.w r2, [r0], #44

  cmp.w r1, lr
  bne.w Short_fromlist_asm_nonzero
  ldr.w r3, [r1, #4]
  ldr.w r4, [r1, #8]
  ldr.w r2, [r1], #12
  bic.w r2, r2, #1
  bic.w r3, r3, #1
  bic.w r4, r4, #1
  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r2, [r0], #12

  add.w lr, r1, #2120
  mov.w r12, #1
Short_fromlist_asm_zero:
  ldr.w r3, [r1, #4]
  ldr.w r4, [r1, #8]
  ldr.w r5, [r1, #12]
  ldr.w r6, [r1, #16]
  ldr.w r7, [r1, #20]
  ldr.w r8, [r1, #24]
  ldr.w r9, [r1, #28]
  ldr.w r10, [r1, #32]
  ldr.w r11, [r1, #36]
  ldr.w r2, [r1], #40

  bfi.w r2, r12, #0, #2
  bfi.w r3, r12, #0, #2
  bfi.w r4, r12, #0, #2
  bfi.w r5, r12, #0, #2
  bfi.w r6, r12, #0, #2
  bfi.w r7, r12, #0, #2
  bfi.w r8, r12, #0, #2
  bfi.w r9, r12, #0, #2
  bfi.w r10, r12, #0, #2
  bfi.w r11, r12, #0, #2

  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r5, [r0, #12]
  str.w r6, [r0, #16]
  str.w r7, [r0, #20]
  str.w r8, [r0, #24]
  str.w r9, [r0, #28]
  str.w r10, [r0, #32]
  str.w r11, [r0, #36]
  str.w r2, [r0], #40

  cmp.w r1, lr
  bne.w Short_fromlist_asm_zero

  ldr.w r3, [r1, #4]
  ldr.w r4, [r1, #8]
  ldr.w r5, [r1, #12]
  ldr.w r6, [r1, #16]
  ldr.w r2, [r1], #20
  bfi.w r2, r12, #0, #2
  bfi.w r3, r12, #0, #2
  bfi.w r4, r12, #0, #2
  bfi.w r5, r12, #0, #2
  bfi.w r6, r12, #0, #2
  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r5, [r0, #12]
  str.w r6, [r0, #16]
  str.w r2, [r0], #20

  mov.w r0, sp
  mov.w r2, #857
  mov.w r3, #0
  vmov.w r4, s0
  bl.w uint32_sort
  mov.w r0, sp
  mov.w r1, #0x01010101
  add.w lr, r0, #3424
Short_fromlist_asm_back:
  mov.w r2, #0
  mov.w r3, #0

  ldr.w r6, [r0, #4]
  ldr.w r7, [r0, #8]
  ldr.w r8, [r0, #12]
  ldr.w r9, [r0, #16]
  ldr.w r10, [r0, #20]
  ldr.w r11, [r0, #24]
  ldr.w r12, [r0, #28]
  ldr.w r5, [r0], #32

  bfi.w r2, r5, #0, #2
  bfi.w r2, r6, #8, #2
  bfi.w r2, r7, #16, #2
  bfi.w r2, r8, #24, #2
  bfi.w r3, r9, #0, #2
  bfi.w r3, r10, #8, #2
  bfi.w r3, r11, #16, #2
  bfi.w r3, r12, #24, #2
  ssub8.w r2, r2, r1
  ssub8.w r3, r3, r1

  str.w r3, [r4, #4]
  str.w r2, [r4], #8
  cmp.w r0, lr
  bne.w Short_fromlist_asm_back
  ldr.w r2, [r0]
  and.w r2, #3
  sub.w r2, #1
  strb.w r2, [r4]

  add.w sp, sp, #3428
  pop.w {r4-r12, pc}
