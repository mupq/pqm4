// #include <stdint.h>
#include "poly.h"

#define p 676
#define p_minus_1 (p-1)
#define _p 688 // for jumpdivsteps
#define over_divsteps ((_p-p)*2+1)
#define reverse_head (p-1+over_divsteps)

extern int jump1376divsteps_mod3_64(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g);

static inline uint8_t __mod3(uint8_t a) { /* a between 0 and 9 */
    int16_t t, c;
    a = (a >> 2) + (a & 3); /* between 0 and 4 */
    t = a - 3;
    c = t >> 5;
    return (uint8_t) (t ^ (c & (a ^ t)));
}

void poly_S3_inv_jumpdivsteps(poly *r, const poly *a){
    uint8_t f[_p]={0},g[_p]={0},M[_p*2]={0};
    int i;
    int minusdelta=-1;

    for(i=0; i<=p; i++) f[i]=1;
    for(i=0;i<p;i++) g[i]= a->coeffs[p_minus_1-i];

    minusdelta = jump1376divsteps_mod3_64(minusdelta,(uint32_t*)M,(uint32_t*)f,(uint32_t*)g);

    for(i=0;i<p;i++){
        r->coeffs[i] = __mod3(M[reverse_head-i]*f[0]);
    }
    r->coeffs[p] = 0;
    
    // return minusdelta == -over_divsteps ? 0 : 1;
}