#include <stdint.h>
#include "cmsis.h"
#include "bred_int.h"

extern int jump2560divsteps(int minusdelta, int32_t* M, int32_t* f, int32_t* g);
int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G);

#define q 7879
#define qR2inv 545116 // round(2^32/q)
#define _2P15 (1 << 15)

static int16_t pow7877(int16_t k){
    int K = k;
    int r = k; // 1
    r=bred(r*r,q,-qR2inv);//10
    r=bred(r*K,q,-qR2inv);//11
    r=bred(r*r,q,-qR2inv);//110
    r=bred(r*K,q,-qR2inv);//111
    r=bred(r*r,q,-qR2inv);//1110
    r=bred(r*K,q,-qR2inv);//1111

    r=bred(r*r,q,-qR2inv);//11110

    r=bred(r*r,q,-qR2inv);//111100
    r=bred(r*K,q,-qR2inv);//111101
    r=bred(r*r,q,-qR2inv);//1111010
    r=bred(r*K,q,-qR2inv);//1111011

    r=bred(r*r,q,-qR2inv);//11110110
    r=bred(r*r,q,-qR2inv);//111101100
    r=bred(r*r,q,-qR2inv);//1111011000

    r=bred(r*r,q,-qR2inv);//11110110000
    r=bred(r*K,q,-qR2inv);//11110110001
    r=bred(r*r,q,-qR2inv);//111101100010
    r=bred(r*r,q,-qR2inv);//1111011000100
    r=bred(r*K,q,-qR2inv);//1111011000101

    return((int16_t)r);
}

int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G){
    int16_t k;
    int16_t f[1280]={0},g[1280]={0},M[1800]={0};
    int i,j;
    int minusdelta=-1;

    f[0]=1;
    f[1276]=-1;
    f[1277]=-1;
    for(i=0;i<1277;i++) g[i] = (int16_t)G[1276-i];

    minusdelta = jump2560divsteps(minusdelta, (int32_t *)M, (int32_t *)f, (int32_t *)g);

    k=pow7877(M[0]*3);

#if 0
    for(i=0;i<761;i++){
        H[i] = bred(M[3847-i]*k,q,-qR2inv);
    }
#else
    int jl, jh;
    int *HH = (int *)(void *)H;
    int *MM = (int *)(void *)(M + 1794);
    for(i=1276; i>0; i-=2){
      j = *(MM--);
      jl = __SMULBB(k,j);
      jh = __SMULBT(k,j);
      *(HH++) = bred_32x2(jh,jl,q,-qR2inv);
    }
    j = *(MM--);
    jh = __SMULBT(k,j);
    *((int16_t *)HH) = bred(jh,q,-qR2inv);
#endif
    return minusdelta;
}

