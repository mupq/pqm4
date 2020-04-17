#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>
extern void gf_polymul_32x32(void *h, void *f, void *g);
extern int jump32divsteps(int minusdelta, int *M, int *f, int *g);
void jump64steps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_32x32_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_32x32_2x2_x_2x2 (int *M, int *M1, int *M2);

#define q 4591
#define qR2inv 935519 // round(2^32/q)
#define _2P15 (1 << 15)

#if 1
// result range: +- 2295 (note: 3 loads for _2P15 and the longer qR2inv)
static inline int barrett_16x2i(int X) {
  int32_t QL = __SMLAWB(qR2inv,X,_2P15);
  int32_t QH = __SMLAWT(qR2inv,X,_2P15);
  int32_t SL = __SMULBT(q,QL);
  int32_t SH = __SMULBT(q,QH);
  return(__SSUB16(X,__PKHBT(SL,SH,16)));
}

#else 
#define barrett_16x2i(A) (A)
#endif
//static
int B64_1[33], B64_2[33];
int * BB64_1 = (int *)((void *)B64_1 + 2);
int * BB64_2 = (int *)((void *)B64_2 + 2);

void gf_polymul_32x32_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;

  B64_1[0] = B64_2[0] = 0;
  gf_polymul_32x32(BB64_1, M+32, fh); 	// x * u * fh
  gf_polymul_32x32(BB64_2, M+48, gh);	// x * v * gh
  for (X=V, Y=B64_1, Z=B64_2, W=M, i=16; i>0; i--) {// x(u fh+v gh)+f1
    *(X++) = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++)));
  }  
  for (i=16; i>0; i--) {  
    *(X++) = barrett_16x2i(__SADD16(*(Y++),(*Z++)));
  } 
  gf_polymul_32x32(V+32, M+64, fh);	// r * fh
  gf_polymul_32x32(BB64_1, M+80, gh);	// s * gh
  for (Y=BB64_1, i=16; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  } 
  for (i=16; i>0; i--) {  
    //V[i+48] =  (__SADD16(BB64_1[i+16],V[i+48]));
    T = barrett_16x2i(__SADD16(*X, *(Y++))); *(X++) = T;
  } 
}

void gf_polymul_32x32_2x2_x_2x2 (int *M, int *M1, int *M2) {
  int i, T, *X, *Y;


  B64_1[0] = B64_2[0] = 0;
  gf_polymul_32x32(BB64_1, M2, M1); 	// x * u2 * u1
  gf_polymul_32x32(M, M2+16, M1+32); 	// v2 * r1
  for (i=32, X=M, Y=B64_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_32x32(BB64_1, M2, M1+16); 	// x * u2 * v1
  gf_polymul_32x32(M+32, M2+16, M1+48); 	// v2 * s1
  for (i=32, Y=B64_1; i > 0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_32x32(BB64_1, M2+32, M1); 	// x * r2 * u1
  gf_polymul_32x32(M+64, M2+48, M1+32); 	// s2 * r1
  for (i=32, Y = B64_1; i > 0; i--) {	// s = x r2 u1 + s2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_32x32(BB64_1, M2+32, M1+16); 	// x * r2 * v1
  gf_polymul_32x32(M+96, M2+48, M1+48); 	// s2 * s1
  for (i=32, Y = B64_1; i > 0; i--) {	// s = x r2 v1 + s2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
}
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
  gf_polymul_32x32_2x2_x2p2 (fg, M1, f+16, g+16);
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
  gf_polymul_32x32_2x2_x2p2 (M, M2, fg+16, fg+48);
  gf_polymul_32x32_2x2_x_2x2(M+64, M1+32, M2+32);
  return(minusdelta);
}
