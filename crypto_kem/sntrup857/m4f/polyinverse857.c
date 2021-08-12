#include <stdint.h>
#include "cmsis.h"
#include "bred_int.h"

extern int jump1728divsteps(int minusdelta, int32_t* M, int32_t* f, int32_t* g);
int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G);

#define q 5167
#define qR2inv 831230 // round(2^32/q)
#define _2P15 (1 << 15)

static int16_t pow5165(int16_t k){
    int K = k;
    int r = k; // 1
    r=bred(r*r,q,-qR2inv);//10
    r=bred(r*r,q,-qR2inv);//100
    r=bred(r*K,q,-qR2inv);//101

    r=bred(r*r,q,-qR2inv);//1010
    r=bred(r*r,q,-qR2inv);//10100
    r=bred(r*r,q,-qR2inv);//101000
    r=bred(r*r,q,-qR2inv);//1010000
    r=bred(r*r,q,-qR2inv);//10100000
    r=bred(r*K,q,-qR2inv);//10100001
    
    r=bred(r*r,q,-qR2inv);//101000010
    r=bred(r*r,q,-qR2inv);//1010000100
    r=bred(r*K,q,-qR2inv);//1010000101

    r=bred(r*r,q,-qR2inv);//10100001010
    r=bred(r*K,q,-qR2inv);//10100001011

    r=bred(r*r,q,-qR2inv);//101000010110
    r=bred(r*r,q,-qR2inv);//1010000101100
    r=bred(r*K,q,-qR2inv);//1010000101101

    return((int16_t)r);
}

int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G){
    int16_t k;
    int16_t f[1024]={0},g[1024]={0},M[2000]={0};
    int i,j;
    int minusdelta=-1;

    f[0]=1;
    f[856]=-1;
    f[857]=-1;
    for(i=0;i<857;i++) g[i] = (int16_t)G[856-i];

    minusdelta = jump1728divsteps(minusdelta, (int32_t *)M, (int32_t *)f, (int32_t *)g);

    k=pow5165(M[0]*3);

#if 0
    for(i=0;i<761;i++){
        H[i] = bred(M[3847-i]*k,q,-qR2inv);
    }
#else
    int jl, jh;
    int *HH = (int *)(void *)H;
    int *MM = (int *)(void *)(M + 998);
    for(i=856; i>0; i-=2){
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

