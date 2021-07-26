#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>
extern void gf_polymul_8x8_nr(void *h, void *f, void *g);
extern int jump8divsteps(int minusdelta, int *M, int *f, int *g);
int jump16divsteps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_8x8_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_8x8_2x2_x_2x2 (int *M, int *M1, int *M2);

#define q 4591
#define qR2inv 935519 // round(2^32/q)

static inline int barrett_32(int X) {
  int32_t X_TMP = __SMMULR(qR2inv,X);
  return(__MLS(q,X_TMP,X));
}
extern void __gf_polymul_8x8_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void __gf_polymul_8x8_2x2_x_2x2 (int *M, int *M1, int *M2);


void gf_polymul_8x8_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int16_t *X, *W;
  int i, *Y, *Z;
  int B16_1[16], B16_2[16];

  X=(int16_t *)V;
  W=(int16_t *)M;
  Y=B16_1;
  Z=B16_2;

  gf_polymul_8x8_nr(Y, M+8, fh); 	// x * u * fh
  gf_polymul_8x8_nr(Z, M+12, gh);	// x * v * gh
  *(X++) = *(W++);
  // x(u fh+v gh)+f1
  for (i=8; i>1; i--) *(X++) = barrett_32((*(W++)) + (*(Y++)) + (*(Z++)));
  for (i=8; i>0; i--) *(X++) = barrett_32((*(Y++)) + (*(Z++)));

  Y -= 15;
  Z -= 15;
  gf_polymul_8x8_nr(Y, M+16, fh);	// r * fh
  gf_polymul_8x8_nr(Z, M+20, gh);	// s * gh
  // x(r fh+s gh) + g1
  for (i=8; i>0; i--) *(X++) = barrett_32((*(W++)) + (*(Y++)) + (*(Z++)));
  for (i=8; i>1; i--) *(X++) = barrett_32((*(Y++)) + (*(Z++)));
  *(X++) = 0;
}

void gf_polymul_8x8_2x2_x_2x2 (int *M, int *M1, int *M2) {
  int16_t *X;
  int i, *Y, *Z;
  int B16_1[16], B16_2[16];

  X=(int16_t *)M;
  Y=B16_1;
  Z=B16_2;

  gf_polymul_8x8_nr(Y, M2, M1);   // x * u2 * u1
  gf_polymul_8x8_nr(Z, M2+4, M1+8);   // v2 * r1
  // u = x u2 u1 + v2 r1
  *(X++) = barrett_32(*(Z++));
  for (i=15; i>1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));

  Y -= 15;
  Z -= 15;
  gf_polymul_8x8_nr(Y, M2, M1+4); 	// x * u2 * v1
  gf_polymul_8x8_nr(Z, M2+4, M1+12); 	// v2 * s1
  // v = x u2 v1 + v2 s1
  *(X++) = barrett_32(*(Z++));
  for (i=15; i > 1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));

  Y -= 15;
  Z -= 15;
  gf_polymul_8x8_nr(Y, M2+8, M1); 	// x * r2 * u1
  gf_polymul_8x8_nr(Z, M2+12, M1+8); 	// s2 * r1
  // s = x r2 u1 + s2 r1
  *(X++) = barrett_32(*(Z++));
  for (i=15; i > 1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));

  Y -= 15;
  Z -= 15;
  gf_polymul_8x8_nr(Y, M2+8, M1+4); 	// x * r2 * v1
  gf_polymul_8x8_nr(Z, M2+12, M1+12); 	// s2 * s1
  // s = x r2 v1 + s2 s1
  *(X++) = barrett_32(*(Z++));
  for (i=15; i > 1; i--) *(X++) = barrett_32((*(Z++)) + (*(Y++)));
  *(X++) = barrett_32(*(Y++));
}

int jump16divsteps(int minusdelta, int *M, int *f, int *g){
int M1[24], M2[24], fg[16];
  minusdelta = jump8divsteps(minusdelta, M1, f, g);

  // gf_polymul_8x8_2x2_x2p2 (fg, M1, f+4, g+4);
  __gf_polymul_8x8_2x2_x2p2 (fg, M1, f+4, g+4);

  minusdelta = jump8divsteps(minusdelta, M2, fg, fg+8);

  // gf_polymul_8x8_2x2_x2p2 (M, M2, fg+4, fg+12);
  __gf_polymul_8x8_2x2_x2p2 (M, M2, fg+4, fg+12);
  // gf_polymul_8x8_2x2_x_2x2(M+16, M1+8, M2+8);
  __gf_polymul_8x8_2x2_x_2x2(M+16, M1+8, M2+8);
  return(minusdelta);
}
