#include <stdint.h>
#include "cmsis.h"

extern void gf_polymul_128x128(int *h, int *f, int *g);
extern int jump128divsteps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_128x128_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_128x128_2x2_x_2x2 (int *M, int *M1, int *M2);
int jump256divsteps(int minusdelta, int *M, int *f, int *g);

#define q 7879
#define qR2inv 545116 // round(2^32/q)
#define _2P15 (1 << 15)

#if 1
// result range: +- q/2 (note: 3 loads for _2P15 and the longer qR2inv)
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

void gf_polymul_128x128_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *W;
  int B256_1[129];
  int * BB256_1 = (int *)((void *)B256_1 + 2);
  B256_1[0] = V[0] = 0;
  gf_polymul_128x128(BB256_1, M+128, fh); 	// x * u * fh
  gf_polymul_128x128((int*)((void*)V+2), M+192, gh);	// x * v * gh
  for (X=V, Y=B256_1, W=M, i=64; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  }  
  for (i=64; i>0; i--) {  
    T = barrett_16x2i(__SADD16(*(Y++),*X)); *(X++) = T;
  } 
  gf_polymul_128x128(V+128, M+256, fh);	// r * fh
  gf_polymul_128x128(BB256_1, M+320, gh);	// s * gh
  for (Y=BB256_1, i=64; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  } 
  for (i=64; i>0; i--) {  
    T = barrett_16x2i(__SADD16(*X, *(Y++))); *(X++) = T;
  } 
}

void gf_polymul_128x128_2x2_x_2x2 (int *M, int *M1, int *M2) {
  int i, T, *X, *Y;
  int B256_1[129];
  int * BB256_1 = (int *)((void *)B256_1 + 2);
  B256_1[0] = 0;
  gf_polymul_128x128(BB256_1, M2, M1); 	// x * u2 * u1
  gf_polymul_128x128(M, M2+64, M1+128); 	// v2 * r1
  for (i=128, X=M, Y=B256_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_128x128(BB256_1, M2, M1+64); 	// x * u2 * v1
  gf_polymul_128x128(M+128, M2+64, M1+192); 	// v2 * s1
  for (i=128, Y=B256_1; i > 0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_128x128(BB256_1, M2+128, M1); 	// x * r2 * u1
  gf_polymul_128x128(M+256, M2+192, M1+128); 	// s2 * r1
  for (i=128, Y = B256_1; i > 0; i--) {	// s = x r2 u1 + s2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
  gf_polymul_128x128(BB256_1, M2+128, M1+64); 	// x * r2 * v1
  gf_polymul_128x128(M+384, M2+192, M1+192); 	// s2 * s1
  for (i=128, Y = B256_1; i > 0; i--) {	// s = x r2 v1 + s2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
}

int jump256divsteps(int minusdelta, int *M, int *f, int *g){
  int M1[384], M2[384], fg[256];
  minusdelta = jump128divsteps(minusdelta, M1, f, g);
  gf_polymul_128x128_2x2_x2p2 (fg, M1, f+64, g+64);
  minusdelta = jump128divsteps(minusdelta, M2, fg, fg+128);
  gf_polymul_128x128_2x2_x2p2 (M, M2, fg+64, fg+192);
  gf_polymul_128x128_2x2_x_2x2(M+256, M1+128, M2+128);
  return(minusdelta);
}
