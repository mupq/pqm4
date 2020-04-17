#include <stdint.h>
#include "red_mod3_int.h"
#include "cmsis.h"

extern int jump32divsteps_mod3(int minusdelta, int* M, int* f, int* g);
extern void gf_polymul_32x32_mod3(int* h, int* f, int* g);
int jump64divsteps_mod3(int minusdelta, int* M, int* f, int* g);
void gf_polymul_32x32_2x2_x2p2_mod3(int* V,int* M,int *fh, int* gh);
void gf_polymul_32x32_2x2_x_2x2_mod3(int* M,int* M1,int* M2);




void gf_polymul_32x32_2x2_x2p2_mod3(int *V,int *M,int *fh,int *gh){
int C64_1[17], C64_2[17];
C64_1[0]=C64_2[0]=0;
int * CC64_1 = (int *)((void *)C64_1 + 1);
int * CC64_2 = (int *)((void *)C64_2 + 1);

  int i, T, *X, *Y, *Z, *W;

  gf_polymul_32x32_mod3(CC64_1, M+16, fh); // x * u * fh
  gf_polymul_32x32_mod3(CC64_2, M+24, gh); // x * v * gh

  for (X=V, Y=C64_1, Z=C64_2, W=M, i=8; i>0; i--) {// x(u fh+v gh)+f1
    *(X++) = add_ub3(add_ub3(*(W++),*(Y++)),*(Z++));
  }
  for (i=8; i>0; i--) {
    *(X++) = add_ub3(*(Y++),*(Z++));
  }

  gf_polymul_32x32_mod3(V+16, M+32, fh); // r * fh
  gf_polymul_32x32_mod3(CC64_1, M+40, gh); // s * gh

  for (Y=CC64_1, i=8; i>0; i--) {// r fh+s gh+g1
    T = add_ub3(add_ub3(*(W++),*(Y++)),*X); *(X++) = T;
  }
  for (i=8; i>0; i--) {
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
}

void gf_polymul_32x32_2x2_x_2x2_mod3(int *M, int *M1, int *M2){
int C64_1[17], C64_2[17];
C64_1[0]=C64_2[0]=0;
int * CC64_1 = (int *)((void *)C64_1 + 1);
int * CC64_2 = (int *)((void *)C64_2 + 1);

  int i, T, *X, *Y;

  gf_polymul_32x32_mod3(CC64_1, M2, M1); // x * u2 * u1
  gf_polymul_32x32_mod3(M, M2+8, M1+16); // v2 * r1
  for (i=16, X=M, Y=C64_1; i>0; i--) { // u = x * u2 * u1 + v2 * r1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_32x32_mod3(CC64_1, M2, M1+8); // x * u2 * v1
  gf_polymul_32x32_mod3(M+16, M2+8, M1+24); // v2 * s1
  for (i=16, Y=C64_1; i>0; i--) { // v = x * u2 * v1 + v2 * s1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_32x32_mod3(CC64_1, M2+16, M1); // x * r2 * u1
  gf_polymul_32x32_mod3(M+32, M2+24, M1+16); // s2 * r1
  for (i=16, Y=C64_1; i>0; i--) { // r = x * r2 * u1 + s2 * r1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_32x32_mod3(CC64_1, M2+16, M1+8); // x * r2 * v1
  gf_polymul_32x32_mod3(M+48, M2+24, M1+24); // s2 * s1
  for (i=16, Y=C64_1; i>0; i--) { // s = x * r2 * v1 + s2 * s1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
}

int jump64divsteps_mod3(int minusdelta, int* M, int* f, int* g){
  int M1[48], M2[48], fg[32];

  minusdelta = jump32divsteps_mod3(minusdelta, M1, f, g);
  gf_polymul_32x32_2x2_x2p2_mod3(fg, M1, f+8, g+8);
  minusdelta = jump32divsteps_mod3(minusdelta, M2, fg, fg+16);
  gf_polymul_32x32_2x2_x2p2_mod3(M, M2, fg+8, fg+24);
  gf_polymul_32x32_2x2_x_2x2_mod3(M+32, M1+16, M2+16);
  return minusdelta;
}
