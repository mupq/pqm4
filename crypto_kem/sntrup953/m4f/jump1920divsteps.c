#include <stdint.h>
#include "cmsis.h"
#include "ntt42.h"
extern int jump1024divsteps(int minusdelta, int32_t *M, int32_t *f, int32_t *g);
extern int jump896divsteps(int minusdelta, int32_t *M, int32_t *f, int32_t *g);
void gf_polymul_960x960(int32_t *h, int32_t *f, int32_t *g);
void gf_polymul_960x960_2x2_x_2x2 (int32_t *M, int32_t *M1, int32_t *M2); // M = M2 x M1 
int jump1920divsteps(int minusdelta, int32_t *M, int32_t *f, int32_t *g);

#define q 6343
#define qR2inv 677119 // round(2^32/q)
#define _2P15 (1 << 15)

static inline int barrett_16x2i(int X) {
  int32_t QL = __SMLAWB(qR2inv,X,_2P15);
  int32_t QH = __SMLAWT(qR2inv,X,_2P15);
  int32_t SL = __SMULBT(q,QL);
  int32_t SH = __SMULBT(q,QH);
  return(__SSUB16(X,__PKHBT(SL,SH,16)));
}
void gf_polymul_960x960_1(int32_t *h, int32_t *f, int32_t *g){
    int fpad[1008], gpad[1008];
    ntt2016_953(fpad, f);
    ntt2016_953(gpad, g);
    basemul_2016(fpad, fpad, gpad);
    intt2016_1906(h, fpad);
}
void gf_polymul_960x960_2x2_x_2x2 (int32_t *M, int32_t *M1, int32_t *M2){ //only v = g^-1 mod f
    int i;
    int32_t T, *X, *Y, *Z;
    int32_t B1920[961], B1920_1[961];
    int32_t *BB1920 = (int32_t *)((void *)B1920 + 2);
    B1920[0] = 0;
    B1920_1[1] = 0;

    gf_polymul_960x960_1(BB1920, M2, M1); // x * u2 * v1 
    gf_polymul_960x960_1(B1920_1, M2+480,M1+512); // v2 * s1

    for (i=500, X=M, Y=B1920, Z=B1920_1; i>0; i--) {	// v = x u2 v1 + v2 s1
        T = barrett_16x2i(__SADD16((*Z++),*(Y++)));
        *(X++) = T;
    }
}

// M: f(128), g(128), v(500*2)
int jump1920divsteps(int minusdelta, int32_t *M, int32_t *f, int32_t *g){
    int32_t M1[2048],M2[1088]={0};
    int i;

    minusdelta = jump1024divsteps(minusdelta,M1,f,g); // M1: f, g, v, s(1024)
    minusdelta = jump896divsteps(minusdelta,M2,M1,M1+512); // M2: f(128), g(128), u(960), v(960)
    gf_polymul_960x960_2x2_x_2x2(M+128,M1+1024,M2+128);

    for(i=0;i<128;i++)M[i]=M2[i];

    return minusdelta;
}
