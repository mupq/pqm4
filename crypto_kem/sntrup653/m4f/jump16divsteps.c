#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>

extern int jump8divsteps(int minusdelta, int *M, int *f, int *g);
extern void __gf_polymul_8x8_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void __gf_polymul_8x8_2x2_x_2x2 (int *M, int *M1, int *M2);
int jump16divsteps(int minusdelta, int *M, int *f, int *g);

int jump16divsteps(int minusdelta, int *M, int *f, int *g){
int M1[48], M2[48], fg[16];
  minusdelta = jump8divsteps(minusdelta, M1, f, g);
  /*
  printf("u1 = GF4591x(");
  printn((short *)(M1+8),8);
  printf(")\n");
  printf("v1 = GF4591x(");
  printn((short *)(M1+12),8);
  printf(")\n");
  printf("r1 = GF4591x(");
  printn((short *)(M1+16),8);
  printf(")\n");
  printf("s1 = GF4591x(");
  printn((short *)(M1+20),8);
  printf(")\n");

  printf("f1 = GF4591x(");
  printn((short *)(M1),8);
  printf(")\n");
  printf("g1 = GF4591x(");
  printn((short *)(M1+4),8);
  printf(")\n");
  */
  __gf_polymul_8x8_2x2_x2p2 (fg, M1, f+4, g+4);
  /*
  printf("f2 = GF4591x(");
  printn((short *)(fg),16);
  printf(")\n");
  printf("g2 = GF4591x(");
  printn((short *)(fg+8),16);
  printf(")\n");
  */
  minusdelta = jump8divsteps(minusdelta, M2, fg, fg+8);
  /*
  printf("u2 = GF4591x(");
  printn((short *)(M2+8),8);
  printf(")\n");
  printf("v2 = GF4591x(");
  printn((short *)(M2+12),8);
  printf(")\n");
  printf("r2 = GF4591x(");
  printn((short *)(M2+16),8);
  printf(")\n");
  printf("s2 = GF4591x(");
  printn((short *)(M2+20),8);
  printf(")\n");

  printf("f3 = GF4591x(");
  printn((short *)(M2),8);
  printf(")\n");
  printf("g3 = GF4591x(");
  printn((short *)(M2+4),8);
  printf(")\n");
  */
  __gf_polymul_8x8_2x2_x2p2 (M, M2, fg+4, fg+12);
  __gf_polymul_8x8_2x2_x_2x2(M+16, M1+8, M2+8);
  return(minusdelta);
}
