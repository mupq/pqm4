#include <stdint.h>
#include "cmsis.h"
#include "ntt287x.h"
extern void gf_polymul_256x256(int *h, int *f, int *g);
extern int jump256divsteps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_256x256_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_256x256_2x2_x_2x2 (int *M, int *M1, int *M2);
int jump512divsteps(int minusdelta, int *M, int *f, int *g);

#define q 5167
#define qR2inv 831230 // round(2^32/q)
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
// int B512_1[257];
// int * BB512_1 = (int *)((void *)B512_1 + 2);

// void gf_polymul_256x256_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
//   int i, T, *X, *Y, *W;

//   B512_1[0] = V[0] = 0;
//   gf_polymul_256x256(BB512_1, M+256, fh); 	// x * u * fh
//   gf_polymul_256x256((int*)((void*)V+2), M+384, gh);	// x * v * gh
//   for (X=V, Y=B512_1, W=M, i=128; i>0; i--) {// x(u fh+v gh)+f1
//     T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
//   }  
//   for (i=128; i>0; i--) {  
//     T = barrett_16x2i(__SADD16(*(Y++),*X)); *(X++) = T;
//   } 
//   gf_polymul_256x256(V+256, M+512, fh);	// r * fh
//   gf_polymul_256x256(BB512_1, M+640, gh);	// s * gh
//   for (Y=BB512_1, i=128; i>0; i--) {	// x(r fh+s gh) + g1
//     T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
//   } 
//   for (i=128; i>0; i--) {  
//     T = barrett_16x2i(__SADD16(*X, *(Y++))); *(X++) = T;
//   } 
// }

// void gf_polymul_256x256_2x2_x_2x2 (int *M, int *M1, int *M2) {
//   int i, T, *X, *Y;

//   B512_1[0] = 0;
//   gf_polymul_256x256(BB512_1, M2, M1); 	// x * u2 * u1
//   gf_polymul_256x256(M, M2+128, M1+256); 	// v2 * r1
//   for (i=256, X=M, Y=B512_1; i>0; i--) {	// u = x u2 u1 + v2 r1
//     T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
//   }
//   gf_polymul_256x256(BB512_1, M2, M1+128); 	// x * u2 * v1
//   gf_polymul_256x256(M+256, M2+128, M1+384); 	// v2 * s1
//   for (i=256, Y=B512_1; i > 0; i--) {	// v = x u2 v1 + v2 s1
//     T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
//   }
//   gf_polymul_256x256(BB512_1, M2+256, M1); 	// x * r2 * u1
//   gf_polymul_256x256(M+512, M2+384, M1+256); 	// s2 * r1
//   for (i=256, Y = B512_1; i > 0; i--) {	// s = x r2 u1 + s2 r1
//     T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
//   }
//   gf_polymul_256x256(BB512_1, M2+256, M1+128); 	// x * r2 * v1
//   gf_polymul_256x256(M+768, M2+384, M1+384); 	// s2 * s1
//   for (i=256, Y = B512_1; i > 0; i--) {	// s = x r2 v1 + s2 s1
//     T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
//   }
// }

// int jump512divsteps(int minusdelta, int *M, int *f, int *g){
//   int M1[768], M2[768], fg[512];
//   minusdelta = jump256divsteps(minusdelta, M1, f, g);
//   gf_polymul_256x256_2x2_x2p2 (fg, M1, f+128, g+128);
//   minusdelta = jump256divsteps(minusdelta, M2, fg, fg+256);
//   gf_polymul_256x256_2x2_x2p2 (M, M2, fg+128, fg+384);
//   gf_polymul_256x256_2x2_x_2x2(M+512, M1+256, M2+256);
//   return(minusdelta);
// }

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