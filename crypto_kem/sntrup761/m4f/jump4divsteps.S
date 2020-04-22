#include "red-asm.h"
	.p2align	2,,3	
	.syntax		unified
	.text
M2x2x2s:
	push	{lr}
	// first, new u = x u2 u1 + v2 r1
	smulbb	r2, r5, r9
	smuadx	r3, r5, r9
	smultt	r10, r5, r9
	smlabb	r3, r4, r8, r3
	smladx	r10, r4, r8, r10
	smultt	r11, r4, r8
	br_32x2	r2, r3, r12, r1, r14
	br_32x2	r10, r11, r12, r1, r14
	str	r10, [r0, #4]
	str	r2, [r0]
	// then new r = x r2 u1 + s2 r1
	smulbb	r2, r7, r9
	smuadx	r3, r7, r9
	smultt	r10, r7, r9
	smlabb	r3, r6, r8, r3
	smladx	r10, r6, r8, r10
	smultt	r11, r6, r8
	br_32x2	r2, r3, r12, r1, r14
	br_32x2	r10, r11, r12, r1, r14
	str	r10, [r0, #20]
	str	r2, [r0, #16]
	pop	{pc}
	.p2align	2,,3	
	.syntax		unified
	.text
M2x2x2_2:
	push	{lr}
	// first, new g = r f1 + s g1 + g0
	asr	r10, r3, #16
	sxth	r3, r3
	smlabb	r3, r6, r8, r3
	smladx	r10, r6, r8, r10
	smultt	r11, r6, r8
	smlabb	r3, r7, r9, r3
	smladx	r10, r7, r9, r10
	smlatt	r11, r7, r9, r11
	br_32x2	r3, r10, r12, r1, r14
	br_32	r11, r12, r1, r14
	uxth	r11, r11
	str	r3, [r0, #8]
	str	r11, [r0, #12]
	// then new f = x u f1 + x v g1 + f0
	asr	r3, r2, #16
	smlabb	r3, r4, r8, r3
	smuadx	r10, r4, r8
	smultt	r11, r4, r8
	smlabb	r3, r5, r9, r3
	smladx	r10, r5, r9, r10
	smlatt	r11, r5, r9, r11
	br_32x2	r10, r11, r12, r1, r14
	br_32	r3, r12, r1, r14
	pkhbt	r2, r2, r3, LSL #16
	str	r2, [r0]
	str	r10, [r0, #4]
	pop	{pc}
	.p2align	2,,3	
	.syntax		unified
	.text
jump2divsteps_sub:
	push	{lr}
	mov	r4, #1	// u
	mov	r5, #0	// v
	mov	r6, #0	// r
	mov	r7, #1	// s
jump2divsteps_t0:	// start of turn 0
	uxth	r10, r3
	tst	r10, r0, ASR #31
	itttt	ne
	movne	r10, r4	// r4<->r6
	movne	r4, r6
	movne	r6, r10
	movne	r10, r5	// r5<->r7
	itttt	ne
	movne	r5, r7
	movne	r7, r10
	movne	r10, r2	// r2<->r3
	movne	r2, r3
	itt	ne
	movne	r3, r10
	negne	r0, r0
jump2divsteps_t0_1:	// end of first half
	mov	r11, #0
	ssub16	r8, r11, r3	// r8 = -g
	sub	r0, r0, #1	// decrement minusdelta
	smlsdx	r3, r2, r3, r11	// (f(0) g - g(0) f) / x 
	br_32	r3, r12, r1, r11 //red. new g[0] % 4591, 32b
	uxth	r3, r3
	smulbb	r9, r8, r4	// - u[0] g[0]
	smlabb	r6, r2, r6, r9	// f[0] r[0] - g[0] u[0], 32bit
	smulbb	r9, r8, r5	// - v[0] g[0]
	smlabb	r7, r2, r7, r9	// f[0] s[0] - g[0] v[0], 32bit
	lsl	r4, r4, #16	// r4 was 0/1; shift
	lsl	r5, r5, #16	// r5 was 0/1; shift
	uxth	r6, r6		// r6 was reduced
	uxth	r7, r7		// r7 was reduced
jump2divsteps_t1:	// start of turn 1
	// top of r4(u)/r5(v): 0/1,  of r6(r)/r7(s): 0
	// start of first half, no need to reduce g[0]
	tst	r3, r0, ASR #31
	itttt	ne
	movne	r10, r4	// r4<->r6
	movne	r4, r6
	movne	r6, r10
	movne	r10, r5	// r5<->r7
	itttt	ne
	movne	r5, r7
	movne	r7, r10
	movne	r10, r2	// r2<->r3
	movne	r2, r3
	itt	ne
	movne	r3, r10
	negne	r0, r0
jump2divsteps_t1_1:	// end of first half
	mov	r11, #0
	sub	r0, r0, #1	// decrement minusdelta
	ssub16	r8, r11, r3	// r8 = -g
	smlsdx	r3, r2, r3, r11	// (f(0) g - g(0) f) / x 
	br_32	r3, r12, r1, r11 //red. new g[0] % 4591, 32b
	uxth	r3, r3
	smulbb	r9, r8, r4	// - u[0] g[0]
	smlabb	r9, r2, r6, r9	// new r[0] = f[0] r[0] - g[0] u[0], 32b
	br_32	r9, r12, r1, r11 //red. new r[0] % 4591, 32b
	smulbt	r11, r8, r4	// - u[1] g[0]
	smlabt	r11, r2, r6, r11// new r[1] = f[0] r[1] - g[0] u[1], 32b
	pkhbt	r6, r9, r11, LSL #16	// new r (new r[1] reduced)
	smulbb	r9, r8, r5	// - v[0] g[0]
	smlabb	r9, r2, r7, r9	// new s[0] = f[0] s[0] - g[0] v[0], 32b
	br_32	r9, r12, r1, r11 //red. new s[0] % 4591, 32b
	smulbt	r11, r8, r5	// - v[1] g[0]
	smlabt	r11, r2, r7, r11// new s[1] = f[0] s[1] - g[0] v[1], 32b
	pkhbt	r7, r9, r11, LSL #16	// new s (new s[1] reduced)
	// note, we don't shift u,v here
	pop	{pc}
	.p2align	2,,3	
	.syntax		unified
	.text
// void jump4divsteps (int minusdelta, int *M, int *f, int *g);
	.global jump4divsteps
	.type	jump4divsteps, %function
jump4divsteps:
	push	{r1-r11,lr}
	mov	r12, #4591	// load q
	movw	r1, #47521
	movt	r1, #65521
	vmov	s0, r1		// save q32inv
	sub	sp, sp, #64	// allocate 2x6+2x2 ints
	ldr	r2, [r2]	// f0
	ldr	r3, [r3]	// g0
	bl	jump2divsteps_sub
	vmov	s1, r0		// store minusdelta
	stm	sp, {r2-r7}	// matrix 1 is at sp
	ldr	r8, [sp, #68]	// load f pointer
	ldr	r9, [sp, #72]	// load g pointer
	ldr	r8, [r8, #4]	// f1
	ldr	r9, [r9, #4]	// g1
	add	r0, sp, #48	// load intermediate f,g pointer
	// compute [[x r4, x r5], [r6, r7]] * [r8, r9] + [r2, r3]
	bl	M2x2x2_2
	ldr	r3, [sp, #56]	// reload lower half of new g
	vmov	r0, s1		// reload minusdelta
	bl	jump2divsteps_sub
	vmov	s1, r0		// store minusdelta
	add	r14, sp, #24	// load matrix 2
	stm	r14, {r2-r7}
	ldr	r8, [sp, #52]	// reload top half of new f
	ldr	r9, [sp, #60]	// reload top half of new g
	ldr	r0, [sp, #64]	// reload matrix pointer
	bl	M2x2x2_2
	// remains to multiply M1 by M2
	ldr	r8, [sp, #8]	// reload u1
	ldr	r9, [sp, #16]	// reload r1
	add	r0, r0, #16
	bl	M2x2x2s
	ldr	r8, [sp, #12]	// reload v1
	ldr	r9, [sp, #20]	// reload s1
	add	r0, r0, #8
	bl	M2x2x2s
	add	sp, sp, #76	// deallocate temp storage + pop r1-3
	vmov	r0, s1		// reload minusdelta for return value
	pop	{r4-r11,pc}
	.p2align	2,,3	
	.syntax		unified
	.text
jump2divsteps_1_sub:
	push	{lr}
	mov	r4, #1	// u
	mov	r5, #0	// v
	mov	r6, #0	// r
	mov	r7, #1	// s
jump2divsteps_1_t0:	// start of turn 0
	uxth	r10, r3
	tst	r10, r0, ASR #31
	itttt	ne
	movne	r10, r4	// r4<->r6
	movne	r4, r6
	movne	r6, r10
	movne	r10, r5	// r5<->r7
	itttt	ne
	movne	r5, r7
	movne	r7, r10
	movne	r10, r2	// r2<->r3
	movne	r2, r3
	itt	ne
	movne	r3, r10
	negne	r0, r0
jump2divsteps_1_t0_1:	// end of first half
	mov	r11, #0
	ssub16	r8, r11, r3	// r8 = -g
	sub	r0, r0, #1	// decrement minusdelta
	smlsdx	r3, r2, r3, r11	// (f(0) g - g(0) f) / x 
	br_32	r3, r12, r1, r11 //red. new g[0] % 4591, 32b
	uxth	r3, r3
	smulbb	r9, r8, r4	// - u[0] g[0]
	smlabb	r6, r2, r6, r9	// f[0] r[0] - g[0] u[0], 32bit
	smulbb	r9, r8, r5	// - v[0] g[0]
	smlabb	r7, r2, r7, r9	// f[0] s[0] - g[0] v[0], 32bit
	lsl	r4, r4, #16	// r4 was 0/1; shift
	lsl	r5, r5, #16	// r5 was 0/1; shift
	lsl	r6, r6, #16	// r6 was reduced, shift
	lsl	r7, r7, #16	// r7 was reduced, shift
	pop	{pc}
 // note M1 redefined here
 // note M2 redefined here
 // note fg redefined here
 // note M redefined here
 // note pf redefined here
 // note pg redefined here
	.p2align	2,,3	
	.syntax		unified
	.text
// void jump4divsteps_3 (int minusdelta, int *M, int *f, int *g);
	.global jump4divsteps_3
	.type	jump4divsteps_3, %function
jump4divsteps_3:
	push	{r1-r11,lr}
	mov	r12, #4591	// load q
	movw	r1, #47521
	movt	r1, #65521
	vmov	s0, r1		// save q32inv
	sub	sp, sp, #64	// allocate 2x6+2x2 ints
	ldr	r2, [r2]	// f0
	ldr	r3, [r3]	// g0
	bl	jump2divsteps_sub
	vmov	s1, r0		// store minusdelta
	stm	sp, {r2-r7}	// matrix 1 is at sp
	ldr	r8, [sp, #68]	// load f pointer
	ldr	r9, [sp, #72]	// load g pointer
	ldr	r8, [r8, #4]	// f1
	ldr	r9, [r9, #4]	// g1
	add	r0, sp, #48	// load intermediate f,g pointer
	// compute [[x r4, x r5], [r6, r7]] * [r8, r9] + [r2, r3]
	bl	M2x2x2_2
	ldr	r3, [sp, #56]	// reload lower half of new g
	vmov	r0, s1		// reload minusdelta
	bl	jump2divsteps_1_sub
	vmov	s1, r0		// store minusdelta
	add	r14, sp, #24	// load matrix 2
	stm	r14, {r2-r7}
	ldr	r8, [sp, #52]	// reload top half of new f
	ldr	r9, [sp, #60]	// reload top half of new g
	ldr	r0, [sp, #64]	// reload matrix pointer
	bl	M2x2x2_2
	// remains to multiply M1 by M2
	ldr	r8, [sp, #8]	// reload u1
	ldr	r9, [sp, #16]	// reload r1
	add	r0, r0, #16
	bl	M2x2x2s
	ldr	r8, [sp, #12]	// reload v1
	ldr	r9, [sp, #20]	// reload s1
	add	r0, r0, #8
	bl	M2x2x2s
	add	sp, sp, #76	// deallocate temp storage + pop r1-3
	vmov	r0, s1		// reload minusdelta for return value
	pop	{r4-r11,pc}
	.p2align	2,,3	
	.syntax		unified
	.text
// void jump4divsteps_2 (int minusdelta, int *M, int *f, int *g);
	.global jump4divsteps_2
	.type	jump4divsteps_2, %function
jump4divsteps_2:
	push	{r1-r11,lr}
	mov	r12, #4591	// load q
	movw	r1, #47521
	movt	r1, #65521
	vmov	s0, r1		// save q32inv
	ldr	r2, [r2]	// f0
	ldr	r3, [r3]	// g0
	bl	jump2divsteps_sub
	vmov	s1, r0		// store minusdelta
	ldr	r8, [sp, #4]
	ldr	r9, [sp, #8]
	ldr	r8, [r8, #4]	// f1
	ldr	r9, [r9, #4]	// g1
	ldr	r0, [sp]
	// compute [[x r4, x r5], [r6, r7]] * [r8, r9] + [r2, r3]
	bl	M2x2x2_2
	str	r4, [r0, #20]
	str	r5, [r0, #28]
	str	r6, [r0, #36]
	str	r7, [r0, #44]
	mov	r1, #0
	str	r1, [r0, #16]
	str	r1, [r0, #24]
	str	r1, [r0, #32]
	str	r1, [r0, #40]
	vmov	r0, s1		// reload minusdelta for return value
	pop	{r1-r11,pc}
	.p2align	2,,3	
	.syntax		unified
	.text
// void jump4divsteps_1 (int minusdelta, int *M, int *f, int *g);
	.global jump4divsteps_1
	.type	jump4divsteps_1, %function
jump4divsteps_1:
	push	{r1-r11,lr}
	mov	r12, #4591	// load q
	movw	r1, #47521
	movt	r1, #65521
	vmov	s0, r1		// save q32inv
	ldr	r2, [r2]	// f0
	ldr	r3, [r3]	// g0
	bl	jump2divsteps_1_sub
	vmov	s1, r0		// store minusdelta
	ldr	r8, [sp, #4]
	ldr	r9, [sp, #8]
	ldr	r8, [r8, #4]	// f1
	ldr	r9, [r9, #4]	// g1
	ldr	r0, [sp]
	// compute [[x r4, x r5], [r6, r7]] * [r8, r9] + [r2, r3]
	bl	M2x2x2_2
	str	r4, [r0, #20]
	str	r5, [r0, #28]
	str	r6, [r0, #36]
	str	r7, [r0, #44]
	mov	r1, #0
	str	r1, [r0, #16]
	str	r1, [r0, #24]
	str	r1, [r0, #32]
	str	r1, [r0, #40]
	vmov	r0, s1		// reload minusdelta for return value
	pop	{r1-r11,pc}
