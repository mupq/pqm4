.p2align 2,,3
.syntax unified
.text

.global gf_polymul_320x320
.type gf_polymul_320x320, %function
@ 320x320 Toom-4
@ void gf_polymul_320x320(uint32_t *h, uint32_t *c, uint32_t *f)
gf_polymul_320x320:
  push.w {r4-r12, lr}
  vpush.w { s16 }
  sub.w sp, sp, #6080
  vmov.w s0, r0
  mov.w r0, sp
  vmov.w s1, r2
  movw.w r2, #7879
  movw.w r3, #32768
  movw.w r4, #20828
  movt.w r4, #8
  add.w lr, r0, #160
gf_polymul_320x320_eval_input_c_body:
  ldr.w r8, [r1, #480]
  ldr.w r7, [r1, #160]
  ldr.w r6, [r1, #320]
  ldr.w r5, [r1], #4
  lsl.w r9, r7, #1
  lsl.w r10, r8, #3
  bfc.w r9, #16, #1
  bfc.w r10, #16, #3
  smlawb.w r12, r4, r10, r3
  smlawt.w r11, r4, r10, r3
  smulbt.w r12, r2, r12
  smulbt.w r11, r2, r11
  pkhbt.w r12, r12, r11, lsl #16
  ssub16.w r10, r10, r12
  sadd16.w r9, r9, r10
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
  vmov s3, s4, r5, r6
  smlawb.w r5, r4, r9, r3
  smlawt.w r6, r4, r9, r3
  smulbt.w r5, r2, r5
  smulbt.w r6, r2, r6
  pkhbt.w r5, r5, r6, lsl #16
  ssub16.w r9, r9, r5
  vmov r5, r6, s3, s4
  sadd16.w r9, r9, r12
  sadd16.w r5, r5, r6
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
  str.w r10, [r0, #640]
  str.w r11, [r0, #480]
  str.w r8, [r0, #320]
  str.w r7, [r0, #160]
  str.w r9, [r0], #4
  cmp.w r0, lr
  bne.w gf_polymul_320x320_eval_input_c_body
  vmov.w r2, s1
  add.w r0, r0, #640
  vmov.w s1, r1
  movw.w r1, #7879
  movw.w r3, #32768
  movw.w r4, #20828
  movt.w r4, #8
  add.w lr, r0, #160
gf_polymul_320x320_eval_input_d_body:
  ldr.w r8, [r2, #480]
  ldr.w r7, [r2, #160]
  ldr.w r6, [r2, #320]
  ldr.w r5, [r2], #4
  lsl.w r9, r7, #1
  lsl.w r10, r8, #3
  bfc.w r9, #16, #1
  bfc.w r10, #16, #3
  smlawb.w r12, r4, r10, r3
  smlawt.w r11, r4, r10, r3
  smulbt.w r12, r1, r12
  smulbt.w r11, r1, r11
  pkhbt.w r12, r12, r11, lsl #16
  ssub16.w r10, r10, r12
  sadd16.w r9, r9, r10
  lsl.w r10, r6, #2
  bfc.w r10, #16, #2
  sadd16.w r10, r10, r5
  sadd16.w r11, r10, r9
  ssub16.w r10, r10, r9
  smlawb.w r9, r4, r11, r3
  smlawt.w r12, r4, r11, r3
  smulbt.w r9, r1, r9
  smulbt.w r12, r1, r12
  pkhbt.w r9, r9, r12, lsl #16
  ssub16.w r11, r11, r9
  smlawb.w r9, r4, r10, r3
  smlawt.w r12, r4, r10, r3
  smulbt.w r9, r1, r9
  smulbt.w r12, r1, r12
  pkhbt.w r9, r9, r12, lsl #16
  ssub16.w r10, r10, r9
  lsl.w r9, r5, #3
  lsl.w r12, r6, #1
  bfc.w r9, #16, #3
  bfc.w r12, #16, #1
  vmov s3, s4, r5, r6
  smlawb.w r5, r4, r9, r3
  smlawt.w r6, r4, r9, r3
  smulbt.w r5, r1, r5
  smulbt.w r6, r1, r6
  pkhbt.w r5, r5, r6, lsl #16
  ssub16.w r9, r9, r5
  vmov r5, r6, s3, s4
  sadd16.w r9, r9, r12
  sadd16.w r5, r5, r6
  lsl.w r12, r7, #2
  bfc.w r12, #16, #2
  sadd16.w r12, r12, r8
  sadd16.w r7, r7, r8
  sadd16.w r9, r9, r12
  smlawb.w r6, r4, r9, r3
  smlawt.w r8, r4, r9, r3
  smulbt.w r6, r1, r6
  smulbt.w r8, r1, r8
  pkhbt.w r6, r6, r8, lsl #16
  ssub16.w r9, r9, r6
  ssub16.w r8, r5, r7
  sadd16.w r7, r5, r7
  smlawb.w r5, r4, r8, r3
  smlawt.w r6, r4, r8, r3
  smulbt.w r5, r1, r5
  smulbt.w r6, r1, r6
  pkhbt.w r5, r5, r6, lsl #16
  ssub16.w r8, r8, r5
  smlawb.w r5, r4, r7, r3
  smlawt.w r6, r4, r7, r3
  smulbt.w r5, r1, r5
  smulbt.w r6, r1, r6
  pkhbt.w r5, r5, r6, lsl #16
  ssub16.w r7, r7, r5
  str.w r10, [r0, #640]
  str.w r11, [r0, #480]
  str.w r8, [r0, #320]
  str.w r7, [r0, #160]
  str.w r9, [r0], #4
  cmp.w r0, lr
  bne.w gf_polymul_320x320_eval_input_d_body
  vmov.w r1, s1
  add.w r0, r0, #640
  vmov.w r4, s0
  mov.w r5, r0
  sub.w r6, r1, #160
  sub.w r7, r2, #160
  mov.w r1, r6
  mov.w r2, r7
  bl.w gf_polymul_80x80
  add.w r0, r5, #1280
  sub.w r1, r5, #1600
  sub.w r2, r5, #800
  bl.w gf_polymul_80x80
  add.w r0, r5, #320
  sub.w r1, r5, #1440
  sub.w r2, r5, #640
  bl.w gf_polymul_80x80
  add.w r0, r5, #1600
  sub.w r1, r5, #1280
  sub.w r2, r5, #480
  bl.w gf_polymul_80x80
  add.w r0, r5, #640
  sub.w r1, r5, #1120
  sub.w r2, r5, #320
  bl.w gf_polymul_80x80
  add.w r0, r5, #1920
  sub.w r1, r5, #960
  sub.w r2, r5, #160
  bl.w gf_polymul_80x80
  add.w r0, r5, #960
  add.w r1, r6, #480
  add.w r2, r7, #480
  bl.w gf_polymul_80x80
  vmov.w s0, r4
  mov.w r0, r5
  add.w lr, r0, #320
  movw.w r12, #20828
  movt.w r12, #8
  movw.w r11, #7879
	 movw.w r10, :lower16:Toom4Table_7879
	 movt.w r10, :upper16:Toom4Table_7879
	 vldm	r10, {s1-s16} @ read table
  add.w r1, r0, #1920
gf_polymul_320x320_interpol_output_body:
  ldr.w r10, [r0, #960]
  ldr.w r9, [r1]
  ldr.w r8, [r0, #640]
  ldr.w r7, [r0, #1600]
  ldr.w r6, [r0, #320]
  ldr.w r3, [r0, #1280]
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
  str.w r8, [r0, #1276]
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
  str.w r8, [r0, #316]
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
  str.w r8, [r0, #1596]
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
  str.w r8, [r0, #636]
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
  add.w r1, r0, #1920
  str.w r8, [r1, #-4]
  cmp.w r0, lr
  bne.w gf_polymul_320x320_interpol_output_body
  sub.w r1, r0, #320
  vmov.w r0, s0
  add.w lr, r0, #132
gf_polymul_320x320_copy_output_A:
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
  bne.w gf_polymul_320x320_copy_output_A
  ldr.w r3, [r1, #4]
  ldr.w r4, [r1, #8]
  ldr.w r5, [r1, #12]
  ldr.w r6, [r1, #16]
  ldr.w r7, [r1, #20]
  ldr.w r8, [r1, #24]
  ldr.w r2, [r1], #28
  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r5, [r0, #12]
  str.w r6, [r0, #16]
  str.w r7, [r0, #20]
  str.w r8, [r0, #24]
  str.w r2, [r0], #28
  add.w lr, r0, #960
gf_polymul_320x320_copy_output_B:
  ldr.w r8, [r1, #1124]
  ldr.w r3, [r1, #4]
  ldr.w r9, [r1, #1128]
  ldr.w r4, [r1, #8]
  ldr.w r10, [r1, #1132]
  ldr.w r5, [r1, #12]
  ldr.w r11, [r1, #1136]
  ldr.w r6, [r1, #16]
  ldr.w r7, [r1, #1120]
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
  bne.w gf_polymul_320x320_copy_output_B
  add.w lr, r0, #132
gf_polymul_320x320_copy_output_C:
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
  bne.w gf_polymul_320x320_copy_output_C
  ldr.w r3, [r1, #4]
  ldr.w r4, [r1, #8]
  ldr.w r5, [r1, #12]
  ldr.w r6, [r1, #16]
  ldr.w r7, [r1, #20]
  ldr.w r8, [r1, #24]
  ldr.w r2, [r1], #28
  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r5, [r0, #12]
  str.w r6, [r0, #16]
  str.w r7, [r0, #20]
  str.w r8, [r0, #24]
  str.w r2, [r0], #28
  add.w sp, sp, #6080
  vpop.w { s16 }
  pop.w {r4-r12, pc}
Toom4Table_7879:
	.word	4122869758	@ s1
	.word	4065524228	@ s2^
	.word	4131520510	@ s3^
	.word	4165798467	@ s4^
	.word	150604355	@ s5
	.word	264442	@ s6
	.word	4036948127	@ s7
	.word	200865651	@ s8
	.word	4036953027	@ s9#
	.word	129107233	@ s10^
	.word	4144366881	@ s11
	.word	4294702854	@ s12
	.word	172101475	@ s13
	.word	114817540	@ s14^
	.word	163516259	@ s15^
	.word	200806156	@ s16#
@ # two packed coeffs ^ swapped position
Toom4Table_7879_end:
