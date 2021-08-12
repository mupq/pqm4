.p2align 2,,3
.syntax unified
.text

.global gf_polymul_512x512
.type gf_polymul_512x512, %function
@ 512x512 Toom-4
@ void gf_polymul_512x512(uint32_t *h, uint32_t *c, uint32_t *f)
gf_polymul_512x512:
  push.w {r4-r12, lr}
  vpush.w { s16 }
  sub.w sp, sp, #9728
  vmov.w s0, r0
  mov.w r0, sp
  vmov.w s1, r2
  movw.w r2, #5167
  movw.w r3, #32768
  movw.w r4, #44798
  movt.w r4, #12
  add.w lr, r0, #256
gf_polymul_512x512_eval_input_c_body:
  ldr.w r8, [r1, #768]
  ldr.w r7, [r1, #256]
  ldr.w r6, [r1, #512]
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
  str.w r10, [r0, #1024]
  str.w r11, [r0, #768]
  str.w r8, [r0, #512]
  str.w r7, [r0, #256]
  str.w r9, [r0], #4
  cmp.w r0, lr
  bne.w gf_polymul_512x512_eval_input_c_body
  vmov.w r2, s1
  add.w r0, r0, #1024
  vmov.w s1, r1
  movw.w r1, #5167
  movw.w r3, #32768
  movw.w r4, #44798
  movt.w r4, #12
  add.w lr, r0, #256
gf_polymul_512x512_eval_input_d_body:
  ldr.w r8, [r2, #768]
  ldr.w r7, [r2, #256]
  ldr.w r6, [r2, #512]
  ldr.w r5, [r2], #4
  lsl.w r9, r7, #1
  lsl.w r10, r8, #3
  bfc.w r9, #16, #1
  bfc.w r10, #16, #3
  sadd16.w r9, r9, r10
  smlawb.w r10, r4, r9, r3
  smlawt.w r11, r4, r9, r3
  smulbt.w r10, r1, r10
  smulbt.w r11, r1, r11
  pkhbt.w r10, r10, r11, lsl #16
  ssub16.w r9, r9, r10
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
  sadd16.w r9, r9, r12
  sadd16.w r5, r5, r6
  smlawb.w r6, r4, r9, r3
  smlawt.w r12, r4, r9, r3
  smulbt.w r6, r1, r6
  smulbt.w r12, r1, r12
  pkhbt.w r6, r6, r12, lsl #16
  ssub16.w r9, r9, r6
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
  str.w r10, [r0, #1024]
  str.w r11, [r0, #768]
  str.w r8, [r0, #512]
  str.w r7, [r0, #256]
  str.w r9, [r0], #4
  cmp.w r0, lr
  bne.w gf_polymul_512x512_eval_input_d_body
  vmov.w r1, s1
  add.w r0, r0, #1024
  vmov.w r4, s0
  mov.w r5, r0
  sub.w r6, r1, #256
  sub.w r7, r2, #256
  mov.w r1, r6
  mov.w r2, r7
  bl.w gf_polymul_128x128
  add.w r0, r5, #2048
  sub.w r1, r5, #2560
  sub.w r2, r5, #1280
  bl.w gf_polymul_128x128
  add.w r0, r5, #512
  sub.w r1, r5, #2304
  sub.w r2, r5, #1024
  bl.w gf_polymul_128x128
  add.w r0, r5, #2560
  sub.w r1, r5, #2048
  sub.w r2, r5, #768
  bl.w gf_polymul_128x128
  add.w r0, r5, #1024
  sub.w r1, r5, #1792
  sub.w r2, r5, #512
  bl.w gf_polymul_128x128
  add.w r0, r5, #3072
  sub.w r1, r5, #1536
  sub.w r2, r5, #256
  bl.w gf_polymul_128x128
  add.w r0, r5, #1536
  add.w r1, r6, #768
  add.w r2, r7, #768
  bl.w gf_polymul_128x128
  vmov.w s0, r4
  mov.w r0, r5
  add.w lr, r0, #512
  movw.w r12, #44798
  movt.w r12, #12
  movw.w r11, #5167
	 movw.w r10, :lower16:Toom4Table_5167
	 movt.w r10, :upper16:Toom4Table_5167
	 vldm	r10, {s1-s16} @ read table
  add.w r1, r0, #3072
gf_polymul_512x512_interpol_output_body:
  ldr.w r10, [r0, #1536]
  ldr.w r9, [r1]
  ldr.w r8, [r0, #1024]
  ldr.w r7, [r0, #2560]
  ldr.w r6, [r0, #512]
  ldr.w r3, [r0, #2048]
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
  str.w r8, [r0, #2044]
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
  str.w r8, [r0, #508]
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
  str.w r8, [r0, #2556]
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
  str.w r8, [r0, #1020]
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
  add.w r1, r0, #3072
  str.w r8, [r1, #-4]
  cmp.w r0, lr
  bne.w gf_polymul_512x512_interpol_output_body
  sub.w r1, r0, #512
  vmov.w r0, s0
  add.w lr, r0, #220
gf_polymul_512x512_copy_output_A:
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
  bne.w gf_polymul_512x512_copy_output_A
  ldr.w r3, [r1, #4]
  ldr.w r4, [r1, #8]
  ldr.w r5, [r1, #12]
  ldr.w r6, [r1, #16]
  ldr.w r7, [r1, #20]
  ldr.w r8, [r1, #24]
  ldr.w r9, [r1, #28]
  ldr.w r10, [r1, #32]
  ldr.w r2, [r1], #36
  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r5, [r0, #12]
  str.w r6, [r0, #16]
  str.w r7, [r0, #20]
  str.w r8, [r0, #24]
  str.w r9, [r0, #28]
  str.w r10, [r0, #32]
  str.w r2, [r0], #36
  add.w lr, r0, #1520
gf_polymul_512x512_copy_output_B:
  ldr.w r8, [r1, #1796]
  ldr.w r3, [r1, #4]
  ldr.w r9, [r1, #1800]
  ldr.w r4, [r1, #8]
  ldr.w r10, [r1, #1804]
  ldr.w r5, [r1, #12]
  ldr.w r11, [r1, #1808]
  ldr.w r6, [r1, #16]
  ldr.w r7, [r1, #1792]
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
  bne.w gf_polymul_512x512_copy_output_B
  ldr.w r7, [r1, #1796]
  ldr.w r3, [r1, #4]
  ldr.w r8, [r1, #1800]
  ldr.w r4, [r1, #8]
  ldr.w r9, [r1, #1804]
  ldr.w r5, [r1, #12]
  ldr.w r6, [r1, #1792]
  ldr.w r2, [r1], #16
  sadd16.w r2, r2, r6
  sadd16.w r3, r3, r7
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r5, [r0, #12]
  str.w r2, [r0], #16
  add.w lr, r0, #220
gf_polymul_512x512_copy_output_C:
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
  bne.w gf_polymul_512x512_copy_output_C
  ldr.w r3, [r1, #4]
  ldr.w r4, [r1, #8]
  ldr.w r5, [r1, #12]
  ldr.w r6, [r1, #16]
  ldr.w r7, [r1, #20]
  ldr.w r8, [r1, #24]
  ldr.w r9, [r1, #28]
  ldr.w r10, [r1, #32]
  ldr.w r2, [r1], #36
  str.w r3, [r0, #4]
  str.w r4, [r0, #8]
  str.w r5, [r0, #12]
  str.w r6, [r0, #16]
  str.w r7, [r0, #20]
  str.w r8, [r0, #24]
  str.w r9, [r0, #28]
  str.w r10, [r0, #32]
  str.w r2, [r0], #36
  add.w sp, sp, #9728
  vpop.w { s16 }
  pop.w {r4-r12, pc}
Toom4Table_5167:
	.word	4182114302	@ s1
	.word	75237768	@ s2^
	.word	96010238	@ s3^
	.word	4210230971	@ s4^
	.word	98764475	@ s5
	.word	263651	@ s6
	.word	4125816299	@ s7
	.word	18810841	@ s8
	.word	4125819856	@ s9#
	.word	84673373	@ s10^
	.word	4196205405	@ s11
	.word	4294703645	@ s12
	.word	112855575	@ s13
	.word	4257352072	@ s14^
	.word	4199025175	@ s15^
	.word	18873105	@ s16#
@ # two packed coeffs ^ swapped position
Toom4Table_5167_end:
