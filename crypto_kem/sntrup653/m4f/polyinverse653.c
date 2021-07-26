#include <stdint.h>
#include "cmsis.h"
#include "bred_int.h"

extern int jump1312divsteps(int minusdelta, int32_t* M, int32_t* f, int32_t* g);
int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G);

#define q 4621
#define qR2inv 929445 // round(2^32/q)
#define _2P15 (1 << 15)

static int16_t pow4619(int16_t k){
    int K = k;
    int r = k; // 1
    r=bred(r*r,q,-qR2inv);//10
    r=bred(r*r,q,-qR2inv);//100
    r=bred(r*r,q,-qR2inv);//1000
    r=bred(r*K,q,-qR2inv);//1001
    r=bred(r*r,q,-qR2inv);//10010
    r=bred(r*r,q,-qR2inv);//100100
    r=bred(r*r,q,-qR2inv);//1001000
    r=bred(r*r,q,-qR2inv);//10010000
    r=bred(r*r,q,-qR2inv);//100100000
    r=bred(r*r,q,-qR2inv);//1001000000
    r=bred(r*K,q,-qR2inv);//1001000001
    r=bred(r*r,q,-qR2inv);//10010000010
    r=bred(r*r,q,-qR2inv);//100100000100
    r=bred(r*K,q,-qR2inv);//100100000101
    r=bred(r*r,q,-qR2inv);//1001000001010
    r=bred(r*K,q,-qR2inv);//1001000001011
    return((int16_t)r);
}

int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G){
    int16_t k;
    int16_t f[768]={0},g[768]={0},M[768*4]={0};
    int i,j;
    int minusdelta=-1;

    f[0]=1;
    f[652]=-1;
    f[653]=-1;
    for(i=0;i<653;i++) g[i] = (int16_t)G[652-i];

    minusdelta = jump1312divsteps(minusdelta, (int32_t *)M, (int32_t *)f, (int32_t *)g);

    k=pow4619(M[0]*3);

#if 0
    for(i=0;i<761;i++){
        H[i] = bred(M[3847-i]*k,q,-qR2inv);
    }
#else
    int jl, jh;
    int *HH = (int *)(void *)H;
    int *MM = (int *)(void *)(M + 722);
    for(i=652; i>0; i-=2){
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

