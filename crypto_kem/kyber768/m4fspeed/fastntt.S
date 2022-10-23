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

.macro _3_layer_double_CT_16_plant c0, c1, c2, c3, c4, c5, c6, c7, twiddle1, twiddle2, twiddle_ptr, q, qa, tmp
	// layer 3
	ldr.w \twiddle1, [\twiddle_ptr], #4
	two_doublebutterfly_plant \c0, \c4, \c1, \c5, \twiddle1, \twiddle1, \tmp, \q, \qa
	two_doublebutterfly_plant \c2, \c6, \c3, \c7, \twiddle1, \twiddle1, \tmp, \q, \qa

	// layer 2
	ldrd \twiddle1, \twiddle2, [\twiddle_ptr], #8
	two_doublebutterfly_plant \c0, \c2, \c1, \c3, \twiddle1, \twiddle1, \tmp, \q, \qa

	two_doublebutterfly_plant \c4, \c6, \c5, \c7, \twiddle2, \twiddle2, \tmp, \q, \qa

	// layer 1
	ldrd \twiddle1, \twiddle2, [\twiddle_ptr], #8
	two_doublebutterfly_plant \c0, \c1, \c2, \c3, \twiddle1, \twiddle2, \tmp, \q, \qa

	ldrd \twiddle1, \twiddle2, [\twiddle_ptr], #8
	two_doublebutterfly_plant \c4, \c5, \c6, \c7, \twiddle1, \twiddle2, \tmp, \q, \qa
.endm

.macro _3_layer_double_CT_16_plant_fp c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle1, twiddle2, q, qa, tmp
	// layer 3
	vmov \twiddle1, \xi0
	two_doublebutterfly_plant \c0, \c4, \c1, \c5, \twiddle1, \twiddle1, \tmp, \q, \qa
	two_doublebutterfly_plant \c2, \c6, \c3, \c7, \twiddle1, \twiddle1, \tmp, \q, \qa

	// layer 2
	vmov \twiddle1, \xi1
	vmov \twiddle2, \xi2
	two_doublebutterfly_plant \c0, \c2, \c1, \c3, \twiddle1, \twiddle1, \tmp, \q, \qa

	two_doublebutterfly_plant \c4, \c6, \c5, \c7, \twiddle2, \twiddle2, \tmp, \q, \qa

	// layer 1
	vmov \twiddle1, \xi3
	vmov \twiddle2, \xi4
	two_doublebutterfly_plant \c0, \c1, \c2, \c3, \twiddle1, \twiddle2, \tmp, \q, \qa

	vmov \twiddle1, \xi5
	vmov \twiddle2, \xi6
	two_doublebutterfly_plant \c4, \c5, \c6, \c7, \twiddle1, \twiddle2, \tmp, \q, \qa
.endm

