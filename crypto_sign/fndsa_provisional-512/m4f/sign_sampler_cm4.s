	.syntax	unified
	.cpu	cortex-m4
	.file	"sign_sampler_cm4.s"
	.text

@ =======================================================================
@ int32_t fndsa_gaussian0_helper(uint64_t lo, uint32_t hi)
@ =======================================================================

	.align	2
	.global	fndsa_gaussian0_helper
	.thumb
	.thumb_func
	.type	fndsa_gaussian0_helper, %function
fndsa_gaussian0_helper:
	push.w	{ r4, r5, r6, r7, r8 }

	adr.w	r12, fndsa_gaussian0_helper__gauss0_low

	@ 0 and 1
	ldm	r12!, { r4, r5, r6, r7 }
	subs	r8, r0, r4
	sbcs	r8, r1, r5
	sbcs	r8, r2, #163  @ high[0]
	lsr.w	r3, r8, #31
	subs	r8, r0, r6
	sbcs	r8, r1, r7
	sbcs	r8, r2, #84   @ high[1]
	add.w	r3, r3, r8, lsr #31

	@ 2 and 3
	ldm	r12!, { r4, r5, r6, r7 }
	subs	r8, r0, r4
	sbcs	r8, r1, r5
	sbcs	r8, r2, #34   @ high[2]
	add.w	r3, r3, r8, lsr #31
	subs	r8, r0, r6
	sbcs	r8, r1, r7
	sbcs	r8, r2, #10   @ high[3]
	add.w	r3, r3, r8, lsr #31

	@ 4 and 5
	ldm	r12!, { r4, r5, r6, r7 }
	subs	r8, r0, r4
	sbcs	r8, r1, r5
	sbcs	r8, r2, #2    @ high[4]
	add.w	r3, r3, r8, lsr #31
	subs	r8, r0, r6
	sbcs	r8, r1, r7
	sbcs	r8, r2, #0    @ high[5]
	add.w	r3, r3, r8, lsr #31

	@ 6 and 7
	ldm	r12!, { r4, r5, r6, r7 }
	subs	r8, r0, r4
	sbcs	r8, r1, r5
	sbcs	r8, r2, #0    @ high[6]
	add.w	r3, r3, r8, lsr #31
	subs	r8, r0, r6
	sbcs	r8, r1, r7
	sbcs	r8, r2, #0    @ high[7]
	add.w	r3, r3, r8, lsr #31

	@ 8 and 9
	ldm	r12!, { r4, r5, r6, r7 }
	subs	r8, r0, r4
	sbcs	r8, r1, r5
	sbcs	r8, r2, #0    @ high[8]
	add.w	r3, r3, r8, lsr #31
	subs	r8, r0, r6
	sbcs	r8, r1, r7
	sbcs	r8, r2, #0    @ high[9]
	add.w	r3, r3, r8, lsr #31

	@ 10, 11 and 12
	ldm	r12!, { r4, r5, r6, r7 }
	subs	r8, r0, r4
	sbcs	r8, r1, r5
	sbcs	r8, r2, #0    @ high[10]
	add.w	r3, r3, r8, lsr #31
	subs	r8, r0, r6
	sbcs	r8, r1, #148  @ mid[11]
	sbcs	r8, r2, #0    @ high[11]
	add.w	r3, r3, r8, lsr #31
	subs	r8, r0, r7
	sbcs	r8, r1, #3    @ mid[12]
	sbcs	r8, r2, #0    @ high[12]
	add.w	r3, r3, r8, lsr #31

	@ 13, 14, 15, 16
	ldm	r12!, { r4, r5, r6, r7 }
	subs	r8, r0, r4
	sbcs	r8, r1, #0    @ mid[13]
	sbcs	r8, r2, #0    @ high[13]
	add.w	r3, r3, r8, lsr #31
	subs	r8, r0, r5
	sbcs	r8, r1, #0    @ mid[14]
	sbcs	r8, r2, #0    @ high[14]
	add.w	r3, r3, r8, lsr #31
	subs	r8, r0, r6
	sbcs	r8, r1, #0    @ mid[15]
	sbcs	r8, r2, #0    @ high[15]
	add.w	r3, r3, r8, lsr #31
	subs	r8, r0, r7
	sbcs	r8, r1, #0    @ mid[16]
	sbcs	r8, r2, #0    @ high[16]
	add.w	r3, r3, r8, lsr #31

	@ 17
	ldr.w	r4, [r12]
	subs	r8, r0, r4
	sbcs	r8, r1, #0    @ mid[17]
	sbcs	r8, r2, #0    @ high[17]
	add.w	r3, r3, r8, lsr #31

	mov.w	r0, r3
	pop	{ r4, r5, r6, r7, r8 }
	bx	lr
	.align	3
fndsa_gaussian0_helper__gauss0_low:
	@ This is the RCDT table from the specification. Only the low 64 bits
	@ of each value are stored here; the high 8 bits are provided in
	@ comments but otherwise hardcoded in the instructions above.
	.word	2889422850, 4159975123  @ high: 163
	.word	1065212802, 3542816799  @ high:  84
	.word	1210696191, 2110640275  @ high:  34
	.word	3348712164, 3514123127  @ high:  10
	.word	4081000303, 2508483758  @ high:   2
	.word	3983850847, 2001389396  @ high:   0
	.word	 729246436,  270851412  @ high:   0
	.word	1705862106,   27394012  @ high:   0
	.word	2323342376,    2064600  @ high:   0
	.word	2986609769,     115709  @ high:   0
	.word	 617624059,       4815  @ high:   0
	@ Starting at value 11, we only store the low 32 bits.
	.word	2676689183  @ mid: 148    high:   0
	.word	1717414296  @ mid:   3    high:   0
	.word	 247426747  @ mid:   0    high:   0
	.word	   3104126  @ mid:   0    high:   0
	.word	     28824  @ mid:   0    high:   0
	.word	       198  @ mid:   0    high:   0
	.word	         1  @ mid:   0    high:   0
	.size	fndsa_gaussian0_helper,.-fndsa_gaussian0_helper
