#include <stdint.h>
#include "cmsis.h"
#include "ntt78.h"
extern int jump1280divsteps_onlyvs(int minusdelta, int32_t *M, int32_t *f, int32_t *g);
extern int jump1280divsteps_onlyuv(int minusdelta, int32_t *M, int32_t *f, int32_t *g);
extern void gf_polymul_1280x1280(int32_t *h, int32_t *f, int32_t *g);

void gf_polymul_1280x1280_2x2_x_2x2_onlyv (int32_t *M, int32_t *M1, int32_t *M2); // M = M2 x M1 
int jump2560divsteps(int minusdelta, int32_t *M, int32_t *f, int32_t *g);

#define q 7879
#define qR2inv 545116 // round(2^32/q)
#define _2P15 (1 << 15)

static inline int barrett_16x2i(int X) {
  int32_t QL = __SMLAWB(qR2inv,X,_2P15);
  int32_t QH = __SMLAWT(qR2inv,X,_2P15);
  int32_t SL = __SMULBT(q,QL);
  int32_t SH = __SMULBT(q,QH);
  return(__SSUB16(X,__PKHBT(SL,SH,16)));
}
void gf_polymul_1280x1280_1(int32_t* h, int32_t* f, int32_t* g){
    int fpad[1404], gpad[1404];
    ntt2808_1277(fpad, f);
    ntt2808_1277(gpad, g);
    basemul_2808(fpad, fpad, gpad);
    intt2808_2554(h, fpad);
}

void gf_polymul_1280x1280_2x2_x_2x2_onlyv (int32_t *M, int32_t *M1, int32_t *M2){ //only v = g^-1 mod f
    int i;
    int32_t T, *X, *Y, *Z;
    int32_t B2048[1281], B2048_1[1281];
    int32_t *BB2048 = (int32_t *)((void *)B2048 + 2);

    B2048[0] = 0;
    B2048_1[0] = 0;

    gf_polymul_1280x1280_1(BB2048, M2, M1); // x * u2 * v1 
    gf_polymul_1280x1280_1(B2048_1, M2+640,M1+640); // v2 * s1

    for (i=644, X=M, Y=B2048, Z=B2048_1; i>0; i--) {	// v = x u2 v1 + v2 s1
        T = barrett_16x2i(__SADD16(*(Z++),*(Y++)));
        *(X++) = T;
    }
}

// M: f(256), g(256), v(1288)
int jump2560divsteps(int minusdelta, int32_t *M, int32_t *f, int32_t *g){
    int32_t M1[2560], M2[1536]={0};
    minusdelta = jump1280divsteps_onlyvs(minusdelta,M1,f,g); // M1: f, g, v, s(1280)
    minusdelta = jump1280divsteps_onlyuv(minusdelta,M2,M1,M1+640); // M2: f(256), g(256), u(1280), v(1280)

    gf_polymul_1280x1280_2x2_x_2x2_onlyv(M+256,M1+1280,M2+256);

    for(int i=0;i<256;i++)M[i]=M2[i];

    return minusdelta;
}
