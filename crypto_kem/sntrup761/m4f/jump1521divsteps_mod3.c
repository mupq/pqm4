#include <stdint.h>
#include "red_mod3_int.h"
#include "cmsis.h"

extern int jump768divsteps_mod3(int minusdelta, int *M, int *f, int *g);
extern int jump753divsteps_mod3(int minusdelta, int *M, int *f, int *g);
extern void gf_polymul_768x768_mod3(void *h, void *f, void *g);

void gf_polymul_768x768_2x2_x_2x2_mod3 (int *M, int *M1, int *M2); // M = M2 x M1 
void gf_polymul_768x768_2x2_x_2x2_onlyv_mod3 (int *M, int *M1, int *M2); // M = M2 x M1 
int jump1521divsteps_mod3(int minusdelta, int *M, int *f, int *g);



void gf_polymul_768x768_2x2_x_2x2_mod3 (int *M, int *M1, int *M2){ //only v = g^-1 mod f
int C1521_1[385];
C1521_1[0]=0;
int * CC1521_1 = (int *)((void *)C1521_1 + 1);

    int i, T, *X, *Y;
    gf_polymul_768x768_mod3(CC1521_1, M2, M1); // x * u2 * u1 
    gf_polymul_768x768_mod3(M, M2+192,M1+384); // v2 * r1
    for (i=384, X=M, Y=C1521_1; i>0; i--) {	// u = x u2 u1 + v2 r1
     T = (add_ub3(*X,*(Y++)));
       *(X++) = T;
    }
    gf_polymul_768x768_mod3(CC1521_1, M2, M1+192); // x * u2 * v1 
    gf_polymul_768x768_mod3(M+384, M2+192,M1+576); // v2 * s1
    for (i=384, Y=C1521_1; i>0; i--) {	// v = x u2 v1 + v2 s1
     T = (add_ub3(*X,*(Y++)));
       *(X++) = T;
    }
    gf_polymul_768x768_mod3(CC1521_1, M2+384, M1); // x * r2 * u1 
    gf_polymul_768x768_mod3(M+768, M2+576,M1+384); // s2 * r1
    for (i=384, Y=C1521_1; i>0; i--) {	// r = x r2 u1 + s2 r1
     T = (add_ub3(*X,*(Y++)));
       *(X++) = T;
    }
    gf_polymul_768x768_mod3(CC1521_1, M2+384, M1+192); // x * r2 * v1 
    gf_polymul_768x768_mod3(M+1152, M2+576,M1+576); // s2 * s1
    for (i=384, Y=C1521_1; i>0; i--) {	// s = x r2 v1 + s2 s1
     T = (add_ub3(*X,*(Y++)));
       *(X++) = T;
    }
}

void gf_polymul_768x768_2x2_x_2x2_onlyv_mod3 (int *M, int *M1, int *M2){ //only v = g^-1 mod f
int C1521_1[385];
C1521_1[0]=0;
int * CC1521_1 = (int *)((void *)C1521_1 + 1);

    int i, T, *X, *Y;
    /*
    gf_polymul_768x768_mod3(CC1521_1, M2, M1); // x * u2 * u1 
    gf_polymul_768x768_mod3(M, M2+192,M1+384); // v2 * r1
    for (i=384, X=M, Y=C1521_1; i>0; i--) {	// u = x u2 u1 + v2 r1
     T = (add_ub3(*X,*(Y++)));
       *(X++) = T;
    }
    */
    gf_polymul_768x768_mod3(CC1521_1, M2, M1+192); // x * u2 * v1 
    gf_polymul_768x768_mod3(M+384, M2+192,M1+576); // v2 * s1
    for (i=384, X=M+384, Y=C1521_1; i>0; i--) {	// v = x u2 v1 + v2 s1
     T = (add_ub3(*X,*(Y++)));
       *(X++) = T;
    }
    /*
    gf_polymul_768x768_mod3(CC1521_1, M2+384, M1); // x * r2 * u1 
    gf_polymul_768x768_mod3(M+768, M2+576,M1+384); // s2 * r1
    for (i=384, Y=C1521_1; i>0; i--) {	// r = x r2 u1 + s2 r1
     T = (add_ub3(*X,*(Y++)));
       *(X++) = T;
    }
    gf_polymul_768x768_mod3(CC1521_1, M2+384, M1+192); // x * r2 * v1 
    gf_polymul_768x768_mod3(M+1152, M2+576,M1+576); // s2 * s1
    for (i=384, Y=C1521_1; i>0; i--) {	// s = x r2 v1 + s2 s1
     T = (add_ub3(*X,*(Y++)));
       *(X++) = T;
    }
    */
}

int jump1521divsteps_mod3(int minusdelta, int *M, int *f, int *g){
    int M1[1152],M2[1152];
    int i;
    
    minusdelta = jump768divsteps_mod3(minusdelta,M1,f,g);

    minusdelta = jump753divsteps_mod3(minusdelta,M2,M1,M1+192);

    gf_polymul_768x768_2x2_x_2x2_onlyv_mod3(M+384,M1+384,M2+384);

    for(i=0;i<384;i++)M[i]=M2[i];

    return minusdelta;
}