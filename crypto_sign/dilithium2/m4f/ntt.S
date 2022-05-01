// based on code by: Markus Krausz (18.03.18)
// date 23.07.21: Now licensed under CC0 with permission of the authors.

.syntax unified
#include "macros.i"

// This code uses UMULL - which is constant time on the M4, but not on the M3
// Make sure that this code is never used on an M3
smlad r0,r0,r0,r0

// ##############################
// ##########   NTT    ##########
// ##############################

//void pqcrystals_dilithium_ntt(int32_t p[N]);
.global pqcrystals_dilithium_ntt
.type pqcrystals_dilithium_ntt,%function
.align 2
pqcrystals_dilithium_ntt:
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
  
  ldr ptr_zeta, =#zetas_new332
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

//void pqcrystals_dilithium_invntt_tomont(int32_t p[N]);
.global pqcrystals_dilithium_invntt_tomont
.type pqcrystals_dilithium_invntt_tomont,%function
.align 2
pqcrystals_dilithium_invntt_tomont:
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

  ldr ptr_zeta, =#zetas_new332inv
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
.word 0xfc7fdfff
.align 2
inv_ntt_asm_smull_q:
.word 8380417

.section .rodata

.type zetas_new332, %object
.align 2
zetas_new332:
.word 25847, -2608894, -518909, 237124, -777960, -876248, 466468, 1826347, 2725464, 1024112, 2706023, 95776, 3077325, 3530437, 2353451, -1079900, 3585928, -1661693, -3592148, -2537516, 3915439, -359251, -549488, -1119584, -3861115, -3043716, 3574422, -2867647, -2091905, 2619752, -2108549, 3539968, -300467, 2348700, -539299, 3119733, -2118186, -3859737, -1699267, -1643818, 3505694, -3821735, -2884855, -1399561, -3277672, 3507263, -2140649, -1600420, 3699596, 3111497, 1757237, -19422, 811944, 531354, 954230, 3881043, 2680103, 4010497, 280005, 3900724, -2556880, 2071892, -2797779, -3930395, 2091667, 3407706, -1528703, 2316500, 3817976, -3677745, -3342478, 2244091, -3041255, -2446433, -3562462, -1452451, 266997, 2434439, 3475950, -1235728, 3513181, 2176455, -3520352, -3759364, -1585221, -1197226, -3193378, -1257611, 900702, 1859098, 1939314, 909542, 819034, -4083598, 495491, -1613174, -1000202, -43260, -522500, -3190144, -655327, -3122442, -3157330, 2031748, 3207046, -3632928, -3556995, -525098, 126922, -768622, -3595838, 3412210, 342297, 286988, -983419, -2437823, 4108315, 2147896, 3437287, -3342277, 2715295, 1735879, 203044, -2967645, 2842341, 2691481, -3693493, -2590150, 1265009, -411027, 4055324, 1247620, -2477047, 2486353, 1595974, -671102, -3767016, 1250494, -1228525, 2635921, -3548272, -22981, -2994039, 1869119, -1308169, 1903435, -1050970, -381987, -1333058, 1237275, 1349076, -3318210, -1430225, 1852771, -451100, 1312455, -1430430, 3306115, -1962642, -3343383, -1279661, 1917081, 264944, -2546312, -1374803, 508951, 1500165, 777191, 3097992, 2235880, 3406031, 44288, -542412, -2831860, -1100098, -1671176, -1846953, 904516, -2584293, -3724270, 3958618, 594136, -3776993, -3724342, -2013608, 2432395, -8578, 2454455, -164721, 1653064, 1957272, 3369112, -3249728, 185531, -1207385, 2389356, -3183426, 162844, -210977, 1616392, 3014001, 759969, 810149, 1652634, -1316856, -3694233, -1799107, 189548, -3038916, 3523897, -3553272, 3866901, 269760, 3159746, 2213111, -975884, -1851402, 1717735, 472078, -2409325, -426683, 1723600, -177440, -1803090, 1910376, 1315589, -1667432, -1104333, 1341330, -260646, -3833893, 1285669, -2939036, -2235985, -1584928, -420899, -2286327, -812732, 183443, -976891, -1439742, 1612842, -3545687, -3019102, -554416, 3919660, -3881060, -48306, -1362209, -3628969, 3937738, 1400424, 3839961, -846154, 1976782
.size zetas_new332,.-zetas_new332

