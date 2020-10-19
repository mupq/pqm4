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
.syntax unified


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

//void ntt_asm_smull(int32_t p[N], const uint32_t zetas_asm[N]);
.global ntt_asm_smull
.type ntt_asm_smull,%function
.align 2
ntt_asm_smull:
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
  sub \x, \pol0, \pol1  //sub \x, \x, \pol1
  add.w \pol0, \pol0, \pol1
  smull \y, \pol1, \x, \zeta //umull \y, \pol1, \x, \zeta
  mul \x, \y, \qinv  //qinv is -qinv
  smlal \y, \pol1, \x, \q //umlal \y, \pol1, \x, \q
.endm

// Montgomery reduction -- SIGNED
.macro montg_red f, pol, q, qinv, x, y
  smull \y, \pol, \pol, \f //umull \y, \pol, \pol, \f
  mul \x, \y, \qinv   //qinv is -qinv
  smlal \y, \pol, \x, \q //umlal \y, \pol, \x, \q
.endm

//void inv_ntt_asm_smull(int32_t p[N], const uint32_t zetas_inv_asm[N]);
.global inv_ntt_asm_smull
.type inv_ntt_asm_smull,%function
.align 2
inv_ntt_asm_smull:
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

  //stage 1 and 2
  ldr.w cntr, inv_ntt_asm_smull_64
  1:
    ldr.w zeta1, [ptr_zeta, #4]  //z1, ..., z127
    ldr.w zeta2, [ptr_zeta, #8]  //z128,.., z191
    ldr zeta0, [ptr_zeta], #12  //z0, ..., z126
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
    ldr.w zeta1, [ptr_zeta, #4]
    ldr.w zeta2, [ptr_zeta, #8]
    ldr zeta0, [ptr_zeta], #12

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
  ldr.w zeta1, [ptr_zeta, #4]
  ldr.w zeta2, [ptr_zeta, #8]
  ldr zeta0, [ptr_zeta], #12
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
  ldr.w zeta1, [ptr_zeta, #4]
  ldr.w zeta2, [ptr_zeta, #8]
  ldr zeta0, [ptr_zeta], #12
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
  ldr.w zeta1, [ptr_zeta, #4]
  ldr.w zeta2, [ptr_zeta, #8]
  ldr zeta0, [ptr_zeta], #12
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
  ldr.w zeta1, [ptr_zeta, #4]
  ldr.w zeta2, [ptr_zeta, #8]
  ldr zeta0, [ptr_zeta], #12
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
  ldr.w zeta1, [ptr_zeta, #4]
  ldr.w zeta2, [ptr_zeta, #8]
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
    // zeta2 is 3975713 instead of 8354570 (3975713 = (8354570 * 16382) % Q)

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
