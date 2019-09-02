.syntax unified
.cpu cortex-m4
.thumb


.macro mont_red q, qinv, tmp, v
  smulbt \tmp, \v, \qinv
  smulbb \tmp, \tmp, \q
  usub16 \tmp, \v, \tmp
  asr \tmp, #16 
.endm

.macro two_barr_red q, const, tmp1, tmp2, v
  smulbb \tmp1, \v, \const
  smultb \tmp2, \v, \const
  smultb \tmp1, \tmp1, \q
  smultb \tmp2, \tmp2, \q
  pkhbt \tmp1, \tmp1, \tmp2, lsl #16  
  usub16 \v, \v, \tmp1
.endm


.macro two_dist_one_butterflies root, q, qinv, tmp1, tmp2, c_0, c_1
  usub16 \tmp2, \c_0, \c_1
  uadd16 \c_0, \c_0, \c_1
  smulbb \tmp1, \root, \tmp2
  smultt \tmp2, \root, \tmp2
  mont_red \q, \qinv, \c_1, \tmp1
  mont_red \q, \qinv, \tmp1, \tmp2
  pkhbt \c_1, \c_1, \tmp1, lsl#16
.endm

.macro double_butterfly root, q, qinv, tmp1, tmp2, c_0, c_1
  usub16 \tmp2, \c_0, \c_1
  uadd16 \c_0, \c_0, \c_1
  smulbb \tmp1, \root, \tmp2
  smulbt \tmp2, \root, \tmp2
  mont_red \q, \qinv, \c_1, \tmp1
  mont_red \q, \qinv, \tmp1, \tmp2
  pkhbt \c_1, \c_1, \tmp1, lsl#16
.endm

.macro double_butterfly_top root, q, qinv, tmp1, tmp2, c_0, c_1
  usub16 \tmp2, \c_0, \c_1
  uadd16 \c_0, \c_0, \c_1
  smultb \tmp1, \root, \tmp2
  smultt \tmp2, \root, \tmp2
  mont_red \q, \qinv, \c_1, \tmp1
  mont_red \q, \qinv, \tmp1, \tmp2
  pkhbt \c_1, \c_1, \tmp1, lsl#16
.endm

