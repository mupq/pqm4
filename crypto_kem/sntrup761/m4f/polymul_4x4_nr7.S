.p2align 2,,3	
.syntax	unified
.text

.global	polymul_4x4_nr7
.type 	polymul_4x4_nr7, %function
polymul_4x4_nr7:
	push 	{r3-r11,lr}
	ldr	r4, [r1]
	ldr	r5, [r1, #4]
	ldr	r6, [r2]
	ldr	r7, [r2, #4]
	ldr	r8, [r2, #2]		// [r8] = g12
	smulbb	r3, r4, r6		// r3 = f0 g0 = h0 (32bit)
	smuadx	r14, r4, r6		// r14 = f0 g1 + f1 g0 = h1 (32bit)
	smuadx	r10, r4, r7		// r10 = f0 g3 + f1 g2
	smulbb	r9, r5, r6		// r9 = f2 g0
	smladx	r10, r5, r6, r10	// r10 = h3 (32bit)
	smladx	r9, r4, r8, r9		// r9 = h2 (32bit)
	smultt	r6, r4, r7		// r6 = f1 g3
	smuadx	r4, r5, r7		// r4 = f2 g3 + f3 g2 = h5 (32bit)
	smultt	r7, r5, r7		// r7 = f3 g3 = h6 (32bit)
	smladx	r6, r5, r8, r6		// r6 = h4 (32bit)
	str	r3, [r0]		// h[0] = [r0] = h01
	str	r14, [r0, #4]		// h[0] = [r0+4] = h01
	str	r9, [r0, #8]		// h[1] = [r0+8] = h23
	str	r10, [r0, #12]		// h[1] = [r0+12] = h23
	str	r6, [r0, #16]
	str	r4, [r0, #20]
	str	r7, [r0, #24]
	pop	{r3-r11,pc}
