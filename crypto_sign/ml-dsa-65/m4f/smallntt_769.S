/**
 * Copyright (c) 2023 Junhao Huang (jhhuang_nuaa@126.com)
 *
 * Licensed under the Apache License, Version 2.0(the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include "macros.i"

.syntax unified
.cpu cortex-m4
.thumb

#include "macros_smallntt.i"
// #######
// #######
// # NTT #
// #######
// #######

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

.global small_ntt_asm_769
.type small_ntt_asm_769, %function
.align 2
small_ntt_asm_769:
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

	// movw qa, #24608
	// Why movt? Because we initially placed qa at the bottom of the same register as q;
	movt q, #769

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
		
		movw qa, #24608

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
		
		movw qa, #24608
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
		
		movw qa, #24608
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

.unreq poly
.unreq twiddle_ptr
.unreq poly0
.unreq poly1
.unreq poly2
.unreq poly3
.unreq poly4
.unreq poly5
.unreq poly6
.unreq poly7
.unreq twiddle1
.unreq twiddle2
.unreq q
.unreq qa
.unreq tmp


// ########
// ########
// # INTT #
// ########
// ########

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
.global small_invntt_asm_769
.type small_invntt_asm_769, %function
.align 2
small_invntt_asm_769:
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

	movt q, #769

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

		movw qa, #24608

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
		
		movw qa, #24608
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
	movw qa, #24608
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
		
		movw qa, #24608
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

.unreq poly
.unreq twiddle_ptr
.unreq poly0
.unreq poly1
.unreq poly2
.unreq poly3
.unreq poly4
.unreq poly5
.unreq poly6
.unreq poly7
.unreq twiddle1
.unreq twiddle2
.unreq q
.unreq qa
.unreq tmp


###################################
#### small point-multiplication####
#### r0: out; r1: in; r2: zetas####
###################################
.align 2
.global small_pointmul_asm_769
.type small_pointmul_asm_769, %function
small_pointmul_asm_769:
    push.w {r4-r11, lr}

    movw r14, #24608 // qa
    movt r12, #769  // q
    .equ width, 4


    add.w r3, r2, #64*width
    _point_mul_16_loop:

    ldr.w r7, [r1, #2*width]
    ldr.w r8, [r1, #3*width]
    ldr.w r9, [r2, #1*width]
    ldr.w r5, [r1, #1*width]
    ldr.w r4, [r1], #4*width
    ldr.w r6, [r2], #2*width

    smulwt r10, r6, r4
    smlabt r10, r10, r12, r14
    pkhbt r4, r4, r10

    neg.w r6, r6

	smulwt r10, r6, r5
    smlabt r10, r10, r12, r14
    pkhbt r5, r5, r10

    str.w r5, [r0, #1*width]
    str.w r4, [r0], #2*width

    smulwt r10, r9, r7
    smlabt r10, r10, r12, r14
    pkhbt r7, r7, r10

    neg.w r9, r9

    smulwt r10, r9, r8
    smlabt r10, r10, r12, r14
    pkhbt r8, r8, r10

    str.w r8, [r0, #1*width]
    str.w r7, [r0], #2*width

    cmp.w r2, r3
    bne.w _point_mul_16_loop

    pop.w {r4-r11, pc}


#### r0: out; r1: a; r2: b; r3: bprime
  .align 2
.global small_asymmetric_mul_asm_769
.type small_asymmetric_mul_asm_769, %function
small_asymmetric_mul_asm_769:
    push.w {r4-r11, lr}

    movw r14, #24608 // qa
    movt r12, #769  // q
	movw r11, #64769
	movt r11, #58632 // qinv
    .equ width, 4
    add.w r10, r0, #256*2
    _asymmetric_mul_16_loop:
    ldr.w r7, [r1, #width]
    ldr.w r4, [r1], #2*width
    ldr.w r8, [r2, #width]
    ldr.w r5, [r2], #2*width
    ldr.w r9, [r3, #width]
    ldr.w r6, [r3], #2*width

    smuad r6, r4, r6
    plant_red r12, r14, r11, r6
    smuadx r5, r4, r5
    plant_red r12, r14, r11, r5

    pkhtb r5, r5, r6, asr#16
    str.w r5, [r0], #width

	smuad r6, r7, r9
    plant_red r12, r14, r11, r6
    smuadx r8, r7, r8
    plant_red r12, r14, r11, r8

    pkhtb r8, r8, r6, asr#16
    str.w r8, [r0], #width

    cmp.w r0, r10
    bne.w _asymmetric_mul_16_loop

    pop.w {r4-r11, pc}