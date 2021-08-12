#include <stdint.h>
#include "cmsis.h"
#include "ntt78.h"
extern void gf_polymul_512x512(int *h, int *f, int *g);
extern int jump512divsteps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_512x512_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_512x512_2x2_x_2x2 (int *M, int *M1, int *M2);
int jump1024divsteps(int minusdelta, int *M, int *f, int *g);

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

void gf_polymul_512x512_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *W;
  int B1024_1[513];
  int * BB1024_1 = (int *)((void *)B1024_1 + 2);
  B1024_1[0] = V[0] = 0;
  gf_polymul_512x512(BB1024_1, M+512, fh); 	// x * u * fh
  gf_polymul_512x512((int*)((void*)V+2), M+768, gh);	// x * v * gh
  for (X=V, Y=B1024_1, W=M, i=256; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  }  
  for (i=256; i>0; i--) {  
    T = barrett_16x2i(__SADD16(*(Y++),*X)); *(X++) = T;
  } 
  gf_polymul_512x512(V+512, M+1024, fh);	// r * fh
  gf_polymul_512x512(BB1024_1, M+1280, gh);	// s * gh
  for (Y=BB1024_1, i=256; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  } 
  for (i=256; i>0; i--) {  
    T = barrett_16x2i(__SADD16(*X, *(Y++))); *(X++) = T;
  } 
}

