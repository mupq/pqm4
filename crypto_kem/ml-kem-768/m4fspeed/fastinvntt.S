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

.macro mul_twiddle_plant a, twiddle, tmp, q, qa
	smulwb \tmp, \twiddle, \a
	smulwt \a,   \twiddle, \a
	smlabt \tmp, \tmp, \q, \qa
	smlabt \a, \a, \q, \qa
	pkhtb \a, \a, \tmp, asr#16
.endm

.macro doublebutterfly_plant a0, a1, twiddle, tmp, q, qa
	smulwb \tmp, \twiddle, \a1
	smulwt \a1, \twiddle, \a1
	smlabt \tmp, \tmp, \q, \qa
	smlabt \a1, \a1, \q, \qa
	pkhtb \tmp, \a1, \tmp, asr#16
	usub16 \a1, \a0, \tmp
	uadd16 \a0, \a0, \tmp
.endm

.macro two_doublebutterfly_plant a0, a1, a2, a3, twiddle0, twiddle1, tmp, q, qa
	doublebutterfly_plant \a0, \a1, \twiddle0, \tmp, \q, \qa
	doublebutterfly_plant \a2, \a3, \twiddle1, \tmp, \q, \qa
.endm

.macro fullplant a0, a1, a2, a3, a4, a5, a6, a7, tmp, q, qa, plantconst
	movw \plantconst, #44984
	movt \plantconst, #19
	doubleplant \a0, \tmp, \q, \qa, \plantconst
	doubleplant \a1, \tmp, \q, \qa, \plantconst
	doubleplant \a2, \tmp, \q, \qa, \plantconst
	doubleplant \a3, \tmp, \q, \qa, \plantconst
	doubleplant \a4, \tmp, \q, \qa, \plantconst
	doubleplant \a5, \tmp, \q, \qa, \plantconst
	doubleplant \a6, \tmp, \q, \qa, \plantconst
	doubleplant \a7, \tmp, \q, \qa, \plantconst
.endm

.macro halfplant a0, a1, a2, a3, tmp, q, qa, plantconst
	movw \plantconst, #44984
	movt \plantconst, #19
	doubleplant \a0, \tmp, \q, \qa, \plantconst
	doubleplant \a1, \tmp, \q, \qa, \plantconst
	doubleplant \a2, \tmp, \q, \qa, \plantconst
	doubleplant \a3, \tmp, \q, \qa, \plantconst
.endm


// input: 0.5/1q
.macro _3_layer_double_inv_CT_16_plant_light c0, c1, c2, c3, c4, c5, c6, c7, xi2, xi4, xi5, xi6, twiddle1, tmp2, q, qa, tmp

	// layer 1  
	sadd16.w \tmp, \c0, \c1 // c0, c1
	ssub16.w \c1, \c0, \c1
	sadd16.w \tmp2, \c2, \c3 // c2, c3
	ssub16.w \c3, \c2, \c3
	// tmp, c1, tmp2, c3: 1q maximum
	sadd16.w \c0, \c4, \c5 // c4, c5
	ssub16.w \c5, \c4, \c5
	sadd16.w \c2, \c6, \c7 // c6, c7
	ssub16.w \c7, \c6, \c7
	// c4, c6 are free at this point
	// c0,c5,c2,c7 1q maximum

	// layer 2
	sadd16.w \c6, \tmp, \tmp2 // c0, c2
	ssub16.w \tmp2, \tmp, \tmp2
	sadd16.w \c4, \c0, \c2 // c4, c6
	ssub16.w \c2, \c0, \c2
	// c6, tmp2, c4, c2: 2q maximum

	vmov.w \twiddle1, \xi2
	doublebutterfly_plant \c1, \c3, \twiddle1, \tmp, \q, \qa
	doublebutterfly_plant \c5, \c7, \twiddle1, \tmp, \q, \qa 
	// c1, c3, c7, c5: 1.5q maximum;

	// tmp and c0 are free at this point
	// layer 3
	sadd16.w \c0, \c6, \c4 // c0, c4
	ssub16.w \c4, \c6, \c4
	// c0, c4: 4q
	// c6 are free at this point
	vmov.w \twiddle1, \xi4
	doublebutterfly_plant \c1, \c5, \twiddle1, \tmp, \q, \qa
	// c1, c5: 2q maximum

	vmov.w \twiddle1, \xi5
	// this block is one doublebutterfly
	smulwb \tmp, \twiddle1, \c2  // c2, c6
	smulwt \c2,  \twiddle1, \c2
	smlabt \tmp, \tmp, \q, \qa
	smlabt \c2, \c2, \q, \qa
	pkhtb \tmp, \c2, \tmp, asr#16
	ssub16.w \c6, \tmp2, \tmp 
	sadd16.w \c2, \tmp2, \tmp
	//c6, c2: 4.5q
	vmov.w \twiddle1, \xi6
	doublebutterfly_plant \c3, \c7, \twiddle1, \tmp, \q, \qa
	//c3, c7: 2.5q maximum
