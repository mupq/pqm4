.p2align 2,,3
.syntax unified
.text

.global gf_polymul_768x768_mod3
.type gf_polymul_768x768_mod3, %function
@ 768x768 mod-3 three-way Karatsuba
@ void gf_polymul_768x768_mod3(uint32_t *h, uint32_t *c, uint32_t *f)
gf_polymul_768x768_mod3:
  push.w {r4-r12, lr}
  vmov.w s0, r0
  sub.w sp, sp, #4608
  mov.w r0, sp
  mov.w r12, #0x03030303
  add.w lr, r0, #256
gf_polymul_768x768_mod3_extend_input_f_unit:
  ldr.w r7, [r2, #512]
  ldr.w r5, [r2, #256]
  ldr.w r3, [r2], #4
  ldr.w r8, [r2, #512]
  ldr.w r6, [r2, #256]
  ldr.w r4, [r2], #4
  add.w r9, r7, r5
  add.w r7, r7, r3
  add.w r5, r5, r3
  usub8.w r3, r9, r12
  sel.w r9, r3, r9
  usub8.w r3, r7, r12
  sel.w r7, r3, r7
  usub8.w r3, r5, r12
  sel.w r5, r3, r5
  add.w r10, r8, r6
  add.w r8, r8, r4
  add.w r6, r6, r4
  usub8.w r4, r10, r12
  sel.w r10, r4, r10
  usub8.w r4, r8, r12
  sel.w r8, r4, r8
  usub8.w r4, r6, r12
  sel.w r6, r4, r6
  str.w r9, [r0, #512]
  str.w r7, [r0, #256]
  str.w r5, [r0], #4
  str.w r10, [r0, #512]
  str.w r8, [r0, #256]
  str.w r6, [r0], #4
  cmp.w r0, lr
  bne.w gf_polymul_768x768_mod3_extend_input_f_unit
  sub.w r2, r2, #256
  add.w r0, r0, #512
  mov.w r12, #0x03030303
  add.w lr, r0, #256
gf_polymul_768x768_mod3_extend_input_c_unit:
  ldr.w r7, [r1, #512]
  ldr.w r5, [r1, #256]
  ldr.w r3, [r1], #4
  ldr.w r8, [r1, #512]
  ldr.w r6, [r1, #256]
  ldr.w r4, [r1], #4
  add.w r9, r7, r5
  add.w r7, r7, r3
  add.w r5, r5, r3
  usub8.w r3, r9, r12
  sel.w r9, r3, r9
  usub8.w r3, r7, r12
  sel.w r7, r3, r7
  usub8.w r3, r5, r12
  sel.w r5, r3, r5
  add.w r10, r8, r6
  add.w r8, r8, r4
  add.w r6, r6, r4
  usub8.w r4, r10, r12
  sel.w r10, r4, r10
  usub8.w r4, r8, r12
  sel.w r8, r4, r8
  usub8.w r4, r6, r12
  sel.w r6, r4, r6
  str.w r9, [r0, #512]
  str.w r7, [r0, #256]
  str.w r5, [r0], #4
  str.w r10, [r0, #512]
  str.w r8, [r0, #256]
  str.w r6, [r0], #4
  cmp.w r0, lr
  bne.w gf_polymul_768x768_mod3_extend_input_c_unit
  sub.w r1, r1, #256
  add.w r0, r0, #512
  vmov.w r4, s0
  mov.w r5, r0
  mov.w r6, r1
  mov.w r7, r2
  bl.w gf_polymul_256x256_mod3
  add.w r0, r5, 512
  add.w r1, r6, 256
  add.w r2, r7, 256
  bl.w gf_polymul_256x256_mod3
  add.w r0, r5, 1024
  add.w r1, r6, 512
  add.w r2, r7, 512
  bl.w gf_polymul_256x256_mod3
  add.w r0, r5, 1536
  sub.w r1, r5, 768
  sub.w r2, r5, 1536
  bl.w gf_polymul_256x256_mod3
  add.w r0, r5, 2048
  sub.w r1, r5, 512
  sub.w r2, r5, 1280
  bl.w gf_polymul_256x256_mod3
  add.w r0, r5, 2560
  sub.w r1, r5, 256
  sub.w r2, r5, 1024
  bl.w gf_polymul_256x256_mod3
  vmov.w s0, r4
  mov.w r0, r5
  mov.w r9, #0x03030303
  add.w lr, r0, #512
gf_polymul_768x768_mod3_compose_output_A:
  ldr.w r11, [r0, #2560]
  ldr.w r7, [r0, #1536]
  ldr.w r5, [r0, #1024]
  ldr.w r3, [r0, #512]
  ldr.w r1, [r0], #4
  ldr.w r12, [r0, #2560]
  ldr.w r8, [r0, #1536]
  ldr.w r6, [r0, #1024]
  ldr.w r4, [r0, #512]
  ldr.w r2, [r0], #4
  usub8.w r5, r9, r5
  usub8.w r10, r9, r3
  usub8.w r1, r9, r1
  add.w r7, r7, r1
  add.w r7, r7, r10
  add.w r11, r11, r5
  add.w r11, r11, r10
  add.w r3, r3, r1
  add.w r3, r3, r5
  usub8.w r6, r9, r6
  usub8.w r10, r9, r4
  usub8.w r2, r9, r2
  add.w r8, r8, r2
  add.w r8, r8, r10
  add.w r12, r12, r6
  add.w r12, r12, r10
  add.w r4, r4, r2
  add.w r4, r4, r6
  ldr.w r1, [r0, #2040]
  ldr.w r2, [r0, #2044]
  add.w r3, r3, r1
  and.w r10, r3, r9
  bic.w r3, r3, r9
  add.w r3, r10, r3, lsr #2
  usub8.w r10, r3, r9
  sel.w r3,r10, r3
  add.w r4, r4, r2
  and.w r10, r4, r9
  bic.w r4, r4, r9
  add.w r4, r10, r4, lsr #2
  usub8.w r10, r4, r9
  sel.w r4,r10, r4
  str.w r11, [r0, #2552]
  str.w r7, [r0, #1528]
  str.w r3, [r0, #504]
  str.w r12, [r0, #2556]
  str.w r8, [r0, #1532]
  str.w r4, [r0, #508]
  cmp.w r0, lr
  bne.w gf_polymul_768x768_mod3_compose_output_A
  add.w lr, r0, #256
  sub.w r0, r0, #256
gf_polymul_768x768_mod3_compose_output_B:
  ldr.w r11, [r0, #2304]
  ldr.w r7, [r0, #1280]
  ldr.w r5, [r0, #512]
  ldr.w r3, [r0], #4
  ldr.w r12, [r0, #2304]
  ldr.w r8, [r0, #1280]
  ldr.w r6, [r0, #512]
  ldr.w r4, [r0], #4
  add.w r3, r3, r7
  add.w r5, r5, r11
  and.w r10, r3, r9
  bic.w r3, r3, r9
  add.w r3, r10, r3, lsr #2
  usub8.w r10, r3, r9
  sel.w r3,r10, r3
  and.w r10, r5, r9
  bic.w r5, r5, r9
  add.w r5, r10, r5, lsr #2
  usub8.w r10, r5, r9
  sel.w r5,r10, r5
  add.w r4, r4, r8
  add.w r6, r6, r12
  and.w r10, r4, r9
  bic.w r4, r4, r9
  add.w r4, r10, r4, lsr #2
  usub8.w r10, r4, r9
  sel.w r4,r10, r4
  and.w r10, r6, r9
  bic.w r6, r6, r9
  add.w r6, r10, r6, lsr #2
  usub8.w r10, r6, r9
  sel.w r6,r10, r6
  str.w r5, [r0, #504]
  str.w r3, [r0, #-8]
  str.w r6, [r0, #508]
  str.w r4, [r0, #-4]
  cmp.w r0, lr
  bne.w gf_polymul_768x768_mod3_compose_output_B
  sub.w r0, r0, #768
  vmov.w lr, s0
  add.w r1, r0, #1496
gf_polymul_768x768_mod3_copy_output_body:
  //ldm.w r0!, {r2-r12}
  //stm.w lr!, {r2-r12}
  ldr.w r3, [r0, #4]
  ldr.w r4, [r0, #8]
  ldr.w r5, [r0, #12]
  ldr.w r6, [r0, #16]
  ldr.w r7, [r0, #20]
  ldr.w r8, [r0, #24]
  ldr.w r9, [r0, #28]
  ldr.w r10, [r0, #32]
  ldr.w r11, [r0, #36]
  ldr.w r12, [r0, #40]
  ldr.w r2, [r0], #44
  str.w r3, [lr, #4]
  str.w r4, [lr, #8]
  str.w r5, [lr, #12]
  str.w r6, [lr, #16]
  str.w r7, [lr, #20]
  str.w r8, [lr, #24]
  str.w r9, [lr, #28]
  str.w r10, [lr, #32]
  str.w r11, [lr, #36]
  str.w r12, [lr, #40]
  str.w r2, [lr], #44
  cmp.w r0, r1
  bne.w gf_polymul_768x768_mod3_copy_output_body
  ldr.w r2, [r0]
  ldr.w r3, [r0, #4]
  ldr.w r4, [r0, #8]
  ldr.w r5, [r0, #12]
  ldr.w r6, [r0, #16]
  ldr.w r7, [r0, #20]
  ldr.w r8, [r0, #24]
  ldr.w r9, [r0, #28]
  ldr.w r10, [r0, #32]
  ldr.w r11, [r0, #36]
  str.w r2, [lr]
  str.w r3, [lr, #4]
  str.w r4, [lr, #8]
  str.w r5, [lr, #12]
  str.w r6, [lr, #16]
  str.w r7, [lr, #20]
  str.w r8, [lr, #24]
  str.w r9, [lr, #28]
  str.w r10, [lr, #32]
  str.w r11, [lr, #36]
  add.w sp, sp, #4608
  pop.w {r4-r12, pc}
