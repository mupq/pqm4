#include <stdint.h>
#include "cmsis.h"
#include "arith.h"

extern int jump1536divsteps_mod3_128(int minusdelta, uint32_t* M, uint32_t* f, uint32_t* g);
int R3_recip_jumpdivsteps(int8_t *H, int8_t* G);

int R3_recip_jumpdivsteps(int8_t* H, int8_t* G){
    uint8_t f[768]={0},g[768]={0},M[768*4]={0};
    int i;
    int minusdelta=-1;

    for(i=0;i<768;i++)f[i]=0;
    for(i=761;i<768;i++)g[i]=0;
    f[0]=1;
    f[760]=2;
    f[761]=2;
    for(i=0;i<761;i++)g[i]=F3_freeze_short(G[760-i]-1)+1;

    minusdelta = jump1536divsteps_mod3_128(minusdelta,(uint32_t*)M,(uint32_t*)f,(uint32_t*)g);

    for(i=0;i<761;i++){
        H[i] = F3_freeze_short(M[775-i]*f[0]);
    }
    return minusdelta == -15 ? 0 : 1;
}
