// based on code by: Markus Krausz (18.03.18)
// date 23.07.21: Now licensed under CC0 with permission of the authors.
/* from Dilithium2 with cosmetic changes */

.syntax unified
#include "header_macros.i"
#include "ntt332_macros.i"

// This code uses UMULL - which is constant time on the M4, but not on the M3
// Make sure that this code is never used on an M3
smlad r0,r0,r0,r0


// ################################################################
// ############          CONFIGURATION          ###################
// ################################################################

#define CHOICE_OF_PRIME 2

#if CHOICE_OF_PRIME == 1
// Dilithium:
  #define FORWARD_NTT_TWIDDLE_TABLE zetas_new332
  #define INVERSE_NTT_TWIDDLE_TABLE zetas_new332inv
  #define Q_VALUE 8380417 
  #define INVERSE_NEG_Q_VALUE 0xfc7fdfff
#endif /* CHOICE_OF_PRIME == 1 */

#if CHOICE_OF_PRIME == 2
// HAETAE with Q = 64513 = 0xFC01
  #define FORWARD_NTT_TWIDDLE_TABLE twiddles_332_0xFC01
  #define INVERSE_NTT_TWIDDLE_TABLE twiddles_inv332_0xFC01
  #define Q_VALUE 64513 
  #define INVERSE_NEG_Q_VALUE 0xC7F0FBFF
#endif /* CHOICE_OF_PRIME == 2 */

// ################################################################
// ############        END CONFIGURATION        ###################
// ################################################################


// ##############################
// ##########   NTT    ##########
// ##############################

