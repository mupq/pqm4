
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global decode_from_gft
.type decode_from_gft, %function
.align 2
decode_from_gft:
push { r0-r12, r14 }
vpush {d8-d15}
@ final state: [{0, 5, 7, 10, 12, 13, 18, 19, 21, 22, 24, 25, 26, 28, 30}, {16, 21, 23, 26, 28, 29}, {2, 3, 5, 8, 10, 15, 16, 17, 21, 22, 25, 26, 28, 29, 30}, {18, 19, 21, 24, 26, 31}, {1, 2, 3, 8, 10, 11, 12, 16, 17, 18, 19, 21, 22, 26, 27, 28, 30}, {17, 18, 19, 24, 26, 27, 28}, {3, 10, 14, 15, 18, 19, 20, 21, 23, 25, 26, 27, 28, 29, 30, 31}, {26, 19, 30, 31}, {1, 2, 3, 4, 7, 8, 9, 12, 15, 17, 20, 21, 22, 24, 25, 27, 31}, {17, 18, 19, 20, 23, 24, 25, 28, 31}, {1, 8, 9, 10, 12, 13, 14, 16, 20, 23, 25, 28, 29, 30, 31}, {17, 24, 25, 26, 28, 29, 30}, {3, 5, 6, 7, 9, 13, 15, 17, 21, 23, 24, 30, 31}, {19, 21, 22, 23, 25, 29, 31}, {2, 3, 7, 12, 15, 18, 20, 21, 22, 25, 26, 31}, {18, 19, 23, 28, 31}, {2, 5, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 27, 28, 31}, {18, 21, 23, 24, 25, 26, 27, 30, 31}, {1, 2, 3, 9, 11, 12, 13, 15, 16, 18, 19, 21, 24, 25, 31}, {17, 18, 19, 25, 27, 28, 29, 31}, {1, 3, 4, 6, 7, 9, 13, 14, 15, 18, 21, 22, 23, 24, 26}, {17, 19, 20, 22, 23, 25, 29, 30, 31}, {1, 2, 7, 9, 11, 12, 15, 17, 21, 22, 24, 27, 28, 30, 31}, {17, 18, 23, 25, 27, 28, 31}, {1, 4, 6, 8, 9, 10, 12, 13, 17, 19, 23, 24, 26, 29, 31}, {17, 20, 22, 24, 25, 26, 28, 29}, {2, 3, 6, 8, 9, 11, 14, 15, 19, 22, 24, 25, 26, 27, 28, 30}, {18, 19, 22, 24, 25, 27, 30, 31}, {1, 2, 4, 5, 8, 13, 14, 18, 20, 21, 23, 26, 29, 31}, {17, 18, 20, 21, 24, 29, 30}, {1, 2, 8, 12, 13, 15, 16, 19, 20, 23, 24, 25, 27, 28, 29, 30}, {17, 18, 24, 28, 29, 31}]

@ i = 0
@ better circuit found: #XORs = 195
@ better circuit found: #XORs = 191
@ better circuit found: #XORs = 189
@ better circuit found: #XORs = 188
@ better circuit found: #XORs = 183
@ better circuit found: #XORs = 181
@ i = 50
@ i = 100
@ better circuit found: #XORs = 178
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
@ better circuit found: #XORs = 173

@ initial state: [{0, 12, 7}, {16}, {3, 15}, {19}, {8, 11, 15}, {28}, {9}, {18}, {2}, {20}, {13, 5}, {30}, {15, 7}, {25}, {1, 7}, {23}, {6}, {26}, {11, 5}, {29}, {1, 12}, {21}, {12, 5}, {27}, {4}, {22}, {10}, {31}, {8, 5}, {24}, {14}, {17}]
@[0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 19, 20, 21, 23, 25, 29, 30, 31, 2, 6, 16, 17, 18, 22, 24, 26, 27, 28]

@instuctions with recommended mapping to GP and FP registers:
@(cycle count without considering memory stores: 588)

mov  r14, r0
mov  r12, r1
ldr  r0, [r12, #0]
ldr  r1, [r12, #48]
ldr  r2, [r12, #28]
eor r0, r1
eor r0, r2
vmov  s0, r0
ldr  r0, [r12, #64]
vmov  s1, r0
ldr  r0, [r12, #12]
ldr  r1, [r12, #60]
eor r0, r1
vmov  s2, r0
ldr  r0, [r12, #76]
vmov  s3, r0
ldr  r0, [r12, #32]
ldr  r1, [r12, #44]
ldr  r2, [r12, #60]
eor r0, r1
eor r0, r2
vmov  s4, r0
ldr  r0, [r12, #112]
vmov  s5, r0
ldr  r0, [r12, #36]
vmov  s6, r0
ldr  r0, [r12, #72]
vmov  s7, r0
ldr  r0, [r12, #8]
vmov  s8, r0
ldr  r0, [r12, #80]
vmov  s9, r0
ldr  r0, [r12, #52]
ldr  r1, [r12, #20]
eor r0, r1
vmov  s10, r0
ldr  r0, [r12, #120]
vmov  s11, r0
ldr  r0, [r12, #60]
ldr  r1, [r12, #28]
eor r0, r1
vmov  s12, r0
ldr  r0, [r12, #100]
vmov  s13, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #28]
eor r0, r1
vmov  s14, r0
ldr  r0, [r12, #92]
vmov  s15, r0
ldr  r0, [r12, #24]
vmov  s16, r0
ldr  r0, [r12, #104]
vmov  s17, r0
ldr  r0, [r12, #44]
ldr  r1, [r12, #20]
eor r0, r1
vmov  s18, r0
ldr  r0, [r12, #116]
vmov  s19, r0
ldr  r0, [r12, #4]
ldr  r1, [r12, #48]
eor r0, r1
vmov  s20, r0
ldr  r0, [r12, #84]
vmov  s21, r0
ldr  r0, [r12, #48]
ldr  r1, [r12, #20]
eor r0, r1
vmov  s22, r0
ldr  r0, [r12, #108]
vmov  s23, r0
ldr  r0, [r12, #16]
vmov  s24, r0
ldr  r0, [r12, #88]
vmov  s25, r0
ldr  r0, [r12, #40]
vmov  s26, r0
ldr  r0, [r12, #124]
vmov  s27, r0
ldr  r0, [r12, #32]
ldr  r1, [r12, #20]
eor r0, r1
vmov  s28, r0
ldr  r0, [r12, #96]
vmov  s29, r0
ldr  r0, [r12, #56]
vmov  s30, r0
ldr  r0, [r12, #68]
vmov  s31, r0
vmov  r0, s2;
vmov  r1, s6;
vmov  r2, s16;
vmov  r3, s17;
vmov  r4, s18;
vmov  r5, s22;
vmov  r6, s24;
vmov  r7, s26;
vmov  r8, s27;
vmov  r9, s28;
@// f20 ^= g6
vmov  r10, s20
eor   r10, r6
vmov  s20, r10
@// g2 ^= f1
vmov r11, s1
eor  r2, r11
@// f0 ^= g7
vmov  r10, s0
eor   r10, r7
vmov  s0, r10
@// g2 ^= g6
 eor r2, r6
@// g4 ^= g7
 eor r4, r7
@// g9 ^= g6
 eor r9, r6
@// g7 ^= f1
vmov r11, s1
eor  r7, r11
@// g6 ^= f8
vmov r11, s8
eor  r6, r11
@// f1 ^= f19
vmov  r10, s1
vmov  r11, s19
eor   r10, r11
vmov  s1, r10
@// g5 ^= f30
vmov r11, s30
eor  r5, r11
@// f0 ^= f19
vmov  r10, s0
vmov  r11, s19
eor   r10, r11
vmov  s0, r10
@// f10 ^= f19
vmov  r10, s10
vmov  r11, s19
eor   r10, r11
vmov  s10, r10
@// f19 ^= f7
vmov  r10, s19
vmov  r11, s7
eor   r10, r11
vmov  s19, r10
@// g5 ^= g3
 eor r5, r3
@// g4 ^= g8
 eor r4, r8
@// f12 ^= g6
vmov  r10, s12
eor   r10, r6
vmov  s12, r10
@// f12 ^= g2
vmov  r10, s12
eor   r10, r2
vmov  s12, r10
@// g3 ^= f7
vmov r11, s7
eor  r3, r11
@// f0 ^= f10
vmov  r10, s0
vmov  r11, s10
eor   r10, r11
vmov  s0, r10
@// g6 ^= g1
 eor r6, r1
@// f30 ^= f7
vmov  r10, s30
vmov  r11, s7
eor   r10, r11
vmov  s30, r10
@// g0 ^= g1
 eor r0, r1
@// f8 ^= f5
vmov  r10, s8
vmov  r11, s5
eor   r10, r11
vmov  s8, r10
@// f7 ^= f3
vmov  r10, s7
vmov  r11, s3
eor   r10, r11
vmov  s7, r10
@// f1 ^= f5
vmov  r10, s1
vmov  r11, s5
eor   r10, r11
vmov  s1, r10
@// f10 ^= g1
vmov  r10, s10
eor   r10, r1
vmov  s10, r10
@// g1 ^= g7
 eor r1, r7
@// g7 ^= g2
 eor r7, r2
@// f5 ^= g8
vmov  r10, s5
eor   r10, r8
vmov  s5, r10
@// g1 ^= f1
vmov r11, s1
eor  r1, r11
@// g1 ^= g0
 eor r1, r0
@// f1 ^= f3
vmov  r10, s1
vmov  r11, s3
eor   r10, r11
vmov  s1, r10
@// f1 ^= f25
vmov  r10, s1
vmov  r11, s25
eor   r10, r11
vmov  s1, r10
@// f8 ^= f23
vmov  r10, s8
vmov  r11, s23
eor   r10, r11
vmov  s8, r10
@// f4 ^= f23
vmov  r10, s4
vmov  r11, s23
eor   r10, r11
vmov  s4, r10
@// g2 ^= g9
 eor r2, r9
@// f23 ^= f3
vmov  r10, s23
vmov  r11, s3
eor   r10, r11
vmov  s23, r10
@// f8 ^= f4
vmov  r10, s8
vmov  r11, s4
eor   r10, r11
vmov  s8, r10
@// f4 ^= g9
vmov  r10, s4
eor   r10, r9
vmov  s4, r10
@// g0 ^= g6
 eor r0, r6
@// g9 ^= f25
vmov r11, s25
eor  r9, r11
@// g9 ^= g6
 eor r9, r6
@// g3 ^= g8
 eor r3, r8
@// g0 ^= f25
vmov r11, s25
eor  r0, r11
@// f4 ^= g6
vmov  r10, s4
eor   r10, r6
vmov  s4, r10
@// g6 ^= f3
vmov r11, s3
eor  r6, r11
@// g2 ^= g7
 eor r2, r7
@// g8 ^= f25
vmov r11, s25
eor  r8, r11
@// g7 ^= f3
vmov r11, s3
eor  r7, r11
@// f3 ^= f21
vmov  r10, s3
vmov  r11, s21
eor   r10, r11
vmov  s3, r10
@// g2 ^= f20
vmov r11, s20
eor  r2, r11
@// g1 ^= f9
vmov r11, s9
eor  r1, r11
@// g8 ^= f21
vmov r11, s21
eor  r8, r11
@// g2 ^= f21
vmov r11, s21
eor  r2, r11
@// f10 ^= f15
vmov  r10, s10
vmov  r11, s15
eor   r10, r11
vmov  s10, r10
@// f21 ^= f9
vmov  r10, s21
vmov  r11, s9
eor   r10, r11
vmov  s21, r10
@// f8 ^= f13
vmov  r10, s8
vmov  r11, s13
eor   r10, r11
vmov  s8, r10
@// f25 ^= f9
vmov  r10, s25
vmov  r11, s9
eor   r10, r11
vmov  s25, r10
@// f8 ^= g0
vmov  r10, s8
eor   r10, r0
vmov  s8, r10
@// f23 ^= f13
vmov  r10, s23
vmov  r11, s13
eor   r10, r11
vmov  s23, r10
@// g4 ^= f15
vmov r11, s15
eor  r4, r11
@// f12 ^= f13
vmov  r10, s12
vmov  r11, s13
eor   r10, r11
vmov  s12, r10
@// f12 ^= f23
vmov  r10, s12
vmov  r11, s23
eor   r10, r11
vmov  s12, r10
@// f9 ^= f13
vmov  r10, s9
vmov  r11, s13
eor   r10, r11
vmov  s9, r10
@// g6 ^= f13
vmov r11, s13
eor  r6, r11
@// f13 ^= f19
vmov  r10, s13
vmov  r11, s19
eor   r10, r11
vmov  s13, r10
@// f13 ^= g3
vmov  r10, s13
eor   r10, r3
vmov  s13, r10
@// f3 ^= f29
vmov  r10, s3
vmov  r11, s29
eor   r10, r11
vmov  s3, r10
@// g1 ^= f15
vmov r11, s15
eor  r1, r11
@// g6 ^= f20
vmov r11, s20
eor  r6, r11
@// f23 ^= f31
vmov  r10, s23
vmov  r11, s31
eor   r10, r11
vmov  s23, r10
@// f15 ^= f7
vmov  r10, s15
vmov  r11, s7
eor   r10, r11
vmov  s15, r10
@// f7 ^= f11
vmov  r10, s7
vmov  r11, s11
eor   r10, r11
vmov  s7, r10
@// g9 ^= f10
vmov r11, s10
eor  r9, r11
@// f25 ^= f11
vmov  r10, s25
vmov  r11, s11
eor   r10, r11
vmov  s25, r10
@// f3 ^= f7
vmov  r10, s3
vmov  r11, s7
eor   r10, r11
vmov  s3, r10
@// f12 ^= f15
vmov  r10, s12
vmov  r11, s15
eor   r10, r11
vmov  s12, r10
@// f7 ^= g3
vmov  r10, s7
eor   r10, r3
vmov  s7, r10
@// f10 ^= f9
vmov  r10, s10
vmov  r11, s9
eor   r10, r11
vmov  s10, r10
@// f0 ^= f9
vmov  r10, s0
vmov  r11, s9
eor   r10, r11
vmov  s0, r10
@// f9 ^= f29
vmov  r10, s9
vmov  r11, s29
eor   r10, r11
vmov  s9, r10
@// g0 ^= f20
vmov r11, s20
eor  r0, r11
@// f20 ^= g5
vmov  r10, s20
eor   r10, r5
vmov  s20, r10
@// g5 ^= f5
vmov r11, s5
eor  r5, r11
@// g5 ^= g4
 eor r5, r4
@// g3 ^= g8
 eor r3, r8
@// g3 ^= f15
vmov r11, s15
eor  r3, r11
@// f11 ^= f31
vmov  r10, s11
vmov  r11, s31
eor   r10, r11
vmov  s11, r10
@// g0 ^= f29
vmov r11, s29
eor  r0, r11
@// f8 ^= f25
vmov  r10, s8
vmov  r11, s25
eor   r10, r11
vmov  s8, r10
@// f0 ^= f25
vmov  r10, s0
vmov  r11, s25
eor   r10, r11
vmov  s0, r10
@// f20 ^= f29
vmov  r10, s20
vmov  r11, s29
eor   r10, r11
vmov  s20, r10
@// g8 ^= f31
vmov r11, s31
eor  r8, r11
@// f9 ^= f31
vmov  r10, s9
vmov  r11, s31
eor   r10, r11
vmov  s9, r10
@// g5 ^= g3
 eor r5, r3
@// f30 ^= f29
vmov  r10, s30
vmov  r11, s29
eor   r10, r11
vmov  s30, r10
@// f14 ^= f21
vmov  r10, s14
vmov  r11, s21
eor   r10, r11
vmov  s14, r10
@// f21 ^= f11
vmov  r10, s21
vmov  r11, s11
eor   r10, r11
vmov  s21, r10
@// f11 ^= f19
vmov  r10, s11
vmov  r11, s19
eor   r10, r11
vmov  s11, r10
@// f29 ^= f19
vmov  r10, s29
vmov  r11, s19
eor   r10, r11
vmov  s29, r10
@// g4 ^= f4
vmov r11, s4
eor  r4, r11
@// f4 ^= f19
vmov  r10, s4
vmov  r11, s19
eor   r10, r11
vmov  s4, r10
@// f19 ^= f15
vmov  r10, s19
vmov  r11, s15
eor   r10, r11
vmov  s19, r10
@// f1 ^= g3
vmov  r10, s1
eor   r10, r3
vmov  s1, r10
@// f30 ^= f15
vmov  r10, s30
vmov  r11, s15
eor   r10, r11
vmov  s30, r10
@// f31 ^= f5
vmov  r10, s31
vmov  r11, s5
eor   r10, r11
vmov  s31, r10
@// f15 ^= f5
vmov  r10, s15
vmov  r11, s5
eor   r10, r11
vmov  s15, r10
@// f0 ^= f5
vmov  r10, s0
vmov  r11, s5
eor   r10, r11
vmov  s0, r10
@// f5 ^= f13
vmov  r10, s5
vmov  r11, s13
eor   r10, r11
vmov  s5, r10
@// f5 ^= f29
vmov  r10, s5
vmov  r11, s29
eor   r10, r11
vmov  s5, r10
@// g7 ^= f7
vmov r11, s7
eor  r7, r11
@// g7 ^= f25
vmov r11, s25
eor  r7, r11
@// g1 ^= f30
vmov r11, s30
eor  r1, r11
@// g5 ^= f14
vmov r11, s14
eor  r5, r11
@// f14 ^= f29
vmov  r10, s14
vmov  r11, s29
eor   r10, r11
vmov  s14, r10
@// f14 ^= g0
vmov  r10, s14
eor   r10, r0
vmov  s14, r10
@// g0 ^= g2
 eor r0, r2
@// g2 ^= f3
vmov r11, s3
eor  r2, r11
@// g2 ^= f30
vmov r11, s30
eor  r2, r11
@// f30 ^= g4
vmov  r10, s30
eor   r10, r4
vmov  s30, r10
@// g4 ^= g9
 eor r4, r9
@// g5 ^= f21
vmov r11, s21
eor  r5, r11
@// f4 ^= g6
vmov  r10, s4
eor   r10, r6
vmov  s4, r10
@// g6 ^= f9
vmov r11, s9
eor  r6, r11
@// f12 ^= f11
vmov  r10, s12
vmov  r11, s11
eor   r10, r11
vmov  s12, r10
@// g8 ^= f3
vmov r11, s3
eor  r8, r11
@// f11 ^= f5
vmov  r10, s11
vmov  r11, s5
eor   r10, r11
vmov  s11, r10
@// f5 ^= f23
vmov  r10, s5
vmov  r11, s23
eor   r10, r11
vmov  s5, r10
@// f20 ^= g8
vmov  r10, s20
eor   r10, r8
vmov  s20, r10
@// g8 ^= f23
vmov r11, s23
eor  r8, r11
@// f14 ^= f13
vmov  r10, s14
vmov  r11, s13
eor   r10, r11
vmov  s14, r10
@// g4 ^= g0
 eor r4, r0
@// f3 ^= f7
vmov  r10, s3
vmov  r11, s7
eor   r10, r11
vmov  s3, r10
@// f31 ^= f29
vmov  r10, s31
vmov  r11, s29
eor   r10, r11
vmov  s31, r10
@// g6 ^= g9
 eor r6, r9
@// g6 ^= g7
 eor r6, r7
@// f10 ^= f15
vmov  r10, s10
vmov  r11, s15
eor   r10, r11
vmov  s10, r10
@// f23 ^= f15
vmov  r10, s23
vmov  r11, s15
eor   r10, r11
vmov  s23, r10
@// f13 ^= g3
vmov  r10, s13
eor   r10, r3
vmov  s13, r10
@// g5 ^= f30
vmov r11, s30
eor  r5, r11
@// f12 ^= g4
vmov  r10, s12
eor   r10, r4
vmov  s12, r10
@// g9 ^= f21
vmov r11, s21
eor  r9, r11
@// g7 ^= f8
vmov r11, s8
eor  r7, r11
@// g9 ^= f20
vmov r11, s20
eor  r9, r11
@// f29 ^= f21
vmov  r10, s29
vmov  r11, s21
eor   r10, r11
vmov  s29, r10
@// g3 ^= g8
 eor r3, r8
@// g4 ^= f4
vmov r11, s4
eor  r4, r11
@// f0 ^= f3
vmov  r10, s0
vmov  r11, s3
eor   r10, r11
vmov  s0, r10
@// f10 ^= g2
vmov  r10, s10
eor   r10, r2
vmov  s10, r10
@// f25 ^= f11
vmov  r10, s25
vmov  r11, s11
eor   r10, r11
vmov  s25, r10
@// f20 ^= f12
vmov  r10, s20
vmov  r11, s12
eor   r10, r11
vmov  s20, r10
@// g7 ^= f30
vmov r11, s30
eor  r7, r11
@// f9 ^= f15
vmov  r10, s9
vmov  r11, s15
eor   r10, r11
vmov  s9, r10
@// f21 ^= f13
vmov  r10, s21
vmov  r11, s13
eor   r10, r11
vmov  s21, r10
@// g0 ^= f11
vmov r11, s11
eor  r0, r11
@// f19 ^= f23
vmov  r10, s19
vmov  r11, s23
eor   r10, r11
vmov  s19, r10
@// g1 ^= g3
 eor r1, r3
@// f30 ^= f10
vmov  r10, s30
vmov  r11, s10
eor   r10, r11
vmov  s30, r10
@// f4 ^= g0
vmov  r10, s4
eor   r10, r0
vmov  s4, r10
@// g2 ^= g5
 eor r2, r5
@// f8 ^= g5
vmov  r10, s8
eor   r10, r5
vmov  s8, r10
vstr.32  s0, [r14, #0]
vstr.32  s1, [r14, #4]
str  r0, [r14, #8]
vstr.32  s3, [r14, #12]
vstr.32  s4, [r14, #16]
vstr.32  s5, [r14, #20]
str  r1, [r14, #24]
vstr.32  s7, [r14, #28]
vstr.32  s8, [r14, #32]
vstr.32  s9, [r14, #36]
vstr.32  s10, [r14, #40]
vstr.32  s11, [r14, #44]
vstr.32  s12, [r14, #48]
vstr.32  s13, [r14, #52]
vstr.32  s14, [r14, #56]
vstr.32  s15, [r14, #60]
str  r2, [r14, #64]
str  r3, [r14, #68]
str  r4, [r14, #72]
vstr.32  s19, [r14, #76]
vstr.32  s20, [r14, #80]
vstr.32  s21, [r14, #84]
str  r5, [r14, #88]
vstr.32  s23, [r14, #92]
str  r6, [r14, #96]
vstr.32  s25, [r14, #100]
str  r7, [r14, #104]
str  r8, [r14, #108]
str  r9, [r14, #112]
vstr.32  s29, [r14, #116]
vstr.32  s30, [r14, #120]
vstr.32  s31, [r14, #124]
vpop { d8-d15 }
pop { r0-r12, r14 }
bx lr
.size   decode_from_gft, .-decode_from_gft
