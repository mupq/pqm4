#include "params.h"
	
	// copy p from f(r0) to f_mod3(r1)
	// copy p from g(r2) to f_mod3(r3)
	// copy_p_F3_mod3(*small f, *small f_mod3, *small g, *small g_mod3);

	.p2align 2,,3	
	.syntax	unified
	.text
	.global	copy_p_F3_mod3
	.type 	copy_p_F3_mod3, %function
	
copy_p_F3_mod3:
	push	{r4-r8,lr}
	mov	r7, #238
	ldr	r8, =0x03030303
copy_p_F3_mod3_0:
	ldr	r4, [r0], #4
	ldr	r5, [r2], #4
	uadd8	r6, r4, r8
	sel	r4, r6, r4
	uadd8	r6, r5, r8
	sel	r5, r6, r5
	str	r4, [r1], #4
	str	r5, [r3], #4
	subs	r7, r7, #1
	bhi	copy_p_F3_mod3_0
copy_p_F3_mod3_1:
	ldrb	r4, [r0], #4
	ldrb	r5, [r2], #4
	uadd8	r6, r4, r8
	sel	r4, r6, r4
	uadd8	r6, r5, r8
	sel	r5, r6, r5
	str	r4, [r1]
	str	r5, [r3]
	str	r7, [r1, #4]
	str	r7, [r3, #4]
copy_p_F3_mod3_2:
	pop	{r4-r8,pc}
	

	// reduce_2p_minus1_mod3_F3(*small h, *small fg);
	// reduce modulo x^p - x - 1 from degree (2p-2) poly
	// fg[2p-1] = 0 because it is a result from a mult
	
	.p2align 2,,3	
	.syntax	unified
	.text
	.global	reduce_2p_minus1_mod3_F3
	.type 	reduce_2p_minus1_mod3_F3, %function

reduce_2p_minus1_mod3_F3:
	push	{r4-r5,r7-r9,lr}
	mov	r7, #238
	ldr	r9, =0x01010101
	add	r8, r9, r9, LSL #1 	// 0x03030303
	add	r2, r1, #953		// fg+761
	ldrb	r3, [r1], #1
	ldrb	r4, [r2]
	add	r3, r3, r4		// 0..4
	uadd8	r3, r3, r9		// 1..5
	usub8	r4, r3, r8		// -2..2
	sel	r3, r4, r3		// 0..2
	usub8	r3, r3, r9		// -1..1
	str	r3, [r0], #1
reduce_2p_minus1_mod3_F3_0:
	ldr	r3, [r1], #4		// fg[i]
	ldr	r4, [r2, #1]		// fg[i+760]
	ldr	r5, [r2], #4		// fg[i+761]
	uadd8	r3, r3, r4		// 0..4
	uadd8	r3, r3, r5		// 0..6
	uadd8	r3, r3, r9		// 1..7
	usub8	r4, r3, r8		// -2..4
	sel	r3, r4, r3		// 0..4
	usub8	r4, r3, r8		// -3..1
	sel	r3, r4, r3		// 0..2
	usub8	r3, r3, r9		// -1..1
	str	r3, [r0], #4		// h[i]
	subs	r7, r7, #1
	bhi	reduce_2p_minus1_mod3_F3_0
reduce_2p_minus1_mod3_F3_1:
	pop	{r4-r5,r7-r9,pc}
	
	
