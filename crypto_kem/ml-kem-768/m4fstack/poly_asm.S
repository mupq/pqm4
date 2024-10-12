/******************************************************************************
* Integrating the improved Plantard arithmetic into Kyber.
*
* Efficient Plantard arithmetic enables a faster Kyber implementation with the 
* same stack usage.
*
* See the paper at https://eprint.iacr.org/2022/956.pdf for more details.
*
* @author   Junhao Huang, BNU-HKBU United International College, Zhuhai, China
*           jhhuang_nuaa@126.com
*
* @date     September 2022
******************************************************************************/
#include "macros.i"

.syntax unified
.cpu cortex-m4
.thumb

.macro doublebasemul_frombytes_asm rptr, bptr, zeta, poly0, poly1, poly3, tmp, tmp2, q, qa, qinv
	ldr.w \poly0, [\bptr], #4

	smulwt \tmp, \zeta, \poly1 
	smlabt \tmp, \tmp, \q, \qa  
	smultt \tmp, \poly0, \tmp  
	smlabb \tmp, \poly0, \poly1, \tmp 
	// a1*b1*zeta+a0*b0
	plant_red \q, \qa, \qinv, \tmp
	// r[0] in upper half of tmp
	
	smuadx \tmp2, \poly0, \poly1 
	plant_red \q, \qa, \qinv, \tmp2

	// r[1] in upper half of tmp2
	pkhtb \tmp, \tmp2, \tmp, asr#16
	str \tmp, [rptr], #4

	neg \zeta, \zeta

	ldr.w \poly0, [\bptr], #4
	//basemul(r->coeffs + 4 * i + 2, a->coeffs + 4 * i + 2, b->coeffs + 4 * i + 2, - zetas[64 + i]);
	smulwt \tmp, \zeta, \poly3 
	smlabt \tmp, \tmp, \q, \qa  
	smultt \tmp, \poly0, \tmp  
	smlabb \tmp, \poly0, \poly3, \tmp 
	plant_red \q, \qa, \qinv, \tmp
	// r[0] in upper half of tmp
	
	smuadx \tmp2, \poly0, \poly3 
	plant_red \q, \qa, \qinv, \tmp2
	// r[1] in upper half of tmp2
	pkhtb \tmp, \tmp2, \tmp, asr#16
	str \tmp, [rptr], #4
.endm

.macro doublebasemul_frombytes_asm_acc rptr, bptr, zeta, poly0, poly1, poly3, res0, tmp, tmp2, q, qa, qinv

	ldr \poly0, [\bptr], #4
	
	ldr \res0, [\rptr]
	smulwt \tmp, \zeta, \poly1 
	// b_1*zeta*qinv*plant_const; in low half
	smlabt \tmp, \tmp, \q, \qa  
	// b_1*zeta
	smultt \tmp, \poly0, \tmp  
	//a_1*b_1*zeta <2^32
	smlabb \tmp, \poly0, \poly1, \tmp 
	// a1*b1*zeta+a0*b0
	plant_red \q, \qa, \qinv, \tmp
	// r[0] in upper half of tmp
	
	smuadx \tmp2, \poly0, \poly1 
	plant_red \q, \qa, \qinv, \tmp2

	// r[1] in upper half of tmp2
	pkhtb \tmp, \tmp2, \tmp, asr#16
	uadd16 \res0, \res0, \tmp
	str \res0, [\rptr], #4

	neg \zeta, \zeta
	
	ldr \poly0, [\bptr], #4
	ldr \res0, [\rptr]

	smulwt \tmp, \zeta, \poly3 
	smlabt \tmp, \tmp, \q, \qa  
	smultt \tmp, \poly0, \tmp  
	smlabb \tmp, \poly0, \poly3, \tmp 
	plant_red \q, \qa, \qinv, \tmp
	// r[0] in upper half of tmp
	
	smuadx \tmp2, \poly0, \poly3 
	plant_red \q, \qa, \qinv, \tmp2
	// r[1] in upper half of tmp2
	pkhtb \tmp, \tmp2, \tmp, asr#16
	uadd16 \res0, \res0, \tmp
	str \res0, [\rptr], #4
.endm

// reduce 2 registers
.macro deserialize aptr, tmp, tmp2, tmp3, t0, t1
	ldrb.w \tmp, [\aptr, #2]
	ldrh.w \tmp2, [\aptr, #3]
	ldrb.w \tmp3, [\aptr, #5]
	ldrh.w \t0, [\aptr], #6

	ubfx.w \t1, \t0, #12, #4
	ubfx.w \t0, \t0, #0, #12
	orr \t1, \t1, \tmp, lsl #4
	orr \t0, \t0, \t1, lsl #16
	//tmp is free now
	ubfx.w \t1, \tmp2, #12, #4
	ubfx.w \tmp, \tmp2, #0, #12
	orr \t1, \t1, \tmp3, lsl #4
	orr \t1, \tmp, \t1, lsl #16
.endm

// void frombytes_mul_asm(int16_t *r, const int16_t *b, const unsigned char *a, const int32_t zetas[64])
.global frombytes_mul_asm
.type frombytes_mul_asm, %function
.align 2
frombytes_mul_asm:
	push {r4-r11, r14}

	rptr    .req r0
	bptr    .req r1
	aptr    .req r2
	zetaptr .req r3
	t0      .req r4
	t1      .req r5
	tmp     .req r6
	tmp2    .req r7
	tmp3    .req r8
	q       .req r9
	qa      .req r10
	qinv    .req r11
	zeta    .req r12
	ctr     .req r14

	movw qa, #26632
	movt  q, #3329  
	### qinv=0x6ba8f301
	movw qinv, #62209
	movt qinv, #27560

	add ctr, rptr, #64*4*2
	1:
		ldr.w zeta, [zetaptr], #4
		deserialize aptr, tmp, tmp2, tmp3, t0, t1

		doublebasemul_frombytes_asm rptr, bptr, zeta, tmp3, t0, t1, tmp, tmp2, q, qa, qinv

	cmp.w rptr, ctr
	bne.w 1b

	pop {r4-r11, pc}
.size frombytes_mul_asm, . -frombytes_mul_asm

// void frombytes_mul_asm_acc(int16_t *r, const int16_t *b, const unsigned char *a, const int32_t zetas[64])
.global frombytes_mul_asm_acc
.type frombytes_mul_asm_acc, %function
.align 2
frombytes_mul_asm_acc:
	push {r4-r11, r14}

	rptr    .req r0
	bptr    .req r1
	aptr    .req r2
	zetaptr .req r3
	t0      .req r4
	t1      .req r5
	tmp     .req r6
	tmp2    .req r7
	tmp3    .req r8
	q       .req r9
	qa      .req r10
	qinv    .req r11
	zeta    .req r12
	ctr     .req r14

	movw qa, #26632
	movt  q, #3329  
	### qinv=0x6ba8f301
	movw qinv, #62209
	movt qinv, #27560

	add ctr, rptr, #64*4*2
	1:
		ldr.w zeta, [zetaptr], #4
		deserialize aptr, tmp, tmp2, tmp3, t0, t1
		vmov s0, ctr
		doublebasemul_frombytes_asm_acc rptr, bptr, zeta, tmp3, t0, t1, ctr, tmp, tmp2, q, qa, qinv
		vmov ctr, s0
	cmp.w rptr, ctr
	bne.w 1b

	pop {r4-r11, pc}
.size frombytes_mul_asm_acc, . - frombytes_mul_asm_acc 