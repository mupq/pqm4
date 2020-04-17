#include <stdint.h>
#include "cmsis.h"

extern int jump768divsteps(int minusdelta, int32_t *M, int32_t *f, int32_t *g);
extern int jump753divsteps(int minusdelta, int32_t *M, int32_t *f, int32_t *g);
extern void gf_polymul_768x768(int32_t *h, int32_t *f, int32_t *g);

void gf_polymul_768x768_2x2_x_2x2 (int32_t *M, int32_t *M1, int32_t *M2); // M = M2 x M1 
int jump1521divsteps(int minusdelta, int32_t *M, int32_t *f, int32_t *g);

void gf_polymul_768x768_2x2_x_2x2 (int32_t *M, int32_t *M1, int32_t *M2){ //only v = g^-1 mod f
    int i;
    int32_t T, *X, *Y;
    int32_t B1521_1[769];
    int32_t *BB1521_1 = (int32_t *)((void *)B1521_1 + 2);
    B1521_1[0] = 0;

    gf_polymul_768x768(BB1521_1, M2, M1+384); // x * u2 * v1 
    gf_polymul_768x768(M+768, M2+384,M1+1152); // v2 * s1
    for (i=768, X=M+768, Y=B1521_1; i>0; i--) {	// v = x u2 v1 + v2 s1
        T = __SADD16(*X,*(Y++));
        *(X++) = T;
    }
}

int jump1521divsteps(int minusdelta, int32_t *M, int32_t *f, int32_t *g){
    int32_t M1[2304],M2[2304];
    int i;

    minusdelta = jump768divsteps(minusdelta,M1,f,g);
    minusdelta = jump753divsteps(minusdelta,M2,M1,M1+384);

    gf_polymul_768x768_2x2_x_2x2(M+768,M1+768,M2+768);

    for(i=0;i<768;i++)M[i]=M2[i];

    return minusdelta;
}
