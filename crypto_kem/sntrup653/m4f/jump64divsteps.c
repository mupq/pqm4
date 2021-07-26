#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>
// extern void gf_polymul_32x32(void *h, void *f, void *g);
extern int jump32divsteps(int minusdelta, int *M, int *f, int *g);
extern void __gf_polymul_32x32_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void __gf_polymul_32x32_2x2_x_2x2 (int *M, int *M1, int *M2);
int jump64divsteps(int minusdelta, int *M, int *f, int *g);

int jump64divsteps(int minusdelta, int *M, int *f, int *g){
int M1[192], M2[192], fg[64];
  minusdelta = jump32divsteps(minusdelta, M1, f, g);
  /*
  printf("u1 = GF4591x(");
  printn((short *)(M1+32),32);
  printf(")\n");
  printf("v1 = GF4591x(");
  printn((short *)(M1+48),32);
  printf(")\n");
  printf("r1 = GF4591x(");
  printn((short *)(M1+64),32);
  printf(")\n");
  printf("s1 = GF4591x(");
  printn((short *)(M1+80),32);
  printf(")\n");

  printf("f1 = GF4591x(");
  printn((short *)(M1),32);
  printf(")\n");
  printf("g1 = GF4591x(");
  printn((short *)(M1+16),32);
  printf(")\n");
  */
  __gf_polymul_32x32_2x2_x2p2 (fg, M1, f+16, g+16);
  /*
  printf("f2 = GF4591x(");
  printn((short *)(fg),64);
  printf(")\n");
  printf("g2 = GF4591x(");
  printn((short *)(fg+32),64);
  printf(")\n");
  */
  minusdelta = jump32divsteps(minusdelta, M2, fg, fg+32);
  /*
  printf("u2 = GF4591x(");
  printn((short *)(M2+32),32);
  printf(")\n");
  printf("v2 = GF4591x(");
  printn((short *)(M2+48),32);
  printf(")\n");
  printf("r2 = GF4591x(");
  printn((short *)(M2+64),32);
  printf(")\n");
  printf("s2 = GF4591x(");
  printn((short *)(M2+80),32);
  printf(")\n");

  printf("f3 = GF4591x(");
  printn((short *)(M2),32);
  printf(")\n");
  printf("g3 = GF4591x(");
  printn((short *)(M2+16),32);
  printf(")\n");
  */
  __gf_polymul_32x32_2x2_x2p2 (M, M2, fg+16, fg+48);
  __gf_polymul_32x32_2x2_x_2x2(M+64, M1+32, M2+32);
  return(minusdelta);
}
