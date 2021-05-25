// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v17
.type gft_mul_v17, %function
.align 2
gft_mul_v17:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{0, 1, 3, 4, 7, 8, 12, 15, 24, 25, 27, 28, 29, 31}, {0, 2, 3, 5, 6, 7, 9, 13, 14, 15, 24, 26, 27, 28, 30, 31}, {0, 3, 4, 10, 12, 24, 27, 28, 31}, {1, 2, 3, 5, 11, 13, 25, 26, 27, 29, 30, 31}, {0, 2, 3, 5, 6, 8, 10, 11, 14, 15, 25, 27, 28}, {1, 2, 4, 5, 7, 9, 10, 14, 24, 25, 26, 27, 29}, {1, 2, 3, 4, 5, 6, 9, 10, 11, 13, 15, 24, 26, 27, 30}, {0, 1, 2, 4, 7, 8, 9, 10, 12, 13, 14, 15, 25, 26, 31}, {0, 3, 5, 6, 7, 9, 12, 13, 14, 21, 23, 29, 31}, {1, 2, 3, 4, 5, 6, 8, 9, 12, 15, 20, 21, 22, 23, 28, 29, 30, 31}, {0, 5, 11, 12, 13, 20, 22, 23, 28, 30, 31}, {1, 4, 5, 10, 11, 12, 21, 22, 29, 30}, {1, 2, 4, 5, 6, 7, 8, 9, 11, 12, 15, 18, 22, 26, 30}, {0, 1, 3, 4, 6, 8, 10, 11, 13, 14, 15, 19, 23, 27, 31}, {0, 1, 2, 5, 6, 8, 11, 12, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31}, {0, 3, 4, 5, 7, 9, 10, 11, 13, 16, 18, 20, 22, 24, 26, 28, 30}, {1, 16, 19, 20, 23, 24, 28, 31}, {0, 1, 17, 18, 19, 21, 22, 23, 25, 29, 30, 31}, {3, 16, 20, 26, 28}, {2, 3, 17, 21, 27, 29}, {5, 16, 18, 19, 22, 24, 26, 27, 30, 31}, {4, 5, 17, 18, 23, 25, 26, 30}, {7, 17, 18, 19, 20, 21, 22, 23, 25, 26, 27, 29, 31}, {6, 7, 16, 17, 18, 20, 22, 24, 25, 26, 28, 29, 30, 31}, {9, 16, 19, 21, 22, 23, 28, 29, 30}, {8, 9, 17, 18, 19, 20, 21, 22, 28, 31}, {11, 16, 21, 28, 29}, {10, 11, 17, 20, 21, 28}, {13, 17, 18, 20, 21, 22, 23, 24, 25, 27, 28, 29, 31}, {12, 13, 16, 17, 19, 20, 22, 24, 26, 27, 28, 30, 31}, {15, 16, 17, 18, 21, 22, 24, 27, 28, 31}, {14, 15, 16, 19, 20, 21, 23, 25, 26, 27, 29, 30, 31}]

@ i = 0
@ better circuit found: #XORs = 238
@ better circuit found: #XORs = 225
@ better circuit found: #XORs = 223
@ better circuit found: #XORs = 215
@ i = 50
@ i = 100
@ i = 150
@ i = 200
@ i = 250
@ i = 300
@ i = 350
@ i = 400
@ better circuit found: #XORs = 214
@ i = 450
@ i = 500
@ better circuit found: #XORs = 211
@ i = 550
@ i = 600
@ i = 650
@ i = 700
@ i = 750
@ i = 800
@ i = 850
@ i = 900
@ i = 950

