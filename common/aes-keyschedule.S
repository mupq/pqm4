/******************************************************************************
* ARM assembly implemetnations of the AES-128 and AES-256 key schedule to
* match fixslicing.
* Note that those implementations are fully bitsliced and do not rely on any
* Look-Up Table (LUT).
*
* See the paper at https://eprint.iacr.org/2020/1123.pdf for more details.
*
* @author   Alexandre Adomnicai, Nanyang Technological University, Singapore
*           alexandre.adomnicai@ntu.edu.sg
*
* @date     October 2020
******************************************************************************/

.syntax unified
.thumb

/******************************************************************************
* Macro to compute the SWAPMOVE technique: swap the bits in 'in1' masked by 'm'
* by the bits in 'in0' masked by 'm << n' and put the results in 'out0', 'out1'
******************************************************************************/
.macro swpmv out0, out1, in0, in1, m, n, tmp
    eor     \tmp, \in1, \in0, lsr \n
    and     \tmp, \m
    eor     \out1, \in1, \tmp
    eor     \out0, \in0, \tmp, lsl \n
.endm

/******************************************************************************
* Packing routine. Note that it is the same as the one used in the encryption
* function so some code size could be saved by merging the two files.
******************************************************************************/
.align 2
packing:
    movw    r3, #0x0f0f
    movt    r3, #0x0f0f             // r3 <- 0x0f0f0f0f (mask for SWAPMOVE)
    eor     r2, r3, r3, lsl #2      // r2 <- 0x33333333 (mask for SWAPMOVE)
    eor     r1, r2, r2, lsl #1      // r1 <- 0x55555555 (mask for SWAPMOVE)
    swpmv   r8, r4, r8, r4, r1, #1, r12
    swpmv   r9, r5, r9, r5, r1, #1, r12
    swpmv   r10, r6, r10, r6, r1, #1, r12
    swpmv   r11, r7, r11, r7, r1, #1, r12
    swpmv   r0, r4, r5, r4, r2, #2, r12
    swpmv   r9, r5, r9, r8, r2, #2, r12
    swpmv   r7, r8, r7, r6, r2, #2, r12
    swpmv   r11, r2, r11, r10, r2, #2, r12
    swpmv   r8, r4, r8, r4, r3, #4, r12
    swpmv   r10, r6, r7, r0, r3, #4, r12
    swpmv   r11, r7, r11, r9, r3, #4, r12
    swpmv   r9, r5, r2, r5, r3, #4, r12
    bx      lr

