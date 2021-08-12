#include <stdint.h>
#include "cmsis.h"

extern void gf_polymul_64x64(int *h, int *f, int *g);
extern void gf_polymul_192x192(int *h, int *f, int *g);
extern void gf_polymul_256x256(int *h, int *f, int *g);
extern int jump512divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump128divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump64divsteps(int minusdelta, int *M, int *f, int *g);

void gf_polymul_64x128(int *h, int *f, int *g);
void gf_polymul_192x512(int *h, int *f, int *g);

void gf_polymul_64x64_2x2_x2p2_1 (int *V,int *M,int *fh,int *gh);
void gf_polymul_192x192_2x2_x2p2_1 (int *V,int *M,int *fh,int *gh);
void gf_polymul_64x128_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2);
void gf_polymul_192x512_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2);

int jump704divsteps(int minusdelta, int *M, int *f, int *g);

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

void gf_polymul_64x128(int *h, int *f, int *g){
  int i, T, hh[64];
  int *p, *pp;
  gf_polymul_64x64(h, f, g);
  gf_polymul_64x64(hh, f, g+32);
  for(i=32, p=hh, pp=h+32; i>0; --i){
    T = barrett_16x2i(__SADD16(*p++, *pp));
    *(pp++) = T;
  }
  for(i=32; i>0; --i){
    *(pp++) = *(p++);
  }
}

void gf_polymul_192x512(int *h, int *f, int *g){
  int i, T, fpad[128]={0}, hh[256];
  int *p, *pp;
  for(i=0;i<96;++i)fpad[i]=f[i];
  gf_polymul_256x256(h, fpad, g);
  gf_polymul_256x256(hh, fpad, g+128);
  for(i=128, p=hh, pp=h+128; i>0; --i){
    T = barrett_16x2i(__SADD16(*p++, *pp));
    *(pp++) = T;
  }
  for(i=96; i>0; --i){
    *(pp++) = *(p++);
  }
}

void gf_polymul_192x192_2x2_x2p2_1 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;
  int B753_1[193], B753_2[193];
  int * BB753_1 = (int *)((void *)B753_1 + 2);
  int * BB753_2 = (int *)((void *)B753_2 + 2);

  B753_1[0] = B753_2[0] = 0;
  gf_polymul_192x192(BB753_1, fh, M+512); 	// x * u * fh
  gf_polymul_192x192(BB753_2, gh, M+768);	// x * v * gh
  for (X=V, Y=B753_1, Z=B753_2, W=M, i=96; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  }

  gf_polymul_192x192(B753_1, fh, M+1024);	// r * fh
  gf_polymul_192x192(B753_2, gh, M+1280);	// s * gh
  for (Y=B753_1, Z=B753_2, W=M+256, i=96; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  } 
}

void gf_polymul_64x64_2x2_x2p2_1 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;
  int B753_1[65], B753_2[65];
  int * BB753_1 = (int *)((void *)B753_1 + 2);
  int * BB753_2 = (int *)((void *)B753_2 + 2);

  B753_1[0] = B753_2[0] = 0;
  gf_polymul_64x64(BB753_1, fh, M+128); 	// x * u * fh
  gf_polymul_64x64(BB753_2, gh, M+192);	// x * v * gh
  for (X=V, Y=B753_1, Z=B753_2, W=M, i=32; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  }

  gf_polymul_64x64(B753_1, fh, M+256);	// r * fh
  gf_polymul_64x64(B753_2, gh, M+320);	// s * gh
  for (Y=B753_1, Z=B753_2, W=M+64, i=32; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  } 
}

void gf_polymul_64x128_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2){ // M = M2*M1, length M1 : 512*4   M2 : 32*4
  int i, T, *X, *Y;
  int B753_1[97];
  int * BB753_1 = (int *)((void *)B753_1 + 2);

  B753_1[0] = 0;
  gf_polymul_64x128(BB753_1, M2, M1); // x * u2 * u1 
  gf_polymul_64x128(M, M2+32, M1+128); // v2 * r1
  for (i=96, X=M, Y=B753_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_64x128(BB753_1, M2, M1+64); // x * u2 * v1
  gf_polymul_64x128(M+96, M2+32, M1+192); // v2 * s1
  for (i=96, Y=B753_1; i>0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }
}

void gf_polymul_192x512_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2){ // M = M2*M1, length M1 : 512*4   M2 : 32*4
  int i, T, *X, *Y;
  int B753_1[353];
  int * BB753_1 = (int *)((void *)B753_1 + 2);

  B753_1[0] = 0;
  gf_polymul_192x512(BB753_1, M2, M1); // x * u2 * u1 
  gf_polymul_192x512(M, M2+96, M1+512); // v2 * r1
  for (i=352, X=M, Y=B753_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_192x512(BB753_1, M2, M1+256); // x * u2 * v1
  gf_polymul_192x512(M+429, M2+96, M1+768); // v2 * s1
  for (i=352, X=M+429, Y=B753_1; i>0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }
}

// M: f(64), g(64), u(858), v(858)
int jump704divsteps(int minusdelta, int *M, int *f, int *g){
  int i;
  int M1[1536], M2[384], M3[192], fg1[192], fg2[64];
  minusdelta = jump512divsteps(minusdelta, M1, f, g);
  gf_polymul_192x192_2x2_x2p2_1(fg1,M1,f+256,g+256); // fg : f1 head , fg+96 : g1 head
  minusdelta = jump128divsteps(minusdelta, M2, fg1, fg1+96);
  gf_polymul_64x64_2x2_x2p2_1(fg2,M2,fg1+64,fg1+160); // fg : f1 head , fg+32 : g1 head
  minusdelta = jump64divsteps(minusdelta, M3, fg2, fg2+32);
  
  for(i=0;i<64;i++)M[i]=M3[i];

  gf_polymul_64x128_2x2_x_2x2_onlyuv(fg1,M2+128,M3+64);
  gf_polymul_192x512_2x2_x_2x2_onlyuv(M+64,M1+512,fg1);

  return(minusdelta);
}
