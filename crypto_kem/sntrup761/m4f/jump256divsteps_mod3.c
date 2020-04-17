#include <stdint.h>
#include "red_mod3_int.h"
#include "cmsis.h"

extern int jump128divsteps_mod3(int minusdelta, int* M, int* f, int* g);
extern void gf_polymul_128x128_mod3(int* h, int* f, int* g);
int jump256divsteps_mod3(int minusdelta, int* M, int* f, int* g);
void gf_polymul_128x128_2x2_x2p2_mod3(int* V,int* M,int *fh, int* gh);
void gf_polymul_128x128_2x2_x_2x2_mod3(int* M,int* M1,int* M2);


void gf_polymul_128x128_2x2_x2p2_mod3(int *V,int *M,int *fh,int *gh){
int C256_1[65], C256_2[65];
C256_1[0]=C256_2[0]=0;
int * CC256_1 = (int *)((void *)C256_1 + 1);
int * CC256_2 = (int *)((void *)C256_2 + 1);

  int i, T, *X, *Y, *Z, *W;

  gf_polymul_128x128_mod3(CC256_1, M+64, fh); // x * u * fh
  gf_polymul_128x128_mod3(CC256_2, M+96, gh); // x * v * gh

  for (X=V, Y=C256_1, Z=C256_2, W=M, i=32; i>0; i--) {// x(u fh+v gh)+f1
    *(X++) = add_ub3(add_ub3(*(W++),*(Y++)),*(Z++));
  }
  for (i=32; i>0; i--) {
    *(X++) = add_ub3(*(Y++),*(Z++));
  }

  gf_polymul_128x128_mod3(V+64, M+128, fh); // r * fh
  gf_polymul_128x128_mod3(CC256_1, M+160, gh); // s * gh

  for (Y=CC256_1, i=32; i>0; i--) {// r fh+s gh+g1
    T = add_ub3(add_ub3(*(W++),*(Y++)),*X); *(X++) = T;
  }
  for (i=32; i>0; i--) {
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
}

void gf_polymul_128x128_2x2_x_2x2_mod3(int *M, int *M1, int *M2){
int C256_1[65], C256_2[65];
C256_1[0]=C256_2[0]=0;
int * CC256_1 = (int *)((void *)C256_1 + 1);
int * CC256_2 = (int *)((void *)C256_2 + 1);

  int i, T, *X, *Y;

  gf_polymul_128x128_mod3(CC256_1, M2, M1); // x * u2 * u1
  gf_polymul_128x128_mod3(M, M2+32, M1+64); // v2 * r1
  for (i=64, X=M, Y=C256_1; i>0; i--) { // u = x * u2 * u1 + v2 * r1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_128x128_mod3(CC256_1, M2, M1+32); // x * u2 * v1
  gf_polymul_128x128_mod3(M+64, M2+32, M1+96); // v2 * s1
  for (i=64, Y=C256_1; i>0; i--) { // v = x * u2 * v1 + v2 * s1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_128x128_mod3(CC256_1, M2+64, M1); // x * r2 * u1
  gf_polymul_128x128_mod3(M+128, M2+96, M1+64); // s2 * r1
  for (i=64, Y=C256_1; i>0; i--) { // r = x * r2 * u1 + s2 * r1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_128x128_mod3(CC256_1, M2+64, M1+32); // x * r2 * v1
  gf_polymul_128x128_mod3(M+192, M2+96, M1+96); // s2 * s1
  for (i=64, Y=C256_1; i>0; i--) { // s = x * r2 * v1 + s2 * s1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
}

int jump256divsteps_mod3(int minusdelta, int* M, int* f, int* g){
  int M1[192], M2[192], fg[128];

  minusdelta = jump128divsteps_mod3(minusdelta, M1, f, g);
  gf_polymul_128x128_2x2_x2p2_mod3(fg, M1, f+32, g+32);
  minusdelta = jump128divsteps_mod3(minusdelta, M2, fg, fg+64);
  gf_polymul_128x128_2x2_x2p2_mod3(M, M2, fg+32, fg+96);
  gf_polymul_128x128_2x2_x_2x2_mod3(M+128, M1+64, M2+64);
  return minusdelta;
}
