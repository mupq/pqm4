#include <stdint.h>
#include "red_mod3_int.h"
#include "cmsis.h"

extern int jump16divsteps_mod3(int minusdelta, int* M, int* f, int* g);
extern void gf_polymul_16x16_mod3(int* h, int* f, int* g);
int jump32divsteps_mod3(int minusdelta, int* M, int* f, int* g);
void gf_polymul_16x16_2x2_x2p2_mod3(int* V,int* M,int *fh, int* gh);
void gf_polymul_16x16_2x2_x_2x2_mod3(int* M,int* M1,int* M2);

void gf_polymul_16x16_2x2_x2p2_mod3(int *V,int *M,int *fh,int *gh){
int C32_1[9], C32_2[9];
C32_1[0]=C32_2[0]=0;
int * CC32_1 = (int *)((void *)C32_1 + 1);
int * CC32_2 = (int *)((void *)C32_2 + 1);

  int i, T, *X, *Y, *Z, *W;

  gf_polymul_16x16_mod3(CC32_1, M+8, fh); // x * u * fh
  gf_polymul_16x16_mod3(CC32_2, M+12, gh); // x * v * gh

  for (X=V, Y=C32_1, Z=C32_2, W=M, i=4; i>0; i--) {// x(u fh+v gh)+f1
    *(X++) = add_ub3(add_ub3(*(W++),*(Y++)),*(Z++));
  }
  for (i=4; i>0; i--) {
    *(X++) = add_ub3(*(Y++),*(Z++));
  }

  gf_polymul_16x16_mod3(V+8, M+16, fh); // r * fh
  gf_polymul_16x16_mod3(CC32_1, M+20, gh); // s * gh

  for (Y=CC32_1, i=4; i>0; i--) {// r fh+s gh+g1
    T = add_ub3(add_ub3(*(W++),*(Y++)),*X); *(X++) = T;
  }
  for (i=4; i>0; i--) {
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
}

void gf_polymul_16x16_2x2_x_2x2_mod3(int *M, int *M1, int *M2){
int C32_1[9], C32_2[9];
C32_1[0]=C32_2[0]=0;
int * CC32_1 = (int *)((void *)C32_1 + 1);
int * CC32_2 = (int *)((void *)C32_2 + 1);

  int i, T, *X, *Y;

  gf_polymul_16x16_mod3(CC32_1, M2, M1); // x * u2 * u1
  gf_polymul_16x16_mod3(M, M2+4, M1+8); // v2 * r1
  for (i=8, X=M, Y=C32_1; i>0; i--) { // u = x * u2 * u1 + v2 * r1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_16x16_mod3(CC32_1, M2, M1+4); // x * u2 * v1
  gf_polymul_16x16_mod3(M+8, M2+4, M1+12); // v2 * s1
  for (i=8, Y=C32_1; i>0; i--) { // v = x * u2 * v1 + v2 * s1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_16x16_mod3(CC32_1, M2+8, M1); // x * r2 * u1
  gf_polymul_16x16_mod3(M+16, M2+12, M1+8); // s2 * r1
  for (i=8, Y=C32_1; i>0; i--) { // r = x * r2 * u1 + s2 * r1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_16x16_mod3(CC32_1, M2+8, M1+4); // x * r2 * v1
  gf_polymul_16x16_mod3(M+24, M2+12, M1+12); // s2 * s1
  for (i=8, Y=C32_1; i>0; i--) { // s = x * r2 * v1 + s2 * s1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
}

int jump32divsteps_mod3(int minusdelta, int* M, int* f, int* g){
  int M1[24], M2[24], fg[16];

  minusdelta = jump16divsteps_mod3(minusdelta, M1, f, g);
  gf_polymul_16x16_2x2_x2p2_mod3(fg, M1, f+4, g+4);
  minusdelta = jump16divsteps_mod3(minusdelta, M2, fg, fg+8);
  gf_polymul_16x16_2x2_x2p2_mod3(M, M2, fg+4, fg+12);
  gf_polymul_16x16_2x2_x_2x2_mod3(M+16, M1+8, M2+8);
  return minusdelta;
}
