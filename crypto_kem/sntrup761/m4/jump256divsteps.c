#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>
extern void gf_polymul_128x128(void *h, void *f, void *g);
extern int jump128divsteps(int minusdelta, int *M, int *f, int *g);
void jump256steps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_128x128_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_128x128_2x2_x_2x2 (int *M, int *M1, int *M2);

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
int B256_1[129], B256_2[129];
int * BB256_1 = (int *)((void *)B256_1 + 2);
int * BB256_2 = (int *)((void *)B256_2 + 2);

void gf_polymul_128x128_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;

  B256_1[0] = B256_2[0] = 0;
  gf_polymul_128x128(BB256_1, M+128, fh); 	// x * u * fh
  gf_polymul_128x128(BB256_2, M+192, gh);	// x * v * gh
  for (X=V, Y=B256_1, Z=B256_2, W=M, i=64; i>0; i--) {// x(u fh+v gh)+f1
    //V[i] = barrett_16x2i(__SADD16(__SADD16(M[i],B256_1[i]),B256_2[i]));
    *(X++) = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++)));
  }  
  for (i=64; i>0; i--) {  
    //V[i+64] = barrett_16x2i(__SADD16(B64_1[i+256],B64_2[i+256]));
    *(X++) = barrett_16x2i(__SADD16(*(Y++),(*Z++)));
  } 
  gf_polymul_128x128(V+128, M+256, fh);	// r * fh
  gf_polymul_128x128(BB256_1, M+320, gh);	// s * gh
  for (Y=BB256_1, i=64; i>0; i--) {	// x(r fh+s gh) + g1
    //V[i+128] = barrett_16x2i(__SADD16(__SADD16((BB256_1[i],V[i+128])),M[i+64]);
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  } 
  for (i=64; i>0; i--) {  
    //V[i+192] = barrett_16x2i(__SADD16(BB256_1[i+64],V[i+192]));
    T = barrett_16x2i(__SADD16(*X, *(Y++))); *(X++) = T;
  } 
}

void gf_polymul_128x128_2x2_x_2x2 (int *M, int *M1, int *M2) {
  int i, T, *X, *Y;

  B256_1[0] = B256_2[0] = 0;
  gf_polymul_128x128(BB256_1, M2, M1); 	// x * u2 * u1
  gf_polymul_128x128(M, M2+64, M1+128); 	// v2 * r1
  for (i=128, X=M, Y=B256_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    //M[i] =  barrett_16x2i(__SADD16(M[i],B256_1[i]));
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_128x128(BB256_1, M2, M1+64); 	// x * u2 * v1
  gf_polymul_128x128(M+128, M2+64, M1+192); 	// v2 * s1
  for (i=128, Y=B256_1; i > 0; i--) {	// v = x u2 v1 + v2 s1
    //M[128+i] =  barrett_16x2i(__SADD16(M[128+i],B256_1[i]));
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_128x128(BB256_1, M2+128, M1); 	// x * r2 * u1
  gf_polymul_128x128(M+256, M2+192, M1+128); 	// s2 * r1
  for (i=128, Y = B256_1; i > 0; i--) {	// s = x r2 u1 + s2 r1
    //M[256+i] =  barrett_16x2i(__SADD16(M[256+i],B256_1[i]));
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_128x128(BB256_1, M2+128, M1+64); 	// x * r2 * v1
  gf_polymul_128x128(M+384, M2+192, M1+192); 	// s2 * s1
  for (i=128, Y = B256_1; i > 0; i--) {	// s = x r2 v1 + s2 s1
    //M[384+i] =  barrett_16x2i(__SADD16(M[384+i],B256_1[i]));
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
}
int jump256divsteps(int minusdelta, int *M, int *f, int *g){
int M1[768], M2[768], fg[256];
  minusdelta = jump128divsteps(minusdelta, M1, f, g);
  /*
  printf("u1 = GF4591x(");
  printn((short *)(M1+128),128);
  printf(")\n");
  printf("v1 = GF4591x(");
  printn((short *)(M1+192),128);
  printf(")\n");
  printf("r1 = GF4591x(");
  printn((short *)(M1+256),128);
  printf(")\n");
  printf("s1 = GF4591x(");
  printn((short *)(M1+320),128);
  printf(")\n");

  printf("f1 = GF4591x(");
  printn((short *)(M1),128);
  printf(")\n");
  printf("g1 = GF4591x(");
  printn((short *)(M1+64),128);
  printf(")\n");
  */
  gf_polymul_128x128_2x2_x2p2 (fg, M1, f+64, g+64);
  /*
  printf("f2 = GF4591x(");
  printn((short *)(fg),256);
  printf(")\n");
  printf("g2 = GF4591x(");
  printn((short *)(fg+128),256);
  printf(")\n");
  */
  minusdelta = jump128divsteps(minusdelta, M2, fg, fg+128);
  /*
  printf("u2 = GF4591x(");
  printn((short *)(M2+128),128);
  printf(")\n");
  printf("v2 = GF4591x(");
  printn((short *)(M2+192),128);
  printf(")\n");
  printf("r2 = GF4591x(");
  printn((short *)(M2+256),128);
  printf(")\n");
  printf("s2 = GF4591x(");
  printn((short *)(M2+320),128);
  printf(")\n");

  printf("f3 = GF4591x(");
  printn((short *)(M2),128);
  printf(")\n");
  printf("g3 = GF4591x(");
  printn((short *)(M2+64),128);
  printf(")\n");
  */
  gf_polymul_128x128_2x2_x2p2 (M, M2, fg+64, fg+192);
  gf_polymul_128x128_2x2_x_2x2(M+256, M1+128, M2+128);
  return(minusdelta);
}
