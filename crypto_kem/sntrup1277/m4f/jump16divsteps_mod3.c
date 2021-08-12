#include <stdint.h>
// #include "red_mod3_int.h"
// #include "cmsis.h"

extern int jump8divsteps_mod3(int minusdelta, int* M, int* f, int* g);
int jump16divsteps_mod3(int minusdelta, int* M, int* f, int* g);
extern void __gf_polymul_8x8_2x2_x2p2_mod3(int* V,int* M,int *fh, int* gh);
extern void __gf_polymul_8x8_2x2_x_2x2_mod3(int* M,int* M1,int* M2);

int jump16divsteps_mod3(int minusdelta, int* M, int* f, int* g){
  int M1[12], M2[12], fg[8];

  minusdelta = jump8divsteps_mod3(minusdelta, M1, f, g);
  __gf_polymul_8x8_2x2_x2p2_mod3(fg, M1, f+2, g+2);
  minusdelta = jump8divsteps_mod3(minusdelta, M2, fg, fg+4);
  __gf_polymul_8x8_2x2_x2p2_mod3(M, M2, fg+2, fg+6);
  __gf_polymul_8x8_2x2_x_2x2_mod3(M+8, M1+4, M2+4);
  return minusdelta;
}