@ initial state: [{1, 7, 8, 20, 25}, {0, 10, 11, 14, 17, 21}, {3, 4, 14, 15, 25, 27, 31}, {2, 3, 5, 14}, {0, 10, 12, 14, 15, 24, 25, 28}, {1, 20, 21, 24, 31}, {1, 21, 23, 25}, {2, 4, 12, 13, 14, 16, 27, 29}, {2, 7}, {7, 18, 23, 28, 31}, {0, 9, 17, 18, 19, 31}, {4, 5, 10, 12, 19, 22, 25, 30}, {2, 9, 14, 21, 26}, {4, 6, 9, 23}, {2, 11, 12, 15, 30}, {0, 9, 16, 26, 27, 31}, {16, 23, 25, 10, 13}, {16, 1, 19, 25, 28}, {3, 16, 20, 26, 28}, {2, 3, 17, 21, 27, 29}, {5, 17, 22, 24, 30, 31}, {4, 17, 18, 25}, {7, 13, 19, 24, 26, 28}, {1, 18, 6, 25, 14}, {9, 11, 19, 22, 23, 30}, {0, 8, 20, 21, 22, 28}, {11, 16, 21, 28, 29}, {15, 16, 17}, {20, 10, 29, 15}, {5, 12, 13, 17, 18, 20, 28}, {5, 23, 26, 30}, {2, 9, 13, 19, 27, 30, 31}]
@[0, 1, 2, 3, 4, 7, 8, 10, 11, 15, 16, 18, 19, 20, 21, 22, 24, 25, 26, 27, 29, 31, 5, 6, 9, 12, 13, 14, 17, 23, 28, 30]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 565)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #4]
ldr  r1, [r12, #28]
ldr  r2, [r12, #32]
ldr  r3, [r12, #80]
ldr  r4, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s0, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #40]
ldr  r2, [r12, #44]
ldr  r3, [r12, #56]
ldr  r4, [r12, #68]
ldr  r5, [r12, #84]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s1, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #16]
ldr  r2, [r12, #56]
ldr  r3, [r12, #60]
ldr  r4, [r12, #100]
ldr  r5, [r12, #108]
ldr  r6, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s2, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #12]
ldr  r2, [r12, #20]
ldr  r3, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s3, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #40]
ldr  r2, [r12, #48]
ldr  r3, [r12, #56]
ldr  r4, [r12, #60]
ldr  r5, [r12, #96]
ldr  r6, [r12, #100]
ldr  r7, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s4, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #80]
ldr  r2, [r12, #84]
ldr  r3, [r12, #96]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s5, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #84]
ldr  r2, [r12, #92]
ldr  r3, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s6, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #16]
ldr  r2, [r12, #48]
ldr  r3, [r12, #52]
ldr  r4, [r12, #56]
ldr  r5, [r12, #64]
ldr  r6, [r12, #108]
ldr  r7, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s7, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #28]
eor r0, r1
vmov  s8, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #72]
ldr  r2, [r12, #92]
ldr  r3, [r12, #112]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s9, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #36]
ldr  r2, [r12, #68]
ldr  r3, [r12, #72]
ldr  r4, [r12, #76]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s10, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #20]
ldr  r2, [r12, #40]
ldr  r3, [r12, #48]
ldr  r4, [r12, #76]
ldr  r5, [r12, #88]
ldr  r6, [r12, #100]
ldr  r7, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s11, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #36]
ldr  r2, [r12, #56]
ldr  r3, [r12, #84]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s12, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #24]
ldr  r2, [r12, #36]
ldr  r3, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s13, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #44]
ldr  r2, [r12, #48]
ldr  r3, [r12, #60]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s14, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #36]
ldr  r2, [r12, #64]
ldr  r3, [r12, #104]
ldr  r4, [r12, #108]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s15, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #92]
ldr  r2, [r12, #100]
ldr  r3, [r12, #40]
ldr  r4, [r12, #52]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s16, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #4]
ldr  r2, [r12, #76]
ldr  r3, [r12, #100]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s17, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #64]
ldr  r2, [r12, #80]
ldr  r3, [r12, #104]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s18, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #12]
ldr  r2, [r12, #68]
ldr  r3, [r12, #84]
ldr  r4, [r12, #108]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s19, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #68]
ldr  r2, [r12, #88]
ldr  r3, [r12, #96]
ldr  r4, [r12, #120]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s20, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #68]
ldr  r2, [r12, #72]
ldr  r3, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s21, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #52]
ldr  r2, [r12, #76]
ldr  r3, [r12, #96]
ldr  r4, [r12, #104]
ldr  r5, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s22, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #72]
ldr  r2, [r12, #24]
ldr  r3, [r12, #100]
ldr  r4, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s23, r0
ldr  r0, [r12, #36]
ldr  r1, [r12, #44]
ldr  r2, [r12, #76]
ldr  r3, [r12, #88]
ldr  r4, [r12, #92]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s24, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #32]
ldr  r2, [r12, #80]
ldr  r3, [r12, #84]
ldr  r4, [r12, #88]
ldr  r5, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s25, r0
ldr  r0, [r12, #44]
ldr  r1, [r12, #64]
ldr  r2, [r12, #84]
ldr  r3, [r12, #112]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s26, r0
ldr  r0, [r12, #60]
ldr  r1, [r12, #64]
ldr  r2, [r12, #68]
eor r0, r1
eor r0, r2
vmov  s27, r0
ldr  r0, [r12, #80]
ldr  r1, [r12, #40]
ldr  r2, [r12, #116]
ldr  r3, [r12, #60]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s28, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #48]
ldr  r2, [r12, #52]
ldr  r3, [r12, #68]
ldr  r4, [r12, #72]
ldr  r5, [r12, #80]
ldr  r6, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s29, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #92]
ldr  r2, [r12, #104]
ldr  r3, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s30, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #36]
ldr  r2, [r12, #52]
ldr  r3, [r12, #76]
ldr  r4, [r12, #108]
ldr  r5, [r12, #120]
ldr  r6, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s31, r0
vmov  r0, s5;
vmov  r1, s6;
vmov  r2, s9;
vmov  r3, s12;
vmov  r4, s13;
vmov  r5, s14;
vmov  r6, s17;
vmov  r7, s23;
vmov  r8, s28;
vmov  r9, s30;
@// g5 ^= g9
 eor r5, r9
@// g9 ^= g1
 eor r9, r1
@// f21 ^= g1
vmov  r10, s21
eor   r10, r1
vmov  s21, r10
@// g1 ^= f16
vmov r11, s16
eor  r1, r11
@// g1 ^= g0
 eor r1, r0
@// f1 ^= f21
vmov  r10, s1
vmov  r11, s21
eor   r10, r11
vmov  s1, r10
@// f21 ^= g9
vmov  r10, s21
eor   r10, r9
vmov  s21, r10
@// g9 ^= g6
 eor r9, r6
@// f31 ^= g3
vmov  r10, s31
eor   r10, r3
vmov  s31, r10
@// g0 ^= f0
vmov r11, s0
eor  r0, r11
@// g9 ^= f27
vmov r11, s27
eor  r9, r11
@// f1 ^= g2
vmov  r10, s1
eor   r10, r2
vmov  s1, r10
@// f8 ^= g3
vmov  r10, s8
eor   r10, r3
vmov  s8, r10
@// g3 ^= g7
 eor r3, r7
@// g7 ^= g6
 eor r7, r6
@// f0 ^= g8
vmov  r10, s0
eor   r10, r8
vmov  s0, r10
@// f27 ^= g8
vmov  r10, s27
eor   r10, r8
vmov  s27, r10
@// g8 ^= f16
vmov r11, s16
eor  r8, r11
@// f16 ^= g6
vmov  r10, s16
eor   r10, r6
vmov  s16, r10
@// g0 ^= f8
vmov r11, s8
eor  r0, r11
@// g0 ^= f2
vmov r11, s2
eor  r0, r11
@// g7 ^= g2
 eor r7, r2
@// g7 ^= f31
vmov r11, s31
eor  r7, r11
@// g7 ^= g8
 eor r7, r8
@// g6 ^= f26
vmov r11, s26
eor  r6, r11
@// f27 ^= f26
vmov  r10, s27
vmov  r11, s26
eor   r10, r11
vmov  s27, r10
@// f16 ^= g1
vmov  r10, s16
eor   r10, r1
vmov  s16, r10
@// g1 ^= g8
 eor r1, r8
@// f8 ^= g4
vmov  r10, s8
eor   r10, r4
vmov  s8, r10
@// g1 ^= g4
 eor r1, r4
@// f8 ^= f3
vmov  r10, s8
vmov  r11, s3
eor   r10, r11
vmov  s8, r10
@// g4 ^= g0
 eor r4, r0
@// g0 ^= f3
vmov r11, s3
eor  r0, r11
@// g5 ^= g4
 eor r5, r4
@// f20 ^= f10
vmov  r10, s20
vmov  r11, s10
eor   r10, r11
vmov  s20, r10
@// f20 ^= f15
vmov  r10, s20
vmov  r11, s15
eor   r10, r11
vmov  s20, r10
@// g9 ^= f20
vmov r11, s20
eor  r9, r11
@// f3 ^= f31
vmov  r10, s3
vmov  r11, s31
eor   r10, r11
vmov  s3, r10
@// f3 ^= g6
vmov  r10, s3
eor   r10, r6
vmov  s3, r10
@// f2 ^= f4
vmov  r10, s2
vmov  r11, s4
eor   r10, r11
vmov  s2, r10
@// g4 ^= f22
vmov r11, s22
eor  r4, r11
@// f11 ^= g6
vmov  r10, s11
eor   r10, r6
vmov  s11, r10
@// f25 ^= f10
vmov  r10, s25
vmov  r11, s10
eor   r10, r11
vmov  s25, r10
@// f10 ^= f24
vmov  r10, s10
vmov  r11, s24
eor   r10, r11
vmov  s10, r10
@// f7 ^= f15
vmov  r10, s7
vmov  r11, s15
eor   r10, r11
vmov  s7, r10
@// f15 ^= g2
vmov  r10, s15
eor   r10, r2
vmov  s15, r10
@// g2 ^= f26
vmov r11, s26
eor  r2, r11
@// g3 ^= f0
vmov r11, s0
eor  r3, r11
@// f15 ^= f2
vmov  r10, s15
vmov  r11, s2
eor   r10, r11
vmov  s15, r10
@// f4 ^= g5
vmov  r10, s4
eor   r10, r5
vmov  s4, r10
@// g5 ^= f18
vmov r11, s18
eor  r5, r11
@// g6 ^= f10
vmov r11, s10
eor  r6, r11
@// f10 ^= f29
vmov  r10, s10
vmov  r11, s29
eor   r10, r11
vmov  s10, r10
@// g0 ^= f0
vmov r11, s0
eor  r0, r11
@// g2 ^= f18
vmov r11, s18
eor  r2, r11
@// f24 ^= f26
vmov  r10, s24
vmov  r11, s26
eor   r10, r11
vmov  s24, r10
@// g3 ^= f11
vmov r11, s11
eor  r3, r11
@// f8 ^= f7
vmov  r10, s8
vmov  r11, s7
eor   r10, r11
vmov  s8, r10
@// g7 ^= g9
 eor r7, r9
@// f15 ^= f10
vmov  r10, s15
vmov  r11, s10
eor   r10, r11
vmov  s15, r10
@// g4 ^= f1
vmov r11, s1
eor  r4, r11
@// f31 ^= g8
vmov  r10, s31
eor   r10, r8
vmov  s31, r10
@// f7 ^= f0
vmov  r10, s7
vmov  r11, s0
eor   r10, r11
vmov  s7, r10
@// g1 ^= f3
vmov r11, s3
eor  r1, r11
@// f29 ^= f20
vmov  r10, s29
vmov  r11, s20
eor   r10, r11
vmov  s29, r10
@// g8 ^= g9
 eor r8, r9
@// f0 ^= f2
vmov  r10, s0
vmov  r11, s2
eor   r10, r11
vmov  s0, r10
@// f1 ^= g1
vmov  r10, s1
eor   r10, r1
vmov  s1, r10
@// g2 ^= g3
 eor r2, r3
@// f22 ^= g8
vmov  r10, s22
eor   r10, r8
vmov  s22, r10
@// g5 ^= g6
 eor r5, r6
vstr.32  s0, [r14, #0]
vstr.32  s1, [r14, #4]
vstr.32  s2, [r14, #8]
vstr.32  s3, [r14, #12]
vstr.32  s4, [r14, #16]
str  r0, [r14, #20]
str  r1, [r14, #24]
vstr.32  s7, [r14, #28]
vstr.32  s8, [r14, #32]
str  r2, [r14, #36]
vstr.32  s10, [r14, #40]
vstr.32  s11, [r14, #44]
str  r3, [r14, #48]
str  r4, [r14, #52]
str  r5, [r14, #56]
vstr.32  s15, [r14, #60]
vstr.32  s16, [r14, #64]
str  r6, [r14, #68]
vstr.32  s18, [r14, #72]
vstr.32  s19, [r14, #76]
vstr.32  s20, [r14, #80]
vstr.32  s21, [r14, #84]
vstr.32  s22, [r14, #88]
str  r7, [r14, #92]
vstr.32  s24, [r14, #96]
vstr.32  s25, [r14, #100]
vstr.32  s26, [r14, #104]
vstr.32  s27, [r14, #108]
str  r8, [r14, #112]
vstr.32  s29, [r14, #116]
str  r9, [r14, #120]
vstr.32  s31, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v17, .-gft_mul_v17
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v18
.type gft_mul_v18, %function
.align 2
gft_mul_v18:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{0, 1, 3, 4, 5, 9, 11, 24, 25, 26, 27, 28, 29, 30, 31}, {0, 2, 3, 4, 8, 9, 10, 11, 24, 26, 28, 30}, {0, 3, 6, 7, 8, 10, 11, 25, 26, 29, 30}, {1, 2, 3, 6, 9, 10, 24, 25, 27, 28, 29, 31}, {0, 3, 5, 13, 15, 27, 28, 29, 30}, {1, 2, 3, 4, 5, 12, 13, 14, 15, 26, 27, 28, 31}, {0, 7, 12, 14, 15, 24, 26, 28, 29}, {1, 6, 7, 13, 14, 25, 27, 28}, {1, 6, 8, 11, 12, 13, 14, 23, 31}, {0, 1, 7, 9, 10, 11, 12, 15, 22, 23, 30, 31}, {3, 4, 5, 6, 7, 8, 12, 13, 20, 22, 28, 30}, {2, 3, 4, 6, 9, 12, 21, 23, 29, 31}, {1, 8, 9, 11, 13, 16, 17, 20, 21, 24, 25, 28, 29}, {0, 1, 8, 10, 11, 12, 13, 16, 20, 24, 28}, {3, 8, 11, 15, 18, 19, 22, 23, 26, 27, 30, 31}, {2, 3, 9, 10, 11, 14, 15, 18, 22, 26, 30}, {0, 3, 17, 20, 21, 25, 27}, {1, 2, 3, 16, 17, 20, 24, 25, 26, 27}, {0, 19, 22, 23, 24, 26, 27}, {1, 18, 19, 22, 25, 26}, {4, 7, 16, 19, 20, 21, 23, 29, 31}, {5, 6, 7, 17, 18, 19, 20, 22, 23, 28, 29, 30, 31}, {4, 16, 20, 23, 28, 30, 31}, {5, 17, 21, 22, 23, 29, 30}, {8, 11, 17, 22, 28, 29, 30}, {9, 10, 11, 16, 17, 23, 28, 31}, {8, 19, 20, 21, 22, 23, 28, 29}, {9, 18, 19, 20, 22, 28}, {12, 15, 17, 24, 25, 27, 28, 29, 31}, {13, 14, 15, 16, 17, 24, 26, 27, 28, 30, 31}, {12, 19, 24, 27, 28, 31}, {13, 18, 19, 25, 26, 27, 29, 30, 31}]

@ i = 0
@ better circuit found: #XORs = 227
@ better circuit found: #XORs = 226
@ better circuit found: #XORs = 215
@ i = 50
@ i = 100
@ better circuit found: #XORs = 212
@ i = 150
@ i = 200
@ i = 250
@ i = 300
@ i = 350
@ i = 400
@ better circuit found: #XORs = 208
@ i = 450
@ i = 500
@ i = 550
@ i = 600
@ i = 650
@ i = 700
@ i = 750
@ i = 800
@ i = 850
@ i = 900
@ i = 950

@ initial state: [{2, 19, 20, 5, 24}, {3, 5, 6, 8, 9, 24, 28}, {5, 8, 17, 22, 23, 30}, {2, 3, 10}, {0, 3, 5, 13, 27, 29}, {1, 2, 4, 7, 24, 31}, {4, 6, 7, 10, 12, 26, 29}, {1, 6, 7, 13, 14, 25, 27, 28}, {1, 6, 8, 11, 12, 13, 14, 23, 31}, {13, 14, 16, 17, 26, 31}, {24, 27}, {7, 18, 21, 26, 31}, {19, 5, 9, 12, 29}, {0, 4, 6, 10, 14, 24, 30}, {17, 13, 3, 23, 25}, {19, 20, 26, 11, 14}, {0, 13, 20, 21, 23, 27}, {0, 1, 2, 16, 21, 24, 26}, {0, 20, 26, 28}, {0, 1, 9, 25}, {7, 8, 15, 19}, {6, 18, 20, 29, 30, 31}, {4, 15, 16, 20, 23, 31}, {21, 8, 29}, {11, 15, 17, 21, 22}, {4, 9, 10, 11, 17, 20, 30}, {9, 18, 23}, {19, 20, 22, 23, 28}, {17, 19, 25, 15, 29}, {15, 28, 30}, {19, 12, 28, 31}, {1, 13, 22, 27, 29, 30, 31}]
@[1, 4, 5, 6, 7, 8, 13, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 0, 2, 3, 9, 10, 11, 12, 14, 15, 29]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 556)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #8]
ldr  r1, [r12, #76]
ldr  r2, [r12, #80]
ldr  r3, [r12, #20]
ldr  r4, [r12, #96]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s0, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #20]
ldr  r2, [r12, #24]
ldr  r3, [r12, #32]
ldr  r4, [r12, #36]
ldr  r5, [r12, #96]
ldr  r6, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s1, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #32]
ldr  r2, [r12, #68]
ldr  r3, [r12, #88]
ldr  r4, [r12, #92]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s2, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #12]
ldr  r2, [r12, #40]
eor r0, r1
eor r0, r2
vmov  s3, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #12]
ldr  r2, [r12, #20]
ldr  r3, [r12, #52]
ldr  r4, [r12, #108]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s4, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #8]
ldr  r2, [r12, #16]
ldr  r3, [r12, #28]
ldr  r4, [r12, #96]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s5, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #24]
ldr  r2, [r12, #28]
ldr  r3, [r12, #40]
ldr  r4, [r12, #48]
ldr  r5, [r12, #104]
ldr  r6, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s6, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #24]
ldr  r2, [r12, #28]
ldr  r3, [r12, #52]
ldr  r4, [r12, #56]
ldr  r5, [r12, #100]
ldr  r6, [r12, #108]
ldr  r7, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s7, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #24]
ldr  r2, [r12, #32]
ldr  r3, [r12, #44]
ldr  r4, [r12, #48]
ldr  r5, [r12, #52]
ldr  r6, [r12, #56]
ldr  r7, [r12, #92]
ldr  r8, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
eor r0, r8
vmov  s8, r0
ldr  r0, [r12, #52]
ldr  r1, [r12, #56]
ldr  r2, [r12, #64]
ldr  r3, [r12, #68]
ldr  r4, [r12, #104]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s9, r0
ldr  r0, [r12, #96]
ldr  r1, [r12, #108]
eor r0, r1
vmov  s10, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #72]
ldr  r2, [r12, #84]
ldr  r3, [r12, #104]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s11, r0
ldr  r0, [r12, #76]
ldr  r1, [r12, #20]
ldr  r2, [r12, #36]
ldr  r3, [r12, #48]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s12, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #16]
ldr  r2, [r12, #24]
ldr  r3, [r12, #40]
ldr  r4, [r12, #56]
ldr  r5, [r12, #96]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s13, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #52]
ldr  r2, [r12, #12]
ldr  r3, [r12, #92]
ldr  r4, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s14, r0
ldr  r0, [r12, #76]
ldr  r1, [r12, #80]
ldr  r2, [r12, #104]
ldr  r3, [r12, #44]
ldr  r4, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s15, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #52]
ldr  r2, [r12, #80]
ldr  r3, [r12, #84]
ldr  r4, [r12, #92]
ldr  r5, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s16, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #8]
ldr  r3, [r12, #64]
ldr  r4, [r12, #84]
ldr  r5, [r12, #96]
ldr  r6, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s17, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #80]
ldr  r2, [r12, #104]
ldr  r3, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s18, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #36]
ldr  r3, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s19, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #32]
ldr  r2, [r12, #60]
ldr  r3, [r12, #76]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s20, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #72]
ldr  r2, [r12, #80]
ldr  r3, [r12, #116]
ldr  r4, [r12, #120]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s21, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #60]
ldr  r2, [r12, #64]
ldr  r3, [r12, #80]
ldr  r4, [r12, #92]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s22, r0
ldr  r0, [r12, #84]
ldr  r1, [r12, #32]
ldr  r2, [r12, #116]
eor r0, r1
eor r0, r2
vmov  s23, r0
ldr  r0, [r12, #44]
ldr  r1, [r12, #60]
ldr  r2, [r12, #68]
ldr  r3, [r12, #84]
ldr  r4, [r12, #88]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s24, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #36]
ldr  r2, [r12, #40]
ldr  r3, [r12, #44]
ldr  r4, [r12, #68]
ldr  r5, [r12, #80]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s25, r0
ldr  r0, [r12, #36]
ldr  r1, [r12, #72]
ldr  r2, [r12, #92]
eor r0, r1
eor r0, r2
vmov  s26, r0
ldr  r0, [r12, #76]
ldr  r1, [r12, #80]
ldr  r2, [r12, #88]
ldr  r3, [r12, #92]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s27, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #76]
ldr  r2, [r12, #100]
ldr  r3, [r12, #60]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s28, r0
ldr  r0, [r12, #60]
ldr  r1, [r12, #112]
ldr  r2, [r12, #120]
eor r0, r1
eor r0, r2
vmov  s29, r0
ldr  r0, [r12, #76]
ldr  r1, [r12, #48]
ldr  r2, [r12, #112]
ldr  r3, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s30, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #52]
ldr  r2, [r12, #88]
ldr  r3, [r12, #108]
ldr  r4, [r12, #116]
ldr  r5, [r12, #120]
ldr  r6, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s31, r0
vmov  r0, s0;
vmov  r1, s2;
vmov  r2, s3;
vmov  r3, s9;
vmov  r4, s10;
vmov  r5, s11;
vmov  r6, s12;
vmov  r7, s14;
vmov  r8, s15;
vmov  r9, s29;
@// g5 ^= f23
vmov r11, s23
eor  r5, r11
@// f19 ^= f26
vmov  r10, s19
vmov  r11, s26
eor   r10, r11
vmov  s19, r10
@// f18 ^= f27
vmov  r10, s18
vmov  r11, s27
eor   r10, r11
vmov  s18, r10
@// f27 ^= f26
vmov  r10, s27
vmov  r11, s26
eor   r10, r11
vmov  s27, r10
@// f24 ^= f23
vmov  r10, s24
vmov  r11, s23
eor   r10, r11
vmov  s24, r10
@// f20 ^= f23
vmov  r10, s20
vmov  r11, s23
eor   r10, r11
vmov  s20, r10
@// g5 ^= f6
vmov r11, s6
eor  r5, r11
@// g6 ^= g0
 eor r6, r0
@// f26 ^= f23
vmov  r10, s26
vmov  r11, s23
eor   r10, r11
vmov  s26, r10
@// f23 ^= g1
vmov  r10, s23
eor   r10, r1
vmov  s23, r10
@// g1 ^= g7
 eor r1, r7
@// g5 ^= g2
 eor r5, r2
@// f20 ^= g9
vmov  r10, s20
eor   r10, r9
vmov  s20, r10
@// g0 ^= g8
 eor r0, r8
@// f22 ^= g9
vmov  r10, s22
eor   r10, r9
vmov  s22, r10
@// f16 ^= g7
vmov  r10, s16
eor   r10, r7
vmov  s16, r10
@// g3 ^= g8
 eor r3, r8
@// g8 ^= f18
vmov r11, s18
eor  r8, r11
@// f19 ^= f18
vmov  r10, s19
vmov  r11, s18
eor   r10, r11
vmov  s19, r10
@// f18 ^= g4
vmov  r10, s18
eor   r10, r4
vmov  s18, r10
@// f30 ^= g4
vmov  r10, s30
eor   r10, r4
vmov  s30, r10
@// g2 ^= g4
 eor r2, r4
@// g4 ^= f5
vmov r11, s5
eor  r4, r11
@// g4 ^= f31
vmov r11, s31
eor  r4, r11
@// f6 ^= f13
vmov  r10, s6
vmov  r11, s13
eor   r10, r11
vmov  s6, r10
@// g1 ^= g4
 eor r1, r4
@// g4 ^= g6
 eor r4, r6
@// g6 ^= g2
 eor r6, r2
@// g0 ^= f13
vmov r11, s13
eor  r0, r11
@// f13 ^= f22
vmov  r10, s13
vmov  r11, s22
eor   r10, r11
vmov  s13, r10
@// f13 ^= f8
vmov  r10, s13
vmov  r11, s8
eor   r10, r11
vmov  s13, r10
@// g7 ^= f28
vmov r11, s28
eor  r7, r11
@// f25 ^= f22
vmov  r10, s25
vmov  r11, s22
eor   r10, r11
vmov  s25, r10
@// g8 ^= f18
vmov r11, s18
eor  r8, r11
@// g3 ^= g8
 eor r3, r8
@// g6 ^= f16
vmov r11, s16
eor  r6, r11
@// g8 ^= g2
 eor r8, r2
@// g2 ^= f5
vmov r11, s5
eor  r2, r11
@// f5 ^= f6
vmov  r10, s5
vmov  r11, s6
eor   r10, r11
vmov  s5, r10
@// f6 ^= g9
vmov  r10, s6
eor   r10, r9
vmov  s6, r10
@// g7 ^= f24
vmov r11, s24
eor  r7, r11
@// f24 ^= g9
vmov  r10, s24
eor   r10, r9
vmov  s24, r10
@// g8 ^= f27
vmov r11, s27
eor  r8, r11
@// g8 ^= g9
 eor r8, r9
@// g7 ^= f28
vmov r11, s28
eor  r7, r11
@// f4 ^= g9
vmov  r10, s4
eor   r10, r9
vmov  s4, r10
@// g9 ^= f30
vmov r11, s30
eor  r9, r11
@// g9 ^= g3
 eor r9, r3
@// g3 ^= f31
vmov r11, s31
eor  r3, r11
@// g3 ^= f6
vmov r11, s6
eor  r3, r11
@// g3 ^= f25
vmov r11, s25
eor  r3, r11
@// g5 ^= f26
vmov r11, s26
eor  r5, r11
@// g2 ^= g1
 eor r2, r1
@// f26 ^= f27
vmov  r10, s26
vmov  r11, s27
eor   r10, r11
vmov  s26, r10
@// f21 ^= f20
vmov  r10, s21
vmov  r11, s20
eor   r10, r11
vmov  s21, r10
@// g9 ^= f30
vmov r11, s30
eor  r9, r11
@// f31 ^= f19
vmov  r10, s31
vmov  r11, s19
eor   r10, r11
vmov  s31, r10
@// g7 ^= f31
vmov r11, s31
eor  r7, r11
@// f20 ^= f22
vmov  r10, s20
vmov  r11, s22
eor   r10, r11
vmov  s20, r10
@// g2 ^= f1
vmov r11, s1
eor  r2, r11
@// g4 ^= f1
vmov r11, s1
eor  r4, r11
@// f17 ^= f16
vmov  r10, s17
vmov  r11, s16
eor   r10, r11
vmov  s17, r10
@// f5 ^= f4
vmov  r10, s5
vmov  r11, s4
eor   r10, r11
vmov  s5, r10
@// g1 ^= g0
 eor r1, r0
@// f28 ^= f30
vmov  r10, s28
vmov  r11, s30
eor   r10, r11
vmov  s28, r10
@// f1 ^= g0
vmov  r10, s1
eor   r10, r0
vmov  s1, r10
@// f21 ^= f23
vmov  r10, s21
vmov  r11, s23
eor   r10, r11
vmov  s21, r10
@// g6 ^= f13
vmov r11, s13
eor  r6, r11
@// g0 ^= g2
 eor r0, r2
str  r0, [r14, #0]
vstr.32  s1, [r14, #4]
str  r1, [r14, #8]
str  r2, [r14, #12]
vstr.32  s4, [r14, #16]
vstr.32  s5, [r14, #20]
vstr.32  s6, [r14, #24]
vstr.32  s7, [r14, #28]
vstr.32  s8, [r14, #32]
str  r3, [r14, #36]
str  r4, [r14, #40]
str  r5, [r14, #44]
str  r6, [r14, #48]
vstr.32  s13, [r14, #52]
str  r7, [r14, #56]
str  r8, [r14, #60]
vstr.32  s16, [r14, #64]
vstr.32  s17, [r14, #68]
vstr.32  s18, [r14, #72]
vstr.32  s19, [r14, #76]
vstr.32  s20, [r14, #80]
vstr.32  s21, [r14, #84]
vstr.32  s22, [r14, #88]
vstr.32  s23, [r14, #92]
vstr.32  s24, [r14, #96]
vstr.32  s25, [r14, #100]
vstr.32  s26, [r14, #104]
vstr.32  s27, [r14, #108]
vstr.32  s28, [r14, #112]
str  r9, [r14, #116]
vstr.32  s30, [r14, #120]
vstr.32  s31, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v18, .-gft_mul_v18
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v19
.type gft_mul_v19, %function
.align 2
gft_mul_v19:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{4, 5, 6, 8, 11, 14, 15, 27, 31}, {4, 7, 9, 10, 11, 14, 26, 27, 30, 31}, {4, 5, 8, 13, 15, 24, 26, 28, 30}, {4, 9, 12, 13, 14, 15, 25, 27, 29, 31}, {0, 1, 3, 4, 5, 7, 8, 15, 24, 25, 28, 29, 31}, {0, 2, 3, 4, 6, 7, 9, 14, 15, 24, 28, 30, 31}, {0, 3, 4, 7, 10, 12, 14, 26, 27, 28, 31}, {1, 2, 3, 5, 6, 7, 11, 13, 15, 26, 29, 30, 31}, {0, 4, 6, 7, 8, 13, 15, 20, 21, 28, 29}, {1, 5, 6, 9, 12, 13, 14, 15, 20, 28}, {2, 5, 6, 7, 10, 12, 14, 15, 22, 23, 30, 31}, {3, 4, 5, 6, 11, 13, 14, 22, 30}, {0, 1, 2, 3, 5, 6, 7, 10, 12, 14, 16, 19, 20, 23, 24, 27, 28, 31}, {0, 2, 4, 5, 6, 11, 13, 15, 17, 18, 19, 21, 22, 23, 25, 26, 27, 29, 30, 31}, {1, 2, 5, 8, 9, 10, 11, 12, 13, 15, 16, 20, 24, 28}, {0, 1, 3, 4, 5, 8, 10, 12, 14, 15, 17, 21, 25, 29}, {0, 2, 3, 16, 18, 19, 20, 21, 22, 24, 27, 30, 31}, {1, 2, 17, 18, 20, 23, 25, 26, 27, 30}, {1, 2, 3, 17, 18, 19, 20, 21, 24, 29, 31}, {0, 1, 2, 16, 17, 18, 20, 25, 28, 29, 30, 31}, {4, 6, 7, 16, 17, 19, 21, 22, 24, 31}, {5, 6, 16, 18, 19, 20, 21, 23, 25, 30, 31}, {5, 6, 7, 16, 19, 20, 21, 22, 26, 28, 30}, {4, 5, 6, 17, 18, 19, 20, 23, 27, 29, 31}, {8, 10, 11, 16, 20, 22, 23, 26, 27, 29, 31}, {9, 10, 17, 21, 22, 26, 28, 29, 30, 31}, {9, 10, 11, 18, 21, 22, 23, 25, 27, 28, 30, 31}, {8, 9, 10, 19, 20, 21, 22, 24, 25, 26, 27, 29, 30}, {12, 14, 15, 16, 17, 18, 19, 21, 22, 23, 26, 31}, {13, 14, 16, 18, 20, 21, 22, 27, 30, 31}, {13, 14, 15, 17, 18, 21, 24, 25, 26, 27, 28, 30}, {12, 13, 14, 16, 17, 19, 20, 21, 24, 26, 29, 31}]

@ i = 0
@ better circuit found: #XORs = 252
@ better circuit found: #XORs = 247
@ better circuit found: #XORs = 244
@ better circuit found: #XORs = 235
@ i = 50
@ better circuit found: #XORs = 234
@ i = 100
@ better circuit found: #XORs = 233
@ i = 150
@ i = 200
@ i = 250
@ better circuit found: #XORs = 231
@ better circuit found: #XORs = 230
@ i = 300
@ i = 350
@ i = 400
@ i = 450
@ i = 500
@ i = 550
@ i = 600
@ i = 650
@ i = 700
@ i = 750
@ i = 800
@ better circuit found: #XORs = 228
@ i = 850
@ i = 900
@ i = 950

@ initial state: [{2, 20, 25, 26, 27, 15}, {18, 5, 22, 8, 27}, {4, 18, 19, 22, 25, 26, 30}, {12, 13, 14, 20, 29}, {6, 8, 9, 10, 20, 22, 25}, {18, 2, 7, 8, 30}, {3, 10, 11, 12, 28}, {3, 5, 6, 8, 21}, {3, 4, 6, 10, 13, 30}, {1, 5, 6, 9, 15, 28, 29}, {5, 10, 11, 14, 22}, {23, 4, 14, 24, 30}, {1, 2, 8, 11, 15, 25}, {1, 13, 15, 18, 21, 22, 23}, {2, 6, 16, 18, 24, 27}, {2, 19, 14, 8}, {29, 2, 19, 12, 30}, {1, 19, 20, 11, 12}, {7, 16, 19, 24, 31}, {16, 17, 21, 22, 23, 27}, {0, 7, 22, 28, 29, 31}, {0, 18, 23, 25, 26, 29}, {8, 13, 15, 17, 20, 31}, {2, 4, 9, 26, 31}, {0, 3, 20, 24, 30}, {0, 9, 10, 30}, {0, 11, 17, 27}, {13, 15, 19, 24, 25, 27, 28}, {8, 12, 22, 24, 30}, {19, 23, 7, 8, 15}, {17, 21, 7, 26}, {3, 11, 16, 18, 26, 30}]
@[0, 2, 3, 4, 6, 7, 9, 10, 11, 12, 13, 14, 16, 19, 20, 21, 22, 25, 26, 27, 28, 30, 1, 5, 8, 15, 17, 18, 23, 24, 29, 31]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 627)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #8]
ldr  r1, [r12, #80]
ldr  r2, [r12, #100]
ldr  r3, [r12, #104]
ldr  r4, [r12, #108]
ldr  r5, [r12, #60]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s0, r0
ldr  r0, [r12, #72]
ldr  r1, [r12, #20]
ldr  r2, [r12, #88]
ldr  r3, [r12, #32]
ldr  r4, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s1, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #72]
ldr  r2, [r12, #76]
ldr  r3, [r12, #88]
ldr  r4, [r12, #100]
ldr  r5, [r12, #104]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s2, r0
ldr  r0, [r12, #48]
ldr  r1, [r12, #52]
ldr  r2, [r12, #56]
ldr  r3, [r12, #80]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s3, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #32]
ldr  r2, [r12, #36]
ldr  r3, [r12, #40]
ldr  r4, [r12, #80]
ldr  r5, [r12, #88]
ldr  r6, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s4, r0
ldr  r0, [r12, #72]
ldr  r1, [r12, #8]
ldr  r2, [r12, #28]
ldr  r3, [r12, #32]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s5, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #40]
ldr  r2, [r12, #44]
ldr  r3, [r12, #48]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s6, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #20]
ldr  r2, [r12, #24]
ldr  r3, [r12, #32]
ldr  r4, [r12, #84]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s7, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #16]
ldr  r2, [r12, #24]
ldr  r3, [r12, #40]
ldr  r4, [r12, #52]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s8, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #20]
ldr  r2, [r12, #24]
ldr  r3, [r12, #36]
ldr  r4, [r12, #60]
ldr  r5, [r12, #112]
ldr  r6, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s9, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #40]
ldr  r2, [r12, #44]
ldr  r3, [r12, #56]
ldr  r4, [r12, #88]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s10, r0
ldr  r0, [r12, #92]
ldr  r1, [r12, #16]
ldr  r2, [r12, #56]
ldr  r3, [r12, #96]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s11, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #8]
ldr  r2, [r12, #32]
ldr  r3, [r12, #44]
ldr  r4, [r12, #60]
ldr  r5, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s12, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #52]
ldr  r2, [r12, #60]
ldr  r3, [r12, #72]
ldr  r4, [r12, #84]
ldr  r5, [r12, #88]
ldr  r6, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s13, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #24]
ldr  r2, [r12, #64]
ldr  r3, [r12, #72]
ldr  r4, [r12, #96]
ldr  r5, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s14, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #76]
ldr  r2, [r12, #56]
ldr  r3, [r12, #32]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s15, r0
ldr  r0, [r12, #116]
ldr  r1, [r12, #8]
ldr  r2, [r12, #76]
ldr  r3, [r12, #48]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s16, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #76]
ldr  r2, [r12, #80]
ldr  r3, [r12, #44]
ldr  r4, [r12, #48]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s17, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #64]
ldr  r2, [r12, #76]
ldr  r3, [r12, #96]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s18, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #68]
ldr  r2, [r12, #84]
ldr  r3, [r12, #88]
ldr  r4, [r12, #92]
ldr  r5, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s19, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #28]
ldr  r2, [r12, #88]
ldr  r3, [r12, #112]
ldr  r4, [r12, #116]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s20, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #72]
ldr  r2, [r12, #92]
ldr  r3, [r12, #100]
ldr  r4, [r12, #104]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s21, r0
ldr  r0, [r12, #32]
ldr  r1, [r12, #52]
ldr  r2, [r12, #60]
ldr  r3, [r12, #68]
ldr  r4, [r12, #80]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s22, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #16]
ldr  r2, [r12, #36]
ldr  r3, [r12, #104]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s23, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #12]
ldr  r2, [r12, #80]
ldr  r3, [r12, #96]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s24, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #36]
ldr  r2, [r12, #40]
ldr  r3, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s25, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #44]
ldr  r2, [r12, #68]
ldr  r3, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s26, r0
ldr  r0, [r12, #52]
ldr  r1, [r12, #60]
ldr  r2, [r12, #76]
ldr  r3, [r12, #96]
ldr  r4, [r12, #100]
ldr  r5, [r12, #108]
ldr  r6, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s27, r0
ldr  r0, [r12, #32]
ldr  r1, [r12, #48]
ldr  r2, [r12, #88]
ldr  r3, [r12, #96]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s28, r0
ldr  r0, [r12, #76]
ldr  r1, [r12, #92]
ldr  r2, [r12, #28]
ldr  r3, [r12, #32]
ldr  r4, [r12, #60]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s29, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #84]
ldr  r2, [r12, #28]
ldr  r3, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s30, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #44]
ldr  r2, [r12, #64]
ldr  r3, [r12, #72]
ldr  r4, [r12, #104]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s31, r0
vmov  r0, s1;
vmov  r1, s5;
vmov  r2, s8;
vmov  r3, s15;
vmov  r4, s17;
vmov  r5, s18;
vmov  r6, s23;
vmov  r7, s24;
vmov  r8, s29;
vmov  r9, s31;
@// g4 ^= f16
vmov r11, s16
eor  r4, r11
@// f0 ^= g6
vmov  r10, s0
eor   r10, r6
vmov  s0, r10
@// f13 ^= f21
vmov  r10, s13
vmov  r11, s21
eor   r10, r11
vmov  s13, r10
@// f26 ^= f21
vmov  r10, s26
vmov  r11, s21
eor   r10, r11
vmov  s26, r10
@// f21 ^= f20
vmov  r10, s21
vmov  r11, s20
eor   r10, r11
vmov  s21, r10
@// f20 ^= g5
vmov  r10, s20
eor   r10, r5
vmov  s20, r10
@// f2 ^= g0
vmov  r10, s2
eor   r10, r0
vmov  s2, r10
@// g6 ^= g3
 eor r6, r3
@// g3 ^= g1
 eor r3, r1
@// g1 ^= g0
 eor r1, r0
@// g0 ^= f10
vmov r11, s10
eor  r0, r11
@// f12 ^= g8
vmov  r10, s12
eor   r10, r8
vmov  s12, r10
@// f12 ^= g5
vmov  r10, s12
eor   r10, r5
vmov  s12, r10
@// f4 ^= f10
vmov  r10, s4
vmov  r11, s10
eor   r10, r11
vmov  s4, r10
@// g1 ^= f28
vmov r11, s28
eor  r1, r11
@// f16 ^= f3
vmov  r10, s16
vmov  r11, s3
eor   r10, r11
vmov  s16, r10
@// f10 ^= f11
vmov  r10, s10
vmov  r11, s11
eor   r10, r11
vmov  s10, r10
@// f11 ^= g7
vmov  r10, s11
eor   r10, r7
vmov  s11, r10
@// f16 ^= g7
vmov  r10, s16
eor   r10, r7
vmov  s16, r10
@// f14 ^= g0
vmov  r10, s14
eor   r10, r0
vmov  s14, r10
@// g0 ^= g3
 eor r0, r3
@// g8 ^= g3
 eor r8, r3
@// f7 ^= f30
vmov  r10, s7
vmov  r11, s30
eor   r10, r11
vmov  s7, r10
@// g5 ^= f30
vmov r11, s30
eor  r5, r11
@// f30 ^= g3
vmov  r10, s30
eor   r10, r3
vmov  s30, r10
@// f30 ^= f2
vmov  r10, s30
vmov  r11, s2
eor   r10, r11
vmov  s30, r10
@// f2 ^= f27
vmov  r10, s2
vmov  r11, s27
eor   r10, r11
vmov  s2, r10
@// g3 ^= g9
 eor r3, r9
@// g3 ^= f6
vmov r11, s6
eor  r3, r11
@// g2 ^= g7
 eor r2, r7
@// g7 ^= f28
vmov r11, s28
eor  r7, r11
@// f28 ^= g8
vmov  r10, s28
eor   r10, r8
vmov  s28, r10
@// f28 ^= f3
vmov  r10, s28
vmov  r11, s3
eor   r10, r11
vmov  s28, r10
@// f11 ^= g2
vmov  r10, s11
eor   r10, r2
vmov  s11, r10
@// g7 ^= f6
vmov r11, s6
eor  r7, r11
@// g2 ^= f3
vmov r11, s3
eor  r2, r11
@// g8 ^= f22
vmov r11, s22
eor  r8, r11
@// g8 ^= f19
vmov r11, s19
eor  r8, r11
@// f19 ^= g5
vmov  r10, s19
eor   r10, r5
vmov  s19, r10
@// g3 ^= g5
 eor r3, r5
@// f6 ^= f25
vmov  r10, s6
vmov  r11, s25
eor   r10, r11
vmov  s6, r10
@// f25 ^= f20
vmov  r10, s25
vmov  r11, s20
eor   r10, r11
vmov  s25, r10
@// f25 ^= g5
vmov  r10, s25
eor   r10, r5
vmov  s25, r10
@// f19 ^= f20
vmov  r10, s19
vmov  r11, s20
eor   r10, r11
vmov  s19, r10
@// g2 ^= g3
 eor r2, r3
@// g5 ^= g9
 eor r5, r9
@// g9 ^= g4
 eor r9, r4
@// g9 ^= f3
vmov r11, s3
eor  r9, r11
@// f20 ^= g2
vmov  r10, s20
eor   r10, r2
vmov  s20, r10
@// g2 ^= f22
vmov r11, s22
eor  r2, r11
@// f27 ^= f22
vmov  r10, s27
vmov  r11, s22
eor   r10, r11
vmov  s27, r10
@// g0 ^= g6
 eor r0, r6
@// g6 ^= f4
vmov r11, s4
eor  r6, r11
@// f12 ^= g6
vmov  r10, s12
eor   r10, r6
vmov  s12, r10
@// g6 ^= f26
vmov r11, s26
eor  r6, r11
@// g5 ^= g4
 eor r5, r4
@// f13 ^= g4
vmov  r10, s13
eor   r10, r4
vmov  s13, r10
@// f9 ^= f3
vmov  r10, s9
vmov  r11, s3
eor   r10, r11
vmov  s9, r10
@// f3 ^= f0
vmov  r10, s3
vmov  r11, s0
eor   r10, r11
vmov  s3, r10
@// f0 ^= f4
vmov  r10, s0
vmov  r11, s4
eor   r10, r11
vmov  s0, r10
@// f4 ^= g4
vmov  r10, s4
eor   r10, r4
vmov  s4, r10
@// f11 ^= f10
vmov  r10, s11
vmov  r11, s10
eor   r10, r11
vmov  s11, r10
@// f7 ^= f22
vmov  r10, s7
vmov  r11, s22
eor   r10, r11
vmov  s7, r10
@// f22 ^= f2
vmov  r10, s22
vmov  r11, s2
eor   r10, r11
vmov  s22, r10
@// f22 ^= f20
vmov  r10, s22
vmov  r11, s20
eor   r10, r11
vmov  s22, r10
@// g1 ^= f0
vmov r11, s0
eor  r1, r11
@// f30 ^= f2
vmov  r10, s30
vmov  r11, s2
eor   r10, r11
vmov  s30, r10
@// g9 ^= g5
 eor r9, r5
@// f21 ^= f22
vmov  r10, s21
vmov  r11, s22
eor   r10, r11
vmov  s21, r10
@// f10 ^= g1
vmov  r10, s10
eor   r10, r1
vmov  s10, r10
@// g1 ^= f6
vmov r11, s6
eor  r1, r11
@// f4 ^= g1
vmov  r10, s4
eor   r10, r1
vmov  s4, r10
@// f7 ^= g4
vmov  r10, s7
eor   r10, r4
vmov  s7, r10
@// g4 ^= f26
vmov r11, s26
eor  r4, r11
@// f26 ^= f25
vmov  r10, s26
vmov  r11, s25
eor   r10, r11
vmov  s26, r10
@// f6 ^= g0
vmov  r10, s6
eor   r10, r0
vmov  s6, r10
@// g7 ^= f19
vmov r11, s19
eor  r7, r11
@// f27 ^= f25
vmov  r10, s27
vmov  r11, s25
eor   r10, r11
vmov  s27, r10
@// f28 ^= g9
vmov  r10, s28
eor   r10, r9
vmov  s28, r10
@// f19 ^= g4
vmov  r10, s19
eor   r10, r4
vmov  s19, r10
@// g3 ^= f4
vmov r11, s4
eor  r3, r11
@// f14 ^= f9
vmov  r10, s14
vmov  r11, s9
eor   r10, r11
vmov  s14, r10
@// f16 ^= g8
vmov  r10, s16
eor   r10, r8
vmov  s16, r10
@// f12 ^= f6
vmov  r10, s12
vmov  r11, s6
eor   r10, r11
vmov  s12, r10
@// f13 ^= g6
vmov  r10, s13
eor   r10, r6
vmov  s13, r10
vstr.32  s0, [r14, #0]
str  r0, [r14, #4]
vstr.32  s2, [r14, #8]
vstr.32  s3, [r14, #12]
vstr.32  s4, [r14, #16]
str  r1, [r14, #20]
vstr.32  s6, [r14, #24]
vstr.32  s7, [r14, #28]
str  r2, [r14, #32]
vstr.32  s9, [r14, #36]
vstr.32  s10, [r14, #40]
vstr.32  s11, [r14, #44]
vstr.32  s12, [r14, #48]
vstr.32  s13, [r14, #52]
vstr.32  s14, [r14, #56]
str  r3, [r14, #60]
vstr.32  s16, [r14, #64]
str  r4, [r14, #68]
str  r5, [r14, #72]
vstr.32  s19, [r14, #76]
vstr.32  s20, [r14, #80]
vstr.32  s21, [r14, #84]
vstr.32  s22, [r14, #88]
str  r6, [r14, #92]
str  r7, [r14, #96]
vstr.32  s25, [r14, #100]
vstr.32  s26, [r14, #104]
vstr.32  s27, [r14, #108]
vstr.32  s28, [r14, #112]
str  r8, [r14, #116]
vstr.32  s30, [r14, #120]
str  r9, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v19, .-gft_mul_v19
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v20
.type gft_mul_v20, %function
.align 2
gft_mul_v20:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{0, 1, 2, 6, 11, 13, 15, 24, 25, 27, 28, 30}, {0, 3, 7, 10, 11, 12, 13, 14, 15, 24, 26, 27, 29, 31}, {0, 1, 4, 5, 6, 7, 8, 10, 12, 14, 15, 24, 27, 28, 29, 31}, {0, 4, 6, 9, 11, 13, 14, 25, 26, 27, 28, 30, 31}, {1, 4, 6, 10, 14, 15, 26, 27, 28, 29, 30}, {0, 1, 5, 7, 11, 14, 26, 28, 31}, {3, 4, 5, 7, 8, 9, 10, 11, 13, 15, 25, 27, 28, 29}, {2, 3, 4, 6, 7, 8, 10, 12, 13, 14, 15, 24, 25, 26, 27, 28}, {0, 1, 3, 4, 5, 10, 11, 12, 13, 14, 16, 18, 21, 23, 24, 26, 29, 31}, {0, 2, 3, 4, 10, 12, 15, 17, 19, 20, 21, 22, 23, 25, 27, 28, 29, 30, 31}, {0, 3, 6, 7, 9, 11, 12, 13, 16, 17, 19, 20, 22, 23, 24, 25, 27, 28, 30, 31}, {1, 2, 3, 6, 8, 9, 10, 11, 12, 16, 18, 19, 21, 22, 24, 26, 27, 29, 30}, {0, 3, 5, 8, 9, 11, 12, 13, 14, 18, 20, 26, 28}, {1, 2, 3, 4, 5, 8, 10, 11, 12, 15, 19, 21, 27, 29}, {0, 7, 8, 11, 12, 13, 16, 17, 18, 19, 22, 24, 25, 26, 27, 30}, {1, 6, 7, 9, 10, 11, 12, 16, 18, 23, 24, 26, 31}, {0, 1, 6, 7, 18, 23, 27, 29, 31}, {0, 6, 19, 22, 23, 26, 27, 28, 29, 30, 31}, {2, 3, 5, 7, 16, 17, 18, 19, 20, 22, 24, 26, 28, 30, 31}, {2, 4, 5, 6, 7, 16, 18, 21, 23, 25, 27, 29, 30}, {0, 5, 16, 17, 20, 21, 22, 26, 30, 31}, {1, 4, 5, 16, 20, 23, 27, 30}, {2, 7, 18, 19, 20, 21, 24, 25, 26, 27, 29, 31}, {3, 6, 7, 18, 20, 24, 26, 28, 29, 30, 31}, {8, 9, 14, 15, 16, 17, 19, 20, 21, 24, 25, 26, 27, 28, 29, 31}, {8, 14, 16, 18, 19, 20, 24, 26, 28, 30, 31}, {10, 11, 13, 15, 16, 19, 22, 23, 25, 26, 28, 31}, {10, 12, 13, 14, 15, 17, 18, 19, 22, 24, 25, 27, 29, 30, 31}, {8, 13, 16, 19, 21, 25, 27, 28, 30}, {9, 12, 13, 17, 18, 19, 20, 21, 24, 25, 26, 27, 29, 31}, {10, 15, 16, 23, 24, 26, 27, 28, 29, 31}, {11, 14, 15, 17, 22, 23, 25, 26, 28, 30, 31}]

@ i = 0
@ better circuit found: #XORs = 253
@ better circuit found: #XORs = 239
@ i = 50
@ i = 100
@ better circuit found: #XORs = 224
@ i = 150
@ i = 200
@ i = 250
@ i = 300
@ i = 350
@ i = 400
@ i = 450
@ i = 500
@ i = 550
@ i = 600
@ i = 650
@ i = 700
@ i = 750
@ i = 800
@ i = 850
@ i = 900
@ i = 950

@ initial state: [{0, 11, 18, 24, 28}, {3, 8, 10, 12, 21, 27}, {12, 19, 29, 31}, {26, 13, 31}, {13, 16, 25, 27, 28}, {1, 23, 7, 8, 9}, {1, 17, 19, 21, 25, 28}, {2, 4, 5, 11}, {7, 15, 18, 20, 21, 30}, {3, 11, 20, 23, 24, 31}, {0, 6, 8, 9, 26}, {16, 4, 24, 28, 15}, {3, 11, 14, 15}, {2, 4, 10, 14, 16, 31}, {4, 5, 8, 10, 30}, {9, 10, 12, 16, 28, 31}, {13, 18, 27, 29}, {4, 22, 24, 10, 11}, {2, 3, 5, 7, 8, 14, 17, 22}, {2, 6, 15, 24, 25}, {14, 17, 19, 21, 24, 30}, {14, 16, 19, 20, 23}, {6, 12, 26, 27, 30}, {1, 24, 29, 30}, {8, 11, 14, 19, 28, 31}, {9, 19, 22, 24, 31}, {10, 13, 16, 21, 24}, {9, 18, 22, 23, 27, 28}, {1, 8, 10, 14, 19, 27}, {2, 7, 9, 12, 13, 17}, {5, 6, 8, 19, 23}, {11, 15, 16, 27}]
@[0, 1, 2, 4, 6, 8, 9, 11, 15, 16, 18, 19, 20, 21, 22, 23, 24, 25, 26, 28, 29, 30, 3, 5, 7, 10, 12, 13, 14, 17, 27, 31]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 619)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #0]
ldr  r1, [r12, #44]
ldr  r2, [r12, #72]
ldr  r3, [r12, #96]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s0, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #32]
ldr  r2, [r12, #40]
ldr  r3, [r12, #48]
ldr  r4, [r12, #84]
ldr  r5, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s1, r0
ldr  r0, [r12, #48]
ldr  r1, [r12, #76]
ldr  r2, [r12, #116]
ldr  r3, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s2, r0
ldr  r0, [r12, #104]
ldr  r1, [r12, #52]
ldr  r2, [r12, #124]
eor r0, r1
eor r0, r2
vmov  s3, r0
ldr  r0, [r12, #52]
ldr  r1, [r12, #64]
ldr  r2, [r12, #100]
ldr  r3, [r12, #108]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s4, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #92]
ldr  r2, [r12, #28]
ldr  r3, [r12, #32]
ldr  r4, [r12, #36]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s5, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #68]
ldr  r2, [r12, #76]
ldr  r3, [r12, #84]
ldr  r4, [r12, #100]
ldr  r5, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s6, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #16]
ldr  r2, [r12, #20]
ldr  r3, [r12, #44]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s7, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #60]
ldr  r2, [r12, #72]
ldr  r3, [r12, #80]
ldr  r4, [r12, #84]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s8, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #44]
ldr  r2, [r12, #80]
ldr  r3, [r12, #92]
ldr  r4, [r12, #96]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s9, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #24]
ldr  r2, [r12, #32]
ldr  r3, [r12, #36]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s10, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #16]
ldr  r2, [r12, #96]
ldr  r3, [r12, #112]
ldr  r4, [r12, #60]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s11, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #44]
ldr  r2, [r12, #56]
ldr  r3, [r12, #60]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s12, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #16]
ldr  r2, [r12, #40]
ldr  r3, [r12, #56]
ldr  r4, [r12, #64]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s13, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #20]
ldr  r2, [r12, #32]
ldr  r3, [r12, #40]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s14, r0
ldr  r0, [r12, #36]
ldr  r1, [r12, #40]
ldr  r2, [r12, #48]
ldr  r3, [r12, #64]
ldr  r4, [r12, #112]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s15, r0
ldr  r0, [r12, #52]
ldr  r1, [r12, #72]
ldr  r2, [r12, #108]
ldr  r3, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s16, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #88]
ldr  r2, [r12, #96]
ldr  r3, [r12, #40]
ldr  r4, [r12, #44]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s17, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #12]
ldr  r2, [r12, #20]
ldr  r3, [r12, #28]
ldr  r4, [r12, #32]
ldr  r5, [r12, #56]
ldr  r6, [r12, #68]
ldr  r7, [r12, #88]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s18, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #24]
ldr  r2, [r12, #60]
ldr  r3, [r12, #96]
ldr  r4, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s19, r0
ldr  r0, [r12, #56]
ldr  r1, [r12, #68]
ldr  r2, [r12, #76]
ldr  r3, [r12, #84]
ldr  r4, [r12, #96]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s20, r0
ldr  r0, [r12, #56]
ldr  r1, [r12, #64]
ldr  r2, [r12, #76]
ldr  r3, [r12, #80]
ldr  r4, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s21, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #48]
ldr  r2, [r12, #104]
ldr  r3, [r12, #108]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s22, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #96]
ldr  r2, [r12, #116]
ldr  r3, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s23, r0
ldr  r0, [r12, #32]
ldr  r1, [r12, #44]
ldr  r2, [r12, #56]
ldr  r3, [r12, #76]
ldr  r4, [r12, #112]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s24, r0
ldr  r0, [r12, #36]
ldr  r1, [r12, #76]
ldr  r2, [r12, #88]
ldr  r3, [r12, #96]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s25, r0
ldr  r0, [r12, #40]
ldr  r1, [r12, #52]
ldr  r2, [r12, #64]
ldr  r3, [r12, #84]
ldr  r4, [r12, #96]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s26, r0
ldr  r0, [r12, #36]
ldr  r1, [r12, #72]
ldr  r2, [r12, #88]
ldr  r3, [r12, #92]
ldr  r4, [r12, #108]
ldr  r5, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s27, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #32]
ldr  r2, [r12, #40]
ldr  r3, [r12, #56]
ldr  r4, [r12, #76]
ldr  r5, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s28, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #28]
ldr  r2, [r12, #36]
ldr  r3, [r12, #48]
ldr  r4, [r12, #52]
ldr  r5, [r12, #68]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s29, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #24]
ldr  r2, [r12, #32]
ldr  r3, [r12, #76]
ldr  r4, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s30, r0
ldr  r0, [r12, #44]
ldr  r1, [r12, #60]
ldr  r2, [r12, #64]
ldr  r3, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s31, r0
vmov  r0, s3;
vmov  r1, s5;
vmov  r2, s7;
vmov  r3, s10;
vmov  r4, s12;
vmov  r5, s13;
vmov  r6, s14;
vmov  r7, s17;
vmov  r8, s27;
vmov  r9, s31;
@// g8 ^= f4
vmov r11, s4
eor  r8, r11
@// f1 ^= f26
vmov  r10, s1
vmov  r11, s26
eor   r10, r11
vmov  s1, r10
@// f4 ^= g0
vmov  r10, s4
eor   r10, r0
vmov  s4, r10
@// f9 ^= f0
vmov  r10, s9
vmov  r11, s0
eor   r10, r11
vmov  s9, r10
@// f4 ^= g5
vmov  r10, s4
eor   r10, r5
vmov  s4, r10
@// g5 ^= f26
vmov r11, s26
eor  r5, r11
@// f26 ^= f20
vmov  r10, s26
vmov  r11, s20
eor   r10, r11
vmov  s26, r10
@// f20 ^= f25
vmov  r10, s20
vmov  r11, s25
eor   r10, r11
vmov  s20, r10
@// g7 ^= g6
 eor r7, r6
@// g7 ^= f0
vmov r11, s0
eor  r7, r11
@// f0 ^= f16
vmov  r10, s0
vmov  r11, s16
eor   r10, r11
vmov  s0, r10
@// g9 ^= f16
vmov r11, s16
eor  r9, r11
@// f16 ^= g0
vmov  r10, s16
eor   r10, r0
vmov  s16, r10
@// f15 ^= g0
vmov  r10, s15
eor   r10, r0
vmov  s15, r10
@// g0 ^= g2
 eor r0, r2
@// g0 ^= g6
 eor r0, r6
@// g2 ^= g4
 eor r2, r4
@// g2 ^= f11
vmov r11, s11
eor  r2, r11
@// f20 ^= g4
vmov  r10, s20
eor   r10, r4
vmov  s20, r10
@// f25 ^= f21
vmov  r10, s25
vmov  r11, s21
eor   r10, r11
vmov  s25, r10
@// g4 ^= f21
vmov r11, s21
eor  r4, r11
@// f21 ^= f28
vmov  r10, s21
vmov  r11, s28
eor   r10, r11
vmov  s21, r10
@// f21 ^= g6
vmov  r10, s21
eor   r10, r6
vmov  s21, r10
@// g2 ^= f1
vmov r11, s1
eor  r2, r11
@// f25 ^= g1
vmov  r10, s25
eor   r10, r1
vmov  s25, r10
@// g4 ^= f30
vmov r11, s30
eor  r4, r11
@// g9 ^= f2
vmov r11, s2
eor  r9, r11
@// f2 ^= f23
vmov  r10, s2
vmov  r11, s23
eor   r10, r11
vmov  s2, r10
@// f19 ^= f23
vmov  r10, s19
vmov  r11, s23
eor   r10, r11
vmov  s19, r10
@// g6 ^= f23
vmov r11, s23
eor  r6, r11
@// f23 ^= g1
vmov  r10, s23
eor   r10, r1
vmov  s23, r10
@// g1 ^= g3
 eor r1, r3
@// g4 ^= g3
 eor r4, r3
@// g6 ^= f11
vmov r11, s11
eor  r6, r11
@// g2 ^= f0
vmov r11, s0
eor  r2, r11
@// f20 ^= g4
vmov  r10, s20
eor   r10, r4
vmov  s20, r10
@// f11 ^= g3
vmov  r10, s11
eor   r10, r3
vmov  s11, r10
@// f11 ^= g7
vmov  r10, s11
eor   r10, r7
vmov  s11, r10
@// g2 ^= g3
 eor r2, r3
@// f16 ^= g1
vmov  r10, s16
eor   r10, r1
vmov  s16, r10
@// g1 ^= f30
vmov r11, s30
eor  r1, r11
@// g8 ^= f15
vmov r11, s15
eor  r8, r11
@// g0 ^= g3
 eor r0, r3
@// g7 ^= g1
 eor r7, r1
@// f28 ^= f26
vmov  r10, s28
vmov  r11, s26
eor   r10, r11
vmov  s28, r10
@// g5 ^= f24
vmov r11, s24
eor  r5, r11
@// f22 ^= f2
vmov  r10, s22
vmov  r11, s2
eor   r10, r11
vmov  s22, r10
@// g3 ^= f9
vmov r11, s9
eor  r3, r11
@// f9 ^= f24
vmov  r10, s9
vmov  r11, s24
eor   r10, r11
vmov  s9, r10
@// f2 ^= g1
vmov  r10, s2
eor   r10, r1
vmov  s2, r10
@// g1 ^= f24
vmov r11, s24
eor  r1, r11
@// f24 ^= g9
vmov  r10, s24
eor   r10, r9
vmov  s24, r10
@// g9 ^= f26
vmov r11, s26
eor  r9, r11
@// f9 ^= g5
vmov  r10, s9
eor   r10, r5
vmov  s9, r10
@// g5 ^= f1
vmov r11, s1
eor  r5, r11
@// f30 ^= f22
vmov  r10, s30
vmov  r11, s22
eor   r10, r11
vmov  s30, r10
@// f30 ^= g6
vmov  r10, s30
eor   r10, r6
vmov  s30, r10
@// f28 ^= f6
vmov  r10, s28
vmov  r11, s6
eor   r10, r11
vmov  s28, r10
@// g9 ^= g8
 eor r9, r8
@// f25 ^= g7
vmov  r10, s25
eor   r10, r7
vmov  s25, r10
@// g8 ^= f30
vmov r11, s30
eor  r8, r11
@// f22 ^= f19
vmov  r10, s22
vmov  r11, s19
eor   r10, r11
vmov  s22, r10
@// f22 ^= f8
vmov  r10, s22
vmov  r11, s8
eor   r10, r11
vmov  s22, r10
@// f15 ^= f0
vmov  r10, s15
vmov  r11, s0
eor   r10, r11
vmov  s15, r10
@// g5 ^= g6
 eor r5, r6
@// g6 ^= g1
 eor r6, r1
@// g0 ^= f4
vmov r11, s4
eor  r0, r11
@// f4 ^= f19
vmov  r10, s4
vmov  r11, s19
eor   r10, r11
vmov  s4, r10
@// f15 ^= f16
vmov  r10, s15
vmov  r11, s16
eor   r10, r11
vmov  s15, r10
@// g7 ^= f16
vmov r11, s16
eor  r7, r11
@// f23 ^= g3
vmov  r10, s23
eor   r10, r3
vmov  s23, r10
@// g4 ^= f24
vmov r11, s24
eor  r4, r11
@// f8 ^= f21
vmov  r10, s8
vmov  r11, s21
eor   r10, r11
vmov  s8, r10
@// f6 ^= f29
vmov  r10, s6
vmov  r11, s29
eor   r10, r11
vmov  s6, r10
@// f6 ^= g5
vmov  r10, s6
eor   r10, r5
vmov  s6, r10
@// g8 ^= f26
vmov r11, s26
eor  r8, r11
@// f26 ^= g9
vmov  r10, s26
eor   r10, r9
vmov  s26, r10
@// f1 ^= g6
vmov  r10, s1
eor   r10, r6
vmov  s1, r10
@// g6 ^= g8
 eor r6, r8
@// f0 ^= f19
vmov  r10, s0
vmov  r11, s19
eor   r10, r11
vmov  s0, r10
@// f19 ^= f8
vmov  r10, s19
vmov  r11, s8
eor   r10, r11
vmov  s19, r10
@// g2 ^= f6
vmov r11, s6
eor  r2, r11
@// f2 ^= f4
vmov  r10, s2
vmov  r11, s4
eor   r10, r11
vmov  s2, r10
@// f18 ^= f25
vmov  r10, s18
vmov  r11, s25
eor   r10, r11
vmov  s18, r10
@// f9 ^= g8
vmov  r10, s9
eor   r10, r8
vmov  s9, r10
@// f11 ^= g5
vmov  r10, s11
eor   r10, r5
vmov  s11, r10
@// f29 ^= f22
vmov  r10, s29
vmov  r11, s22
eor   r10, r11
vmov  s29, r10
@// f8 ^= f1
vmov  r10, s8
vmov  r11, s1
eor   r10, r11
vmov  s8, r10
@// f24 ^= f29
vmov  r10, s24
vmov  r11, s29
eor   r10, r11
vmov  s24, r10
@// g3 ^= g6
 eor r3, r6
vstr.32  s0, [r14, #0]
vstr.32  s1, [r14, #4]
vstr.32  s2, [r14, #8]
str  r0, [r14, #12]
vstr.32  s4, [r14, #16]
str  r1, [r14, #20]
vstr.32  s6, [r14, #24]
str  r2, [r14, #28]
vstr.32  s8, [r14, #32]
vstr.32  s9, [r14, #36]
str  r3, [r14, #40]
vstr.32  s11, [r14, #44]
str  r4, [r14, #48]
str  r5, [r14, #52]
str  r6, [r14, #56]
vstr.32  s15, [r14, #60]
vstr.32  s16, [r14, #64]
str  r7, [r14, #68]
vstr.32  s18, [r14, #72]
vstr.32  s19, [r14, #76]
vstr.32  s20, [r14, #80]
vstr.32  s21, [r14, #84]
vstr.32  s22, [r14, #88]
vstr.32  s23, [r14, #92]
vstr.32  s24, [r14, #96]
vstr.32  s25, [r14, #100]
vstr.32  s26, [r14, #104]
str  r8, [r14, #108]
vstr.32  s28, [r14, #112]
vstr.32  s29, [r14, #116]
vstr.32  s30, [r14, #120]
str  r9, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v20, .-gft_mul_v20
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v21
.type gft_mul_v21, %function
.align 2
gft_mul_v21:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{3, 6, 9, 14, 15, 26, 27, 28, 29, 31}, {2, 3, 7, 8, 9, 14, 26, 28, 30, 31}, {0, 2, 4, 5, 6, 7, 11, 13, 15, 25, 27, 28, 31}, {1, 3, 4, 6, 10, 11, 12, 13, 14, 15, 24, 25, 26, 27, 29, 30, 31}, {1, 5, 7, 8, 12, 13, 25, 27, 29, 30}, {0, 1, 4, 5, 6, 7, 9, 12, 24, 25, 26, 27, 28, 29, 31}, {3, 4, 6, 7, 10, 14, 15, 24, 26, 27, 28, 29, 30}, {2, 3, 5, 6, 11, 14, 25, 26, 28, 31}, {0, 2, 4, 5, 6, 8, 10, 11, 12, 13, 17, 19, 20, 25, 27, 28}, {1, 3, 4, 7, 9, 10, 12, 16, 17, 18, 19, 21, 24, 25, 26, 27, 29}, {0, 1, 3, 4, 5, 9, 10, 11, 14, 15, 16, 18, 19, 22, 24, 26, 27, 30}, {0, 2, 3, 4, 8, 9, 10, 14, 17, 18, 23, 25, 26, 31}, {0, 1, 3, 5, 6, 7, 8, 11, 14, 17, 18, 19, 22, 25, 26, 27, 30}, {0, 2, 3, 4, 5, 6, 9, 10, 11, 15, 16, 17, 18, 23, 24, 25, 26, 31}, {0, 3, 5, 8, 12, 13, 14, 15, 17, 20, 21, 22, 23, 25, 28, 29, 30, 31}, {1, 2, 3, 4, 5, 9, 12, 14, 16, 17, 20, 22, 24, 25, 28, 30}, {2, 6, 18, 19, 25, 30, 31}, {3, 7, 18, 24, 25, 30}, {0, 1, 2, 3, 4, 5, 6, 7, 17, 19, 27, 29, 31}, {0, 2, 4, 6, 16, 17, 18, 19, 26, 27, 28, 29, 30, 31}, {1, 5, 6, 22, 23, 24, 28, 29}, {0, 1, 4, 5, 7, 22, 25, 28}, {3, 4, 5, 6, 21, 23, 26, 30, 31}, {2, 3, 4, 7, 20, 21, 22, 23, 27, 30}, {10, 14, 16, 18, 20, 21, 22, 24, 27, 28, 29, 30}, {11, 15, 17, 19, 20, 23, 25, 26, 27, 28, 31}, {8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20, 21, 24, 28, 29}, {8, 10, 12, 14, 16, 18, 19, 20, 25, 28}, {9, 13, 14, 16, 17, 19, 21, 22, 23, 24, 25, 27, 29}, {8, 9, 12, 13, 15, 16, 18, 19, 20, 21, 22, 24, 26, 27, 28, 29}, {11, 12, 13, 14, 16, 19, 21, 24, 27, 31}, {10, 11, 12, 15, 17, 18, 19, 20, 21, 25, 26, 27, 30, 31}]

@ i = 0
@ better circuit found: #XORs = 263
@ better circuit found: #XORs = 241
@ better circuit found: #XORs = 237
@ better circuit found: #XORs = 232
@ i = 50
@ i = 100
@ i = 150
@ i = 200
@ i = 250
@ i = 300
@ i = 350
@ i = 400
@ better circuit found: #XORs = 231
@ i = 450
@ i = 500
@ i = 550
@ i = 600
@ i = 650
@ i = 700
@ better circuit found: #XORs = 230
@ i = 750
@ i = 800
@ i = 850
@ i = 900
@ i = 950

@ initial state: [{8, 11, 15, 24, 31}, {0, 7, 8, 11, 28, 29}, {5, 11, 13, 23}, {1, 7, 10, 12, 25}, {0, 5, 7, 27, 30, 31}, {5, 6, 24, 28, 29}, {0, 30, 24, 25, 9}, {22, 8, 9, 28, 31}, {19, 21, 22, 8, 26}, {7, 25, 26, 27, 9}, {2, 8, 15, 16, 17, 18, 19}, {10, 12, 17, 21, 31}, {3, 4, 6, 10, 21, 26, 28, 30}, {0, 7, 14, 15, 16}, {27, 12, 13, 14, 31}, {0, 2, 8, 12, 26}, {2, 6, 18, 19, 25, 30, 31}, {17, 18, 3, 23}, {16, 4, 23, 28, 29}, {0, 17, 23, 7, 9}, {1, 22, 23}, {0, 1, 4, 12, 31}, {5, 10, 23, 28, 31}, {2, 5, 6, 15, 27, 31}, {1, 13, 16, 20, 24, 29, 31}, {7, 15, 20, 22, 26}, {17, 10, 25, 29, 9}, {2, 3, 9, 20, 22, 24, 29}, {14, 18, 22, 25, 29, 31}, {3, 9, 11, 12, 14}, {8, 13, 16, 18, 21, 24}, {17, 18, 5, 10, 30}]
@[0, 1, 2, 4, 5, 6, 10, 12, 13, 15, 16, 17, 18, 19, 20, 22, 23, 24, 25, 27, 28, 30, 3, 7, 8, 9, 11, 14, 21, 26, 29, 31]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 633)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #32]
ldr  r1, [r12, #44]
ldr  r2, [r12, #60]
ldr  r3, [r12, #96]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s0, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #28]
ldr  r2, [r12, #32]
ldr  r3, [r12, #44]
ldr  r4, [r12, #112]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s1, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #44]
ldr  r2, [r12, #52]
ldr  r3, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s2, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #28]
ldr  r2, [r12, #40]
ldr  r3, [r12, #48]
ldr  r4, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s3, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #20]
ldr  r2, [r12, #28]
ldr  r3, [r12, #108]
ldr  r4, [r12, #120]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s4, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #24]
ldr  r2, [r12, #96]
ldr  r3, [r12, #112]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s5, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #120]
ldr  r2, [r12, #96]
ldr  r3, [r12, #100]
ldr  r4, [r12, #36]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s6, r0
ldr  r0, [r12, #88]
ldr  r1, [r12, #32]
ldr  r2, [r12, #36]
ldr  r3, [r12, #112]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s7, r0
ldr  r0, [r12, #76]
ldr  r1, [r12, #84]
ldr  r2, [r12, #88]
ldr  r3, [r12, #32]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s8, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #100]
ldr  r2, [r12, #104]
ldr  r3, [r12, #108]
ldr  r4, [r12, #36]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s9, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #32]
ldr  r2, [r12, #60]
ldr  r3, [r12, #64]
ldr  r4, [r12, #68]
ldr  r5, [r12, #72]
ldr  r6, [r12, #76]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s10, r0
ldr  r0, [r12, #40]
ldr  r1, [r12, #48]
ldr  r2, [r12, #68]
ldr  r3, [r12, #84]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s11, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #16]
ldr  r2, [r12, #24]
ldr  r3, [r12, #40]
ldr  r4, [r12, #84]
ldr  r5, [r12, #104]
ldr  r6, [r12, #112]
ldr  r7, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s12, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #28]
ldr  r2, [r12, #56]
ldr  r3, [r12, #60]
ldr  r4, [r12, #64]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s13, r0
ldr  r0, [r12, #108]
ldr  r1, [r12, #48]
ldr  r2, [r12, #52]
ldr  r3, [r12, #56]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s14, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #8]
ldr  r2, [r12, #32]
ldr  r3, [r12, #48]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s15, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #24]
ldr  r2, [r12, #72]
ldr  r3, [r12, #76]
ldr  r4, [r12, #100]
ldr  r5, [r12, #120]
ldr  r6, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s16, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #72]
ldr  r2, [r12, #12]
ldr  r3, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s17, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #16]
ldr  r2, [r12, #92]
ldr  r3, [r12, #112]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s18, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #68]
ldr  r2, [r12, #92]
ldr  r3, [r12, #28]
ldr  r4, [r12, #36]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s19, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #88]
ldr  r2, [r12, #92]
eor r0, r1
eor r0, r2
vmov  s20, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #16]
ldr  r3, [r12, #48]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s21, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #40]
ldr  r2, [r12, #92]
ldr  r3, [r12, #112]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s22, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #20]
ldr  r2, [r12, #24]
ldr  r3, [r12, #60]
ldr  r4, [r12, #108]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s23, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #52]
ldr  r2, [r12, #64]
ldr  r3, [r12, #80]
ldr  r4, [r12, #96]
ldr  r5, [r12, #116]
ldr  r6, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s24, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #60]
ldr  r2, [r12, #80]
ldr  r3, [r12, #88]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s25, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #40]
ldr  r2, [r12, #100]
ldr  r3, [r12, #116]
ldr  r4, [r12, #36]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s26, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #12]
ldr  r2, [r12, #36]
ldr  r3, [r12, #80]
ldr  r4, [r12, #88]
ldr  r5, [r12, #96]
ldr  r6, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s27, r0
ldr  r0, [r12, #56]
ldr  r1, [r12, #72]
ldr  r2, [r12, #88]
ldr  r3, [r12, #100]
ldr  r4, [r12, #116]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s28, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #36]
ldr  r2, [r12, #44]
ldr  r3, [r12, #48]
ldr  r4, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s29, r0
ldr  r0, [r12, #32]
ldr  r1, [r12, #52]
ldr  r2, [r12, #64]
ldr  r3, [r12, #72]
ldr  r4, [r12, #84]
ldr  r5, [r12, #96]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s30, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #72]
ldr  r2, [r12, #20]
ldr  r3, [r12, #40]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s31, r0
vmov  r0, s3;
vmov  r1, s7;
vmov  r2, s8;
vmov  r3, s9;
vmov  r4, s11;
vmov  r5, s14;
vmov  r6, s21;
vmov  r7, s26;
vmov  r8, s29;
vmov  r9, s31;
@// f27 ^= g7
vmov  r10, s27
eor   r10, r7
vmov  s27, r10
@// g7 ^= g3
 eor r7, r3
@// f24 ^= g5
vmov  r10, s24
eor   r10, r5
vmov  s24, r10
@// g5 ^= g6
 eor r5, r6
@// g6 ^= g0
 eor r6, r0
@// f0 ^= g1
vmov  r10, s0
eor   r10, r1
vmov  s0, r10
@// g1 ^= g2
 eor r1, r2
@// f0 ^= g8
vmov  r10, s0
eor   r10, r8
vmov  s0, r10
@// g0 ^= f20
vmov r11, s20
eor  r0, r11
@// g1 ^= g4
 eor r1, r4
@// g7 ^= g1
 eor r7, r1
@// f15 ^= g1
vmov  r10, s15
eor   r10, r1
vmov  s15, r10
@// g1 ^= g8
 eor r1, r8
@// g8 ^= f17
vmov r11, s17
eor  r8, r11
@// f17 ^= f19
vmov  r10, s17
vmov  r11, s19
eor   r10, r11
vmov  s17, r10
@// f19 ^= g3
vmov  r10, s19
eor   r10, r3
vmov  s19, r10
@// g1 ^= g9
 eor r1, r9
@// f2 ^= f20
vmov  r10, s2
vmov  r11, s20
eor   r10, r11
vmov  s2, r10
@// g9 ^= f22
vmov r11, s22
eor  r9, r11
@// f27 ^= f0
vmov  r10, s27
vmov  r11, s0
eor   r10, r11
vmov  s27, r10
@// f27 ^= f10
vmov  r10, s27
vmov  r11, s10
eor   r10, r11
vmov  s27, r10
@// g3 ^= g0
 eor r3, r0
@// g0 ^= f22
vmov r11, s22
eor  r0, r11
@// f30 ^= g2
vmov  r10, s30
eor   r10, r2
vmov  s30, r10
@// f10 ^= f16
vmov  r10, s10
vmov  r11, s16
eor   r10, r11
vmov  s10, r10
@// f19 ^= f18
vmov  r10, s19
vmov  r11, s18
eor   r10, r11
vmov  s19, r10
@// f18 ^= f22
vmov  r10, s18
vmov  r11, s22
eor   r10, r11
vmov  s18, r10
@// g0 ^= f2
vmov r11, s2
eor  r0, r11
@// f24 ^= f20
vmov  r10, s24
vmov  r11, s20
eor   r10, r11
vmov  s24, r10
@// g5 ^= f17
vmov r11, s17
eor  r5, r11
@// f17 ^= f6
vmov  r10, s17
vmov  r11, s6
eor   r10, r11
vmov  s17, r10
@// f4 ^= f1
vmov  r10, s4
vmov  r11, s1
eor   r10, r11
vmov  s4, r10
@// f1 ^= f5
vmov  r10, s1
vmov  r11, s5
eor   r10, r11
vmov  s1, r10
@// f13 ^= f1
vmov  r10, s13
vmov  r11, s1
eor   r10, r11
vmov  s13, r10
@// f1 ^= f6
vmov  r10, s1
vmov  r11, s6
eor   r10, r11
vmov  s1, r10
@// f5 ^= f22
vmov  r10, s5
vmov  r11, s22
eor   r10, r11
vmov  s5, r10
@// f20 ^= f22
vmov  r10, s20
vmov  r11, s22
eor   r10, r11
vmov  s20, r10
@// f22 ^= f12
vmov  r10, s22
vmov  r11, s12
eor   r10, r11
vmov  s22, r10
@// f12 ^= g2
vmov  r10, s12
eor   r10, r2
vmov  s12, r10
@// g2 ^= f25
vmov r11, s25
eor  r2, r11
@// f18 ^= f23
vmov  r10, s18
vmov  r11, s23
eor   r10, r11
vmov  s18, r10
@// f2 ^= f23
vmov  r10, s2
vmov  r11, s23
eor   r10, r11
vmov  s2, r10
@// f23 ^= f25
vmov  r10, s23
vmov  r11, s25
eor   r10, r11
vmov  s23, r10
@// f23 ^= f22
vmov  r10, s23
vmov  r11, s22
eor   r10, r11
vmov  s23, r10
@// g1 ^= f16
vmov r11, s16
eor  r1, r11
@// g9 ^= g4
 eor r9, r4
@// f28 ^= g8
vmov  r10, s28
eor   r10, r8
vmov  s28, r10
@// g8 ^= g3
 eor r8, r3
@// f30 ^= g8
vmov  r10, s30
eor   r10, r8
vmov  s30, r10
@// f30 ^= g4
vmov  r10, s30
eor   r10, r4
vmov  s30, r10
@// f25 ^= g7
vmov  r10, s25
eor   r10, r7
vmov  s25, r10
@// f25 ^= f28
vmov  r10, s25
vmov  r11, s28
eor   r10, r11
vmov  s25, r10
@// f6 ^= g6
vmov  r10, s6
eor   r10, r6
vmov  s6, r10
@// g2 ^= g4
 eor r2, r4
@// g4 ^= g6
 eor r4, r6
@// g6 ^= f20
vmov r11, s20
eor  r6, r11
@// f15 ^= f27
vmov  r10, s15
vmov  r11, s27
eor   r10, r11
vmov  s15, r10
@// f20 ^= f5
vmov  r10, s20
vmov  r11, s5
eor   r10, r11
vmov  s20, r10
@// f4 ^= g0
vmov  r10, s4
eor   r10, r0
vmov  s4, r10
@// f18 ^= f10
vmov  r10, s18
vmov  r11, s10
eor   r10, r11
vmov  s18, r10
@// f1 ^= g1
vmov  r10, s1
eor   r10, r1
vmov  s1, r10
@// f15 ^= f17
vmov  r10, s15
vmov  r11, s17
eor   r10, r11
vmov  s15, r10
@// f5 ^= g3
vmov  r10, s5
eor   r10, r3
vmov  s5, r10
@// g3 ^= g5
 eor r3, r5
@// g5 ^= g6
 eor r5, r6
@// f12 ^= g6
vmov  r10, s12
eor   r10, r6
vmov  s12, r10
@// f0 ^= f5
vmov  r10, s0
vmov  r11, s5
eor   r10, r11
vmov  s0, r10
@// f24 ^= g9
vmov  r10, s24
eor   r10, r9
vmov  s24, r10
@// f18 ^= f12
vmov  r10, s18
vmov  r11, s12
eor   r10, r11
vmov  s18, r10
@// g7 ^= g2
 eor r7, r2
@// f10 ^= f6
vmov  r10, s10
vmov  r11, s6
eor   r10, r11
vmov  s10, r10
@// g4 ^= g9
 eor r4, r9
@// g5 ^= g9
 eor r5, r9
@// g4 ^= f1
vmov r11, s1
eor  r4, r11
@// f28 ^= f30
vmov  r10, s28
vmov  r11, s30
eor   r10, r11
vmov  s28, r10
@// f15 ^= g6
vmov  r10, s15
eor   r10, r6
vmov  s15, r10
@// g5 ^= g7
 eor r5, r7
@// f2 ^= g6
vmov  r10, s2
eor   r10, r6
vmov  s2, r10
@// f19 ^= f16
vmov  r10, s19
vmov  r11, s16
eor   r10, r11
vmov  s19, r10
@// g3 ^= f28
vmov r11, s28
eor  r3, r11
@// g7 ^= f30
vmov r11, s30
eor  r7, r11
@// f5 ^= g6
vmov  r10, s5
eor   r10, r6
vmov  s5, r10
@// f6 ^= f0
vmov  r10, s6
vmov  r11, s0
eor   r10, r11
vmov  s6, r10
@// f12 ^= g8
vmov  r10, s12
eor   r10, r8
vmov  s12, r10
@// g2 ^= f2
vmov r11, s2
eor  r2, r11
@// f10 ^= f12
vmov  r10, s10
vmov  r11, s12
eor   r10, r11
vmov  s10, r10
@// g9 ^= f25
vmov r11, s25
eor  r9, r11
@// g8 ^= g7
 eor r8, r7
@// g0 ^= f6
vmov r11, s6
eor  r0, r11
@// f13 ^= g4
vmov  r10, s13
eor   r10, r4
vmov  s13, r10
vstr.32  s0, [r14, #0]
vstr.32  s1, [r14, #4]
vstr.32  s2, [r14, #8]
str  r0, [r14, #12]
vstr.32  s4, [r14, #16]
vstr.32  s5, [r14, #20]
vstr.32  s6, [r14, #24]
str  r1, [r14, #28]
str  r2, [r14, #32]
str  r3, [r14, #36]
vstr.32  s10, [r14, #40]
str  r4, [r14, #44]
vstr.32  s12, [r14, #48]
vstr.32  s13, [r14, #52]
str  r5, [r14, #56]
vstr.32  s15, [r14, #60]
vstr.32  s16, [r14, #64]
vstr.32  s17, [r14, #68]
vstr.32  s18, [r14, #72]
vstr.32  s19, [r14, #76]
vstr.32  s20, [r14, #80]
str  r6, [r14, #84]
vstr.32  s22, [r14, #88]
vstr.32  s23, [r14, #92]
vstr.32  s24, [r14, #96]
vstr.32  s25, [r14, #100]
str  r7, [r14, #104]
vstr.32  s27, [r14, #108]
vstr.32  s28, [r14, #112]
str  r8, [r14, #116]
vstr.32  s30, [r14, #120]
str  r9, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v21, .-gft_mul_v21
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v22
.type gft_mul_v22, %function
.align 2
gft_mul_v22:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{1, 4, 5, 7, 8, 9, 10, 11, 12, 14, 15, 24, 25, 27, 29, 30}, {0, 1, 4, 6, 7, 8, 10, 13, 14, 24, 26, 27, 28, 29, 31}, {3, 4, 7, 9, 10, 13, 14, 15, 24, 27, 28, 29, 30}, {2, 3, 5, 6, 7, 8, 9, 11, 12, 13, 14, 25, 26, 27, 28, 31}, {1, 3, 7, 8, 9, 10, 11, 24, 26, 29, 30, 31}, {0, 1, 2, 3, 6, 7, 8, 10, 25, 27, 28, 29, 30}, {0, 2, 3, 4, 6, 9, 10, 24, 25, 27, 29}, {1, 2, 5, 7, 8, 9, 11, 24, 26, 27, 28, 29}, {0, 1, 3, 7, 8, 11, 12, 13, 19, 21, 23, 27, 29, 31}, {0, 2, 3, 6, 7, 9, 10, 11, 12, 18, 19, 20, 21, 22, 23, 26, 27, 28, 29, 30, 31}, {0, 3, 4, 6, 8, 14, 15, 16, 18, 20, 22, 23, 24, 26, 28, 30, 31}, {1, 2, 3, 5, 7, 9, 14, 17, 19, 21, 22, 25, 27, 29, 30}, {0, 1, 7, 8, 11, 18, 22, 23, 26, 30, 31}, {0, 6, 7, 9, 10, 11, 19, 22, 27, 30}, {2, 3, 4, 6, 8, 16, 17, 18, 19, 21, 23, 24, 25, 26, 27, 29, 31}, {2, 5, 7, 9, 16, 18, 20, 21, 22, 23, 24, 26, 28, 29, 30, 31}, {0, 1, 3, 4, 5, 16, 19, 23, 24, 25, 26, 27, 28, 30, 31}, {0, 2, 3, 4, 17, 18, 19, 22, 23, 24, 26, 29, 30}, {0, 3, 6, 7, 16, 20, 22, 25, 26, 29, 30, 31}, {1, 2, 3, 6, 17, 21, 23, 24, 25, 27, 28, 29, 30}, {0, 3, 5, 16, 17, 21, 23, 24, 25, 26, 27}, {1, 2, 3, 4, 5, 16, 20, 21, 22, 23, 24, 26}, {0, 7, 18, 19, 20, 22, 23, 25, 26}, {1, 6, 7, 18, 21, 22, 24, 25, 27}, {8, 9, 11, 12, 13, 16, 17, 19, 23, 25}, {8, 10, 11, 12, 16, 18, 19, 22, 23, 24, 25}, {8, 11, 14, 15, 16, 19, 20, 22, 27}, {9, 10, 11, 14, 17, 18, 19, 21, 23, 26, 27}, {8, 11, 13, 16, 17, 23, 29}, {9, 10, 11, 12, 13, 16, 22, 23, 28, 29}, {8, 15, 18, 19, 20, 22, 31}, {9, 14, 15, 18, 21, 23, 30, 31}]

@ i = 0
@ better circuit found: #XORs = 254
@ better circuit found: #XORs = 252
@ better circuit found: #XORs = 242
@ better circuit found: #XORs = 235
@ better circuit found: #XORs = 233
@ i = 50
@ better circuit found: #XORs = 227
@ better circuit found: #XORs = 223
@ i = 100
@ i = 150
@ better circuit found: #XORs = 219
@ i = 200
@ i = 250
@ i = 300
@ i = 350
@ i = 400
@ i = 450
@ i = 500
@ i = 550
@ i = 600
@ i = 650
@ i = 700
@ i = 750
@ i = 800
@ i = 850
@ i = 900
@ i = 950

@ initial state: [{1, 18, 5, 22, 11}, {0, 2, 7, 8, 14, 25, 30}, {1, 8, 10, 13, 14, 25, 29}, {21, 23, 25, 14, 31}, {1, 7, 15, 26, 27, 30}, {30, 8, 12, 9}, {6, 8, 13, 15, 28}, {2, 4, 5, 10, 25, 26, 29}, {0, 1, 12, 19, 26}, {16, 3, 10, 24, 26, 12}, {3, 25, 27, 15}, {4, 27, 24, 31}, {9, 10, 16, 22, 24, 31}, {6, 12, 18, 22, 27}, {2, 3, 5, 6, 7, 26, 28}, {3, 8, 18, 24, 29, 31}, {0, 19, 6, 30}, {4, 21, 25, 28}, {0, 8, 16, 23, 24}, {2, 6, 18, 21, 23}, {5, 8, 15, 17, 21, 26}, {0, 1, 6, 17, 25, 31}, {2, 20, 6, 22, 24}, {1, 7, 12, 21, 24, 25}, {9, 12, 19, 25, 29}, {10, 11, 25, 27, 30}, {11, 14, 16, 18, 27, 31}, {7, 14, 23, 24, 28}, {0, 17, 29, 24, 11, 13}, {17, 22, 10, 28, 30}, {8, 15, 18, 19, 20, 22, 31}, {18, 9, 25, 15, 30}]
@[1, 2, 3, 6, 7, 9, 12, 13, 14, 16, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 4, 5, 8, 10, 11, 15, 17, 18, 19]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 592)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #4]
ldr  r1, [r12, #72]
ldr  r2, [r12, #20]
ldr  r3, [r12, #88]
ldr  r4, [r12, #44]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s0, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #8]
ldr  r2, [r12, #28]
ldr  r3, [r12, #32]
ldr  r4, [r12, #56]
ldr  r5, [r12, #100]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s1, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #32]
ldr  r2, [r12, #40]
ldr  r3, [r12, #52]
ldr  r4, [r12, #56]
ldr  r5, [r12, #100]
ldr  r6, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s2, r0
ldr  r0, [r12, #84]
ldr  r1, [r12, #92]
ldr  r2, [r12, #100]
ldr  r3, [r12, #56]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s3, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #28]
ldr  r2, [r12, #60]
ldr  r3, [r12, #104]
ldr  r4, [r12, #108]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s4, r0
ldr  r0, [r12, #120]
ldr  r1, [r12, #32]
ldr  r2, [r12, #48]
ldr  r3, [r12, #36]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s5, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #32]
ldr  r2, [r12, #52]
ldr  r3, [r12, #60]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s6, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #16]
ldr  r2, [r12, #20]
ldr  r3, [r12, #40]
ldr  r4, [r12, #100]
ldr  r5, [r12, #104]
ldr  r6, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s7, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #48]
ldr  r3, [r12, #76]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s8, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #12]
ldr  r2, [r12, #40]
ldr  r3, [r12, #96]
ldr  r4, [r12, #104]
ldr  r5, [r12, #48]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s9, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #100]
ldr  r2, [r12, #108]
ldr  r3, [r12, #60]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s10, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #108]
ldr  r2, [r12, #96]
ldr  r3, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s11, r0
ldr  r0, [r12, #36]
ldr  r1, [r12, #40]
ldr  r2, [r12, #64]
ldr  r3, [r12, #88]
ldr  r4, [r12, #96]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s12, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #48]
ldr  r2, [r12, #72]
ldr  r3, [r12, #88]
ldr  r4, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s13, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #12]
ldr  r2, [r12, #20]
ldr  r3, [r12, #24]
ldr  r4, [r12, #28]
ldr  r5, [r12, #104]
ldr  r6, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s14, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #32]
ldr  r2, [r12, #72]
ldr  r3, [r12, #96]
ldr  r4, [r12, #116]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s15, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #76]
ldr  r2, [r12, #24]
ldr  r3, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s16, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #84]
ldr  r2, [r12, #100]
ldr  r3, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s17, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #32]
ldr  r2, [r12, #64]
ldr  r3, [r12, #92]
ldr  r4, [r12, #96]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s18, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #24]
ldr  r2, [r12, #72]
ldr  r3, [r12, #84]
ldr  r4, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s19, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #32]
ldr  r2, [r12, #60]
ldr  r3, [r12, #68]
ldr  r4, [r12, #84]
ldr  r5, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s20, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #24]
ldr  r3, [r12, #68]
ldr  r4, [r12, #100]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s21, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #80]
ldr  r2, [r12, #24]
ldr  r3, [r12, #88]
ldr  r4, [r12, #96]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s22, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #28]
ldr  r2, [r12, #48]
ldr  r3, [r12, #84]
ldr  r4, [r12, #96]
ldr  r5, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s23, r0
ldr  r0, [r12, #36]
ldr  r1, [r12, #48]
ldr  r2, [r12, #76]
ldr  r3, [r12, #100]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s24, r0
ldr  r0, [r12, #40]
ldr  r1, [r12, #44]
ldr  r2, [r12, #100]
ldr  r3, [r12, #108]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s25, r0
ldr  r0, [r12, #44]
ldr  r1, [r12, #56]
ldr  r2, [r12, #64]
ldr  r3, [r12, #72]
ldr  r4, [r12, #108]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s26, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #56]
ldr  r2, [r12, #92]
ldr  r3, [r12, #96]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s27, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #68]
ldr  r2, [r12, #116]
ldr  r3, [r12, #96]
ldr  r4, [r12, #44]
ldr  r5, [r12, #52]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s28, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #88]
ldr  r2, [r12, #40]
ldr  r3, [r12, #112]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s29, r0
ldr  r0, [r12, #32]
ldr  r1, [r12, #60]
ldr  r2, [r12, #72]
ldr  r3, [r12, #76]
ldr  r4, [r12, #80]
ldr  r5, [r12, #88]
ldr  r6, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s30, r0
ldr  r0, [r12, #72]
ldr  r1, [r12, #36]
ldr  r2, [r12, #100]
ldr  r3, [r12, #60]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s31, r0
vmov  r0, s0;
vmov  r1, s4;
vmov  r2, s5;
vmov  r3, s8;
vmov  r4, s10;
vmov  r5, s11;
vmov  r6, s15;
vmov  r7, s17;
vmov  r8, s18;
vmov  r9, s19;
@// f28 ^= g8
vmov  r10, s28
eor   r10, r8
vmov  s28, r10
@// f12 ^= g8
vmov  r10, s12
eor   r10, r8
vmov  s12, r10
@// f20 ^= g8
vmov  r10, s20
eor   r10, r8
vmov  s20, r10
@// g8 ^= f16
vmov r11, s16
eor  r8, r11
@// f16 ^= f21
vmov  r10, s16
vmov  r11, s21
eor   r10, r11
vmov  s16, r10
@// f21 ^= g5
vmov  r10, s21
eor   r10, r5
vmov  s21, r10
@// f21 ^= f22
vmov  r10, s21
vmov  r11, s22
eor   r10, r11
vmov  s21, r10
@// g1 ^= f31
vmov r11, s31
eor  r1, r11
@// f3 ^= g9
vmov  r10, s3
eor   r10, r9
vmov  s3, r10
@// f31 ^= f3
vmov  r10, s31
vmov  r11, s3
eor   r10, r11
vmov  s31, r10
@// f31 ^= g9
vmov  r10, s31
eor   r10, r9
vmov  s31, r10
@// f22 ^= g9
vmov  r10, s22
eor   r10, r9
vmov  s22, r10
@// g9 ^= g7
 eor r9, r7
@// g9 ^= f7
vmov r11, s7
eor  r9, r11
@// f27 ^= g5
vmov  r10, s27
eor   r10, r5
vmov  s27, r10
@// g5 ^= f26
vmov r11, s26
eor  r5, r11
@// g5 ^= g0
 eor r5, r0
@// g0 ^= f13
vmov r11, s13
eor  r0, r11
@// g9 ^= f29
vmov r11, s29
eor  r9, r11
@// f16 ^= g7
vmov  r10, s16
eor   r10, r7
vmov  s16, r10
@// g7 ^= f23
vmov r11, s23
eor  r7, r11
@// f29 ^= g2
vmov  r10, s29
eor   r10, r2
vmov  s29, r10
@// g2 ^= g7
 eor r2, r7
@// g7 ^= g3
 eor r7, r3
@// f7 ^= f25
vmov  r10, s7
vmov  r11, s25
eor   r10, r11
vmov  s7, r10
@// f9 ^= g3
vmov  r10, s9
eor   r10, r3
vmov  s9, r10
@// f3 ^= g1
vmov  r10, s3
eor   r10, r1
vmov  s3, r10
@// g1 ^= f25
vmov r11, s25
eor  r1, r11
@// g5 ^= g2
 eor r5, r2
@// g5 ^= g8
 eor r5, r8
@// g9 ^= f14
vmov r11, s14
eor  r9, r11
@// f22 ^= f23
vmov  r10, s22
vmov  r11, s23
eor   r10, r11
vmov  s22, r10
@// f22 ^= g3
vmov  r10, s22
eor   r10, r3
vmov  s22, r10
@// f14 ^= g7
vmov  r10, s14
eor   r10, r7
vmov  s14, r10
@// f1 ^= f2
vmov  r10, s1
vmov  r11, s2
eor   r10, r11
vmov  s1, r10
@// f2 ^= g4
vmov  r10, s2
eor   r10, r4
vmov  s2, r10
@// f1 ^= g2
vmov  r10, s1
eor   r10, r2
vmov  s1, r10
@// f6 ^= g4
vmov  r10, s6
eor   r10, r4
vmov  s6, r10
@// f20 ^= g4
vmov  r10, s20
eor   r10, r4
vmov  s20, r10
@// g4 ^= g6
 eor r4, r6
@// g4 ^= f27
vmov r11, s27
eor  r4, r11
@// f27 ^= f16
vmov  r10, s27
vmov  r11, s16
eor   r10, r11
vmov  s27, r10
@// f14 ^= g6
vmov  r10, s14
eor   r10, r6
vmov  s14, r10
@// f25 ^= f13
vmov  r10, s25
vmov  r11, s13
eor   r10, r11
vmov  s25, r10
@// f25 ^= g8
vmov  r10, s25
eor   r10, r8
vmov  s25, r10
@// g8 ^= g6
 eor r8, r6
@// f23 ^= f13
vmov  r10, s23
vmov  r11, s13
eor   r10, r11
vmov  s23, r10
@// g3 ^= g1
 eor r3, r1
@// f13 ^= g3
vmov  r10, s13
eor   r10, r3
vmov  s13, r10
@// g3 ^= f31
vmov r11, s31
eor  r3, r11
@// f27 ^= g1
vmov  r10, s27
eor   r10, r1
vmov  s27, r10
@// f21 ^= f20
vmov  r10, s21
vmov  r11, s20
eor   r10, r11
vmov  s21, r10
@// f9 ^= g0
vmov  r10, s9
eor   r10, r0
vmov  s9, r10
@// g0 ^= f6
vmov r11, s6
eor  r0, r11
@// g8 ^= f22
vmov r11, s22
eor  r8, r11
@// f26 ^= f30
vmov  r10, s26
vmov  r11, s30
eor   r10, r11
vmov  s26, r10
@// f29 ^= f28
vmov  r10, s29
vmov  r11, s28
eor   r10, r11
vmov  s29, r10
@// g7 ^= g9
 eor r7, r9
@// g9 ^= f23
vmov r11, s23
eor  r9, r11
@// g3 ^= f2
vmov r11, s2
eor  r3, r11
@// f12 ^= g1
vmov  r10, s12
eor   r10, r1
vmov  s12, r10
@// f7 ^= g2
vmov  r10, s7
eor   r10, r2
vmov  s7, r10
@// g1 ^= g6
 eor r1, r6
@// g6 ^= g2
 eor r6, r2
@// f6 ^= f1
vmov  r10, s6
vmov  r11, s1
eor   r10, r11
vmov  s6, r10
@// f2 ^= g2
vmov  r10, s2
eor   r10, r2
vmov  s2, r10
@// g5 ^= g9
 eor r5, r9
@// f1 ^= f3
vmov  r10, s1
vmov  r11, s3
eor   r10, r11
vmov  s1, r10
@// f24 ^= f28
vmov  r10, s24
vmov  r11, s28
eor   r10, r11
vmov  s24, r10
@// g2 ^= f6
vmov r11, s6
eor  r2, r11
@// g4 ^= g8
 eor r4, r8
@// g6 ^= f21
vmov r11, s21
eor  r6, r11
@// f16 ^= f20
vmov  r10, s16
vmov  r11, s20
eor   r10, r11
vmov  s16, r10
@// f3 ^= g0
vmov  r10, s3
eor   r10, r0
vmov  s3, r10
@// g0 ^= f2
vmov r11, s2
eor  r0, r11
@// f14 ^= f20
vmov  r10, s14
vmov  r11, s20
eor   r10, r11
vmov  s14, r10
@// f9 ^= g6
vmov  r10, s9
eor   r10, r6
vmov  s9, r10
str  r0, [r14, #0]
vstr.32  s1, [r14, #4]
vstr.32  s2, [r14, #8]
vstr.32  s3, [r14, #12]
str  r1, [r14, #16]
str  r2, [r14, #20]
vstr.32  s6, [r14, #24]
vstr.32  s7, [r14, #28]
str  r3, [r14, #32]
vstr.32  s9, [r14, #36]
str  r4, [r14, #40]
str  r5, [r14, #44]
vstr.32  s12, [r14, #48]
vstr.32  s13, [r14, #52]
vstr.32  s14, [r14, #56]
str  r6, [r14, #60]
vstr.32  s16, [r14, #64]
str  r7, [r14, #68]
str  r8, [r14, #72]
str  r9, [r14, #76]
vstr.32  s20, [r14, #80]
vstr.32  s21, [r14, #84]
vstr.32  s22, [r14, #88]
vstr.32  s23, [r14, #92]
vstr.32  s24, [r14, #96]
vstr.32  s25, [r14, #100]
vstr.32  s26, [r14, #104]
vstr.32  s27, [r14, #108]
vstr.32  s28, [r14, #112]
vstr.32  s29, [r14, #116]
vstr.32  s30, [r14, #120]
vstr.32  s31, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v22, .-gft_mul_v22
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v23
.type gft_mul_v23, %function
.align 2
gft_mul_v23:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{1, 2, 3, 5, 10, 12, 13, 14, 24, 25, 30, 31}, {0, 1, 2, 4, 5, 11, 12, 15, 24, 30}, {1, 7, 8, 9, 10, 11, 12, 13, 26, 27, 29, 31}, {0, 1, 6, 7, 8, 10, 12, 26, 28, 29, 30, 31}, {0, 1, 2, 4, 7, 8, 9, 11, 12, 13, 14, 15, 24, 29}, {0, 3, 5, 6, 7, 8, 10, 11, 12, 14, 25, 28, 29}, {0, 1, 4, 8, 11, 13, 14, 26, 31}, {0, 5, 9, 10, 11, 12, 13, 15, 27, 30, 31}, {0, 2, 3, 5, 8, 9, 16, 17, 20, 23, 24, 25, 28, 31}, {1, 2, 4, 5, 8, 16, 21, 22, 23, 24, 29, 30, 31}, {1, 2, 3, 7, 10, 11, 18, 19, 20, 26, 27, 28}, {0, 1, 2, 6, 7, 10, 18, 21, 26, 29}, {0, 1, 2, 5, 7, 12, 13, 16, 18, 19, 21, 22, 23, 24, 26, 27, 29, 30, 31}, {0, 3, 4, 5, 6, 7, 12, 17, 18, 20, 21, 22, 25, 26, 28, 29, 30}, {0, 1, 4, 6, 7, 14, 15, 17, 18, 19, 21, 25, 26, 27, 29}, {0, 5, 6, 14, 16, 17, 18, 20, 21, 24, 25, 26, 28, 29}, {1, 4, 7, 18, 19, 20, 21, 23, 26, 28, 29, 30}, {0, 1, 5, 6, 7, 18, 20, 22, 23, 27, 28, 31}, {3, 4, 17, 19, 20, 23, 24, 25, 26, 27, 28, 29}, {2, 3, 5, 16, 17, 18, 19, 21, 22, 23, 24, 26, 28}, {0, 2, 3, 4, 5, 6, 7, 17, 19, 21, 22, 24, 25, 27, 28, 29, 30, 31}, {1, 2, 4, 6, 16, 17, 18, 19, 20, 21, 23, 24, 26, 27, 28, 30}, {1, 2, 3, 5, 6, 16, 18, 19, 20, 21, 22, 24, 27, 29, 30}, {0, 1, 2, 4, 5, 7, 17, 18, 20, 23, 25, 26, 27, 28, 29, 31}, {9, 12, 15, 16, 18, 19, 21, 24, 28, 31}, {8, 9, 13, 14, 15, 17, 18, 20, 21, 25, 29, 30, 31}, {11, 12, 17, 18, 19, 23, 26, 28}, {10, 11, 13, 16, 17, 18, 22, 23, 27, 29}, {8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 21, 23, 24, 26, 27, 30, 31}, {9, 10, 12, 14, 16, 19, 20, 21, 22, 23, 25, 26, 30}, {9, 10, 11, 13, 14, 16, 17, 20, 22, 23, 25, 26, 27, 29, 31}, {8, 9, 10, 12, 13, 15, 16, 21, 22, 24, 25, 26, 28, 29, 30, 31}]

@ i = 0
@ better circuit found: #XORs = 247
@ better circuit found: #XORs = 244
@ i = 50
@ i = 100
@ i = 150
@ i = 200
@ i = 250
@ i = 300
@ i = 350
@ i = 400
@ i = 450
@ better circuit found: #XORs = 242
@ i = 500
@ i = 550
@ better circuit found: #XORs = 239
@ i = 600
@ i = 650
@ i = 700
@ i = 750
@ i = 800
@ i = 850
@ i = 900
@ i = 950

@ initial state: [{2, 8, 9, 11, 25, 28, 29}, {2, 3, 22, 26}, {7, 10, 12, 27, 28, 31}, {7, 9, 10, 11, 13}, {5, 30, 8, 10, 11, 29, 14}, {0, 4, 9, 14, 15, 28}, {1, 2, 13, 25, 26}, {5, 6, 7, 27, 15}, {17, 2, 5, 25, 27}, {8, 12, 13, 19, 23, 30}, {1, 3, 11, 24, 27}, {0, 1, 9, 18, 20}, {0, 6, 12, 30, 31}, {2, 13, 16, 17, 30}, {17, 18, 21, 10, 14}, {6, 9, 14, 16, 18, 24, 30}, {3, 7, 8, 12, 19, 20, 26}, {3, 12, 17, 18, 22, 28}, {0, 4, 9, 12, 25, 29}, {11, 18, 21, 28, 31}, {16, 29, 19, 4, 25, 13}, {16, 24, 25, 27, 31}, {5, 8, 15, 18, 19, 21}, {4, 7, 22, 26, 31}, {9, 10, 15, 22, 23, 24, 28, 30}, {15, 29, 31}, {12, 17, 19, 21, 23, 26, 31}, {1, 16, 17, 22, 23, 24, 29}, {0, 2, 12, 17, 22, 24}, {3, 10, 13, 18}, {0, 2, 13, 14, 31}, {17, 4, 8}]
@[0, 2, 3, 4, 5, 6, 7, 11, 14, 15, 16, 17, 18, 19, 21, 23, 24, 26, 27, 28, 29, 31, 1, 8, 9, 10, 12, 13, 20, 22, 25, 30]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 660)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #8]
ldr  r1, [r12, #32]
ldr  r2, [r12, #36]
ldr  r3, [r12, #44]
ldr  r4, [r12, #100]
ldr  r5, [r12, #112]
ldr  r6, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s0, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #12]
ldr  r2, [r12, #88]
ldr  r3, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s1, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #40]
ldr  r2, [r12, #48]
ldr  r3, [r12, #108]
ldr  r4, [r12, #112]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s2, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #36]
ldr  r2, [r12, #40]
ldr  r3, [r12, #44]
ldr  r4, [r12, #52]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s3, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #120]
ldr  r2, [r12, #32]
ldr  r3, [r12, #40]
ldr  r4, [r12, #44]
ldr  r5, [r12, #116]
ldr  r6, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s4, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #16]
ldr  r2, [r12, #36]
ldr  r3, [r12, #56]
ldr  r4, [r12, #60]
ldr  r5, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s5, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #8]
ldr  r2, [r12, #52]
ldr  r3, [r12, #100]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s6, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #24]
ldr  r2, [r12, #28]
ldr  r3, [r12, #108]
ldr  r4, [r12, #60]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s7, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #8]
ldr  r2, [r12, #20]
ldr  r3, [r12, #100]
ldr  r4, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s8, r0
ldr  r0, [r12, #32]
ldr  r1, [r12, #48]
ldr  r2, [r12, #52]
ldr  r3, [r12, #76]
ldr  r4, [r12, #92]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s9, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #12]
ldr  r2, [r12, #44]
ldr  r3, [r12, #96]
ldr  r4, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s10, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #36]
ldr  r3, [r12, #72]
ldr  r4, [r12, #80]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s11, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #24]
ldr  r2, [r12, #48]
ldr  r3, [r12, #120]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s12, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #52]
ldr  r2, [r12, #64]
ldr  r3, [r12, #68]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s13, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #72]
ldr  r2, [r12, #84]
ldr  r3, [r12, #40]
ldr  r4, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s14, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #36]
ldr  r2, [r12, #56]
ldr  r3, [r12, #64]
ldr  r4, [r12, #72]
ldr  r5, [r12, #96]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s15, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #28]
ldr  r2, [r12, #32]
ldr  r3, [r12, #48]
ldr  r4, [r12, #76]
ldr  r5, [r12, #80]
ldr  r6, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s16, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #48]
ldr  r2, [r12, #68]
ldr  r3, [r12, #72]
ldr  r4, [r12, #88]
ldr  r5, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s17, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #16]
ldr  r2, [r12, #36]
ldr  r3, [r12, #48]
ldr  r4, [r12, #100]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s18, r0
ldr  r0, [r12, #44]
ldr  r1, [r12, #72]
ldr  r2, [r12, #84]
ldr  r3, [r12, #112]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s19, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #116]
ldr  r2, [r12, #76]
ldr  r3, [r12, #16]
ldr  r4, [r12, #100]
ldr  r5, [r12, #52]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s20, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #96]
ldr  r2, [r12, #100]
ldr  r3, [r12, #108]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s21, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #32]
ldr  r2, [r12, #60]
ldr  r3, [r12, #72]
ldr  r4, [r12, #76]
ldr  r5, [r12, #84]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s22, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #28]
ldr  r2, [r12, #88]
ldr  r3, [r12, #104]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s23, r0
ldr  r0, [r12, #36]
ldr  r1, [r12, #40]
ldr  r2, [r12, #60]
ldr  r3, [r12, #88]
ldr  r4, [r12, #92]
ldr  r5, [r12, #96]
ldr  r6, [r12, #112]
ldr  r7, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s24, r0
ldr  r0, [r12, #60]
ldr  r1, [r12, #116]
ldr  r2, [r12, #124]
eor r0, r1
eor r0, r2
vmov  s25, r0
ldr  r0, [r12, #48]
ldr  r1, [r12, #68]
ldr  r2, [r12, #76]
ldr  r3, [r12, #84]
ldr  r4, [r12, #92]
ldr  r5, [r12, #104]
ldr  r6, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s26, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #64]
ldr  r2, [r12, #68]
ldr  r3, [r12, #88]
ldr  r4, [r12, #92]
ldr  r5, [r12, #96]
ldr  r6, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s27, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #8]
ldr  r2, [r12, #48]
ldr  r3, [r12, #68]
ldr  r4, [r12, #88]
ldr  r5, [r12, #96]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s28, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #40]
ldr  r2, [r12, #52]
ldr  r3, [r12, #72]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s29, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #8]
ldr  r2, [r12, #52]
ldr  r3, [r12, #56]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s30, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #16]
ldr  r2, [r12, #32]
eor r0, r1
eor r0, r2
vmov  s31, r0
vmov  r0, s1;
vmov  r1, s8;
vmov  r2, s9;
vmov  r3, s10;
vmov  r4, s12;
vmov  r5, s13;
vmov  r6, s20;
vmov  r7, s22;
vmov  r8, s25;
vmov  r9, s30;
@// f28 ^= g9
vmov  r10, s28
eor   r10, r9
vmov  s28, r10
@// f4 ^= f3
vmov  r10, s4
vmov  r11, s3
eor   r10, r11
vmov  s4, r10
@// g5 ^= g0
 eor r5, r0
@// g0 ^= f23
vmov r11, s23
eor  r0, r11
@// f17 ^= f14
vmov  r10, s17
vmov  r11, s14
eor   r10, r11
vmov  s17, r10
@// g0 ^= g8
 eor r0, r8
@// f18 ^= f11
vmov  r10, s18
vmov  r11, s11
eor   r10, r11
vmov  s18, r10
@// g9 ^= f6
vmov r11, s6
eor  r9, r11
@// f15 ^= f14
vmov  r10, s15
vmov  r11, s14
eor   r10, r11
vmov  s15, r10
@// g9 ^= f11
vmov r11, s11
eor  r9, r11
@// f11 ^= f14
vmov  r10, s11
vmov  r11, s14
eor   r10, r11
vmov  s11, r10
@// f14 ^= g1
vmov  r10, s14
eor   r10, r1
vmov  s14, r10
@// g1 ^= f7
vmov r11, s7
eor  r1, r11
@// f3 ^= f2
vmov  r10, s3
vmov  r11, s2
eor   r10, r11
vmov  s3, r10
@// f3 ^= g4
vmov  r10, s3
eor   r10, r4
vmov  s3, r10
@// g7 ^= f31
vmov r11, s31
eor  r7, r11
@// g1 ^= g8
 eor r1, r8
@// f5 ^= g8
vmov  r10, s5
eor   r10, r8
vmov  s5, r10
@// f27 ^= g3
vmov  r10, s27
eor   r10, r3
vmov  s27, r10
@// g8 ^= g4
 eor r8, r4
@// g4 ^= g2
 eor r4, r2
@// g2 ^= g6
 eor r2, r6
@// f31 ^= g6
vmov  r10, s31
eor   r10, r6
vmov  s31, r10
@// g6 ^= f6
vmov r11, s6
eor  r6, r11
@// g2 ^= f21
vmov r11, s21
eor  r2, r11
@// g2 ^= g3
 eor r2, r3
@// f16 ^= f26
vmov  r10, s16
vmov  r11, s26
eor   r10, r11
vmov  s16, r10
@// g6 ^= f18
vmov r11, s18
eor  r6, r11
@// f17 ^= f14
vmov  r10, s17
vmov  r11, s14
eor   r10, r11
vmov  s17, r10
@// f14 ^= g7
vmov  r10, s14
eor   r10, r7
vmov  s14, r10
@// f31 ^= g5
vmov  r10, s31
eor   r10, r5
vmov  s31, r10
@// g4 ^= f26
vmov r11, s26
eor  r4, r11
@// f11 ^= g9
vmov  r10, s11
eor   r10, r9
vmov  s11, r10
@// f31 ^= f29
vmov  r10, s31
vmov  r11, s29
eor   r10, r11
vmov  s31, r10
@// f27 ^= f29
vmov  r10, s27
vmov  r11, s29
eor   r10, r11
vmov  s27, r10
@// f29 ^= g5
vmov  r10, s29
eor   r10, r5
vmov  s29, r10
@// f29 ^= f26
vmov  r10, s29
vmov  r11, s26
eor   r10, r11
vmov  s29, r10
@// f26 ^= f19
vmov  r10, s26
vmov  r11, s19
eor   r10, r11
vmov  s26, r10
@// f19 ^= f21
vmov  r10, s19
vmov  r11, s21
eor   r10, r11
vmov  s19, r10
@// f19 ^= f17
vmov  r10, s19
vmov  r11, s17
eor   r10, r11
vmov  s19, r10
@// g7 ^= f7
vmov r11, s7
eor  r7, r11
@// f17 ^= f6
vmov  r10, s17
vmov  r11, s6
eor   r10, r11
vmov  s17, r10
@// g5 ^= f23
vmov r11, s23
eor  r5, r11
@// f18 ^= g3
vmov  r10, s18
eor   r10, r3
vmov  s18, r10
@// g3 ^= f7
vmov r11, s7
eor  r3, r11
@// f7 ^= f2
vmov  r10, s7
vmov  r11, s2
eor   r10, r11
vmov  s7, r10
@// f2 ^= f5
vmov  r10, s2
vmov  r11, s5
eor   r10, r11
vmov  s2, r10
@// f5 ^= f0
vmov  r10, s5
vmov  r11, s0
eor   r10, r11
vmov  s5, r10
@// g6 ^= f21
vmov r11, s21
eor  r6, r11
@// f11 ^= g1
vmov  r10, s11
eor   r10, r1
vmov  s11, r10
@// f15 ^= g8
vmov  r10, s15
eor   r10, r8
vmov  s15, r10
@// f15 ^= f7
vmov  r10, s15
vmov  r11, s7
eor   r10, r11
vmov  s15, r10
@// g5 ^= f28
vmov r11, s28
eor  r5, r11
@// f6 ^= f5
vmov  r10, s6
vmov  r11, s5
eor   r10, r11
vmov  s6, r10
@// f5 ^= g0
vmov  r10, s5
eor   r10, r0
vmov  s5, r10
@// g0 ^= g3
 eor r0, r3
@// g3 ^= f7
vmov r11, s7
eor  r3, r11
@// f23 ^= g1
vmov  r10, s23
eor   r10, r1
vmov  s23, r10
@// f21 ^= g1
vmov  r10, s21
eor   r10, r1
vmov  s21, r10
@// g1 ^= f16
vmov r11, s16
eor  r1, r11
@// g0 ^= g8
 eor r0, r8
@// g8 ^= g4
 eor r8, r4
@// g4 ^= f16
vmov r11, s16
eor  r4, r11
@// f0 ^= f4
vmov  r10, s0
vmov  r11, s4
eor   r10, r11
vmov  s0, r10
@// g7 ^= f16
vmov r11, s16
eor  r7, r11
@// f24 ^= f29
vmov  r10, s24
vmov  r11, s29
eor   r10, r11
vmov  s24, r10
@// f16 ^= g2
vmov  r10, s16
eor   r10, r2
vmov  s16, r10
@// f18 ^= f26
vmov  r10, s18
vmov  r11, s26
eor   r10, r11
vmov  s18, r10
@// f17 ^= g4
vmov  r10, s17
eor   r10, r4
vmov  s17, r10
@// f16 ^= f26
vmov  r10, s16
vmov  r11, s26
eor   r10, r11
vmov  s16, r10
@// f0 ^= g3
vmov  r10, s0
eor   r10, r3
vmov  s0, r10
@// g3 ^= g6
 eor r3, r6
@// f2 ^= f6
vmov  r10, s2
vmov  r11, s6
eor   r10, r11
vmov  s2, r10
@// g2 ^= f19
vmov r11, s19
eor  r2, r11
@// f5 ^= f7
vmov  r10, s5
vmov  r11, s7
eor   r10, r11
vmov  s5, r10
@// g1 ^= f15
vmov r11, s15
eor  r1, r11
@// f15 ^= g9
vmov  r10, s15
eor   r10, r9
vmov  s15, r10
@// f29 ^= g9
vmov  r10, s29
eor   r10, r9
vmov  s29, r10
@// f7 ^= f3
vmov  r10, s7
vmov  r11, s3
eor   r10, r11
vmov  s7, r10
@// f19 ^= f26
vmov  r10, s19
vmov  r11, s26
eor   r10, r11
vmov  s19, r10
@// f28 ^= g8
vmov  r10, s28
eor   r10, r8
vmov  s28, r10
@// f3 ^= f2
vmov  r10, s3
vmov  r11, s2
eor   r10, r11
vmov  s3, r10
@// g8 ^= g9
 eor r8, r9
@// g7 ^= g2
 eor r7, r2
@// f28 ^= f27
vmov  r10, s28
vmov  r11, s27
eor   r10, r11
vmov  s28, r10
@// f4 ^= g0
vmov  r10, s4
eor   r10, r0
vmov  s4, r10
@// f31 ^= f24
vmov  r10, s31
vmov  r11, s24
eor   r10, r11
vmov  s31, r10
@// f14 ^= f11
vmov  r10, s14
vmov  r11, s11
eor   r10, r11
vmov  s14, r10
@// f23 ^= f17
vmov  r10, s23
vmov  r11, s17
eor   r10, r11
vmov  s23, r10
@// g5 ^= f15
vmov r11, s15
eor  r5, r11
@// g9 ^= f27
vmov r11, s27
eor  r9, r11
@// f21 ^= f16
vmov  r10, s21
vmov  r11, s16
eor   r10, r11
vmov  s21, r10
@// g6 ^= g5
 eor r6, r5
@// g4 ^= g7
 eor r4, r7
vstr.32  s0, [r14, #0]
str  r0, [r14, #4]
vstr.32  s2, [r14, #8]
vstr.32  s3, [r14, #12]
vstr.32  s4, [r14, #16]
vstr.32  s5, [r14, #20]
vstr.32  s6, [r14, #24]
vstr.32  s7, [r14, #28]
str  r1, [r14, #32]
str  r2, [r14, #36]
str  r3, [r14, #40]
vstr.32  s11, [r14, #44]
str  r4, [r14, #48]
str  r5, [r14, #52]
vstr.32  s14, [r14, #56]
vstr.32  s15, [r14, #60]
vstr.32  s16, [r14, #64]
vstr.32  s17, [r14, #68]
vstr.32  s18, [r14, #72]
vstr.32  s19, [r14, #76]
str  r6, [r14, #80]
vstr.32  s21, [r14, #84]
str  r7, [r14, #88]
vstr.32  s23, [r14, #92]
vstr.32  s24, [r14, #96]
str  r8, [r14, #100]
vstr.32  s26, [r14, #104]
vstr.32  s27, [r14, #108]
vstr.32  s28, [r14, #112]
vstr.32  s29, [r14, #116]
str  r9, [r14, #120]
vstr.32  s31, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v23, .-gft_mul_v23
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v24
.type gft_mul_v24, %function
.align 2
gft_mul_v24:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{0, 2, 4, 6, 8, 10, 14, 15, 17, 18, 21, 22, 24, 25, 26}, {1, 3, 5, 7, 9, 11, 14, 16, 17, 19, 20, 21, 23, 24, 27}, {0, 1, 3, 4, 5, 7, 8, 9, 11, 13, 15, 16, 17, 18, 20, 21, 22, 24, 25}, {0, 2, 3, 4, 6, 7, 8, 10, 11, 12, 13, 14, 15, 16, 19, 20, 23, 24}, {2, 3, 4, 7, 8, 14, 16, 18, 20, 21, 28, 29, 30}, {2, 5, 6, 7, 9, 15, 17, 19, 20, 28, 31}, {1, 3, 4, 10, 12, 13, 14, 15, 16, 17, 19, 22, 23, 28, 29}, {0, 1, 2, 3, 5, 11, 12, 14, 16, 18, 19, 22, 28}, {0, 1, 2, 3, 6, 7, 9, 11, 12, 15, 17, 19, 20, 21, 23, 26, 27, 28, 30, 31}, {0, 2, 6, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 22, 23, 26, 29, 30}, {1, 2, 5, 7, 8, 10, 11, 12, 16, 18, 19, 20, 23, 25, 27, 29, 30, 31}, {0, 1, 3, 4, 5, 6, 7, 9, 10, 13, 17, 18, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30}, {0, 5, 6, 7, 8, 10, 11, 12, 13, 14, 17, 19, 24, 25, 26, 27, 28, 29}, {1, 4, 5, 6, 9, 10, 12, 15, 16, 17, 18, 19, 24, 26, 28}, {2, 5, 9, 10, 11, 12, 13, 16, 18, 19, 25, 26, 30, 31}, {3, 4, 5, 8, 9, 10, 12, 17, 18, 24, 25, 27, 30}, {0, 1, 2, 6, 12, 14, 17, 20, 24, 26, 28, 31}, {0, 3, 7, 13, 15, 16, 17, 21, 25, 27, 29, 30, 31}, {0, 1, 4, 5, 6, 7, 12, 13, 15, 19, 22, 24, 25, 27, 28}, {0, 4, 6, 12, 14, 15, 18, 19, 23, 24, 26, 27, 29}, {1, 4, 6, 10, 11, 14, 15, 17, 18, 19, 22, 23, 24, 26, 27, 31}, {0, 1, 5, 7, 10, 14, 16, 17, 18, 22, 25, 26, 30, 31}, {3, 4, 5, 7, 9, 11, 13, 15, 17, 21, 23, 25, 26, 27, 28, 30}, {2, 3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 20, 21, 22, 23, 24, 25, 26, 29, 31}, {0, 9, 10, 14, 17, 18, 19, 22, 23, 26, 27, 28, 30, 31}, {1, 8, 9, 11, 15, 16, 17, 18, 22, 26, 29, 30}, {2, 8, 9, 10, 12, 13, 14, 15, 17, 21, 23, 25, 27, 29, 30, 31}, {3, 8, 11, 12, 14, 16, 17, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30}, {4, 9, 14, 16, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29}, {5, 8, 9, 15, 17, 20, 22, 24, 26, 28}, {6, 11, 12, 13, 14, 15, 18, 21, 22, 25, 26, 30, 31}, {7, 10, 11, 12, 14, 19, 20, 21, 23, 24, 25, 27, 30}]

@ i = 0
@ better circuit found: #XORs = 263
@ better circuit found: #XORs = 262
@ better circuit found: #XORs = 258
@ better circuit found: #XORs = 250
@ i = 50
@ i = 100
@ i = 150
@ i = 200
@ i = 250
@ i = 300
@ i = 350
@ i = 400
@ better circuit found: #XORs = 249
@ i = 450
@ i = 500
@ better circuit found: #XORs = 248
@ i = 550
@ i = 600
@ i = 650
@ i = 700
@ i = 750
@ i = 800
@ i = 850
@ i = 900
@ i = 950

@ initial state: [{6, 7, 18, 19, 24, 31}, {1, 4, 8, 16, 18, 24, 27}, {0, 9, 11, 19, 27, 29}, {0, 5, 16, 28}, {5, 21, 7, 8, 9, 11}, {2, 18, 22, 8, 26}, {5, 13, 22, 28}, {1, 2, 14, 25}, {6, 11, 12, 21, 22, 29}, {7, 8, 23, 27, 29}, {6, 13, 17, 21, 27, 29}, {5, 21, 15, 31}, {0, 4, 8, 12, 14, 15, 26, 31}, {3, 5, 6, 20}, {16, 23, 10, 31}, {5, 10, 11, 18, 24, 25, 27}, {2, 6, 10, 11, 28, 29}, {1, 9, 13, 20, 26}, {5, 6, 9, 17, 19, 22, 24, 27}, {7, 17, 19, 25, 28}, {0, 1, 6, 10, 17, 21, 31}, {2, 3, 4, 7, 9, 15, 26}, {4, 5, 12, 13, 24, 25, 30}, {12, 13, 21, 25, 26, 31}, {0, 1, 7, 8, 14, 24, 30}, {4, 9, 10, 14, 16, 18, 30}, {2, 5, 16, 22, 23, 25}, {3, 4, 8, 9, 11, 12, 17, 30}, {14, 20, 22, 24, 26}, {5, 8, 9, 14, 15, 17, 28}, {3, 11, 12, 18, 19, 22, 25}, {3, 14, 17, 19, 26, 29}]
@[1, 2, 4, 5, 6, 7, 9, 10, 11, 15, 16, 18, 19, 20, 21, 22, 23, 25, 27, 29, 30, 31, 0, 3, 8, 12, 13, 14, 17, 24, 26, 28]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 671)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #24]
ldr  r1, [r12, #28]
ldr  r2, [r12, #72]
ldr  r3, [r12, #76]
ldr  r4, [r12, #96]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s0, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #16]
ldr  r2, [r12, #32]
ldr  r3, [r12, #64]
ldr  r4, [r12, #72]
ldr  r5, [r12, #96]
ldr  r6, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s1, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #36]
ldr  r2, [r12, #44]
ldr  r3, [r12, #76]
ldr  r4, [r12, #108]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s2, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #20]
ldr  r2, [r12, #64]
ldr  r3, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s3, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #84]
ldr  r2, [r12, #28]
ldr  r3, [r12, #32]
ldr  r4, [r12, #36]
ldr  r5, [r12, #44]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s4, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #72]
ldr  r2, [r12, #88]
ldr  r3, [r12, #32]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s5, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #52]
ldr  r2, [r12, #88]
ldr  r3, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s6, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #8]
ldr  r2, [r12, #56]
ldr  r3, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s7, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #44]
ldr  r2, [r12, #48]
ldr  r3, [r12, #84]
ldr  r4, [r12, #88]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s8, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #32]
ldr  r2, [r12, #92]
ldr  r3, [r12, #108]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s9, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #52]
ldr  r2, [r12, #68]
ldr  r3, [r12, #84]
ldr  r4, [r12, #108]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s10, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #84]
ldr  r2, [r12, #60]
ldr  r3, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s11, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #16]
ldr  r2, [r12, #32]
ldr  r3, [r12, #48]
ldr  r4, [r12, #56]
ldr  r5, [r12, #60]
ldr  r6, [r12, #104]
ldr  r7, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s12, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #20]
ldr  r2, [r12, #24]
ldr  r3, [r12, #80]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s13, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #92]
ldr  r2, [r12, #40]
ldr  r3, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s14, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #40]
ldr  r2, [r12, #44]
ldr  r3, [r12, #72]
ldr  r4, [r12, #96]
ldr  r5, [r12, #100]
ldr  r6, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s15, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #24]
ldr  r2, [r12, #40]
ldr  r3, [r12, #44]
ldr  r4, [r12, #112]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s16, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #36]
ldr  r2, [r12, #52]
ldr  r3, [r12, #80]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s17, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #24]
ldr  r2, [r12, #36]
ldr  r3, [r12, #68]
ldr  r4, [r12, #76]
ldr  r5, [r12, #88]
ldr  r6, [r12, #96]
ldr  r7, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s18, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #68]
ldr  r2, [r12, #76]
ldr  r3, [r12, #100]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s19, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #24]
ldr  r3, [r12, #40]
ldr  r4, [r12, #68]
ldr  r5, [r12, #84]
ldr  r6, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s20, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #12]
ldr  r2, [r12, #16]
ldr  r3, [r12, #28]
ldr  r4, [r12, #36]
ldr  r5, [r12, #60]
ldr  r6, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s21, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #20]
ldr  r2, [r12, #48]
ldr  r3, [r12, #52]
ldr  r4, [r12, #96]
ldr  r5, [r12, #100]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s22, r0
ldr  r0, [r12, #48]
ldr  r1, [r12, #52]
ldr  r2, [r12, #84]
ldr  r3, [r12, #100]
ldr  r4, [r12, #104]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s23, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #28]
ldr  r3, [r12, #32]
ldr  r4, [r12, #56]
ldr  r5, [r12, #96]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s24, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #36]
ldr  r2, [r12, #40]
ldr  r3, [r12, #56]
ldr  r4, [r12, #64]
ldr  r5, [r12, #72]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s25, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #20]
ldr  r2, [r12, #64]
ldr  r3, [r12, #88]
ldr  r4, [r12, #92]
ldr  r5, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s26, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #16]
ldr  r2, [r12, #32]
ldr  r3, [r12, #36]
ldr  r4, [r12, #44]
ldr  r5, [r12, #48]
ldr  r6, [r12, #68]
ldr  r7, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s27, r0
ldr  r0, [r12, #56]
ldr  r1, [r12, #80]
ldr  r2, [r12, #88]
ldr  r3, [r12, #96]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s28, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #32]
ldr  r2, [r12, #36]
ldr  r3, [r12, #56]
ldr  r4, [r12, #60]
ldr  r5, [r12, #68]
ldr  r6, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s29, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #44]
ldr  r2, [r12, #48]
ldr  r3, [r12, #72]
ldr  r4, [r12, #76]
ldr  r5, [r12, #88]
ldr  r6, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s30, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #56]
ldr  r2, [r12, #68]
ldr  r3, [r12, #76]
ldr  r4, [r12, #104]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s31, r0
vmov  r0, s0;
vmov  r1, s3;
vmov  r2, s8;
vmov  r3, s12;
vmov  r4, s13;
vmov  r5, s14;
vmov  r6, s17;
vmov  r7, s24;
vmov  r8, s26;
vmov  r9, s28;
@// f21 ^= f5
vmov  r10, s21
vmov  r11, s5
eor   r10, r11
vmov  s21, r10
@// g5 ^= g8
 eor r5, r8
@// g8 ^= f5
vmov r11, s5
eor  r8, r11
@// f5 ^= g9
vmov  r10, s5
eor   r10, r9
vmov  s5, r10
@// f22 ^= g1
vmov  r10, s22
eor   r10, r1
vmov  s22, r10
@// f7 ^= g1
vmov  r10, s7
eor   r10, r1
vmov  s7, r10
@// g1 ^= f29
vmov r11, s29
eor  r1, r11
@// g1 ^= g7
 eor r1, r7
@// f5 ^= g0
vmov  r10, s5
eor   r10, r0
vmov  s5, r10
@// g0 ^= f19
vmov r11, s19
eor  r0, r11
@// f31 ^= f19
vmov  r10, s31
vmov  r11, s19
eor   r10, r11
vmov  s31, r10
@// f2 ^= f10
vmov  r10, s2
vmov  r11, s10
eor   r10, r11
vmov  s2, r10
@// f10 ^= f20
vmov  r10, s10
vmov  r11, s20
eor   r10, r11
vmov  s10, r10
@// f6 ^= g8
vmov  r10, s6
eor   r10, r8
vmov  s6, r10
@// f6 ^= f30
vmov  r10, s6
vmov  r11, s30
eor   r10, r11
vmov  s6, r10
@// f31 ^= g9
vmov  r10, s31
eor   r10, r9
vmov  s31, r10
@// g7 ^= f9
vmov r11, s9
eor  r7, r11
@// f31 ^= f30
vmov  r10, s31
vmov  r11, s30
eor   r10, r11
vmov  s31, r10
@// f19 ^= f9
vmov  r10, s19
vmov  r11, s9
eor   r10, r11
vmov  s19, r10
@// f9 ^= f10
vmov  r10, s9
vmov  r11, s10
eor   r10, r11
vmov  s9, r10
@// f10 ^= g6
vmov  r10, s10
eor   r10, r6
vmov  s10, r10
@// f19 ^= g0
vmov  r10, s19
eor   r10, r0
vmov  s19, r10
@// g0 ^= f20
vmov r11, s20
eor  r0, r11
@// f20 ^= g2
vmov  r10, s20
eor   r10, r2
vmov  s20, r10
@// f23 ^= g2
vmov  r10, s23
eor   r10, r2
vmov  s23, r10
@// g2 ^= g4
 eor r2, r4
@// g2 ^= g9
 eor r2, r9
@// f11 ^= g5
vmov  r10, s11
eor   r10, r5
vmov  s11, r10
@// g8 ^= g5
 eor r8, r5
@// g5 ^= f15
vmov r11, s15
eor  r5, r11
@// f1 ^= f15
vmov  r10, s1
vmov  r11, s15
eor   r10, r11
vmov  s1, r10
@// g2 ^= g7
 eor r2, r7
@// g7 ^= g0
 eor r7, r0
@// f23 ^= f2
vmov  r10, s23
vmov  r11, s2
eor   r10, r11
vmov  s23, r10
@// f7 ^= g4
vmov  r10, s7
eor   r10, r4
vmov  s7, r10
@// f21 ^= g3
vmov  r10, s21
eor   r10, r3
vmov  s21, r10
@// g6 ^= g4
 eor r6, r4
@// f22 ^= g1
vmov  r10, s22
eor   r10, r1
vmov  s22, r10
@// f10 ^= f9
vmov  r10, s10
vmov  r11, s9
eor   r10, r11
vmov  s10, r10
@// f4 ^= g4
vmov  r10, s4
eor   r10, r4
vmov  s4, r10
@// f9 ^= f5
vmov  r10, s9
vmov  r11, s5
eor   r10, r11
vmov  s9, r10
@// g6 ^= f18
vmov r11, s18
eor  r6, r11
@// g8 ^= f21
vmov r11, s21
eor  r8, r11
@// g5 ^= g6
 eor r5, r6
@// g6 ^= g1
 eor r6, r1
@// g4 ^= f30
vmov r11, s30
eor  r4, r11
@// f30 ^= f27
vmov  r10, s30
vmov  r11, s27
eor   r10, r11
vmov  s30, r10
@// f30 ^= f2
vmov  r10, s30
vmov  r11, s2
eor   r10, r11
vmov  s30, r10
@// g6 ^= f23
vmov r11, s23
eor  r6, r11
@// f7 ^= g4
vmov  r10, s7
eor   r10, r4
vmov  s7, r10
@// f2 ^= g4
vmov  r10, s2
eor   r10, r4
vmov  s2, r10
@// g4 ^= f1
vmov r11, s1
eor  r4, r11
@// f4 ^= f16
vmov  r10, s4
vmov  r11, s16
eor   r10, r11
vmov  s4, r10
@// f1 ^= f27
vmov  r10, s1
vmov  r11, s27
eor   r10, r11
vmov  s1, r10
@// f30 ^= g3
vmov  r10, s30
eor   r10, r3
vmov  s30, r10
@// g1 ^= f27
vmov r11, s27
eor  r1, r11
@// g0 ^= f16
vmov r11, s16
eor  r0, r11
@// f4 ^= f25
vmov  r10, s4
vmov  r11, s25
eor   r10, r11
vmov  s4, r10
@// f5 ^= f29
vmov  r10, s5
vmov  r11, s29
eor   r10, r11
vmov  s5, r10
@// f19 ^= g3
vmov  r10, s19
eor   r10, r3
vmov  s19, r10
@// g3 ^= f20
vmov r11, s20
eor  r3, r11
@// f29 ^= g9
vmov  r10, s29
eor   r10, r9
vmov  s29, r10
@// f16 ^= f20
vmov  r10, s16
vmov  r11, s20
eor   r10, r11
vmov  s16, r10
@// f16 ^= g9
vmov  r10, s16
eor   r10, r9
vmov  s16, r10
@// g9 ^= f25
vmov r11, s25
eor  r9, r11
@// g9 ^= g7
 eor r9, r7
@// f31 ^= g7
vmov  r10, s31
eor   r10, r7
vmov  s31, r10
@// f21 ^= f1
vmov  r10, s21
vmov  r11, s1
eor   r10, r11
vmov  s21, r10
@// g7 ^= f23
vmov r11, s23
eor  r7, r11
@// f11 ^= g0
vmov  r10, s11
eor   r10, r0
vmov  s11, r10
@// g5 ^= f1
vmov r11, s1
eor  r5, r11
@// g4 ^= f29
vmov r11, s29
eor  r4, r11
@// f25 ^= g3
vmov  r10, s25
eor   r10, r3
vmov  s25, r10
@// g8 ^= g6
 eor r8, r6
@// f1 ^= f31
vmov  r10, s1
vmov  r11, s31
eor   r10, r11
vmov  s1, r10
@// g0 ^= g3
 eor r0, r3
@// f18 ^= f22
vmov  r10, s18
vmov  r11, s22
eor   r10, r11
vmov  s18, r10
@// f22 ^= g2
vmov  r10, s22
eor   r10, r2
vmov  s22, r10
@// f6 ^= g3
vmov  r10, s6
eor   r10, r3
vmov  s6, r10
@// f15 ^= f27
vmov  r10, s15
vmov  r11, s27
eor   r10, r11
vmov  s15, r10
@// f20 ^= f19
vmov  r10, s20
vmov  r11, s19
eor   r10, r11
vmov  s20, r10
@// g3 ^= f18
vmov r11, s18
eor  r3, r11
@// f2 ^= g1
vmov  r10, s2
eor   r10, r1
vmov  s2, r10
@// g1 ^= f9
vmov r11, s9
eor  r1, r11
@// f10 ^= g5
vmov  r10, s10
eor   r10, r5
vmov  s10, r10
@// g2 ^= f5
vmov r11, s5
eor  r2, r11
@// f27 ^= g9
vmov  r10, s27
eor   r10, r9
vmov  s27, r10
@// f9 ^= f25
vmov  r10, s9
vmov  r11, s25
eor   r10, r11
vmov  s9, r10
@// f11 ^= f22
vmov  r10, s11
vmov  r11, s22
eor   r10, r11
vmov  s11, r10
@// f23 ^= g1
vmov  r10, s23
eor   r10, r1
vmov  s23, r10
str  r0, [r14, #0]
vstr.32  s1, [r14, #4]
vstr.32  s2, [r14, #8]
str  r1, [r14, #12]
vstr.32  s4, [r14, #16]
vstr.32  s5, [r14, #20]
vstr.32  s6, [r14, #24]
vstr.32  s7, [r14, #28]
str  r2, [r14, #32]
vstr.32  s9, [r14, #36]
vstr.32  s10, [r14, #40]
vstr.32  s11, [r14, #44]
str  r3, [r14, #48]
str  r4, [r14, #52]
str  r5, [r14, #56]
vstr.32  s15, [r14, #60]
vstr.32  s16, [r14, #64]
str  r6, [r14, #68]
vstr.32  s18, [r14, #72]
vstr.32  s19, [r14, #76]
vstr.32  s20, [r14, #80]
vstr.32  s21, [r14, #84]
vstr.32  s22, [r14, #88]
vstr.32  s23, [r14, #92]
str  r7, [r14, #96]
vstr.32  s25, [r14, #100]
str  r8, [r14, #104]
vstr.32  s27, [r14, #108]
str  r9, [r14, #112]
vstr.32  s29, [r14, #116]
vstr.32  s30, [r14, #120]
vstr.32  s31, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v24, .-gft_mul_v24
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v25
.type gft_mul_v25, %function
.align 2
gft_mul_v25:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{0, 4, 7, 11, 13, 15, 16, 17, 19, 20, 21, 23, 27, 28, 30, 31}, {1, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 18, 19, 20, 22, 23, 26, 27, 29, 30}, {2, 4, 8, 10, 12, 14, 15, 16, 19, 20, 23, 24, 26, 29, 30, 31}, {3, 5, 9, 11, 13, 14, 17, 18, 19, 21, 22, 23, 25, 27, 28, 29, 30}, {0, 2, 3, 6, 7, 10, 14, 15, 17, 19, 20, 24, 25, 26, 27, 28, 29, 30}, {1, 2, 6, 11, 14, 16, 17, 18, 19, 21, 24, 26, 28, 31}, {1, 2, 3, 5, 7, 8, 9, 10, 11, 13, 15, 16, 18, 19, 22, 25, 26, 28, 29}, {0, 1, 2, 4, 5, 6, 7, 8, 10, 12, 13, 14, 15, 17, 18, 23, 24, 25, 27, 28}, {0, 1, 3, 4, 5, 9, 11, 13, 15, 16, 20, 21, 25, 27, 31}, {0, 2, 3, 4, 8, 9, 10, 11, 12, 13, 14, 15, 17, 20, 24, 25, 26, 27, 30, 31}, {0, 3, 6, 7, 8, 10, 11, 12, 14, 15, 18, 22, 23, 24, 26, 27, 28, 30}, {1, 2, 3, 6, 9, 10, 13, 14, 19, 22, 25, 26, 29, 31}, {0, 3, 5, 10, 13, 14, 15, 16, 19, 23, 24, 25, 28, 31}, {1, 2, 3, 4, 5, 11, 12, 13, 14, 17, 18, 19, 22, 23, 24, 29, 30, 31}, {0, 7, 8, 9, 10, 11, 13, 16, 20, 22, 26, 27, 28}, {1, 6, 7, 8, 10, 12, 13, 17, 21, 23, 26, 29}, {0, 3, 5, 6, 7, 13, 15, 19, 20, 21, 22, 27}, {1, 2, 3, 4, 5, 6, 12, 13, 14, 15, 18, 19, 20, 23, 26, 27}, {0, 5, 12, 14, 15, 16, 18, 20, 21, 24, 26}, {1, 4, 5, 13, 14, 17, 19, 20, 25, 27}, {1, 2, 4, 5, 6, 7, 10, 14, 16, 17, 19, 20, 21, 31}, {0, 1, 3, 4, 6, 11, 15, 16, 18, 19, 20, 30, 31}, {0, 1, 2, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19, 22, 23, 28, 30}, {0, 3, 4, 5, 7, 8, 10, 12, 14, 17, 18, 19, 22, 29, 31}, {1, 8, 9, 11, 13, 14, 15, 16, 19, 20, 21, 24, 30}, {0, 1, 8, 10, 11, 12, 13, 14, 17, 18, 19, 20, 25, 31}, {3, 8, 11, 13, 16, 22, 23, 26, 28, 29, 30, 31}, {2, 3, 9, 10, 11, 12, 13, 17, 22, 27, 28, 30}, {5, 9, 10, 12, 14, 15, 16, 19, 25, 28, 29}, {4, 5, 8, 9, 11, 13, 14, 17, 18, 19, 24, 25, 28}, {7, 8, 9, 10, 13, 14, 15, 16, 27, 30, 31}, {6, 7, 8, 11, 12, 13, 14, 17, 26, 27, 30}]

@ i = 0
@ better circuit found: #XORs = 260
@ better circuit found: #XORs = 257
@ better circuit found: #XORs = 252
@ i = 50
@ better circuit found: #XORs = 251
@ i = 100
@ i = 150
@ i = 200
@ i = 250
@ i = 300
@ i = 350
@ i = 400
@ i = 450
@ i = 500
@ i = 550
@ i = 600
@ i = 650
@ i = 700
@ i = 750
@ i = 800
@ i = 850
@ i = 900
@ i = 950

@ initial state: [{0, 1, 3, 9, 21, 23}, {0, 2, 4, 7, 10, 16, 28, 31}, {3, 24, 28, 31, 14}, {1, 8, 21, 23, 26, 27, 30}, {2, 7, 8, 13, 14, 29, 30}, {1, 6, 15, 23, 24}, {8, 11, 14, 25, 31}, {0, 3, 5, 11, 17, 25, 28}, {5, 14, 15, 21, 25, 30}, {4, 8, 18, 28}, {4, 23, 24, 12, 31}, {19}, {18, 7, 9, 14}, {17, 21, 22, 28, 30}, {4, 6, 14, 20, 22, 23}, {26, 25, 10, 29, 31}, {7, 8, 11, 20, 21, 24, 28}, {5, 6, 12, 17}, {10, 5, 21, 26, 28}, {6, 7, 13, 15, 27}, {13, 10, 8, 25}, {3, 10, 12, 16, 18, 31}, {7, 12, 22, 24, 25}, {3, 14, 15, 20, 26, 29}, {0, 12, 14, 16, 18, 25}, {0, 9, 15, 17, 18, 28}, {2, 9, 11, 23, 26}, {4, 15, 16, 23, 27, 28}, {6, 10, 12, 29}, {1, 3, 7, 14, 20, 25, 27}, {30, 23, 11, 14}, {5, 23, 9, 27, 29}]
@[0, 1, 2, 3, 4, 7, 8, 10, 12, 14, 15, 16, 18, 21, 22, 24, 26, 27, 28, 29, 30, 31, 5, 6, 9, 11, 13, 17, 19, 20, 23, 25]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 692)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #12]
ldr  r3, [r12, #36]
ldr  r4, [r12, #84]
ldr  r5, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s0, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #8]
ldr  r2, [r12, #16]
ldr  r3, [r12, #28]
ldr  r4, [r12, #40]
ldr  r5, [r12, #64]
ldr  r6, [r12, #112]
ldr  r7, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s1, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #96]
ldr  r2, [r12, #112]
ldr  r3, [r12, #124]
ldr  r4, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s2, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #32]
ldr  r2, [r12, #84]
ldr  r3, [r12, #92]
ldr  r4, [r12, #104]
ldr  r5, [r12, #108]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s3, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #28]
ldr  r2, [r12, #32]
ldr  r3, [r12, #52]
ldr  r4, [r12, #56]
ldr  r5, [r12, #116]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s4, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #24]
ldr  r2, [r12, #60]
ldr  r3, [r12, #92]
ldr  r4, [r12, #96]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s5, r0
ldr  r0, [r12, #32]
ldr  r1, [r12, #44]
ldr  r2, [r12, #56]
ldr  r3, [r12, #100]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s6, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #12]
ldr  r2, [r12, #20]
ldr  r3, [r12, #44]
ldr  r4, [r12, #68]
ldr  r5, [r12, #100]
ldr  r6, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s7, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #56]
ldr  r2, [r12, #60]
ldr  r3, [r12, #84]
ldr  r4, [r12, #100]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s8, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #32]
ldr  r2, [r12, #72]
ldr  r3, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s9, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #92]
ldr  r2, [r12, #96]
ldr  r3, [r12, #48]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s10, r0
ldr  r0, [r12, #76]
vmov  s11, r0
ldr  r0, [r12, #72]
ldr  r1, [r12, #28]
ldr  r2, [r12, #36]
ldr  r3, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s12, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #84]
ldr  r2, [r12, #88]
ldr  r3, [r12, #112]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s13, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #24]
ldr  r2, [r12, #56]
ldr  r3, [r12, #80]
ldr  r4, [r12, #88]
ldr  r5, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s14, r0
ldr  r0, [r12, #104]
ldr  r1, [r12, #100]
ldr  r2, [r12, #40]
ldr  r3, [r12, #116]
ldr  r4, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s15, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #32]
ldr  r2, [r12, #44]
ldr  r3, [r12, #80]
ldr  r4, [r12, #84]
ldr  r5, [r12, #96]
ldr  r6, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s16, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #24]
ldr  r2, [r12, #48]
ldr  r3, [r12, #68]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s17, r0
ldr  r0, [r12, #40]
ldr  r1, [r12, #20]
ldr  r2, [r12, #84]
ldr  r3, [r12, #104]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s18, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #28]
ldr  r2, [r12, #52]
ldr  r3, [r12, #60]
ldr  r4, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s19, r0
ldr  r0, [r12, #52]
ldr  r1, [r12, #40]
ldr  r2, [r12, #32]
ldr  r3, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s20, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #40]
ldr  r2, [r12, #48]
ldr  r3, [r12, #64]
ldr  r4, [r12, #72]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s21, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #48]
ldr  r2, [r12, #88]
ldr  r3, [r12, #96]
ldr  r4, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s22, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #56]
ldr  r2, [r12, #60]
ldr  r3, [r12, #80]
ldr  r4, [r12, #104]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s23, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #48]
ldr  r2, [r12, #56]
ldr  r3, [r12, #64]
ldr  r4, [r12, #72]
ldr  r5, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s24, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #36]
ldr  r2, [r12, #60]
ldr  r3, [r12, #68]
ldr  r4, [r12, #72]
ldr  r5, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s25, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #36]
ldr  r2, [r12, #44]
ldr  r3, [r12, #92]
ldr  r4, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s26, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #60]
ldr  r2, [r12, #64]
ldr  r3, [r12, #92]
ldr  r4, [r12, #108]
ldr  r5, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s27, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #40]
ldr  r2, [r12, #48]
ldr  r3, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s28, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #12]
ldr  r2, [r12, #28]
ldr  r3, [r12, #56]
ldr  r4, [r12, #80]
ldr  r5, [r12, #100]
ldr  r6, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s29, r0
ldr  r0, [r12, #120]
ldr  r1, [r12, #92]
ldr  r2, [r12, #44]
ldr  r3, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s30, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #92]
ldr  r2, [r12, #36]
ldr  r3, [r12, #108]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s31, r0
vmov  r0, s5;
vmov  r1, s6;
vmov  r2, s9;
vmov  r3, s11;
vmov  r4, s13;
vmov  r5, s17;
vmov  r6, s19;
vmov  r7, s20;
vmov  r8, s23;
vmov  r9, s25;
@// g2 ^= g3
 eor r2, r3
@// f8 ^= g3
vmov  r10, s8
eor   r10, r3
vmov  s8, r10
@// f28 ^= g3
vmov  r10, s28
eor   r10, r3
vmov  s28, r10
@// f10 ^= f22
vmov  r10, s10
vmov  r11, s22
eor   r10, r11
vmov  s10, r10
@// f18 ^= f15
vmov  r10, s18
vmov  r11, s15
eor   r10, r11
vmov  s18, r10
@// f14 ^= g0
vmov  r10, s14
eor   r10, r0
vmov  s14, r10
@// f22 ^= g3
vmov  r10, s22
eor   r10, r3
vmov  s22, r10
@// g3 ^= g7
 eor r3, r7
@// g7 ^= f15
vmov r11, s15
eor  r7, r11
@// g7 ^= f18
vmov r11, s18
eor  r7, r11
@// g7 ^= f16
vmov r11, s16
eor  r7, r11
@// f15 ^= g1
vmov  r10, s15
eor   r10, r1
vmov  s15, r10
@// f21 ^= f28
vmov  r10, s21
vmov  r11, s28
eor   r10, r11
vmov  s21, r10
@// g2 ^= g3
 eor r2, r3
@// f16 ^= g4
vmov  r10, s16
eor   r10, r4
vmov  s16, r10
@// f29 ^= f2
vmov  r10, s29
vmov  r11, s2
eor   r10, r11
vmov  s29, r10
@// g0 ^= f30
vmov r11, s30
eor  r0, r11
@// g0 ^= f8
vmov r11, s8
eor  r0, r11
@// g0 ^= g3
 eor r0, r3
@// f8 ^= f12
vmov  r10, s8
vmov  r11, s12
eor   r10, r11
vmov  s8, r10
@// f8 ^= g6
vmov  r10, s8
eor   r10, r6
vmov  s8, r10
@// f4 ^= g6
vmov  r10, s4
eor   r10, r6
vmov  s4, r10
@// g4 ^= f18
vmov r11, s18
eor  r4, r11
@// g4 ^= f7
vmov r11, s7
eor  r4, r11
@// g1 ^= f12
vmov r11, s12
eor  r1, r11
@// f0 ^= g9
vmov  r10, s0
eor   r10, r9
vmov  s0, r10
@// f0 ^= g6
vmov  r10, s0
eor   r10, r6
vmov  s0, r10
@// g6 ^= g5
 eor r6, r5
@// f12 ^= g9
vmov  r10, s12
eor   r10, r9
vmov  s12, r10
@// g5 ^= g9
 eor r5, r9
@// g9 ^= g2
 eor r9, r2
@// g9 ^= g6
 eor r9, r6
@// f18 ^= f2
vmov  r10, s18
vmov  r11, s2
eor   r10, r11
vmov  s18, r10
@// f18 ^= f24
vmov  r10, s18
vmov  r11, s24
eor   r10, r11
vmov  s18, r10
@// f24 ^= g5
vmov  r10, s24
eor   r10, r5
vmov  s24, r10
@// g5 ^= f7
vmov r11, s7
eor  r5, r11
@// f16 ^= g1
vmov  r10, s16
eor   r10, r1
vmov  s16, r10
@// f7 ^= g3
vmov  r10, s7
eor   r10, r3
vmov  s7, r10
@// g3 ^= f15
vmov r11, s15
eor  r3, r11
@// g3 ^= f26
vmov r11, s26
eor  r3, r11
@// f31 ^= g6
vmov  r10, s31
eor   r10, r6
vmov  s31, r10
@// g6 ^= f22
vmov r11, s22
eor  r6, r11
@// g6 ^= f14
vmov r11, s14
eor  r6, r11
@// f12 ^= f2
vmov  r10, s12
vmov  r11, s2
eor   r10, r11
vmov  s12, r10
@// f29 ^= g1
vmov  r10, s29
eor   r10, r1
vmov  s29, r10
@// f21 ^= f2
vmov  r10, s21
vmov  r11, s2
eor   r10, r11
vmov  s21, r10
@// g0 ^= f28
vmov r11, s28
eor  r0, r11
@// f16 ^= f12
vmov  r10, s16
vmov  r11, s12
eor   r10, r11
vmov  s16, r10
@// g5 ^= f26
vmov r11, s26
eor  r5, r11
@// f2 ^= g8
vmov  r10, s2
eor   r10, r8
vmov  s2, r10
@// f18 ^= g8
vmov  r10, s18
eor   r10, r8
vmov  s18, r10
@// g8 ^= f14
vmov r11, s14
eor  r8, r11
@// g3 ^= f10
vmov r11, s10
eor  r3, r11
@// f10 ^= f12
vmov  r10, s10
vmov  r11, s12
eor   r10, r11
vmov  s10, r10
@// f12 ^= f31
vmov  r10, s12
vmov  r11, s31
eor   r10, r11
vmov  s12, r10
@// f2 ^= f27
vmov  r10, s2
vmov  r11, s27
eor   r10, r11
vmov  s2, r10
@// f30 ^= f27
vmov  r10, s30
vmov  r11, s27
eor   r10, r11
vmov  s30, r10
@// f27 ^= f31
vmov  r10, s27
vmov  r11, s31
eor   r10, r11
vmov  s27, r10
@// f31 ^= f26
vmov  r10, s31
vmov  r11, s26
eor   r10, r11
vmov  s31, r10
@// g3 ^= g8
 eor r3, r8
@// f22 ^= f28
vmov  r10, s22
vmov  r11, s28
eor   r10, r11
vmov  s22, r10
@// g9 ^= g1
 eor r9, r1
@// f1 ^= g4
vmov  r10, s1
eor   r10, r4
vmov  s1, r10
@// g4 ^= g8
 eor r4, r8
@// g0 ^= f31
vmov r11, s31
eor  r0, r11
@// f16 ^= f8
vmov  r10, s16
vmov  r11, s8
eor   r10, r11
vmov  s16, r10
@// f27 ^= f1
vmov  r10, s27
vmov  r11, s1
eor   r10, r11
vmov  s27, r10
@// f10 ^= g2
vmov  r10, s10
eor   r10, r2
vmov  s10, r10
@// f26 ^= g1
vmov  r10, s26
eor   r10, r1
vmov  s26, r10
@// f26 ^= g2
vmov  r10, s26
eor   r10, r2
vmov  s26, r10
@// f7 ^= g7
vmov  r10, s7
eor   r10, r7
vmov  s7, r10
@// f14 ^= g4
vmov  r10, s14
eor   r10, r4
vmov  s14, r10
@// g4 ^= f26
vmov r11, s26
eor  r4, r11
@// f26 ^= f1
vmov  r10, s26
vmov  r11, s1
eor   r10, r11
vmov  s26, r10
@// f21 ^= g8
vmov  r10, s21
eor   r10, r8
vmov  s21, r10
@// f21 ^= f14
vmov  r10, s21
vmov  r11, s14
eor   r10, r11
vmov  s21, r10
@// f15 ^= f3
vmov  r10, s15
vmov  r11, s3
eor   r10, r11
vmov  s15, r10
@// f3 ^= g8
vmov  r10, s3
eor   r10, r8
vmov  s3, r10
@// g8 ^= g7
 eor r8, r7
@// g7 ^= g2
 eor r7, r2
@// f31 ^= f4
vmov  r10, s31
vmov  r11, s4
eor   r10, r11
vmov  s31, r10
@// g2 ^= g1
 eor r2, r1
@// f30 ^= g2
vmov  r10, s30
eor   r10, r2
vmov  s30, r10
@// f2 ^= f28
vmov  r10, s2
vmov  r11, s28
eor   r10, r11
vmov  s2, r10
@// g2 ^= f28
vmov r11, s28
eor  r2, r11
@// g1 ^= f24
vmov r11, s24
eor  r1, r11
@// f28 ^= f24
vmov  r10, s28
vmov  r11, s24
eor   r10, r11
vmov  s28, r10
@// f24 ^= f8
vmov  r10, s24
vmov  r11, s8
eor   r10, r11
vmov  s24, r10
@// g3 ^= f22
vmov r11, s22
eor  r3, r11
@// g0 ^= g1
 eor r0, r1
@// f24 ^= f29
vmov  r10, s24
vmov  r11, s29
eor   r10, r11
vmov  s24, r10
@// f14 ^= f30
vmov  r10, s14
vmov  r11, s30
eor   r10, r11
vmov  s14, r10
@// f15 ^= f31
vmov  r10, s15
vmov  r11, s31
eor   r10, r11
vmov  s15, r10
@// g9 ^= g6
 eor r9, r6
@// f29 ^= g6
vmov  r10, s29
eor   r10, r6
vmov  s29, r10
@// f2 ^= f4
vmov  r10, s2
vmov  r11, s4
eor   r10, r11
vmov  s2, r10
@// g7 ^= g0
 eor r7, r0
@// g8 ^= g9
 eor r8, r9
@// f22 ^= g4
vmov  r10, s22
eor   r10, r4
vmov  s22, r10
@// f12 ^= f28
vmov  r10, s12
vmov  r11, s28
eor   r10, r11
vmov  s12, r10
@// f0 ^= f21
vmov  r10, s0
vmov  r11, s21
eor   r10, r11
vmov  s0, r10
@// f8 ^= f21
vmov  r10, s8
vmov  r11, s21
eor   r10, r11
vmov  s8, r10
@// g5 ^= g6
 eor r5, r6
@// g4 ^= g8
 eor r4, r8
@// f22 ^= f28
vmov  r10, s22
vmov  r11, s28
eor   r10, r11
vmov  s22, r10
@// f10 ^= f31
vmov  r10, s10
vmov  r11, s31
eor   r10, r11
vmov  s10, r10
@// f3 ^= f29
vmov  r10, s3
vmov  r11, s29
eor   r10, r11
vmov  s3, r10
@// g1 ^= g3
 eor r1, r3
@// f4 ^= f7
vmov  r10, s4
vmov  r11, s7
eor   r10, r11
vmov  s4, r10
@// f7 ^= g5
vmov  r10, s7
eor   r10, r5
vmov  s7, r10
@// g2 ^= f4
vmov r11, s4
eor  r2, r11
@// f1 ^= g5
vmov  r10, s1
eor   r10, r5
vmov  s1, r10
vstr.32  s0, [r14, #0]
vstr.32  s1, [r14, #4]
vstr.32  s2, [r14, #8]
vstr.32  s3, [r14, #12]
vstr.32  s4, [r14, #16]
str  r0, [r14, #20]
str  r1, [r14, #24]
vstr.32  s7, [r14, #28]
vstr.32  s8, [r14, #32]
str  r2, [r14, #36]
vstr.32  s10, [r14, #40]
str  r3, [r14, #44]
vstr.32  s12, [r14, #48]
str  r4, [r14, #52]
vstr.32  s14, [r14, #56]
vstr.32  s15, [r14, #60]
vstr.32  s16, [r14, #64]
str  r5, [r14, #68]
vstr.32  s18, [r14, #72]
str  r6, [r14, #76]
str  r7, [r14, #80]
vstr.32  s21, [r14, #84]
vstr.32  s22, [r14, #88]
str  r8, [r14, #92]
vstr.32  s24, [r14, #96]
str  r9, [r14, #100]
vstr.32  s26, [r14, #104]
vstr.32  s27, [r14, #108]
vstr.32  s28, [r14, #112]
vstr.32  s29, [r14, #116]
vstr.32  s30, [r14, #120]
vstr.32  s31, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v25, .-gft_mul_v25
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v26
.type gft_mul_v26, %function
.align 2
gft_mul_v26:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{5, 7, 8, 9, 10, 12, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 31}, {4, 5, 6, 7, 8, 11, 13, 15, 16, 18, 20, 22, 24, 26, 30, 31}, {4, 6, 7, 8, 9, 12, 13, 15, 17, 18, 21, 22, 25, 26, 28, 30}, {5, 6, 8, 12, 14, 15, 16, 17, 19, 20, 21, 23, 24, 25, 27, 29, 31}, {2, 6, 10, 11, 12, 13, 15, 19, 20, 21, 22, 24, 25, 30, 31}, {3, 7, 10, 12, 14, 15, 18, 19, 20, 23, 24, 30}, {0, 1, 2, 3, 4, 5, 6, 7, 9, 11, 12, 15, 16, 18, 20, 21, 26, 27, 29, 31}, {0, 2, 4, 6, 8, 9, 10, 11, 13, 14, 15, 17, 19, 20, 26, 28, 29, 30, 31}, {0, 1, 3, 4, 5, 7, 8, 9, 11, 12, 17, 19, 23, 24, 26, 28, 29, 30}, {0, 2, 3, 4, 6, 7, 8, 10, 11, 13, 16, 17, 18, 19, 22, 23, 25, 27, 28, 31}, {0, 3, 4, 7, 8, 11, 14, 16, 18, 19, 20, 22, 24, 25, 27, 28, 29}, {1, 2, 3, 5, 6, 7, 9, 10, 11, 15, 17, 18, 21, 23, 24, 26, 27, 28}, {1, 3, 4, 9, 10, 11, 12, 14, 16, 17, 20, 23, 24, 25, 27, 29, 30, 31}, {0, 1, 2, 3, 5, 8, 9, 10, 13, 15, 16, 21, 22, 23, 24, 26, 27, 28, 29, 30}, {0, 2, 3, 6, 9, 12, 13, 15, 18, 19, 20, 24, 27, 29}, {1, 2, 7, 8, 9, 12, 14, 15, 18, 21, 25, 26, 27, 28, 29}, {1, 6, 15, 17, 21, 22, 23, 24, 25, 26, 28, 30, 31}, {0, 1, 7, 14, 15, 16, 17, 20, 21, 22, 24, 27, 29, 30}, {3, 4, 5, 6, 7, 12, 14, 19, 21, 24, 25, 29, 30, 31}, {2, 3, 4, 6, 13, 15, 18, 19, 20, 21, 24, 28, 29, 30}, {1, 8, 9, 12, 13, 17, 18, 22, 24, 25, 26, 27, 31}, {0, 1, 8, 12, 16, 17, 19, 23, 24, 26, 30, 31}, {3, 10, 11, 14, 15, 16, 17, 18, 20, 21, 22, 23, 25, 26, 28, 30}, {2, 3, 10, 14, 16, 19, 20, 22, 24, 25, 27, 29, 31}, {0, 3, 8, 9, 11, 14, 17, 20, 21, 23, 28, 30}, {1, 2, 3, 8, 10, 11, 15, 16, 17, 20, 22, 23, 29, 31}, {0, 8, 11, 12, 13, 14, 15, 19, 20, 23, 28, 29, 31}, {1, 9, 10, 11, 12, 14, 18, 19, 21, 22, 23, 28, 30, 31}, {4, 7, 9, 12, 15, 17, 19, 23, 26, 27, 30, 31}, {5, 6, 7, 8, 9, 13, 14, 15, 16, 17, 18, 19, 22, 23, 26, 30}, {4, 11, 12, 16, 18, 19, 20, 22, 25, 27, 29, 31}, {5, 10, 11, 13, 17, 18, 21, 23, 24, 25, 26, 27, 28, 29, 30, 31}]

@ i = 0
@ better circuit found: #XORs = 286
@ better circuit found: #XORs = 268
@ better circuit found: #XORs = 257
@ better circuit found: #XORs = 256
@ i = 50
@ better circuit found: #XORs = 245
@ i = 100
@ i = 150
@ better circuit found: #XORs = 243
@ i = 200
@ i = 250
@ i = 300
@ i = 350
@ i = 400
@ i = 450
@ i = 500
@ i = 550
@ i = 600
@ i = 650
@ i = 700
@ i = 750
@ i = 800
@ i = 850
@ i = 900
@ i = 950

@ initial state: [{0, 7, 6, 12}, {4, 19, 20, 21, 24, 29}, {4, 10, 13, 25, 30}, {17, 9, 15}, {20, 5, 22, 23, 21}, {2, 7, 14, 19, 20, 23, 29, 30}, {0, 7, 13, 26, 27}, {2, 11, 17, 18, 22, 25}, {7, 15, 16, 21, 28, 31}, {17, 24, 30, 31}, {16, 19, 5, 7, 25}, {17, 22, 6, 12, 8}, {3, 5, 21, 9, 14}, {11, 15, 23, 30}, {2, 6, 8, 11, 15, 25}, {0, 8, 9, 10, 18, 29}, {9, 21, 25, 27, 28, 30}, {11, 16, 21, 25}, {19, 6, 7, 15}, {0, 4, 12, 25}, {23, 6, 8, 13}, {1, 7, 8, 19, 21, 23}, {18, 19, 26, 5, 10}, {4, 11, 14, 15, 29}, {16, 17, 20, 5, 27}, {18, 25, 12, 15}, {2, 3, 29, 24, 25, 10}, {6, 9, 26}, {19, 22, 24, 25, 12}, {0, 3, 9, 16, 19, 23, 28}, {4, 23, 21, 31}, {0, 1, 5, 9, 11}]
@[0, 1, 4, 5, 7, 8, 12, 13, 14, 15, 16, 17, 19, 21, 22, 23, 24, 25, 26, 28, 29, 31, 2, 3, 6, 9, 10, 11, 18, 20, 27, 30]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 676)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #0]
ldr  r1, [r12, #28]
ldr  r2, [r12, #24]
ldr  r3, [r12, #48]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s0, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #76]
ldr  r2, [r12, #80]
ldr  r3, [r12, #84]
ldr  r4, [r12, #96]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s1, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #40]
ldr  r2, [r12, #52]
ldr  r3, [r12, #100]
ldr  r4, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s2, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #36]
ldr  r2, [r12, #60]
eor r0, r1
eor r0, r2
vmov  s3, r0
ldr  r0, [r12, #80]
ldr  r1, [r12, #20]
ldr  r2, [r12, #88]
ldr  r3, [r12, #92]
ldr  r4, [r12, #84]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s4, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #28]
ldr  r2, [r12, #56]
ldr  r3, [r12, #76]
ldr  r4, [r12, #80]
ldr  r5, [r12, #92]
ldr  r6, [r12, #116]
ldr  r7, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s5, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #28]
ldr  r2, [r12, #52]
ldr  r3, [r12, #104]
ldr  r4, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s6, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #44]
ldr  r2, [r12, #68]
ldr  r3, [r12, #72]
ldr  r4, [r12, #88]
ldr  r5, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s7, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #60]
ldr  r2, [r12, #64]
ldr  r3, [r12, #84]
ldr  r4, [r12, #112]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s8, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #96]
ldr  r2, [r12, #120]
ldr  r3, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s9, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #76]
ldr  r2, [r12, #20]
ldr  r3, [r12, #28]
ldr  r4, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s10, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #88]
ldr  r2, [r12, #24]
ldr  r3, [r12, #48]
ldr  r4, [r12, #32]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s11, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #20]
ldr  r2, [r12, #84]
ldr  r3, [r12, #36]
ldr  r4, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s12, r0
ldr  r0, [r12, #44]
ldr  r1, [r12, #60]
ldr  r2, [r12, #92]
ldr  r3, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s13, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #24]
ldr  r2, [r12, #32]
ldr  r3, [r12, #44]
ldr  r4, [r12, #60]
ldr  r5, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s14, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #32]
ldr  r2, [r12, #36]
ldr  r3, [r12, #40]
ldr  r4, [r12, #72]
ldr  r5, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s15, r0
ldr  r0, [r12, #36]
ldr  r1, [r12, #84]
ldr  r2, [r12, #100]
ldr  r3, [r12, #108]
ldr  r4, [r12, #112]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s16, r0
ldr  r0, [r12, #44]
ldr  r1, [r12, #64]
ldr  r2, [r12, #84]
ldr  r3, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s17, r0
ldr  r0, [r12, #76]
ldr  r1, [r12, #24]
ldr  r2, [r12, #28]
ldr  r3, [r12, #60]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s18, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #16]
ldr  r2, [r12, #48]
ldr  r3, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s19, r0
ldr  r0, [r12, #92]
ldr  r1, [r12, #24]
ldr  r2, [r12, #32]
ldr  r3, [r12, #52]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s20, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #28]
ldr  r2, [r12, #32]
ldr  r3, [r12, #76]
ldr  r4, [r12, #84]
ldr  r5, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s21, r0
ldr  r0, [r12, #72]
ldr  r1, [r12, #76]
ldr  r2, [r12, #104]
ldr  r3, [r12, #20]
ldr  r4, [r12, #40]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s22, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #44]
ldr  r2, [r12, #56]
ldr  r3, [r12, #60]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s23, r0
ldr  r0, [r12, #64]
ldr  r1, [r12, #68]
ldr  r2, [r12, #80]
ldr  r3, [r12, #20]
ldr  r4, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s24, r0
ldr  r0, [r12, #72]
ldr  r1, [r12, #100]
ldr  r2, [r12, #48]
ldr  r3, [r12, #60]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s25, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #12]
ldr  r2, [r12, #116]
ldr  r3, [r12, #96]
ldr  r4, [r12, #100]
ldr  r5, [r12, #40]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s26, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #36]
ldr  r2, [r12, #104]
eor r0, r1
eor r0, r2
vmov  s27, r0
ldr  r0, [r12, #76]
ldr  r1, [r12, #88]
ldr  r2, [r12, #96]
ldr  r3, [r12, #100]
ldr  r4, [r12, #48]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s28, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #12]
ldr  r2, [r12, #36]
ldr  r3, [r12, #64]
ldr  r4, [r12, #76]
ldr  r5, [r12, #92]
ldr  r6, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s29, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #92]
ldr  r2, [r12, #84]
ldr  r3, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s30, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #20]
ldr  r3, [r12, #36]
ldr  r4, [r12, #44]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s31, r0
vmov  r0, s2;
vmov  r1, s3;
vmov  r2, s6;
vmov  r3, s9;
vmov  r4, s10;
vmov  r5, s11;
vmov  r6, s18;
vmov  r7, s20;
vmov  r8, s27;
vmov  r9, s30;
@// f0 ^= g5
vmov  r10, s0
eor   r10, r5
vmov  s0, r10
@// f0 ^= g1
vmov  r10, s0
eor   r10, r1
vmov  s0, r10
@// f7 ^= f28
vmov  r10, s7
vmov  r11, s28
eor   r10, r11
vmov  s7, r10
@// g1 ^= g3
 eor r1, r3
@// g3 ^= g9
 eor r3, r9
@// f17 ^= g9
vmov  r10, s17
eor   r10, r9
vmov  s17, r10
@// g9 ^= f4
vmov r11, s4
eor  r9, r11
@// g9 ^= f24
vmov r11, s24
eor  r9, r11
@// f14 ^= g8
vmov  r10, s14
eor   r10, r8
vmov  s14, r10
@// f26 ^= g0
vmov  r10, s26
eor   r10, r0
vmov  s26, r10
@// f7 ^= f22
vmov  r10, s7
vmov  r11, s22
eor   r10, r11
vmov  s7, r10
@// f13 ^= f25
vmov  r10, s13
vmov  r11, s25
eor   r10, r11
vmov  s13, r10
@// f25 ^= g0
vmov  r10, s25
eor   r10, r0
vmov  s25, r10
@// g0 ^= g7
 eor r0, r7
@// g7 ^= g5
 eor r7, r5
@// g5 ^= f28
vmov r11, s28
eor  r5, r11
@// f4 ^= g7
vmov  r10, s4
eor   r10, r7
vmov  s4, r10
@// f24 ^= g4
vmov  r10, s24
eor   r10, r4
vmov  s24, r10
@// f22 ^= g4
vmov  r10, s22
eor   r10, r4
vmov  s22, r10
@// f4 ^= f7
vmov  r10, s4
vmov  r11, s7
eor   r10, r11
vmov  s4, r10
@// f4 ^= g8
vmov  r10, s4
eor   r10, r8
vmov  s4, r10
@// f15 ^= g8
vmov  r10, s15
eor   r10, r8
vmov  s15, r10
@// g8 ^= g6
 eor r8, r6
@// g6 ^= g4
 eor r6, r4
@// g4 ^= f28
vmov r11, s28
eor  r4, r11
@// g9 ^= g3
 eor r9, r3
@// g3 ^= g1
 eor r3, r1
@// g8 ^= f22
vmov r11, s22
eor  r8, r11
@// g8 ^= f29
vmov r11, s29
eor  r8, r11
@// g6 ^= f17
vmov r11, s17
eor  r6, r11
@// f17 ^= f23
vmov  r10, s17
vmov  r11, s23
eor   r10, r11
vmov  s17, r10
@// f29 ^= f12
vmov  r10, s29
vmov  r11, s12
eor   r10, r11
vmov  s29, r10
@// f8 ^= f12
vmov  r10, s8
vmov  r11, s12
eor   r10, r11
vmov  s8, r10
@// f12 ^= f31
vmov  r10, s12
vmov  r11, s31
eor   r10, r11
vmov  s12, r10
@// g6 ^= g1
 eor r6, r1
@// f17 ^= g1
vmov  r10, s17
eor   r10, r1
vmov  s17, r10
@// f28 ^= g1
vmov  r10, s28
eor   r10, r1
vmov  s28, r10
@// g1 ^= f16
vmov r11, s16
eor  r1, r11
@// g1 ^= g5
 eor r1, r5
@// g5 ^= f21
vmov r11, s21
eor  r5, r11
@// g5 ^= g3
 eor r5, r3
@// g9 ^= g7
 eor r9, r7
@// f5 ^= f23
vmov  r10, s5
vmov  r11, s23
eor   r10, r11
vmov  s5, r10
@// g4 ^= f0
vmov r11, s0
eor  r4, r11
@// g4 ^= f8
vmov r11, s8
eor  r4, r11
@// g3 ^= f23
vmov r11, s23
eor  r3, r11
@// f13 ^= g7
vmov  r10, s13
eor   r10, r7
vmov  s13, r10
@// f24 ^= f21
vmov  r10, s24
vmov  r11, s21
eor   r10, r11
vmov  s24, r10
@// f21 ^= g2
vmov  r10, s21
eor   r10, r2
vmov  s21, r10
@// f21 ^= g9
vmov  r10, s21
eor   r10, r9
vmov  s21, r10
@// g9 ^= f13
vmov r11, s13
eor  r9, r11
@// g0 ^= f25
vmov r11, s25
eor  r0, r11
@// f8 ^= f23
vmov  r10, s8
vmov  r11, s23
eor   r10, r11
vmov  s8, r10
@// f25 ^= f26
vmov  r10, s25
vmov  r11, s26
eor   r10, r11
vmov  s25, r10
@// f14 ^= g0
vmov  r10, s14
eor   r10, r0
vmov  s14, r10
@// f14 ^= g2
vmov  r10, s14
eor   r10, r2
vmov  s14, r10
@// g7 ^= f19
vmov r11, s19
eor  r7, r11
@// g7 ^= g2
 eor r7, r2
@// f7 ^= g6
vmov  r10, s7
eor   r10, r6
vmov  s7, r10
@// g1 ^= f1
vmov r11, s1
eor  r1, r11
@// f31 ^= g2
vmov  r10, s31
eor   r10, r2
vmov  s31, r10
@// g2 ^= f22
vmov r11, s22
eor  r2, r11
@// g2 ^= g0
 eor r2, r0
@// g6 ^= f8
vmov r11, s8
eor  r6, r11
@// f23 ^= f25
vmov  r10, s23
vmov  r11, s25
eor   r10, r11
vmov  s23, r10
@// f25 ^= g9
vmov  r10, s25
eor   r10, r9
vmov  s25, r10
@// g9 ^= f1
vmov r11, s1
eor  r9, r11
@// f25 ^= f24
vmov  r10, s25
vmov  r11, s24
eor   r10, r11
vmov  s25, r10
@// f13 ^= f22
vmov  r10, s13
vmov  r11, s22
eor   r10, r11
vmov  s13, r10
@// f17 ^= f0
vmov  r10, s17
vmov  r11, s0
eor   r10, r11
vmov  s17, r10
@// f17 ^= f24
vmov  r10, s17
vmov  r11, s24
eor   r10, r11
vmov  s17, r10
@// f29 ^= f19
vmov  r10, s29
vmov  r11, s19
eor   r10, r11
vmov  s29, r10
@// g8 ^= f12
vmov r11, s12
eor  r8, r11
@// f19 ^= f16
vmov  r10, s19
vmov  r11, s16
eor   r10, r11
vmov  s19, r10
@// f12 ^= f16
vmov  r10, s12
vmov  r11, s16
eor   r10, r11
vmov  s12, r10
@// f16 ^= g7
vmov  r10, s16
eor   r10, r7
vmov  s16, r10
@// f16 ^= g5
vmov  r10, s16
eor   r10, r5
vmov  s16, r10
@// g0 ^= g5
 eor r0, r5
@// g5 ^= f26
vmov r11, s26
eor  r5, r11
@// g2 ^= g1
 eor r2, r1
@// f26 ^= f5
vmov  r10, s26
vmov  r11, s5
eor   r10, r11
vmov  s26, r10
@// f13 ^= f15
vmov  r10, s13
vmov  r11, s15
eor   r10, r11
vmov  s13, r10
@// f22 ^= f0
vmov  r10, s22
vmov  r11, s0
eor   r10, r11
vmov  s22, r10
@// f0 ^= f15
vmov  r10, s0
vmov  r11, s15
eor   r10, r11
vmov  s0, r10
@// f31 ^= f0
vmov  r10, s31
vmov  r11, s0
eor   r10, r11
vmov  s31, r10
@// f15 ^= f14
vmov  r10, s15
vmov  r11, s14
eor   r10, r11
vmov  s15, r10
@// f14 ^= f26
vmov  r10, s14
vmov  r11, s26
eor   r10, r11
vmov  s14, r10
@// f26 ^= g4
vmov  r10, s26
eor   r10, r4
vmov  s26, r10
@// f5 ^= f23
vmov  r10, s5
vmov  r11, s23
eor   r10, r11
vmov  s5, r10
@// f1 ^= g3
vmov  r10, s1
eor   r10, r3
vmov  s1, r10
@// g3 ^= f4
vmov r11, s4
eor  r3, r11
@// f15 ^= g8
vmov  r10, s15
eor   r10, r8
vmov  s15, r10
@// g8 ^= f28
vmov r11, s28
eor  r8, r11
@// g6 ^= f29
vmov r11, s29
eor  r6, r11
@// f24 ^= f12
vmov  r10, s24
vmov  r11, s12
eor   r10, r11
vmov  s24, r10
@// f4 ^= f28
vmov  r10, s4
vmov  r11, s28
eor   r10, r11
vmov  s4, r10
@// f28 ^= g7
vmov  r10, s28
eor   r10, r7
vmov  s28, r10
@// f23 ^= g9
vmov  r10, s23
eor   r10, r9
vmov  s23, r10
@// f31 ^= f16
vmov  r10, s31
vmov  r11, s16
eor   r10, r11
vmov  s31, r10
@// g7 ^= g0
 eor r7, r0
@// g0 ^= f16
vmov r11, s16
eor  r0, r11
@// f22 ^= f24
vmov  r10, s22
vmov  r11, s24
eor   r10, r11
vmov  s22, r10
@// g1 ^= f29
vmov r11, s29
eor  r1, r11
@// g5 ^= f31
vmov r11, s31
eor  r5, r11
@// f29 ^= g0
vmov  r10, s29
eor   r10, r0
vmov  s29, r10
@// f1 ^= f29
vmov  r10, s1
vmov  r11, s29
eor   r10, r11
vmov  s1, r10
@// f19 ^= f14
vmov  r10, s19
vmov  r11, s14
eor   r10, r11
vmov  s19, r10
@// f12 ^= g2
vmov  r10, s12
eor   r10, r2
vmov  s12, r10
@// g2 ^= g5
 eor r2, r5
@// f13 ^= g5
vmov  r10, s13
eor   r10, r5
vmov  s13, r10
@// f8 ^= f21
vmov  r10, s8
vmov  r11, s21
eor   r10, r11
vmov  s8, r10
@// g4 ^= g9
 eor r4, r9
@// g3 ^= g4
 eor r3, r4
@// f7 ^= f26
vmov  r10, s7
vmov  r11, s26
eor   r10, r11
vmov  s7, r10
@// f0 ^= g1
vmov  r10, s0
eor   r10, r1
vmov  s0, r10
vstr.32  s0, [r14, #0]
vstr.32  s1, [r14, #4]
str  r0, [r14, #8]
str  r1, [r14, #12]
vstr.32  s4, [r14, #16]
vstr.32  s5, [r14, #20]
str  r2, [r14, #24]
vstr.32  s7, [r14, #28]
vstr.32  s8, [r14, #32]
str  r3, [r14, #36]
str  r4, [r14, #40]
str  r5, [r14, #44]
vstr.32  s12, [r14, #48]
vstr.32  s13, [r14, #52]
vstr.32  s14, [r14, #56]
vstr.32  s15, [r14, #60]
vstr.32  s16, [r14, #64]
vstr.32  s17, [r14, #68]
str  r6, [r14, #72]
vstr.32  s19, [r14, #76]
str  r7, [r14, #80]
vstr.32  s21, [r14, #84]
vstr.32  s22, [r14, #88]
vstr.32  s23, [r14, #92]
vstr.32  s24, [r14, #96]
vstr.32  s25, [r14, #100]
vstr.32  s26, [r14, #104]
str  r8, [r14, #108]
vstr.32  s28, [r14, #112]
vstr.32  s29, [r14, #116]
str  r9, [r14, #120]
vstr.32  s31, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v26, .-gft_mul_v26
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global gft_mul_v27
.type gft_mul_v27, %function
.align 2
gft_mul_v27:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{1, 2, 4, 6, 7, 9, 11, 13, 15, 19, 23, 24, 26, 27, 28, 30}, {0, 1, 3, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 18, 19, 22, 23, 25, 26, 29, 31}, {0, 1, 2, 5, 6, 7, 8, 10, 11, 12, 14, 15, 16, 18, 20, 22, 25, 26, 27, 28, 29, 31}, {0, 3, 4, 5, 6, 9, 10, 13, 14, 17, 19, 21, 23, 24, 25, 26, 28, 30, 31}, {0, 1, 2, 3, 4, 7, 10, 13, 14, 15, 16, 17, 20, 21, 23, 26, 27, 28}, {0, 2, 5, 6, 7, 11, 12, 13, 14, 16, 20, 22, 23, 26, 29}, {1, 2, 4, 8, 9, 10, 11, 13, 18, 19, 20, 23, 25, 27, 30}, {0, 1, 3, 5, 8, 10, 12, 13, 18, 21, 22, 23, 24, 25, 26, 27, 31}, {6, 9, 10, 12, 15, 16, 19, 20, 21, 22, 23, 24, 28, 29, 30}, {7, 8, 9, 11, 13, 14, 15, 17, 18, 19, 20, 22, 25, 28, 31}, {4, 5, 6, 7, 8, 9, 10, 12, 16, 21, 22, 26, 28, 29}, {4, 6, 8, 11, 13, 17, 20, 21, 23, 27, 28}, {1, 5, 8, 10, 11, 12, 13, 15, 19, 20, 24, 25, 27, 29, 31}, {0, 1, 4, 5, 9, 10, 12, 14, 15, 18, 19, 21, 24, 26, 27, 28, 29, 30, 31}, {3, 7, 9, 10, 11, 12, 15, 16, 18, 22, 24, 27, 28, 30, 31}, {2, 3, 6, 7, 8, 9, 10, 13, 14, 15, 17, 19, 23, 25, 26, 27, 29, 30}, {0, 4, 6, 7, 12, 13, 16, 17, 18, 25, 27, 28, 31}, {1, 5, 6, 12, 16, 19, 24, 25, 26, 27, 29, 30, 31}, {2, 5, 6, 7, 14, 15, 16, 17, 24, 26, 27, 28}, {3, 4, 5, 6, 14, 16, 25, 26, 29}, {0, 1, 2, 3, 5, 6, 7, 8, 11, 12, 15, 20, 21, 22, 24, 26, 27, 28, 29, 30}, {0, 2, 4, 5, 6, 9, 10, 11, 13, 14, 15, 20, 23, 25, 26, 28, 31}, {1, 2, 5, 8, 12, 20, 21, 25, 26, 27, 28, 29}, {0, 1, 3, 4, 5, 9, 13, 20, 24, 25, 26, 28}, {0, 2, 3, 10, 11, 12, 14, 15, 16, 18, 19, 22, 25, 27, 30}, {1, 2, 10, 13, 14, 17, 18, 23, 24, 25, 26, 27, 31}, {1, 2, 3, 9, 11, 13, 14, 15, 17, 18, 19, 20, 21, 22, 23, 24, 26, 27, 28, 29, 30, 31}, {0, 1, 2, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 20, 22, 25, 26, 28, 30}, {4, 6, 7, 8, 9, 10, 11, 12, 13, 17, 20, 21, 22, 23, 25, 31}, {5, 6, 8, 10, 12, 16, 17, 20, 22, 24, 25, 30, 31}, {5, 6, 7, 9, 10, 14, 15, 19, 21, 22, 27, 28, 30}, {4, 5, 6, 8, 9, 11, 14, 18, 19, 20, 21, 23, 26, 27, 29, 31}]

@ i = 0
@ better circuit found: #XORs = 272
@ better circuit found: #XORs = 254
@ better circuit found: #XORs = 252
@ i = 50
@ i = 100
@ i = 150
@ i = 200
@ better circuit found: #XORs = 251
@ i = 250
@ i = 300
@ i = 350
@ i = 400
@ i = 450
@ better circuit found: #XORs = 250
@ i = 500
@ i = 550
@ i = 600
@ i = 650
@ i = 700
@ i = 750
@ i = 800
@ i = 850
@ better circuit found: #XORs = 246
@ i = 900
@ i = 950

@ initial state: [{3, 6}, {9, 10, 24, 27, 29}, {10, 11, 14, 15, 21, 31}, {2, 16, 17, 18, 19, 20, 21, 25}, {1, 12, 24, 27}, {12, 14, 16, 21, 29, 31}, {6, 19, 31}, {2, 5, 21, 24, 25, 27}, {4, 14, 27, 30}, {20, 22, 30, 24, 25, 8}, {23, 22, 7, 8, 26, 12, 14}, {7, 16, 17, 21, 22, 23, 28, 29}, {18, 4, 22, 11, 28}, {17, 2, 4, 23}, {3, 7, 9, 15, 18, 25}, {0, 10, 11, 14, 25, 26}, {5, 16, 22, 24, 27, 28}, {5, 10, 12, 16, 17, 19}, {15, 16, 18, 26, 28}, {4, 5, 14, 16, 25, 26, 29}, {0, 6, 7, 16, 18, 22}, {2, 8, 13, 21, 22, 24, 26}, {0, 8, 20, 23, 26, 29, 30}, {6, 9, 10, 21, 23, 25, 26, 28}, {0, 2, 14, 17, 28}, {10, 12, 13, 18, 25, 26, 27, 30, 31}, {0, 3, 4, 12, 17, 20}, {0, 1, 5, 14, 19, 22, 30}, {4, 7, 9, 10, 13, 17}, {4, 6, 10, 13, 24, 25}, {7, 9, 11, 16, 24, 30}, {0, 5, 8, 14, 16, 20, 24, 31}]
@[2, 3, 5, 7, 8, 10, 11, 12, 14, 15, 16, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 31, 0, 1, 4, 6, 9, 13, 17, 18, 29, 30]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 655)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #12]
ldr  r1, [r12, #24]
eor r0, r1
vmov  s0, r0
ldr  r0, [r12, #36]
ldr  r1, [r12, #40]
ldr  r2, [r12, #96]
ldr  r3, [r12, #108]
ldr  r4, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s1, r0
ldr  r0, [r12, #40]
ldr  r1, [r12, #44]
ldr  r2, [r12, #56]
ldr  r3, [r12, #60]
ldr  r4, [r12, #84]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s2, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #64]
ldr  r2, [r12, #68]
ldr  r3, [r12, #72]
ldr  r4, [r12, #76]
ldr  r5, [r12, #80]
ldr  r6, [r12, #84]
ldr  r7, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s3, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #48]
ldr  r2, [r12, #96]
ldr  r3, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s4, r0
ldr  r0, [r12, #48]
ldr  r1, [r12, #56]
ldr  r2, [r12, #64]
ldr  r3, [r12, #84]
ldr  r4, [r12, #116]
ldr  r5, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s5, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #76]
ldr  r2, [r12, #124]
eor r0, r1
eor r0, r2
vmov  s6, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #20]
ldr  r2, [r12, #84]
ldr  r3, [r12, #96]
ldr  r4, [r12, #100]
ldr  r5, [r12, #108]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s7, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #56]
ldr  r2, [r12, #108]
ldr  r3, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s8, r0
ldr  r0, [r12, #80]
ldr  r1, [r12, #88]
ldr  r2, [r12, #120]
ldr  r3, [r12, #96]
ldr  r4, [r12, #100]
ldr  r5, [r12, #32]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s9, r0
ldr  r0, [r12, #92]
ldr  r1, [r12, #88]
ldr  r2, [r12, #28]
ldr  r3, [r12, #32]
ldr  r4, [r12, #104]
ldr  r5, [r12, #48]
ldr  r6, [r12, #56]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s10, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #64]
ldr  r2, [r12, #68]
ldr  r3, [r12, #84]
ldr  r4, [r12, #88]
ldr  r5, [r12, #92]
ldr  r6, [r12, #112]
ldr  r7, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s11, r0
ldr  r0, [r12, #72]
ldr  r1, [r12, #16]
ldr  r2, [r12, #88]
ldr  r3, [r12, #44]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s12, r0
ldr  r0, [r12, #68]
ldr  r1, [r12, #8]
ldr  r2, [r12, #16]
ldr  r3, [r12, #92]
eor r0, r1
eor r0, r2
eor r0, r3
vmov  s13, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #28]
ldr  r2, [r12, #36]
ldr  r3, [r12, #60]
ldr  r4, [r12, #72]
ldr  r5, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s14, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #40]
ldr  r2, [r12, #44]
ldr  r3, [r12, #56]
ldr  r4, [r12, #100]
ldr  r5, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s15, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #64]
ldr  r2, [r12, #88]
ldr  r3, [r12, #96]
ldr  r4, [r12, #108]
ldr  r5, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s16, r0
ldr  r0, [r12, #20]
ldr  r1, [r12, #40]
ldr  r2, [r12, #48]
ldr  r3, [r12, #64]
ldr  r4, [r12, #68]
ldr  r5, [r12, #76]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s17, r0
ldr  r0, [r12, #60]
ldr  r1, [r12, #64]
ldr  r2, [r12, #72]
ldr  r3, [r12, #104]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s18, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #20]
ldr  r2, [r12, #56]
ldr  r3, [r12, #64]
ldr  r4, [r12, #100]
ldr  r5, [r12, #104]
ldr  r6, [r12, #116]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s19, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #24]
ldr  r2, [r12, #28]
ldr  r3, [r12, #64]
ldr  r4, [r12, #72]
ldr  r5, [r12, #88]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s20, r0
ldr  r0, [r12, #8]
ldr  r1, [r12, #32]
ldr  r2, [r12, #52]
ldr  r3, [r12, #84]
ldr  r4, [r12, #88]
ldr  r5, [r12, #96]
ldr  r6, [r12, #104]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s21, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #32]
ldr  r2, [r12, #80]
ldr  r3, [r12, #92]
ldr  r4, [r12, #104]
ldr  r5, [r12, #116]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s22, r0
ldr  r0, [r12, #24]
ldr  r1, [r12, #36]
ldr  r2, [r12, #40]
ldr  r3, [r12, #84]
ldr  r4, [r12, #92]
ldr  r5, [r12, #100]
ldr  r6, [r12, #104]
ldr  r7, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s23, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #8]
ldr  r2, [r12, #56]
ldr  r3, [r12, #68]
ldr  r4, [r12, #112]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
vmov  s24, r0
ldr  r0, [r12, #40]
ldr  r1, [r12, #48]
ldr  r2, [r12, #52]
ldr  r3, [r12, #72]
ldr  r4, [r12, #100]
ldr  r5, [r12, #104]
ldr  r6, [r12, #108]
ldr  r7, [r12, #120]
ldr  r8, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
eor r0, r8
vmov  s25, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #12]
ldr  r2, [r12, #16]
ldr  r3, [r12, #48]
ldr  r4, [r12, #68]
ldr  r5, [r12, #80]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s26, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #4]
ldr  r2, [r12, #20]
ldr  r3, [r12, #56]
ldr  r4, [r12, #76]
ldr  r5, [r12, #88]
ldr  r6, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
vmov  s27, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #28]
ldr  r2, [r12, #36]
ldr  r3, [r12, #40]
ldr  r4, [r12, #52]
ldr  r5, [r12, #68]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s28, r0
ldr  r0, [r12, #16]
ldr  r1, [r12, #24]
ldr  r2, [r12, #40]
ldr  r3, [r12, #52]
ldr  r4, [r12, #96]
ldr  r5, [r12, #100]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s29, r0
ldr  r0, [r12, #28]
ldr  r1, [r12, #36]
ldr  r2, [r12, #44]
ldr  r3, [r12, #64]
ldr  r4, [r12, #96]
ldr  r5, [r12, #120]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
vmov  s30, r0
ldr  r0, [r12, #0]
ldr  r1, [r12, #20]
ldr  r2, [r12, #32]
ldr  r3, [r12, #56]
ldr  r4, [r12, #64]
ldr  r5, [r12, #80]
ldr  r6, [r12, #96]
ldr  r7, [r12, #124]
eor r0, r1
eor r0, r2
eor r0, r3
eor r0, r4
eor r0, r5
eor r0, r6
eor r0, r7
vmov  s31, r0
vmov  r0, s0;
vmov  r1, s1;
vmov  r2, s4;
vmov  r3, s6;
vmov  r4, s9;
vmov  r5, s13;
vmov  r6, s17;
vmov  r7, s18;
vmov  r8, s29;
vmov  r9, s30;
@// g5 ^= f24
vmov r11, s24
eor  r5, r11
@// f10 ^= g0
vmov  r10, s10
eor   r10, r0
vmov  s10, r10
@// f19 ^= g0
vmov  r10, s19
eor   r10, r0
vmov  s19, r10
@// g0 ^= g2
 eor r0, r2
@// g0 ^= g1
 eor r0, r1
@// g2 ^= f8
vmov r11, s8
eor  r2, r11
@// g2 ^= g5
 eor r2, r5
@// g5 ^= f12
vmov r11, s12
eor  r5, r11
@// f27 ^= g3
vmov  r10, s27
eor   r10, r3
vmov  s27, r10
@// g0 ^= f14
vmov r11, s14
eor  r0, r11
@// f14 ^= g9
vmov  r10, s14
eor   r10, r9
vmov  s14, r10
@// g9 ^= g1
 eor r9, r1
@// f11 ^= g9
vmov  r10, s11
eor   r10, r9
vmov  s11, r10
@// f12 ^= g7
vmov  r10, s12
eor   r10, r7
vmov  s12, r10
@// f10 ^= f19
vmov  r10, s10
vmov  r11, s19
eor   r10, r11
vmov  s10, r10
@// g7 ^= f20
vmov r11, s20
eor  r7, r11
@// g7 ^= f24
vmov r11, s24
eor  r7, r11
@// f22 ^= g2
vmov  r10, s22
eor   r10, r2
vmov  s22, r10
@// f8 ^= g4
vmov  r10, s8
eor   r10, r4
vmov  s8, r10
@// g4 ^= g8
 eor r4, r8
@// g8 ^= g3
 eor r8, r3
@// g1 ^= g3
 eor r1, r3
@// g3 ^= f23
vmov r11, s23
eor  r3, r11
@// g3 ^= f11
vmov r11, s11
eor  r3, r11
@// g2 ^= f24
vmov r11, s24
eor  r2, r11
@// f27 ^= g7
vmov  r10, s27
eor   r10, r7
vmov  s27, r10
@// g5 ^= f12
vmov r11, s12
eor  r5, r11
@// g8 ^= g6
 eor r8, r6
@// g9 ^= f16
vmov r11, s16
eor  r9, r11
@// f27 ^= g6
vmov  r10, s27
eor   r10, r6
vmov  s27, r10
@// g6 ^= f16
vmov r11, s16
eor  r6, r11
@// f21 ^= f12
vmov  r10, s21
vmov  r11, s12
eor   r10, r11
vmov  s21, r10
@// f11 ^= g4
vmov  r10, s11
eor   r10, r4
vmov  s11, r10
@// f31 ^= g5
vmov  r10, s31
eor   r10, r5
vmov  s31, r10
@// g1 ^= f2
vmov r11, s2
eor  r1, r11
@// f21 ^= f31
vmov  r10, s21
vmov  r11, s31
eor   r10, r11
vmov  s21, r10
@// f15 ^= f26
vmov  r10, s15
vmov  r11, s26
eor   r10, r11
vmov  s15, r10
@// f15 ^= f22
vmov  r10, s15
vmov  r11, s22
eor   r10, r11
vmov  s15, r10
@// g3 ^= f8
vmov r11, s8
eor  r3, r11
@// f24 ^= g6
vmov  r10, s24
eor   r10, r6
vmov  s24, r10
@// g6 ^= f22
vmov r11, s22
eor  r6, r11
@// g0 ^= f22
vmov r11, s22
eor  r0, r11
@// f22 ^= f7
vmov  r10, s22
vmov  r11, s7
eor   r10, r11
vmov  s22, r10
@// f7 ^= f8
vmov  r10, s7
vmov  r11, s8
eor   r10, r11
vmov  s7, r10
@// f3 ^= f14
vmov  r10, s3
vmov  r11, s14
eor   r10, r11
vmov  s3, r10
@// f7 ^= f26
vmov  r10, s7
vmov  r11, s26
eor   r10, r11
vmov  s7, r10
@// f8 ^= f10
vmov  r10, s8
vmov  r11, s10
eor   r10, r11
vmov  s8, r10
@// f25 ^= g2
vmov  r10, s25
eor   r10, r2
vmov  s25, r10
@// g2 ^= f7
vmov r11, s7
eor  r2, r11
@// g2 ^= g4
 eor r2, r4
@// g7 ^= f16
vmov r11, s16
eor  r7, r11
@// f16 ^= g8
vmov  r10, s16
eor   r10, r8
vmov  s16, r10
@// f12 ^= g4
vmov  r10, s12
eor   r10, r4
vmov  s12, r10
@// g8 ^= g4
 eor r8, r4
@// g4 ^= g0
 eor r4, r0
@// f28 ^= f16
vmov  r10, s28
vmov  r11, s16
eor   r10, r11
vmov  s28, r10
@// g6 ^= g8
 eor r6, r8
@// g4 ^= g3
 eor r4, r3
@// g3 ^= f25
vmov r11, s25
eor  r3, r11
@// g9 ^= g1
 eor r9, r1
@// f5 ^= f20
vmov  r10, s5
vmov  r11, s20
eor   r10, r11
vmov  s5, r10
@// f16 ^= f20
vmov  r10, s16
vmov  r11, s20
eor   r10, r11
vmov  s16, r10
@// g5 ^= f23
vmov r11, s23
eor  r5, r11
@// f10 ^= f23
vmov  r10, s10
vmov  r11, s23
eor   r10, r11
vmov  s10, r10
@// f23 ^= g2
vmov  r10, s23
eor   r10, r2
vmov  s23, r10
@// f20 ^= f14
vmov  r10, s20
vmov  r11, s14
eor   r10, r11
vmov  s20, r10
@// f2 ^= f14
vmov  r10, s2
vmov  r11, s14
eor   r10, r11
vmov  s2, r10
@// g0 ^= g3
 eor r0, r3
@// f12 ^= g6
vmov  r10, s12
eor   r10, r6
vmov  s12, r10
@// f8 ^= g9
vmov  r10, s8
eor   r10, r9
vmov  s8, r10
@// f26 ^= f5
vmov  r10, s26
vmov  r11, s5
eor   r10, r11
vmov  s26, r10
@// f5 ^= f21
vmov  r10, s5
vmov  r11, s21
eor   r10, r11
vmov  s5, r10
@// g2 ^= g7
 eor r2, r7
@// f21 ^= g5
vmov  r10, s21
eor   r10, r5
vmov  s21, r10
@// f15 ^= g0
vmov  r10, s15
eor   r10, r0
vmov  s15, r10
@// f31 ^= g1
vmov  r10, s31
eor   r10, r1
vmov  s31, r10
@// f24 ^= f14
vmov  r10, s24
vmov  r11, s14
eor   r10, r11
vmov  s24, r10
@// f7 ^= f25
vmov  r10, s7
vmov  r11, s25
eor   r10, r11
vmov  s7, r10
@// f14 ^= f28
vmov  r10, s14
vmov  r11, s28
eor   r10, r11
vmov  s14, r10
@// f28 ^= f11
vmov  r10, s28
vmov  r11, s11
eor   r10, r11
vmov  s28, r10
@// g5 ^= g6
 eor r5, r6
@// f27 ^= g4
vmov  r10, s27
eor   r10, r4
vmov  s27, r10
@// f3 ^= f21
vmov  r10, s3
vmov  r11, s21
eor   r10, r11
vmov  s3, r10
@// f20 ^= f22
vmov  r10, s20
vmov  r11, s22
eor   r10, r11
vmov  s20, r10
@// f26 ^= g0
vmov  r10, s26
eor   r10, r0
vmov  s26, r10
@// g1 ^= f7
vmov r11, s7
eor  r1, r11
@// f2 ^= f20
vmov  r10, s2
vmov  r11, s20
eor   r10, r11
vmov  s2, r10
str  r0, [r14, #0]
str  r1, [r14, #4]
vstr.32  s2, [r14, #8]
vstr.32  s3, [r14, #12]
str  r2, [r14, #16]
vstr.32  s5, [r14, #20]
str  r3, [r14, #24]
vstr.32  s7, [r14, #28]
vstr.32  s8, [r14, #32]
str  r4, [r14, #36]
vstr.32  s10, [r14, #40]
vstr.32  s11, [r14, #44]
vstr.32  s12, [r14, #48]
str  r5, [r14, #52]
vstr.32  s14, [r14, #56]
vstr.32  s15, [r14, #60]
vstr.32  s16, [r14, #64]
str  r6, [r14, #68]
str  r7, [r14, #72]
vstr.32  s19, [r14, #76]
vstr.32  s20, [r14, #80]
vstr.32  s21, [r14, #84]
vstr.32  s22, [r14, #88]
vstr.32  s23, [r14, #92]
vstr.32  s24, [r14, #96]
vstr.32  s25, [r14, #100]
vstr.32  s26, [r14, #104]
vstr.32  s27, [r14, #108]
vstr.32  s28, [r14, #112]
str  r8, [r14, #116]
str  r9, [r14, #120]
vstr.32  s31, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   gft_mul_v27, .-gft_mul_v27