void gf_polymul_512x512_2x2_x_2x2 (int *M, int *M1, int *M2) {
  int i, T, *X, *Y;
  int B1024_1[513];
  int * BB1024_1 = (int *)((void *)B1024_1 + 2);
  B1024_1[0] = 0;

  gf_polymul_512x512(BB1024_1, M2, M1); 	// x * u2 * u1
  gf_polymul_512x512(M, M2+256, M1+512); 	// v2 * r1
  for (i=512, X=M, Y=B1024_1; i > 0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }

  gf_polymul_512x512(BB1024_1, M2, M1+256); 	// x * u2 * v1
  gf_polymul_512x512(M+512, M2+256, M1+768); 	// v2 * s1
  for (i=512, Y=B1024_1; i > 0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }

  gf_polymul_512x512(BB1024_1, M2+512, M1); 	// x * r2 * u1
  gf_polymul_512x512(M+1024, M2+768, M1+512); 	// s2 * r1
  for (i=512, Y = B1024_1; i > 0; i--) {	// r = x r2 u1 + s2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }

  gf_polymul_512x512(BB1024_1, M2+512, M1+256); 	// x * r2 * v1
  gf_polymul_512x512(M+1536, M2+768, M1+768); 	// s2 * s1
  for (i=512, Y = B1024_1; i > 0; i--) {	// s = x r2 v1 + s2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
}

int jump1024divsteps(int minusdelta, int *M, int *f, int *g){
  int M1[1536], M2[1536], fg[1024];
  minusdelta = jump512divsteps(minusdelta, M1, f, g);
  gf_polymul_512x512_2x2_x2p2 (fg, M1, f+256, g+256);
  minusdelta = jump512divsteps(minusdelta, M2, fg, fg+512);
  gf_polymul_512x512_2x2_x2p2 (M, M2, fg+256, fg+768);
  gf_polymul_512x512_2x2_x_2x2(M+1024, M1+512, M2+512);
  return(minusdelta);
}

// int jump1024divsteps(int minusdelta, int *M, int *f, int *g){
//   int M1[1536], M2[1536], fg[1024];
//   int u1[624], v1[624], r1[624], s1[624], fh[624], gh[624], tmp[624], tmp2[624];
//   int u2[624], v2[624], r2[624], s2[624];
//   fg[0] = M[0] = 0;
//   int i, T, *X, *Y, *W;

//   minusdelta = jump512divsteps(minusdelta, M1, f, g);

//   ntt1248_512x(u1, M1+512);
//   ntt1248_512x(v1, M1+768);
//   ntt1248_512(r1, M1+1024);
//   ntt1248_512(s1, M1+1280);
//   ntt1248_512(fh, f+256);
//   ntt1248_512(gh, g+256);

//   basemul_1248(tmp, u1, fh);
//   basemul_1248(tmp2, v1, gh);
//   for(X=tmp, Y=tmp2, i=624;i>0;--i){
//       T = barrett_16x2i(__SADD16(*(Y++),*X));
//       // T = __SADD16(*(Y++),*X);
//       *(X++) = T;
//   }
//   intt1248_1024(fg, tmp);
//   for (X=fg, W=M1, i=256; i>0; i--) {// x(u fh+v gh)+f1
//     T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
//   }
//   for(i=256;i>0;--i){
//     T = barrett_16x2i(*X); *(X++) = T;
//   }

//   basemul_1248(tmp, r1, fh);
//   basemul_1248(tmp2, s1, gh);
//   for(X=tmp, Y=tmp2, i=624;i>0;--i){
//       T = barrett_16x2i(__SADD16(*(Y++),*X));
//       // T = __SADD16(*(Y++),*X);
//       *(X++) = T;
//   }
//   intt1248_1024(fg+512, tmp);
//   for (X = fg+512, i=256; i>0; i--) {	// (r fh+s gh) + g1
//     T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
//   } 
//   for(i=256;i>0;--i){
//     T = barrett_16x2i(*X); *(X++) = T;
//   }

//   minusdelta = jump512divsteps(minusdelta, M2, fg, fg+512);

//   ntt1248_512x(u2, M2+512);
//   ntt1248_512x(v2, M2+768);
//   ntt1248_512(r2, M2+1024);
//   ntt1248_512(s2, M2+1280);
//   ntt1248_512(fh, fg+256);
//   ntt1248_512(gh, fg+768);

//   basemul_1248(tmp, u2, fh);
//   basemul_1248(tmp2, v2, gh);
//   for(X=tmp, Y=tmp2, i=624;i>0;--i){
//       T = barrett_16x2i(__SADD16(*(Y++),*X));
//       // T = __SADD16(*(Y++),*X);
//       *(X++) = T;
//   }
//   intt1248_1024(M, tmp);
//   for (X=M, W=M2, i=256; i>0; i--) {// x(u fh+v gh)+f1
//     T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
//   }  
//   for(i=256;i>0;--i){
//     T = barrett_16x2i(*X); *(X++) = T;
//   }

//   basemul_1248(tmp, r2, fh);
//   basemul_1248(tmp2, s2, gh);
//   for(X=tmp, Y=tmp2, i=624;i>0;--i){
//       T = barrett_16x2i(__SADD16(*(Y++),*X));
//       // T = __SADD16(*(Y++),*X);
//       *(X++) = T;
//   }
//   intt1248_1024(M+512, tmp);
//   for (X = M+512, i=256; i>0; i--) {	// x(r fh+s gh) + g1
//     T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
//   } 
//   for(i=256;i>0;--i){
//     T = barrett_16x2i(*X); *(X++) = T;
//   }

//   basemul_1248(tmp, u2, u1);
//   basemul_1248(tmp2, v2, r1);
//   for(X=tmp, Y=tmp2, i=624;i>0;--i){
//       T = barrett_16x2i(__SADD16(*(Y++),*X));
//       *(X++) = T;
//   }
//   intt1248_1024x(M+1024, tmp);
//   for (i=512, X=M+1024 ; i>0; i--) {	// u = x u2 u1 + v2 r1
//     T = barrett_16x2i(*X); *(X++) = T;
//   }

//   basemul_1248(tmp, u2, v1);
//   basemul_1248(tmp2, v2, s1);
//   for(X=tmp, Y=tmp2, i=624;i>0;--i){
//       T = barrett_16x2i(__SADD16(*(Y++),*X));
//       *(X++) = T;
//   }
//   intt1248_1024x(M+1536, tmp);
//   for (i=512, X=M+1536 ; i>0; i--) {
//     T = barrett_16x2i(*X); *(X++) = T;
//   }

//   basemul_1248(tmp, r2, u1);
//   basemul_1248(tmp2, s2, r1);
//   for(X=tmp, Y=tmp2, i=624;i>0;--i){
//       T = barrett_16x2i(__SADD16(*(Y++),*X));
//       *(X++) = T;
//   }
//   intt1248_1024(M+2048, tmp);
//   for (i=512, X=M+2048 ; i>0; i--) {
//     T = barrett_16x2i(*X); *(X++) = T;
//   }

//   basemul_1248(tmp, r2, v1);
//   basemul_1248(tmp2, s2, s1);
//   for(X=tmp, Y=tmp2, i=624;i>0;--i){
//       T = barrett_16x2i(__SADD16(*(Y++),*X));
//       *(X++) = T;
//   }
//   intt1248_1024(M+2560, tmp);
//   for (i=512, X=M+2560 ; i>0; i--) {
//     T = barrett_16x2i(*X); *(X++) = T;
//   }

//   return(minusdelta);
// }