.endm
.macro _3_layer_double_inv_CT_16_plant c0, c1, c2, c3, c4, c5, c6, c7, twiddle1, twiddle2, twiddle_ptr, q, qa, tmp
	// layer 3
	ldr.w \twiddle1, [\twiddle_ptr], #4
	two_doublebutterfly_plant \c0, \c1, \c2, \c3, \twiddle1, \twiddle1, \tmp, \q, \qa
	two_doublebutterfly_plant \c4, \c5, \c6, \c7, \twiddle1, \twiddle1, \tmp, \q, \qa

	// layer 2
	ldrd \twiddle1, \twiddle2, [\twiddle_ptr], #8
	two_doublebutterfly_plant \c0, \c2, \c1, \c3, \twiddle1, \twiddle2, \tmp, \q, \qa

	two_doublebutterfly_plant \c4, \c6, \c5, \c7, \twiddle1, \twiddle2, \tmp, \q, \qa

	// layer 1
	ldrd \twiddle1, \twiddle2, [\twiddle_ptr], #8
	two_doublebutterfly_plant \c0, \c4, \c1, \c5, \twiddle1, \twiddle2, \tmp, \q, \qa

	ldrd \twiddle1, \twiddle2, [\twiddle_ptr], #8
	two_doublebutterfly_plant \c2, \c6, \c3, \c7, \twiddle1, \twiddle2, \tmp, \q, \qa
.endm

.macro _3_layer_double_inv_twist_16_plant c0, c1, c2, c3, c4, c5, c6, c7, twiddle1, twiddle2, twiddle_ptr, q, qa, tmp
	ldrd \twiddle1, \twiddle2, [\twiddle_ptr], #8
	mul_twiddle_plant \c0, \twiddle1, \tmp, \q, \qa
	mul_twiddle_plant \c1, \twiddle2, \tmp, \q, \qa
	ldrd \twiddle1, \twiddle2, [\twiddle_ptr], #8
	mul_twiddle_plant \c2, \twiddle1, \tmp, \q, \qa
	mul_twiddle_plant \c3, \twiddle2, \tmp, \q, \qa
	ldrd \twiddle1, \twiddle2, [\twiddle_ptr], #8
	mul_twiddle_plant \c4, \twiddle1, \tmp, \q, \qa
	mul_twiddle_plant \c5, \twiddle2, \tmp, \q, \qa
	ldrd \twiddle1, \twiddle2, [\twiddle_ptr], #8
	mul_twiddle_plant \c6, \twiddle1, \tmp, \q, \qa
	mul_twiddle_plant \c7, \twiddle2, \tmp, \q, \qa
