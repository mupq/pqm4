.syntax unified
.cpu cortex-m4
.thumb

.macro montgomery q, qinv, a, tmp
  smulbt \tmp, \a, \qinv
  smlabb \tmp, \q, \tmp, \a
.endm

.macro doublebarrett_newhope a, tmp, tmp2, q, barrettconst
  smulbt \tmp, \a, \barrettconst
  smultt \tmp2, \a, \barrettconst
  asr \tmp, \tmp, #28
  asr \tmp2, \tmp2, #28
  smulbb \tmp, \tmp, \q
  smulbb \tmp2, \tmp2, \q
  pkhbt \tmp, \tmp, \tmp2, lsl#16
  usub16 \a, \a, \tmp
.endm

.global asm_mul_coeff
.type asm_mul_coeff,%function
.align 2
asm_mul_coeff:
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
  f_3       .req r7            
  f_4       .req r8
  tmp       .req r10
  tmp0      .req r11            
  rcons     .req r12            
  q         .req r14          
  qinv      .req r14          
                               
  movw q, #12289                
  movt qinv, #12287                                
  movw rcons, #10952
                                
  .equ loopcount1, 102           
                                
#ifdef USE_REPT                                                                                                                                    
  .rept loopcount1        
#else                                              
  movw tmp, #loopcount1                             
  mloop:                            
    push {tmp}     
#endif                  
                         
    ldm poly, {r2-r6}                                                
    ldm factors!, {r7-r9}         
                                                      
    smulbb tmp, p_0, f_0
    smultt p_0, p_0, f_0
    montgomery q, qinv, tmp, f_0
    montgomery q, qinv, p_0, tmp
    smultb tmp0, f_0, rcons
    smultb p_0, tmp, rcons
    montgomery q, qinv, tmp0, f_0
    montgomery q, qinv, p_0, tmp   
    pkhtb p_0, tmp, f_0, asr #16

    smulbb tmp, p_1, f_1
    smultt p_1, p_1, f_1
    montgomery q, qinv, tmp, f_1
    montgomery q, qinv, p_1, tmp
    smultb tmp0, f_1, rcons
    smultb p_1, tmp, rcons
    montgomery q, qinv, tmp0, f_1
    montgomery q, qinv, p_1, tmp   
    pkhtb p_1, tmp, f_1, asr #16
            
    smulbb tmp, p_2, f_2
    smultt p_2, p_2, f_2
    montgomery q, qinv, tmp, f_2
    montgomery q, qinv, p_2, tmp
    smultb tmp0, f_2, rcons
    smultb p_2, tmp, rcons
    montgomery q, qinv, tmp0, f_2
    montgomery q, qinv, p_2, tmp   
    pkhtb p_2, tmp, f_2, asr #16
    
    ldm factors!, {r7,r8}                     
    smulbb tmp, p_3, f_3
    smultt p_3, p_3, f_3
    montgomery q, qinv, tmp, f_3
    montgomery q, qinv, p_3, tmp
    smultb tmp0, f_3, rcons
    smultb p_3, tmp, rcons
    montgomery q, qinv, tmp0, f_3
    montgomery q, qinv, p_3, tmp   
    pkhtb p_3, tmp, f_3, asr #16
   
    smulbb tmp, p_4, f_4
    smultt p_4, p_4, f_4
    montgomery q, qinv, tmp, f_4
    montgomery q, qinv, p_4, tmp
    smultb tmp0, f_4, rcons
    smultb p_4, tmp, rcons
    montgomery q, qinv, tmp0, f_4
    montgomery q, qinv, p_4, tmp   
    pkhtb p_4, tmp, f_4, asr #16

    stm poly!, {r2-r6}

#ifdef USE_REPT
  .endr
#else
    pop {tmp}
    subs.w tmp, #1
    bne.w mloop
#endif

  ldm poly, {p_0,p_1}
  ldm factors, {f_0, f_1}

  smulbb tmp, p_0, f_0
  smultt p_0, p_0, f_0
  montgomery q, qinv, tmp, f_0
  montgomery q, qinv, p_0, tmp
  smultb tmp0, f_0, rcons
  smultb p_0, tmp, rcons
  montgomery q, qinv, tmp0, f_0
  montgomery q, qinv, p_0, tmp   
  pkhtb p_0, tmp, f_0, asr #16

  smulbb tmp, p_1, f_1
  smultt p_1, p_1, f_1
  montgomery q, qinv, tmp, f_1
  montgomery q, qinv, p_1, tmp
  smultb tmp0, f_1, rcons
  smultb p_1, tmp, rcons
  montgomery q, qinv, tmp0, f_1
  montgomery q, qinv, p_1, tmp   
  pkhtb p_1, tmp, f_1, asr #16

  stm poly, {p_0, p_1}

  pop     {r4-r11, pc}


