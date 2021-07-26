#include <stdint.h>
#include "cmsis.h"
#include <stdio.h>
#include "ntt132x.h"
void gf_polymul_128x128(int *h, int *f, int *g);
extern int jump128divsteps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_128x128_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_128x128_2x2_x_2x2 (int *M, int *M1, int *M2);
int jump256divsteps(int minusdelta, int *M, int *f, int *g);

#define q 4621
#define qR2inv 929445 // round(2^32/q)
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
// int B256_1[129];
// int * BB256_1 = (int *)((void *)B256_1 + 2);

// void gf_polymul_128x128(int *h, int *f, int *g){
//     int16_t *ptr = (int16_t *)h;
//     for (int i = 0; i < 256; i++) *ptr++ = 0;
    
//     for (int i = 0; i < 128; i++)
//     {
//         int16_t *result = (int16_t *)h + i;
//         int16_t *f_i = (int16_t *)f + i;
//         for (int j = 0; j < 128; j++)
//         {
//             int16_t *g_i = (int16_t *)g + j;
//             int new_val = (*f_i * *g_i) + *(result);
//             *(result++) = (int16_t)(new_val % q);
//         }
//     }
// }

// void gf_polymul_128x128_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
//   int i, T, *X, *Y, *W;

//   B256_1[0] = V[0] = 0;
//   gf_polymul_128x128(BB256_1, M+128, fh); 	// x * u * fh
//   gf_polymul_128x128((int*)((void*)V+2), M+192, gh);	// x * v * gh
//   for (X=V, Y=B256_1, W=M, i=64; i>0; i--) {// x(u fh+v gh)+f1
//     //V[i] = barrett_16x2i(__SADD16(__SADD16(M[i],B256_1[i]),B256_2[i]));
//     T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
//   }  
//   for (i=64; i>0; i--) {  
//     //V[i+64] = barrett_16x2i(__SADD16(B64_1[i+256],B64_2[i+256]));
//     T = barrett_16x2i(__SADD16(*(Y++),*X)); *(X++) = T;
//   } 
//   gf_polymul_128x128(V+128, M+256, fh);	// r * fh
//   gf_polymul_128x128(BB256_1, M+320, gh);	// s * gh
//   for (Y=BB256_1, i=64; i>0; i--) {	// x(r fh+s gh) + g1
//     //V[i+128] = barrett_16x2i(__SADD16(__SADD16((BB256_1[i],V[i+128])),M[i+64]);
//     T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
//   } 
//   for (i=64; i>0; i--) {  
//     //V[i+192] = barrett_16x2i(__SADD16(BB256_1[i+64],V[i+192]));
//     T = barrett_16x2i(__SADD16(*X, *(Y++))); *(X++) = T;
//   } 
// }

// void gf_polymul_128x128_2x2_x_2x2 (int *M, int *M1, int *M2) {
//   int i, T, *X, *Y;

//   B256_1[0] = 0;
//   gf_polymul_128x128(BB256_1, M2, M1); 	// x * u2 * u1
//   gf_polymul_128x128(M, M2+64, M1+128); 	// v2 * r1
//   for (i=128, X=M, Y=B256_1; i>0; i--) {	// u = x u2 u1 + v2 r1
//     //M[i] =  barrett_16x2i(__SADD16(M[i],B256_1[i]));
//     T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
//   }
//   gf_polymul_128x128(BB256_1, M2, M1+64); 	// x * u2 * v1
//   gf_polymul_128x128(M+128, M2+64, M1+192); 	// v2 * s1
//   for (i=128, Y=B256_1; i > 0; i--) {	// v = x u2 v1 + v2 s1
//     //M[128+i] =  barrett_16x2i(__SADD16(M[128+i],B256_1[i]));
//     T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
//   }
//   gf_polymul_128x128(BB256_1, M2+128, M1); 	// x * r2 * u1
//   gf_polymul_128x128(M+256, M2+192, M1+128); 	// s2 * r1
//   for (i=128, Y = B256_1; i > 0; i--) {	// s = x r2 u1 + s2 r1
//     //M[256+i] =  barrett_16x2i(__SADD16(M[256+i],B256_1[i]));
//     T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
//   }
//   gf_polymul_128x128(BB256_1, M2+128, M1+64); 	// x * r2 * v1
//   gf_polymul_128x128(M+384, M2+192, M1+192); 	// s2 * s1
//   for (i=128, Y = B256_1; i > 0; i--) {	// s = x r2 v1 + s2 s1
//     //M[384+i] =  barrett_16x2i(__SADD16(M[384+i],B256_1[i]));
//     T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
//   }
// }

// int jump256divsteps(int minusdelta, int *M, int *f, int *g){
// int M1[768], M2[768], fg[256];
//   minusdelta = jump128divsteps(minusdelta, M1, f, g);

//   gf_polymul_128x128_2x2_x2p2 (fg, M1, f+64, g+64);

//   minusdelta = jump128divsteps(minusdelta, M2, fg, fg+128);

//   gf_polymul_128x128_2x2_x2p2 (M, M2, fg+64, fg+192);
//   gf_polymul_128x128_2x2_x_2x2(M+256, M1+128, M2+128);
//   return(minusdelta);
// }

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