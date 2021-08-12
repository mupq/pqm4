#include <stdint.h>
#include "cmsis.h"
#include "bred_int.h"

extern int jump1920divsteps(int minusdelta, int32_t* M, int32_t* f, int32_t* g);
int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G);

#define q 6343
#define qR2inv 677119 // round(2^32/q)
#define _2P15 (1 << 15)

static int16_t pow6341(int16_t k){
    int K = k;
    int r = k; // 1
    r=bred(r*r,q,-qR2inv);//10
    r=bred(r*K,q,-qR2inv);//11

    r=bred(r*r,q,-qR2inv);//110
    r=bred(r*r,q,-qR2inv);//1100
    r=bred(r*r,q,-qR2inv);//11000

    r=bred(r*r,q,-qR2inv);//110000
    r=bred(r*K,q,-qR2inv);//110001
    r=bred(r*r,q,-qR2inv);//1100010
    r=bred(r*K,q,-qR2inv);//1100011
    
    r=bred(r*r,q,-qR2inv);//11000110
    r=bred(r*r,q,-qR2inv);//110001100
    r=bred(r*r,q,-qR2inv);//1100011000

    r=bred(r*r,q,-qR2inv);//11000110000
    r=bred(r*K,q,-qR2inv);//11000110001

    r=bred(r*r,q,-qR2inv);//110001100010
    r=bred(r*r,q,-qR2inv);//1100011000100
    r=bred(r*K,q,-qR2inv);//1100011000101

    return((int16_t)r);
}

int Rq_recip3_jumpdivsteps(int16_t* H, int8_t* G){
    int16_t k;
    int16_t f[1024]={0},g[1024]={0},M[1256];
    int i,j;
    int minusdelta=-1;

    f[0]=1;
    f[952]=-1;
    f[953]=-1;
    for(i=0;i<953;i++) g[i] = (int16_t)G[952-i];

    minusdelta = jump1920divsteps(minusdelta, (int32_t *)M, (int32_t *)f, (int32_t *)g);

    k=pow6341(M[0]*3);

#if 0
    for(i=0;i<761;i++){
        H[i] = bred(M[3847-i]*k,q,-qR2inv);
    }
#else
    int jl, jh;
    int *HH = (int *)(void *)H;
    int *MM = (int *)(void *)(M + 1222);
    for(i=952; i>0; i-=2){
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

