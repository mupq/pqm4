#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>

extern int jump4divsteps(int minusdelta, int *M, int *f, int *g);
extern void polymul_4x4_nr7(void *h, void *f, void *g); 
int jump8divsteps(int minusdelta, int *M, int *f, int *g);
void polymul_4x4_2x2_x2p2 (int *V, int *M, int *fh, int *gh);
void polymul_4x4_2x2_x_2x2 (int *M, int *M1, int *M2);

#define q 4591
#define qR2inv 935519 // round(2^32/q)

static inline int barrett_32(int X) {
  int32_t X_TMP = __SMMULR(qR2inv,X);
  return(__MLS(q,X_TMP,X));
}

void polymul_4x4_2x2_x2p2 (int *V, int *M, int *fh, int *gh) {
  int16_t *X, *W;
  int i, *Y, *Z;
  int B8_1[7], B8_2[7];

  X=(int16_t *)V;
  W=(int16_t *)M;
  Y=B8_1;
  Z=B8_2;

  polymul_4x4_nr7(Y, M+4, fh);  // x * u * fh
  polymul_4x4_nr7(Z, M+6, gh); // x * v * gh
  // x(u fh+v gh)+f1
  *(X++) = *(W++);
  for (i=4; i>1; i--) *(X++) = barrett_32((*(W++)) + (*(Y++)) + (*(Z++)));
  for (i=4; i>0; i--) *(X++) = barrett_32((*(Y++)) + (*(Z++)));

  Y -= 7;
  Z -= 7;
  polymul_4x4_nr7(Y, M+8, fh); // r * fh
  polymul_4x4_nr7(Z, M+10, gh); // s * gh
  // x(r fh+s gh) + g1
  for (i=4; i>0; i--) *(X++) = barrett_32((*(W++)) + (*(Y++)) + (*(Z++)));
  for (i=4; i>1; i--) *(X++) = barrett_32((*(Y++)) + (*(Z++)));
  *(X++) = 0;
}

void polymul_4x4_2x2_x_2x2 (int *M, int *M1, int *M2) {
  int16_t *X;
  int i, *Y, *Z;
  int B8_1[7], B8_2[7];

  X=(int16_t *)M;
  Y=B8_1;
  Z=B8_2;

  polymul_4x4_nr7(Y, M2, M1);   // x * u2 * u1
  polymul_4x4_nr7(Z, M2+2, M1+4);   // v2 * r1
  // u = x u2 u1 + v2 r1
  *(X++) = barrett_32(*(Z++));
  for (i=7; i>1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));

  Y -= 7;
  Z -= 7;
  polymul_4x4_nr7(Y, M2, M1+2);   // x * u2 * v1
  polymul_4x4_nr7(Z, M2+2, M1+6);  // v2 * s1
  // v = x u2 v1 + v2 s1
  *(X++) = barrett_32(*(Z++));
  for (i=7; i > 1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));

  Y -= 7;
  Z -= 7;
  polymul_4x4_nr7(Y, M2+4, M1);   // x * r2 * u1
  polymul_4x4_nr7(Z, M2+6, M1+4);  // s2 * r1
  // s = x r2 u1 + s2 r1
  *(X++) = barrett_32(*(Z++));
  for (i=7; i > 1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));

  Y -= 7;
  Z -= 7;
  polymul_4x4_nr7(Y, M2+4, M1+2);   // x * r2 * v1
  polymul_4x4_nr7(Z, M2+6, M1+6);   // s2 * s1
  // s = x r2 v1 + s2 s1
  *(X++) = barrett_32(*(Z++));
  for (i=7; i > 1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));
}

int jump8divsteps(int minusdelta, int *M, int *f, int *g){
  int M1[24], M2[24], fg[8];

  minusdelta = jump4divsteps(minusdelta, M1, f, g);

  /*
  printf("u1 = GF4591x(");
  printn((short *)(M1+4),4);
  printf(")\n");
  printf("v1 = GF4591x(");
  printn((short *)(M1+6),4);
  printf(")\n");
  printf("r1 = GF4591x(");
  printn((short *)(M1+8),4);
  printf(")\n");
  printf("s1 = GF4591x(");
  printn((short *)(M1+10),4);
  printf(")\n");

  printf("f1 = GF4591x(");
  printn((short *)(M1),4);
  printf(")\n");
  printf("g1 = GF4591x(");
  printn((short *)(M1+2),4);
  printf(")\n");
  */
  polymul_4x4_2x2_x2p2 (fg, M1, f+2, g+2);

  /*
  printf("f2 = GF4591x(");
  printn((short *)(fg),8);
  printf(")\n");
  printf("g2 = GF4591x(");
  printn((short *)(fg+4),8);
  printf(")\n");
  */
  
  minusdelta = jump4divsteps(minusdelta, M2, fg, fg+4);

  /*
  printf("u2 = GF4591x(");
  printn((short *)(M2+4),4);
  printf(")\n");
  printf("v2 = GF4591x(");
  printn((short *)(M2+6),4);
  printf(")\n");
  printf("r2 = GF4591x(");
  printn((short *)(M2+8),4);
  printf(")\n");
  printf("s2 = GF4591x(");
  printn((short *)(M2+10),4);
  printf(")\n");
  
  printf("f3 = GF4591x(");
  printn((short *)(M2),4);
  printf(")\n");
  printf("g3 = GF4591x(");
  printn((short *)(M2+2),4);
  printf(")\n");
  */
  
  polymul_4x4_2x2_x2p2 (M, M2, fg+2, fg+6);
  polymul_4x4_2x2_x_2x2(M+8, M1+4, M2+4);
  return(minusdelta);
}

