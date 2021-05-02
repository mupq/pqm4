// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

	.cpu cortex-m4
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"shr_asm.c"
	.text
	.align	1
	.p2align 2,,3
	.global	shiftright_small_umlal
	.arch armv7e-m
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	shiftright_small_umlal, %function
shiftright_small_umlal:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #-1
	rsb	r1, r1, #32
	lsl	r1, r3, r1
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mvns	r1, r1
	ldr	r4, [r0, r2, lsl #2]
	adds	r6, r1, #1
	umull	r6, r4, r4, r6
	subs	r4, r2, #1
	cmp	r4, #3
	add	r3, r0, r2, lsl #2
	ble	.L2
	lsls	r5, r2, #2
	sub	r8, r2, #5
	sub	lr, r0, #16
	add	lr, lr, r5
	lsr	ip, r8, #2
	sub	lr, lr, ip, lsl #4
.L3:
	ldr	r2, [r3, #-4]
	ldr	r4, [r3, #-8]
	ldr	r5, [r3, #-12]
	ldr	r7, [r3, #-16]
	umlal	r2, r6, r1, r2
	umlal	r4, r2, r1, r4
	umlal	r5, r4, r1, r5
	umlal	r7, r5, r1, r7
	str	r6, [r3, #-4]
	str	r2, [r3, #-8]
	str	r4, [r3, #-12]
	str	r5, [r3, #-16]!
	cmp	r3, lr
	mov	r6, r7
	bne	.L3
	rsb	ip, ip, ip, lsl #30
	add	r4, r8, ip, lsl #2
.L4:
	mov	r2, r6
	ldr	r6, [r0, r4, lsl #2]
	mov	r5, r6
	umlal	r5, r2, r1, r6
	str	r2, [r0, r4, lsl #2]
	lsls	r3, r4, #2
	cbz	r4, .L5
	subs	r2, r3, #4
	cmp	r4, #1
	ldr	r6, [r0, r2]
	umlal	r6, r5, r1, r6
	str	r5, [r0, r2]
	sub	ip, r4, #2
	mov	r7, r6
	beq	.L5
	sub	r4, r3, #8
	ldr	r6, [r0, r4]
	mov	r2, r6
	umlal	r2, r7, r1, r6
	str	r7, [r0, r4]
	cmp	ip, #0
	beq	.L5
	subs	r3, r3, #12
	ldr	r6, [r0, r3]
	umlal	r6, r2, r1, r6
	str	r2, [r0, r3]
.L5:
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L2:
	cmp	r4, #0
	bge	.L4
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
	.size	shiftright_small_umlal, .-shiftright_small_umlal
	.ident	"GCC: (GNU Arm Embedded Toolchain 10-2020-q4-major) 10.2.1 20201103 (release)"
