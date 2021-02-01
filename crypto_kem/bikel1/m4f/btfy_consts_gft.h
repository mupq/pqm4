#ifndef _BTFY_CONSTS_GFT_H_
#define _BTFY_CONSTS_GFT_H_

#include "stdint.h"

#define MASK_S0 0xaaaaaaaa
#define MASK_S1 0xcccccccc
#define MASK_S2 0xf0f0f0f0
#define MASK_S3 0xff00ff00
#define MASK_S4 0xffff0000


#define BTFY_MAXLEN_BIT 65536
#define BTFY_CONSTS_LEN ((BTFY_MAXLEN_BIT/2)/32)


extern const uint32_t s0_gft[BTFY_CONSTS_LEN];


#define S0_GF256_NUMX32 4
#define S0_GF216_NUMX32 28

extern const uint32_t s0_gf256_vec[S0_GF256_NUMX32*8];
extern const uint32_t s0_gf216_vec[S0_GF216_NUMX32*16];


#define S1_GF256_NUMX32 8
#define S1_GF216_NUMX32  24

extern const uint32_t s1_gf256_vec[S1_GF256_NUMX32*8];
extern const uint32_t s1_gf216_vec[S1_GF216_NUMX32*16];


#define S2_GF256_NUMX32 16
#define S2_GF216_NUMX32  16

extern const uint32_t s2_gf256_vec[S2_GF256_NUMX32*8];
extern const uint32_t s2_gf216_vec[S2_GF216_NUMX32*16];


extern const uint32_t s3_gf256_vec[BTFY_CONSTS_LEN*8/32];


#define S4_GF16_NUMX32 4
#define S4_GF256_NUMX32 28

extern const uint32_t s4_gf16_vec[S4_GF16_NUMX32*4];
extern const uint32_t s4_gf256_vec[S4_GF256_NUMX32*8];



#endif
