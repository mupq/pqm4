#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>
extern void gf_polymul_64x64(void *h, void *f, void *g);
extern int jump64divsteps(int minusdelta, int *M, int *f, int *g);
void jump128steps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_64x64_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_64x64_2x2_x_2x2 (int *M, int *M1, int *M2);

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
int B128_1[65], B128_2[65];
int * BB128_1 = (int *)((void *)B128_1 + 2);
int * BB128_2 = (int *)((void *)B128_2 + 2);

void gf_polymul_64x64_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;

  B128_1[0] = B128_2[0] = 0;
  gf_polymul_64x64(BB128_1, M+64, fh); 	// x * u * fh
  gf_polymul_64x64(BB128_2, M+96, gh);	// x * v * gh
  for (X=V, Y=B128_1, Z=B128_2, W=M, i=32; i>0; i--) {// x(u fh+v gh)+f1
    //V[i] = barrett_16x2i(__SADD16(__SADD16(M[i],B128_1[i]),B128_2[i]));
    *(X++) = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++)));
  }  
  for (i=32; i>0; i--) {  
    //V[i+32] = barrett_16x2i(__SADD16(B32_1[i+128],B32_2[i+128]));
    *(X++) = barrett_16x2i(__SADD16(*(Y++),(*Z++)));
  } 
  gf_polymul_64x64(V+64, M+128, fh);	// r * fh
  gf_polymul_64x64(BB128_1, M+160, gh);	// s * gh
  for (Y=BB128_1, i=32; i>0; i--) {	// x(r fh+s gh) + g1
    //V[i+64] = barrett_16x2i(__SADD16(__SADD16((BB128_1[i],V[i+64])),M[i+32]);
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  } 
  for (i=32; i>0; i--) {  
    //V[i+96] = barrett_16x2i(__SADD16(BB128_1[i+32],V[i+96]));
    T = barrett_16x2i(__SADD16(*X, *(Y++))); *(X++) = T;
  } 
}

void gf_polymul_64x64_2x2_x_2x2 (int *M, int *M1, int *M2) {
  int i, T, *X, *Y;

  B128_1[0] = B128_2[0] = 0;
  gf_polymul_64x64(BB128_1, M2, M1); 	// x * u2 * u1
  gf_polymul_64x64(M, M2+32, M1+64); 	// v2 * r1
  for (i=64, X=M, Y=B128_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    //M[i] =  barrett_16x2i(__SADD16(M[i],B128_1[i]));
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_64x64(BB128_1, M2, M1+32); 	// x * u2 * v1
  gf_polymul_64x64(M+64, M2+32, M1+96); 	// v2 * s1
  for (i=64, Y=B128_1; i > 0; i--) {	// v = x u2 v1 + v2 s1
    //M[64+i] =  barrett_16x2i(__SADD16(M[64+i],B128_1[i]));
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_64x64(BB128_1, M2+64, M1); 	// x * r2 * u1
  gf_polymul_64x64(M+128, M2+96, M1+64); 	// s2 * r1
  for (i=64, Y = B128_1; i > 0; i--) {	// s = x r2 u1 + s2 r1
    //M[128+i] =  barrett_16x2i(__SADD16(M[128+i],B128_1[i]));
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_64x64(BB128_1, M2+64, M1+32); 	// x * r2 * v1
  gf_polymul_64x64(M+192, M2+96, M1+96); 	// s2 * s1
  for (i=64, Y = B128_1; i > 0; i--) {	// s = x r2 v1 + s2 s1
    //M[192+i] =  barrett_16x2i(__SADD16(M[192+i],B128_1[i]));
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
}
int jump128divsteps(int minusdelta, int *M, int *f, int *g){
int M1[384], M2[384], fg[128];
  minusdelta = jump64divsteps(minusdelta, M1, f, g);
  /*
  printf("u1 = GF4591x(");
  printn((short *)(M1+64),64);
  printf(")\n");
  printf("v1 = GF4591x(");
  printn((short *)(M1+96),64);
  printf(")\n");
  printf("r1 = GF4591x(");
  printn((short *)(M1+128),64);
  printf(")\n");
  printf("s1 = GF4591x(");
  printn((short *)(M1+160),64);
  printf(")\n");

  printf("f1 = GF4591x(");
  printn((short *)(M1),64);
  printf(")\n");
  printf("g1 = GF4591x(");
  printn((short *)(M1+32),64);
  printf(")\n");
  */
  gf_polymul_64x64_2x2_x2p2 (fg, M1, f+32, g+32);
  /*
  printf("f2 = GF4591x(");
  printn((short *)(fg),128);
  printf(")\n");
  printf("g2 = GF4591x(");
  printn((short *)(fg+64),128);
  printf(")\n");
  */
  minusdelta = jump64divsteps(minusdelta, M2, fg, fg+64);
  /*
  printf("u2 = GF4591x(");
  printn((short *)(M2+64),64);
  printf(")\n");
  printf("v2 = GF4591x(");
  printn((short *)(M2+96),64);
  printf(")\n");
  printf("r2 = GF4591x(");
  printn((short *)(M2+128),64);
  printf(")\n");
  printf("s2 = GF4591x(");
  printn((short *)(M2+160),64);
  printf(")\n");

  printf("f3 = GF4591x(");
  printn((short *)(M2),64);
  printf(")\n");
  printf("g3 = GF4591x(");
  printn((short *)(M2+32),64);
  printf(")\n");
  */
  gf_polymul_64x64_2x2_x2p2 (M, M2, fg+32, fg+96);
  gf_polymul_64x64_2x2_x_2x2(M+128, M1+64, M2+64);
  return(minusdelta);
}
