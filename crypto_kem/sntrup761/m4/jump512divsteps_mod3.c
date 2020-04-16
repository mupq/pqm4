#include <stdint.h>
#include "red_mod3_int.h"
#include "cmsis.h"

extern int jump256divsteps_mod3(int minusdelta, int* M, int* f, int* g);
extern void gf_polymul_256x256_mod3(int* h, int* f, int* g);
int jump512divsteps_mod3(int minusdelta, int* M, int* f, int* g);
void gf_polymul_256x256_2x2_x2p2_mod3(int* V,int* M,int *fh, int* gh);
void gf_polymul_256x256_2x2_x_2x2_mod3(int* M,int* M1,int* M2);



void gf_polymul_256x256_2x2_x2p2_mod3(int *V,int *M,int *fh,int *gh){
int C512_1[129], C512_2[129];
C512_1[0]=C512_2[0]=0;
int * CC512_1 = (int *)((void *)C512_1 + 1);
int * CC512_2 = (int *)((void *)C512_2 + 1);

  int i, T, *X, *Y, *Z, *W;

  gf_polymul_256x256_mod3(CC512_1, M+128, fh); // x * u * fh
  gf_polymul_256x256_mod3(CC512_2, M+192, gh); // x * v * gh

  for (X=V, Y=C512_1, Z=C512_2, W=M, i=64; i>0; i--) {// x(u fh+v gh)+f1
    *(X++) = add_ub3(add_ub3(*(W++),*(Y++)),*(Z++));
  }
  for (i=64; i>0; i--) {
    *(X++) = add_ub3(*(Y++),*(Z++));
  }

  gf_polymul_256x256_mod3(V+128, M+256, fh); // r * fh
  gf_polymul_256x256_mod3(CC512_1, M+320, gh); // s * gh

  for (Y=CC512_1, i=64; i>0; i--) {// r fh+s gh+g1
    T = add_ub3(add_ub3(*(W++),*(Y++)),*X); *(X++) = T;
  }
  for (i=64; i>0; i--) {
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
}

void gf_polymul_256x256_2x2_x_2x2_mod3(int *M, int *M1, int *M2){
int C512_1[129], C512_2[129];
C512_1[0]=C512_2[0]=0;
int * CC512_1 = (int *)((void *)C512_1 + 1);
int * CC512_2 = (int *)((void *)C512_2 + 1);

  int i, T, *X, *Y;

  gf_polymul_256x256_mod3(CC512_1, M2, M1); // x * u2 * u1
  gf_polymul_256x256_mod3(M, M2+64, M1+128); // v2 * r1
  for (i=128, X=M, Y=C512_1; i>0; i--) { // u = x * u2 * u1 + v2 * r1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_256x256_mod3(CC512_1, M2, M1+64); // x * u2 * v1
  gf_polymul_256x256_mod3(M+128, M2+64, M1+192); // v2 * s1
  for (i=128, Y=C512_1; i>0; i--) { // v = x * u2 * v1 + v2 * s1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_256x256_mod3(CC512_1, M2+128, M1); // x * r2 * u1
  gf_polymul_256x256_mod3(M+256, M2+192, M1+128); // s2 * r1
  for (i=128, Y=C512_1; i>0; i--) { // r = x * r2 * u1 + s2 * r1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
  gf_polymul_256x256_mod3(CC512_1, M2+128, M1+64); // x * r2 * v1
  gf_polymul_256x256_mod3(M+384, M2+192, M1+192); // s2 * s1
  for (i=128, Y=C512_1; i>0; i--) { // s = x * r2 * v1 + s2 * s1
    T = add_ub3(*X, *(Y++)); *(X++) = T;
  }
}

int jump512divsteps_mod3(int minusdelta, int* M, int* f, int* g){
  int M1[384], M2[384], fg[256];

  minusdelta = jump256divsteps_mod3(minusdelta, M1, f, g);
  gf_polymul_256x256_2x2_x2p2_mod3(fg, M1, f+64, g+64);
  minusdelta = jump256divsteps_mod3(minusdelta, M2, fg, fg+128);
  gf_polymul_256x256_2x2_x2p2_mod3(M, M2, fg+64, fg+192);
  gf_polymul_256x256_2x2_x_2x2_mod3(M+256, M1+128, M2+128);
  return minusdelta;
}
