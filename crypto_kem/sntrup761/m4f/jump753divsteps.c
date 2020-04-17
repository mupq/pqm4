#include <stdint.h>
#include "cmsis.h"

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
void gf_polymul_256x512_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2);

extern int jump512divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump128divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump64divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump32divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump16divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump4divsteps_1(int minusdelta, int *M, int *f, int *g);

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

void gf_polymul_256x512_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2){ // M = M2*M1, length M1 : 512*4   M2 : 256*4
  int i, T, *X, *Y;

  //static
  int B753_1[385];
  int * BB753_1 = (int *)((void *)B753_1 + 2);

  B753_1[0] = 0;
  gf_polymul_256x512(BB753_1, M2, M1); // x * u2 * u1 
  gf_polymul_256x512(M, M2+128, M1+512); // v2 * r1
  for (i=384, X=M, Y=B753_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_256x512(BB753_1, M2, M1+256); // x * u2 * v1
  gf_polymul_256x512(M+384, M2+128, M1+768); // v2 * s1
  for (i=384, Y=B753_1; i>0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }
/*
  gf_polymul_256x512(BB753_1, M2+256, M1); // x * r2 * u1
  gf_polymul_256x512(M+768, M2+384, M1+512); // s2 * r1
  for (i=384, Y=B768_1; i>0; i--) { // r = x r2 u1 + s2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_256x512(BB753_1, M2+256, M1+256); // x * r2 * v1
  gf_polymul_256x512(M+1152, M2+384, M1+768); // s2 * s1
  for (i=384, Y=B768_1; i>0; i--) { // s = x r2 v1 + s2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }
  */
}

int jump753divsteps(int minusdelta, int *M, int *f, int *g){
  int i;
  int M1[1536], M2[384], M3[192], M4[96], M5[48], M6[48], fg1[768],fg2[256],fg3[128],fg4[64],fg5[32];
  int h1[64],h2[128],h3[256],h4[512];

  for(i=0;i<48;i++)M6[i]=0;

  minusdelta = jump512divsteps(minusdelta, M1, f, g);
  gf_polymul_512x256_2x2_x2p2(fg1,M1,f+256,g+256); // fg : f1 head , fg+384 : g1 head
  minusdelta = jump128divsteps(minusdelta, M2, fg1, fg1+384);
  gf_polymul_128x128_2x2_x2p2(fg2,M2,fg1+64,fg1+448);
  minusdelta = jump64divsteps(minusdelta, M3, fg2, fg2+128);
  gf_polymul_64x64_2x2_x2p2(fg3,M3,fg2+32,fg2+160);
  minusdelta = jump32divsteps(minusdelta, M4, fg3, fg3+64);
  gf_polymul_32x32_2x2_x2p2(fg4,M4,fg3+16,fg3+80);
  minusdelta = jump16divsteps(minusdelta, M5, fg4, fg4+32);
  gf_polymul_16x16_2x2_x2p2(fg5,M5,fg4+8,fg4+40); //fg 0~15 f, 16~31 g
  minusdelta = jump4divsteps_1(minusdelta, M6, fg5, fg5+16);

  M6[46]=M6[10];
  M6[47]=M6[11];
  M6[38]=M6[8];
  M6[39]=M6[9];
  M6[30]=M6[6];
  M6[31]=M6[7];
  M6[22]=M6[4];
  M6[23]=M6[5];

  gf_polymul_16x16_2x2_x_2x2(h1,M5+16,M6+16);
  gf_polymul_32x32_2x2_x_2x2(h2,M4+32,h1);
  gf_polymul_64x64_2x2_x_2x2(h3,M3+64,h2);
  gf_polymul_128x128_2x2_x_2x2(h4,M2+128,h3);
  gf_polymul_256x512_2x2_x_2x2_onlyuv(M+768,M1+512,h4);

  for(i=0;i<768;i++)M[i]=0;
  M[0]=M6[0];
  M[1]=M6[1];
  M[384]=M6[2];
  M[385]=M6[3];

  return(minusdelta);
}
