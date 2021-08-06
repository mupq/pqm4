#include <stdint.h>
#include "cmsis.h"
#include "ntt132x.h"

extern void gf_polymul_32x32(int *h, int *f, int *g);
extern void gf_polymul_512x32_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern int jump512divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump32divsteps(int minusdelta, int *M, int *f, int *g);

int jump544divsteps(int minusdelta, int *M, int *f, int *g);

#define q 4621
#define qR2inv 929445 // round(2^32/q)
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

void gf_polymul_512x32_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;
  int B753_1[385], B753_2[385];
  int * BB753_1 = (int *)((void *)B753_1 + 2);
  int * BB753_2 = (int *)((void *)B753_2 + 2);

  B753_1[0] = B753_2[0] = 0;
  gf_polymul_32x32(BB753_1, fh, M+512); 	// x * u * fh
  gf_polymul_32x32(BB753_2, gh, M+768);	// x * v * gh
  for (X=V, Y=B753_1, Z=B753_2, W=M, i=16; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  }

  gf_polymul_32x32(B753_1, fh, M+1024);	// r * fh
  gf_polymul_32x32(B753_2, gh, M+1280);	// s * gh
  for (Y=B753_1, Z=B753_2, W=M+256, i=16; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  } 
}

int jump544divsteps(int minusdelta, int *M, int *f, int *g){
  int i;
  int M1[1536], M2[96], fg1[32];

  minusdelta = jump512divsteps(minusdelta, M1, f, g);
  gf_polymul_512x32_2x2_x2p2(fg1,M1,f+256,g+256); // fg : f1 head , fg+16 : g1 head
  minusdelta = jump32divsteps(minusdelta, M2, fg1, fg1+16);
  
  for(i=0;i<32;i++)M[i]=M2[i];

  // gf_polymul_32x512_2x2_x_2x2_onlyuv(M+32,M1+512,M2+32);
  int u1[396], v1[396], r1[396], s1[396], tmp1[396], tmp2[396];
  int u2[396], v2[396];
  int T, *X, *Y;
  ntt792_512x(u1, M1+512);
  ntt792_512x(v1, M1+768);
  ntt792_512(r1, M1+1024);
  ntt792_512(s1, M1+1280);

  for(i=16;i<128;++i)tmp1[i]=0;
  for(X = M2+32, Y = tmp1, i=16;i>0;--i)*(Y++) = *(X++);
  ntt792_256x(u2, tmp1);
  for(X = M2+48, Y = tmp1, i=16;i>0;--i)*(Y++) = *(X++);
  ntt792_256x(v2, tmp1);

  basemul_792(tmp1, u2, u1);
  basemul_792(tmp2, v2, r1);
  for(X=tmp1, Y=tmp2, i=396;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt792_768x(M+32, tmp1);
  for (i=384, X=M+32 ; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_792(tmp1, u2, v1);
  basemul_792(tmp2, v2, s1);
  for(X=tmp1, Y=tmp2, i=396;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt792_768x(M+416, tmp1);
  for (i=384, X=M+416 ; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(*X); *(X++) = T;
  }

  return(minusdelta);
}