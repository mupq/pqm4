#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>
extern void gf_polymul_16x16_nr(void *h, void *f, void *g);
extern int jump16divsteps(int minusdelta, int *M, int *f, int *g);
void jump32steps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_16x16_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_16x16_2x2_x_2x2 (int *M, int *M1, int *M2);

#define q 4591
#define qR2inv 935519 // round(2^32/q)

static inline int barrett_32(int X) {
  int32_t X_TMP = __SMMULR(qR2inv,X);
  return(__MLS(q,X_TMP,X));
}

void gf_polymul_16x16_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int16_t *X, *W;
  int i, *Y, *Z;
  int B32_1[32], B32_2[32];

  X=(int16_t *)V;
  W=(int16_t *)M;
  Y=B32_1;
  Z=B32_2;

  gf_polymul_16x16_nr(Y, M+16, fh);  // x * u * fh
  gf_polymul_16x16_nr(Z, M+24, gh); // x * v * gh
  *(X++) = *(W++);
  // x(u fh+v gh)+f1
  for (i=16; i>1; i--) *(X++) = barrett_32((*(W++)) + (*(Y++)) + (*(Z++)));
  for (i=16; i>0; i--) *(X++) = barrett_32((*(Y++)) + (*(Z++)));

  Y -= 31;
  Z -= 31;
  gf_polymul_16x16_nr(Y, M+32, fh); // r * fh
  gf_polymul_16x16_nr(Z, M+40, gh); // s * gh
  // x(r fh+s gh) + g1
  for (i=16; i>0; i--) *(X++) = barrett_32((*(W++)) + (*(Y++)) + (*(Z++)));
  for (i=16; i>1; i--) *(X++) = barrett_32((*(Y++)) + (*(Z++)));
  *(X++) = 0;
}

void gf_polymul_16x16_2x2_x_2x2 (int *M, int *M1, int *M2) {
  int16_t *X;
  int i, *Y, *Z;
  int B32_1[32], B32_2[32];

  X=(int16_t *)M;
  Y=B32_1;
  Z=B32_2;

  gf_polymul_16x16_nr(Y, M2, M1);   // x * u2 * u1
  gf_polymul_16x16_nr(Z, M2+8, M1+16);   // v2 * r1
  // u = x u2 u1 + v2 r1
  *(X++) = barrett_32(*(Z++));
  for (i=31; i>1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));

  Y -= 31;
  Z -= 31;
  gf_polymul_16x16_nr(Y, M2, M1+8);   // x * u2 * v1
  gf_polymul_16x16_nr(Z, M2+8, M1+24);  // v2 * s1
  // v = x u2 v1 + v2 s1
  *(X++) = barrett_32(*(Z++));
  for (i=31; i > 1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));

  Y -= 31;
  Z -= 31;
  gf_polymul_16x16_nr(Y, M2+16, M1);   // x * r2 * u1
  gf_polymul_16x16_nr(Z, M2+24, M1+16);  // s2 * r1
  // s = x r2 u1 + s2 r1
  *(X++) = barrett_32(*(Z++));
  for (i=31; i > 1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));

  Y -= 31;
  Z -= 31;
  gf_polymul_16x16_nr(Y, M2+16, M1+8);   // x * r2 * v1
  gf_polymul_16x16_nr(Z, M2+24, M1+24);   // s2 * s1
  // s = x r2 v1 + s2 s1
  *(X++) = barrett_32(*(Z++));
  for (i=31; i > 1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));
}

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
  gf_polymul_16x16_2x2_x2p2 (fg, M1, f+8, g+8);
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
  gf_polymul_16x16_2x2_x2p2 (M, M2, fg+8, fg+24);
  gf_polymul_16x16_2x2_x_2x2(M+32, M1+16, M2+16);
  return(minusdelta);
}
