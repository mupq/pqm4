#include <stdint.h>
#include "cmsis.h"
#include "ntt132x.h"

extern int jump256divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump512divsteps(int minusdelta, int *M, int *f, int *g);
int jump768divsteps(int minusdelta, int *M, int *f, int *g);

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

int jump768divsteps(int minusdelta, int *M, int *f, int *g){
    int M1[1536], M2[768], fg[768];
    int u1[396], v1[396], r1[396], s1[396], fh[396], gh[396], tmp1[396], tmp2[396];
    int u2[396], v2[396], r2[396], s2[396];
    int i, T, *X, *Y, *W;
    
    minusdelta = jump512divsteps(minusdelta,M1,f,g);
    
    ntt792_512x(u1, M1+512);
    ntt792_512x(v1, M1+768);
    ntt792_512(r1, M1+1024);
    ntt792_512(s1, M1+1280);
    ntt792_256(fh, f+256);
    ntt792_256(gh, g+256);

    basemul_792(tmp1, u1, fh);
    basemul_792(tmp2, v1, gh);
    for(X = tmp1, Y = tmp2, i=396; i>0; --i){
      T = __SADD16(*X, *(Y++));
      *(X++) = T;
    }
    intt792_768(fg, tmp1);
    for(X = fg, W = M1, i=256;i>0;--i){
      T = barrett_16x2i(__SADD16(*(W++), *X));
      *(X++) = T;
    }
    for(i=128;i>0;--i){
      T = barrett_16x2i(*X); *(X++) = T;
    }

    basemul_792(tmp1, r1, fh);
    basemul_792(tmp2, s1, gh);
    for(X = tmp1, Y = tmp2, i=396; i>0; --i){
      T = __SADD16(*X, *(Y++));
      *(X++) = T;
    }
    intt792_768(fg+384, tmp1);
    for(X = fg+384, i=256;i>0;--i){
      T = barrett_16x2i(__SADD16(*(W++), *X));
      *(X++) = T;
    }
    for(i=128;i>0;--i){
      T = barrett_16x2i(*X); *(X++) = T;
    }

    minusdelta = jump256divsteps(minusdelta,M2,fg,fg+384);

    ntt792_256x(u2, M2+256);
    ntt792_256x(v2, M2+384);
    ntt792_256(r2, M2+512);
    ntt792_256(s2, M2+640);
    ntt792_512(fh, fg+128);
    ntt792_512(gh, fg+512);

    basemul_792(tmp1, u2, fh);
    basemul_792(tmp2, v2, gh);
    for(X = tmp1, Y = tmp2, i=396; i>0; --i){
      T = __SADD16(*X, *(Y++));
      *(X++) = T;
    }
    intt792_768(M, tmp1);
    for(X = M, W = M2, i=128;i>0;--i){
      T = barrett_16x2i(__SADD16(*(W++), *X));
      *(X++) = T;
    }
    for(i=256;i>0;--i){
      T = barrett_16x2i(*X); *(X++) = T;
    }

    basemul_792(tmp1, r2, fh);
    basemul_792(tmp2, s2, gh);
    for(X = tmp1, Y = tmp2, i=396; i>0; --i){
      T = __SADD16(*X, *(Y++));
      *(X++) = T;
    }
    intt792_768(M+384, tmp1);
    for(X = M+384, i=128;i>0;--i){
      T = barrett_16x2i(__SADD16(*(W++), *X));
      *(X++) = T;
    }
    for(i=256;i>0;--i){
      T = barrett_16x2i(*X); *(X++) = T;
    }

    basemul_792(tmp1, u2, v1);
    basemul_792(tmp2, v2, s1);
    for(X=tmp1, Y=tmp2, i=396;i>0;--i){
        T = __SADD16(*(Y++),*X);
        *(X++) = T;
    }
    intt792_768x(M+768, tmp1);
    for (i=384, X=M+768 ; i>0; i--) {	// u = x u2 u1 + v2 r1
      T = barrett_16x2i(*X); *(X++) = T;
    }

    basemul_792(tmp1, r2, v1);
    basemul_792(tmp2, s2, s1);
    for(X=tmp1, Y=tmp2, i=396;i>0;--i){
        T = __SADD16(*(Y++),*X);
        *(X++) = T;
    }
    intt792_768(M+1152, tmp1);
    for (i=384, X=M+1152 ; i>0; i--) {	// u = x u2 u1 + v2 r1
      T = barrett_16x2i(*X); *(X++) = T;
    }

    return minusdelta;
}