//void haetae_ntt332(int32_t p[N]);
.global haetae_ntt332
.type haetae_ntt332,%function
.align 2
haetae_ntt332:
  //bind aliases
  ptr_p     .req R0
  ptr_zeta  .req R1
  zeta      .req R1
  qinv      .req R2
  q         .req R3
  cntr      .req R4
  pol4      .req R4
  pol0      .req R5
  pol1      .req R6
  pol2      .req R7
  pol3      .req R8
  temp_h    .req R9
  temp_l    .req R10
  zeta0     .req R11
  zeta1     .req R12
  zeta2     .req R14
  pol5     .req R11
  pol6     .req R12
  pol7     .req R14

  //preserve registers
  push {R4-R11, R14}
  
  //load constants, ptr
  ldr.w qinv, inv_ntt_asm_smull_qinv  //-qinv_signed
  ldr.w q, inv_ntt_asm_smull_q

  //stage 1 - 3
  .equ distance, 512
  .equ strincr, 4
  
  ldr ptr_zeta, =#FORWARD_NTT_TWIDDLE_TABLE
  vldm ptr_zeta!, {s2-s8} 
  vmov s0, ptr_zeta
  
  add.w temp_l, ptr_p, #32*strincr // 32 iterations
  vmov s9, temp_l
  1:
    .rept 2
    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #1*distance/4]
    ldr.w pol2, [ptr_p, #2*distance/4]
    ldr.w pol3, [ptr_p, #3*distance/4]
    ldr.w pol4, [ptr_p, #4*distance/4]
    ldr.w pol5, [ptr_p, #5*distance/4]
    ldr.w pol6, [ptr_p, #6*distance/4]
    ldr.w pol7, [ptr_p, #7*distance/4]

    _3_layer_CT_32 pol0, pol1, pol2, pol3, pol4, pol5, pol6, pol7, s2, s3, s4, s5, s6, s7, s8, zeta, qinv, q, temp_h, temp_l

    str.w pol1, [ptr_p, #1*distance/4]
    str.w pol2, [ptr_p, #2*distance/4]
    str.w pol3, [ptr_p, #3*distance/4]
    str.w pol4, [ptr_p, #4*distance/4]
    str.w pol5, [ptr_p, #5*distance/4]
    str.w pol6, [ptr_p, #6*distance/4]
    str.w pol7, [ptr_p, #7*distance/4]
    str.w pol0, [ptr_p], #strincr
    .endr
    vmov temp_l, s9
    cmp.w ptr_p, temp_l
    bne 1b
  
  sub ptr_p, #32*4

  // stage 4 - 6  
  .equ distance, 64
  add.w temp_l, ptr_p, #8*112+8*4*4 // 8 iterations
  vmov s9, temp_l
  1:
    add.w temp_l, ptr_p, #4*strincr // 4 iterations
    vmov s10, temp_l
    vmov ptr_zeta, s0
    vldm ptr_zeta!, {s2-s8}
    vmov s0, ptr_zeta
    2:
      .rept 2
      ldr.w pol0, [ptr_p]
      ldr.w pol1, [ptr_p, #1*distance/4]
      ldr.w pol2, [ptr_p, #2*distance/4]
      ldr.w pol3, [ptr_p, #3*distance/4]
      ldr.w pol4, [ptr_p, #4*distance/4]
      ldr.w pol5, [ptr_p, #5*distance/4]
      ldr.w pol6, [ptr_p, #6*distance/4]
      ldr.w pol7, [ptr_p, #7*distance/4]

      _3_layer_CT_32 pol0, pol1, pol2, pol3, pol4, pol5, pol6, pol7, s2, s3, s4, s5, s6, s7, s8, zeta, qinv, q, temp_h, temp_l
      
      str.w pol1, [ptr_p, #1*distance/4]
      str.w pol2, [ptr_p, #2*distance/4]
      str.w pol3, [ptr_p, #3*distance/4]
      str.w pol4, [ptr_p, #4*distance/4]
      str.w pol5, [ptr_p, #5*distance/4]
      str.w pol6, [ptr_p, #6*distance/4]
      str.w pol7, [ptr_p, #7*distance/4]
      str.w pol0, [ptr_p], #4
      .endr
      vmov temp_l, s10
      cmp.w ptr_p, temp_l
      bne 2b

    add.w ptr_p, #112
    vmov temp_l, s9
    cmp.w ptr_p, temp_l
    bne 1b
  
    sub ptr_p, #4*4*8+112*8
    vmov ptr_zeta, s0
    //stage 7 and 8
    add cntr, ptr_p, #1024 // 64 iterations
    1:
      ldr.w zeta1, [ptr_zeta, #4]  //z128,..., z254
      ldr.w zeta2, [ptr_zeta, #8]  //z129,..., z255
      ldr zeta0, [ptr_zeta], #12  //z64, ..., z127
      ldr.w pol0, [ptr_p]  //1*4
      ldr.w pol1, [ptr_p, #4]
      ldr.w pol2, [ptr_p, #8]
      ldr.w pol3, [ptr_p, #12] 

      _2_layer_CT_32 pol0, pol1, pol2, pol3, zeta0, zeta1, zeta2, qinv, q, temp_h, temp_l

      str.w pol1, [ptr_p, #4]
      str.w pol2, [ptr_p, #8]
      str.w pol3, [ptr_p, #12]
      str pol0, [ptr_p], #16

      cmp.w cntr, ptr_p
      bne.w 1b

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

.ltorg
// ##############################
// ##########  NTT^-1  ##########
// ##############################

//void haetae_invntt332_tomont(int32_t p[N]);
.global haetae_invntt332_tomont
.type haetae_invntt332_tomont,%function
.align 2
haetae_invntt332_tomont:
  //bind aliases
  ptr_p     .req R0
  ptr_zeta  .req R1
  zeta      .req R1
  qinv      .req R2
  q         .req R3
  cntr      .req R4
  pol4      .req R4
  pol0      .req R5
  pol1      .req R6
  pol2      .req R7
  pol3      .req R8
  temp_h    .req R9
  temp_l    .req R10
  zeta0     .req R11
  zeta1     .req R12
  zeta2     .req R14
  pol5     .req R11
  pol6     .req R12
  pol7     .req R14

  //preserve registers
  push {R4-R11, R14}
    
  //load constants, ptr
  ldr.w qinv, inv_ntt_asm_smull_qinv  //-qinv_signed
  ldr.w q, inv_ntt_asm_smull_q

  //stage 1 - 3
  .equ distance, 16
  .equ strincr, 32

  ldr ptr_zeta, =#INVERSE_NTT_TWIDDLE_TABLE
  vldm ptr_zeta!, {s2-s8} 
  vmov s0, ptr_zeta
  
  add.w temp_l, ptr_p, #32*strincr // 32 iterations
  vmov s9, temp_l
  1:
    ldr.w pol4, [ptr_p, #4*distance/4]
    ldr.w pol1, [ptr_p, #5*distance/4]
    ldr.w pol6, [ptr_p, #6*distance/4]
    ldr.w pol3, [ptr_p, #7*distance/4]
    _3_layer_inv_butterfly_light_fast_first pol0, pol1, pol2, pol3, pol4, pol5, pol6, pol7, s2, s3, s4, s5, s6, s7, s8, zeta, qinv, q, temp_h, temp_l
    
    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #1*distance/4]
    ldr.w pol2, [ptr_p, #2*distance/4]
    ldr.w pol3, [ptr_p, #3*distance/4]
    _3_layer_inv_butterfly_light_fast_second pol0, pol1, pol2, pol3, pol4, pol5, pol6, pol7, s2, s3, s4, s5, s6, s7, s8, zeta, qinv, q, temp_h, temp_l
    
    str.w pol1, [ptr_p, #1*distance/4]
    str.w pol2, [ptr_p, #2*distance/4]
    str.w pol3, [ptr_p, #3*distance/4]
    str.w pol4, [ptr_p, #4*distance/4]
    str.w pol5, [ptr_p, #5*distance/4]
    str.w pol6, [ptr_p, #6*distance/4]
    str.w pol7, [ptr_p, #7*distance/4]
    str.w pol0, [ptr_p], #strincr
    vmov temp_l, s9
    cmp.w ptr_p, temp_l
  bne.w 1b
  
  sub ptr_p, #32*strincr

  // stage 4 - 6  
  .equ distance, 128
  .equ strincr, 256
  
  // iteration 0
  movw temp_l, #4
  add.w temp_l, ptr_p, #4*256 // 4 iterations
  vmov s10, temp_l
	
  vmov ptr_zeta, s0
  vldm ptr_zeta!, {s2-s8}
  vmov s0, ptr_zeta

  2:
    ldr.w pol4, [ptr_p, #4*distance/4]
    ldr.w pol1, [ptr_p, #5*distance/4]
    ldr.w pol6, [ptr_p, #6*distance/4]
    ldr.w pol3, [ptr_p, #7*distance/4]
    _3_layer_inv_butterfly_light_fast_first pol0, pol1, pol2, pol3, pol4, pol5, pol6, pol7, s2, s3, s4, s5, s6, s7, s8, zeta, qinv, q, temp_h, temp_l
    
    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #1*distance/4]
    ldr.w pol2, [ptr_p, #2*distance/4]
    ldr.w pol3, [ptr_p, #3*distance/4]
    _3_layer_inv_butterfly_light_fast_second pol0, pol1, pol2, pol3, pol4, pol5, pol6, pol7, s2, s3, s4, s5, s6, s7, s8, zeta, qinv, q, temp_h, temp_l

    str.w pol1, [ptr_p, #1*distance/4]
    str.w pol2, [ptr_p, #2*distance/4]
    str.w pol3, [ptr_p, #3*distance/4]
    str.w pol4, [ptr_p, #4*distance/4]
    str.w pol5, [ptr_p, #5*distance/4]
    str.w pol6, [ptr_p, #6*distance/4]
    str.w pol7, [ptr_p, #7*distance/4]
    str.w pol0, [ptr_p]
    add.w ptr_p, #strincr

    vmov temp_l, s10
    cmp.w temp_l, ptr_p
  bne.w 2b

  sub.w ptr_p, #4*256-4

  // iteration 1-7
  add.w temp_l, ptr_p, #7*4 // 7 iterations
  vmov s9, temp_l
  1:
    add.w temp_l, ptr_p, #4*strincr // 4 iterations
    vmov s10, temp_l

	  vmov ptr_zeta, s0
    vldm ptr_zeta!, {s2-s8}
    vmov s0, ptr_zeta
    2:     
	    ldr.w pol0, [ptr_p]
	    ldr.w pol1, [ptr_p, #1*distance/4]
	    ldr.w pol2, [ptr_p, #2*distance/4]
	    ldr.w pol3, [ptr_p, #3*distance/4]
	    ldr.w pol4, [ptr_p, #4*distance/4]
	    ldr.w pol5, [ptr_p, #5*distance/4]
	    ldr.w pol6, [ptr_p, #6*distance/4]
	    ldr.w pol7, [ptr_p, #7*distance/4]

	    _3_layer_inv_CT_32 pol0, pol1, pol2, pol3, pol4, pol5, pol6, pol7, s2, s3, s4, s5, s6, s7, s8, zeta, qinv, q, temp_h, temp_l

	    str.w pol1, [ptr_p, #1*distance/4]
	    str.w pol2, [ptr_p, #2*distance/4]
	    str.w pol3, [ptr_p, #3*distance/4]
	    str.w pol4, [ptr_p, #4*distance/4]
	    str.w pol5, [ptr_p, #5*distance/4]
	    str.w pol6, [ptr_p, #6*distance/4]
	    str.w pol7, [ptr_p, #7*distance/4]
	    str.w pol0, [ptr_p]
	    add.w ptr_p, #strincr

      vmov temp_l, s10
      cmp.w ptr_p, temp_l
    bne 2b
    sub.w ptr_p, #4*strincr-4

    vmov temp_l, s9
    cmp.w temp_l, ptr_p
  bne 1b
  
  sub ptr_p, #8*4
  vmov ptr_zeta, s0
  
  //stage 7 and 8
  .equ strincr, 4

  add.w cntr, ptr_p, #64*strincr // 64 iterations 
  vmov s9, cntr
  1:
    ldr.w zeta1, [ptr_zeta, #4]
    ldr.w zeta2, [ptr_zeta, #8]
    ldr zeta0, [ptr_zeta], #12
    ldr.w pol0, [ptr_p]
    ldr.w pol1, [ptr_p, #256]
    ldr.w pol2, [ptr_p, #512]
    ldr.w pol3, [ptr_p, #768]

    _2_layer_inv_CT_32 pol0, pol1, pol2, pol3, zeta0, zeta1, zeta2, qinv, q, temp_h, temp_l

    ldr.w zeta1, [ptr_zeta, #4]
    ldr.w zeta2, [ptr_zeta, #8]
    ldr.w zeta0, [ptr_zeta, #12]
    ldr.w cntr, [ptr_zeta], #16
    montgomery_mul_32 pol0, cntr, qinv, q, temp_h, temp_l
    montgomery_mul_32 pol1, zeta1, qinv, q, temp_h, temp_l
    montgomery_mul_32 pol2, zeta2, qinv, q, temp_h, temp_l
    montgomery_mul_32 pol3, zeta0, qinv, q, temp_h, temp_l

    str.w pol1, [ptr_p, #256]
    str.w pol2, [ptr_p, #512]
    str.w pol3, [ptr_p, #768]
    str pol0, [ptr_p], #strincr

    vmov cntr, s9
    cmp.w cntr, ptr_p
    bne.w 1b

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
inv_ntt_asm_smull_qinv:
.word INVERSE_NEG_Q_VALUE
.align 2
inv_ntt_asm_smull_q:
.word Q_VALUE

.section .rodata


/**********************************************************************
 * zetas in Montgomery domain, reordered for NTT 3+3+2 layers:
 * twiddles = reorder332([(R * pow(root,brv(i),q) mod_pm q for i in range(L)])
 * q=64513, root=426, R=2**32, L=256, signed
 *********************************************************************/
.align 2
OBJECT twiddles_332_0xFC01
.4byte	 26964, -16505,  22229,  30746,  20243,  19064, -31218,   9395
.4byte	-16039, -22946, -22562,  -6789, -10049,   9383, -30985,   6241
.4byte	-19553,  16304, -12296,  16446,  18239,  22859,  10681,  22935
.4byte	 -1296, -19725, -32076,  11782,  -8851,  22431, -29104, -17941
.4byte	 29643,  -8577,   7893,  32144,  28147, -27527, -21464, -19646
.4byte	-15130,  -2391,  13744, -29133, -20035,  30608, -23970, -16608
.4byte	 19616,  21408,  20143, -11361,  -7941,  26533, -19129,  27690
.4byte	 17599,  30820,  25252,   7597, -11459,  10615,  -9430,  11591
.4byte	-27989,   3350,   7814,    787, -13857,  12697,   1657, -21224
.4byte	 32114,  -7374,  -9190,  -3761,   2464,  25555,  -9604,  -3529
.4byte	-28772,  19813,  16588, -15739,  20353,  23475,  13666,  17456
.4byte	  5764,  30980, -16267,  13633,  -7401, -19555, -30317,  28847
.4byte	   598,   7682, -11808, -29942,  -8796,  14864,   4538, -24162
.4byte	-19194,    835,    689,  -1311,  15546, -31332, -16319,   3970
.4byte	  1025,  10971, -27685, -23016,  -2648,   1488, -21900, -12543
.4byte	  8311, -25921,  28254, -12442,  28521, -16160,  31352,  12380
.4byte	-12882, -17631, -30332, -16630,   1806,  23439,   7742,  -5342
.4byte	 17182,  17494,   9790,   5920,  13642,  29068,   7382, -18166
.4byte	 16507,  21422, -30274, -29051, -28190,  13283,  22131, -20316
.4byte	 -9939,   6759,  10672,  21454,  15510,   6080, -17374, -14941
.4byte	-29735, -25912,  28710, -10170,   3808,   1160,  10639, -26985
.4byte	-31327, -10865,  25636,  24985,  17261, -26851,  11261,  -8253
.4byte	 -3304, -10623,  18282,  -2202, -27727, -31368, -22243,  21502
.4byte	 13882,  12069,  18731, -11242,  -7729, -16186, -10226,   1761
.4byte	 -4127, -27298,  -4800, -18832, -17737, -22805,  12050,  -3528
.4byte	    65, -14501,  10770,   8908,   7929, -23751,  26934,  29563
.4byte	 21921, -27010, -31064, -21944,   8889,   5913,  -1035,  23224
.4byte	  5322,  -9488,  -5823, -16405,   -994, -20206,   2844,   7655
.4byte	-16251,  29439, -22820, -27740,   5876,  15822,  23078,  -9522
.4byte	 13803,  -8099, -18586,   2931,   9217,  -9874, -21126, -14203
.4byte	 23844,  25492, -12831,  30362,   7947,  17463, -21442, -12979
.4byte	 29003,   9560,  31612,  26554,  17671,   8241, -20175
ENDOBJ twiddles_332_0xFC01

/**********************************************************************
 * zetas in Montgomery domain, reordered for inverse NTT 3+3+2 layers:
 * q=64513, root=426, R=2**32, L=256, signed
 *********************************************************************/
.align 2
OBJECT twiddles_inv332_0xFC01
.4byte	 14321,  14321, -26964,  14321, -22229, -26964,  16505
.4byte	 14321,  14321, -26964,  14321, -22229, -26964,  16505
.4byte	 31218, -17599, -21408, -25252,  11361, -30820, -20143
.4byte	-22229,  31218, -19064, -17599, -13744, -21408, -32144
.4byte	-20243,   8851, -22859,  29104, -22935, -22431, -10681
.4byte	-26964, -22229,  16505,  31218, -20243, -19064, -30746
.4byte	-19064, -13744, -32144,  20035,  27527,  29133, -28147
.4byte	 16505, -20243, -30746,   8851,  30985, -22859,  -9395
.4byte	-30746,  30985,  -9395,  19553,  22946,  -6241,  16039
.4byte	 14321,  14321, -26964, -29720,  15742, -19565,  25927
.4byte	  9430, -17671,  -9560, -24300,   4883,  -1106,  20808
.4byte	-25252,   9430, -10615,  17207,  -2563, -28776, -22667
.4byte	 -7893, -15510,  -6759,   4735,  21044,  30826,  27963
.4byte	-17599, -25252, -30820, -18313,  23371, -11437,  17784
.4byte	-19616,  -7929,  14501,  31002,  20802,  16480, -25400
.4byte	 29104,  -7893,   8577, -15374,   4592,   6702,  25685
.4byte	-18239, -15546,   -835,  22074,  -3018,   1833,   2029
.4byte	 31218, -17599, -21408,  31854, -29992,  26809,  18026
.4byte	-27690,  -5876, -29439, -15372,  28703,  13541,  -6621
.4byte	 20035, -19616,  16608, -30021,  32021,  15630, -15008
.4byte	-11782,  -1806,  17631, -22332, -10677,  19118, -27900
.4byte	  8851,  29104, -22431, -20951,  25871,   -258, -13695
.4byte	  2391,  27727,  10623, -26551,  -4331,  10903,  -4121
.4byte	 19553, -18239, -16446, -24444,  10742,  22590,  24372
.4byte	 -9383, -20353, -19813,  26293,  -9364,  10048, -21750
.4byte	-22229,  31218, -19064, -29166, -14863,   3961, -20041
.4byte	 11459, -23844,   9874,  -3703, -30777,  14396,  11008
.4byte	 11361, -27690,  19129, -25299,  -6887, -30254,  29405
.4byte	-29643, -16507, -29068,   7664,  10736,  14770,   3855
.4byte	-13744,  20035,  29133, -24818,  17895, -30556,   1372
.4byte	 23970,   4127,  16186,  26595,  18669,  10529,   3032
.4byte	-22935, -11782,  32076, -24925, -14040,  22892, -12108
.4byte	 12296,   -598,  19555,   7362, -17297,  14289, -20927
.4byte	-20243,   8851, -22859, -29059,  17072,  15026,  -6561
.4byte	-26533,  -5322,  -5913,  15530,   5189,  10636, -29546
.4byte	 27527,   2391,  15130, -21165,  26514, -22388,  23858
.4byte	 19725,  -8311,  -1488,   -504, -11750,  18423,  12474
.4byte	 30985,  19553,  -6241,  31801,   8453,   6858, -29047
.4byte	 19646,  31327,  -1160, -21884, -28905,   2742,  25525
.4byte	 22946,  -9383,  10049, -13378,   4021,  -6354, -23716
.4byte	  6789, -32114, -12697,  28742,   -142,  29970,  30535
.4byte	-26964, -22229,  16505,  16120,  21504,  28238, -11892
.4byte	-10615,  21442, -30362,  29417, -23574, -16592,  29957
.4byte	-30820,  11459,  -7597,  13850,   9031,   7533,  12034
.4byte	  8577, -22131,  29051,  -1179,  11682,    472,  13052
.4byte	-21408,  11361, -20143, -30442,  20926,  27563,  11540
.4byte	 16608, -12050,  18832,   8712,    352, -14322, -22083
.4byte	-22431, -29643,  17941,  30914,  -7874, -26384, -23222
.4byte	-16446,  -4538,  29942,  18851,  11188, -19749,   1157
.4byte	-19064, -13744, -32144,  19277, -14209,  17672,  22870
.4byte	 19129,  -2844,  16405,  19278,  30103, -11165,   6717
.4byte	 29133,  23970, -30608,  25487,  15366,  27990,  30455
.4byte	 32076, -31352,  12442,  -1606,  -7233,  -8112,   7492
.4byte	-22859, -22935, -10681,  27861,  -8649,  17245,   3955
.4byte	 15130, -11261, -24985,  29596, -26825, -17375, -22858
.4byte	 -6241,  12296, -16304,  28540,  16141, -15639,   3278
.4byte	 10049,   9604,   3761, -12351,  30780, -10486,  31507
.4byte	 16505, -20243, -30746,  18598,  25514, -13957,  23547
.4byte	 -7597,  18586,   9522,  -3288, -27502, -18054,  16865
.4byte	-20143, -26533,   7941, -29084,   5993,  26308,  10186
.4byte	 17941,  -9790,   5342, -10669, -13464,   -544,  22134
.4byte	-32144,  27527, -28147,  11030,  10872, -23020,  17316
.4byte	-30608, -18731, -21502, -27536,  23650,  29628, -28127
.4byte	-10681,  19725,   1296, -11574,  11262, -30824,  -3852
.4byte	-16304,  16267, -17456,   4516,  -6334,  23855,  17255
.4byte	-30746,  30985,  -9395, -23311,  25124,  -6153, -19798
.4byte	  7941,  31064, -29563,  29173,   2482, -12281, -28517
.4byte	-28147,  19646,  21464, -17347,  -7869,   1637,  26132
.4byte	  1296,  27685,  -3970,  29187, -22280, -28921,   3393
.4byte	 -9395,  22946,  16039,   5066, -20648, -30810, -28614
.4byte	 21464, -28710,  14941, -27550, -16101, -18245,   4476
.4byte	 16039,   6789,  22562,  30526,  24041,   1623, -13619
.4byte	 22562,  -7814, -11591,  -3260, -12513,  13179,  16172
ENDOBJ twiddles_inv332_0xFC01


.type zetas_new332, %object
.align 2
zetas_new332:
.word 25847, -2608894, -518909, 237124, -777960, -876248, 466468, 1826347
.word 2725464, 1024112, 2706023, 95776, 3077325, 3530437, 2353451, -1079900
.word 3585928, -1661693, -3592148, -2537516, 3915439, -359251, -549488, -1119584
.word -3861115, -3043716, 3574422, -2867647, -2091905, 2619752, -2108549, 3539968
.word -300467, 2348700, -539299, 3119733, -2118186, -3859737, -1699267, -1643818
.word 3505694, -3821735, -2884855, -1399561, -3277672, 3507263, -2140649, -1600420
.word 3699596, 3111497, 1757237, -19422, 811944, 531354, 954230, 3881043
.word 2680103, 4010497, 280005, 3900724, -2556880, 2071892, -2797779, -3930395
.word 2091667, 3407706, -1528703, 2316500, 3817976, -3677745, -3342478, 2244091
.word -3041255, -2446433, -3562462, -1452451, 266997, 2434439, 3475950, -1235728
.word 3513181, 2176455, -3520352, -3759364, -1585221, -1197226, -3193378, -1257611
.word 900702, 1859098, 1939314, 909542, 819034, -4083598, 495491, -1613174
.word -1000202, -43260, -522500, -3190144, -655327, -3122442, -3157330, 2031748
.word 3207046, -3632928, -3556995, -525098, 126922, -768622, -3595838, 3412210
.word 342297, 286988, -983419, -2437823, 4108315, 2147896, 3437287, -3342277
.word 2715295, 1735879, 203044, -2967645, 2842341, 2691481, -3693493, -2590150
.word 1265009, -411027, 4055324, 1247620, -2477047, 2486353, 1595974, -671102
.word -3767016, 1250494, -1228525, 2635921, -3548272, -22981, -2994039, 1869119
.word -1308169, 1903435, -1050970, -381987, -1333058, 1237275, 1349076, -3318210
.word -1430225, 1852771, -451100, 1312455, -1430430, 3306115, -1962642, -3343383
.word -1279661, 1917081, 264944, -2546312, -1374803, 508951, 1500165, 777191
.word 3097992, 2235880, 3406031, 44288, -542412, -2831860, -1100098, -1671176
.word -1846953, 904516, -2584293, -3724270, 3958618, 594136, -3776993, -3724342
.word -2013608, 2432395, -8578, 2454455, -164721, 1653064, 1957272, 3369112
.word -3249728, 185531, -1207385, 2389356, -3183426, 162844, -210977, 1616392
.word 3014001, 759969, 810149, 1652634, -1316856, -3694233, -1799107, 189548
.word -3038916, 3523897, -3553272, 3866901, 269760, 3159746, 2213111, -975884
.word -1851402, 1717735, 472078, -2409325, -426683, 1723600, -177440, -1803090
.word 1910376, 1315589, -1667432, -1104333, 1341330, -260646, -3833893, 1285669
.word -2939036, -2235985, -1584928, -420899, -2286327, -812732, 183443, -976891
.word -1439742, 1612842, -3545687, -3019102, -554416, 3919660, -3881060, -48306
.word -1362209, -3628969, 3937738, 1400424, 3839961, -846154, 1976782
.size zetas_new332,.-zetas_new332

.type zetas_new332inv, %object
.align 2
zetas_new332inv:
.word 4193792, 4193792, -25847, 4193792, 518909, -25847, 2608894
.word 4193792, 4193792, -25847, 4193792, 518909, -25847, 2608894
.word -466468, -2680103, -3111497, -280005, 19422, -4010497, -1757237
.word 518909, -466468, 876248, -2680103, 2884855, -3111497, -3119733
.word 777960, 2091905, 359251, 2108549, 1119584, -2619752, 549488
.word -25847, 518909, 2608894, -466468, 777960, 876248, -237124, 876248
.word 2884855, -3119733, 3277672, 3859737, 1399561, 2118186, 2608894
.word 777960, -237124, 2091905, -2353451, 359251, -1826347, -237124
.word -2353451, -1826347, -3585928, -1024112, 1079900, -2725464, 4193792
.word 4193792, -25847, 41978, 3024400, 3975713, -1225192, 2797779
.word -3839961, 3628969, -1711436, 3835778, 485110, -3954267, -280005
.word 2797779, -2071892, -2831100, -2698859, -908040, -2292170, 539299
.word 1430430, -1852771, -3658785, 3512212, 1859141, -1607594, -2680103
.word -280005, -4010497, 715005, 1483994, -1045894, -980943, -3699596
.word 1316856, -759969, -955715, 3677139, 3933849, 2719610, 2108549
.word 539299, -2348700, 1658328, -1403403, 1775852, -2460465, -3915439
.word -126922, 3632928, 1067023, 3847594, 4179270, 1652689, -466468
.word -2680103, -3111497, -2953811, -284642, 2507426, -324139, -3881043
.word -1341330, -1315589, 3990128, -2137097, -4109898, 4092021, 3277672
.word -3699596, 1600420, 1541634, 3493410, 3487504, 2497815, 2867647
.word 2477047, 411027, 1654972, 1326223, -2608226, -2752209, 2091905
.word 2108549, -2619752, 1836700, 2945615, -1908953, 729864, 3821735
.word -3958618, -904516, 2080615, 1555380, -3471815, -1978758, -3585928
.word -3915439, 2537516, -892788, -553664, -3095038, 658596, -3530437
.word 1585221, -2176455, 3355482, -1783485, 2780552, -3623330, 518909
.word -466468, 876248, -442683, 2523147, -2847660, -3683140, 2556880
.word 1439742, 812732, 774207, -3168108, 1877157, 3406477, 19422, -3881043
.word -954230, -214686, -1182619, 2453526, -2201920, 300467, 1308169
.word 22981, 3614022, 2136260, 1459487, -2233803, 2884855, 3277672
.word 1399561, 394072, -3933227, 4136064, 156486, 2140649, 3249728
.word -1653064, 1596950, 633578, 2722529, -554462, 1119584, 2867647
.word -3574422, 1004840, 191586, 3969463, 1161373, 3592148, 1000202
.word 4083598, 3189243, 3561667, -3650125, 3490511, 777960, 2091905
.word 359251, -1829156, -3707725, -661807, 1144558, -531354, 1851402
.word -3159746, 1543095, -2903948, 1505516, -1500460, 3859737, 3821735
.word -3505694, -2413330, 3908886, -1203856, 3570263, 3043716, -2715295
.word -2147896, 758741, 3917553, -2414897, -1613811, -2353451, -3585928
.word 1079900, 990020, -719638, 2718792, 2260310, 1643818, -3097992
.word -508951, -783456, -2089539, 2616547, 4060031, -1024112, -3530437
.word -3077325, -1821861, 1920615, 3988525, 2048419, -95776, 3041255
.word 3677745, -971504, 2190617, 2311312, -1170082, -25847, 518909
.word 2608894, 1261528, -2073537, -959585, 3948120, -2071892, 3881060
.word 3019102, -1342633, -1115066, 3589694, -1929116, -4010497, 2556880
.word -3900724, 3360006, 1758630, -2306989, -1841637, -2348700, -1349076
.word 381987, -1699982, 3189673, 3531558, -1210546, -3111497, 19422
.word -1757237, 2977353, 2612035, -2718155, -1544829, 1600420, 210977
.word -2389356, 2052582, -2737802, 2383976, -450259, -2619752, 300467
.word -3539968, 1698289, -4065084, -644023, -1114140, 2537516, 3157330
.word 3190144, -993399, -2220524, 2920588, 252737, 876248, 2884855
.word -3119733, 1490985, -34731, -1212610, -3183745, -954230, 177440
.word 2409325, -3302554, -2390327, -2749545, 653128, 1399561, 2140649
.word -3507263, -3745105, -1942293, -3367121, 2734884, -3574422, 3693493
.word 2967645, 1393803, -2467905, 1786029, -1633410, 359251, 1119584
.word 549488, -2824548, -1325638, -2207625, -2601586, -3505694, 1100098
.word -44288, 3478676, -2457992, -1617107, 2551364, 1079900, 3592148
.word 1661693, 1593929, 318899, -3366475, 3118416, -3077325, -3475950
.word 1452451, 3772814, 1424805, -3391376, 632820, 2608894, 777960
.word -237124, 2062597, 4064335, 2197148, -1127864, -3900724, 1584928
.word -1285669, 2525341, -896437, -1915773, 1792087, -1757237, -531354, -811944
.word 938441, -674578, 2876837, 3959371, -3539968, 1228525, 671102
.word 1219592, -3853560, 2630979, -2134676, -3119733, 3859737, 2118186
.word -2432637, 2746655, 718593, -2353280, -3507263, 8578, 3724342
.word -34852, 1387945, 358956, 1604944, 549488, 3043716, 3861115
.word 1290746, 3208584, 2538711, -1442830, 1661693, -1939314, 1257611
.word -367371, -1308058, 264382, 2614173, -237124, -2353451, -1826347, 2050674
.word 592050, -138487, 2310528, -811944, 3553272, -189548, -2728561
.word -4168358, -79, 3844932, 2118186, 1643818, 1699267, 500408
.word 743398, 879633, -3105206, 3861115, 983419, -3412210, 712597
.word -23479, 3729381, -1010481, -1826347, -1024112, -2725464, -2361217
.word -1864453, 3850522, 2337144, 1699267, -264944, 3343383, 3842267
.word 4181974, -4032642, 3983585, -2725464, -95776, -2706023, 260345
.word 2526550, 2000777, 987079, -2706023, 1528703, 3930395, -3030761
.word -3082055, -2374824, 1836319
.size zetas_new332inv,.-zetas_new332inv
