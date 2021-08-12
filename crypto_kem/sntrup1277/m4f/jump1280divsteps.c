#include <stdint.h>
#include "cmsis.h"

extern int jump256divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump1024divsteps(int minusdelta, int *M, int *f, int *g);
extern void gf_polymul_256x256(int *h, int *f, int *g);

void gf_polymul_256x1024(int *h, int *f, int *g);
void gf_polymul_256x1024_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_1024x256_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_256x256_2x2_x2p2_1 (int *V,int *M,int *fh,int *gh);

void gf_polymul_256x1024_2x2_x_2x2_onlyvs (int *M, int *M1, int *M2);
void gf_polymul_256x1024_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2);

int jump1280divsteps_onlyuv(int minusdelta, int *M, int *f, int *g);
int jump1280divsteps_onlyvs(int minusdelta, int *M, int *f, int *g);

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

void gf_polymul_256x1024(int *h, int *f, int *g){
  int i, T, hh[256];
  int *p, *pp;
  gf_polymul_256x256(h, f, g);
  gf_polymul_256x256(h+256, f, g+256);
  gf_polymul_256x256(hh, f, g+128);
  for(i=256, p=hh, pp=h+128;i>0;--i){
    T = barrett_16x2i(__SADD16(*(p++), *pp));
    *(pp++)=T;
  }
  gf_polymul_256x256(hh, f, g+384);
  for(i=128, p=hh, pp=h+384;i>0;--i){
    T = barrett_16x2i(__SADD16(*(p++), *pp));
    *(pp++)=T;
  }
  for(i=128;i>0;--i){
    *(pp++)=*(p++);
  }
}

void gf_polymul_1024x256_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *W;
  int B1280_1[641];
  int * BB1280_1 = (int *)((void *)B1280_1 + 2);
  B1280_1[0] = V[0] = 0;
  gf_polymul_256x1024(BB1280_1, fh, M+1024); 	// x * u * fh
  gf_polymul_256x1024((int*)((void*)V+2), gh, M+1536);	// x * v * gh
  for (X=V, Y=B1280_1, W=M, i=512; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  }  
  for (i=128; i>0; i--) {  
    T = barrett_16x2i(__SADD16(*(Y++),*X)); *(X++) = T;
  } 
  gf_polymul_256x1024(V+640, fh, M+2048);	// r * fh
  gf_polymul_256x1024(BB1280_1, gh, M+2560);	// s * gh
  for (Y=BB1280_1, i=512; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  } 
  for (i=128; i>0; i--) {
    T = barrett_16x2i(__SADD16(*X, *(Y++))); *(X++) = T;
  } 
}

void gf_polymul_256x1024_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *W;
  int B1280_1[641];
  int * BB1280_1 = (int *)((void *)B1280_1 + 2);
  B1280_1[0] = V[0] = 0;
  gf_polymul_256x1024(BB1280_1, M+256, fh); 	// x * u * fh
  gf_polymul_256x1024((int*)((void*)V+2), M+384, gh);	// x * v * gh
  for (X=V, Y=B1280_1, W=M, i=128; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  }  
  for (i=512; i>0; i--) {  
    T = barrett_16x2i(__SADD16(*(Y++),*X)); *(X++) = T;
  } 
  gf_polymul_256x1024(V+640, M+512, fh);	// r * fh
  gf_polymul_256x1024(BB1280_1, M+640, gh);	// s * gh
  for (Y=BB1280_1, i=128; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  } 
  for (i=512; i>0; i--) {
    T = barrett_16x2i(__SADD16(*X, *(Y++))); *(X++) = T;
  } 
}

void gf_polymul_256x256_2x2_x2p2_1 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *W;
  int B1280_1[641];
  int * BB1280_1 = (int *)((void *)B1280_1 + 2);
  B1280_1[0] = V[0] = 0;
  gf_polymul_256x256(BB1280_1, M+1024, fh); 	// x * u * fh
  gf_polymul_256x256((int*)((void*)V+2), M+1536, gh);	// x * v * gh
  for (X=V, Y=B1280_1, W=M, i=128; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  }  
  gf_polymul_256x256(V+128, M+2048, fh);	// r * fh
  gf_polymul_256x256(BB1280_1, M+2560, gh);	// s * gh
  for (Y=BB1280_1, W=M+512, i=128; i>0; i--) {	// (r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X)); *(X++) = T;
  } 
}

void gf_polymul_256x1024_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2) {
  int i, T, *X, *Y;
  int B1280_1[641];
  int * BB1280_1 = (int *)((void *)B1280_1 + 2);
  B1280_1[0] = 0;

  gf_polymul_256x1024(BB1280_1, M2, M1); 	// x * u2 * u1
  gf_polymul_256x1024(M, M2+128, M1+1024); 	// v2 * r1
  for (i=640, X=M, Y=B1280_1; i > 0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }

  gf_polymul_256x1024(BB1280_1, M2, M1+512); 	// x * u2 * v1
  gf_polymul_256x1024(M+640, M2+128, M1+1536); 	// v2 * s1
  for (i=640, Y = B1280_1; i > 0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
}

void gf_polymul_256x1024_2x2_x_2x2_onlyvs (int *M, int *M1, int *M2) {
  int i, T, *X, *Y;
  int B1280_1[641];
  int * BB1280_1 = (int *)((void *)B1280_1 + 2);
  B1280_1[0] = 0;

  gf_polymul_256x1024(BB1280_1, M2, M1+512); 	// x * u2 * v1
  gf_polymul_256x1024(M, M2+128, M1+1536); 	// v2 * s1
  for (i=640, X=M, Y=B1280_1; i > 0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }

  gf_polymul_256x1024(BB1280_1, M2+256, M1+512); 	// x * r2 * v1
  gf_polymul_256x1024(M+640, M2+384, M1+1536); 	// s2 * s1
  for (i=640, Y = B1280_1; i > 0; i--) {	// s = x r2 v1 + s2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++))); *(X++) = T;
  }
}

// M1: f, g, v, s(1280)
int jump1280divsteps_onlyvs(int minusdelta, int *M, int *f, int *g){
  int M1[3072], M2[768], fg[1280];
  minusdelta = jump1024divsteps(minusdelta, M1, f, g);
  gf_polymul_1024x256_2x2_x2p2 (fg, M1, f+512, g+512);
  minusdelta = jump256divsteps(minusdelta, M2, fg, fg+640);
  gf_polymul_256x1024_2x2_x2p2 (M, M2, fg+128, fg+768);
  gf_polymul_256x1024_2x2_x_2x2_onlyvs(M+1280, M1+1024, M2+256);
  return(minusdelta);
}

// M2: f(256), g(256), u(1280), v(1280)
int jump1280divsteps_onlyuv(int minusdelta, int *M, int *f, int *g){
  int M1[3072], M2[768], fg[256];
  minusdelta = jump1024divsteps(minusdelta, M1, f, g);
  gf_polymul_256x256_2x2_x2p2_1 (fg, M1, f+512, g+512);
  minusdelta = jump256divsteps(minusdelta, M2, fg, fg+128);

  for(int i=0;i<256;i++)M[i]=M2[i];
  
  gf_polymul_256x1024_2x2_x_2x2_onlyuv(M+256, M1+1024, M2+256);
  return(minusdelta);
}
