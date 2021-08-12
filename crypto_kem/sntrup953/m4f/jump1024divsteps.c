#include <stdint.h>
#include "cmsis.h"
#include "ntt42.h"

extern int jump512divsteps(int minusdelta, int *M, int *f, int *g);
int jump1024divsteps(int minusdelta, int *M, int *f, int *g);

#define q 6343
#define qR2inv 677119 // round(2^32/q)
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

int jump1024divsteps(int minusdelta, int *M, int *f, int *g){
  int M1[1536], M2[1536], fg[1024];
  int u1[588], v1[588], r1[588], s1[588], fh[588], gh[588], tmp[588], tmp2[588];
  int u2[588], v2[588], r2[588], s2[588];
  fg[0] = M[0] = 0;
  int i, T, *X, *Y, *W;

  minusdelta = jump512divsteps(minusdelta, M1, f, g);

  ntt1176_512x(u1, M1+512);
  ntt1176_512x(v1, M1+768);
  ntt1176_512(r1, M1+1024);
  ntt1176_512(s1, M1+1280);
  ntt1176_512(fh, f+256);
  ntt1176_512(gh, g+256);

  basemul_1176(tmp, u1, fh);
  basemul_1176(tmp2, v1, gh);
  for(X=tmp, Y=tmp2, i=588;i>0;--i){
      T = barrett_16x2i(__SADD16(*(Y++),*X));
      // T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt1176_1024(fg, tmp);
  for (X=fg, W=M1, i=256; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  }
  for(i=256;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_1176(tmp, r1, fh);
  basemul_1176(tmp2, s1, gh);
  for(X=tmp, Y=tmp2, i=588;i>0;--i){
      T = barrett_16x2i(__SADD16(*(Y++),*X));
      // T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt1176_1024(fg+512, tmp);
  for (X = fg+512, i=256; i>0; i--) {	// (r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  } 
  for(i=256;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  minusdelta = jump512divsteps(minusdelta, M2, fg, fg+512);

  ntt1176_512x(u2, M2+512);
  ntt1176_512x(v2, M2+768);
  ntt1176_512(r2, M2+1024);
  ntt1176_512(s2, M2+1280);
  ntt1176_512(fh, fg+256);
  ntt1176_512(gh, fg+768);

  basemul_1176(tmp, u2, fh);
  basemul_1176(tmp2, v2, gh);
  for(X=tmp, Y=tmp2, i=588;i>0;--i){
      T = barrett_16x2i(__SADD16(*(Y++),*X));
      // T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt1176_1024(M, tmp);
  for (X=M, W=M2, i=256; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  }  
  for(i=256;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_1176(tmp, r2, fh);
  basemul_1176(tmp2, s2, gh);
  for(X=tmp, Y=tmp2, i=588;i>0;--i){
      T = barrett_16x2i(__SADD16(*(Y++),*X));
      // T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt1176_1024(M+512, tmp);
  for (X = M+512, i=256; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  } 
  for(i=256;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  // v
  basemul_1176(tmp, u2, v1);
  basemul_1176(tmp2, v2, s1);
  for(X=tmp, Y=tmp2, i=588;i>0;--i){
      T = barrett_16x2i(__SADD16(*(Y++),*X));
      *(X++) = T;
  }
  intt1176_1024x(M+1024, tmp);
  for (i=512, X=M+1024 ; i>0; i--) {
    T = barrett_16x2i(*X); *(X++) = T;
  }

  // s
  basemul_1176(tmp, r2, v1);
  basemul_1176(tmp2, s2, s1);
  for(X=tmp, Y=tmp2, i=588;i>0;--i){
      T = barrett_16x2i(__SADD16(*(Y++),*X));
      *(X++) = T;
  }
  intt1176_1024(M+1536, tmp);
  for (i=512, X=M+1536 ; i>0; i--) {
    T = barrett_16x2i(*X); *(X++) = T;
  }

  return(minusdelta);
}