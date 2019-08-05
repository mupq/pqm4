// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.


// author: Markus Krausz
// date: 18.03.18
#include "ntt.h"
.syntax unified


// This code uses UMULL - which is constant time on the M4, but not on the M3
// Make sure that this code is never used on an M3
smlad r0,r0,r0,r0

// ##############################
// ##########   NTT    ##########
// ##############################

//CT butterfly with Montgomery reduction
.macro ct_butterfly_montg pol0, pol1, zeta, q, qinv, th, tl
      umull \tl, \th, \pol1, \zeta
      mul \pol1, \tl, \qinv
      umlal \tl, \th, \pol1, \q
      add \pol1, \pol0, \q, LSL #1
      sub \pol1, \pol1, \th
      add.w \pol0, \pol0, \th
.endm
	
//void ntt_asm(uint32_t *p);
.global ntt_asm
.align 2
ntt_asm:
	//bind aliases
	ptr_p 		.req R0
	ptr_zeta	.req R1
	qinv		.req R2
	q			.req R3
	cntr		.req R4
	pol0		.req R5
	pol1		.req R6
	pol2		.req R7
	pol3		.req R8
	temp_h		.req R9
	temp_l		.req R10
	zeta0       .req R11
	zeta1       .req R12
	zeta2       .req R14

	//preserve registers
	push {R1-R12, R14}
	//load constants, ptr
	ldr qinv, =# 4236238847
	ldr q	, =# 8380417
	ldr ptr_zeta, =#zetas_asm
	add ptr_zeta, #4

	//stage 1 and 2
	ldr cntr, =# 64
	ldr zeta0, [ptr_zeta], #4	//z1
	ldr zeta1, [ptr_zeta], #4	//z2
	ldr zeta2, [ptr_zeta], #4	//z3
	stage_1_2:
		ldr.w pol0, [ptr_p]
		ldr pol1, [ptr_p, #256]	//64*4
		ldr pol2, [ptr_p, #512]	//128*4
		ldr pol3, [ptr_p, #768]	//192*4
		ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l	//stage1
		ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l	//stage1
		ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l	//stage2
		ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l	//stage2
		str.w pol0, [ptr_p]
		str pol1, [ptr_p, #256]
		str pol2, [ptr_p, #512]
		str pol3, [ptr_p, #768]
		add ptr_p, #4
		subs cntr, #1
		bne stage_1_2
	sub ptr_p, #256			// on pol0 again

	//stage 3 and 4
	ldr cntr, =# 16
	ldr zeta0, [ptr_zeta], #4	//z4
	ldr zeta1, [ptr_zeta], #4	//z8
	ldr zeta2, [ptr_zeta], #4	//z9
	stage_3_4_a:
		ldr pol0, [ptr_p], #64	//16*4
		ldr pol1, [ptr_p], #64
		ldr pol2, [ptr_p], #64
		ldr pol3, [ptr_p], #-192	//(16*3)*4
		ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l	//stage3
		ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l	//stage3
		ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l	//stage4
		ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l	//stage4
		str pol0, [ptr_p], #64
		str pol1, [ptr_p], #64
		str pol2, [ptr_p], #64
		str pol3, [ptr_p], #-188	//(16*3-1)*4
		subs cntr, #1
		bne stage_3_4_a
	add ptr_p, #192			//(64-16)*4

	ldr cntr, =# 16
	ldr zeta0, [ptr_zeta], #4	//z5
	ldr zeta1, [ptr_zeta], #4	//z10
	ldr zeta2, [ptr_zeta], #4	//z11
	stage_3_4_b:
		ldr pol0, [ptr_p], #64	//16*4
		ldr pol1, [ptr_p], #64
		ldr pol2, [ptr_p], #64
		ldr pol3, [ptr_p], #-192	//(16*3)*4
		ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l	//stage3
		ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l	//stage3
		ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l	//stage4
		ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l	//stage4
		str pol0, [ptr_p], #64
		str pol1, [ptr_p], #64
		str pol2, [ptr_p], #64
		str pol3, [ptr_p], #-188	//(16*3-1)*4
		subs cntr, #1
		bne stage_3_4_b
	add ptr_p, #192			//(64-16)*4

	ldr cntr, =# 16
	ldr zeta0, [ptr_zeta], #4	//z6
	ldr zeta1, [ptr_zeta], #4	//z12
	ldr zeta2, [ptr_zeta], #4	//z13
	stage_3_4_c:
		ldr pol0, [ptr_p], #64	//16*4
		ldr pol1, [ptr_p], #64
		ldr pol2, [ptr_p], #64
		ldr pol3, [ptr_p], #-192	//(16*3)*4
		ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l	//stage3
		ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l	//stage3
		ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l	//stage4
		ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l	//stage4
		str pol0, [ptr_p], #64
		str pol1, [ptr_p], #64
		str pol2, [ptr_p], #64
		str pol3, [ptr_p], #-188	//(16*3-1)*4
		subs cntr, #1
		bne stage_3_4_c
	add ptr_p, #192			//(64-16)*4

	ldr cntr, =# 16
	ldr zeta0, [ptr_zeta], #4	//z7
	ldr zeta1, [ptr_zeta], #4	//z14
	ldr zeta2, [ptr_zeta], #4	//z15
	stage_3_4_d:
		ldr pol0, [ptr_p], #64	//16*4
		ldr pol1, [ptr_p], #64
		ldr pol2, [ptr_p], #64
		ldr pol3, [ptr_p], #-192	//(16*3)*4
		ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l	//stage3
		ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l	//stage3
		ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l	//stage4
		ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l	//stage4
		str pol0, [ptr_p], #64
		str pol1, [ptr_p], #64
		str pol2, [ptr_p], #64
		str pol3, [ptr_p], #-188	//(16*3-1)*4
		subs cntr, #1
		bne stage_3_4_d
	sub ptr_p, #832			//(208)*4

	//stage 5 and 6
	ldr cntr, =# 16
	stage_5_6:
		ldr zeta0, [ptr_zeta], #4	//z16, ..., z31
		ldr zeta1, [ptr_zeta], #4	//z32, ..., z62
		ldr zeta2, [ptr_zeta], #4	//z33, ..., z63

		ldr pol0, [ptr_p], #16	//4*4
		ldr pol1, [ptr_p], #16
		ldr pol2, [ptr_p], #16
		ldr pol3, [ptr_p], #-48	//(4*3)*4
		ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l	//stage5
		ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l	//stage5
		ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l	//stage6
		ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l	//stage6
		str pol0, [ptr_p], #16
		str pol1, [ptr_p], #16
		str pol2, [ptr_p], #16
		str pol3, [ptr_p], #-44	//(4*3-1)*4

		ldr pol0, [ptr_p], #16	//4*4
		ldr pol1, [ptr_p], #16
		ldr pol2, [ptr_p], #16
		ldr pol3, [ptr_p], #-48	//(4*3)*4
		ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l	//stage5
		ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l	//stage5
		ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l	//stage6
		ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l	//stage6
		str pol0, [ptr_p], #16
		str pol1, [ptr_p], #16
		str pol2, [ptr_p], #16
		str pol3, [ptr_p], #-44	//(4*3-1)*4

		ldr pol0, [ptr_p], #16	//4*4
		ldr pol1, [ptr_p], #16
		ldr pol2, [ptr_p], #16
		ldr pol3, [ptr_p], #-48	//(4*3)*4
		ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l	//stage5
		ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l	//stage5
		ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l	//stage6
		ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l	//stage6
		str pol0, [ptr_p], #16
		str pol1, [ptr_p], #16
		str pol2, [ptr_p], #16
		str pol3, [ptr_p], #-44	//(4*3-1)*4

		ldr pol0, [ptr_p], #16	//4*4
		ldr pol1, [ptr_p], #16
		ldr pol2, [ptr_p], #16
		ldr pol3, [ptr_p], #-48	//(4*3)*4
		ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l	//stage5
		ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l	//stage5
		ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l	//stage6
		ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l	//stage6
		str pol0, [ptr_p], #16
		str pol1, [ptr_p], #16
		str pol2, [ptr_p], #16
		str pol3, [ptr_p], #-44	//(4*3-1)*4

		add ptr_p, #48			//(16-4)*4
		subs.w cntr, #1
		bne stage_5_6
	sub ptr_p, #1024			//256*4

	//stage 7 and 8
	ldr cntr, =# 64
	stage_7_8:
		ldr zeta0, [ptr_zeta], #4	//z64, ..., z127
		ldr zeta1, [ptr_zeta], #4	//z128,..., z254
		ldr zeta2, [ptr_zeta], #4	//z129,..., z255
		ldr pol0, [ptr_p], #4	//1*4
		ldr pol1, [ptr_p], #4
		ldr pol2, [ptr_p], #4
		ldr pol3, [ptr_p], #-12	//3*4
		ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l	//stage7
		ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l	//stage7
		ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l	//stage8
		ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l	//stage8
		str pol0, [ptr_p], #4
		str pol1, [ptr_p], #4
		str pol2, [ptr_p], #4
		str pol3, [ptr_p], #4
		subs cntr, #1
		bne stage_7_8

    //restore registers
    pop {R1-R12, PC}

    //unbind aliases
    .unreq ptr_p
    .unreq ptr_zeta
    .unreq qinv
    .unreq q
    .unreq cntr
    .unreq pol0
    .unreq pol1
    .unreq pol2
    .unreq pol3
    .unreq temp_h
    .unreq temp_l
    .unreq zeta0
    .unreq zeta1
    .unreq zeta2


// ##############################
// ##########  NTT^-1  ##########
// ##############################

//GS butterfly with Montgomery reduction
.macro gs_butterfly_montg pol0, pol1, zeta, q, qinv, x, y
      add \x, \pol0, \q, LSL#8
      sub \x, \x, \pol1
      add.w \pol0, \pol0, \pol1
      umull \y, \pol1, \x, \zeta
      mul \x, \y, \qinv
      umlal \y, \pol1, \x, \q
.endm

// Montgomery reduction
.macro montg_red f, pol, q, qinv, x, y
	umull \y, \pol, \pol, \f
	mul \x, \y, \qinv
	umlal \y, \pol, \x, \q
.endm

//void inv_ntt_asm(uint32_t *p);
.global inv_ntt_asm
.align 2
inv_ntt_asm:
	//bind aliases
	ptr_p 		.req R0
	ptr_zeta	.req R1
	qinv		.req R2
	q			.req R3
	cntr		.req R4
	pol0		.req R5
	pol1		.req R6
	pol2		.req R7
	pol3		.req R8
	temp_h		.req R9
	temp_l		.req R10
	zeta0       .req R11
	zeta1       .req R12
	zeta2       .req R14

	//preserve registers
	push {R1-R12, R14}
	//load constants, ptr
	ldr qinv, =# 4236238847
	ldr q	, =# 8380417
	ldr ptr_zeta, =#zetas_inv_asm

	//stage 1 and 2
	ldr cntr, =# 64
	inv_stage_1_2:
		ldr zeta0, [ptr_zeta], #4	//z0, ..., z126
		ldr zeta1, [ptr_zeta], #4	//z1, ..., z127
		ldr zeta2, [ptr_zeta], #4	//z128,.., z191
		ldr pol0, [ptr_p], #4	//1*4
		ldr pol1, [ptr_p], #4
		ldr pol2, [ptr_p], #4
		ldr pol3, [ptr_p], #-12	//3*4
		gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l	//stage1
		gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l	//stage1
		gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l	//stage2
		gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l	//stage2
		str pol0, [ptr_p], #4
		str pol1, [ptr_p], #4
		str pol2, [ptr_p], #4
		str pol3, [ptr_p], #4
		subs cntr, #1
		bne inv_stage_1_2
	sub ptr_p, #1024			// on pol0 again

	//stage 3 and 4
	ldr cntr, =# 16
	inv_stage_3_4:
		ldr zeta0, [ptr_zeta], #4
		ldr zeta1, [ptr_zeta], #4
		ldr zeta2, [ptr_zeta], #4

		ldr pol0, [ptr_p], #16	//4*4
		ldr pol1, [ptr_p], #16
		ldr pol2, [ptr_p], #16
		ldr pol3, [ptr_p], #-48	//(4*3)*4
		gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l	//stage3
		gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l	//stage3
		gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l	//stage4
		gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l	//stage4
		str pol0, [ptr_p], #16
		str pol1, [ptr_p], #16
		str pol2, [ptr_p], #16
		str pol3, [ptr_p], #-44	//(4*3-1)*4

		ldr pol0, [ptr_p], #16	//4*4
		ldr pol1, [ptr_p], #16
		ldr pol2, [ptr_p], #16
		ldr pol3, [ptr_p], #-48	//(4*3)*4
		gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l	//stage3
		gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l	//stage3
		gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l	//stage4
		gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l	//stage4
		str pol0, [ptr_p], #16
		str pol1, [ptr_p], #16
		str pol2, [ptr_p], #16
		str pol3, [ptr_p], #-44	//(4*3-1)*4

		ldr pol0, [ptr_p], #16	//4*4
		ldr pol1, [ptr_p], #16
		ldr pol2, [ptr_p], #16
		ldr pol3, [ptr_p], #-48	//(4*3)*4
		gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l	//stage3
		gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l	//stage3
		gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l	//stage4
		gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l	//stage4
		str pol0, [ptr_p], #16
		str pol1, [ptr_p], #16
		str pol2, [ptr_p], #16
		str pol3, [ptr_p], #-44	//(4*3-1)*4

		ldr pol0, [ptr_p], #16	//4*4
		ldr pol1, [ptr_p], #16
		ldr pol2, [ptr_p], #16
		ldr pol3, [ptr_p], #-48	//(4*3)*4
		gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l	//stage3
		gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l	//stage3
		gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l	//stage4
		gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l	//stage4
		str pol0, [ptr_p], #16
		str pol1, [ptr_p], #16
		str pol2, [ptr_p], #16
		str pol3, [ptr_p], #-44	//(4*3-1)*4

		add ptr_p, #48			//(16-4)*4
		subs.w cntr, #1
		bne inv_stage_3_4
	sub ptr_p, #1024			//256*4

	//stage 5 and 6
	ldr cntr, =# 16
	ldr zeta0, [ptr_zeta], #4
	ldr zeta1, [ptr_zeta], #4
	ldr zeta2, [ptr_zeta], #4
	inv_stage_5_6_a:
		ldr pol0, [ptr_p], #64	//16*4
		ldr pol1, [ptr_p], #64
		ldr pol2, [ptr_p], #64
		ldr pol3, [ptr_p], #-192	//(16*3)*4
		gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l	//stage5
		gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l	//stage5
		gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l	//stage6
		gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l	//stage6
		str pol0, [ptr_p], #64
		str pol1, [ptr_p], #64
		str pol2, [ptr_p], #64
		str pol3, [ptr_p], #-188	//(16*3-1)*4
		subs cntr, #1
		bne inv_stage_5_6_a
	add ptr_p, #192			//(64-16)*4

	ldr cntr, =# 16
	ldr zeta0, [ptr_zeta], #4
	ldr zeta1, [ptr_zeta], #4
	ldr zeta2, [ptr_zeta], #4
	inv_stage_5_6_b:
		ldr pol0, [ptr_p], #64	//16*4
		ldr pol1, [ptr_p], #64
		ldr pol2, [ptr_p], #64
		ldr pol3, [ptr_p], #-192	//(16*3)*4
		gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l	//stage5
		gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l	//stage5
		gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l	//stage6
		gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l	//stage6
		str pol0, [ptr_p], #64
		str pol1, [ptr_p], #64
		str pol2, [ptr_p], #64
		str pol3, [ptr_p], #-188	//(16*3-1)*4
		subs cntr, #1
		bne inv_stage_5_6_b
	add ptr_p, #192			//(64-16)*4

	ldr cntr, =# 16
	ldr zeta0, [ptr_zeta], #4
	ldr zeta1, [ptr_zeta], #4
	ldr zeta2, [ptr_zeta], #4
	inv_stage_5_6_c:
		ldr pol0, [ptr_p], #64	//16*4
		ldr pol1, [ptr_p], #64
		ldr pol2, [ptr_p], #64
		ldr pol3, [ptr_p], #-192	//(16*3)*4
		gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l	//stage5
		gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l	//stage5
		gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l	//stage6
		gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l	//stage6
		str pol0, [ptr_p], #64
		str pol1, [ptr_p], #64
		str pol2, [ptr_p], #64
		str pol3, [ptr_p], #-188	//(16*3-1)*4
		subs cntr, #1
		bne inv_stage_5_6_c
	add ptr_p, #192			//(64-16)*4

	ldr cntr, =# 16
	ldr zeta0, [ptr_zeta], #4
	ldr zeta1, [ptr_zeta], #4
	ldr zeta2, [ptr_zeta], #4
	inv_stage_5_6_d:
		ldr pol0, [ptr_p], #64	//16*4
		ldr pol1, [ptr_p], #64
		ldr pol2, [ptr_p], #64
		ldr pol3, [ptr_p], #-192	//(16*3)*4
		gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l	//stage5
		gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l	//stage5
		gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l	//stage6
		gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l	//stage6
		str pol0, [ptr_p], #64
		str pol1, [ptr_p], #64
		str pol2, [ptr_p], #64
		str pol3, [ptr_p], #-188	//(16*3-1)*4
		subs cntr, #1
		bne inv_stage_5_6_d
	sub ptr_p, #832			//(208)*4

	//stage 7 and 8
	ldr cntr, =# 64
	ldr zeta0, [ptr_zeta], #4
	ldr zeta1, [ptr_zeta], #4
	ldr zeta2, [ptr_zeta], #4
	ldr ptr_zeta, =# 41978 //ptr_zeta not needed anymore, contains now value f for final reduction
	inv_stage_7_8:
		ldr pol0, [ptr_p]
		ldr pol1, [ptr_p, #256]	//64*4
		ldr pol2, [ptr_p, #512]	//128*4
		ldr pol3, [ptr_p, #768]	//192*4
		gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l	//stage7
		gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l	//stage7
		gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l	//stage8
		gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l	//stage8
		montg_red ptr_zeta, pol0, q, qinv, temp_h, temp_l				//final reduction
		montg_red ptr_zeta, pol1, q, qinv, temp_h, temp_l				//final reduction
		montg_red ptr_zeta, pol2, q, qinv, temp_h, temp_l				//final reduction
		montg_red ptr_zeta, pol3, q, qinv, temp_h, temp_l				//final reduction
		str.w pol0, [ptr_p]
		str pol1, [ptr_p, #256]
		str pol2, [ptr_p, #512]
		str pol3, [ptr_p, #768]
		add ptr_p, #4
		subs cntr, #1
		bne inv_stage_7_8

    //restore registers
    pop {R1-R12, PC}

    //unbind aliases
    .unreq ptr_p
    .unreq ptr_zeta
    .unreq qinv
    .unreq q
    .unreq cntr
    .unreq pol0
    .unreq pol1
    .unreq pol2
    .unreq pol3
    .unreq temp_h
    .unreq temp_l
    .unreq zeta0
    .unreq zeta1
    .unreq zeta2

