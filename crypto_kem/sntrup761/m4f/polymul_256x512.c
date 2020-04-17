#include <stdint.h>
#include "cmsis.h"

extern void gf_polymul_256x256(void *h, void *f, void *g);
void gf_polymul_256x512(int *h, int *f, int *g);

#define q 4591
#define qR2inv 935519 // round(2^32/q)
#define _2P15 (1 << 15)

#if 1
// result range: +- 2295 (note: 3 loads for _2P15 and the longer qR2inv)
static inline int barrett_16x2i(int X) {
  int32_t QL = __SMLAWB(qR2inv,X,_2P15);
  int32_t QH = __SMLAWT(qR2inv,X,_2P15);
  int32_t SL = __SMULBT(q,QL);
  int32_t SH = __SMULBT(q,QH);
  return(__SSUB16(X,__PKHBT(SL,SH,16)));
}

#else 
#define barrett_16x2i(A) (A)
#endif

void gf_polymul_256x512(int *h, int *f, int *g){
    int i, T, *start, *H_local;
    int h_tmp[256];
    gf_polymul_256x256(h,f,g);
    gf_polymul_256x256(h_tmp,f,g+128);

    start = h + 128;
    H_local = h_tmp;
    for (i = 0; i < 128; ++i){
        T = __SADD16(*start, *(H_local++));
        *(start++) = T;
    }
    for (i = 0; i < 128; ++i) *(start++) = *(H_local++);
}