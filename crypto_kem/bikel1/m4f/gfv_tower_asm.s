// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain


.syntax unified

//////////////////////////////////////////////////////////////// General Macros:

.macro m_eor4 a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3
	eor \a_0, \b_0
	eor \a_1, \b_1
	eor \a_2, \b_2
	eor \a_3, \b_3
.endm

//////////////////////////////////////////////////////////////// GF(4):

//computes c=a*b in GF(4),
//preserves the operands, uses 1 buffer register:
.macro m_gf4v_mul c_0, c_1, a_0, a_1, b_0, b_1, buf0
	and \c_0, \a_0, \b_0
	and \c_1, \a_1, \b_1
	eor \c_0, \c_0, \c_1	//c_0 done
	eor \c_1, \b_0, \b_1
	and \buf0, \a_1, \c_1
	and \c_1, \a_0, \b_1
	eor \c_1, \c_1, \buf0	//c_1 done
.endm

//computes c=a*b, b is scalar in GF(4)
//preserves the operands, uses 2 buffer register:
.macro m_gf4v_mulscalar c_0, c_1, a_0, a_1, b_, buf0, buf1
	and \buf0, \b_, #1	//b0
	lsr \buf1, \b_, #1
	and \buf1, \buf1, #1	//b1
	mul \c_0, \a_0, \buf0
	mul \c_1, \a_1, \buf1
	eor \c_0, \c_0, \c_1	//c_0
	eor \c_1, \buf1, \buf0
	mul \c_1, \c_1, \a_1
	mul \buf1, \a_0, \buf1
	eor \c_1, \c_1, \buf1	//c_1
.endm

