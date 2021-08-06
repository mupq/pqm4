#include <stdint.h>
#include "cmsis.h"
#include "ntt287x.h"

extern int jump256divsteps(int minusdelta, int *M, int *f, int *g);
int jump512divsteps(int minusdelta, int *M, int *f, int *g);

#define q 5167
#define qR2inv 831230 // round(2^32/q)
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

int jump512divsteps(int minusdelta, int *M, int *f, int *g){
  int M1[768], M2[768], fg[512];
  int u1[287], v1[287], r1[287], s1[287], fh[287], gh[287], tmp[287], tmp2[287];
  int u2[287], v2[287], r2[287], s2[287];
  fg[0] = M[0] = 0;
  int i, T, *X, *Y, *W;

  minusdelta = jump256divsteps(minusdelta, M1, f, g);

  ntt574_256x(u1, M1+256);
  ntt574_256x(v1, M1+384);
  ntt574_256(r1, M1+512);
  ntt574_256(s1, M1+640);
  ntt574_256(fh, f+128);
  ntt574_256(gh, g+128);

  basemul_574(tmp, u1, fh);
  basemul_574(tmp2, v1, gh);
  for(X=tmp, Y=tmp2, i=287;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt574_512(fg, tmp);
  for (X=fg, W=M1, i=128; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  }
  for(i=128;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_574(tmp, r1, fh);
  basemul_574(tmp2, s1, gh);
  for(X=tmp, Y=tmp2, i=287;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt574_512(fg+256, tmp);
  for (X = fg+256, i=128; i>0; i--) {	// (r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  } 
  for(i=128;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  minusdelta = jump256divsteps(minusdelta, M2, fg, fg+256);

  ntt574_256x(u2, M2+256);
  ntt574_256x(v2, M2+384);
  ntt574_256(r2, M2+512);
  ntt574_256(s2, M2+640);
  ntt574_256(fh, fg+128);
  ntt574_256(gh, fg+384);

  basemul_574(tmp, u2, fh);
  basemul_574(tmp2, v2, gh);
  for(X=tmp, Y=tmp2, i=287;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt574_512(M, tmp);
  for (X=M, W=M2, i=128; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  }  
  for(i=128;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_574(tmp, r2, fh);
  basemul_574(tmp2, s2, gh);
  for(X=tmp, Y=tmp2, i=287;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt574_512(M+256, tmp);
  for (X = M+256, i=128; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  } 
  for(i=128;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }


  basemul_574(tmp, u2, u1);
  basemul_574(tmp2, v2, r1);
  for(X=tmp, Y=tmp2, i=287;i>0;--i){
      T = barrett_16x2i(__SADD16(*(Y++),*X));
      *(X++) = T;
  }
  intt574_512x(M+512, tmp);
  // for (i=256, X=M+512 ; i>0; i--) {	// u = x u2 u1 + v2 r1
  //   T = barrett_16x2i(*X); *(X++) = T;
  // }
  basemul_574(tmp, u2, v1);
  basemul_574(tmp2, v2, s1);
  for(X=tmp, Y=tmp2, i=287;i>0;--i){
      T = barrett_16x2i(__SADD16(*(Y++),*X));
      *(X++) = T;
  }
  intt574_512x(M+768, tmp);
  // for (i=256, X=M+768 ; i>0; i--) {
  //   T = barrett_16x2i(*X); *(X++) = T;
  // }
  basemul_574(tmp, r2, u1);
  basemul_574(tmp2, s2, r1);
  for(X=tmp, Y=tmp2, i=287;i>0;--i){
      T = barrett_16x2i(__SADD16(*(Y++),*X));
      *(X++) = T;
  }
  intt574_512(M+1024, tmp);
  // for (i=256, X=M+1024 ; i>0; i--) {
  //   T = barrett_16x2i(*X); *(X++) = T;
  // }
  basemul_574(tmp, r2, v1);
  basemul_574(tmp2, s2, s1);
  for(X=tmp, Y=tmp2, i=287;i>0;--i){
      T = barrett_16x2i(__SADD16(*(Y++),*X));
      *(X++) = T;
  }
  intt574_512(M+1280, tmp);
  // for (i=256, X=M+1280 ; i>0; i--) {
  //   T = barrett_16x2i(*X); *(X++) = T;
  // }

  return(minusdelta);
}