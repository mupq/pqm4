#include <stdint.h>
#include "cmsis.h"
#include "ntt132x.h"

extern int jump128divsteps(int minusdelta, int *M, int *f, int *g);
int jump256divsteps(int minusdelta, int *M, int *f, int *g);

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

int jump256divsteps(int minusdelta, int *M, int *f, int *g){
  int M1[384], M2[384], fg[256];
  int u1[132], v1[132], r1[132], s1[132], fh[132], gh[132], tmp[132], tmp2[132];
  int u2[132], v2[132], r2[132], s2[132];
  int k=132;
  fg[0] = M[0] = 0;
  int i, T, *X, *Y, *W;

  minusdelta = jump128divsteps(minusdelta, M1, f, g);

  ntt264_128x(u1, M1+128);
  ntt264_128x(v1, M1+192);
  ntt264_128(r1, M1+256);
  ntt264_128(s1, M1+320);
  ntt264_128(fh, f+64);
  ntt264_128(gh, g+64);

  basemul_264(tmp, u1, fh);
  basemul_264(tmp2, v1, gh);
  for(X=tmp, Y=tmp2, i=k;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt264_256(fg, tmp);
  for (X=fg, W=M1, i=64; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  }
  for(i=64;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_264(tmp, r1, fh);
  basemul_264(tmp2, s1, gh);
  for(X=tmp, Y=tmp2, i=k;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt264_256(fg+128, tmp);
  for (X = fg+128, i=64; i>0; i--) {	// (r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  } 
  for(i=64;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  minusdelta = jump128divsteps(minusdelta, M2, fg, fg+128);

  ntt264_128x(u2, M2+128);
  ntt264_128x(v2, M2+192);
  ntt264_128(r2, M2+256);
  ntt264_128(s2, M2+320);
  ntt264_128(fh, fg+64);
  ntt264_128(gh, fg+192);

  basemul_264(tmp, u2, fh);
  basemul_264(tmp2, v2, gh);
  for(X=tmp, Y=tmp2, i=k;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt264_256(M, tmp);
  for (X=M, W=M2, i=64; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  }  
  for(i=64;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_264(tmp, r2, fh);
  basemul_264(tmp2, s2, gh);
  for(X=tmp, Y=tmp2, i=k;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt264_256(M+128, tmp);
  for (X = M+128, i=64; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  } 
  for(i=64;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_264(tmp, u2, u1);
  basemul_264(tmp2, v2, r1);
  for(X=tmp, Y=tmp2, i=k;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt264_256x(M+256, tmp);
  for (i=128, X=M+256 ; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(*X); *(X++) = T;
  }
  basemul_264(tmp, u2, v1);
  basemul_264(tmp2, v2, s1);
  for(X=tmp, Y=tmp2, i=k;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt264_256x(M+384, tmp);
  for (i=128, X=M+384 ; i>0; i--) {
    T = barrett_16x2i(*X); *(X++) = T;
  }
  basemul_264(tmp, r2, u1);
  basemul_264(tmp2, s2, r1);
  for(X=tmp, Y=tmp2, i=k;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt264_256(M+512, tmp);
  for (i=128, X=M+512 ; i>0; i--) {
    T = barrett_16x2i(*X); *(X++) = T;
  }
  basemul_264(tmp, r2, v1);
  basemul_264(tmp2, s2, s1);
  for(X=tmp, Y=tmp2, i=k;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt264_256(M+640, tmp);
  for (i=128, X=M+640 ; i>0; i--) {
    T = barrett_16x2i(*X); *(X++) = T;
  }

  return(minusdelta);
}