#ifndef NTT_PARAMS_H
#define NTT_PARAMS_H

#define ARRAY_N 1536

#ifndef NTRU_Q
#define NTRU_Q 8192
#endif

#ifndef NTRU_N
#define NTRU_N 701
#endif

#define NTT_N 128
#define LOGNTT_N 7

#define Q1 5743489
#define Q1pr 7
// omegaQ1 = Q1pr^((Q1 - 1) / NTT_N) mod Q1
#define omegaQ1 1772242
// invomegaQ1 = omegaQ1^{-1} mod Q1
#define invomegaQ1 636374
// RmodQ1 = 2^32 mod^{+-} Q1
#define RmodQ1 (-1162476)
// Q1prime = -Q1^{-1} mod^{+-} 2^32
#define Q1prime (-909417601)
// invNQ1 = NTT_N^{-1} mod Q1
#define invNQ1 (-44871)

#define omega3Q1 35303
#define omega3RmodQ1 (-1661323)
#define invomega3Q1 (-35304)
#define invomega3RmodQ1 2823799
#define inv3Q1 (-1914496)

#define invNinv3RmodQ1 1612329

#define invNinv3R2modQ1 1972722


#endif

