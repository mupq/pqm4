#include <stdint.h>
#include "cmsis.h"
#include "bred_int.h"

extern int jump2048divsteps(int minusdelta, int32_t* M, int32_t* f, int32_t* g);
int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G);

#define q 7177
#define qR2inv 598435 // round(2^32/q)
#define _2P15 (1 << 15)

static int16_t pow7175(int16_t k){
    int K = k;
    int r = k; // 1
    r=bred(r*r,q,-qR2inv);//10
    r=bred(r*K,q,-qR2inv);//11
    r=bred(r*r,q,-qR2inv);//110
    r=bred(r*K,q,-qR2inv);//111

    r=bred(r*r,q,-qR2inv);//1110
    r=bred(r*r,q,-qR2inv);//11100
    r=bred(r*r,q,-qR2inv);//111000
    r=bred(r*r,q,-qR2inv);//1110000
    r=bred(r*r,q,-qR2inv);//11100000
    r=bred(r*r,q,-qR2inv);//111000000
    r=bred(r*r,q,-qR2inv);//1110000000

    r=bred(r*r,q,-qR2inv);//11100000000
    r=bred(r*K,q,-qR2inv);//11100000001
    r=bred(r*r,q,-qR2inv);//111000000010
    r=bred(r*K,q,-qR2inv);//111000000011
    r=bred(r*r,q,-qR2inv);//1110000000110
    r=bred(r*K,q,-qR2inv);//1110000000111

    return((int16_t)r);
}

int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G){
    int16_t k;
    int16_t f[1024]={0},g[1024]={0},M[1024*4]={0};
    int i,j;
    int minusdelta=-1;

    f[0]=1;
    f[1012]=-1;
    f[1013]=-1;
    for(i=0;i<1013;i++) g[i] = (int16_t)G[1012-i];

    minusdelta = jump2048divsteps(minusdelta, (int32_t *)M, (int32_t *)f, (int32_t *)g);

    k=pow7175(M[0]*3);

#if 0
    for(i=0;i<761;i++){
        H[i] = bred(M[3847-i]*k,q,-qR2inv);
    }
#else
    int jl, jh;
    int *HH = (int *)(void *)H;
    int *MM = (int *)(void *)(M + 2058);
    for(i=1012; i>0; i-=2){
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