//void gf4v_mul_2_asm( sto_t *c, const sto_t *a )
.global gf4v_mul_2_asm
gf4v_mul_2_asm:
	ldr r3, [r1] 		//load a0
	ldr r2, [r1, #4]	//load a1
	eor r3, r3, r2		//c1= a0 xor a1
	//stm r0, {r2, r3}
	str r2, [r0, #0]
	str r3, [r0, #4]
	bx lr

//void gf4v_mul_asm( sto_t *c, const sto_t *a , const sto_t *b)
.global gf4v_mul_asm
gf4v_mul_asm:
	push {r4-r5}
ptr_c	.req r0
ptr_a	.req r1
buf0	.req r1
ptr_b	.req r2
buf1	.req r2
a_0		.req r3
a_1		.req r4
buf2	.req r4
b_0		.req r5
b_1		.req r12
	//ldm ptr_a, {a_0, a_1}
	//ldm ptr_b, {b_0, b_1}
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	ldr b_0, [ptr_b, #0]
	ldr b_1, [ptr_b, #4]
	and buf0, a_0, b_0
	and buf1, a_1, b_1
	eor buf0, buf0, buf1	//c_0
	eor buf1, b_0, b_1
	and a_1, a_1, buf1
	and buf1, a_0, b_1
	eor buf1, buf1, buf2	//c_1
	//stm ptr_c, {buf0, buf1}
	str buf0, [ptr_c, #0]
	str buf1, [ptr_c, #4]
.unreq a_1
.unreq ptr_a
.unreq ptr_b
.unreq ptr_c
.unreq buf0
.unreq buf1
.unreq a_0
.unreq buf2
.unreq b_0
.unreq b_1
	pop {r4-r5}
	bx lr

//void gf4v_mulscalar_asm( sto_t *c, const sto_t *a , uint8_t b)
.global gf4v_mulscalar_asm
gf4v_mulscalar_asm:
	push {r4-r5}
ptr_c	.req r0
ptr_a	.req r1
b0		.req r1
b_		.req r2
b1		.req r2
a_0		.req r3
a_1		.req r4
buf2	.req r4
buf0	.req r5
buf1	.req r12
	//ldm ptr_a, {a_0, a_1}
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	and b0, b_, #1
	lsr b_, b_, #1
	and b_, b_, #1
	mul buf0, a_0, b0
	mul buf1, a_1, b1
	eor buf0, buf0, buf1	//c_0
	eor buf1, b1, b0
	mul buf1, buf1, a_1
	mul buf2, a_0, b1
	eor buf1, buf1, buf2	//c_1
	//stm ptr_c, {buf0, buf1}
	str buf0, [ptr_c, #0]
	str buf1, [ptr_c, #4]
.unreq ptr_a
.unreq ptr_c
.unreq buf0
.unreq buf1
.unreq b_
.unreq a_0
.unreq a_1
.unreq buf2
.unreq b0
.unreq b1
	pop {r4-r5}
	bx lr


//////////////////////////////////////////////////////////////// GF(16):

//computes c=a*b in GF(16)
//does not preserve the operands, uses 1 buffer register
.macro m_gf16v_mul c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3, buf0
	m_gf4v_mul \c_0, \c_1, \a_0, \a_1, \b_0, \b_1, \buf0
	eor \a_0, \a_0, \a_2
	eor \a_1, \a_1, \a_3
	eor \b_0, \b_0, \b_2
	eor \b_1, \b_1, \b_3
	m_gf4v_mul \c_2, \c_3, \a_0, \a_1, \b_0, \b_1, \buf0
	m_gf4v_mul \b_0, \b_1, \a_2, \a_3, \b_2, \b_3, \buf0
	eor \c_2, \c_2, \c_0
	eor \c_3, \c_3, \c_1
	eor \a_1, \b_0, \b_1
	eor \c_0, \c_0, \b_1
	eor \c_1, \c_1, \a_1
.endm

//computes c=a*b, b is scalar in GF(16)
//only preserves b_, uses 3 buffer registers
.macro m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	eor \buf0, \a_0, \a_2
	eor \buf1, \a_1, \a_3
	m_gf4v_mulscalar \c_0, \c_1, \a_0, \a_1, \b_, \c_2, \c_3
	eor \buf2, \b_, \b_, lsr #2
	m_gf4v_mulscalar \a_0, \a_1, \buf0, \buf1, \buf2, \c_2, \c_3
	eor \buf2, \b_, \buf2
	m_gf4v_mulscalar \buf0, \buf1, \a_2, \a_3, \buf2, \c_2, \c_3
	eor \c_2, \a_0, \c_0
	eor \c_3, \a_1, \c_1
	eor \c_0, \c_0, \buf1
	eor \buf0, \buf0, \buf1
	eor \c_1, \c_1, \buf0
.endm

//void gf16v_mul_asm( sto_t *c, const sto_t *a , const sto_t *b )
// does not preserve pointers, uses all registers
.global gf16v_mul_asm
gf16v_mul_asm:
	push {r4-r11, lr}
ptr_c	.req r0
ptr_a	.req r1
c_0		.req r1
ptr_b	.req r2
c_1		.req r2
a_0		.req r3
a_1		.req r4
a_2		.req r5
a_3		.req r6
b_0		.req r7
b_1		.req r8
b_2		.req r9
b_3		.req r10
c_2		.req r11
c_3		.req r12
buf0	.req r14
	//ldm ptr_a, {a_0-a_3}
	//ldm ptr_b, {b_0-b_3}
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	ldr a_2, [ptr_a, #8]
	ldr a_3, [ptr_a, #12]
	ldr b_0, [ptr_b, #0]
	ldr b_1, [ptr_b, #4]
	ldr b_2, [ptr_b, #8]
	ldr b_3, [ptr_b, #12]
	m_gf16v_mul c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3, buf0
	//stm ptr_c, {c_0, c_1, c_2, c_3}
	str c_0, [ptr_c, #0]
	str c_1, [ptr_c, #4]
	str c_2, [ptr_c, #8]
	str c_3, [ptr_c, #12]
.unreq ptr_c
.unreq ptr_a
.unreq c_0
.unreq ptr_b
.unreq c_1
.unreq a_0
.unreq a_1
.unreq a_2
.unreq a_3
.unreq b_0
.unreq b_1
.unreq b_2
.unreq b_3
.unreq c_2
.unreq c_3
.unreq buf0
	pop {r4-r11, pc}

// void gf16v_mulscalar_asm( sto_t *c, const sto_t *a , uint8_t b )
// preserves pointers, uses all registers
.global gf16v_mulscalar_asm
gf16v_mulscalar_asm:
	push {r4-r11, lr}
ptr_c	.req r0
ptr_a	.req r1
b_		.req r2
a_0		.req r3
a_1		.req r4
a_2		.req r5
a_3		.req r6
c_0		.req r7
c_1		.req r8
c_2		.req r9
c_3		.req r10
buf0	.req r11
buf1	.req r12
buf2	.req r14
	ldm ptr_a, {a_0-a_3}
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	//stm ptr_c, {c_0-c_3}
	str c_0, [ptr_c, #0]
	str c_1, [ptr_c, #4]
	str c_2, [ptr_c, #8]
	str c_3, [ptr_c, #12]
.unreq ptr_c
.unreq ptr_a
.unreq b_
.unreq a_0
.unreq a_1
.unreq a_2
.unreq a_3
.unreq c_0
.unreq c_1
.unreq c_2
.unreq c_3
.unreq buf0
.unreq buf1
.unreq buf2
	pop {r4-r11, pc}

//void gf16v_mul_0x4_asm( sto_t *c, const sto_t *a )
//does not preserve pointer a, uses only caller-saved registers
.global gf16v_mul_0x4_asm
gf16v_mul_0x4_asm:
ptr_c	.req r0
ptr_a	.req r1
c_0		.req r1
c_1		.req r2
c_2		.req r3
c_3		.req r12
	ldr c_1, [ptr_a, #8]	//a_2
	ldr c_2, [ptr_a, #0]	//a_0
	ldr c_3, [ptr_a, #4]	//a_1
	ldr ptr_a, [ptr_a, #12]	//a_3
	eor	c_3, c_3, c_0
	eor c_2, c_2, c_1
	eor c_1, c_1, c_0
	//stm ptr_c, {c_0, c_1, c_2, c_3}
	str c_0, [ptr_c, #0]
	str c_1, [ptr_c, #4]
	str c_2, [ptr_c, #8]
	str c_3, [ptr_c, #12]
.unreq ptr_c
.unreq ptr_a
.unreq c_0
.unreq c_1
.unreq c_2
.unreq c_3
	bx lr

//void gf16v_mul_0x5_asm( sto_t *c, const sto_t *a )
//does not preserve pointer a, uses only caller-saved registers
.global gf16v_mul_0x5_asm
gf16v_mul_0x5_asm:
ptr_c	.req r0
ptr_a	.req r1
c_0		.req r1
c_1		.req r2
c_2		.req r3
c_3		.req r12
	ldr c_1, [ptr_a, #8]	//a_2
	ldr c_2, [ptr_a, #0]	//a_0
	ldr c_3, [ptr_a, #4]	//a_1
	ldr ptr_a, [ptr_a, #12]	//a_3
	eor c_1, c_1, c_0
	eor c_1, c_1, c_3
	eor c_0, c_0, c_2
	//stm ptr_c, {c_0, c_1, c_2, c_3}
	str c_0, [ptr_c, #0]
	str c_1, [ptr_c, #4]
	str c_2, [ptr_c, #8]
	str c_3, [ptr_c, #12]
.unreq ptr_c
.unreq ptr_a
.unreq c_0
.unreq c_1
.unreq c_2
.unreq c_3
	bx lr

//void gf16v_mul_8_asm( sto_t *c, const sto_t *a )
//does not preserve pointer a, uses only caller-saved registers
.global gf16v_mul_8_asm
gf16v_mul_8_asm:
ptr_c	.req r0
ptr_a	.req r1
c_0		.req r1
c_1		.req r2
c_2		.req r3
c_3		.req r12
	ldr c_1, [ptr_a, #8]	//a_2
	ldr c_2, [ptr_a, #4]	//a_1
	ldr c_3, [ptr_a, #0]	//a_0
	ldr ptr_a, [ptr_a, #12]	//a_3
	eor c_3, c_3, c_2
	eor c_2, c_2, c_0
	eor c_0, c_0, c_1
	eor c_3, c_3, c_0
	//stm ptr_c, {c_0, c_1, c_2, c_3}
	str c_0, [ptr_c, #0]
	str c_1, [ptr_c, #4]
	str c_2, [ptr_c, #8]
	str c_3, [ptr_c, #12]
.unreq ptr_c
.unreq ptr_a
.unreq c_0
.unreq c_1
.unreq c_2
.unreq c_3
	bx lr

//////////////////////////////////////////////////////////////// GF(256):

//computes c=a*0x80 in GF(256)
//does not load and not store
.macro m_gf256v_mul_0x80 c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	eor \c_7, \c_6
	eor \c_6, \c_4
	eor \c_4, \c_5
	eor \c_7, \c_4
	eor \c_0, \c_1
	eor \c_1, \c_3
	eor \c_3, \c_2
	eor \c_0, \c_3
	eor \c_4, \c_3
	eor \c_5, \c_2
	eor \c_6, \c_1
	eor \c_7, \c_0
	eor \c_3, \c_2
	eor \c_2, \c_0
	eor \c_0, \c_1
	eor \c_3, \c_0
.endm

//computes c=a*0x80 in GF(256)
//does load, does not store
.macro m_gf256v_mul_0x80_load ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	ldr \c_7, [\ptr_a, #0]
	ldr \c_6, [\ptr_a, #4]
	ldr \c_5, [\ptr_a, #8]
	ldr \c_4, [\ptr_a, #12]
	ldr \c_0, [\ptr_a, #16]
	ldr \c_1, [\ptr_a, #20]
	ldr \c_2, [\ptr_a, #24]
	ldr \c_3, [\ptr_a, #28]
	m_gf256v_mul_0x80 \c_0, \c_1, \c_2, \c_3, \c_4, \c_5, \c_6, \c_7
.endm

//computes c=a*b in GF(256), b is scalar
//does load and store
//uses s0-s4
.macro m_gf256v_mulscalar_asm
ptr_c	.req r0
ptr_a	.req r1
b_		.req r2
a_0		.req r3
a_1		.req r4
a_2		.req r5
a_3		.req r6
c_0		.req r7
c_1		.req r8
c_2		.req r9
c_3		.req r10
buf0	.req r11
buf1	.req r12
buf2	.req r14
	ldm ptr_a, {a_0, a_1, a_2, a_3, c_0, c_1, c_2, c_3}
	eor c_0, c_0, a_0
	eor c_1, c_1, a_1
	eor c_2, c_2, a_2
	eor c_3, c_3, a_3
	vmov s0, c_0	//c1_0
	vmov s1, c_1	//c1_1
	vmov s2, c_2	//c1_2
	vmov s3, c_3	//c1_3
	// gf16v_mulscalar( c , a , b ):
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	vmov a_0, s0	//c1_0
	vmov a_1, s1	//c1_1
	vmov a_2, s2	//c1_2
	vmov a_3, s3	//c1_3
	vmov s0, c_0
	vmov s1, c_1
	vmov s2, c_2
	vmov s3, c_3
	vmov s4, b_
	eor b_, b_, b_, lsr #4 //b2
	//gf16v_mulscalar( c+4 , c1 , b2 ):
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	vmov a_0, s0	//c_0
	vmov a_1, s1	//c_1
	vmov a_2, s2	//c_2
	vmov a_3, s3	//c_3
	eor c_0, c_0, a_0
	eor c_1, c_1, a_1
	eor c_2, c_2, a_2
	eor c_3, c_3, a_3
	str c_0, [ptr_c, #16]	//c_4
	str c_1, [ptr_c, #20]	//c_5
	str c_2, [ptr_c, #24]	//c_6
	str c_3, [ptr_c, #28]	//c_7
	ldr a_0, [ptr_a, #16]	//a_4
	ldr a_1, [ptr_a, #20]	//a_5
	ldr a_2, [ptr_a, #24]	//a_6
	ldr a_3, [ptr_a, #28]	//a_7
	vmov buf0, s4	//b2
	eor b_, b_, buf0
	//gf16v_mulscalar( c3 , a+4 , b2^b):
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	vmov a_0, s0	//c_0
	vmov a_1, s1	//c_1
	vmov a_2, s2	//c_2
	vmov a_3, s3	//c_3
	eor c_0, c_0, c_1
	eor c_1, c_1, c_3		//c4_2
	eor c_3, c_3, c_2		//c4_0
	eor	c_0, c_0, c_3		//c4_3
	//c_2 = c4_1
	eor a_0, a_0, c_3
	eor a_1, a_1, c_2
	eor a_2, a_2, c_1
	eor a_3, a_3, c_0
	//stm ptr_c, {a_0-a_3}
	str a_0, [ptr_c, #0]
	str a_1, [ptr_c, #4]
	str a_2, [ptr_c, #8]
	str a_3, [ptr_c, #12]
.unreq ptr_c
.unreq ptr_a
.unreq b_
.unreq a_0
.unreq a_1
.unreq a_2
.unreq a_3
.unreq c_0
.unreq c_1
.unreq c_2
.unreq c_3
.unreq buf0
.unreq buf1
.unreq buf2
.endm

//computes c=a*b in GF(256)
//does load and store
//uses s0-s9
.macro m_gf256v_mul
	vmov s0, r1
	vmov s1, r2
	ldm r1, {r3-r6}
	ldr r11, [r1, #20]	//a_5
	ldr r12, [r1, #24]	//a_6
	ldr r14, [r1, #28]	//a_7
	ldr r1, [r1, #16]	//a_4
	eor r1, r1, r3		//c1_0
	eor r11, r11, r4	//c1_1
	eor r12, r12, r5	//c1_2
	eor r14, r14, r6	//c1_3
	vmov s2, r1
	vmov s3, r11
	vmov s4, r12
	vmov s5, r14
	ldm r2, {r7-r10}
	ldr r1, [r2, #16]	//b_4
	ldr r11, [r2, #20]	//b_5
	ldr r12, [r2, #24]	//b_6
	ldr r14, [r2, #28]	//b_7
	eor r1, r1, r7		//c2_0
	eor r11, r11, r8	//c2_1
	eor r12, r12, r9	//c2_2
	eor r14, r14, r10	//c2_3
	vmov s6, r1
	vmov s7, r11
	vmov s8, r12
	vmov s9, r14
	// gf16v_mul( c , a , b ):
	m_gf16v_mul r1, r11, r12, r14, r3, r4, r5, r6, r7, r8, r9, r10, r2
	vmov r7, s2
	vmov r8, s3
	vmov r9, s4
	vmov r10, s5
	vmov s2, r1		//c0
	vmov s3, r11	//c1
	vmov s4, r12	//c2
	vmov s5, r14	//c3
	vmov r3, s6
	vmov r4, s7
	vmov r5, s8
	vmov r6, s9
	// gf16v_mul( c+4 , c1 , c2 ):
	m_gf16v_mul r1, r11, r12, r14, r3, r4, r5, r6, r7, r8, r9, r10, r2
	vmov r3, s2		//c0
	vmov r4, s3		//c1
	vmov r5, s4		//c2
	vmov r6, s5		//c3
	eor r1, r1, r3
	eor r11, r11, r4
	eor r12, r12, r5
	eor r14, r14, r6
	str r1, [r0, #16]	//c4
	str r11, [r0, #20]	//c5
	str r12, [r0, #24]	//c6
	str r14, [r0, #28]	//c7
	vmov r1, s0
	vmov r2, s1
	ldr r3, [r1, #16]	//a4
	ldr r4, [r1, #20]	//a5
	ldr r5, [r1, #24]	//a6
	ldr r6, [r1, #28]	//a7
	ldr r7, [r2, #16]	//b4
	ldr r8, [r2, #20]	//b5
	ldr r9, [r2, #24]	//b6
	ldr r10, [r2, #28]	//b7
	//gf16v_mul( c3 , a+4 , b+4 ):
	m_gf16v_mul r1, r11, r12, r14, r3, r4, r5, r6, r7, r8, r9, r10, r2
	eor r1, r1, r11
	eor r11, r11, r14	//c4_2
	eor r14, r14, r12	//c4_0
	eor	r1, r1, r14		//c4_3
	//r12 = c4_1
	vmov r3, s2			//c0
	vmov r4, s3			//c1
	vmov r5, s4			//c2
	vmov r6, s5			//c3
	eor r3, r3, r14
	eor r4, r4, r12
	eor r5, r5, r11
	eor r6, r6, r1
	//stm r0, {r3-r6}
	str r3, [r0, #0]
	str r4, [r0, #4]
	str r5, [r0, #8]
	str r6, [r0, #12]
.endm

//void void gf256v_mul_asm( sto_t *c, const sto_t *a , const sto_t *b )
.global gf256v_mul_asm
gf256v_mul_asm:
	push {r4-r11, lr}
	m_gf256v_mul
	pop {r4-r11, pc}

//void gf256v_mulscalar_asm( sto_t *c, const sto_t *a , uint8_t b )
.global gf256v_mulscalar_asm
gf256v_mulscalar_asm:
	push {r4-r11, lr}
	m_gf256v_mulscalar_asm
	pop {r4-r11, pc}

//void gf256v_mul_0x80_asm( sto_t *c, const sto_t *a)
.global gf256v_mul_0x80_asm
gf256v_mul_0x80_asm:
	push {r4, r5, r10, r11, lr}
ptr_c	.req r0
ptr_a	.req r1
c_0		.req r2
c_1		.req r3
c_2		.req r4
c_3		.req r5
c_4		.req r10
c_5		.req r11
c_6		.req r12
c_7		.req r14
	m_gf256v_mul_0x80_load ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	stm ptr_c, {c_0-c_3, c_4, c_5, c_6, c_7}
	pop {r4, r5, r10, r11, pc}
.unreq ptr_c
.unreq ptr_a
.unreq c_0
.unreq c_1
.unreq c_2
.unreq c_3
.unreq c_4
.unreq c_5
.unreq c_6
.unreq c_7

//////////////////////////////////////////////////////////////// GF(2^16):

//computes c=a*0x8000 in GF(2^16)
// does load and store
// uses s0-s3
.macro m_gf216v_mul_0x8000
	add r1, #32
	m_gf256v_mul_0x80_load r1, r2, r3, r4, r5, r6, r7, r8, r9
	vmov s0, r2
	vmov s1, r3
	vmov s2, r4
	vmov s3, r5
	sub r1, #32
	m_gf256v_mul_0x80_load r1, r2, r3, r4, r5, r10, r11, r12, r14
	eor r10, r6
	eor r11, r7
	eor r12, r8
	eor r14, r9
	add r0, #48
	stm r0, {r10, r11, r12, r14}
	vmov r10, s3
	vmov r11, s2
	vmov r12, s1
	vmov r14, s0
	eor r2, r14
	eor r3, r12
	eor r4, r11
	eor r5, r10
	sub r0, #16
	stm r0, {r2-r5}
	m_gf256v_mul_0x80 r6, r7, r8, r9, r10, r11, r12, r14
	sub r0, #32
	stm r0, {r6-r12, r14}
.endm

//computes c=a*b in GF(2^16)
//does load and store
//uses s0-s14
.macro m_gf216v_mul
	sub sp, #32 //c1
	mov r11, sp
	sub sp, #32 //c2
	mov r12, sp
	vmov s10, r0
	vmov s11, r1
	vmov s12, r2
	vmov s13, r11
	vmov s14, r12
	ldm r1!, {r3-r10} //a[8]
	ldm r1!, {r0, r11, r12, r14}
	m_eor4 r3, r4, r5, r6, r0, r11, r12, r14
	ldm r1!, {r0, r11, r12, r14}
	m_eor4 r7, r8, r9, r10, r0, r11, r12, r14
	vmov r0, s13		//ptr_c1
	stm r0, {r3-r10}	//c1[8]

	ldm r2!, {r3-r10} //b[8]
	ldm r2!, {r0, r11, r12, r14}
	m_eor4 r3, r4, r5, r6, r0, r11, r12, r14
	ldm r2!, {r0, r11, r12, r14}
	m_eor4 r7, r8, r9, r10, r0, r11, r12, r14
	vmov r0, s14		//ptr_c2
	stm r0, {r3-r10}	//c2[8]

	vmov r0, s10	//ptr_c
	vmov r1, s11	//ptr_a
	vmov r2, s12	//ptr_b
	m_gf256v_mul
	add r0, #32	//ptr_c+8
	vmov r1, s13	//ptr_c1
	vmov r2, s14	//ptr_c2
	m_gf256v_mul
	vmov r1, s10		//ptr_c
	mov r2, r0	//ptr_c+8
	ldm r2, {r3-r10} //c+8[8]
	ldm r1!, {r0, r11, r12, r14} //c0-c3
	m_eor4 r3, r4, r5, r6, r0, r11, r12, r14
	ldm r1!, {r0, r11, r12, r14} //c4-c7
	m_eor4 r7, r8, r9, r10, r0, r11, r12, r14
	stm r2, {r3-r10}	//c+8[8]

	vmov r0, s14	//ptr_c2
	vmov r1, s11
	add r1, #32	//ptr_a+8
	vmov r2, s12
	add r2, #32	//ptr_b+8
	m_gf256v_mul
	vmov r1, s14	//ptr_c2
	m_gf256v_mul_0x80_load r1, r3 r4, r5, r6, r7, r8, r9, r10
	vmov r2, s10	//ptr_c
	ldm r2, {r0, r11, r12, r14}	//c_0-c_3
	m_eor4 r0, r11, r12, r14, r3, r4, r5, r6
	stm r2, {r0, r11, r12, r14}	//c_0-c_3
	add r2, #16
	ldm r2, {r0, r11, r12, r14}	//c_4-c_7
	m_eor4 r0, r11, r12, r14, r7, r8, r9, r10
	stm r2, {r0, r11, r12, r14}	//c_4-c_7
	add sp, #64
.endm

//void gf216v_mul( sto_t *c, const sto_t *a , const sto_t *b )
.global gf216v_mul_asm
gf216v_mul_asm:
	push {r4-r11, lr}
	m_gf216v_mul
	pop {r4-r11, pc}

//void void gf216v_mul_0x8000_asm( sto_t *c, const sto_t *a )
.global gf216v_mul_0x8000_asm
gf216v_mul_0x8000_asm:
	push {r4-r11, lr}
	m_gf216v_mul_0x8000
	pop {r4-r11, pc}


//////////////////////////////////////////////////////////////// GF(2^32):

// void gf232v_mul_0x2 loop body
// does load and store
.macro m_gf232v_mul_0x2_body ptr_c, ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	ldr \c_1, [\ptr_a], #4	//a0
	ldr \c_0, [\ptr_a], #4	//a1
	ldr \c_3, [\ptr_a], #4	//a2
	ldr \c_2, [\ptr_a], #4	//a3
	ldr \c_5, [\ptr_a], #4	//a4
	ldr \c_4, [\ptr_a], #4	//a5
	ldr \c_7, [\ptr_a], #4	//a6
	ldr \c_6, [\ptr_a], #4	//a7
	eor c_1, c_0
	eor c_3, c_2
	eor c_5, c_4
	eor c_7, c_6
	stm ptr_c, {c_0, c_1, c_2, c_3, c_4, c_5, c_6, c_7}
.endm

// void gf232v_mul_0x5 loop body
// does load and store
.macro m_gf232v_mul_0x5_body ptr_c, ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	ldr \c_2, [\ptr_a], #4	//a0
	ldr \c_3, [\ptr_a], #4	//a1
	ldr \c_1, [\ptr_a], #4	//a2
	ldr \c_0, [\ptr_a], #4	//a3
	ldr \c_6, [\ptr_a], #4	//a4
	ldr \c_7, [\ptr_a], #4	//a5
	ldr \c_5, [\ptr_a], #4	//a6
	ldr \c_4, [\ptr_a], #4	//a7
	eor c_1, c_0
	eor c_1, c_3
	eor c_0, c_2
	eor c_5, c_4
	eor c_5, c_7
	eor c_4, c_6
	stm ptr_c, {c_0, c_1, c_2, c_3, c_4, c_5, c_6, c_7}
.endm

.macro m_gf232v_mul_asm
ptr_c	.req r0
buf0	.req r0
ptr_a	.req r1
ptr_b	.req r2
a_0		.req r3
a_1		.req r4
a_2		.req r5
a_3		.req r6
b_0		.req r7
b_1		.req r8
b_2		.req r9
b_3		.req r10
buf1	.req r11
buf2	.req r12
buf3	.req r14
	sub sp, #64 //c1
	mov buf1, sp
	sub sp, #64 //c2
	mov buf2, sp
	vmov s15, ptr_c
	vmov s16, ptr_a
	vmov s17, ptr_b
	vmov s18, buf1
	vmov s19, buf2

	vmov ptr_b, s18		//ptr_c1
	ldm ptr_a, {a_0-b_3}
	add ptr_a, #64	//ptr_a+16
	ldm ptr_a!, {buf0, buf1, buf2, buf3} //ptr_a+20
	m_eor4 a_0, a_1, a_2, a_3, buf0, buf1, buf2, buf3
	ldm ptr_a!, {buf0, buf1, buf2, buf3} //ptr_a+24
	m_eor4 b_0, b_1, b_2, b_3, buf0, buf1, buf2, buf3
	stm ptr_b!, {a_0-b_3}	//c1[8]
	sub ptr_a, #64	//ptr_a+8
	ldm ptr_a, {a_0-b_3}
	add ptr_a, #64	//ptr_a+24
	ldm ptr_a!, {buf0, buf1, buf2, buf3}
	m_eor4 a_0, a_1, a_2, a_3, buf0, buf1, buf2, buf3
	ldm ptr_a!, {buf0, buf1, buf2, buf3}
	m_eor4 b_0, b_1, b_2, b_3, buf0, buf1, buf2, buf3
	stm ptr_b!, {a_0-b_3}	//c1+8[8]

	vmov ptr_b, s17 	//ptr_b
	vmov ptr_a, s19		//ptr_c2
	ldm ptr_b, {a_0-b_3}
	add ptr_b, #64	//ptr_b+16
	ldm ptr_b!, {buf0, buf1, buf2,  buf3}
	m_eor4 a_0, a_1, a_2, a_3, buf0, buf1, buf2, buf3
	ldm ptr_b!, {buf0, buf1, buf2,  buf3}
	m_eor4 b_0, b_1, b_2, b_3, buf0, buf1, buf2, buf3
	stm ptr_a!, {a_0-b_3}	//c2[8]
	sub ptr_b, #64	//ptr_b+8
	ldm ptr_b, {a_0-b_3}
	add ptr_b, #64	//ptr_b+24
	ldm ptr_b!, {buf0, buf1, buf2,  buf3}
	m_eor4 a_0, a_1, a_2, a_3, buf0, buf1, buf2, buf3
	ldm ptr_b!, {buf0, buf1, buf2,  buf3}
	m_eor4 b_0, b_1, b_2, b_3, buf0, buf1, buf2, buf3
	stm ptr_a!, {a_0-b_3}	//c2+8[8]

	vmov ptr_c, s15	//ptr_c
	vmov ptr_a, s16	//ptr_a
	vmov ptr_b, s17 //ptr_b
	m_gf216v_mul
	vmov ptr_c, s15	//ptr_c
	add ptr_c, #64	//ptr_c+16
	vmov ptr_a, s18	//ptr_c1
	vmov ptr_b, s19	//ptr_c2
	m_gf216v_mul

	vmov ptr_a, s15		//ptr_c
	vmov ptr_b, s15
	add ptr_b, #64		//ptr_c+16
	ldm ptr_b, {a_0-b_3} //c+16[8]
	ldm ptr_a!, {buf0, buf1, buf2, buf3}	//c0-c3
	m_eor4 a_0, a_1, a_2, a_3, buf0, buf1, buf2, buf3
	ldm ptr_a!, {buf0, buf1, buf2, buf3}	//c4-c7
	m_eor4 b_0, b_1, b_2, b_3, buf0, buf1, buf2, buf3
	stm ptr_b!, {a_0-b_3}	//c+16[8]
	ldm ptr_b, {a_0-b_3} 	//c+32[8]
	ldm ptr_a!, {buf0, buf1, buf2, buf3}	//c8-c11
	m_eor4 a_0, a_1, a_2, a_3, buf0, buf1, buf2, buf3
	ldm ptr_a!, {buf0, buf1, buf2, buf3}	//c12-c15
	m_eor4 b_0, b_1, b_2, b_3, buf0, buf1, buf2, buf3
	stm ptr_b!, {a_0-b_3}	//c+32[8]

	vmov ptr_c, s19	//ptr_c2
	vmov ptr_a, s16	//ptr_a
	add ptr_a, #64	//ptr_a+16
	vmov ptr_b, s17	//ptr_b
	add ptr_b, #64	//ptr_b+16
	m_gf216v_mul
	vmov ptr_c, s18	//ptr_c1
	vmov ptr_a, s19	//ptr_c2
	m_gf216v_mul_0x8000

	vmov ptr_a, s18 //ptr_c1
	vmov ptr_b, s15	//ptr_c
	ldm ptr_a!, {a_0-b_3}	//c1[8]
	ldm ptr_b, {buf0, buf1, buf2, buf3}	//c_0-c_3
	m_eor4 buf0, buf1, buf2, buf3, a_0, a_1, a_2, a_3
	stm ptr_b!, {buf0, buf1, buf2, buf3}//c_0-c_3
	ldm ptr_b, {buf0, buf1, buf2, buf3}	//c_4-c_7
	m_eor4 buf0, buf1, buf2, buf3, b_0, b_1, b_2, b_3
	stm ptr_b!, {buf0, buf1, buf2, buf3} //c_4-c_7

	ldm ptr_a, {a_0-b_3}	//c1+8[8]
	ldm ptr_b, {buf0, buf1, buf2, buf3}	//c_8-c_11
	m_eor4 buf0, buf1, buf2, buf3, a_0, a_1, a_2, a_3
	stm ptr_b!, {buf0, buf1, buf2, buf3}//c_8-c_11
	ldm ptr_b, {buf0, buf1, buf2, buf3}	//c_12-c_15
	m_eor4 buf0, buf1, buf2, buf3, b_0, b_1, b_2, b_3
	stm ptr_b!, {buf0, buf1, buf2, buf3} //c_12-c_15

	add sp, #128
.unreq ptr_c
.unreq ptr_a
.unreq ptr_b
.unreq a_0
.unreq a_1
.unreq a_2
.unreq a_3
.unreq b_0
.unreq b_1
.unreq b_2
.unreq b_3
.unreq buf0
.unreq buf1
.unreq buf2
.unreq buf3
.endm

//void gf232v_mul( sto_t *c, const sto_t *a , const sto_t *b )
.global gf232v_mul_asm
gf232v_mul_asm:
	push {r4-r11, lr}
	vpush {s16-s19}
	m_gf232v_mul_asm
	vpop {s16-s19}
	pop {r4-r11, pc}


//void void gf232v_mul_0x2_asm( sto_t *c, const sto_t *a )
.global gf232v_mul_0x2_asm
gf232v_mul_0x2_asm:
	push {r4, r5, r10, r11, lr}
ptr_c	.req r0
ptr_a	.req r1
c_0		.req r2
c_1		.req r3
c_2		.req r4
c_3		.req r5
c_4		.req r10
c_5		.req r11
c_6		.req r12
c_7		.req r14
	m_gf232v_mul_0x2_body ptr_c, ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	add ptr_c, #32
	m_gf232v_mul_0x2_body ptr_c, ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	add ptr_c, #32
	m_gf232v_mul_0x2_body ptr_c, ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	add ptr_c, #32
	m_gf232v_mul_0x2_body ptr_c, ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	add ptr_c, #32
	pop {r4, r5, r10, r11, pc}
.unreq ptr_c
.unreq ptr_a
.unreq c_0
.unreq c_1
.unreq c_2
.unreq c_3
.unreq c_4
.unreq c_5
.unreq c_6
.unreq c_7

// void gf232v_mul_0x5_asm( sto_t *c, const sto_t *a )
.global gf232v_mul_0x5_asm
gf232v_mul_0x5_asm:
	push {r4, r5, r10, r11, lr}
ptr_c	.req r0
ptr_a	.req r1
c_0		.req r2
c_1		.req r3
c_2		.req r4
c_3		.req r5
c_4		.req r10
c_5		.req r11
c_6		.req r12
c_7		.req r14
	m_gf232v_mul_0x5_body ptr_c, ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	add ptr_c, #32
	m_gf232v_mul_0x5_body ptr_c, ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	add ptr_c, #32
	m_gf232v_mul_0x5_body ptr_c, ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	add ptr_c, #32
	m_gf232v_mul_0x5_body ptr_c, ptr_a, c_0 c_1, c_2, c_3, c_4, c_5, c_6, c_7
	add ptr_c, #32
	pop {r4, r5, r10, r11, pc}
.unreq ptr_c
.unreq ptr_a
.unreq c_0
.unreq c_1
.unreq c_2
.unreq c_3
.unreq c_4
.unreq c_5
.unreq c_6
.unreq c_7

// void gf232v_mul_gf16_asm( sto_t *c, const sto_t *a , const sto_t *b_gf16 )
.global gf232v_mul_gf16_asm
gf232v_mul_gf16_asm:
	push {r4-r11, lr}
ptr_c	.req r0
ptr_a	.req r1
c_0		.req r1
ptr_b	.req r2
c_1		.req r2
a_0		.req r3
a_1		.req r4
a_2		.req r5
a_3		.req r6
b_0		.req r7
b_1		.req r8
b_2		.req r9
b_3		.req r10
c_2		.req r11
c_3		.req r12
buf0	.req r14
	push {ptr_a, ptr_b}
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	ldr a_2, [ptr_a, #8]
	ldr a_3, [ptr_a, #12]
	ldr b_0, [ptr_b, #0]
	ldr b_1, [ptr_b, #4]
	ldr b_2, [ptr_b, #8]
	ldr b_3, [ptr_b, #12]
	m_gf16v_mul c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3, buf0
	stm ptr_c!, {c_0, c_1, c_2, c_3}

	ldm sp, {ptr_a, ptr_b}
	add ptr_a, #16
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	ldr a_2, [ptr_a, #8]
	ldr a_3, [ptr_a, #12]
	ldr b_0, [ptr_b, #0]
	ldr b_1, [ptr_b, #4]
	m_gf16v_mul c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3, buf0
	stm ptr_c!, {c_0, c_1, c_2, c_3}

	ldm sp, {ptr_a, ptr_b}
	add ptr_a, #32
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	ldr a_2, [ptr_a, #8]
	ldr a_3, [ptr_a, #12]
	ldr b_0, [ptr_b, #0]
	ldr b_1, [ptr_b, #4]
	m_gf16v_mul c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3, buf0
	stm ptr_c!, {c_0, c_1, c_2, c_3}

	ldm sp, {ptr_a, ptr_b}
	add ptr_a, #48
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	ldr a_2, [ptr_a, #8]
	ldr a_3, [ptr_a, #12]
	ldr b_0, [ptr_b, #0]
	ldr b_1, [ptr_b, #4]
	m_gf16v_mul c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3, buf0
	stm ptr_c!, {c_0, c_1, c_2, c_3}

	ldm sp, {ptr_a, ptr_b}
	add ptr_a, #64
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	ldr a_2, [ptr_a, #8]
	ldr a_3, [ptr_a, #12]
	ldr b_0, [ptr_b, #0]
	ldr b_1, [ptr_b, #4]
	m_gf16v_mul c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3, buf0
	stm ptr_c!, {c_0, c_1, c_2, c_3}

	ldm sp, {ptr_a, ptr_b}
	add ptr_a, #80
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	ldr a_2, [ptr_a, #8]
	ldr a_3, [ptr_a, #12]
	ldr b_0, [ptr_b, #0]
	ldr b_1, [ptr_b, #4]
	m_gf16v_mul c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3, buf0
	stm ptr_c!, {c_0, c_1, c_2, c_3}

	ldm sp, {ptr_a, ptr_b}
	add ptr_a, #96
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	ldr a_2, [ptr_a, #8]
	ldr a_3, [ptr_a, #12]
	ldr b_0, [ptr_b, #0]
	ldr b_1, [ptr_b, #4]
	m_gf16v_mul c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3, buf0
	stm ptr_c!, {c_0, c_1, c_2, c_3}

	pop {ptr_a, ptr_b}
	add ptr_a, #112
	ldr a_0, [ptr_a, #0]
	ldr a_1, [ptr_a, #4]
	ldr a_2, [ptr_a, #8]
	ldr a_3, [ptr_a, #12]
	ldr b_0, [ptr_b, #0]
	ldr b_1, [ptr_b, #4]
	m_gf16v_mul c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_0, b_1, b_2, b_3, buf0
	stm ptr_c!, {c_0, c_1, c_2, c_3}

.unreq ptr_c
.unreq ptr_a
.unreq c_0
.unreq ptr_b
.unreq c_1
.unreq a_0
.unreq a_1
.unreq a_2
.unreq a_3
.unreq b_0
.unreq b_1
.unreq b_2
.unreq b_3
.unreq c_2
.unreq c_3
.unreq buf0
	pop {r4-r11, pc}

// void gf232v_mul_gf256_asm( sto_t *c, const sto_t *a , const sto_t *b_gf256 )
.global gf232v_mul_gf256_asm
gf232v_mul_gf256_asm:
	push {r4-r11, lr}
	push {r1, r2}
	m_gf256v_mul
	ldm sp, {r1, r2}
	add r0, #32
	add r1, #32
	m_gf256v_mul
	ldm sp, {r1, r2}
	add r0, #32
	add r1, #64
	m_gf256v_mul
	pop {r1, r2}
	add r0, #32
	add r1, #96
	m_gf256v_mul
	pop {r4-r11, pc}

// void gf232v_mul_gf216_asm( sto_t *c, const sto_t *a , const sto_t *b_gf216 )
.global gf232v_mul_gf216_asm
gf232v_mul_gf216_asm:
	push {r4-r11, lr}
	push {r0, r1, r2}
	m_gf216v_mul
	pop {r0, r1, r2}
	add r0, #64
	add r1, #64
	m_gf216v_mul
	pop {r4-r11, pc}

// void gf232v_mulscalar_gf16_asm( sto_t *c, const sto_t *a , uint8_t b )
.global gf232v_mulscalar_gf16_asm
gf232v_mulscalar_gf16_asm:
		push {r4-r11, lr}
ptr_c	.req r0
ptr_a	.req r1
b_		.req r2
a_0		.req r3
a_1		.req r4
a_2		.req r5
a_3		.req r6
c_0		.req r7
c_1		.req r8
c_2		.req r9
c_3		.req r10
buf0	.req r11
buf1	.req r12
buf2	.req r14
	ldm ptr_a!, {a_0-a_3}
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	str c_0, [ptr_c, #0]
	str c_1, [ptr_c, #4]
	str c_2, [ptr_c, #8]
	str c_3, [ptr_c, #12]
	ldm ptr_a!, {a_0-a_3}
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	str c_0, [ptr_c, #16]
	str c_1, [ptr_c, #20]
	str c_2, [ptr_c, #24]
	str c_3, [ptr_c, #28]
	ldm ptr_a!, {a_0-a_3}
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	str c_0, [ptr_c, #32]
	str c_1, [ptr_c, #36]
	str c_2, [ptr_c, #40]
	str c_3, [ptr_c, #44]
	ldm ptr_a!, {a_0-a_3}
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	str c_0, [ptr_c, #48]
	str c_1, [ptr_c, #52]
	str c_2, [ptr_c, #56]
	str c_3, [ptr_c, #60]
	ldm ptr_a!, {a_0-a_3}
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	str c_0, [ptr_c, #64]
	str c_1, [ptr_c, #68]
	str c_2, [ptr_c, #72]
	str c_3, [ptr_c, #76]
	ldm ptr_a!, {a_0-a_3}
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	str c_0, [ptr_c, #80]
	str c_1, [ptr_c, #84]
	str c_2, [ptr_c, #88]
	str c_3, [ptr_c, #92]
	ldm ptr_a!, {a_0-a_3}
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	str c_0, [ptr_c, #96]
	str c_1, [ptr_c, #100]
	str c_2, [ptr_c, #104]
	str c_3, [ptr_c, #108]
	ldm ptr_a!, {a_0-a_3}
	m_gf16v_mulscalar c_0, c_1, c_2, c_3, a_0, a_1, a_2, a_3, b_, buf0, buf1, buf2
	str c_0, [ptr_c, #112]
	str c_1, [ptr_c, #116]
	str c_2, [ptr_c, #120]
	str c_3, [ptr_c, #124]
.unreq ptr_c
.unreq ptr_a
.unreq b_
.unreq a_0
.unreq a_1
.unreq a_2
.unreq a_3
.unreq c_0
.unreq c_1
.unreq c_2
.unreq c_3
.unreq buf0
.unreq buf1
.unreq buf2
	pop {r4-r11, pc}

// void gf232v_mulscalar_gf256_asm( sto_t *c, const sto_t *a , uint8_t b )
.global gf232v_mulscalar_gf256_asm
gf232v_mulscalar_gf256_asm:
	push {r4-r11, lr}
	vmov s5, r2
	m_gf256v_mulscalar_asm
	add r0, #32
	add r1, #32
	vmov r2, s5
	m_gf256v_mulscalar_asm
	add r0, #32
	add r1, #32
	vmov r2, s5
	m_gf256v_mulscalar_asm
	add r0, #32
	add r1, #32
	vmov r2, s5
	m_gf256v_mulscalar_asm
	pop {r4-r11, pc}

// void gf232v_mulscalar_asm( sto_t *c, const sto_t *a , uint32_t _b );
.global gf232v_mulscalar_asm
gf232v_mulscalar_asm:
	push {r4-r11, lr}
	vpush {s16-s19}
	sub sp, #128 	//b[32]
	mov r3, r2		// _b
	mov r2, sp		//ptr_b
	mov r12, #1
	mov r14, #0

	and r4, r12, r3, ror #0
	sub r4, r14, r4
	str r4, [r2, #0]
	and r4, r12, r3, ror #1
	sub r4, r14, r4
	str r4, [r2, #4]
	and r4, r12, r3, ror #2
	sub r4, r14, r4
	str r4, [r2, #8]
	and r4, r12, r3, ror #3
	sub r4, r14, r4
	str r4, [r2, #12]
	and r4, r12, r3, ror #4
	sub r4, r14, r4
	str r4, [r2, #16]
	and r4, r12, r3, ror #5
	sub r4, r14, r4
	str r4, [r2, #20]
	and r4, r12, r3, ror #6
	sub r4, r14, r4
	str r4, [r2, #24]
	and r4, r12, r3, ror #7
	sub r4, r14, r4
	str r4, [r2, #28]
	and r4, r12, r3, ror #8
	sub r4, r14, r4
	str r4, [r2, #32]
	and r4, r12, r3, ror #9
	sub r4, r14, r4
	str r4, [r2, #36]
	and r4, r12, r3, ror #10
	sub r4, r14, r4
	str r4, [r2, #40]
	and r4, r12, r3, ror #11
	sub r4, r14, r4
	str r4, [r2, #44]
	and r4, r12, r3, ror #12
	sub r4, r14, r4
	str r4, [r2, #48]
	and r4, r12, r3, ror #13
	sub r4, r14, r4
	str r4, [r2, #52]
	and r4, r12, r3, ror #14
	sub r4, r14, r4
	str r4, [r2, #56]
	and r4, r12, r3, ror #15
	sub r4, r14, r4
	str r4, [r2, #60]
	and r4, r12, r3, ror #16
	sub r4, r14, r4
	str r4, [r2, #64]
	and r4, r12, r3, ror #17
	sub r4, r14, r4
	str r4, [r2, #68]
	and r4, r12, r3, ror #18
	sub r4, r14, r4
	str r4, [r2, #72]
	and r4, r12, r3, ror #19
	sub r4, r14, r4
	str r4, [r2, #76]
	and r4, r12, r3, ror #20
	sub r4, r14, r4
	str r4, [r2, #80]
	and r4, r12, r3, ror #21
	sub r4, r14, r4
	str r4, [r2, #84]
	and r4, r12, r3, ror #22
	sub r4, r14, r4
	str r4, [r2, #88]
	and r4, r12, r3, ror #23
	sub r4, r14, r4
	str r4, [r2, #92]
	and r4, r12, r3, ror #24
	sub r4, r14, r4
	str r4, [r2, #96]
	and r4, r12, r3, ror #25
	sub r4, r14, r4
	str r4, [r2, #100]
	and r4, r12, r3, ror #26
	sub r4, r14, r4
	str r4, [r2, #104]
	and r4, r12, r3, ror #27
	sub r4, r14, r4
	str r4, [r2, #108]
	and r4, r12, r3, ror #28
	sub r4, r14, r4
	str r4, [r2, #112]
	and r4, r12, r3, ror #29
	sub r4, r14, r4
	str r4, [r2, #116]
	and r4, r12, r3, ror #30
	sub r4, r14, r4
	str r4, [r2, #120]
	and r4, r12, r3, ror #31
	sub r4, r14, r4
	str r4, [r2, #124]

	m_gf232v_mul_asm

	add sp, #128
	vpop {s16-s19}
	pop {r4-r11, pc}
