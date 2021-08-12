#include <stdint.h>
// #include "cmsis.h"
#include "arith.h"

#define p 1013
#define p_minus_1 (p-1)
#define _p 1024 // for jumpdivsteps
#define over_divsteps ((_p-p)*2+1)
#define reverse_head (p-1+over_divsteps)

extern int jump2048divsteps_mod3_128(int minusdelta, uint32_t* M, uint32_t* f, uint32_t* g);
int R3_recip_jumpdivsteps(int8_t *H, int8_t* G);

int R3_recip_jumpdivsteps(int8_t* H, int8_t* G){
    uint8_t f[_p]={0},g[_p]={0},M[_p*2]={0};
    int i;
    int minusdelta=-1;

    for(i=0;i<_p;i++)f[i]=0;
    for(i=p;i<_p;i++)g[i]=0;
    f[0]=1;
    f[p_minus_1]=2; // p-1
    f[p]=2;
    for(i=0;i<p;i++)g[i]=F3_freeze_short(G[p_minus_1-i]-1)+1;

    minusdelta = jump2048divsteps_mod3_128(minusdelta,(uint32_t*)M,(uint32_t*)f,(uint32_t*)g);

    for(i=0;i<p;i++){
        H[i] = F3_freeze_short(M[reverse_head-i]*f[0]);
    }
    return minusdelta == -over_divsteps ? 0 : 1;
}
