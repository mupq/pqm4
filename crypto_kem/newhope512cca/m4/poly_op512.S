.syntax unified
.cpu cortex-m4
.thumb


.macro mont_red q, qinv, tmp, v
  smulbt \tmp, \v, \qinv
  smulbb \tmp, \tmp, \q
  usub16 \tmp, \v, \tmp
.endm


.macro two_barr_red q, const, tmp1, tmp2, v
  smulbt \tmp1, \v, \const
  smultt \tmp2, \v, \const
  smultb \tmp1, \tmp1, \q
  smultb \tmp2, \tmp2, \q
  pkhbt \tmp1, \tmp1, \tmp2, lsl #16  
  usub16 \v, \v, \tmp1
.endm



.global asm_mul_coeff512
.type asm_mul_coeff512,%function
.align 2
asm_mul_coeff512:
  push    {r4-r11, lr}
  poly      .req r0
  factors   .req r1
  p_0       .req r2
  p_1       .req r3
  p_2       .req r4
  p_3       .req r5
  p_4       .req r6
  f_0       .req r7
  f_1       .req r8
  f_2       .req r9
  f_3       .req r10
  f_4       .req r11
  tmp       .req r12
  q         .req r14
  qinv      .req r14

  ldr qinv,=53249
  ldr tmp, =12289
  lsl qinv, #16
  eor qinv, qinv, tmp

  b pool
  .ltorg
pool:

  
  .rept 51
    
    ldm poly, {r2-r6}
    ldm factors!,{r7-r11}


    smulbb tmp, p_0, f_0
    smultt p_0, p_0, f_0

    mont_red q, qinv, f_0, tmp
    mont_red q, qinv, tmp, p_0

    pkhtb p_0, tmp, f_0, asr #16  


    smulbb tmp, p_1, f_1
    smultt p_1, p_1, f_1

    mont_red q, qinv, f_1, tmp
    mont_red q, qinv, tmp, p_1

    pkhtb p_1, tmp, f_1, asr #16  


    smulbb tmp, p_2, f_2
    smultt p_2, p_2, f_2

    mont_red q, qinv, f_2, tmp
    mont_red q, qinv, tmp, p_2

    pkhtb p_2, tmp, f_2, asr #16  

    smulbb tmp, p_3, f_3
    smultt p_3, p_3, f_3

    mont_red q, qinv, f_3, tmp
    mont_red q, qinv, tmp, p_3

    pkhtb p_3, tmp, f_3, asr #16  

    smulbb tmp, p_4, f_4
    smultt p_4, p_4, f_4

    mont_red q, qinv, f_4, tmp
    mont_red q, qinv, tmp, p_4

    pkhtb p_4, tmp, f_4, asr #16  

    stm poly!, {r2-r6}

  .endr
  
    
    ldr p_0, [poly]
    ldr f_0, [factors]


    smulbb tmp, p_0, f_0
    smultt p_0, p_0, f_0

    mont_red q, qinv, f_0, tmp
    mont_red q, qinv, tmp, p_0

    pkhtb p_0, tmp, f_0, asr #16  

  
    str p_0, [poly]

  pop     {r4-r11, pc}





.global asm_add512
.type asm_add512,%function
.align 2
asm_add512:
  push    {r4-r11, lr}
  q              .req r14
  barrett_const  .req r14

  ldr r3, =12289
  ldr barrett_const, =5
  lsl barrett_const, #16
  eor q, q, r3
  
  b pooladd
  .ltorg
pooladd:

  .rept 51
      ldm r1!, {r3-r7}
      ldm r2!, {r8-r12}
      uadd16 r3, r3, r8
      uadd16 r4, r4, r9
      uadd16 r5, r5, r10
      uadd16 r6, r6, r11
      uadd16 r7, r7, r12

      two_barr_red q, barrett_const, r8, r9, r3
      two_barr_red q, barrett_const, r8, r9, r4
      two_barr_red q, barrett_const, r8, r9, r5
      two_barr_red q, barrett_const, r8, r9, r6
      two_barr_red q, barrett_const, r8, r9, r7

      stm r0!, {r3-r7}
  .endr
 
  ldr r3, [r1]
  ldr r4, [r2]
  uadd16 r3, r3, r4
  two_barr_red q, barrett_const, r8, r9, r3
  str r3, [r0]
  pop     {r4-r11, pc} 



