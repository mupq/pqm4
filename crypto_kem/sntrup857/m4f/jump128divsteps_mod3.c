#include <stdint.h>

extern int jump64divsteps_mod3(int minusdelta, int* M, int* f, int* g);
int jump128divsteps_mod3(int minusdelta, int* M, int* f, int* g);
extern void __gf_polymul_64x64_2x2_x2p2_mod3(int* V,int* M,int *fh, int* gh);
extern void __gf_polymul_64x64_2x2_x_2x2_mod3(int* M,int* M1,int* M2);

int jump128divsteps_mod3(int minusdelta, int* M, int* f, int* g){
  int M1[96], M2[96], fg[64];

  minusdelta = jump64divsteps_mod3(minusdelta, M1, f, g);
  __gf_polymul_64x64_2x2_x2p2_mod3(fg, M1, f+16, g+16);
  minusdelta = jump64divsteps_mod3(minusdelta, M2, fg, fg+32);
  // __gf_polymul_64x64_2x2_x2p2_mod3(M, M2, fg+16, fg+48);
  __gf_polymul_64x64_2x2_x_2x2_mod3(M+64, M1+32, M2+32);
  return minusdelta;
}
