#include <stdint.h>
#include "cmsis.h"
#include "ntt612.h"
extern void gf_polymul_512x256_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void gf_polymul_128x128_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void gf_polymul_64x64_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void gf_polymul_32x32_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
extern void gf_polymul_16x16_2x2_x2p2 (int *V,int *M,int *fh,int *gh);

extern void gf_polymul_16x16_2x2_x_2x2 (int *M, int *M1, int *M2);
extern void gf_polymul_32x32_2x2_x_2x2 (int *M, int *M1, int *M2);
extern void gf_polymul_64x64_2x2_x_2x2 (int *M, int *M1, int *M2);
extern void gf_polymul_128x128_2x2_x_2x2 (int *M, int *M1, int *M2);
//extern void gf_polymul_256x512_2x2_x_2x2 (int *M, int *M1, int *M2);
extern void gf_polymul_256x512 (int *M, int *M1, int *M2);
void gf_polymul_256x512_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2);

extern int jump512divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump128divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump64divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump32divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump16divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump4divsteps_1(int minusdelta, int *M, int *f, int *g);

extern void __gf_polymul_16x16_2x2_x2p2(int*, int*, int*, int*);
extern void __gf_polymul_16x16_2x2_x_2x2(int*, int*, int*);
extern void __gf_polymul_32x32_2x2_x2p2(int*, int*, int*, int*);
extern void __gf_polymul_32x32_2x2_x_2x2(int*, int*, int*);
extern void __gf_polymul_64x64_2x2_x2p2(int*, int*, int*, int*);
extern void __gf_polymul_64x64_2x2_x_2x2(int*, int*, int*);

extern void ntt918_256(int*, int*);
extern void ntt918_256x(int*, int*);
extern void ntt918_512(int*, int*);
extern void ntt918_512x(int*, int*);
extern void basemul_918(int*, int*, int*);
extern void intt918_768(int*, int*);
extern void intt918_768x(int*, int*);
extern void ntt306(int*, int*);
extern void ntt306x(int*, int*);
extern void intt306(int*, int*);
extern void intt306x(int*, int*);
extern void basemul_306(int*, int*, int*);

int jump753divsteps(int minusdelta, int *M, int *f, int *g);

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

// void gf_polymul_256x512_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2){ // M = M2*M1, length M1 : 512*4   M2 : 256*4
//   int i, T, *X, *Y;

//   //static
//   int B753_1[385];
//   int * BB753_1 = (int *)((void *)B753_1 + 2);

//   B753_1[0] = 0;
//   gf_polymul_256x512(BB753_1, M2, M1); // x * u2 * u1 
//   gf_polymul_256x512(M, M2+128, M1+512); // v2 * r1
//   for (i=384, X=M, Y=B753_1; i>0; i--) {	// u = x u2 u1 + v2 r1
//     T = barrett_16x2i(__SADD16(*X,*(Y++)));
//     *(X++) = T;
//   }

//   gf_polymul_256x512(BB753_1, M2, M1+256); // x * u2 * v1
//   gf_polymul_256x512(M+384, M2+128, M1+768); // v2 * s1
//   for (i=384, Y=B753_1; i>0; i--) {	// v = x u2 v1 + v2 s1
//     T = barrett_16x2i(__SADD16(*X,*(Y++)));
//     *(X++) = T;
//   }
// /*
//   gf_polymul_256x512(BB753_1, M2+256, M1); // x * r2 * u1
//   gf_polymul_256x512(M+768, M2+384, M1+512); // s2 * r1
//   for (i=384, Y=B768_2; i>0; i--) { // r = x r2 u1 + s2 r1
//     T = barrett_16x2i(__SADD16(*X,*(Y++)));
//     *(X++) = T;
//   }

//   gf_polymul_256x512(BB753_1, M2+256, M1+256); // x * r2 * v1
//   gf_polymul_256x512(M+1152, M2+384, M1+768); // s2 * s1
//   for (i=384, Y=B768_2; i>0; i--) { // s = x r2 v1 + s2 s1
//     T = barrett_16x2i(__SADD16(*X,*(Y++)));
//     *(X++) = T;
//   }
//   */
// }

// int jump753divsteps(int minusdelta, int *M, int *f, int *g){
//   int i;
//   int M1[1536], M2[384], M3[192], M4[96], M5[48], M6[48], fg1[768],fg2[256];//,fg3[128]={0},fg4[64]={0},fg5[32]={0};
//   //int h1[64]={0},h2[128]={0},h3[256]={0},h4[512]={0};

//   for(i=0;i<48;i++)M6[i]=0;