.global ntt_fast
.type ntt_fast, %function
.align 2
ntt_fast:
	push {r4-r11, r14}
	vpush.w {s16-s24}
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
	###  qinv        .req r11 ### q^-1 mod 2^2n; n=16
	q           .req r12 
	### at the top of r12
	qa          .req r0
	### qa=2^a q;a=3; at the bottom of r12
	tmp         .req r14

	// movw qa, #26632
	// Why movt? Because we initially placed qa at the bottom of the same register as q;
	movt q, #3329

	### LAYER 7+6+5+4
	.equ distance, 256
	.equ offset, 32
	.equ strincr, 4
	// pre-load 15 twiddle factors to 15 FPU registers
	// s0-s7 used to temporary store 16 16-bit polys.
	vldm twiddle_ptr!, {s8-s22}
 
	add tmp, poly, #strincr*8
	// s23: poly addr
	// s24: tmp  
	vmov s24, tmp  
	1:
		// load a1, a3, ..., a15
		vmov s23, poly
		load poly, poly0, poly1, poly2, poly3, #offset, #distance/4+offset, #2*distance/4+offset, #3*distance/4+offset
		load poly, poly4, poly5, poly6, poly7, #distance+offset, #5*distance/4+offset, #6*distance/4+offset, #7*distance/4+offset
		
		movw qa, #26632

		// 8-NTT on a1, a3, ..., a15
		_3_layer_double_CT_16_plant_fp poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s8, s9, s10, s11, s12, s13, s14, twiddle1, twiddle2, q, qa, tmp

		// s15, s16, s17, s18, s19, s20, s21, s22 left
		// multiply coeffs by layer 8 twiddles for later use
		vmov twiddle1, s15 
		vmov twiddle2, s16 
		mul_twiddle_plant poly0, twiddle1, tmp, q, qa
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

		vmov poly, s23
	
		// load a0, a2, ..., a14
		load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
		load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
		
		movw qa, #26632
		// 8-NTT on a0, a2, ..., a14
		_3_layer_double_CT_16_plant_fp poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s8, s9, s10, s11, s12, s13, s14, twiddle1, twiddle2, q, qa, tmp

		
		// layer 4 - 1
		// addsub: (a2, a6, a10, a14), (a3, a7, a11, a15)
		vmov poly, s23
		vmov twiddle1, s1 // load a3
		uadd16 tmp, poly1, twiddle1
		usub16 poly1, poly1, twiddle1
		str.w tmp, [poly, #1*distance/4]
		str.w poly1, [poly, #1*distance/4+offset]

		vmov twiddle1, s3 // load a7
		uadd16 tmp, poly3, twiddle1
		usub16 poly3, poly3, twiddle1
		str.w tmp, [poly, #3*distance/4]
		str.w poly3, [poly, #3*distance/4+offset]
		
		vmov twiddle1, s5 // load a11
		uadd16 tmp, poly5, twiddle1
		usub16 poly5, poly5, twiddle1
		str.w tmp, [poly, #5*distance/4]
		str.w poly5, [poly, #5*distance/4+offset]
		
		vmov twiddle1, s7 // load a15
		uadd16 tmp, poly7, twiddle1
		usub16 poly7, poly7, twiddle1
		str.w tmp, [poly, #7*distance/4]
		str.w poly7, [poly, #7*distance/4+offset]
		
		// layer 4 - 2    
		// addsub: (a0, a4, a8, a12), (a1, a5, a9, a13)
		vmov poly3, s2 // load a5
		uadd16 tmp, poly2, poly3
		usub16 twiddle1, poly2, poly3
		str.w tmp, [poly, #2*distance/4]
		str.w twiddle1, [poly, #2*distance/4+offset]

		vmov poly5, s4 // load a9
		uadd16 tmp, poly4, poly5
		usub16 twiddle1, poly4, poly5
		str.w tmp, [poly, #4*distance/4]
		str.w twiddle1, [poly, #4*distance/4+offset]

		vmov poly7, s6 // load a13
		uadd16 tmp, poly6, poly7
		usub16 twiddle1, poly6, poly7
		str.w tmp, [poly, #6*distance/4]
		str.w twiddle1, [poly, #6*distance/4+offset]
		
		vmov poly1, s0 // load a1
		uadd16 tmp, poly0, poly1
		usub16 twiddle1, poly0, poly1
		str.w twiddle1, [poly, #offset]
		str.w tmp, [poly], #4

	vmov tmp, s24
	cmp.w poly, tmp
	bne.w 1b

	sub.w poly, #8*strincr

	### LAYER 3+2+1

	.equ distance, distance/16
	.equ strincr, 32

	add.w tmp, poly, #strincr*16
	vmov s13, tmp
	2:
		vmov s23, poly
		load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
		load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
		
		movw qa, #26632
		_3_layer_double_CT_16_plant poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle1, twiddle2, twiddle_ptr, q, qa, tmp
		
		vmov poly, s23
		store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
		str.w poly1, [poly, #distance/4]
		str.w poly2, [poly, #2*distance/4]
		str.w poly3, [poly, #3*distance/4]
		str.w poly0, [poly], #strincr

	vmov tmp, s13
	cmp.w poly, tmp
	bne.w 2b
	vpop.w {s16-s24}
	pop {r4-r11, pc}
