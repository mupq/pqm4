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

// reuse of the NTT zeta table also for NTT^-1
// added by Marco Palumbi (marco@palumbi.it)
// date: 21.12.20

.syntax unified


// This code uses UMULL - which is constant time on the M4, but not on the M3
// Make sure that this code is never used on an M3
smlad r0,r0,r0,r0

// ##############################
// ##########   NTT    ##########
// ##############################

//CT butterfly with Montgomery reduction  -- SIGNED
.macro ct_butterfly_montg pol0, pol1, zeta, q, qinv, th, tl
  smull \tl, \th, \pol1, \zeta
  mul \pol1, \tl, \qinv  // q is -qinv
  smlal \tl, \th, \pol1, \q
  sub \pol1, \pol0, \th
  add.w \pol0, \pol0, \th
.endm

//void pqcrystals_dilithium_ntt(int32_t p[N]);
.global pqcrystals_dilithium_ntt
.type pqcrystals_dilithium_ntt,%function
.align 2
pqcrystals_dilithium_ntt:
  //bind aliases
  ptr_p     .req R0
  ptr_zeta  .req R1
  qinv      .req R2
  q         .req R3
  cntr      .req R4
  pol0      .req R5
  pol1      .req R6
  pol2      .req R7
  pol3      .req R8
  temp_h    .req R9
  temp_l    .req R10
  zeta0     .req R11
  zeta1     .req R12
  zeta2     .req R14

  //preserve registers
  push {R4-R11, R14}
  ldr ptr_zeta, =#zetas_interleaved_asm
  add ptr_zeta, #4
  //load constants, ptr
  ldr.w qinv, inv_ntt_asm_smull_qinv  //-qinv_signed
  ldr.w q, inv_ntt_asm_smull_q
  //stage 1 and 2
  ldr.w cntr, inv_ntt_asm_smull_64

  ldr zeta1, [ptr_zeta, #4]  //z2
  ldr zeta2, [ptr_zeta, #8]  //z3
  ldr zeta0, [ptr_zeta], #12  //z1
  1:
    ldr.w pol0, [ptr_p]
    ldr pol1, [ptr_p, #256]  //64*4
    ldr pol2, [ptr_p, #512]  //128*4
    ldr pol3, [ptr_p, #768]  //192*4
    ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l  //stage1
    ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l  //stage1
    ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l  //stage2
    ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l  //stage2

    str pol1, [ptr_p, #256]
    str pol2, [ptr_p, #512]
    str pol3, [ptr_p, #768]
    str pol0, [ptr_p], #4
    subs cntr, #1
    bne 1b
  sub ptr_p, #256      // on pol0 again

  //stage 3 and 4
  movw cntr, #16
  ldr zeta1, [ptr_zeta, #4]  //z8
  ldr zeta2, [ptr_zeta, #8]  //z9
  ldr zeta0, [ptr_zeta], #12  //z4
  1:
    ldr.w pol0, [ptr_p]  //16*4
    ldr.w pol1, [ptr_p, #64]
    ldr.w pol2, [ptr_p, #128]
    ldr.w pol3, [ptr_p, #192]
    ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l  //stage3
    ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l  //stage3
    ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l  //stage4
    ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l  //stage4

    str.w pol1, [ptr_p, #64]
    str.w pol2, [ptr_p, #128]
    str.w pol3, [ptr_p, #192]
    str pol0, [ptr_p], #4
    subs cntr, #1
    bne 1b
  add.w ptr_p, ptr_p, #192      //(64-16)*4

  movw cntr, #16
  ldr zeta1, [ptr_zeta, #4]  //z10
  ldr zeta2, [ptr_zeta, #8]  //z11
  ldr zeta0, [ptr_zeta], #12  //z5
  1:
    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #64]
    ldr.w pol2, [ptr_p, #128]
    ldr.w pol3, [ptr_p, #192]
    ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l  //stage3
    ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l  //stage3
    ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l  //stage4
    ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l  //stage4

    str.w pol1, [ptr_p, #64]
    str.w pol2, [ptr_p, #128]
    str.w pol3, [ptr_p, #192]  //(16*3-1)*4
    str pol0, [ptr_p], #4
    subs cntr, #1
    bne 1b
  add ptr_p, ptr_p, #192      //(64-16)*4

  movw cntr, #16

  ldr.w zeta1, [ptr_zeta, #4]  //z12
  ldr.w zeta2, [ptr_zeta, #8]  //z13
  ldr zeta0, [ptr_zeta], #12  //z6
  1:
    ldr.w pol0, [ptr_p]  //16*4
    ldr.w pol1, [ptr_p, #64]
    ldr.w pol2, [ptr_p, #128]
    ldr.w pol3, [ptr_p, #192]  //(16*3)*4
    ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l  //stage3
    ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l  //stage3
    ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l  //stage4
    ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l  //stage4
    str.w pol1, [ptr_p, #64]
    str.w pol2, [ptr_p, #128]
    str.w pol3, [ptr_p, #192]
    str pol0, [ptr_p], #4
    subs cntr, #1
    bne 1b
  add ptr_p, #192      //(64-16)*4

  movw cntr, #16
  ldr.w zeta1, [ptr_zeta, #4]  //z14
  ldr.w zeta2, [ptr_zeta, #8]  //z15
  ldr zeta0, [ptr_zeta], #12  //z7
  1:
    ldr.w pol0, [ptr_p]  //16*4
    ldr.w pol1, [ptr_p, #64]
    ldr.w pol2, [ptr_p, #128]
    ldr.w pol3, [ptr_p, #192]
    ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l  //stage3
    ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l  //stage3
    ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l  //stage4
    ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l  //stage4
    str.w pol1, [ptr_p, #64]
    str.w pol2, [ptr_p, #128]
    str.w pol3, [ptr_p, #192] //(16*3-1)*4
    str pol0, [ptr_p], #4
    subs cntr, #1
    bne 1b
  sub ptr_p, #832      //(208)*4

  //stage 5 and 6
  movw cntr, #16
  1:
    ldr.w zeta1, [ptr_zeta, #4]  //z32, ..., z62
    ldr.w zeta2, [ptr_zeta, #8]  //z33, ..., z63
    ldr zeta0, [ptr_zeta], #12  //z16, ..., z31

    ldr.w pol0, [ptr_p]  //4*4
    ldr.w pol1, [ptr_p, #16]
    ldr.w pol2, [ptr_p, #32]
    ldr.w pol3, [ptr_p, #48]  //(4*3)*4
    ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l  //stage5
    ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l  //stage5
    ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l  //stage6
    ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l  //stage6

    str.w pol1, [ptr_p, #16]
    str.w pol2, [ptr_p, #32]
    str.w pol3, [ptr_p, #48]  //(4*3-1)*4
    str pol0, [ptr_p], #4

    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #16]
    ldr.w pol2, [ptr_p, #32]
    ldr.w pol3, [ptr_p, #48]
    ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l  //stage5
    ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l  //stage5
    ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l  //stage6
    ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l  //stage6

    str.w pol1, [ptr_p, #16]
    str.w pol2, [ptr_p, #32]
    str.w pol3, [ptr_p, #48]
    str pol0, [ptr_p], #4

    ldr.w pol0, [ptr_p] //4*4
    ldr.w pol1, [ptr_p, #16]
    ldr.w pol2, [ptr_p, #32]
    ldr.w pol3, [ptr_p, #48]
    ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l  //stage5
    ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l  //stage5
    ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l  //stage6
    ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l  //stage6

    str.w pol1, [ptr_p, #16]
    str.w pol2, [ptr_p, #32]
    str.w pol3, [ptr_p, #48] //(4*3-1)*4
    str pol0, [ptr_p], #4

    ldr.w pol0, [ptr_p]  //4*4
    ldr.w pol1, [ptr_p, #16]
    ldr.w pol2, [ptr_p, #32]
    ldr.w pol3, [ptr_p, #48]  //(4*3)*4
    ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l  //stage5
    ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l  //stage5
    ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l  //stage6
    ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l  //stage6

    str.w pol1, [ptr_p, #16]
    str.w pol2, [ptr_p, #32]
    str.w pol3, [ptr_p, #48]
    str pol0, [ptr_p], #52

    subs.w cntr, cntr, #1
    bne 1b
  sub ptr_p, #1024      //256*4

  //stage 7 and 8
  mov cntr, #64
  1:

    ldr.w zeta1, [ptr_zeta, #4]  //z128,..., z254
    ldr.w zeta2, [ptr_zeta, #8]  //z129,..., z255
    ldr zeta0, [ptr_zeta], #12  //z64, ..., z127
    ldr.w pol0, [ptr_p]  //1*4
    ldr.w pol1, [ptr_p, #4]
    ldr.w pol2, [ptr_p, #8]
    ldr.w pol3, [ptr_p, #12]  //3*4
    ct_butterfly_montg pol0, pol2, zeta0, q, qinv, temp_h, temp_l  //stage7
    ct_butterfly_montg pol1, pol3, zeta0, q, qinv, temp_h, temp_l  //stage7
    ct_butterfly_montg pol0, pol1, zeta1, q, qinv, temp_h, temp_l  //stage8
    ct_butterfly_montg pol2, pol3, zeta2, q, qinv, temp_h, temp_l  //stage8

    str.w pol1, [ptr_p, #4]
    str.w pol2, [ptr_p, #8]
    str.w pol3, [ptr_p, #12]
    str pol0, [ptr_p], #16
    subs cntr, #1
    bne 1b

    //restore registers
    pop {R4-R11, PC}

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

//GS butterfly with Montgomery reduction  -- SIGNED
.macro gs_butterfly_montg pol0, pol1, zeta, q, qinv, x, y
  sub \x, \pol1, \pol0         // x= -(pol0 - pol1)
  add.w \pol0, \pol0, \pol1
  smull \y, \pol1, \x, \zeta   // -(pol0-pol1)*zeta -> (pol0-pol1)*(-zeta)
  mul \x, \y, \qinv  //qinv is -qinv
  smlal \y, \pol1, \x, \q
.endm

// Montgomery reduction -- SIGNED
.macro montg_red f, pol, q, qinv, x, y
  smull \y, \pol, \pol, \f
  mul \x, \y, \qinv
  smlal \y, \pol, \x, \q
.endm

//void pqcrystals_dilithium_invntt_tomont(int32_t p[N]);
.global pqcrystals_dilithium_invntt_tomont
.type pqcrystals_dilithium_invntt_tomont,%function
.align 2
pqcrystals_dilithium_invntt_tomont:
  //bind aliases
  ptr_p     .req R0
  ptr_zeta  .req R1
  qinv      .req R2
  q         .req R3
  cntr      .req R4
  pol0      .req R5
  pol1      .req R6
  pol2      .req R7
  pol3      .req R8
  temp_h    .req R9
  temp_l    .req R10
  zeta0     .req R11
  zeta1     .req R12
  zeta2     .req R14

  //preserve registers
  push {R4-R11, R14}
  //load constants, ptr
  ldr.w qinv, inv_ntt_asm_smull_qinv  //-qinv_signed
  ldr.w q  , inv_ntt_asm_smull_q
  ldr ptr_zeta, =#zetas_interleaved_asm + 1020  // &zetas_interleaved_asm[N-1]

  //stage 1 and 2
  ldr.w cntr, inv_ntt_asm_smull_64
  1:
    ldr.w zeta1, [ptr_zeta, #-4]  //z1, ..., z127
    ldr.w zeta2, [ptr_zeta, #-8]  //z128,.., z191
    ldr zeta0, [ptr_zeta], #-12  //z0, ..., z126
    ldr.w pol0, [ptr_p]  //1*4
    ldr.w pol1, [ptr_p, #4]
    ldr.w pol2, [ptr_p, #8]
    ldr.w pol3, [ptr_p, #12]  //3*4
    gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l  //stage1
    gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l  //stage1
    gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l  //stage2
    gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l  //stage2
    str.w pol1, [ptr_p, #4]
    str.w pol2, [ptr_p, #8]
    str.w pol3, [ptr_p, #12]
    str pol0, [ptr_p], #16
    subs cntr, #1
    bne 1b
  sub ptr_p, #1024      // on pol0 again

  //stage 3 and 4
  movw cntr, #16
  1:
    ldr.w zeta1, [ptr_zeta, #-4]
    ldr.w zeta2, [ptr_zeta, #-8]
    ldr zeta0, [ptr_zeta], #-12

    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #16]
    ldr.w pol2, [ptr_p, #32]
    ldr.w pol3, [ptr_p, #48]
    gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l  //stage3
    gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l  //stage3
    gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l  //stage4
    gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l  //stage4

    str.w pol1, [ptr_p, #16]
    str.w pol2, [ptr_p, #32]
    str.w pol3, [ptr_p, #48]
    str pol0, [ptr_p], #4

    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #16]
    ldr.w pol2, [ptr_p, #32]
    ldr.w pol3, [ptr_p, #48]
    gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l  //stage3
    gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l  //stage3
    gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l  //stage4
    gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l  //stage4

    str.w pol1, [ptr_p, #16]
    str.w pol2, [ptr_p, #32]
    str.w pol3, [ptr_p, #48]
    str pol0, [ptr_p], #4

    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #16]
    ldr.w pol2, [ptr_p, #32]
    ldr.w pol3, [ptr_p, #48]
    gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l  //stage3
    gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l  //stage3
    gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l  //stage4
    gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l  //stage4

    str.w pol1, [ptr_p, #16]
    str.w pol2, [ptr_p, #32]
    str.w pol3, [ptr_p, #48] //(4*3-1)*4
    str pol0, [ptr_p], #4

    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #16]
    ldr.w pol2, [ptr_p, #32]
    ldr.w pol3, [ptr_p, #48]
    gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l  //stage3
    gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l  //stage3
    gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l  //stage4
    gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l  //stage4
    str.w pol1, [ptr_p, #16]
    str.w pol2, [ptr_p, #32]
    str.w pol3, [ptr_p, #48]
    str pol0, [ptr_p], #52
    subs.w cntr, cntr, #1
    bne 1b
  sub ptr_p, #1024      //256*4

  //stage 5 and 6
  movw cntr, #16
  ldr.w zeta1, [ptr_zeta, #-4]
  ldr.w zeta2, [ptr_zeta, #-8]
  ldr zeta0, [ptr_zeta], #-12
  1:
    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #64]
    ldr.w pol2, [ptr_p, #128]
    ldr.w pol3, [ptr_p, #192]
    gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l  //stage5
    gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l  //stage5
    gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l  //stage6
    gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l  //stage6

    str.w pol1, [ptr_p, #64]
    str.w pol2, [ptr_p, #128]
    str.w pol3, [ptr_p, #192] //(16*3-1)*4
    str pol0, [ptr_p], #4
    subs cntr, #1
    bne 1b
  add ptr_p, #192      //(64-16)*4

  movw cntr, #16
  ldr.w zeta1, [ptr_zeta, #-4]
  ldr.w zeta2, [ptr_zeta, #-8]
  ldr zeta0, [ptr_zeta], #-12
  1:
    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #64]
    ldr.w pol2, [ptr_p, #128]
    ldr.w pol3, [ptr_p, #192]
    gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l  //stage5
    gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l  //stage5
    gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l  //stage6
    gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l  //stage6
    str.w pol1, [ptr_p, #64]
    str.w pol2, [ptr_p, #128]
    str.w pol3, [ptr_p, #192]
    str pol0, [ptr_p], #4
    subs cntr, #1
    bne 1b
  add.w ptr_p, ptr_p, #192      //(64-16)*4

  movw cntr, #16
  ldr.w zeta1, [ptr_zeta, #-4]
  ldr.w zeta2, [ptr_zeta, #-8]
  ldr zeta0, [ptr_zeta], #-12
  1:
    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #64]
    ldr.w pol2, [ptr_p, #128]
    ldr.w pol3, [ptr_p, #192]
    gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l  //stage5
    gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l  //stage5
    gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l  //stage6
    gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l  //stage6
    str.w pol1, [ptr_p, #64]
    str.w pol2, [ptr_p, #128]
    str.w pol3, [ptr_p, #192]
    str pol0, [ptr_p], #4
    subs cntr, #1
    bne 1b
  add ptr_p, #192      //(64-16)*4

  movw cntr, #16
  ldr.w zeta1, [ptr_zeta, #-4]
  ldr.w zeta2, [ptr_zeta, #-8]
  ldr zeta0, [ptr_zeta], #-12
  1:
    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #64]
    ldr.w pol2, [ptr_p, #128]
    ldr.w pol3, [ptr_p, #192]
    gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l  //stage5
    gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l  //stage5
    gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l  //stage6
    gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l  //stage6
    str.w pol1, [ptr_p, #64]
    str.w pol2, [ptr_p, #128]
    str.w pol3, [ptr_p, #192]
    str pol0, [ptr_p], #4
    subs cntr, #1
    bne 1b
  sub ptr_p, #832      //(208)*4

  //stage 7 and 8
  movw cntr, #64
  ldr.w zeta0, [ptr_zeta]
  ldr.w zeta1, [ptr_zeta, #-4]
  ldr.w zeta2, [ptr_zeta, #-12] // zetas_interleaved_asm[0] = 4404704
  ldr.w ptr_zeta, inv_ntt_asm_smull_f //ptr_zeta not needed anymore, contains now value f for final reduction
  1:
    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #256]  //64*4
    ldr.w pol2, [ptr_p, #512]  //128*4
    ldr.w pol3, [ptr_p, #768]  //192*4
    gs_butterfly_montg pol0, pol1, zeta0, q, qinv, temp_h, temp_l  //stage7
    gs_butterfly_montg pol2, pol3, zeta1, q, qinv, temp_h, temp_l  //stage7
    gs_butterfly_montg pol0, pol2, zeta2, q, qinv, temp_h, temp_l  //stage8
    gs_butterfly_montg pol1, pol3, zeta2, q, qinv, temp_h, temp_l  //stage8
    montg_red ptr_zeta, pol0, q, qinv, temp_h, temp_l        //final reduction
    montg_red ptr_zeta, pol1, q, qinv, temp_h, temp_l        //final reduction

    // We can save the multiplication by f here by instead pre-computing it and putting it into the
    // twiddle factor of the previous butterfly
    // zeta2 is 4404704 instead of 25847 (4404704 = (25847 * 16382) % Q)

    //montg_red ptr_zeta, pol2, q, qinv, temp_h, temp_l        //final reduction
    //montg_red ptr_zeta, pol3, q, qinv, temp_h, temp_l        //final reduction
    str.w pol1, [ptr_p, #256]
    str.w pol2, [ptr_p, #512]
    str.w pol3, [ptr_p, #768]
    str pol0, [ptr_p], #4
    subs cntr, #1
    bne 1b

    //restore registers
    pop {R4-R11, PC}

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

.align 2
inv_ntt_asm_smull_f:
.word 41978
.align 2
inv_ntt_asm_smull_qinv:
.word 0xfc7fdfff
.align 2
inv_ntt_asm_smull_q:
.word 8380417
.align 2
inv_ntt_asm_smull_64:
.word 64


.section .rodata
/* Roots of unity in order needed by forward ntt */
.type zetas_interleaved_asm, %object
.align 2
zetas_interleaved_asm:
.word 4404704, 25847, -2608894, -518909, 237124, 1826347, 2353451, -777960, -359251, -2091905, -876248, 3119733, -2884855, 466468, 3111497, 2680103, 2725464, 2706023, 95776, 1024112, 3077325, 3530437, -1079900, -1661693, -3592148, 3585928, -2537516, 3915439, -549488, -3861115, -3043716, -1119584, 3574422, -2867647, 2619752, 3539968, -300467, -2108549, 2348700, -539299, -2118186, -1699267, -1643818, -3859737, 3505694, -3821735, -1399561, 3507263, -2140649, -3277672, -1600420, 3699596, 1757237, 811944, 531354, -19422, 954230, 3881043, 4010497, 3900724, -2556880, 280005, 2071892, -2797779, -3930395, 2091667, 3407706, -1528703, 2316500, 3817976, -3677745, -3342478, 2244091, -3041255, -2446433, -3562462, -1452451, 266997, 2434439, 3475950, -1235728, 3513181, 2176455, -3520352, -3759364, -1585221, -1197226, -3193378, -1257611, 900702, 1859098, 1939314, 909542, 819034, -4083598, 495491, -1613174, -1000202, -43260, -522500, -3190144, -655327, -3122442, -3157330, 2031748, 3207046, -3632928, -3556995, -525098, 126922, -768622, -3595838, 3412210, 342297, 286988, -983419, -2437823, 4108315, 2147896, 3437287, -3342277, 2715295, 1735879, 203044, -2967645, 2842341, 2691481, -3693493, -2590150, 1265009, -411027, 4055324, 1247620, -2477047, 2486353, 1595974, -671102, -3767016, 1250494, -1228525, 2635921, -3548272, -22981, -2994039, 1869119, -1308169, 1903435, -1050970, -381987, -1333058, 1237275, 1349076, -3318210, -1430225, 1852771, -451100, 1312455, -1430430, 3306115, -1962642, -3343383, -1279661, 1917081, 264944, -2546312, -1374803, 508951, 1500165, 777191, 3097992, 2235880, 3406031, 44288, -542412, -2831860, -1100098, -1671176, -1846953, 904516, -2584293, -3724270, 3958618, 594136, -3776993, -3724342, -2013608, 2432395, -8578, 2454455, -164721, 1653064, 1957272, 3369112, -3249728, 185531, -1207385, 2389356, -3183426, 162844, -210977, 1616392, 3014001, 759969, 810149, 1652634, -1316856, -3694233, -1799107, 189548, -3038916, 3523897, -3553272, 3866901, 269760, 3159746, 2213111, -975884, -1851402, 1717735, 472078, -2409325, -426683, 1723600, -177440, -1803090, 1910376, 1315589, -1667432, -1104333, 1341330, -260646, -3833893, 1285669, -2939036, -2235985, -1584928, -420899, -2286327, -812732, 183443, -976891, -1439742, 1612842, -3545687, -3019102, -554416, 3919660, -3881060, -48306, -1362209, -3628969, 3937738, 1400424, 3839961, -846154, 1976782
.size zetas_interleaved_asm,.-zetas_interleaved_asm