//   minusdelta = jump512divsteps(minusdelta, M1, f, g);
//   gf_polymul_512x256_2x2_x2p2(fg1,M1,f+256,g+256); // fg : f1 head , fg+384 : g1 head
//   minusdelta = jump128divsteps(minusdelta, M2, fg1, fg1+384);
//   gf_polymul_128x128_2x2_x2p2(fg2,M2,fg1+64,fg1+448);
//   minusdelta = jump64divsteps(minusdelta, M3, fg2, fg2+128);
//   gf_polymul_64x64_2x2_x2p2(fg1,M3,fg2+32,fg2+160);
//   minusdelta = jump32divsteps(minusdelta, M4, fg1, fg1+64);
//   gf_polymul_32x32_2x2_x2p2(fg2,M4,fg1+16,fg1+80);
//   minusdelta = jump16divsteps(minusdelta, M5, fg2, fg2+32);
//   gf_polymul_16x16_2x2_x2p2(fg1,M5,fg2+8,fg2+40); //fg 0~15 f, 16~31 g
//   minusdelta = jump4divsteps_1(minusdelta, M6, fg1, fg1+16);

//   // M6[46]=M6[10];
//   // M6[47]=M6[11];
//   // M6[38]=M6[8];
//   // M6[39]=M6[9];
//   // M6[30]=M6[6];
//   // M6[31]=M6[7];
//   // M6[22]=M6[4];
//   // M6[23]=M6[5];
  
//   M6[40]=M6[10];
//   M6[41]=M6[11];
//   M6[32]=M6[8];
//   M6[33]=M6[9];
//   M6[24]=M6[6];
//   M6[25]=M6[7];
//   M6[16]=M6[4];
//   M6[17]=M6[5];

//   gf_polymul_16x16_2x2_x_2x2(fg2,M5+16,M6+16);
//   gf_polymul_32x32_2x2_x_2x2(fg2+64,M4+32,fg2);
//   gf_polymul_64x64_2x2_x_2x2(fg1,M3+64,fg2+64);
//   gf_polymul_128x128_2x2_x_2x2(fg1+256,M2+128,fg1);
//   gf_polymul_256x512_2x2_x_2x2_onlyuv(M+768,M1+512,fg1+256);

//   for(i=0;i<768;i++)M[i]=0;
//   M[0]=M6[0];
//   M[1]=M6[1];
//   M[384]=M6[2];
//   M[385]=M6[3];

//   return(minusdelta);
// }