.endm
# input coefficients < 0.5q
.global invntt_fast
.type invntt_fast, %function
.align 2
invntt_fast:
	push {r4-r11, r14}
	vpush.w {s16-s23}
	poly         .req r0
	twiddle_ptr  .req r1
	poly0        .req r2
	poly1        .req r3
	poly2        .req r4
	poly3        .req r5
	poly4        .req r6
	poly5        .req r7
	poly6        .req r8
	poly7        .req r9
	twiddle1     .req r10
	twiddle2     .req r11
	q            .req r12 
	// at the top of r12
	qa           .req r0
	// qa=2^a q;a=3; at the bottom of r12
	tmp          .req r14

	movt q, #3329

	### LAYER 7+6+5+4
	.equ distance, 16
	.equ offset, 32
	.equ strincr, 64

	// pre-load twiddle factors to FPU registers
	vldm twiddle_ptr!, {s8-s22}

	add.w tmp, poly, #8*strincr
	vmov s8, tmp
	1:
		vmov s23, poly
		// load a1, a3, ..., a15
		load poly, poly0, poly1, poly2, poly3, #offset, #distance/4+offset, #2*distance/4+offset, #3*distance/4+offset
		load poly, poly4, poly5, poly6, poly7, #distance+offset, #5*distance/4+offset, #6*distance/4+offset, #7*distance/4+offset

		movw qa, #26632

		// NTT on a1, a3, ..., a15   
		// twiddle2 is used as tmp2
		_3_layer_double_inv_CT_16_plant_light poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s10, s12, s13, s14, twiddle1, twiddle2, q, qa, tmp

		// multiply coeffs by layer 4 twiddles for later use
		// vmov twiddle1, s15 
		vmov twiddle2, s16
		// mul_twiddle_plant poly0, twiddle1, tmp, q, qa // could be omitted but kept for reduction only
		mul_twiddle_plant poly1, twiddle2, tmp, q, qa

		vmov twiddle1, s17 
		vmov twiddle2, s18
		mul_twiddle_plant poly2, twiddle1, tmp, q, qa
		mul_twiddle_plant poly3, twiddle2, tmp, q, qa

		vmov twiddle1, s19 
		vmov twiddle2, s20
		mul_twiddle_plant poly4, twiddle1, tmp, q, qa
		mul_twiddle_plant poly5, twiddle2, tmp, q, qa

		vmov twiddle1, s21 
		vmov twiddle2, s22
		mul_twiddle_plant poly6, twiddle1, tmp, q, qa
		mul_twiddle_plant poly7, twiddle2, tmp, q, qa

		vmov s0, poly0 // a1
		vmov s1, poly1 // a3
		vmov s2, poly2 // a5
		vmov s3, poly3 // a7
		vmov s4, poly4 // a9
		vmov s5, poly5 // a11
		vmov s6, poly6 // a13
		vmov s7, poly7 // a15
		// 0.5q
		// ----------

		vmov poly, s23
		// load a0, a2, ..., a14
		load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
		load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
		
		movw qa, #26632
		// NTT on a0, a2, ..., a14
		// twiddle2 is used as tmp2
		_3_layer_double_inv_CT_16_plant_light poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s10, s12, s13, s14, twiddle1, twiddle2, q, qa, tmp
		// 1,3,5,7: <5q; 0,2,4,6:<1q
		// layer 4 - 1
		// addsub: (a2, a6, a10, a14), (a3, a7, a11, a15)
		vmov poly, s23
		vmov twiddle2, s1 // load a3
		uadd16 tmp, poly1, twiddle2
		usub16 poly1, poly1, twiddle2
		str.w tmp, [poly, #1*distance/4]
		str.w poly1, [poly, #1*distance/4+offset]

		vmov twiddle2, s3 // load a7
		uadd16 tmp, poly3, twiddle2
		usub16 poly3, poly3, twiddle2
		str.w tmp, [poly, #3*distance/4]
		str.w poly3, [poly, #3*distance/4+offset]
		
		vmov twiddle2, s5 // load a11
		uadd16 tmp, poly5, twiddle2
		usub16 poly5, poly5, twiddle2
		str.w tmp, [poly, #5*distance/4]
		str.w poly5, [poly, #5*distance/4+offset]
		
		vmov twiddle2, s7 // load a15
		uadd16 tmp, poly7, twiddle2
		usub16 poly7, poly7, twiddle2
		str.w tmp, [poly, #7*distance/4]
		str.w poly7, [poly, #7*distance/4+offset]
		//1,3,5,7: < 5.5q

		// layer 4 - 2    
		// addsub: (a0, a4, a8, a12), (a1, a5, a9, a13)
		vmov poly3, s2 // load a5
		uadd16 tmp, poly2, poly3
		usub16 twiddle2, poly2, poly3
		str.w tmp, [poly, #2*distance/4]
		str.w twiddle2, [poly, #2*distance/4+offset]

		vmov poly5, s4 // load a9
		uadd16 tmp, poly4, poly5
		usub16 twiddle2, poly4, poly5
		str.w tmp, [poly, #4*distance/4]
		str.w twiddle2, [poly, #4*distance/4+offset]

		vmov poly7, s6 // load a13
		uadd16 tmp, poly6, poly7
		usub16 twiddle2, poly6, poly7
		str.w tmp, [poly, #6*distance/4]
		str.w twiddle2, [poly, #6*distance/4+offset]
		
		vmov poly1, s0 // load a1
		uadd16 tmp, poly0, poly1
		usub16 twiddle2, poly0, poly1
		str.w twiddle2, [poly, #offset]    
		str.w tmp, [poly], #strincr // increase 2*8*4 = 64 (2 * 8 loads of 4 bytes each)
		//0,2,4,6: < 1.5q
	vmov tmp, s8
	cmp.w poly, tmp
	bne.w 1b

	sub.w poly, #8*strincr  

	### LAYER 3+2+1

	.equ distance, distance*16
	.equ strincr, 4

	// ITER 0
	vmov s6, poly
	load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
	load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

	vldm twiddle_ptr!, {s0-s5}
	movw qa, #26632
	fullplant poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7 tmp, q, qa, twiddle1
	// twiddle2 is used as tmp2
	_3_layer_double_inv_CT_16_plant_light poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s1, s3, s4, s5, twiddle1, twiddle2, q, qa, tmp

	// twisting
	_3_layer_double_inv_twist_16_plant poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle1, twiddle2, twiddle_ptr, q, qa, tmp
	
	vmov poly, s6
	store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
	str.w poly1, [poly, #distance/4]
	str.w poly2, [poly, #2*distance/4]
	str.w poly3, [poly, #3*distance/4]
	str.w poly0, [poly], #4

	// ITER 1-15
	add.w tmp, poly, #strincr*3*(5)
	vmov s14, tmp
	2:
		vmov s6, poly
		// polys upto 5.5q
		load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
		load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
		
		movw qa, #26632
		_3_layer_double_inv_CT_16_plant poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle1, twiddle2, twiddle_ptr, q, qa, tmp

		// twisting
		_3_layer_double_inv_twist_16_plant poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle1, twiddle2, twiddle_ptr, q, qa, tmp

		vmov poly, s6
		store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
		str.w poly1, [poly, #distance/4]
		str.w poly2, [poly, #2*distance/4]
		str.w poly3, [poly, #3*distance/4]
		str.w poly0, [poly], #4

	vmov tmp, s14
	cmp.w poly, tmp
	bne.w 2b

	vpop.w {s16-s23}
	pop {r4-r11, pc}
