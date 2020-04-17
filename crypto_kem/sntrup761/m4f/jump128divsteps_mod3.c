#include <stdint.h>
#include "red_mod3_int.h"
#include "cmsis.h"

extern int jump64divsteps_mod3(int minusdelta, int* M, int* f, int* g);
extern void gf_polymul_64x64_mod3(int* h, int* f, int* g);
int jump128divsteps_mod3(int minusdelta, int* M, int* f, int* g);
void gf_polymul_64x64_2x2_x2p2_mod3(int* V,int* M,int *fh, int* gh);
void gf_polymul_64x64_2x2_x_2x2_mod3(int* M,int* M1,int* M2);



void gf_polymul_64x64_2x2_x2p2_mod3(int *V,int *M,int *fh,int *gh){
int C128_1[33], C128_2[33];
C128_1[0]=C128_2[0]=0;
int * CC128_1 = (int *)((void *)C128_1 + 1);
int * CC128_2 = (int *)((void *)C128_2 + 1);

  int i, T, *X, *Y, *Z, *W;

  gf_polymul_64x64_mod3(CC128_1, M+32, fh); // x * u * fh
  gf_polymul_64x64_mod3(CC128_2, M+48, gh); // x * v * gh

  for (X=V, Y=C128_1, Z=C128_2, W=M, i=16; i>0; i--) {// x(u fh+v gh)+f1
    *(X++) = add_ub3(add_ub3(*(W++),*(Y++)),*(Z++));
  }
  for (i=16; i>0; i--) {
    *(X++) = add_ub3(*(Y++),*(Z++));
  }

  gf_polymul_64x64_mod3(V+32, M+64, fh); // r * fh
  gf_polymul_64x64_mod3(CC128_1, M+80, gh); // s * gh

  for (Y=CC128_1, i=16; i>0; i--) {// r fh+s gh+g1
    T = add_ub3(add_ub3(*(W++),*(Y++)),*X); *(X++) = T;
  }
  for (i=16; i>0; i--) {
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
}

void gf_polymul_64x64_2x2_x_2x2_mod3(int *M, int *M1, int *M2){
int C128_1[33], C128_2[33];
C128_1[0]=C128_2[0]=0;
int * CC128_1 = (int *)((void *)C128_1 + 1);
int * CC128_2 = (int *)((void *)C128_2 + 1);

  int i, T, *X, *Y;

  gf_polymul_64x64_mod3(CC128_1, M2, M1); // x * u2 * u1
  gf_polymul_64x64_mod3(M, M2+16, M1+32); // v2 * r1
  for (i=32, X=M, Y=C128_1; i>0; i--) { // u = x * u2 * u1 + v2 * r1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_64x64_mod3(CC128_1, M2, M1+16); // x * u2 * v1
  gf_polymul_64x64_mod3(M+32, M2+16, M1+48); // v2 * s1
  for (i=32, Y=C128_1; i>0; i--) { // v = x * u2 * v1 + v2 * s1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_64x64_mod3(CC128_1, M2+32, M1); // x * r2 * u1
  gf_polymul_64x64_mod3(M+64, M2+48, M1+32); // s2 * r1
  for (i=32, Y=C128_1; i>0; i--) { // r = x * r2 * u1 + s2 * r1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_64x64_mod3(CC128_1, M2+32, M1+16); // x * r2 * v1
  gf_polymul_64x64_mod3(M+96, M2+48, M1+48); // s2 * s1
  for (i=32, Y=C128_1; i>0; i--) { // s = x * r2 * v1 + s2 * s1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
}

int jump128divsteps_mod3(int minusdelta, int* M, int* f, int* g){
  int M1[96], M2[96], fg[64];

  minusdelta = jump64divsteps_mod3(minusdelta, M1, f, g);
  gf_polymul_64x64_2x2_x2p2_mod3(fg, M1, f+16, g+16);
  minusdelta = jump64divsteps_mod3(minusdelta, M2, fg, fg+32);
  gf_polymul_64x64_2x2_x2p2_mod3(M, M2, fg+16, fg+48);
  gf_polymul_64x64_2x2_x_2x2_mod3(M+64, M1+32, M2+32);
  return minusdelta;
}
