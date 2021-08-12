#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>

extern int jump128divsteps(int minusdelta, int *M, int *f, int *g);
int jump256divsteps(int minusdelta, int *M, int *f, int *g);

extern void ntt306(int*, int*);
extern void ntt306x(int*, int*);
extern void intt306(int*, int*);
extern void intt306x(int*, int*);
extern void basemul_306(int*, int*, int*);

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

int jump256divsteps(int minusdelta, int *M, int *f, int *g){
  int M1[384], M2[384], fg[256];
  int u1[153], v1[153], r1[153], s1[153], fh[153], gh[153], tmp[153], tmp2[153];
  int u2[153], v2[153], r2[153], s2[153];
  fg[0] = M[0] = 0;
  int i, T, *X, *Y, *W;

  minusdelta = jump128divsteps(minusdelta, M1, f, g);

  ntt306x(u1, M1+128);
  ntt306x(v1, M1+192);
  ntt306(r1, M1+256);
  ntt306(s1, M1+320);
  ntt306(fh, f+64);
  ntt306(gh, g+64);

  basemul_306(tmp, u1, fh);
  basemul_306(tmp2, v1, gh);
  for(X=tmp, Y=tmp2, i=153;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306(fg, tmp);
  for (X=fg, W=M1, i=64; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  }
  for(i=64;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_306(tmp, r1, fh);
  basemul_306(tmp2, s1, gh);
  for(X=tmp, Y=tmp2, i=153;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306(fg+128, tmp);
  for (X = fg+128, i=64; i>0; i--) {	// (r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  } 
  for(i=64;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  minusdelta = jump128divsteps(minusdelta, M2, fg, fg+128);

  ntt306x(u2, M2+128);
  ntt306x(v2, M2+192);
  ntt306(r2, M2+256);
  ntt306(s2, M2+320);
  ntt306(fh, fg+64);
  ntt306(gh, fg+192);

  basemul_306(tmp, u2, fh);
  basemul_306(tmp2, v2, gh);
  for(X=tmp, Y=tmp2, i=153;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306(M, tmp);
  for (X=M, W=M2, i=64; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  }  
  for(i=64;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_306(tmp, r2, fh);
  basemul_306(tmp2, s2, gh);
  for(X=tmp, Y=tmp2, i=153;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306(M+128, tmp);
  for (X = M+128, i=64; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  } 
  for(i=64;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_306(tmp, u2, u1);
  basemul_306(tmp2, v2, r1);
  for(X=tmp, Y=tmp2, i=153;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306x(M+256, tmp);
  for (i=128, X=M+256 ; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(*X); *(X++) = T;
  }
  basemul_306(tmp, u2, v1);
  basemul_306(tmp2, v2, s1);
  for(X=tmp, Y=tmp2, i=153;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306x(M+384, tmp);
  for (i=128, X=M+384 ; i>0; i--) {
    T = barrett_16x2i(*X); *(X++) = T;
  }
  basemul_306(tmp, r2, u1);
  basemul_306(tmp2, s2, r1);
  for(X=tmp, Y=tmp2, i=153;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306(M+512, tmp);
  for (i=128, X=M+512 ; i>0; i--) {
    T = barrett_16x2i(*X); *(X++) = T;
  }
  basemul_306(tmp, r2, v1);
  basemul_306(tmp2, s2, s1);
  for(X=tmp, Y=tmp2, i=153;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306(M+640, tmp);
  for (i=128, X=M+640 ; i>0; i--) {
    T = barrett_16x2i(*X); *(X++) = T;
  }

  return(minusdelta);
}