#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>

extern int jump32divsteps(int minusdelta, int *M, int *f, int *g);
int jump64divsteps(int minusdelta, int *M, int *f, int *g);
extern void __gf_polymul_32x32_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void __gf_polymul_32x32_2x2_x_2x2 (int *M, int *M1, int *M2);

int jump64divsteps(int minusdelta, int *M, int *f, int *g){
  int M1[96], M2[96], fg[64];
  minusdelta = jump32divsteps(minusdelta, M1, f, g);
  __gf_polymul_32x32_2x2_x2p2 (fg, M1, f+16, g+16);
  minusdelta = jump32divsteps(minusdelta, M2, fg, fg+32);
  __gf_polymul_32x32_2x2_x2p2 (M, M2, fg+16, fg+48);
  __gf_polymul_32x32_2x2_x_2x2(M+64, M1+32, M2+32);
  return(minusdelta);
}
