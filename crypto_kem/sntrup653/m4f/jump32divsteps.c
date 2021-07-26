#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>

extern int jump16divsteps(int minusdelta, int *M, int *f, int *g);
extern void __gf_polymul_16x16_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void __gf_polymul_16x16_2x2_x_2x2 (int *M, int *M1, int *M2);
int jump32divsteps(int minusdelta, int *M, int *f, int *g);

int jump32divsteps(int minusdelta, int *M, int *f, int *g){
int M1[96], M2[96], fg[32];
  minusdelta = jump16divsteps(minusdelta, M1, f, g);
  /*
  printf("u1 = GF4591x(");
  printn((short *)(M1+16),16);
  printf(")\n");
  printf("v1 = GF4591x(");
  printn((short *)(M1+24),16);
  printf(")\n");
  printf("r1 = GF4591x(");
  printn((short *)(M1+32),16);
  printf(")\n");
  printf("s1 = GF4591x(");
  printn((short *)(M1+40),16);
  printf(")\n");

  printf("f1 = GF4591x(");
  printn((short *)(M1),16);
  printf(")\n");
  printf("g1 = GF4591x(");
  printn((short *)(M1+8),16);
  printf(")\n");
  */
  __gf_polymul_16x16_2x2_x2p2 (fg, M1, f+8, g+8);
  /*
  printf("f2 = GF4591x(");
  printn((short *)(fg),32);
  printf(")\n");
  printf("g2 = GF4591x(");
  printn((short *)(fg+16),32);
  printf(")\n");
  */
  minusdelta = jump16divsteps(minusdelta, M2, fg, fg+16);
  /*
  printf("u2 = GF4591x(");
  printn((short *)(M2+16),16);
  printf(")\n");
  printf("v2 = GF4591x(");
  printn((short *)(M2+24),16);
  printf(")\n");
  printf("r2 = GF4591x(");
  printn((short *)(M2+32),16);
  printf(")\n");
  printf("s2 = GF4591x(");
  printn((short *)(M2+40),16);
  printf(")\n");

  printf("f3 = GF4591x(");
  printn((short *)(M2),16);
  printf(")\n");
  printf("g3 = GF4591x(");
  printn((short *)(M2+8),16);
  printf(")\n");
  */
  __gf_polymul_16x16_2x2_x2p2 (M, M2, fg+8, fg+24);
  __gf_polymul_16x16_2x2_x_2x2(M+32, M1+16, M2+16);
  return(minusdelta);
}
