#include <stdint.h>
#include "cmsis.h"
#include "ntt287x.h"

extern int jump1024divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump704divsteps(int minusdelta, int *M, int *f, int *g);

void gf_polymul_858x858(int *h, int *f, int *g);
void gf_polymul_858x858_2x2_x_2x2 (int *M, int *M1, int *M2); // M = M2 x M1 
int jump1728divsteps(int minusdelta, int *M, int *f, int *g);

#define q 5167
#define qR2inv 831230 // round(2^32/q)
#define _2P15 (1 << 15)

static inline int barrett_16x2i(int X) {
  int QL = __SMLAWB(qR2inv,X,_2P15);
  int QH = __SMLAWT(qR2inv,X,_2P15);
  int SL = __SMULBT(q,QL);
  int SH = __SMULBT(q,QH);
  return(__SSUB16(X,__PKHBT(SL,SH,16)));
}

void gf_polymul_858x858(int *h, int *f, int *g){
    int fpad[861], gpad[861];
    ntt1722_857(fpad, f);
    ntt1722_857(gpad, g);
    basemul_1722(fpad, gpad);
    intt1722(h, fpad);
}

void gf_polymul_858x858_2x2_x_2x2 (int *M, int *M1, int *M2){ //only v = g^-1 mod f
    int i;
    int T, *X, *Y;
    int B1728[1728];
    int *BB1728 = (int *)((void *)B1728 + 2);
    B1728[0] = 0;
    B1728[1] = 0;

    gf_polymul_858x858(BB1728, M2, M1); // x * u2 * v1 
    gf_polymul_858x858(M, M2+429,M1+512); // v2 * s1

    for (i=857, X=M, Y=B1728; i>0; i--) {	// v = x u2 v1 + v2 s1
        T = barrett_16x2i(__SADD16(*X,*(Y++)));
        *(X++) = T;
    }
}

// M: f(64), g(64), v(857*2)
int jump1728divsteps(int minusdelta, int *M, int *f, int *g){
    int M1[2048],M2[922]={0};
    int i;
    minusdelta = jump1024divsteps(minusdelta,M1,f,g); // M1: f, g, v, s(1024)
    minusdelta = jump704divsteps(minusdelta,M2,M1,M1+512); // M2: f(64), g(64), u(858), v(858)

    gf_polymul_858x858_2x2_x_2x2(M+64,M1+1024,M2+64);

    for(i=0;i<64;i++)M[i]=M2[i];
    return minusdelta;
}
