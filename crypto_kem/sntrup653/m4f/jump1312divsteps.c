#include "cmsis.h"

extern int jump768divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump544divsteps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_656x656_2x2_x_2x2 (int *M, int *M1, int *M2); // M = M2 x M1 
int jump1312divsteps(int minusdelta, int *M, int *f, int *g);

extern void ntt11_rader(int*, int*);
extern void ntt12(int*);
extern void polymul_10x10_132(int*, int*);
extern void intt12(int*);
extern void intt11_rader_mr(int*, int*);

#define q 4621
#define qR2inv 929445 // round(2^32/q)
#define _2P15 (1 << 15)

static inline int barrett_16x2i(int X) {
  int QL = __SMLAWB(qR2inv,X,_2P15);
  int QH = __SMLAWT(qR2inv,X,_2P15);
  int SL = __SMULBT(q,QL);
  int SH = __SMULBT(q,QH);
  return(__SSUB16(X,__PKHBT(SL,SH,16)));
}

void gf_polymul_656x656_2x2_x_2x2 (int *M, int *M1, int *M2){ //only v = g^-1 mod f
    int i;
    int T, *X, *Y;
    int B1521_1[769];
    int *BB1521_1 = (int *)((void *)B1521_1 + 2);
    B1521_1[0] = 0;
    B1521_1[1] = 0;

    int fpad[660], gpad[660];
    ntt11_rader(fpad, M1);
    ntt12(fpad);
    ntt11_rader(gpad, M2);
    ntt12(gpad);
    polymul_10x10_132(fpad, gpad);
    intt12(fpad);
    intt11_rader_mr(BB1521_1, fpad);
    
    ntt11_rader(fpad, M1+384);
    ntt12(fpad);
    ntt11_rader(gpad, M2+384);
    ntt12(gpad);
    polymul_10x10_132(fpad, gpad);
    intt12(fpad);
    intt11_rader_mr(M, fpad);

    for (i=656, X=M, Y=B1521_1; i>0; i--) {	// v = x u2 v1 + v2 s1
        T = barrett_16x2i(__SADD16(*X,*(Y++)));
        *(X++) = T;
    }
}

int jump1312divsteps(int minusdelta, int *M, int *f, int *g){
    int M1[1536],M2[800]={0};
    int i;

    minusdelta = jump768divsteps(minusdelta,M1,f,g); // M1: f, g, v, s(768)
    minusdelta = jump544divsteps(minusdelta,M2,M1,M1+384); // M2: f(32), g(32), u(768), v(768)
    
    gf_polymul_656x656_2x2_x_2x2(M+32,M1+768,M2+32);

    for(i=0;i<32;i++)M[i]=M2[i];
    // M: f(32), g(32), v(768)

    return minusdelta;
}
