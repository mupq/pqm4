#include <stdint.h>

extern int jump64divsteps(int minusdelta, int *M, int *f, int *g);
extern void __gf_polymul_64x64_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void __gf_polymul_64x64_2x2_x_2x2 (int *M, int *M1, int *M2);
int jump128divsteps(int minusdelta, int *M, int *f, int *g);

int jump128divsteps(int minusdelta, int *M, int *f, int *g){
  int M1[192], M2[192], fg[128];
  minusdelta = jump64divsteps(minusdelta, M1, f, g);
  __gf_polymul_64x64_2x2_x2p2 (fg, M1, f+32, g+32);
  minusdelta = jump64divsteps(minusdelta, M2, fg, fg+64);
  __gf_polymul_64x64_2x2_x2p2 (M, M2, fg+32, fg+96);
  __gf_polymul_64x64_2x2_x_2x2(M+128, M1+64, M2+64);
  return(minusdelta);
}
