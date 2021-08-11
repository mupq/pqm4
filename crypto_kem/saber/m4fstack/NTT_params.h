#ifndef NTT_PARAMS_H
#define NTT_PARAMS_H

#define ARRAY_N 256

#define NTT_N 64
#define LOGNTT_N 6

#define Q1 7681
#define Q1pr 13
// omegaQ1 = Q1pr^((Q1 - 1) / (NTT_N << 1)) mod Q1
#define omegaQ1 5258
// invomegaQ1 = omegaQ1^{-1} mod Q1
#define invomegaQ1 3449
// RmodQ1 = 2^16 mod^{+-} Q1
#define RmodQ1 -3593
// Q1prime = -Q1^{-1} mod^{+-} 2^16
#define Q1prime 7679
// Q1Q1prime = Q1 || Q1prime
#define Q1Q1prime 503389695
// invNQ1 = NTT_N^{-1} mod Q1
#define invNQ1 7561

#define Q2 3329
#define Q2pr 3
// omegaQ2 = Q2pr^((Q2 - 1) / (NTT_N << 1)) mod Q2
#define omegaQ2 1915
// invomegaQ2 = omegaQ2^{-1} mod Q2
#define invomegaQ2 1010
// RmodQ2 = 2^16 mod^{+-} Q2
#define RmodQ2 -1044
// Q2prime = -Q2^{-1} mod^{+-} 2^16
#define Q2prime 3327
// Q2Q2prime = Q2 || Q2prime
#define Q2Q2prime 218172671
// invNQ2 = NTT_N^{-1} mod Q2
#define invNQ2 3277


// Q1inv = Q1^{-1} mod^{+-} Q2
#define Q1inv 1370
// Q1invRmod = 2^16 Q1^{-1} mod^{+-} Q2
#define Q1invRmod 1190
// Q1Q1invRmod = Q1 || Q1invRmod
#define Q1Q1invRmod 503383206


// Q1Q2 = Q1 * Q2
#define Q1Q2 25570049
// omegaQ1Q2 = CRT(omegaQ1, omegaQ2) in (mod Q1, mod Q2)
#define omegaQ1Q2 6103972
// invomegaQ1Q2 = omegaQ1Q2^{-1} mod Q1Q2
#define invomegaQ1Q2 6808815
// R = 2^32 below
// RmodQ1Q2 = 2^32 mod^{+-} Q1Q2
#define RmodQ1Q2 -800936
// Q1Q2prime = -Q1Q2^{-1} mod^{+-} 2^32
#define Q1Q2prime -1991431425
// invNQ1Q2 = NTT_N^{-1} mod Q1Q2
#define invNQ1Q2 25170517

#endif