int jump753divsteps(int minusdelta, int *M, int *f, int *g){
  int i;
  int M1[1536], M2[384], M3[192], M4[96], M5[48], M6[48], fg1[768],fg2[256];

  for(i=0;i<48;i++)M6[i]=0;
  int T, *X, *Y, *W;
  int u1[459], v1[459], r1[459], s1[459], fh[459], gh[459], tmp1[459], tmp2[459];
  minusdelta = jump512divsteps(minusdelta, M1, f, g);

  ntt918_512x(u1, M1+512);
  ntt918_512x(v1, M1+768);
  ntt918_512(r1, M1+1024);
  ntt918_512(s1, M1+1280);
  ntt918_256(fh, f+256);
  ntt918_256(gh, g+256);

  basemul_918(tmp1, u1, fh);
  basemul_918(tmp2, v1, gh);
  for(X = tmp1, Y = tmp2, i=459; i>0; --i){
    T = __SADD16(*X, *(Y++));
    *(X++) = T;
  }
  intt918_768(fg1, tmp1);
  for(X = fg1, W = M1, i=256;i>0;--i){
    T = barrett_16x2i(__SADD16(*(W++), *X));
    *(X++) = T;
  }
  for(i=128;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_918(tmp1, r1, fh);
  basemul_918(tmp2, s1, gh);
  for(X = tmp1, Y = tmp2, i=459; i>0; --i){
    T = __SADD16(*X, *(Y++));
    *(X++) = T;
  }
  intt918_768(fg1+384, tmp1);
  for(X = fg1+384, i=256;i>0;--i){
    T = barrett_16x2i(__SADD16(*(W++), *X));
    *(X++) = T;
  }
  for(i=128;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  minusdelta = jump128divsteps(minusdelta, M2, fg1, fg1+384);
  // gf_polymul_128x128_2x2_x2p2(fg2,M2,fg1+64,fg1+448);
  int u3[153], v3[153], r3[153], s3[153];
  ntt306x(u3, M2+128);
  ntt306x(v3, M2+192);
  ntt306(r3, M2+256);
  ntt306(s3, M2+320);
  ntt306(fh, fg1+64);
  ntt306(gh, fg1+448);

  basemul_306(tmp1, u3, fh);
  basemul_306(tmp2, v3, gh);
  for(X=tmp1, Y=tmp2, i=153;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306(fg2, tmp1);
  for (X=fg2, W=M2, i=64; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  }
  for(i=64;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_306(tmp1, r3, fh);
  basemul_306(tmp2, s3, gh);
  for(X=tmp1, Y=tmp2, i=153;i>0;--i){
      // T = barrett_16x2i(__SADD16(*(Y++),*X));
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306(fg2+128, tmp1);
  for (X = fg2+128, i=64; i>0; i--) {	// (r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(*(W++),*X)); *(X++) = T;
  } 
  for(i=64;i>0;--i){
    T = barrett_16x2i(*X); *(X++) = T;
  }

  minusdelta = jump64divsteps(minusdelta, M3, fg2, fg2+128);
  gf_polymul_64x64_2x2_x2p2(fg1,M3,fg2+32,fg2+160);
  minusdelta = jump32divsteps(minusdelta, M4, fg1, fg1+64);
  gf_polymul_32x32_2x2_x2p2(fg2,M4,fg1+16,fg1+80);
  minusdelta = jump16divsteps(minusdelta, M5, fg2, fg2+32);
  gf_polymul_16x16_2x2_x2p2(fg1,M5,fg2+8,fg2+40); //fg 0~15 f, 16~31 g
  minusdelta = jump4divsteps_1(minusdelta, M6, fg1, fg1+16);

  // M6[46]=M6[10];
  // M6[47]=M6[11];
  // M6[38]=M6[8];
  // M6[39]=M6[9];
  // M6[30]=M6[6];
  // M6[31]=M6[7];
  // M6[22]=M6[4];
  // M6[23]=M6[5];
  
  M6[40]=M6[10];
  M6[41]=M6[11];
  M6[32]=M6[8];
  M6[33]=M6[9];
  M6[24]=M6[6];
  M6[25]=M6[7];
  M6[16]=M6[4];
  M6[17]=M6[5];

  gf_polymul_16x16_2x2_x_2x2(fg2,M5+16,M6+16);
  gf_polymul_32x32_2x2_x_2x2(fg2+64,M4+32,fg2);
  gf_polymul_64x64_2x2_x_2x2(fg1,M3+64,fg2+64);

  // gf_polymul_128x128_2x2_x_2x2(fg1+256,M2+128,fg1);
  int u4[153], v4[153];//, r4[153], s4[153];
  ntt306x(u4, fg1);
  ntt306x(v4, fg1+64);
  // ntt306(r4, fg1+128);
  // ntt306(s4, fg1+192);
  basemul_306(tmp1, u4, u3);
  basemul_306(tmp2, v4, r3);
  for(X=tmp1, Y=tmp2, i=153;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306x(fg1+256, tmp1);
  for (i=128, X=fg1+256 ; i>0; i--) {
    T = barrett_16x2i(*X); *(X++) = T;
  }
  basemul_306(tmp1, u4, v3);
  basemul_306(tmp2, v4, s3);
  for(X=tmp1, Y=tmp2, i=153;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt306x(fg1+384, tmp1);
  for (i=128, X=fg1+384 ; i>0; i--) {
    T = barrett_16x2i(*X); *(X++) = T;
  }
  // basemul_306(tmp1, r4, u3);
  // basemul_306(tmp2, s4, r3);
  // for(X=tmp1, Y=tmp2, i=153;i>0;--i){
  //     T = __SADD16(*(Y++),*X);
  //     *(X++) = T;
  // }
  // intt306(fg1+512, tmp1);
  // for (i=128, X=fg1+512 ; i>0; i--) {
  //   T = barrett_16x2i(*X); *(X++) = T;
  // }
  // basemul_306(tmp1, r4, v3);
  // basemul_306(tmp2, s4, s3);
  // for(X=tmp1, Y=tmp2, i=153;i>0;--i){
  //     T = __SADD16(*(Y++),*X);
  //     *(X++) = T;
  // }
  // intt306(fg1+640, tmp1);
  // for (i=128, X=fg1+640 ; i>0; i--) {
  //   T = barrett_16x2i(*X); *(X++) = T;
  // }

  int u2[459], v2[459];

  ntt918_256x(u2, fg1+256);
  ntt918_256x(v2, fg1+384);

  basemul_918(tmp1, u2, u1);
  basemul_918(tmp2, v2, r1);
  for(X=tmp1, Y=tmp2, i=459;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt918_768x(M+768, tmp1);
  for (i=384, X=M+768 ; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_918(tmp1, u2, v1);
  basemul_918(tmp2, v2, s1);
  for(X=tmp1, Y=tmp2, i=459;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt918_768x(M+1152, tmp1);
  for (i=384, X=M+1152 ; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(*X); *(X++) = T;
  }

  for(i=0;i<768;i++)M[i]=0;
  M[0]=M6[0];
  M[1]=M6[1];
  M[384]=M6[2];
  M[385]=M6[3];

  return(minusdelta);
}