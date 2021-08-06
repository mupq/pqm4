#include <stdint.h>

extern int jump16divsteps(int minusdelta, int *M, int *f, int *g);
extern void __gf_polymul_16x16_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void __gf_polymul_16x16_2x2_x_2x2 (int *M, int *M1, int *M2);
int jump32divsteps(int minusdelta, int *M, int *f, int *g);

int jump32divsteps(int minusdelta, int *M, int *f, int *g){
  int M1[48], M2[48], fg[32];
  minusdelta = jump16divsteps(minusdelta, M1, f, g);
  __gf_polymul_16x16_2x2_x2p2 (fg, M1, f+8, g+8);
  minusdelta = jump16divsteps(minusdelta, M2, fg, fg+16);
  __gf_polymul_16x16_2x2_x2p2 (M, M2, fg+8, fg+24);
  __gf_polymul_16x16_2x2_x_2x2(M+32, M1+16, M2+16);
  return(minusdelta);
}
