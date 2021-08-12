
	.p2align	2,,3	
	.syntax		unified
	.text
	.global		jump8divsteps_mod3_1
	.type		jump8divsteps_mod3_1, %function
jump8divsteps_mod3_1:
	push	{r1,r4-r11,lr}
	vmov	s0, r0		// save minusdelta
	vcvt.f32.s32	s0, s0		// convert to float
	vmov.f32	s1, #-1.0	// float -1.0 #240
	ldr	r5, [r3, #4] // g1
	ldr	r4, [r3] //g0
	ldr	r3, [r2, #4] // f1
	ldr	r2, [r2] //f0
	mov	r6, #1	// u0
	mov	r8, #0	// v0
	mov	r10, #0	// r0
	mov	r12, #1	// s0
	movw	r0, 0x0303
	movt	r0, 0x0303
jump8divsteps_ub3_1_0:	// start of turn 0
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	mov	r1, #0x1000000
	umull	r7, r6, r6, r1
	umull	r9, r8, r8, r1
	umull	r11, r10, r10, r1
	umull	r14, r12, r12, r1
	vcvt.s32.f32	s0, s0	// back to int
	vmov	r0, s0		// restore minusdelta
	pop	{r1}
	str	r3, [r1, #4]
	str	r4, [r1, #8]
	str	r5, [r1, #12]
	str	r6, [r1, #16]
	str	r7, [r1, #20]
	str	r8, [r1, #24]
	str	r9, [r1, #28]
	str	r10, [r1, #32]
	str	r11, [r1, #36]
	str	r12, [r1, #40]
	str	r14, [r1, #44] // 12th register
	str	r2, [r1], #48
	pop	{r4-r11,pc}

	.p2align	2,,3	
	.syntax		unified
	.text
	.global		jump8divsteps_mod3_2
	.type		jump8divsteps_mod3_2, %function
jump8divsteps_mod3_2:
	push	{r1,r4-r11,lr}
	vmov	s0, r0		// save minusdelta
	vcvt.f32.s32	s0, s0		// convert to float
	vmov.f32	s1, #-1.0	// float -1.0 #240
	ldr	r5, [r3, #4] // g1
	ldr	r4, [r3] //g0
	ldr	r3, [r2, #4] // f1
	ldr	r2, [r2] //f0
	mov	r6, #1	// u0
	mov	r8, #0	// v0
	mov	r10, #0	// r0
	mov	r12, #1	// s0
	movw	r0, 0x0303
	movt	r0, 0x0303
jump8divsteps_ub3_2_0:	// start of turn 0
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_2_1:	// start of turn 1
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	mov	r1, #0x10000
	umull	r7, r6, r6, r1
	umull	r9, r8, r8, r1
	umull	r11, r10, r10, r1
	umull	r14, r12, r12, r1
	vcvt.s32.f32	s0, s0	// back to int
	vmov	r0, s0		// restore minusdelta
	pop	{r1}
	str	r3, [r1, #4]
	str	r4, [r1, #8]
	str	r5, [r1, #12]
	str	r6, [r1, #16]
	str	r7, [r1, #20]
	str	r8, [r1, #24]
	str	r9, [r1, #28]
	str	r10, [r1, #32]
	str	r11, [r1, #36]
	str	r12, [r1, #40]
	str	r14, [r1, #44] // 12th register
	str	r2, [r1], #48
	pop	{r4-r11,pc}

	.p2align	2,,3	
	.syntax		unified
	.text
	.global		jump8divsteps_mod3_3
	.type		jump8divsteps_mod3_3, %function
jump8divsteps_mod3_3:
	push	{r1,r4-r11,lr}
	vmov	s0, r0		// save minusdelta
	vcvt.f32.s32	s0, s0		// convert to float
	vmov.f32	s1, #-1.0	// float -1.0 #240
	ldr	r5, [r3, #4] // g1
	ldr	r4, [r3] //g0
	ldr	r3, [r2, #4] // f1
	ldr	r2, [r2] //f0
	mov	r6, #1	// u0
	mov	r8, #0	// v0
	mov	r10, #0	// r0
	mov	r12, #1	// s0
	movw	r0, 0x0303
	movt	r0, 0x0303
jump8divsteps_ub3_3_0:	// start of turn 0
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_3_1:	// start of turn 1
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_3_2:	// start of turn 2
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	mov	r1, #0x100
	umull	r7, r6, r6, r1
	umull	r9, r8, r8, r1
	umull	r11, r10, r10, r1
	umull	r14, r12, r12, r1
	vcvt.s32.f32	s0, s0	// back to int
	vmov	r0, s0		// restore minusdelta
	pop	{r1}
	str	r3, [r1, #4]
	str	r4, [r1, #8]
	str	r5, [r1, #12]
	str	r6, [r1, #16]
	str	r7, [r1, #20]
	str	r8, [r1, #24]
	str	r9, [r1, #28]
	str	r10, [r1, #32]
	str	r11, [r1, #36]
	str	r12, [r1, #40]
	str	r14, [r1, #44] // 12th register
	str	r2, [r1], #48
	pop	{r4-r11,pc}

	.p2align	2,,3	
	.syntax		unified
	.text
	.global		jump8divsteps_mod3_4
	.type		jump8divsteps_mod3_4, %function
jump8divsteps_mod3_4:
	push	{r1,r4-r11,lr}
	vmov	s0, r0		// save minusdelta
	vcvt.f32.s32	s0, s0		// convert to float
	vmov.f32	s1, #-1.0	// float -1.0 #240
	ldr	r5, [r3, #4] // g1
	ldr	r4, [r3] //g0
	ldr	r3, [r2, #4] // f1
	ldr	r2, [r2] //f0
	mov	r7, #1	// u0
	mov	r9, #0	// v0
	mov	r11, #0	// r0
	mov	r14, #1	// s0
	movw	r0, 0x0303
	movt	r0, 0x0303
jump8divsteps_ub3_4_0:	// start of turn 0
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	itttt	cs
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r11, r1, r7, r11	// r+=T0*u, 0..10
	mla	r14, r1, r9, r14	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	lsl	r7, r7, #8	// u*=x
	lsl	r9, r9, #8	// v*=x
jump8divsteps_ub3_4_1:	// start of turn 1
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	itttt	cs
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r11, r1, r7, r11	// r+=T0*u, 0..10
	mla	r14, r1, r9, r14	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	lsl	r7, r7, #8	// u*=x
	lsl	r9, r9, #8	// v*=x
jump8divsteps_ub3_4_2:	// start of turn 2
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	itttt	cs
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r11, r1, r7, r11	// r+=T0*u, 0..10
	mla	r14, r1, r9, r14	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	lsl	r7, r7, #8	// u*=x
	lsl	r9, r9, #8	// v*=x
jump8divsteps_ub3_4_3:	// start of turn 3
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	itttt	cs
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r11, r1, r7, r11	// r+=T0*u, 0..10
	mla	r14, r1, r9, r14	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	mov	r6, #0
	mov	r8, #0
	mov	r10, #0
	mov	r12, #0
	vcvt.s32.f32	s0, s0	// back to int
	vmov	r0, s0		// restore minusdelta
	pop	{r1}
	str	r3, [r1, #4]
	str	r4, [r1, #8]
	str	r5, [r1, #12]
	str	r6, [r1, #16]
	str	r7, [r1, #20]
	str	r8, [r1, #24]
	str	r9, [r1, #28]
	str	r10, [r1, #32]
	str	r11, [r1, #36]
	str	r12, [r1, #40]
	str	r14, [r1, #44] // 12th register
	str	r2, [r1], #48
	pop	{r4-r11,pc}

	.p2align	2,,3	
	.syntax		unified
	.text
	.global		jump8divsteps_mod3_5
	.type		jump8divsteps_mod3_5, %function
jump8divsteps_mod3_5:
	push	{r1,r4-r11,lr}
	vmov	s0, r0		// save minusdelta
	vcvt.f32.s32	s0, s0		// convert to float
	vmov.f32	s1, #-1.0	// float -1.0 #240
	ldr	r5, [r3, #4] // g1
	ldr	r4, [r3] //g0
	ldr	r3, [r2, #4] // f1
	ldr	r2, [r2] //f0
	mov	r6, #1	// u0
	mov	r8, #0	// v0
	mov	r10, #0	// r0
	mov	r12, #1	// s0
	movw	r0, 0x0303
	movt	r0, 0x0303
jump8divsteps_ub3_5_0:	// start of turn 0
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_5_1:	// start of turn 1
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_5_2:	// start of turn 2
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_5_3:	// start of turn 3
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	mov	r1, #256
	umull	r6, r7, r6, r1	// u*=x
	umull	r8, r9, r8, r1	// v*=x
	mov	r11, #0
	mov	r14, #0
jump8divsteps_ub3_5_4:	// start of turn 4
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	movcs	r1, r8	// r8<->r12
	itttt	cs
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	itttt	cs
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	movcs	r2, r4
	movcs	r4, r1
	itttt	cs
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r0+=T0*u0, 0..10
	mla	r11, r1, r7, r11	// r1+=T0*u1, 0..10
	mla	r12, r1, r8, r12	// s0+=T0*v0, 0..10
	mla	r14, r1, r9, r14	// s1+=T0*v1, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	mov	r1, 0x1000000
	umull	r6, r0, r6, r1
	add	r7, r0, r7, LSL #24
	umull	r8, r0, r8, r1
	add	r9, r0, r9, LSL #24
	umull	r10, r0, r10, r1
	add	r11, r0, r11, LSL #24
	umull	r12, r0, r12, r1
	add	r14, r0, r14, LSL #24
	vcvt.s32.f32	s0, s0	// back to int
	vmov	r0, s0		// restore minusdelta
	pop	{r1}
	str	r3, [r1, #4]
	str	r4, [r1, #8]
	str	r5, [r1, #12]
	str	r6, [r1, #16]
	str	r7, [r1, #20]
	str	r8, [r1, #24]
	str	r9, [r1, #28]
	str	r10, [r1, #32]
	str	r11, [r1, #36]
	str	r12, [r1, #40]
	str	r14, [r1, #44] // 12th register
	str	r2, [r1], #48
	pop	{r4-r11,pc}

	.p2align	2,,3	
	.syntax		unified
	.text
	.global		jump8divsteps_mod3_6
	.type		jump8divsteps_mod3_6, %function
jump8divsteps_mod3_6:
	push	{r1,r4-r11,lr}
	vmov	s0, r0		// save minusdelta
	vcvt.f32.s32	s0, s0		// convert to float
	vmov.f32	s1, #-1.0	// float -1.0 #240
	ldr	r5, [r3, #4] // g1
	ldr	r4, [r3] //g0
	ldr	r3, [r2, #4] // f1
	ldr	r2, [r2] //f0
	mov	r6, #1	// u0
	mov	r8, #0	// v0
	mov	r10, #0	// r0
	mov	r12, #1	// s0
	movw	r0, 0x0303
	movt	r0, 0x0303
jump8divsteps_ub3_6_0:	// start of turn 0
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_6_1:	// start of turn 1
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_6_2:	// start of turn 2
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_6_3:	// start of turn 3
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	mov	r1, #256
	umull	r6, r7, r6, r1	// u*=x
	umull	r8, r9, r8, r1	// v*=x
	mov	r11, #0
	mov	r14, #0
jump8divsteps_ub3_6_4:	// start of turn 4
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	movcs	r1, r8	// r8<->r12
	itttt	cs
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	itttt	cs
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	movcs	r2, r4
	movcs	r4, r1
	itttt	cs
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r0+=T0*u0, 0..10
	mla	r11, r1, r7, r11	// r1+=T0*u1, 0..10
	mla	r12, r1, r8, r12	// s0+=T0*v0, 0..10
	mla	r14, r1, r9, r14	// s1+=T0*v1, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	lsl	r7, r7, #8
	orr	r7, r7, r6, LSR #24
	lsl	r6, r6, #8
	lsl	r9, r9, #8
	orr	r9, r9, r8, LSR #24
	lsl	r8, r8, #8
jump8divsteps_ub3_6_5:	// start of turn 5
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	movcs	r1, r8	// r8<->r12
	itttt	cs
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	itttt	cs
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	movcs	r2, r4
	movcs	r4, r1
	itttt	cs
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r0+=T0*u0, 0..10
	mla	r11, r1, r7, r11	// r1+=T0*u1, 0..10
	mla	r12, r1, r8, r12	// s0+=T0*v0, 0..10
	mla	r14, r1, r9, r14	// s1+=T0*v1, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	mov	r1, 0x10000
	umull	r6, r0, r6, r1
	add	r7, r0, r7, LSL #16
	umull	r8, r0, r8, r1
	add	r9, r0, r9, LSL #16
	umull	r10, r0, r10, r1
	add	r11, r0, r11, LSL #16
	umull	r12, r0, r12, r1
	add	r14, r0, r14, LSL #16
	vcvt.s32.f32	s0, s0	// back to int
	vmov	r0, s0		// restore minusdelta
	pop	{r1}
	str	r3, [r1, #4]
	str	r4, [r1, #8]
	str	r5, [r1, #12]
	str	r6, [r1, #16]
	str	r7, [r1, #20]
	str	r8, [r1, #24]
	str	r9, [r1, #28]
	str	r10, [r1, #32]
	str	r11, [r1, #36]
	str	r12, [r1, #40]
	str	r14, [r1, #44] // 12th register
	str	r2, [r1], #48
	pop	{r4-r11,pc}

	.p2align	2,,3	
	.syntax		unified
	.text
	.global		jump8divsteps_mod3_7
	.type		jump8divsteps_mod3_7, %function
jump8divsteps_mod3_7:
	push	{r1,r4-r11,lr}
	vmov	s0, r0		// save minusdelta
	vcvt.f32.s32	s0, s0		// convert to float
	vmov.f32	s1, #-1.0	// float -1.0 #240
	ldr	r5, [r3, #4] // g1
	ldr	r4, [r3] //g0
	ldr	r3, [r2, #4] // f1
	ldr	r2, [r2] //f0
	mov	r6, #1	// u0
	mov	r8, #0	// v0
	mov	r10, #0	// r0
	mov	r12, #1	// s0
	movw	r0, 0x0303
	movt	r0, 0x0303
jump8divsteps_ub3_7_0:	// start of turn 0
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_7_1:	// start of turn 1
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_7_2:	// start of turn 2
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_7_3:	// start of turn 3
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	mov	r1, #256
	umull	r6, r7, r6, r1	// u*=x
	umull	r8, r9, r8, r1	// v*=x
	mov	r11, #0
	mov	r14, #0
jump8divsteps_ub3_7_4:	// start of turn 4
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	movcs	r1, r8	// r8<->r12
	itttt	cs
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	itttt	cs
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	movcs	r2, r4
	movcs	r4, r1
	itttt	cs
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r0+=T0*u0, 0..10
	mla	r11, r1, r7, r11	// r1+=T0*u1, 0..10
	mla	r12, r1, r8, r12	// s0+=T0*v0, 0..10
	mla	r14, r1, r9, r14	// s1+=T0*v1, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	lsl	r7, r7, #8
	orr	r7, r7, r6, LSR #24
	lsl	r6, r6, #8
	lsl	r9, r9, #8
	orr	r9, r9, r8, LSR #24
	lsl	r8, r8, #8
jump8divsteps_ub3_7_5:	// start of turn 5
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	movcs	r1, r8	// r8<->r12
	itttt	cs
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	itttt	cs
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	movcs	r2, r4
	movcs	r4, r1
	itttt	cs
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r0+=T0*u0, 0..10
	mla	r11, r1, r7, r11	// r1+=T0*u1, 0..10
	mla	r12, r1, r8, r12	// s0+=T0*v0, 0..10
	mla	r14, r1, r9, r14	// s1+=T0*v1, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	lsl	r7, r7, #8
	orr	r7, r7, r6, LSR #24
	lsl	r6, r6, #8
	lsl	r9, r9, #8
	orr	r9, r9, r8, LSR #24
	lsl	r8, r8, #8
jump8divsteps_ub3_7_6:	// start of turn 6
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	movcs	r1, r8	// r8<->r12
	itttt	cs
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	itttt	cs
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	movcs	r2, r4
	movcs	r4, r1
	itttt	cs
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r0+=T0*u0, 0..10
	mla	r11, r1, r7, r11	// r1+=T0*u1, 0..10
	mla	r12, r1, r8, r12	// s0+=T0*v0, 0..10
	mla	r14, r1, r9, r14	// s1+=T0*v1, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	mov	r1, 0x100
	umull	r6, r0, r6, r1
	add	r7, r0, r7, LSL #8
	umull	r8, r0, r8, r1
	add	r9, r0, r9, LSL #8
	umull	r10, r0, r10, r1
	add	r11, r0, r11, LSL #8
	umull	r12, r0, r12, r1
	add	r14, r0, r14, LSL #8
	vcvt.s32.f32	s0, s0	// back to int
	vmov	r0, s0		// restore minusdelta
	pop	{r1}
	str	r3, [r1, #4]
	str	r4, [r1, #8]
	str	r5, [r1, #12]
	str	r6, [r1, #16]
	str	r7, [r1, #20]
	str	r8, [r1, #24]
	str	r9, [r1, #28]
	str	r10, [r1, #32]
	str	r11, [r1, #36]
	str	r12, [r1, #40]
	str	r14, [r1, #44] // 12th register
	str	r2, [r1], #48
	pop	{r4-r11,pc}

	.p2align	2,,3	
	.syntax		unified
	.text
	.global		jump8divsteps_mod3
	.type		jump8divsteps_mod3, %function
jump8divsteps_mod3:
	push	{r1,r4-r11,lr}
	vmov	s0, r0		// save minusdelta
	vcvt.f32.s32	s0, s0		// convert to float
	vmov.f32	s1, #-1.0	// float -1.0 #240
	ldr	r5, [r3, #4] // g1
	ldr	r4, [r3] //g0
	ldr	r3, [r2, #4] // f1
	ldr	r2, [r2] //f0
	mov	r6, #1	// u0
	mov	r8, #0	// v0
	mov	r10, #0	// r0
	mov	r12, #1	// s0
	movw	r0, 0x0303
	movt	r0, 0x0303
jump8divsteps_ub3_8_0:	// start of turn 0
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_8_1:	// start of turn 1
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_8_2:	// start of turn 2
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	lsl	r6, r6, #8	// u*=x
	lsl	r8, r8, #8	// v*=x
jump8divsteps_ub3_8_3:	// start of turn 3
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r8	// r8<->r12
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r2	// r2<->r4
	itttt	cs
	movcs	r2, r4
	movcs	r4, r1
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	itt	cs
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r+=T0*u, 0..10
	mla	r12, r1, r8, r12	// s+=T0*v, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	mov	r1, #256
	umull	r6, r7, r6, r1	// u*=x
	umull	r8, r9, r8, r1	// v*=x
	mov	r11, #0
	mov	r14, #0
jump8divsteps_ub3_8_4:	// start of turn 4
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	movcs	r1, r8	// r8<->r12
	itttt	cs
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	itttt	cs
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	movcs	r2, r4
	movcs	r4, r1
	itttt	cs
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r0+=T0*u0, 0..10
	mla	r11, r1, r7, r11	// r1+=T0*u1, 0..10
	mla	r12, r1, r8, r12	// s0+=T0*v0, 0..10
	mla	r14, r1, r9, r14	// s1+=T0*v1, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	lsl	r7, r7, #8
	orr	r7, r7, r6, LSR #24
	lsl	r6, r6, #8
	lsl	r9, r9, #8
	orr	r9, r9, r8, LSR #24
	lsl	r8, r8, #8
jump8divsteps_ub3_8_5:	// start of turn 5
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	movcs	r1, r8	// r8<->r12
	itttt	cs
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	itttt	cs
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	movcs	r2, r4
	movcs	r4, r1
	itttt	cs
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r0+=T0*u0, 0..10
	mla	r11, r1, r7, r11	// r1+=T0*u1, 0..10
	mla	r12, r1, r8, r12	// s0+=T0*v0, 0..10
	mla	r14, r1, r9, r14	// s1+=T0*v1, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	lsl	r7, r7, #8
	orr	r7, r7, r6, LSR #24
	lsl	r6, r6, #8
	lsl	r9, r9, #8
	orr	r9, r9, r8, LSR #24
	lsl	r8, r8, #8
jump8divsteps_ub3_8_6:	// start of turn 6
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	movcs	r1, r8	// r8<->r12
	itttt	cs
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	itttt	cs
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	movcs	r2, r4
	movcs	r4, r1
	itttt	cs
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r0+=T0*u0, 0..10
	mla	r11, r1, r7, r11	// r1+=T0*u1, 0..10
	mla	r12, r1, r8, r12	// s0+=T0*v0, 0..10
	mla	r14, r1, r9, r14	// s1+=T0*v1, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	lsl	r7, r7, #8
	orr	r7, r7, r6, LSR #24
	lsl	r6, r6, #8
	lsl	r9, r9, #8
	orr	r9, r9, r8, LSR #24
	lsl	r8, r8, #8
jump8divsteps_ub3_8_7:	// start of turn 7
	uxtb	r1, r4
	vcmp.f32	s1, s0		// delta > 0?
	vmrs	APSR_nzcv, FPSCR	// move carry
	itttt	cs
	cmpcs	r1, #1
	movcs	r1, r6	// r6<->r10
	movcs	r6, r10
	movcs	r10, r1
	itttt	cs
	movcs	r1, r7	// r7<->r11
	movcs	r7, r11
	movcs	r11, r1
	movcs	r1, r8	// r8<->r12
	itttt	cs
	movcs	r8, r12
	movcs	r12, r1
	movcs	r1, r9	// r9<->r14
	movcs	r9, r14
	itttt	cs
	movcs	r14, r1
	movcs	r1, r2	// r2<->r4
	movcs	r2, r4
	movcs	r4, r1
	itttt	cs
	movcs	r1, r3	// r3<->r5
	movcs	r3, r5
	movcs	r5, r1
	vnegcs.f32	s0, s0
	vadd.f32	s0, s0, s1 	// dec minusdelta
	sub	r1, r0, r2	// -f
	mul	r1, r4, r1	// T0 = -f0*g0
	and	r1, r1, #0xff	// T0 = 0..4
	mla	r10, r1, r6, r10	// r0+=T0*u0, 0..10
	mla	r11, r1, r7, r11	// r1+=T0*u1, 0..10
	mla	r12, r1, r8, r12	// s0+=T0*v0, 0..10
	mla	r14, r1, r9, r14	// s1+=T0*v1, 0..10
	mla	r4, r1, r2, r4	// g0+=T0*f0, 0..10
	mla	r5, r1, r3, r5	// g1+=T0*f1, 0..10
	lsr	r4, r4, #8
	orr	r4, r4, r5, LSL #24
	bic	r1, r4, r0		// top 3b < 3
	and	r4, r4, r0		// bot 2b < 4
	add	r4, r4, r1, LSR #2	// range <=5
	usub8	r1, r4, r0		// >= 3 ?
	sel	r4, r1, r4		// select
	and	r1, r0, r5, LSR #8
	bic	r5, r5, r0
	add	r5, r1, r5, LSR #10
	usub8	r1, r5, r0		// >= 3 ?
	sel	r5, r1, r5		// select
	bic	r1, r10, r0		// top 3b < 3
	and	r10, r10, r0		// bot 2b < 4
	add	r10, r10, r1, LSR #2	// range <=5
	usub8	r1, r10, r0		// >= 3 ?
	sel	r10, r1, r10		// select
	bic	r1, r11, r0		// top 3b < 3
	and	r11, r11, r0		// bot 2b < 4
	add	r11, r11, r1, LSR #2	// range <=5
	usub8	r1, r11, r0		// >= 3 ?
	sel	r11, r1, r11		// select
	bic	r1, r12, r0		// top 3b < 3
	and	r12, r12, r0		// bot 2b < 4
	add	r12, r12, r1, LSR #2	// range <=5
	usub8	r1, r12, r0		// >= 3 ?
	sel	r12, r1, r12		// select
	bic	r1, r14, r0		// top 3b < 3
	and	r14, r14, r0		// bot 2b < 4
	add	r14, r14, r1, LSR #2	// range <=5
	usub8	r1, r14, r0		// >= 3 ?
	sel	r14, r1, r14		// select
	vcvt.s32.f32	s0, s0	// back to int
	vmov	r0, s0		// restore minusdelta
	pop	{r1}
	str	r3, [r1, #4]
	str	r4, [r1, #8]
	str	r5, [r1, #12]
	str	r6, [r1, #16]
	str	r7, [r1, #20]
	str	r8, [r1, #24]
	str	r9, [r1, #28]
	str	r10, [r1, #32]
	str	r11, [r1, #36]
	str	r12, [r1, #40]
	str	r14, [r1, #44] // 12th register
	str	r2, [r1], #48
	pop	{r4-r11,pc}
