#ifndef NTT_PARAMS_H
#define NTT_PARAMS_H

#define ARRAY_N 1536

#ifndef NTRU_Q
#define NTRU_Q 2048
#endif

#ifndef NTRU_N
#define NTRU_N 677
#endif

#define NTT_N 128
#define LOGNTT_N 7

#define Q1 2342401
#define Q1pr 11
// omegaQ1 = Q1pr^((Q1 - 1) / NTT_N) mod Q1
#define omegaQ1 1680307
// invomegaQ1 = omegaQ1^{-1} mod Q1
#define invomegaQ1 2209034
// RmodQ1 = 2^32 mod^{+-} Q1
#define RmodQ1 -996138
// Q1prime = -Q1^{-1} mod^{+-} 2^32
#define Q1prime 1998568959
// invNQ1 = NTT_N^{-1} mod Q1
#define invNQ1 2324101

#define omega3Q1 436506
#define omega3RmodQ1 (-316198)
#define invomega3Q1 1905894
#define invomega3RmodQ1 (-1030065)
#define inv3Q1 1561601

#define invNinv3 2336301

#define invNinv3RmodQ1 253606

#define invNinv3R2modQ1 (-968179)


#endif