.global asm_sub512
.type asm_sub512, %function
.align 2
asm_sub512:
  push    {r4-r11, lr}
  q              .req r14
  barrett_const  .req r14

  ldr r3, =12289
  ldr barrett_const, =5
  lsl barrett_const, #16
  eor q, q, r3
    
  b poolsub
  .ltorg
poolsub:



  .rept 51
      ldm r1!, {r3-r7}
      ldm r2!, {r8-r12}
      usub16 r3, r3, r8
      usub16 r4, r4, r9
      usub16 r5, r5, r10
      usub16 r6, r6, r11
      usub16 r7, r7, r12
      two_barr_red q, barrett_const, r8, r9, r3
      two_barr_red q, barrett_const, r8, r9, r4
      two_barr_red q, barrett_const, r8, r9, r5
      two_barr_red q, barrett_const, r8, r9, r6
      two_barr_red q, barrett_const, r8, r9, r7
      
      stm r0!, {r3-r7}
  .endr
  ldr r3, [r1]
  ldr r4, [r2]
  usub16 r3, r3, r4
  two_barr_red q, barrett_const, r8, r9, r3
  str r3, [r0]
  pop     {r4-r11, pc}


 .global asm_pointwise512
.type asm_pointwise512, %function
.align 2
asm_pointwise512:
  push    {r4-r11, lr}
  r_ptr       .req r0
  a_ptr       .req r1
  b_ptr       .req r2
  
  mont_square .req r4
  a_0         .req r5
  a_1         .req r6
  a_2         .req r7
  b_0         .req r8
  b_1         .req r9
  b_2         .req r10
  tmp1        .req r11
  tmp2        .req r12
  q           .req r14
  qinv        .req r14


  ldr qinv,=53249
  ldr tmp1, =12289
  lsl qinv, #16
  eor qinv, qinv, tmp1
  ldr mont_square, =10952


  b poolpw
  .ltorg
poolpw:
  

  .rept 85
  ldm r1!, {r5-r7}
  ldm r2!, {r8-r10}
  

  smulbb tmp1, a_0, mont_square 
  smultb a_0, a_0, mont_square
  mont_red q, qinv, tmp2, tmp1
  mont_red q, qinv, tmp1, a_0

  smultb tmp2, tmp2, b_0
  smultt a_0, tmp1, b_0

  mont_red q, qinv, tmp1, tmp2
  mont_red q, qinv, tmp2, a_0

  pkhtb a_0, tmp2, tmp1, asr#16

  smulbb tmp1, a_1, mont_square 
  smultb a_1, a_1, mont_square
  mont_red q, qinv, tmp2, tmp1
  mont_red q, qinv, tmp1, a_1

  smultb tmp2, tmp2, b_1
  smultt a_1, tmp1, b_1
  mont_red q, qinv, tmp1, tmp2
  mont_red q, qinv, tmp2, a_1

  pkhtb a_1, tmp2, tmp1, asr#16


  smulbb tmp1, a_2, mont_square 
  smultb a_2, a_2, mont_square
  mont_red q, qinv, tmp2, tmp1
  mont_red q, qinv, tmp1, a_2

  smultb tmp2, tmp2, b_2
  smultt a_2, tmp1, b_2

  mont_red q, qinv, tmp1, tmp2
  mont_red q, qinv, tmp2, a_2

  pkhtb a_2, tmp2, tmp1, asr#16

  stm r0!, {r5-r7}
  .endr

  ldr a_0, [a_ptr]
  ldr b_0, [b_ptr]

  smulbb tmp1, a_0, mont_square 
  smultb a_0, a_0, mont_square
  mont_red q, qinv, tmp2, tmp1
  mont_red q, qinv, tmp1, a_0

  smultb tmp2, tmp2, b_0
  smultt a_0, tmp1, b_0
  mont_red q, qinv, tmp1, tmp2
  mont_red q, qinv, tmp2, a_0

  pkhtb a_0, tmp2, tmp1, asr#16


  str a_0, [r_ptr]
  pop   {r4-r11, pc}
