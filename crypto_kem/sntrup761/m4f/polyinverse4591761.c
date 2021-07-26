#include <stdint.h>
#include "cmsis.h"
#include "bred_int.h"

extern int jump1521divsteps(int minusdelta, int32_t* M, int32_t* f, int32_t* g);
int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G);

#define q 4591
#define qR2inv 935519 // round(2^32/q)
#define _2P15 (1 << 15)

static int16_t pow4589(int16_t k){
#if 0
    int16_t r=k;       //1
    r=bred(r*r,q,-qR2inv);//10
    r=bred(r*r,q,-qR2inv);//100
    r=bred(r*r,q,-qR2inv);//1000
    r=bred(r*r,q,-qR2inv);//10000
    r=bred(r*k,q,-qR2inv);//10001
    r=bred(r*r,q,-qR2inv);//100010
    r=bred(r*k,q,-qR2inv);//100011
    r=bred(r*r,q,-qR2inv);//1000110
    r=bred(r*k,q,-qR2inv);//1000111
    r=bred(r*r,q,-qR2inv);//10001110
    r=bred(r*k,q,-qR2inv);//10001111
    r=bred(r*r,q,-qR2inv);//100011110
    r=bred(r*r,q,-qR2inv);//1000111100
    r=bred(r*k,q,-qR2inv);//1000111101
    r=bred(r*r,q,-qR2inv);//10001111010
    r=bred(r*k,q,-qR2inv);//10001111011
    r=bred(r*r,q,-qR2inv);//100011110110
    r=bred(r*r,q,-qR2inv);//1000111101100
    r=bred(r*k,q,-qR2inv);//1000111101101
    return r;
#else
    int K = k;
    int r = k; // 1
    r=bred(r*r,q,-qR2inv);//10
    r=bred(r*r,q,-qR2inv);//100
    r=bred(r*r,q,-qR2inv);//1000
    r=bred(r*r,q,-qR2inv);//10000
    r=bred(r*K,q,-qR2inv);//10001
    r=bred(r*r,q,-qR2inv);//100010
    r=bred(r*K,q,-qR2inv);//100011
    r=bred(r*r,q,-qR2inv);//1000110
    r=bred(r*K,q,-qR2inv);//1000111
    r=bred(r*r,q,-qR2inv);//10001110
    r=bred(r*K,q,-qR2inv);//10001111
    r=bred(r*r,q,-qR2inv);//100011110
    r=bred(r*r,q,-qR2inv);//1000111100
    r=bred(r*K,q,-qR2inv);//1000111101
    r=bred(r*r,q,-qR2inv);//10001111010
    r=bred(r*K,q,-qR2inv);//10001111011
    r=bred(r*r,q,-qR2inv);//100011110110
    r=bred(r*r,q,-qR2inv);//1000111101100
    r=bred(r*K,q,-qR2inv);//1000111101101
    return((int16_t)r);
#endif
}

int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G){
    int16_t k;
    int16_t f[768]={0},g[768]={0},M[768*4]={0};
    int i,j;
    int minusdelta=-1;

    for(i=1;i<768;i++)f[i]=0;
    for(i=761;i<768;i++)g[i]=0;
    f[0]=1;
    f[760]=-1;
    f[761]=-1;
    for(i=0;i<761;i++) g[i] = (int16_t)G[760-i];

    minusdelta = jump1521divsteps(minusdelta, (int32_t *)M, (int32_t *)f, (int32_t *)g);

    k=pow4589(M[0]*3);

#if 0
    for(i=0;i<761;i++){
        H[i] = bred(M[3847-i]*k,q,-qR2inv);
    }
#else
    int jl, jh;
    int *HH = (int *)(void *)H;
    // int *MM = (int *)(void *)(M + 2310);
    int *MM = (int *)(void *)(M + 2298);
    for(i=760; i>0; i-=2){
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

