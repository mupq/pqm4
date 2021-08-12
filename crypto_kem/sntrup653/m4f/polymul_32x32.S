.p2align 2,,3
.syntax unified
.text

.global gf_polymul_32x32
.type gf_polymul_32x32, %function
@ 32x32 0-layer Karatsuba
@ void gf_polymul_32x32(uint32_t *h, uint32_t *c, uint32_t *f)
gf_polymul_32x32:
  push.w {r4-r12, lr}
  movw.w r3, #11941
  movt.w r3, #14
  vmov.w s2, r3
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  smulbb.w r7, r3, r5
  smulbb.w r9, r3, r6
  smuadx.w r8, r3, r5
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  vmov.w s3, r5
  vmov.w r4, s2
  movw.w r3, #4621
  smmulr.w r5, r4, r7
  mls.w r7, r3, r5, r7
  smmulr.w r5, r4, r8
  mls.w r8, r3, r5, r8
  pkhbt.w r7, r7, r8, lsl #16
  smmulr.w r5, r4, r9
  mls.w r9, r3, r5, r9
  smmulr.w r5, r4, r10
  mls.w r10, r3, r5, r10
  pkhbt.w r8, r9, r10, lsl #16
  vmov.w r5, s3
  str.w r8, [r0, #4]
  str.w r7, [r0], #8
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  vmov.w r6, s2
  movw.w r5, #4621
  smmulr.w r3, r6, r11
  mls.w r11, r5, r3, r11
  smmulr.w r3, r6, r12
  mls.w r12, r5, r3, r12
  pkhbt.w r11, r11, r12, lsl #16
  smmulr.w r3, r6, lr
  mls.w lr, r5, r3, lr
  smmulr.w r3, r6, r10
  mls.w r10, r5, r3, r10
  pkhbt.w r12, lr, r10, lsl #16
  ldr.w r3, [r1, #-8]
  str.w r12, [r0, #4]
  str.w r11, [r0], #8
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  vmov.w s3, r5
  vmov.w r4, s2
  movw.w r3, #4621
  smmulr.w r5, r4, r7
  mls.w r7, r3, r5, r7
  smmulr.w r5, r4, r8
  mls.w r8, r3, r5, r8
  pkhbt.w r7, r7, r8, lsl #16
  smmulr.w r5, r4, r9
  mls.w r9, r3, r5, r9
  smmulr.w r5, r4, r10
  mls.w r10, r3, r5, r10
  pkhbt.w r8, r9, r10, lsl #16
  vmov.w r5, s3
  str.w r8, [r0, #4]
  str.w r7, [r0], #8
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  vmov.w r6, s2
  movw.w r5, #4621
  smmulr.w r3, r6, r11
  mls.w r11, r5, r3, r11
  smmulr.w r3, r6, r12
  mls.w r12, r5, r3, r12
  pkhbt.w r11, r11, r12, lsl #16
  smmulr.w r3, r6, lr
  mls.w lr, r5, r3, lr
  smmulr.w r3, r6, r10
  mls.w r10, r5, r3, r10
  pkhbt.w r12, lr, r10, lsl #16
  ldr.w r3, [r1, #-8]
  str.w r12, [r0, #4]
  str.w r11, [r0], #8
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  vmov.w s3, r5
  vmov.w r4, s2
  movw.w r3, #4621
  smmulr.w r5, r4, r7
  mls.w r7, r3, r5, r7
  smmulr.w r5, r4, r8
  mls.w r8, r3, r5, r8
  pkhbt.w r7, r7, r8, lsl #16
  smmulr.w r5, r4, r9
  mls.w r9, r3, r5, r9
  smmulr.w r5, r4, r10
  mls.w r10, r3, r5, r10
  pkhbt.w r8, r9, r10, lsl #16
  vmov.w r5, s3
  str.w r8, [r0, #4]
  str.w r7, [r0], #8
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  vmov.w r6, s2
  movw.w r5, #4621
  smmulr.w r3, r6, r11
  mls.w r11, r5, r3, r11
  smmulr.w r3, r6, r12
  mls.w r12, r5, r3, r12
  pkhbt.w r11, r11, r12, lsl #16
  smmulr.w r3, r6, lr
  mls.w lr, r5, r3, lr
  smmulr.w r3, r6, r10
  mls.w r10, r5, r3, r10
  pkhbt.w r12, lr, r10, lsl #16
  ldr.w r3, [r1, #-8]
  str.w r12, [r0, #4]
  str.w r11, [r0], #8
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  vmov.w s3, r5
  vmov.w r4, s2
  movw.w r3, #4621
  smmulr.w r5, r4, r7
  mls.w r7, r3, r5, r7
  smmulr.w r5, r4, r8
  mls.w r8, r3, r5, r8
  pkhbt.w r7, r7, r8, lsl #16
  smmulr.w r5, r4, r9
  mls.w r9, r3, r5, r9
  smmulr.w r5, r4, r10
  mls.w r10, r3, r5, r10
  pkhbt.w r8, r9, r10, lsl #16
  vmov.w r5, s3
  str.w r8, [r0, #4]
  str.w r7, [r0], #8
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  vmov.w s3, r5
  vmov.w r4, s2
  movw.w r3, #4621
  smmulr.w r5, r4, r11
  mls.w r11, r3, r5, r11
  smmulr.w r5, r4, r12
  mls.w r12, r3, r5, r12
  pkhbt.w r11, r11, r12, lsl #16
  smmulr.w r5, r4, lr
  mls.w lr, r3, r5, lr
  smmulr.w r5, r4, r10
  mls.w r10, r3, r5, r10
  pkhbt.w r12, lr, r10, lsl #16
  vmov.w r5, s3
  str.w r12, [r0, #4]
  str.w r11, [r0], #8
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  vmov.w r6, s2
  movw.w r5, #4621
  smmulr.w r3, r6, r7
  mls.w r7, r5, r3, r7
  smmulr.w r3, r6, r8
  mls.w r8, r5, r3, r8
  pkhbt.w r7, r7, r8, lsl #16
  smmulr.w r3, r6, r9
  mls.w r9, r5, r3, r9
  smmulr.w r3, r6, r10
  mls.w r10, r5, r3, r10
  pkhbt.w r8, r9, r10, lsl #16
  ldr.w r3, [r1, #4]
  str.w r8, [r0, #4]
  str.w r7, [r0], #8
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  vmov.w s3, r5
  vmov.w r4, s2
  movw.w r3, #4621
  smmulr.w r5, r4, r11
  mls.w r11, r3, r5, r11
  smmulr.w r5, r4, r12
  mls.w r12, r3, r5, r12
  pkhbt.w r11, r11, r12, lsl #16
  smmulr.w r5, r4, lr
  mls.w lr, r3, r5, lr
  smmulr.w r5, r4, r10
  mls.w r10, r3, r5, r10
  pkhbt.w r12, lr, r10, lsl #16
  vmov.w r5, s3
  str.w r12, [r0, #4]
  str.w r11, [r0], #8
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  vmov.w r6, s2
  movw.w r5, #4621
  smmulr.w r3, r6, r7
  mls.w r7, r5, r3, r7
  smmulr.w r3, r6, r8
  mls.w r8, r5, r3, r8
  pkhbt.w r7, r7, r8, lsl #16
  smmulr.w r3, r6, r9
  mls.w r9, r5, r3, r9
  smmulr.w r3, r6, r10
  mls.w r10, r5, r3, r10
  pkhbt.w r8, r9, r10, lsl #16
  ldr.w r3, [r1, #4]
  str.w r8, [r0, #4]
  str.w r7, [r0], #8
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #-8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  vmov.w s3, r5
  vmov.w r4, s2
  movw.w r3, #4621
  smmulr.w r5, r4, r11
  mls.w r11, r3, r5, r11
  smmulr.w r5, r4, r12
  mls.w r12, r3, r5, r12
  pkhbt.w r11, r11, r12, lsl #16
  smmulr.w r5, r4, lr
  mls.w lr, r3, r5, lr
  smmulr.w r5, r4, r10
  mls.w r10, r3, r5, r10
  pkhbt.w r12, lr, r10, lsl #16
  vmov.w r5, s3
  str.w r12, [r0, #4]
  str.w r11, [r0], #8
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #-8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  vmov.w r6, s2
  movw.w r5, #4621
  smmulr.w r3, r6, r7
  mls.w r7, r5, r3, r7
  smmulr.w r3, r6, r8
  mls.w r8, r5, r3, r8
  pkhbt.w r7, r7, r8, lsl #16
  smmulr.w r3, r6, r9
  mls.w r9, r5, r3, r9
  smmulr.w r3, r6, r10
  mls.w r10, r5, r3, r10
  pkhbt.w r8, r9, r10, lsl #16
  ldr.w r3, [r1, #4]
  str.w r8, [r0, #4]
  str.w r7, [r0], #8
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #8
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  vmov.w s3, r5
  vmov.w r4, s2
  movw.w r3, #4621
  smmulr.w r5, r4, r11
  mls.w r11, r3, r5, r11
  smmulr.w r5, r4, r12
  mls.w r12, r3, r5, r12
  pkhbt.w r11, r11, r12, lsl #16
  smmulr.w r5, r4, lr
  mls.w lr, r3, r5, lr
  smmulr.w r5, r4, r10
  mls.w r10, r3, r5, r10
  pkhbt.w r12, lr, r10, lsl #16
  vmov.w r5, s3
  str.w r12, [r0, #4]
  str.w r11, [r0], #8
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #8
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  vmov.w r6, s2
  movw.w r5, #4621
  smmulr.w r3, r6, r7
  mls.w r7, r5, r3, r7
  smmulr.w r3, r6, r8
  mls.w r8, r5, r3, r8
  pkhbt.w r7, r7, r8, lsl #16
  smmulr.w r3, r6, r9
  mls.w r9, r5, r3, r9
  smmulr.w r3, r6, r10
  mls.w r10, r5, r3, r10
  pkhbt.w r8, r9, r10, lsl #16
  smmulr.w r3, r6, r11
  mls.w r11, r5, r3, r11
  smmulr.w r3, r6, r12
  mls.w r12, r5, r3, r12
  pkhbt.w r9, r11, r12, lsl #16
  smmulr.w r3, r6, lr
  mls.w r10, r5, r3, lr
  ubfx.w r10, r10, #0, #16
  str.w r8, [r0, #4]
  str.w r7, [r0], #8
  str.w r10, [r0, #4]
  str.w r9, [r0], #8
  pop.w {r4-r12, pc}