.type zetas_new332inv, %object
.align 2
zetas_new332inv:
.word 4193792, 4193792, -25847, 4193792, 518909, -25847, 2608894, 4193792, 4193792, -25847, 4193792, 518909, -25847, 2608894, -466468, -2680103, -3111497, -280005, 19422, -4010497, -1757237, 518909, -466468, 876248, -2680103, 2884855, -3111497, -3119733, 777960, 2091905, 359251, 2108549, 1119584, -2619752, 549488, -25847, 518909, 2608894, -466468, 777960, 876248, -237124, 876248, 2884855, -3119733, 3277672, 3859737, 1399561, 2118186, 2608894, 777960, -237124, 2091905, -2353451, 359251, -1826347, -237124, -2353451, -1826347, -3585928, -1024112, 1079900, -2725464, 4193792, 4193792, -25847, 41978, 3024400, 3975713, -1225192, 2797779, -3839961, 3628969, -1711436, 3835778, 485110, -3954267, -280005, 2797779, -2071892, -2831100, -2698859, -908040, -2292170, 539299, 1430430, -1852771, -3658785, 3512212, 1859141, -1607594, -2680103, -280005, -4010497, 715005, 1483994, -1045894, -980943, -3699596, 1316856, -759969, -955715, 3677139, 3933849, 2719610, 2108549, 539299, -2348700, 1658328, -1403403, 1775852, -2460465, -3915439, -126922, 3632928, 1067023, 3847594, 4179270, 1652689, -466468, -2680103, -3111497, -2953811, -284642, 2507426, -324139, -3881043, -1341330, -1315589, 3990128, -2137097, -4109898, 4092021, 3277672, -3699596, 1600420, 1541634, 3493410, 3487504, 2497815, 2867647, 2477047, 411027, 1654972, 1326223, -2608226, -2752209, 2091905, 2108549, -2619752, 1836700, 2945615, -1908953, 729864, 3821735, -3958618, -904516, 2080615, 1555380, -3471815, -1978758, -3585928, -3915439, 2537516, -892788, -553664, -3095038, 658596, -3530437, 1585221, -2176455, 3355482, -1783485, 2780552, -3623330, 518909, -466468, 876248, -442683, 2523147, -2847660, -3683140, 2556880, 1439742, 812732, 774207, -3168108, 1877157, 3406477, 19422, -3881043, -954230, -214686, -1182619, 2453526, -2201920, 300467, 1308169, 22981, 3614022, 2136260, 1459487, -2233803, 2884855, 3277672, 1399561, 394072, -3933227, 4136064, 156486, 2140649, 3249728, -1653064, 1596950, 633578, 2722529, -554462, 1119584, 2867647, -3574422, 1004840, 191586, 3969463, 1161373, 3592148, 1000202, 4083598, 3189243, 3561667, -3650125, 3490511, 777960, 2091905, 359251, -1829156, -3707725, -661807, 1144558, -531354, 1851402, -3159746, 1543095, -2903948, 1505516, -1500460, 3859737, 3821735, -3505694, -2413330, 3908886, -1203856, 3570263, 3043716, -2715295, -2147896, 758741, 3917553, -2414897, -1613811, -2353451, -3585928, 1079900, 990020, -719638, 2718792, 2260310, 1643818, -3097992, -508951, -783456, -2089539, 2616547, 4060031, -1024112, -3530437, -3077325, -1821861, 1920615, 3988525, 2048419, -95776, 3041255, 3677745, -971504, 2190617, 2311312, -1170082, -25847, 518909, 2608894, 1261528, -2073537, -959585, 3948120, -2071892, 3881060, 3019102, -1342633, -1115066, 3589694, -1929116, -4010497, 2556880, -3900724, 3360006, 1758630, -2306989, -1841637, -2348700, -1349076, 381987, -1699982, 3189673, 3531558, -1210546, -3111497, 19422, -1757237, 2977353, 2612035, -2718155, -1544829, 1600420, 210977, -2389356, 2052582, -2737802, 2383976, -450259, -2619752, 300467, -3539968, 1698289, -4065084, -644023, -1114140, 2537516, 3157330, 3190144, -993399, -2220524, 2920588, 252737, 876248, 2884855, -3119733, 1490985, -34731, -1212610, -3183745, -954230, 177440, 2409325, -3302554, -2390327, -2749545, 653128, 1399561, 2140649, -3507263, -3745105, -1942293, -3367121, 2734884, -3574422, 3693493, 2967645, 1393803, -2467905, 1786029, -1633410, 359251, 1119584, 549488, -2824548, -1325638, -2207625, -2601586, -3505694, 1100098, -44288, 3478676, -2457992, -1617107, 2551364, 1079900, 3592148, 1661693, 1593929, 318899, -3366475, 3118416, -3077325, -3475950, 1452451, 3772814, 1424805, -3391376, 632820, 2608894, 777960, -237124, 2062597, 4064335, 2197148, -1127864, -3900724, 1584928, -1285669, 2525341, -896437, -1915773, 1792087, -1757237, -531354, -811944, 938441, -674578, 2876837, 3959371, -3539968, 1228525, 671102, 1219592, -3853560, 2630979, -2134676, -3119733, 3859737, 2118186, -2432637, 2746655, 718593, -2353280, -3507263, 8578, 3724342, -34852, 1387945, 358956, 1604944, 549488, 3043716, 3861115, 1290746, 3208584, 2538711, -1442830, 1661693, -1939314, 1257611, -367371, -1308058, 264382, 2614173, -237124, -2353451, -1826347, 2050674, 592050, -138487, 2310528, -811944, 3553272, -189548, -2728561, -4168358, -79, 3844932, 2118186, 1643818, 1699267, 500408, 743398, 879633, -3105206, 3861115, 983419, -3412210, 712597, -23479, 3729381, -1010481, -1826347, -1024112, -2725464, -2361217, -1864453, 3850522, 2337144, 1699267, -264944, 3343383, 3842267, 4181974, -4032642, 3983585, -2725464, -95776, -2706023, 260345, 2526550, 2000777, 987079, -2706023, 1528703, 3930395, -3030761, -3082055, -2374824, 1836319
.size zetas_new332inv,.-zetas_new332inv