.global asm_eight_mul
.type asm_eight_mul,%function
.align 2
asm_eight_mul:
  push    {r4-r11, lr}
  a_ptr     .req r0
  b_ptr     .req r1
  a0a1      .req r2
  a2a3      .req r3
  a4a5      .req r4
  a6a7      .req r5
  b0b1      .req r6
  b2b3      .req r7
  b4b5      .req r8
  b6b7      .req r9
  tmp       .req r10
  tmp0      .req r11
  rcons     .req r12
  q         .req r14
  qinv      .req r14

  movw q, #12289
  movt qinv, #12287
  movw rcons, #10952

  ldm a_ptr, {a0a1-a6a7}
  ldm b_ptr, {b0b1-b6b7}

  smulbb tmp, a0a1, b0b1
  smultt a0a1, a0a1, b0b1
  montgomery q, qinv, tmp, b0b1
  montgomery q, qinv, a0a1, tmp
  smultb tmp0, b0b1, rcons
  smultb a0a1, tmp, rcons
  montgomery q, qinv, tmp0, b0b1
  montgomery q, qinv, a0a1, tmp
  pkhtb a0a1, tmp, b0b1, asr #16

  smulbb tmp, a2a3, b2b3
  smultt a2a3, a2a3, b2b3
  montgomery q, qinv, tmp, b2b3
  montgomery q, qinv, a2a3, tmp
  smultb tmp0, b2b3, rcons
  smultb a2a3, tmp, rcons
  montgomery q, qinv, tmp0, b2b3
  montgomery q, qinv, a2a3, tmp 
  pkhtb a2a3, tmp, b2b3, asr #16

  smulbb tmp, a4a5, b4b5
  smultt a4a5, a4a5, b4b5
  montgomery q, qinv, tmp, b4b5
  montgomery q, qinv, a4a5, tmp
  smultb tmp0, b4b5, rcons
  smultb a4a5, tmp, rcons
  montgomery q, qinv, tmp0, b4b5
  montgomery q, qinv, a4a5, tmp 
  pkhtb a4a5, tmp, b4b5, asr #16

  smulbb tmp, a6a7, b6b7
  smultt a6a7, a6a7, b6b7
  montgomery q, qinv, tmp, b6b7
  montgomery q, qinv, a6a7, tmp
  smultb tmp0, b6b7, rcons
  smultb a6a7, tmp, rcons
  montgomery q, qinv, tmp0, b6b7
  montgomery q, qinv, a6a7, tmp 
  pkhtb a6a7, tmp, b6b7, asr #16

  stm a_ptr, {a0a1-a6a7}

  pop     {r4-r11, pc}


.global asm_add
.type asm_add,%function
.align 2
asm_add:
  push    {r4-r11, lr}
  loop           .req r12
  q              .req r14
  barrettconst   .req r14

  movw q, #12289
  movt barrettconst, #21844 

  .equ loopcount2, 102

#ifdef USE_REPT
  .rept loopcount2
#else
  movw loop, #loopcount2
  aloop:
#endif

    ldm r0, {r2-r6}
    ldm r1!, {r7-r11}

    uadd16 r2, r2, r7
    uadd16 r3, r3, r8
    uadd16 r4, r4, r9
    uadd16 r5, r5, r10
    uadd16 r6, r6, r11

    doublebarrett_newhope r2, r8, r9, q, barrettconst
    doublebarrett_newhope r3, r8, r9, q, barrettconst
    doublebarrett_newhope r4, r8, r9, q, barrettconst
    doublebarrett_newhope r5, r8, r9, q, barrettconst
    doublebarrett_newhope r6, r8, r9, q, barrettconst

    stm r0!, {r2-r6}

#ifdef USE_REPT
  .endr
#else
    subs.w loop, #1 
    bne.w aloop
#endif

  ldm r0, {r2-r3}
  ldm r1!, {r7-r10}

  uadd16 r2, r2, r7
  uadd16 r3, r3, r8

  doublebarrett_newhope r2, r8, r9, q, barrettconst
  doublebarrett_newhope r3, r8, r9, q, barrettconst

  stm r0!, {r2-r3}
  pop     {r4-r11, pc}

.global asm_barrett_reduce
.type asm_barrett_reduce,%function
.align 2
asm_barrett_reduce:
  push    {r4-r11, r14}

  poly         .req r0
  poly0        .req r1
  poly1        .req r2
  poly2        .req r3
  poly3        .req r4
  poly4        .req r5
  poly5        .req r6
  poly6        .req r7
  poly7        .req r8
  tmp          .req r10
  tmp2         .req r11
  loop         .req r12
  q            .req r14 
  barrettconst .req r14

  .equ loopcount, 64

  movw q, #12289
  movt barrettconst, #21844
  movw loop, #loopcount
  redloop:

    ldm poly, {poly0-poly7}

    doublebarrett_newhope poly0, tmp, tmp2, q, barrettconst
    doublebarrett_newhope poly1, tmp, tmp2, q, barrettconst
    doublebarrett_newhope poly2, tmp, tmp2, q, barrettconst
    doublebarrett_newhope poly3, tmp, tmp2, q, barrettconst
    doublebarrett_newhope poly4, tmp, tmp2, q, barrettconst
    doublebarrett_newhope poly5, tmp, tmp2, q, barrettconst
    doublebarrett_newhope poly6, tmp, tmp2, q, barrettconst
    doublebarrett_newhope poly7, tmp, tmp2, q, barrettconst

    stm poly!, {poly0-poly7}

    subs.w loop, #1 
    bne.w redloop

  pop     {r4-r11, pc}