/******************************************************************************
* Subroutine that computes S-box. Note that the same code is used in the
* encryption function, so some code size could be saved by merging the 2 files.
* Credits to https://github.com/Ko-/aes-armcortexm.
******************************************************************************/
.align 2
sbox:
    str     r14, [sp, #52]
    eor     r1, r7, r9              //Exec y14 = U3 ^ U5; into r1
    eor     r3, r4, r10             //Exec y13 = U0 ^ U6; into r3
    eor     r2, r3, r1              //Exec y12 = y13 ^ y14; into r2
    eor     r0, r8, r2              //Exec t1 = U4 ^ y12; into r0
    eor     r14, r0, r9             //Exec y15 = t1 ^ U5; into r14
    and     r12, r2, r14            //Exec t2 = y12 & y15; into r12
    eor     r8, r14, r11            //Exec y6 = y15 ^ U7; into r8
    eor     r0, r0, r5              //Exec y20 = t1 ^ U1; into r0
    str.w   r2, [sp, #44]           //Store r2/y12 on stack
    eor     r2, r4, r7              //Exec y9 = U0 ^ U3; into r2
    str     r0, [sp, #40]           //Store r0/y20 on stack
    eor     r0, r0, r2              //Exec y11 = y20 ^ y9; into r0
    str     r2, [sp, #36]           //Store r2/y9 on stack
    and     r2, r2, r0              //Exec t12 = y9 & y11; into r2
    str     r8, [sp, #32]           //Store r8/y6 on stack
    eor     r8, r11, r0             //Exec y7 = U7 ^ y11; into r8
    eor     r9, r4, r9              //Exec y8 = U0 ^ U5; into r9
    eor     r6, r5, r6              //Exec t0 = U1 ^ U2; into r6
    eor     r5, r14, r6             //Exec y10 = y15 ^ t0; into r5
    str     r14, [sp, #28]          //Store r14/y15 on stack
    eor     r14, r5, r0             //Exec y17 = y10 ^ y11; into r14
    str.w   r1, [sp, #24]           //Store r1/y14 on stack
    and     r1, r1, r14             //Exec t13 = y14 & y17; into r1
    eor     r1, r1, r2              //Exec t14 = t13 ^ t12; into r1
    str     r14, [sp, #20]          //Store r14/y17 on stack
    eor     r14, r5, r9             //Exec y19 = y10 ^ y8; into r14
    str.w   r5, [sp, #16]           //Store r5/y10 on stack
    and     r5, r9, r5              //Exec t15 = y8 & y10; into r5
    eor     r2, r5, r2              //Exec t16 = t15 ^ t12; into r2
    eor     r5, r6, r0              //Exec y16 = t0 ^ y11; into r5
    str.w   r0, [sp, #12]           //Store r0/y11 on stack
    eor     r0, r3, r5              //Exec y21 = y13 ^ y16; into r0
    str     r3, [sp, #8]            //Store r3/y13 on stack
    and     r3, r3, r5              //Exec t7 = y13 & y16; into r3
    str     r5, [sp, #4]            //Store r5/y16 on stack
    str     r11, [sp, #0]           //Store r11/U7 on stack
    eor     r5, r4, r5              //Exec y18 = U0 ^ y16; into r5
    eor     r6, r6, r11             //Exec y1 = t0 ^ U7; into r6
    eor     r7, r6, r7              //Exec y4 = y1 ^ U3; into r7
    and     r11, r7, r11            //Exec t5 = y4 & U7; into r11
    eor     r11, r11, r12           //Exec t6 = t5 ^ t2; into r11
    eor     r11, r11, r2            //Exec t18 = t6 ^ t16; into r11
    eor     r14, r11, r14           //Exec t22 = t18 ^ y19; into r14
    eor     r4, r6, r4              //Exec y2 = y1 ^ U0; into r4
    and     r11, r4, r8             //Exec t10 = y2 & y7; into r11
    eor     r11, r11, r3            //Exec t11 = t10 ^ t7; into r11
    eor     r2, r11, r2             //Exec t20 = t11 ^ t16; into r2
    eor     r2, r2, r5              //Exec t24 = t20 ^ y18; into r2
    eor     r10, r6, r10            //Exec y5 = y1 ^ U6; into r10
    and     r11, r10, r6            //Exec t8 = y5 & y1; into r11
    eor     r3, r11, r3             //Exec t9 = t8 ^ t7; into r3
    eor     r3, r3, r1              //Exec t19 = t9 ^ t14; into r3
    eor     r3, r3, r0              //Exec t23 = t19 ^ y21; into r3
    eor     r0, r10, r9             //Exec y3 = y5 ^ y8; into r0
    ldr     r11, [sp, #32]          //Load y6 into r11
    and     r5, r0, r11             //Exec t3 = y3 & y6; into r5
    eor     r12, r5, r12            //Exec t4 = t3 ^ t2; into r12
    ldr     r5, [sp, #40]           //Load y20 into r5
    str     r7, [sp, #32]           //Store r7/y4 on stack
    eor     r12, r12, r5            //Exec t17 = t4 ^ y20; into r12
    eor     r1, r12, r1             //Exec t21 = t17 ^ t14; into r1
    and     r12, r1, r3             //Exec t26 = t21 & t23; into r12
    eor     r5, r2, r12             //Exec t27 = t24 ^ t26; into r5
    eor     r12, r14, r12           //Exec t31 = t22 ^ t26; into r12
    eor     r1, r1, r14             //Exec t25 = t21 ^ t22; into r1
    and     r7, r1, r5              //Exec t28 = t25 & t27; into r7
    eor     r14, r7, r14            //Exec t29 = t28 ^ t22; into r14
    and     r4, r14, r4             //Exec z14 = t29 & y2; into r4
    and     r8, r14, r8             //Exec z5 = t29 & y7; into r8
    eor     r7, r3, r2              //Exec t30 = t23 ^ t24; into r7
    and     r12, r12, r7            //Exec t32 = t31 & t30; into r12
    eor     r12, r12, r2            //Exec t33 = t32 ^ t24; into r12
    eor     r7, r5, r12             //Exec t35 = t27 ^ t33; into r7
    and     r2, r2, r7              //Exec t36 = t24 & t35; into r2
    eor     r5, r5, r2              //Exec t38 = t27 ^ t36; into r5
    and     r5, r14, r5             //Exec t39 = t29 & t38; into r5
    eor     r1, r1, r5              //Exec t40 = t25 ^ t39; into r1
    eor     r5, r14, r1             //Exec t43 = t29 ^ t40; into r5
    ldr.w   r7, [sp, #4]            //Load y16 into r7
    and     r7, r5, r7              //Exec z3 = t43 & y16; into r7
    eor     r8, r7, r8              //Exec tc12 = z3 ^ z5; into r8
    str     r8, [sp, #40]           //Store r8/tc12 on stack
    ldr     r8, [sp, #8]            //Load y13 into r8
    and     r8, r5, r8              //Exec z12 = t43 & y13; into r8
    and     r10, r1, r10            //Exec z13 = t40 & y5; into r10
    and     r6, r1, r6              //Exec z4 = t40 & y1; into r6
    eor     r6, r7, r6              //Exec tc6 = z3 ^ z4; into r6
    eor     r3, r3, r12             //Exec t34 = t23 ^ t33; into r3
    eor     r3, r2, r3              //Exec t37 = t36 ^ t34; into r3
    eor     r1, r1, r3              //Exec t41 = t40 ^ t37; into r1
    ldr.w   r5, [sp, #16]           //Load y10 into r5
    and     r2, r1, r5              //Exec z8 = t41 & y10; into r2
    and     r9, r1, r9              //Exec z17 = t41 & y8; into r9
    str     r9, [sp, #16]           //Store r9/z17 on stack
    eor     r5, r12, r3             //Exec t44 = t33 ^ t37; into r5
    ldr     r9, [sp, #28]           //Load y15 into r9
    ldr.w   r7, [sp, #44]           //Load y12 into r7
    and     r9, r5, r9              //Exec z0 = t44 & y15; into r9
    and     r7, r5, r7              //Exec z9 = t44 & y12; into r7
    and     r0, r3, r0              //Exec z10 = t37 & y3; into r0
    and     r3, r3, r11             //Exec z1 = t37 & y6; into r3
    eor     r3, r3, r9              //Exec tc5 = z1 ^ z0; into r3
    eor     r3, r6, r3              //Exec tc11 = tc6 ^ tc5; into r3
    ldr     r11, [sp, #32]          //Load y4 into r11
    ldr.w   r5, [sp, #20]           //Load y17 into r5
    and     r11, r12, r11           //Exec z11 = t33 & y4; into r11
    eor     r14, r14, r12           //Exec t42 = t29 ^ t33; into r14
    eor     r1, r14, r1             //Exec t45 = t42 ^ t41; into r1
    and     r5, r1, r5              //Exec z7 = t45 & y17; into r5
    eor     r6, r5, r6              //Exec tc8 = z7 ^ tc6; into r6
    ldr     r5, [sp, #24]           //Load y14 into r5
    str     r4, [sp, #32]           //Store r4/z14 on stack
    and     r1, r1, r5              //Exec z16 = t45 & y14; into r1
    ldr     r5, [sp, #12]           //Load y11 into r5
    ldr     r4, [sp, #36]           //Load y9 into r4
    and     r5, r14, r5             //Exec z6 = t42 & y11; into r5
    eor     r5, r5, r6              //Exec tc16 = z6 ^ tc8; into r5
    and     r4, r14, r4             //Exec z15 = t42 & y9; into r4
    eor     r14, r4, r5             //Exec tc20 = z15 ^ tc16; into r14
    eor     r4, r4, r1              //Exec tc1 = z15 ^ z16; into r4
    eor     r1, r0, r4              //Exec tc2 = z10 ^ tc1; into r1
    eor     r0, r1, r11             //Exec tc21 = tc2 ^ z11; into r0
    eor     r7, r7, r1              //Exec tc3 = z9 ^ tc2; into r7
    eor     r1, r7, r5              //Exec S0 = tc3 ^ tc16; into r1
    eor     r7, r7, r3              //Exec S3 = tc3 ^ tc11; into r7
    eor     r3, r7, r5              //Exec S1 = S3 ^ tc16 ^ 1; into r3
    eor     r11, r10, r4            //Exec tc13 = z13 ^ tc1; into r11
    ldr.w   r4, [sp, #0]            //Load U7 into r4
    and     r12, r12, r4            //Exec z2 = t33 & U7; into r12
    eor     r9, r9, r12             //Exec tc4 = z0 ^ z2; into r9
    eor     r12, r8, r9             //Exec tc7 = z12 ^ tc4; into r12
    eor     r2, r2, r12             //Exec tc9 = z8 ^ tc7; into r2
    eor     r2, r6, r2              //Exec tc10 = tc8 ^ tc9; into r2
    ldr.w   r4, [sp, #32]           //Load z14 into r4
    eor     r12, r4, r2             //Exec tc17 = z14 ^ tc10; into r12
    eor     r0, r0, r12             //Exec S5 = tc21 ^ tc17; into r0
    eor     r6, r12, r14            //Exec tc26 = tc17 ^ tc20; into r6
    ldr.w   r4, [sp, #16]           //Load z17 into r4
    ldr     r12, [sp, #40]          //Load tc12 into r12
    eor     r6, r6, r4              //Exec S2 = tc26 ^ z17 ^ 1; into r6
    eor     r12, r9, r12            //Exec tc14 = tc4 ^ tc12; into r12
    eor     r14, r11, r12           //Exec tc18 = tc13 ^ tc14; into r14
    eor     r2, r2, r14             //Exec S6 = tc10 ^ tc18 ^ 1; into r2
    eor     r11, r8, r14            //Exec S7 = z12 ^ tc18 ^ 1; into r11
    ldr     r14, [sp, #52]          // restore link register
    eor     r8, r12, r7             //Exec S4 = tc14 ^ S3; into r8
    bx      lr
    // [('r0', 'S5'), ('r1', 'S0'), ('r2', 'S6'), ('r3', 'S1'),
    // ('r6', 'S2'),('r7', 'S3'), ('r8', 'S4'), ('r11', 'S7')]

/******************************************************************************
* Subroutine that XORs the columns after the S-box during the AES-128 key
* schedule round function, for rounds i such that (i % 4) == 0.
* Note that the code size could be reduced at the cost of some instructions
* since some redundant code is applied on different registers.
******************************************************************************/
.align 2
aes128_xorcolumns_rotword:
    ldr     r12, [sp, #56]          // restore 'rkeys' address
    ldr.w   r5, [r12, #28]          // load rkey word of rkey from prev round
    movw    r4, #0xc0c0
    movt    r4, #0xc0c0             // r4 <- 0xc0c0c0c0
    eor     r11, r5, r11, ror #2    // r11<- r5 ^ (r11 >>> 2)
    bic     r11, r4, r11            // r11<- ~r11 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r9, r5, r11, ror #2     // r9 <- r5 ^ (r11 >>> 2)
    and     r9, r9, r4, ror #2      // r9 <- r9 & 0x30303030
    orr     r11, r11, r9            // r11<- r11 | r9
    eor     r9, r5, r11, ror #2     // r9 <- r5 ^ (r11 >>> 2)
    and     r9, r9, r4, ror #4      // r9 <- r9 & 0x0c0c0c0c
    orr     r11, r11, r9            // r11<- r11 | r9
    eor     r9, r5, r11, ror #2     // r9 <- r5 ^ (r11 >>> 2)
    and     r9, r9, r4, ror #6      // r9 <- r9 & 0x03030303
    orr     r11, r11, r9            // r11<- r11 | r9
    mvn     r9, r5                  // NOT omitted in sbox
    ldr.w   r5, [r12, #24]          // load rkey word of rkey from prev round
    str     r9, [r12, #28]          // store new rkey word after NOT
    str     r11, [r12, #60]         // store new rkey word in 'rkeys'
    eor     r10, r5, r2, ror #2     // r10<- r5 ^ (r2 >>> 2)
    bic     r10, r4, r10            // r10<- ~r10 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r9, r5, r10, ror #2     // r9 <- r5 ^ (r10 >>> 2)
    and     r9, r9, r4, ror #2      // r9 <- r9 & 0x30303030
    orr     r10, r10, r9            // r10<- r10 | r9
    eor     r9, r5, r10, ror #2     // r9 <- r5 ^ (r10 >>> 2)
    and     r9, r9, r4, ror #4      // r9 <- r9 & 0x0c0c0c0c
    orr     r10, r10, r9            // r10<- r10 | r9
    eor     r9, r5, r10, ror #2     // r9 <- r5 ^ (r10 >>> 2)
    and     r9, r9, r4, ror #6      // r9 <- r9 & 0x03030303
    orr     r10, r10, r9            // r10<- r10 | r9
    mvn     r9, r5                  // NOT omitted in sbox
    ldr.w   r2, [r12, #20]          // load rkey word of rkey from prev round
    str     r9, [r12, #24]          // store new rkey word after NOT
    str     r10, [r12, #56]         // store new rkey word in 'rkeys'
    eor     r9, r2, r0, ror #2      // r9 <- r2 ^ (r9 >>> 2)
    and     r9, r4, r9              // r9 <- r9 & 0xc0c0c0c0
    eor     r0, r2, r9, ror #2      // r0 <- r2 ^ (r9 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r9, r9, r0              // r9 <- r9 | r0
    eor     r0, r2, r9, ror #2      // r0 <- r2 ^ (r9 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r9, r9, r0              // r9 <- r9 | r0
    eor     r0, r2, r9, ror #2      // r0 <- r2 ^ (r9 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r9, r9, r0              // r9 <- r9 | r0
    ldr.w   r2, [r12, #16]          // load rkey word of rkey from prev round
    str.w   r9, [r12, #52]          // store new rkey word in 'rkeys'
    eor     r8, r2, r8, ror #2      // r8 <- r2 ^ (r8 >>> 2)
    and     r8, r4, r8              // r8 <- r8 & 0xc0c0c0c0
    eor     r0, r2, r8, ror #2      // r0 <- r2 ^ (r8 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r8, r8, r0              // r8 <- r8 | r0
    eor     r0, r2, r8, ror #2      // r0 <- r2 ^ (r8 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r8, r8, r0              // r8 <- r8 | r0
    eor     r0, r2, r8, ror #2      // r0 <- r2 ^ (r8 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r8, r8, r0              // r8 <- r8 | r0
    ldr.w   r2, [r12, #12]          // load rkey word of rkey from prev round
    str.w   r8, [r12, #48]          // store new rkey word in 'rkeys'
    eor     r7, r2, r7, ror #2      // r7 <- r2 ^ (r7 >>> 2)
    and     r7, r4, r7              // r7 <- r7 & 0xc0c0c0c0
    eor     r0, r2, r7, ror #2      // r0 <- r2 ^ (r7 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r7, r7, r0              // r7 <- r7 | r0
    eor     r0, r2, r7, ror #2      // r0 <- r2 ^ (r7 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r7, r7, r0              // r7 <- r7 | r0
    eor     r0, r2, r7, ror #2      // r0 <- r2 ^ (r7 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r7, r7, r0              // r7 <- r7 | r0
    ldr.w   r2, [r12, #8]           // load rkey word of rkey from prev round
    str.w   r7, [r12, #44]          // store new rkey word in 'rkeys'
    eor     r6, r2, r6, ror #2      // r6 <- r2 ^ (r6 >>> 2)
    bic     r6, r4, r6              // r6 <- ~r6 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r0, r2, r6, ror #2      // r0 <- r2 ^ (r6 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r6, r6, r0              // r6 <- r6 | r0
    eor     r0, r2, r6, ror #2      // r0 <- r2 ^ (r6 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r6, r6, r0              // r6 <- r6 | r0
    eor     r0, r2, r6, ror #2      // r0 <- r2 ^ (r6 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r6, r6, r0              // r6 <- r6 | r0
    mvn     r0, r2                  // NOT omitted in sbox
    ldr.w   r2, [r12, #4]           // load rkey word of rkey from prev round
    str.w   r0, [r12, #8]           // store new rkey word after NOT
    str.w   r6, [r12, #40]          // store new rkey word in 'rkeys'
    eor     r5, r2, r3, ror #2      // r5 <- r2 ^ (r3 >>> 2)
    bic     r5, r4, r5              // r5 <- ~r5 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r0, r2, r5, ror #2      // r0 <- r2 ^ (r5 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r5, r5, r0              // r5 <- r5 | r0
    eor     r0, r2, r5, ror #2      // r0 <- r2 ^ (r5 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r5, r5, r0              // r5 <- r5 | r0
    eor     r0, r2, r5, ror #2      // r0 <- r2 ^ (r5 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r5, r5, r0              // r5 <- r5 | r0
    mvn     r0, r2                  // NOT omitted in sbox
    ldr.w   r2, [r12], #32          // load rkey word of rkey from prev round
    str.w   r0, [r12, #-28]         // store new rkey word after NOT
    str.w   r5, [r12, #4]           // store new rkey word in 'rkeys'
    eor     r3, r2, r1, ror #2      // r3 <- r2 ^ (r1 >>> 2)
    and     r3, r4, r3              // r3 <- r3 & 0xc0c0c0c0
    eor     r0, r2, r3, ror #2      // r0 <- r2 ^ (r3 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r3, r3, r0              // r3 <- r3 | r0
    eor     r0, r2, r3, ror #2      // r0 <- r2 ^ (r3 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r3, r3, r0              // r3 <- r3 | r0
    eor     r0, r2, r3, ror #2      // r0 <- r2 ^ (r3 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r4, r3, r0              // r4 <- r3 | r0
    str.w   r4, [r12]
    str.w   r12, [sp, #56]          // store the new rkeys address on the stack
    bx      lr

/******************************************************************************
* Subroutine that XORs the columns after the S-box during the AES-256 key
* schedule round function, for rounds i such that (i % 4) == 0.
* Differs from 'aes128_xorcolumns_rotword' by the rkeys' indexes to be involved
* in XORs.
******************************************************************************/
.align 2
aes256_xorcolumns_rotword:
    ldr     r12, [sp, #56]          // restore 'rkeys' address
    ldr.w   r5, [r12, #28]          // load rkey word of rkey from prev round
    movw    r4, #0xc0c0
    movt    r4, #0xc0c0             // r4 <- 0xc0c0c0c0
    eor     r11, r5, r11, ror #2    // r11<- r5 ^ (r11 >>> 2)
    bic     r11, r4, r11            // r11<- ~r11 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r9, r5, r11, ror #2     // r9 <- r5 ^ (r11 >>> 2)
    and     r9, r9, r4, ror #2      // r9 <- r9 & 0x30303030
    orr     r11, r11, r9            // r11<- r11 | r9
    eor     r9, r5, r11, ror #2     // r9 <- r5 ^ (r11 >>> 2)
    and     r9, r9, r4, ror #4      // r9 <- r9 & 0x0c0c0c0c
    orr     r11, r11, r9            // r11<- r11 | r9
    eor     r9, r5, r11, ror #2     // r9 <- r5 ^ (r11 >>> 2)
    and     r9, r9, r4, ror #6      // r9 <- r9 & 0x03030303
    orr     r11, r11, r9            // r11<- r11 | r9
    mvn     r9, r5                  // NOT omitted in sbox
    ldr.w   r5, [r12, #24]          // load rkey word of rkey from prev round
    str     r9, [r12, #28]          // store new rkey word after NOT
    str     r11, [r12, #92]         // store new rkey word in 'rkeys'
    eor     r10, r5, r2, ror #2     // r10<- r5 ^ (r2 >>> 2)
    bic     r10, r4, r10            // r10<- ~r10 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r9, r5, r10, ror #2     // r9 <- r5 ^ (r10 >>> 2)
    and     r9, r9, r4, ror #2      // r9 <- r9 & 0x30303030
    orr     r10, r10, r9            // r10<- r10 | r9
    eor     r9, r5, r10, ror #2     // r9 <- r5 ^ (r10 >>> 2)
    and     r9, r9, r4, ror #4      // r9 <- r9 & 0x0c0c0c0c
    orr     r10, r10, r9            // r10<- r10 | r9
    eor     r9, r5, r10, ror #2     // r9 <- r5 ^ (r10 >>> 2)
    and     r9, r9, r4, ror #6      // r9 <- r9 & 0x03030303
    orr     r10, r10, r9            // r10<- r10 | r9
    mvn     r9, r5                  // NOT omitted in sbox
    ldr.w   r2, [r12, #20]          // load rkey word of rkey from prev round
    str     r9, [r12, #24]          // store new rkey word after NOT
    str     r10, [r12, #88]         // store new rkey word in 'rkeys'
    eor     r9, r2, r0, ror #2      // r9 <- r2 ^ (r9 >>> 2)
    and     r9, r4, r9              // r9 <- r9 & 0xc0c0c0c0
    eor     r0, r2, r9, ror #2      // r0 <- r2 ^ (r9 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r9, r9, r0              // r9 <- r9 | r0
    eor     r0, r2, r9, ror #2      // r0 <- r2 ^ (r9 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r9, r9, r0              // r9 <- r9 | r0
    eor     r0, r2, r9, ror #2      // r0 <- r2 ^ (r9 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r9, r9, r0              // r9 <- r9 | r0
    ldr.w   r2, [r12, #16]          // load rkey word of rkey from prev round
    str.w   r9, [r12, #84]          // store new rkey word in 'rkeys'
    eor     r8, r2, r8, ror #2      // r8 <- r2 ^ (r8 >>> 2)
    and     r8, r4, r8              // r8 <- r8 & 0xc0c0c0c0
    eor     r0, r2, r8, ror #2      // r0 <- r2 ^ (r8 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r8, r8, r0              // r8 <- r8 | r0
    eor     r0, r2, r8, ror #2      // r0 <- r2 ^ (r8 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r8, r8, r0              // r8 <- r8 | r0
    eor     r0, r2, r8, ror #2      // r0 <- r2 ^ (r8 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r8, r8, r0              // r8 <- r8 | r0
    ldr.w   r2, [r12, #12]          // load rkey word of rkey from prev round
    str.w   r8, [r12, #80]          // store new rkey word in 'rkeys'
    eor     r7, r2, r7, ror #2      // r7 <- r2 ^ (r7 >>> 2)
    and     r7, r4, r7              // r7 <- r7 & 0xc0c0c0c0
    eor     r0, r2, r7, ror #2      // r0 <- r2 ^ (r7 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r7, r7, r0              // r7 <- r7 | r0
    eor     r0, r2, r7, ror #2      // r0 <- r2 ^ (r7 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r7, r7, r0              // r7 <- r7 | r0
    eor     r0, r2, r7, ror #2      // r0 <- r2 ^ (r7 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r7, r7, r0              // r7 <- r7 | r0
    ldr.w   r2, [r12, #8]           // load rkey word of rkey from prev round
    str.w   r7, [r12, #76]          // store new rkey word in 'rkeys'
    eor     r6, r2, r6, ror #2      // r6 <- r2 ^ (r6 >>> 2)
    bic     r6, r4, r6              // r6 <- ~r6 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r0, r2, r6, ror #2      // r0 <- r2 ^ (r6 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r6, r6, r0              // r6 <- r6 | r0
    eor     r0, r2, r6, ror #2      // r0 <- r2 ^ (r6 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r6, r6, r0              // r6 <- r6 | r0
    eor     r0, r2, r6, ror #2      // r0 <- r2 ^ (r6 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r6, r6, r0              // r6 <- r6 | r0
    mvn     r0, r2                  // NOT omitted in sbox
    ldr.w   r2, [r12, #4]           // load rkey word of rkey from prev round
    str.w   r0, [r12, #8]           // store new rkey word after NOT
    str.w   r6, [r12, #72]          // store new rkey word in 'rkeys'
    eor     r5, r2, r3, ror #2      // r5 <- r2 ^ (r3 >>> 2)
    bic     r5, r4, r5              // r5 <- ~r5 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r0, r2, r5, ror #2      // r0 <- r2 ^ (r5 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r5, r5, r0              // r5 <- r5 | r0
    eor     r0, r2, r5, ror #2      // r0 <- r2 ^ (r5 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r5, r5, r0              // r5 <- r5 | r0
    eor     r0, r2, r5, ror #2      // r0 <- r2 ^ (r5 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r5, r5, r0              // r5 <- r5 | r0
    mvn     r0, r2                  // NOT omitted in sbox
    ldr.w   r2, [r12], #32          // load rkey word of rkey from prev round
    str.w   r0, [r12, #-28]         // store new rkey word after NOT
    str.w   r5, [r12, #36]          // store new rkey word in 'rkeys'
    eor     r3, r2, r1, ror #2      // r3 <- r2 ^ (r1 >>> 2)
    and     r3, r4, r3              // r3 <- r3 & 0xc0c0c0c0
    eor     r0, r2, r3, ror #2      // r0 <- r2 ^ (r3 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r3, r3, r0              // r3 <- r3 | r0
    eor     r0, r2, r3, ror #2      // r0 <- r2 ^ (r3 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r3, r3, r0              // r3 <- r3 | r0
    eor     r0, r2, r3, ror #2      // r0 <- r2 ^ (r3 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r4, r3, r0              // r4 <- r3 | r0
    str.w   r4, [r12, #32]
    str.w   r12, [sp, #56]          // store the new rkeys address on the stack
    bx      lr

/******************************************************************************
* Subroutine that XORs the columns after the S-box during the AES-256 key
* schedule round function, for rounds i such that (i % 4) == 0.
* It differs from 'aes256_xorcolumns_rotword' by the omission of the rotword
* operation (i.e. 'ror #26' instead of 'ror #2').
******************************************************************************/
.align 2
aes256_xorcolumns:
    ldr     r12, [sp, #56]          // restore 'rkeys' address
    ldr.w   r5, [r12, #28]          // load rkey word of rkey from prev round
    movw    r4, #0xc0c0
    movt    r4, #0xc0c0             // r4 <- 0xc0c0c0c0
    eor     r11, r5, r11, ror #26   // r11<- r5 ^ (r11 >>> 26)
    bic     r11, r4, r11            // r11<- ~r11 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r9, r5, r11, ror #2     // r9 <- r5 ^ (r11 >>> 2)
    and     r9, r9, r4, ror #2      // r9 <- r9 & 0x30303030
    orr     r11, r11, r9            // r11<- r11 | r9
    eor     r9, r5, r11, ror #2     // r9 <- r5 ^ (r11 >>> 2)
    and     r9, r9, r4, ror #4      // r9 <- r9 & 0x0c0c0c0c
    orr     r11, r11, r9            // r11<- r11 | r9
    eor     r9, r5, r11, ror #2     // r9 <- r5 ^ (r11 >>> 2)
    and     r9, r9, r4, ror #6      // r9 <- r9 & 0x03030303
    orr     r11, r11, r9            // r11<- r11 | r9
    mvn     r9, r5                  // NOT omitted in sbox
    ldr.w   r5, [r12, #24]          // load rkey word of rkey from prev round
    str     r9, [r12, #28]          // store new rkey word after NOT
    str     r11, [r12, #92]         // store new rkey word in 'rkeys'
    eor     r10, r5, r2, ror #26    // r10<- r5 ^ (r2 >>> 2)
    bic     r10, r4, r10            // r10<- ~r10 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r9, r5, r10, ror #2     // r9 <- r5 ^ (r10 >>> 2)
    and     r9, r9, r4, ror #2      // r9 <- r9 & 0x30303030
    orr     r10, r10, r9            // r10<- r10 | r9
    eor     r9, r5, r10, ror #2     // r9 <- r5 ^ (r10 >>> 2)
    and     r9, r9, r4, ror #4      // r9 <- r9 & 0x0c0c0c0c
    orr     r10, r10, r9            // r10<- r10 | r9
    eor     r9, r5, r10, ror #2     // r9 <- r5 ^ (r10 >>> 2)
    and     r9, r9, r4, ror #6      // r9 <- r9 & 0x03030303
    orr     r10, r10, r9            // r10<- r10 | r9
    mvn     r9, r5                  // NOT omitted in sbox
    ldr.w   r2, [r12, #20]          // load rkey word of rkey from prev round
    str     r9, [r12, #24]          // store new rkey word after NOT
    str     r10, [r12, #88]         // store new rkey word in 'rkeys'
    eor     r9, r2, r0, ror #26     // r9 <- r2 ^ (r9 >>> 26)
    and     r9, r4, r9              // r9 <- r9 & 0xc0c0c0c0
    eor     r0, r2, r9, ror #2      // r0 <- r2 ^ (r9 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r9, r9, r0              // r9 <- r9 | r0
    eor     r0, r2, r9, ror #2      // r0 <- r2 ^ (r9 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r9, r9, r0              // r9 <- r9 | r0
    eor     r0, r2, r9, ror #2      // r0 <- r2 ^ (r9 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r9, r9, r0              // r9 <- r9 | r0
    ldr.w   r2, [r12, #16]          // load rkey word of rkey from prev round
    str.w   r9, [r12, #84]          // store new rkey word in 'rkeys'
    eor     r8, r2, r8, ror #26     // r8 <- r2 ^ (r8 >>> 26)
    and     r8, r4, r8              // r8 <- r8 & 0xc0c0c0c0
    eor     r0, r2, r8, ror #2      // r0 <- r2 ^ (r8 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r8, r8, r0              // r8 <- r8 | r0
    eor     r0, r2, r8, ror #2      // r0 <- r2 ^ (r8 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r8, r8, r0              // r8 <- r8 | r0
    eor     r0, r2, r8, ror #2      // r0 <- r2 ^ (r8 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r8, r8, r0              // r8 <- r8 | r0
    ldr.w   r2, [r12, #12]          // load rkey word of rkey from prev round
    str.w   r8, [r12, #80]          // store new rkey word in 'rkeys'
    eor     r7, r2, r7, ror #26     // r7 <- r2 ^ (r7 >>> 26)
    and     r7, r4, r7              // r7 <- r7 & 0xc0c0c0c0
    eor     r0, r2, r7, ror #2      // r0 <- r2 ^ (r7 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r7, r7, r0              // r7 <- r7 | r0
    eor     r0, r2, r7, ror #2      // r0 <- r2 ^ (r7 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r7, r7, r0              // r7 <- r7 | r0
    eor     r0, r2, r7, ror #2      // r0 <- r2 ^ (r7 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r7, r7, r0              // r7 <- r7 | r0
    ldr.w   r2, [r12, #8]           // load rkey word of rkey from prev round
    str.w   r7, [r12, #76]          // store new rkey word in 'rkeys'
    eor     r6, r2, r6, ror #26     // r6 <- r2 ^ (r6 >>> 26)
    bic     r6, r4, r6              // r6 <- ~r6 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r0, r2, r6, ror #2      // r0 <- r2 ^ (r6 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r6, r6, r0              // r6 <- r6 | r0
    eor     r0, r2, r6, ror #2      // r0 <- r2 ^ (r6 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r6, r6, r0              // r6 <- r6 | r0
    eor     r0, r2, r6, ror #2      // r0 <- r2 ^ (r6 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r6, r6, r0              // r6 <- r6 | r0
    mvn     r0, r2                  // NOT omitted in sbox
    ldr.w   r2, [r12, #4]           // load rkey word of rkey from prev round
    str.w   r0, [r12, #8]           // store new rkey word after NOT
    str.w   r6, [r12, #72]          // store new rkey word in 'rkeys'
    eor     r5, r2, r3, ror #26     // r5 <- r2 ^ (r3 >>> 26)
    bic     r5, r4, r5              // r5 <- ~r5 & 0xc0c0c0c0 (NOT omitted in sbox)
    eor     r0, r2, r5, ror #2      // r0 <- r2 ^ (r5 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r5, r5, r0              // r5 <- r5 | r0
    eor     r0, r2, r5, ror #2      // r0 <- r2 ^ (r5 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r5, r5, r0              // r5 <- r5 | r0
    eor     r0, r2, r5, ror #2      // r0 <- r2 ^ (r5 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r5, r5, r0              // r5 <- r5 | r0
    mvn     r0, r2                  // NOT omitted in sbox
    ldr.w   r2, [r12], #32          // load rkey word of rkey from prev round
    str.w   r0, [r12, #-28]         // store new rkey word after NOT
    str.w   r5, [r12, #36]          // store new rkey word in 'rkeys'
    eor     r3, r2, r1, ror #26     // r3 <- r2 ^ (r1 >>> 26)
    and     r3, r4, r3              // r3 <- r3 & 0xc0c0c0c0
    eor     r0, r2, r3, ror #2      // r0 <- r2 ^ (r3 >>> 2)
    and     r0, r0, r4, ror #2      // r0 <- r0 & 0x30303030
    orr     r3, r3, r0              // r3 <- r3 | r0
    eor     r0, r2, r3, ror #2      // r0 <- r2 ^ (r3 >>> 2)
    and     r0, r0, r4, ror #4      // r0 <- r0 & 0x0c0c0c0c
    orr     r3, r3, r0              // r3 <- r3 | r0
    eor     r0, r2, r3, ror #2      // r0 <- r2 ^ (r3 >>> 2)
    and     r0, r0, r4, ror #6      // r0 <- r0 & 0x03030303
    orr     r4, r3, r0              // r4 <- r3 | r0
    str.w   r4, [r12, #32]
    str.w   r12, [sp, #56]          // store the new rkeys address on the stack
    bx      lr

/******************************************************************************
* Applies ShiftRows^(-1) on a round key to match the fixsliced representation.
******************************************************************************/
.align 2
inv_shiftrows_1:
    ldr.w   r2, [r12, #-32]!
    str     r14, [sp, #52]          // store link register
    movw    r1, #8
    movw    r14, #0x0300
    movt    r14, #0x0c0f            // r14<- 0x0c0f0300 for ShiftRows^[-1]
loop_inv_sr_1:
    movw    r3, #0x3300
    movt    r3, #0x3300             // r3 <- 0x33003300 for ShiftRows^[-1]
    swpmv   r2, r2, r2, r2, r14, 4, r0
    eor     r0, r2, r2, lsr #2
    and     r0, r3
    eor     r2, r2, r0
    eor     r3, r2, r0, lsl #2
    ldr.w   r2, [r12, #4]!
    str.w   r3, [r12, #-4]
    subs    r1, #1
    bne     loop_inv_sr_1
    ldr     r14, [sp, #52]          // restore link register
    bx      lr

/******************************************************************************
* Applies ShiftRows^(-2) on a round key to match the fixsliced representation.
* Only needed for the fully-fixsliced (ffs) representation.
******************************************************************************/
.align 2
inv_shiftrows_2:
    ldr.w   r2, [r12, #-32]!
    str     r14, [sp, #52]          // store link register
    movw    r1, #8
    movw    r14, #0x0f00
    movt    r14, #0x0f00            // r14<- 0x0f000f00 for ShiftRows^[-2]
loop_inv_sr_2:
    eor     r0, r2, r2, lsr #4
    and     r0, r14
    eor     r2, r2, r0
    eor     r3, r2, r0, lsl #4
    ldr.w   r2, [r12, #4]!
    str.w   r3, [r12, #-4]
    subs    r1, #1
    bne     loop_inv_sr_2
    ldr     r14, [sp, #52]          // restore link register
    bx      lr

/******************************************************************************
* Applies ShiftRows^(-3) on a round key to match the fixsliced representation.
* Only needed for the fully-fixsliced (ffs) representation.
******************************************************************************/
.align 2
inv_shiftrows_3:
    ldr.w   r2, [r12, #-32]!
    str     r14, [sp, #52]          // store link register
    movw    r1, #8
    movw    r14, #0x0c00
    movt    r14, #0x030f            // r14<- 0x030f0c00 for ShiftRows^[-3]
loop_inv_sr_3:
    movw    r3, #0x3300
    movt    r3, #0x3300             // r3 <- 0x33003300 for ShiftRows^[-3]
    swpmv   r2, r2, r2, r2, r14, 4, r0
    eor     r0, r2, r2, lsr #2
    and     r0, r3
    eor     r2, r2, r0
    eor     r3, r2, r0, lsl #2
    ldr.w   r2, [r12, #4]!
    str.w   r3, [r12, #-4]
    subs    r1, #1
    bne     loop_inv_sr_3
    ldr     r14, [sp, #52]          // restore link register
    bx      lr

/******************************************************************************
* Fully bitsliced AES-128 key schedule to match the fully-fixsliced (ffs)
* representation. Note that it is possible to pass two different keys as input
* parameters if one wants to encrypt 2 blocks in with two different keys.
******************************************************************************/
@ void aes128_keyschedule_ffs(u32* rkeys, const u8* key);
.global aes128_keyschedule_ffs
.type   aes128_keyschedule_ffs,%function
.align 2
aes128_keyschedule_ffs:
    push    {r0-r12,r14}
    sub.w   sp, #56                 // allow space on the stack for tmp var
    ldr.w   r4, [r1]                // load the 128-bit key in r4-r7
    ldr     r5, [r1, #4]
    ldr     r6, [r1, #8]
    ldr     r7, [r1, #12]
    ldr.w   r8, [r1]                // load the 128-bit key in r8-r11
    ldr     r9, [r1, #4]
    ldr     r10,[r1, #8]
    ldr     r11,[r1, #12]
    bl      packing                 // pack the master key
    ldr.w   r0, [sp, #56]           // restore 'rkeys' address
    stm     r0, {r4-r11}            // store the packed master key in 'rkeys'
    bl      sbox                    // apply the sbox to the master key
    eor     r11, r11, #0x00000300   // add the 1st rconst
    bl      aes128_xorcolumns_rotword
    bl      sbox                    // apply the sbox to the master key
    eor     r2, r2, #0x00000300     // add the 2nd rconst
    bl      aes128_xorcolumns_rotword
    bl      inv_shiftrows_1
    bl      sbox                    // apply the sbox to the master key
    eor     r0, r0, #0x00000300     // add the 3rd rconst
    bl      aes128_xorcolumns_rotword
    bl      inv_shiftrows_2
    bl      sbox                    // apply the sbox to the master key
    eor     r8, r8, #0x00000300     // add the 4th rconst
    bl      aes128_xorcolumns_rotword
    bl      inv_shiftrows_3
    bl      sbox                    // apply the sbox to the master key
    eor     r7, r7, #0x00000300     // add the 5th rconst
    bl      aes128_xorcolumns_rotword
    bl      sbox                    // apply the sbox to the master key
    eor     r6, r6, #0x00000300     // add the 6th rconst
    bl      aes128_xorcolumns_rotword
    bl      inv_shiftrows_1
    bl      sbox                    // apply the sbox to the master key
    eor     r3, r3, #0x00000300     // add the 7th rconst
    bl      aes128_xorcolumns_rotword
    bl      inv_shiftrows_2
    bl      sbox                    // apply the sbox to the master key
    eor     r1, r1, #0x00000300     // add the 8th rconst
    bl      aes128_xorcolumns_rotword
    bl      inv_shiftrows_3
    bl      sbox                    // apply the sbox to the master key
    eor     r11, r11, #0x00000300   // add the 9th rconst
    eor     r2, r2, #0x00000300     // add the 9th rconst
    eor     r8, r8, #0x00000300     // add the 9th rconst
    eor     r7, r7, #0x00000300     // add the 9th rconst
    bl      aes128_xorcolumns_rotword
    bl      sbox                    // apply the sbox to the master key
    eor     r2, r2, #0x00000300     // add the 10th rconst
    eor     r0, r0, #0x00000300     // add the 10th rconst
    eor     r7, r7, #0x00000300     // add the 10th rconst
    eor     r6, r6, #0x00000300     // add the 10th rconst
    bl      aes128_xorcolumns_rotword
    bl      inv_shiftrows_1
    mvn     r5, r5                  // add the NOT for the last rkey
    mvn     r6, r6                  // add the NOT for the last rkey
    mvn     r10, r10                // add the NOT for the last rkey
    mvn     r11, r11                // add the NOT for the last rkey
    strd    r5, r6, [r12, #4]
    strd    r10, r11, [r12, #24]
    ldrd    r0, r1, [r12, #-316]
    ldrd    r2, r3, [r12, #-296]
    mvn     r0, r0                  // remove the NOT for the key whitening
    mvn     r1, r1                  // remove the NOT for the key whitening
    mvn     r2, r2                  // remove the NOT for the key whitening
    mvn     r3, r3                  // remove the NOT for the key whitening
    strd    r0, r1, [r12, #-316]
    strd    r2, r3, [r12, #-296]
    add.w   sp, #56                 // restore stack
    pop     {r0-r12, r14}           // restore context
    bx      lr

/******************************************************************************
* Fully bitsliced AES-256 key schedule to match the fully-fixsliced (ffs)
* representation. Note that it is possible to pass 2 different keys as input
* parameters if one wants to encrypt 2 blocks in with 2 different keys.
******************************************************************************/
@ void aes256_keyschedule_ffs(u32* rkeys, const u8* key);
.global aes256_keyschedule_ffs
.type   aes256_keyschedule_ffs,%function
.align 2
aes256_keyschedule_ffs:
    push    {r0-r12,r14}
    sub.w   sp, #56                 // allow space on the stack for tmp var
    ldr.w   r4, [r1]                // load the 128 first key bits in r4-r7
    ldr     r5, [r1, #4]
    ldr     r6, [r1, #8]
    ldr     r7, [r1, #12]
    ldr.w   r8, [r1]                // load the 128 first key bits in r8-r11
    ldr     r9, [r1, #4]
    ldr     r10,[r1, #8]
    ldr     r11,[r1, #12]
    bl      packing                 // pack the master key
    ldrd    r0,r1, [sp, #56]        // restore 'rkeys' and 'key' addresses
    stm     r0, {r4-r11}            // store the packed master key in 'rkeys'
    add.w   r1, #16                 // points to the 128 last bits of the key
    ldr.w   r4, [r1]                // load the 128 first key bits in r4-r7
    ldr     r5, [r1, #4]
    ldr     r6, [r1, #8]
    ldr     r7, [r1, #12]
    ldr.w   r8, [r1]                // load the 128 first key bits in r8-r11
    ldr     r9, [r1, #4]
    ldr     r10,[r1, #8]
    ldr     r11,[r1, #12]
    bl      packing                 // pack the master key
    ldr.w   r0, [sp, #56]           // restore 'rkeys' address
    add.w   r0, #32                 // points to the 128 last bits of the key
    stm     r0, {r4-r11}            // store the packed master key in 'rkeys'
    bl      sbox                    // apply the sbox to the master key
    eor     r11, r11, #0x00000300   // add the 1st rconst
    bl      aes256_xorcolumns_rotword
    bl      sbox                    // apply the sbox to the master key
    bl      aes256_xorcolumns
    bl      inv_shiftrows_1
    bl      sbox                    // apply the sbox to the master key
    eor     r2, r2, #0x00000300     // add the 2nd rconst
    bl      aes256_xorcolumns_rotword
    bl      inv_shiftrows_2
    bl      sbox                    // apply the sbox to the master key
    bl      aes256_xorcolumns
    bl      inv_shiftrows_3
    bl      sbox                    // apply the sbox to the master key
    eor     r0, r0, #0x00000300     // add the 3rd rconst
    bl      aes256_xorcolumns_rotword
    bl      sbox                    // apply the sbox to the master key
    bl      aes256_xorcolumns
    bl      inv_shiftrows_1
    bl      sbox                    // apply the sbox to the master key
    eor     r8, r8, #0x00000300     // add the 4th rconst
    bl      aes256_xorcolumns_rotword
    bl      inv_shiftrows_2
    bl      sbox                    // apply the sbox to the master key
    bl      aes256_xorcolumns
    bl      inv_shiftrows_3
    bl      sbox                    // apply the sbox to the master key
    eor     r7, r7, #0x00000300     // add the 5th rconst
    bl      aes256_xorcolumns_rotword
    bl      sbox                    // apply the sbox to the master key
    bl      aes256_xorcolumns
    bl      inv_shiftrows_1
    bl      sbox                    // apply the sbox to the master key
    eor     r6, r6, #0x00000300     // add the 6th rconst
    bl      aes256_xorcolumns_rotword
    bl      inv_shiftrows_2
    bl      sbox                    // apply the sbox to the master key
    bl      aes256_xorcolumns
    bl      inv_shiftrows_3
    bl      sbox                    // apply the sbox to the master key
    eor     r3, r3, #0x00000300     // add the 6th rconst
    bl      aes256_xorcolumns_rotword
    add     r12, #32
    bl      inv_shiftrows_1
    mvn     r5, r5                  // add the NOT for the last rkey
    mvn     r6, r6                  // add the NOT for the last rkey
    mvn     r10, r10                // add the NOT for the last rkey
    mvn     r11, r11                // add the NOT for the last rkey
    ldrd    r0, r1, [r12, #-28]
    ldrd    r2, r3, [r12, #-8]
    strd    r5, r6, [r12, #4]
    strd    r10, r11, [r12, #24]
    mvn     r0, r0                  // add the NOT for the penultimate rkey
    mvn     r1, r1                  // add the NOT for the penultimate rkey
    mvn     r2, r2                  // add the NOT for the penultimate rkey
    mvn     r3, r3                  // add the NOT for the penultimate rkey
    ldrd    r5, r6, [r12, #-444]
    ldrd    r10, r11, [r12, #-424]
    strd    r0, r1, [r12, #-28]
    strd    r2, r3, [r12, #-8]
    mvn     r5, r5                  // remove the NOT for the key whitening
    mvn     r6, r6                  // remove the NOT for the key whitening
    mvn     r10, r10                // remove the NOT for the key whitening
    mvn     r11, r11                // remove the NOT for the key whitening
    strd    r5, r6, [r12, #-444]
    strd    r10, r11, [r12, #-424]
    add.w   sp, #56                 // restore stack
    pop     {r0-r12, r14}           // restore context
    bx      lr