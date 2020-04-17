.p2align 2,,3
.syntax unified
.text

.global gf_polymul_192x192_1s
.type gf_polymul_192x192_1s, %function
@ 192x192 Toom-4
@ void gf_polymul_192x192_1s(uint32_t *h, uint32_t *c, uint32_t *f)
gf_polymul_192x192_1s:
  push.w {r4-r12, lr}
  vpush.w { s16 }
  sub.w sp, sp, #3648
  vmov.w s0, r0
  mov.w r0, sp
  vmov.w s1, r2
  movw.w r2, #4591
  movw.w r3, #32768
  movw.w r4, #18015
  movt.w r4, #14
  add.w lr, r0, #96
gf_polymul_192x192_1s_eval_input_c_body:
  ldr.w r8, [r1, #288]
  ldr.w r7, [r1, #96]
  ldr.w r6, [r1, #192]
  ldr.w r5, [r1], #4
  lsl.w r9, r7, #1
  lsl.w r10, r8, #3
  bfc.w r9, #16, #1
  bfc.w r10, #16, #3
  sadd16.w r9, r9, r10
  smlawb.w r10, r4, r9, r3
  smlawt.w r11, r4, r9, r3
  smulbt.w r10, r2, r10
  smulbt.w r11, r2, r11
  pkhbt.w r10, r10, r11, lsl #16
  ssub16.w r9, r9, r10
  lsl.w r10, r6, #2
  bfc.w r10, #16, #2
  sadd16.w r10, r10, r5
  sadd16.w r11, r10, r9
  ssub16.w r10, r10, r9
  smlawb.w r9, r4, r11, r3
  smlawt.w r12, r4, r11, r3
  smulbt.w r9, r2, r9
  smulbt.w r12, r2, r12
  pkhbt.w r9, r9, r12, lsl #16
  ssub16.w r11, r11, r9
  smlawb.w r9, r4, r10, r3
  smlawt.w r12, r4, r10, r3
  smulbt.w r9, r2, r9
  smulbt.w r12, r2, r12
  pkhbt.w r9, r9, r12, lsl #16
  ssub16.w r10, r10, r9
  lsl.w r9, r5, #3
  lsl.w r12, r6, #1
  bfc.w r9, #16, #3
  bfc.w r12, #16, #1
  sadd16.w r9, r9, r12
  sadd16.w r5, r5, r6
  smlawb.w r6, r4, r9, r3
  smlawt.w r12, r4, r9, r3
  smulbt.w r6, r2, r6
  smulbt.w r12, r2, r12
  pkhbt.w r6, r6, r12, lsl #16
  ssub16.w r9, r9, r6
  lsl.w r12, r7, #2
  bfc.w r12, #16, #2
  sadd16.w r12, r12, r8
  sadd16.w r7, r7, r8
  sadd16.w r9, r9, r12
  smlawb.w r6, r4, r9, r3
  smlawt.w r8, r4, r9, r3
  smulbt.w r6, r2, r6
  smulbt.w r8, r2, r8
  pkhbt.w r6, r6, r8, lsl #16
  ssub16.w r9, r9, r6
  ssub16.w r8, r5, r7
  sadd16.w r7, r5, r7
  smlawb.w r5, r4, r8, r3
  smlawt.w r6, r4, r8, r3
  smulbt.w r5, r2, r5
  smulbt.w r6, r2, r6
  pkhbt.w r5, r5, r6, lsl #16
  ssub16.w r8, r8, r5
  smlawb.w r5, r4, r7, r3
  smlawt.w r6, r4, r7, r3
  smulbt.w r5, r2, r5
  smulbt.w r6, r2, r6
  pkhbt.w r5, r5, r6, lsl #16
  ssub16.w r7, r7, r5
  str.w r10, [r0, #384]
  str.w r11, [r0, #288]
  str.w r8, [r0, #192]
  str.w r7, [r0, #96]
  str.w r9, [r0], #4
  cmp.w r0, lr
  bne.w gf_polymul_192x192_1s_eval_input_c_body
  vmov.w r2, s1
  add.w r0, r0, #384
  vmov.w s1, r1
  mvn.w r1, #0x00010000
  mvn.w r3, #0x00030000
  mvn.w r4, #0x00070000
  add.w lr, r0, #96
gf_polymul_192x192_1s_eval_input_f_body:
  ldr.w r8, [r2, #288]
  ldr.w r7, [r2, #96]
  ldr.w r6, [r2, #192]
  ldr.w r5, [r2], #4
  and.w r9, r1, r7, lsl #1
  and.w r10, r4, r8, lsl #3
  sadd16.w r9, r9, r10
  and.w r10, r3, r6, lsl #2
  sadd16.w r10, r10, r5
  sadd16.w r11, r10, r9
  ssub16.w r10, r10, r9
  and.w r9, r4, r5, lsl #3
  and.w r12, r1, r6, lsl #1
  sadd16.w r9, r9, r12
  sadd16.w r5, r5, r6
  and.w r12, r3, r7, lsl #2
  sadd16.w r12, r12, r8
  sadd16.w r7, r7, r8
  sadd16.w r9, r9, r12
  ssub16.w r8, r5, r7
  sadd16.w r7, r5, r7
  str.w r10, [r0, #384]
  str.w r11, [r0, #288]
  str.w r8, [r0, #192]
  str.w r7, [r0, #96]
  str.w r9, [r0], #4
  cmp.w r0, lr
  bne.w gf_polymul_192x192_1s_eval_input_f_body
  vmov.w r1, s1
  add.w r0, r0, #384
  vmov.w r4, s0
  mov.w r5, r0
  sub.w r6, r1, #96
  sub.w r7, r2, #96
  mov.w r1, r6
  mov.w r2, r7
  bl.w gf_polymul_48x48
  add.w r0, r5, #768
  sub.w r1, r5, #960
  sub.w r2, r5, #480
  bl.w gf_polymul_48x48
  add.w r0, r5, #192
  sub.w r1, r5, #864
  sub.w r2, r5, #384
  bl.w gf_polymul_48x48
  add.w r0, r5, #960
  sub.w r1, r5, #768
  sub.w r2, r5, #288
  bl.w gf_polymul_48x48
  add.w r0, r5, #384
  sub.w r1, r5, #672
  sub.w r2, r5, #192
  bl.w gf_polymul_48x48
  add.w r0, r5, #1152
  sub.w r1, r5, #576
  sub.w r2, r5, #96
  bl.w gf_polymul_48x48
  add.w r0, r5, #576
  add.w r1, r6, #288
  add.w r2, r7, #288
  bl.w gf_polymul_48x48
  vmov.w s0, r4
  mov.w r0, r5
  add.w lr, r0, #192
  movw.w r12, #18015
  movt.w r12, #14
  movw.w r11, #4591
	 movw.w r10, :lower16:Toom4Table_4591
	 movt.w r10, :upper16:Toom4Table_4591
	 vldm	r10, {s1-s16} @ read table
  add.w r1, r0, #1152
gf_polymul_192x192_1s_interpol_output_body:
  ldr.w r10, [r0, #576]
  ldr.w r9, [r1]
  ldr.w r8, [r0, #384]
  ldr.w r7, [r0, #960]
  ldr.w r6, [r0, #192]
  ldr.w r3, [r0, #768]
  ldr.w r4, [r0], #4
  pkhbt.w r1, r4, r6, lsl #16
  pkhtb.w r2, r6, r4, asr #16
  pkhbt.w r4, r7, r8, lsl #16
  pkhtb.w r5, r8, r7, asr #16
  pkhbt.w r6, r9, r10, lsl #16
  pkhtb.w r7, r10, r9, asr #16
  vmov.w r10, s1
  smuad.w r8, r10, r1
  smuad.w r9, r10, r2
  vmov.w r10, s16 @ bot = A[1][1]
  smlabb.w r8, r10, r3, r8
  smlabt.w r9, r10, r3, r9
  vmov.w r10, s2
  smladx.w r8, r10, r4, r8
  smladx.w r9, r10, r5, r9
  vmov.w r10, s3
  smladx.w r8, r10, r6, r8
  smladx.w r9, r10, r7, r9
  smmulr.w r10, r12, r8
  mls.w r8, r11, r10, r8
  smmulr.w r10, r12, r9
  mls.w r9, r11, r10, r9
  pkhbt.w r8, r8, r9, lsl #16
  str.w r8, [r0, #764]
  vmov.w r10, s4
  smuadx.w r8, r10, r1
  smuadx.w r9, r10, r2
  vmov.w r10, s5
  smlad.w r8, r10, r4, r8
  smlad.w r9, r10, r5, r9
  vmov.w r10, s6
  smlad.w r8, r10, r6, r8
  smlad.w r9, r10, r7, r9
  smmulr.w r10, r12, r8
  mls.w r8, r11, r10, r8
  smmulr.w r10, r12, r9
  mls.w r9, r11, r10, r9
  pkhbt.w r8, r8, r9, lsl #16
  str.w r8, [r0, #188]
  vmov.w r10, s7
  smuad.w r8, r10, r1
  smuad.w r9, r10, r2
  vmov.w r10, s16 @ top = A[3][1]
  smlatb.w r8, r10, r3, r8
  smlatt.w r9, r10, r3, r9
  vmov.w r10, s8
  smlad.w r8, r10, r4, r8
  smlad.w r9, r10, r5, r9
  vmov.w r10, s9 @ top = A[3][6]
  smlatt.w r8, r10, r6, r8
  smlatt.w r9, r10, r7, r9
  smmulr.w r10, r12, r8
  mls.w r8, r11, r10, r8
  smmulr.w r10, r12, r9
  mls.w r9, r11, r10, r9
  pkhbt.w r8, r8, r9, lsl #16
  str.w r8, [r0, #956]
  vmov.w r10, s10
  smuadx.w r8, r10, r1
  smuadx.w r9, r10, r2
  vmov.w r10, s11
  smlad.w r8, r10, r4, r8
  smlad.w r9, r10, r5, r9
  vmov.w r10, s12
  smlad.w r8, r10, r6, r8
  smlad.w r9, r10, r7, r9
  smmulr.w r10, r12, r8
  mls.w r8, r11, r10, r8
  smmulr.w r10, r12, r9
  mls.w r9, r11, r10, r9
  pkhbt.w r8, r8, r9, lsl #16
  str.w r8, [r0, #380]
  vmov.w r10, s13
  smuad.w r8, r10, r1
  smuad.w r9, r10, r2
  vmov.w r10, s9 @ bot = A[5][1]
  smlabb.w r8, r10, r3, r8
  smlabt.w r9, r10, r3, r9
  vmov.w r10, s14
  smladx.w r8, r10, r4, r8
  smladx.w r9, r10, r5, r9
  vmov.w r10, s15
  smladx.w r8, r10, r6, r8
  smladx.w r9, r10, r7, r9
  smmulr.w r10, r12, r8
  mls.w r8, r11, r10, r8
  smmulr.w r10, r12, r9
  mls.w r9, r11, r10, r9
  pkhbt.w r8, r8, r9, lsl #16
  add.w r1, r0, #1152
  str.w r8, [r1, #-4]
  cmp.w r0, lr
  bne.w gf_polymul_192x192_1s_interpol_output_body
  sub.w r1, r0, #192
  vmov.w r0, s0
  add.w lr, r0, #88
gf_polymul_192x192_1s_copy_output_A:
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
  cmp.w r0, lr
  bne.w gf_polymul_192x192_1s_copy_output_A
  ldr.w r3, [r1, #4]
  ldr.w r2, [r1], #8
  str.w r3, [r0, #4]
  str.w r2, [r0], #8
  add.w lr, r0, #560
gf_polymul_192x192_1s_copy_output_B:
  ldr.w r8, [r1, #676]
  ldr.w r3, [r1, #4]
  ldr.w r9, [r1, #680]
  ldr.w r4, [r1, #8]
  ldr.w r10, [r1, #684]
  ldr.w r5, [r1, #12]
  ldr.w r11, [r1, #688]
  ldr.w r6, [r1, #16]
  ldr.w r7, [r1, #672]
  ldr.w r2, [r1], #20
  sadd16.w r2, r2, r7
  sadd16.w r3, r3, r8
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r5, [r0, #12]
  str.w r6, [r0, #16]
  str.w r2, [r0], #20
  cmp.w r0, lr
  bne.w gf_polymul_192x192_1s_copy_output_B
  ldr.w r7, [r1, #676]
  ldr.w r3, [r1, #4]
  ldr.w r8, [r1, #680]
  ldr.w r4, [r1, #8]
  ldr.w r9, [r1, #684]
  ldr.w r5, [r1, #12]
  ldr.w r6, [r1, #672]
  ldr.w r2, [r1], #16
  sadd16.w r2, r2, r6
  sadd16.w r3, r3, r7
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r5, [r0, #12]
  str.w r2, [r0], #16
  add.w lr, r0, #88
gf_polymul_192x192_1s_copy_output_C:
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
  cmp.w r0, lr
  bne.w gf_polymul_192x192_1s_copy_output_C
  ldr.w r3, [r1, #4]
  ldr.w r2, [r1], #8
  str.w r3, [r0, #4]
  str.w r2, [r0], #8
  add.w sp, sp, #3648
  vpop.w { s16 }
  pop.w {r4-r12, pc}
Toom4Table_4591:
	.word	4194697214	@ s1
	.word	66848888	@ s2^
	.word	145489918	@ s3^
	.word	4219667963	@ s4^
	.word	87754235	@ s5
	.word	263483	@ s6
	.word	4144690955	@ s7
	.word	16713465	@ s8
	.word	4144758733	@ s9#
	.word	75236093	@ s10^
	.word	4207215357	@ s11
	.word	4294703813	@ s12
	.word	100272375	@ s13
	.word	4261546104	@ s14^
	.word	4149545207	@ s15^
	.word	16777012	@ s16#
@ # two packed coeffs ^ swapped position
Toom4Table_4591_end:
