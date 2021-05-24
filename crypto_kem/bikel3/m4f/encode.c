#include "encode.h"

#include "run_config.h"

void encode_to_gft( uint32_t * out , const uint32_t * in ) {
const uint32_t * b = in;
uint32_t g0,g1,g2,g3, g4,g5,g6,g7, g8,g9,g10,g11;
uint32_t f0,f1,f2,f3, f4,f5,f6,f7, f8,f9,f10,f11;
uint32_t f12,f13,f14,f15, f16,f17,f18,f19, f20,f21,f22,f23, f24,f25,f26,f27, f28,f29,f30,f31;
// final state: [{0, 1, 2, 4, 8, 11}, {1, 4, 7, 9, 12, 14}, {3, 4, 5, 8, 9, 12, 13, 14}, {1, 2, 3, 7, 8, 9, 10, 12, 14}, {1, 2, 3, 4, 6, 7, 8, 9, 11}, {2, 3, 4, 5, 6, 8, 10, 11, 12, 13, 14}, {2, 5, 6, 8, 12, 13, 15}, {1, 2, 3, 9, 10, 11, 15}, {1, 12, 4, 5}, {1, 2, 3, 4, 5, 6, 7, 9, 11, 15}, {1, 4, 5, 8, 10, 11, 12}, {1, 3, 5, 6, 7, 8, 9, 10, 11, 14}, {2, 4, 5, 6, 7, 9, 10, 12, 13, 15}, {1, 3, 7, 8, 9, 11, 12, 14, 15}, {4, 5, 9, 10, 11, 12, 13, 15}, {2, 5, 6, 7, 9, 10, 12, 13, 14, 15}, {1, 3, 5, 9}, {13, 5, 15}, {9, 13, 5, 15}, {3, 9, 11, 13, 15}, {9, 3, 5, 7}, {3, 5, 7, 9, 11, 13, 15}, {9, 3, 13, 7}, {11, 3}, {13, 5}, {3, 5, 7}, {9, 13, 11, 5}, {9, 11, 15, 7}, {3, 5, 7, 11, 13}, {9, 13, 15}, {13, 11, 5}, {3, 7, 11, 13, 15}]

// i = 0
// better circuit found: #XORs = 78
// better circuit found: #XORs = 73
// i = 50
// better circuit found: #XORs = 72
// i = 100
// better circuit found: #XORs = 71
// i = 150
// i = 200
// i = 250
// i = 300
// i = 350
// i = 400
// i = 450
// better circuit found: #XORs = 68
// i = 500
// i = 550
// i = 600
// i = 650
// i = 700
// i = 750
// i = 800
// i = 850
// i = 900
// i = 950

// initial state: [{0, 1, 2}, {14}, {13}, set(), {4}, {6}, {12}, {1}, {4, 12}, {8}, {10}, {11}, {2}, set(), {10, 11}, {4, 14}, set(), {15}, set(), {3}, {9}, set(), {3}, set(), {5}, set(), {9}, {11, 7}, {3}, set(), set(), {7}]
//[0, 5, 6, 7, 8, 10, 14, 15, 16, 17, 18, 19, 20, 22, 23, 24, 26, 27, 28, 29, 30, 31, 1, 2, 3, 4, 9, 11, 12, 13, 21, 25]

//instuctions with recommended mapping to GP and FP registers:
//(cycle count without considering memory stores: 287)

g0 = b[0];
g1 = b[1];
g2 = b[2];
g0 ^= g1;
g0 ^= g2;
f0 = g0;
g0 = b[14];
f1 = g0;
g0 = b[13];
f2 = g0;
g0 = b[4];
f4 = g0;
g0 = b[6];
f5 = g0;
g0 = b[12];
f6 = g0;
g0 = b[1];
f7 = g0;
g0 = b[4];
g1 = b[12];
g0 ^= g1;
f8 = g0;
g0 = b[8];
f9 = g0;
g0 = b[10];
f10 = g0;
g0 = b[11];
f11 = g0;
g0 = b[2];
f12 = g0;
g0 = b[10];
g1 = b[11];
g0 ^= g1;
f14 = g0;
g0 = b[4];
g1 = b[14];
g0 ^= g1;
f15 = g0;
g0 = b[15];
f17 = g0;
g0 = b[3];
f19 = g0;
g0 = b[9];
f20 = g0;
g0 = b[3];
f22 = g0;
g0 = b[5];
f24 = g0;
g0 = b[9];
f26 = g0;
g0 = b[11];
g1 = b[7];
g0 ^= g1;
f27 = g0;
g0 = b[3];
f28 = g0;
g0 = b[7];
f31 = g0;
g0 = f1;
g1 = f2;
g3 = f4;
g4 = f9;
g5 = f11;
g6 = f12;
// f28 ^= f31
g10 = f28;
g11 = f31;
g10 ^= g11;
f28 = g10;
// f16 = f24
f16 = f24;
// g2 = f17
g2 = f17;
// g3 ^= g4
g3 ^= g4;
// g2 ^= g6
g2 ^= g6;
// f29 = g1
f29 = g1;
// f24 ^= g1
g10 = f24;
g10 ^= g1;
f24 = g10;
// f0 ^= g5
g10 = f0;
g10 ^= g5;
f0 = g10;
// f10 ^= g4
g10 = f10;
g10 ^= g4;
f10 = g10;
// g4 ^= f17
g11 = f17;
g4 ^= g11;
// g9 = f16
g9 = f16;
// g8 = f26
g8 = f26;
// g8 ^= f17
g11 = f17;
g8 ^= g11;
// f19 ^= g5
g10 = f19;
g10 ^= g5;
f19 = g10;
// g6 ^= f5
g11 = f5;
g6 ^= g11;
// g2 ^= f14
g11 = f14;
g2 ^= g11;
// f14 ^= f8
g10 = f14;
g11 = f8;
g10 ^= g11;
f14 = g10;
// f8 ^= f7
g10 = f8;
g11 = f7;
g10 ^= g11;
f8 = g10;
// f18 = g9
f18 = g9;
// g7 = f17
g7 = f17;
// f6 ^= g1
g10 = f6;
g10 ^= g1;
f6 = g10;
// g0 ^= f31
g11 = f31;
g0 ^= g11;
// f10 ^= g5
g10 = f10;
g10 ^= g5;
f10 = g10;
// g0 ^= f26
g11 = f26;
g0 ^= g11;
// g0 ^= f16
g11 = f16;
g0 ^= g11;
// f22 ^= f26
g10 = f22;
g11 = f26;
g10 ^= g11;
f22 = g10;
// g4 ^= g9
g4 ^= g9;
// f31 ^= g1
g10 = f31;
g10 ^= g1;
f31 = g10;
// f8 ^= g9
g10 = f8;
g10 ^= g9;
f8 = g10;
// f6 ^= g6
g10 = f6;
g10 ^= g6;
f6 = g10;
// f29 ^= g8
g10 = f29;
g10 ^= g8;
f29 = g10;
// g6 ^= f27
g11 = f27;
g6 ^= g11;
// f27 ^= g8
g10 = f27;
g10 ^= g8;
f27 = g10;
// f5 ^= g8
g10 = f5;
g10 ^= g8;
f5 = g10;
// g1 ^= f15
g11 = f15;
g1 ^= g11;
// g5 ^= f24
g11 = f24;
g5 ^= g11;
// f7 ^= f22
g10 = f7;
g11 = f22;
g10 ^= g11;
f7 = g10;
// g9 ^= f28
g11 = f28;
g9 ^= g11;
// f17 ^= f24
g10 = f17;
g11 = f24;
g10 ^= g11;
f17 = g10;
// g1 ^= f8
g11 = f8;
g1 ^= g11;
// f23 = f19
f23 = f19;
// f5 ^= g2
g10 = f5;
g10 ^= g2;
f5 = g10;
// f22 ^= f31
g10 = f22;
g11 = f31;
g10 ^= g11;
f22 = g10;
// g0 ^= f8
g11 = f8;
g0 ^= g11;
// f30 = g5
f30 = g5;
// g5 ^= f6
g11 = f6;
g5 ^= g11;
// g7 ^= f19
g11 = f19;
g7 ^= g11;
// f31 ^= g7
g10 = f31;
g10 ^= g7;
f31 = g10;
// g7 ^= g3
g7 ^= g3;
// f0 ^= g3
g10 = f0;
g10 ^= g3;
f0 = g10;
// f16 ^= f7
g10 = f16;
g11 = f7;
g10 ^= g11;
f16 = g10;
// g3 ^= f7
g11 = f7;
g3 ^= g11;
// f18 ^= f29
g10 = f18;
g11 = f29;
g10 ^= g11;
f18 = g10;
// f20 ^= g9
g10 = f20;
g10 ^= g9;
f20 = g10;
// f26 ^= f30
g10 = f26;
g11 = f30;
g10 ^= g11;
f26 = g10;
// g1 ^= g3
g1 ^= g3;
// f19 ^= f29
g10 = f19;
g11 = f29;
g10 ^= g11;
f19 = g10;
// f28 ^= f30
g10 = f28;
g11 = f30;
g10 ^= g11;
f28 = g10;
// f6 ^= g4
g10 = f6;
g10 ^= g4;
f6 = g10;
// f7 ^= g2
g10 = f7;
g10 ^= g2;
f7 = g10;
// g3 ^= g6
g3 ^= g6;
// f14 ^= f18
g10 = f14;
g11 = f18;
g10 ^= g11;
f14 = g10;
// g7 ^= g0
g7 ^= g0;
// f10 ^= f8
g10 = f10;
g11 = f8;
g10 ^= g11;
f10 = g10;
// g2 ^= g7
g2 ^= g7;
// g8 ^= f28
g11 = f28;
g8 ^= g11;
// g5 ^= g2
g5 ^= g2;
// f5 ^= g1
g10 = f5;
g10 ^= g1;
f5 = g10;
// g6 ^= f14
g11 = f14;
g6 ^= g11;
// g4 ^= g3
g4 ^= g3;
// f15 ^= g6
g10 = f15;
g10 ^= g6;
f15 = g10;
out[0] = f0;
out[1] = g0;
out[2] = g1;
out[3] = g2;
out[4] = g3;
out[5] = f5;
out[6] = f6;
out[7] = f7;
out[8] = f8;
out[9] = g4;
out[10] = f10;
out[11] = g5;
out[12] = g6;
out[13] = g7;
out[14] = f14;
out[15] = f15;
out[16] = f16;
out[17] = f17;
out[18] = f18;
out[19] = f19;
out[20] = f20;
out[21] = g8;
out[22] = f22;
out[23] = f23;
out[24] = f24;
out[25] = g9;
out[26] = f26;
out[27] = f27;
out[28] = f28;
out[29] = f29;
out[30] = f30;
out[31] = f31;
}

#if !defined(_M4_ASM_)

#include "encode.h"

void decode_from_gft( uint32_t * out , const uint32_t * in ) {
const uint32_t * b = in;
uint32_t g0,g1,g2,g3, g4,g5,g6,g7, g8,g9,g10,g11;
uint32_t f0,f1,f2,f3, f4,f5,f6,f7, f8,f9,f10,f11;
uint32_t f12,f13,f14,f15, f16,f17,f18,f19, f20,f21,f22,f23, f24,f25,f26,f27, f28,f29,f30,f31;
// final state: [{0, 5, 7, 10, 12, 13, 18, 19, 21, 22, 24, 25, 26, 28, 30}, {16, 21, 23, 26, 28, 29}, {2, 3, 5, 8, 10, 15, 16, 17, 21, 22, 25, 26, 28, 29, 30}, {18, 19, 21, 24, 26, 31}, {1, 2, 3, 8, 10, 11, 12, 16, 17, 18, 19, 21, 22, 26, 27, 28, 30}, {17, 18, 19, 24, 26, 27, 28}, {3, 10, 14, 15, 18, 19, 20, 21, 23, 25, 26, 27, 28, 29, 30, 31}, {26, 19, 30, 31}, {1, 2, 3, 4, 7, 8, 9, 12, 15, 17, 20, 21, 22, 24, 25, 27, 31}, {17, 18, 19, 20, 23, 24, 25, 28, 31}, {1, 8, 9, 10, 12, 13, 14, 16, 20, 23, 25, 28, 29, 30, 31}, {17, 24, 25, 26, 28, 29, 30}, {3, 5, 6, 7, 9, 13, 15, 17, 21, 23, 24, 30, 31}, {19, 21, 22, 23, 25, 29, 31}, {2, 3, 7, 12, 15, 18, 20, 21, 22, 25, 26, 31}, {18, 19, 23, 28, 31}, {2, 5, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 27, 28, 31}, {18, 21, 23, 24, 25, 26, 27, 30, 31}, {1, 2, 3, 9, 11, 12, 13, 15, 16, 18, 19, 21, 24, 25, 31}, {17, 18, 19, 25, 27, 28, 29, 31}, {1, 3, 4, 6, 7, 9, 13, 14, 15, 18, 21, 22, 23, 24, 26}, {17, 19, 20, 22, 23, 25, 29, 30, 31}, {1, 2, 7, 9, 11, 12, 15, 17, 21, 22, 24, 27, 28, 30, 31}, {17, 18, 23, 25, 27, 28, 31}, {1, 4, 6, 8, 9, 10, 12, 13, 17, 19, 23, 24, 26, 29, 31}, {17, 20, 22, 24, 25, 26, 28, 29}, {2, 3, 6, 8, 9, 11, 14, 15, 19, 22, 24, 25, 26, 27, 28, 30}, {18, 19, 22, 24, 25, 27, 30, 31}, {1, 2, 4, 5, 8, 13, 14, 18, 20, 21, 23, 26, 29, 31}, {17, 18, 20, 21, 24, 29, 30}, {1, 2, 8, 12, 13, 15, 16, 19, 20, 23, 24, 25, 27, 28, 29, 30}, {17, 18, 24, 28, 29, 31}]

// i = 0
// better circuit found: #XORs = 187
// better circuit found: #XORs = 186
// better circuit found: #XORs = 185
// better circuit found: #XORs = 184
// better circuit found: #XORs = 181
// better circuit found: #XORs = 180
// i = 50
// i = 100
// i = 150
// i = 200
// better circuit found: #XORs = 179
// i = 250
// i = 300
// i = 350
// i = 400
// i = 450
// i = 500
// i = 550
// i = 600
// i = 650
// better circuit found: #XORs = 178
// i = 700
// i = 750
// i = 800
// i = 850
// i = 900
// i = 950

// initial state: [{0, 5, 7, 10, 12, 13, 28, 30}, {16, 18}, {2, 3, 5, 11, 18, 22}, {18, 23}, {1, 2, 11, 31}, {28, 22}, {3, 10, 15, 20, 28}, {27}, {3, 4, 8, 11}, {24, 20}, {5, 9, 13, 20}, {24, 30}, {2, 6, 7, 15, 23}, {28, 31}, {2, 5, 12, 15, 26}, {19}, {8, 10, 11, 15, 24}, {26, 29, 22}, {4, 7, 9, 31}, {29, 23}, {1, 4, 5, 22}, {21}, {3, 5, 7, 14, 20}, {25}, {1, 2, 9, 12}, {20, 22, 30}, {10, 4, 6}, {26, 30, 31}, {2, 8, 13, 22}, {18, 14}, {24, 29, 14}, {17}]
//[0, 1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 19, 20, 24, 25, 28, 29, 31, 4, 5, 15, 18, 21, 22, 23, 26, 27, 30]

//instuctions with recommended mapping to GP and FP registers:
//(cycle count without considering memory stores: 544)

g0 = b[0];
g1 = b[5];
g2 = b[7];
g3 = b[10];
g4 = b[12];
g5 = b[13];
g6 = b[28];
g7 = b[30];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
g0 ^= g4;
g0 ^= g5;
g0 ^= g6;
g0 ^= g7;
f0 = g0;
g0 = b[16];
g1 = b[18];
g0 ^= g1;
f1 = g0;
g0 = b[2];
g1 = b[3];
g2 = b[5];
g3 = b[11];
g4 = b[18];
g5 = b[22];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
g0 ^= g4;
g0 ^= g5;
f2 = g0;
g0 = b[18];
g1 = b[23];
g0 ^= g1;
f3 = g0;
g0 = b[1];
g1 = b[2];
g2 = b[11];
g3 = b[31];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
f4 = g0;
g0 = b[28];
g1 = b[22];
g0 ^= g1;
f5 = g0;
g0 = b[3];
g1 = b[10];
g2 = b[15];
g3 = b[20];
g4 = b[28];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
g0 ^= g4;
f6 = g0;
g0 = b[27];
f7 = g0;
g0 = b[3];
g1 = b[4];
g2 = b[8];
g3 = b[11];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
f8 = g0;
g0 = b[24];
g1 = b[20];
g0 ^= g1;
f9 = g0;
g0 = b[5];
g1 = b[9];
g2 = b[13];
g3 = b[20];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
f10 = g0;
g0 = b[24];
g1 = b[30];
g0 ^= g1;
f11 = g0;
g0 = b[2];
g1 = b[6];
g2 = b[7];
g3 = b[15];
g4 = b[23];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
g0 ^= g4;
f12 = g0;
g0 = b[28];
g1 = b[31];
g0 ^= g1;
f13 = g0;
g0 = b[2];
g1 = b[5];
g2 = b[12];
g3 = b[15];
g4 = b[26];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
g0 ^= g4;
f14 = g0;
g0 = b[19];
f15 = g0;
g0 = b[8];
g1 = b[10];
g2 = b[11];
g3 = b[15];
g4 = b[24];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
g0 ^= g4;
f16 = g0;
g0 = b[26];
g1 = b[29];
g2 = b[22];
g0 ^= g1;
g0 ^= g2;
f17 = g0;
g0 = b[4];
g1 = b[7];
g2 = b[9];
g3 = b[31];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
f18 = g0;
g0 = b[29];
g1 = b[23];
g0 ^= g1;
f19 = g0;
g0 = b[1];
g1 = b[4];
g2 = b[5];
g3 = b[22];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
f20 = g0;
g0 = b[21];
f21 = g0;
g0 = b[3];
g1 = b[5];
g2 = b[7];
g3 = b[14];
g4 = b[20];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
g0 ^= g4;
f22 = g0;
g0 = b[25];
f23 = g0;
g0 = b[1];
g1 = b[2];
g2 = b[9];
g3 = b[12];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
f24 = g0;
g0 = b[20];
g1 = b[22];
g2 = b[30];
g0 ^= g1;
g0 ^= g2;
f25 = g0;
g0 = b[10];
g1 = b[4];
g2 = b[6];
g0 ^= g1;
g0 ^= g2;
f26 = g0;
g0 = b[26];
g1 = b[30];
g2 = b[31];
g0 ^= g1;
g0 ^= g2;
f27 = g0;
g0 = b[2];
g1 = b[8];
g2 = b[13];
g3 = b[22];
g0 ^= g1;
g0 ^= g2;
g0 ^= g3;
f28 = g0;
g0 = b[18];
g1 = b[14];
g0 ^= g1;
f29 = g0;
g0 = b[24];
g1 = b[29];
g2 = b[14];
g0 ^= g1;
g0 ^= g2;
f30 = g0;
g0 = b[17];
f31 = g0;
g0 = f4;
g1 = f5;
g2 = f15;
g3 = f18;
g4 = f21;
g5 = f22;
g6 = f23;
g7 = f26;
g8 = f27;
g9 = f30;
// f19 ^= g2
g10 = f19;
g10 ^= g2;
f19 = g10;
// f6 ^= g2
g10 = f6;
g10 ^= g2;
f6 = g10;
// f20 ^= g2
g10 = f20;
g10 ^= g2;
f20 = g10;
// g0 ^= g8
g0 ^= g8;
// f12 ^= f7
g10 = f12;
g11 = f7;
g10 ^= g11;
f12 = g10;
// g8 ^= f7
g11 = f7;
g8 ^= g11;
// g3 ^= g7
g3 ^= g7;
// g1 ^= g6
g1 ^= g6;
// f28 ^= g2
g10 = f28;
g10 ^= g2;
f28 = g10;
// g7 ^= f7
g11 = f7;
g7 ^= g11;
// f7 ^= g2
g10 = f7;
g10 ^= g2;
f7 = g10;
// f3 ^= g6
g10 = f3;
g10 ^= g6;
f3 = g10;
// g2 ^= g6
g2 ^= g6;
// g6 ^= f31
g11 = f31;
g6 ^= g11;
// g0 ^= f14
g11 = f14;
g0 ^= g11;
// f14 ^= f29
g10 = f14;
g11 = f29;
g10 ^= g11;
f14 = g10;
// f14 ^= g5
g10 = f14;
g10 ^= g5;
f14 = g10;
// g5 ^= f25
g11 = f25;
g5 ^= g11;
// f10 ^= g2
g10 = f10;
g10 ^= g2;
f10 = g10;
// f24 ^= g2
g10 = f24;
g10 ^= g2;
f24 = g10;
// g2 ^= g1
g2 ^= g1;
// f20 ^= f31
g10 = f20;
g11 = f31;
g10 ^= g11;
f20 = g10;
// f11 ^= f31
g10 = f11;
g11 = f31;
g10 ^= g11;
f11 = g10;
// f31 ^= f13
g10 = f31;
g11 = f13;
g10 ^= g11;
f31 = g10;
// f13 ^= g1
g10 = f13;
g10 ^= g1;
f13 = g10;
// g2 ^= f13
g11 = f13;
g2 ^= g11;
// f13 ^= g4
g10 = f13;
g10 ^= g4;
f13 = g10;
// f0 ^= g4
g10 = f0;
g10 ^= g4;
f0 = g10;
// f8 ^= g1
g10 = f8;
g10 ^= g1;
f8 = g10;
// g1 ^= f17
g11 = f17;
g1 ^= g11;
// f17 ^= g4
g10 = f17;
g10 ^= g4;
f17 = g10;
// f2 ^= g4
g10 = f2;
g10 ^= g4;
f2 = g10;
// f20 ^= f29
g10 = f20;
g11 = f29;
g10 ^= g11;
f20 = g10;
// f29 ^= g9
g10 = f29;
g10 ^= g9;
f29 = g10;
// g2 ^= f3
g11 = f3;
g2 ^= g11;
// g1 ^= f29
g11 = f29;
g1 ^= g11;
// f8 ^= f25
g10 = f8;
g11 = f25;
g10 ^= g11;
f8 = g10;
// f28 ^= f19
g10 = f28;
g11 = f19;
g10 ^= g11;
f28 = g10;
// g3 ^= f12
g11 = f12;
g3 ^= g11;
// f12 ^= f1
g10 = f12;
g11 = f1;
g10 ^= g11;
f12 = g10;
// f16 ^= f1
g10 = f16;
g11 = f1;
g10 ^= g11;
f16 = g10;
// f1 ^= f29
g10 = f1;
g11 = f29;
g10 ^= g11;
f1 = g10;
// f17 ^= f19
g10 = f17;
g11 = f19;
g10 ^= g11;
f17 = g10;
// f3 ^= g4
g10 = f3;
g10 ^= g4;
f3 = g10;
// f3 ^= g1
g10 = f3;
g10 ^= g1;
f3 = g10;
// f10 ^= f19
g10 = f10;
g11 = f19;
g10 ^= g11;
f10 = g10;
// f1 ^= f3
g10 = f1;
g11 = f3;
g10 ^= g11;
f1 = g10;
// f3 ^= g2
g10 = f3;
g10 ^= g2;
f3 = g10;
// g4 ^= f9
g11 = f9;
g4 ^= g11;
// g4 ^= f11
g11 = f11;
g4 ^= g11;
// g7 ^= g8
g7 ^= g8;
// g7 ^= f25
g11 = f25;
g7 ^= g11;
// g5 ^= g0
g5 ^= g0;
// g5 ^= f6
g11 = f6;
g5 ^= g11;
// f6 ^= f19
g10 = f6;
g11 = f19;
g10 ^= g11;
f6 = g10;
// g9 ^= f19
g11 = f19;
g9 ^= g11;
// f11 ^= f29
g10 = f11;
g11 = f29;
g10 ^= g11;
f11 = g10;
// f9 ^= g6
g10 = f9;
g10 ^= g6;
f9 = g10;
// f2 ^= f16
g10 = f2;
g11 = f16;
g10 ^= g11;
f2 = g10;
// f16 ^= g0
g10 = f16;
g10 ^= g0;
f16 = g10;
// g0 ^= f11
g11 = f11;
g0 ^= g11;
// g6 ^= f7
g11 = f7;
g6 ^= g11;
// f0 ^= g8
g10 = f0;
g10 ^= g8;
f0 = g10;
// g5 ^= g4
g5 ^= g4;
// f7 ^= g8
g10 = f7;
g10 ^= g8;
f7 = g10;
// f6 ^= g9
g10 = f6;
g10 ^= g9;
f6 = g10;
// f16 ^= g9
g10 = f16;
g10 ^= g9;
f16 = g10;
// f24 ^= f9
g10 = f24;
g11 = f9;
g10 ^= g11;
f24 = g10;
// f12 ^= f11
g10 = f12;
g11 = f11;
g10 ^= g11;
f12 = g10;
// g8 ^= f3
g11 = f3;
g8 ^= g11;
// f20 ^= f7
g10 = f20;
g11 = f7;
g10 ^= g11;
f20 = g10;
// g9 ^= g3
g9 ^= g3;
// g3 ^= f28
g11 = f28;
g3 ^= g11;
// f11 ^= g1
g10 = f11;
g10 ^= g1;
f11 = g10;
// g1 ^= g6
g1 ^= g6;
// g0 ^= g6
g0 ^= g6;
// g3 ^= f2
g11 = f2;
g3 ^= g11;
// g8 ^= f13
g11 = f13;
g8 ^= g11;
// f14 ^= f13
g10 = f14;
g11 = f13;
g10 ^= g11;
f14 = g10;
// f13 ^= f19
g10 = f13;
g11 = f19;
g10 ^= g11;
f13 = g10;
// g6 ^= g2
g6 ^= g2;
// f24 ^= f28
g10 = f24;
g11 = f28;
g10 ^= g11;
f24 = g10;
// f24 ^= g7
g10 = f24;
g10 ^= g7;
f24 = g10;
// f10 ^= g2
g10 = f10;
g10 ^= g2;
f10 = g10;
// g5 ^= g9
g5 ^= g9;
// f12 ^= g3
g10 = f12;
g10 ^= g3;
f12 = g10;
// f31 ^= f29
g10 = f31;
g11 = f29;
g10 ^= g11;
f31 = g10;
// f28 ^= g4
g10 = f28;
g10 ^= g4;
f28 = g10;
// f29 ^= g4
g10 = f29;
g10 ^= g4;
f29 = g10;
// f28 ^= f20
g10 = f28;
g11 = f20;
g10 ^= g11;
f28 = g10;
// f0 ^= g8
g10 = f0;
g10 ^= g8;
f0 = g10;
// g3 ^= g0
g3 ^= g0;
// f17 ^= g8
g10 = f17;
g10 ^= g8;
f17 = g10;
// g7 ^= f8
g11 = f8;
g7 ^= g11;
// f25 ^= f11
g10 = f25;
g11 = f11;
g10 ^= g11;
f25 = g10;
// f10 ^= f16
g10 = f10;
g11 = f16;
g10 ^= g11;
f10 = g10;
// f2 ^= f11
g10 = f2;
g11 = f11;
g10 ^= g11;
f2 = g10;
// f20 ^= f12
g10 = f20;
g11 = f12;
g10 ^= g11;
f20 = g10;
// g4 ^= f13
g11 = f13;
g4 ^= g11;
// f9 ^= g2
g10 = f9;
g10 ^= g2;
f9 = g10;
// g7 ^= g9
g7 ^= g9;
// f19 ^= g6
g10 = f19;
g10 ^= g6;
f19 = g10;
// g9 ^= f10
g11 = f10;
g9 ^= g11;
// f6 ^= f17
g10 = f6;
g11 = f17;
g10 ^= g11;
f6 = g10;
// g0 ^= f2
g11 = f2;
g0 ^= g11;
// f16 ^= g5
g10 = f16;
g10 ^= g5;
f16 = g10;
// f8 ^= g5
g10 = f8;
g10 ^= g5;
f8 = g10;
out[0] = f0;
out[1] = f1;
out[2] = f2;
out[3] = f3;
out[4] = g0;
out[5] = g1;
out[6] = f6;
out[7] = f7;
out[8] = f8;
out[9] = f9;
out[10] = f10;
out[11] = f11;
out[12] = f12;
out[13] = f13;
out[14] = f14;
out[15] = g2;
out[16] = f16;
out[17] = f17;
out[18] = g3;
out[19] = f19;
out[20] = f20;
out[21] = g4;
out[22] = g5;
out[23] = g6;
out[24] = f24;
out[25] = f25;
out[26] = g7;
out[27] = g8;
out[28] = f28;
out[29] = f29;
out[30] = g9;
out[31] = f31;
}

#endif //!defined(_M4_ASM_)