.global asm_ntt512
.type asm_ntt512,%function
.align 2
asm_ntt512:
  push {r4-r11, lr}
  p           .req r0
  root        .req r1
  c_0         .req r2
  c_1         .req r3
  c_2         .req r4
  c_3         .req r5
  q           .req r6
  qinv        .req r6
  root12      .req r7
  root3       .req r8
  offset      .req r8
  loop        .req r9
  barrett_c   .req r10
  tmp1        .req r11
  tmp2        .req r12
  tmp3        .req r14

  ldr qinv, =53249
  lsl qinv, qinv, #16
  ldr tmp2, =12289
  eor qinv, tmp2

  ldr barrett_c, =5
  add offset, root, #4
  #stage 1+2+3

  mov loop, #0
  1:
    ldr tmp1, [p]
    ldr tmp2, [p, #4]
    ldr tmp3, [p, #8]
    ldr c_3,  [p, #12]
    ldr root12, [root, loop, lsl#3]

    pkhbt c_0, tmp1, tmp2, lsl#16
    pkhtb c_1, tmp2, tmp1, asr#16
    pkhbt c_2, tmp3, c_3 , lsl#16
    pkhtb c_3, c_3, tmp3 , asr#16
    
    two_dist_one_butterflies root12, q, qinv, tmp1, tmp2, c_0, c_1
    two_barr_red q, barrett_c, tmp1, tmp2, c_0

    ldr root12, [offset, loop, lsl#3]

    two_dist_one_butterflies root12, q, qinv, tmp1, tmp2, c_2, c_3
    two_barr_red q, barrett_c, tmp1, tmp2, c_2    

    pkhbt tmp1, c_0, c_1, lsl#16
    pkhtb tmp2, c_1, c_0, asr#16
    pkhbt tmp3, c_2, c_3, lsl#16
    pkhtb c_3,  c_3, c_2, asr#16

    ldr root12, [root, loop, lsl#2]

    double_butterfly root12, q, qinv, c_0, c_1, tmp1, tmp2
    two_barr_red q, barrett_c, c_0, c_1, tmp1

    double_butterfly_top root12, q, qinv, c_0, c_1, tmp3, c_3
    two_barr_red q, barrett_c, c_0, c_1, tmp3

    ldr root12, [root, loop, lsl#1] 

    double_butterfly root12, q, qinv, c_0, c_1, tmp1, tmp3
    two_barr_red q, barrett_c, c_0, c_1, tmp1

    double_butterfly root12, q, qinv, c_0, c_1, tmp2, c_3
    two_barr_red q, barrett_c, c_0, c_1, tmp2
  
    str c_3,  [p, #12]  
    str tmp3, [p, #8]  
    str tmp2, [p, #4]  
    str tmp1, [p], #16

    add loop, #1
    cmp loop, #64
    bne 1b
  subs p, #1024


  #stage 4+5
  
  mov tmp3, root
  mov loop, #16
  3:
    ldr root12, [root], #4
    ldrh root3, [tmp3], #2  
    .rept 4
      ldr c_0, [p]
      ldr c_1, [p, #16]
      ldr c_2, [p, #32]
      ldr c_3, [p, #48]
      
      double_butterfly root12, q, qinv, tmp1, tmp2, c_0, c_1
      two_barr_red q, barrett_c, tmp1, tmp2, c_0

      double_butterfly_top root12, q, qinv, tmp1, tmp2, c_2, c_3
      two_barr_red q, barrett_c, tmp1, tmp2, c_2

      double_butterfly root3, q, qinv, tmp1, tmp2, c_0, c_2
      two_barr_red q, barrett_c, tmp1, tmp2, c_0 

      double_butterfly root3, q, qinv, tmp1, tmp2, c_1, c_3
      two_barr_red q, barrett_c, tmp1, tmp2, c_1


      str c_3, [p, #48]
      str c_2, [p, #32]
      str c_1, [p, #16]
      str c_0, [p], #4
    .endr
    add p, #48
    subs loop, #1
    bne 3b
  subs p, #1024
  subs root, #64


  #stage 6+7
  
  mov tmp3, root
  .rept 4
    ldr root12, [root], #4
    ldrh root3, [tmp3], #2  
    mov loop, #16
    6:
      ldr c_0, [p]
      ldr c_1, [p, #64]
      ldr c_2, [p, #128]
      ldr c_3, [p, #192]
      
      double_butterfly root12, q, qinv, tmp1, tmp2, c_0, c_1
      two_barr_red q, barrett_c, tmp1, tmp2, c_0

      double_butterfly_top root12, q, qinv, tmp1, tmp2, c_2, c_3
      two_barr_red q, barrett_c, tmp1, tmp2, c_2

      double_butterfly root3, q, qinv, tmp1, tmp2, c_0, c_2
      two_barr_red q, barrett_c, tmp1, tmp2, c_0 

      double_butterfly root3, q, qinv, tmp1, tmp2, c_1, c_3
      two_barr_red q, barrett_c, tmp1, tmp2, c_1


      str c_3, [p, #192]
      str c_2, [p, #128]
      str c_1, [p, #64]
      str c_0, [p], #4
      subs loop, #1
      bne 6b
    add p, #192
  .endr
  subs p, #1024
  subs root, #16


  #stage 8+9
  
  mov tmp3, root
  ldr root12, [root], #4
  ldrh root3, [tmp3], #2  
  mov loop, #64
  7:
    ldr c_0, [p]
    ldr c_1, [p, #256]
    ldr c_2, [p, #512]
    ldr c_3, [p, #768]
      
    double_butterfly root12, q, qinv, tmp1, tmp2, c_0, c_1
    two_barr_red q, barrett_c, tmp1, tmp2, c_0

    double_butterfly_top root12, q, qinv, tmp1, tmp2, c_2, c_3
    two_barr_red q, barrett_c, tmp1, tmp2, c_2

    double_butterfly root3, q, qinv, tmp1, tmp2, c_0, c_2
    two_barr_red q, barrett_c, tmp1, tmp2, c_0 

    double_butterfly root3, q, qinv, tmp1, tmp2, c_1, c_3
    two_barr_red q, barrett_c, tmp1, tmp2, c_1


    str c_3, [p, #768]
    str c_2, [p, #512]
    str c_1, [p, #256]
    str c_0, [p], #4
    subs loop, #1
    bne 7b


  pop {r4-r11, pc} 
