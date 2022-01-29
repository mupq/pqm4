#ifndef NTT_PARAMS_H
#define NTT_PARAMS_H

#define ARRAY_N 1024

#ifndef NTRU_Q
#define NTRU_Q 2048
#endif
#ifndef NTRU_N
#define NTRU_N 509
#endif

#define NTT_N 256
#define LOGNTT_N 8

#define Q1 1043969
#define Q1pr 3
// omegaQ1 = Q1pr^((Q1 - 1) / NTT_N) mod Q1
#define omegaQ1 (-102338)
// invomegaQ1 = omegaQ1^{-1} mod Q1
#define invomegaQ1 383534
// RmodQ1 = 2^32 mod^{+-} Q1
#define RmodQ1 78830
// Q1prime = -Q1^{-1} mod^{+-} 2^32
#define Q1prime 1993076223
// invNQ1 = NTT_N^{-1} mod Q1
#define invNQ1 1039891

// invNRmodQ1 = NTT_N^{-1} * 2^32 mod^{+-} Q1
#define invNRmodQ1 73712
// invNR2modQ1 = NTT_N^{-1} * 2^64 mod^{+-} Q1
#define invNR2modQ1 (-14494)


#endif

