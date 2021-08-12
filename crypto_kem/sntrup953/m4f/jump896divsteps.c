#include <stdint.h>
#include "cmsis.h"
#include "ntt42.h"

extern void gf_polymul_128x128(int *h, int *f, int *g);
extern void gf_polymul_384x384(int *h, int *f, int *g);
extern int jump512divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump256divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump128divsteps(int minusdelta, int *M, int *f, int *g);

void gf_polymul_128x256(int *h, int *f, int *g);
void gf_polymul_512x512_1(int *h, int *f, int *g);
void gf_polymul_128x128_2x2_x2p2_1 (int *V,int *M,int *fh,int *gh);
void gf_polymul_384x384_2x2_x2p2_1 (int *V,int *M,int *fh,int *gh);
void gf_polymul_128x256_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2);
void gf_polymul_384x512_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2);
int jump896divsteps(int minusdelta, int *M, int *f, int *g);

#define q 6343
#define qR2inv 677119 // round(2^32/q)
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

void gf_polymul_128x256(int *h, int *f, int *g){
  int i, T, hh[128];
  int *p, *pp;
  gf_polymul_128x128(h, f, g);
  gf_polymul_128x128(hh, f, g+64);
  for(i=64, p=hh, pp=h+64; i>0; --i){
    T = barrett_16x2i(__SADD16(*p++, *pp));
    *(pp++) = T;
  }
  for(i=64; i>0; --i){
    *(pp++) = *(p++);
  }
}

void gf_polymul_512x512_1(int *h, int *f, int *g){
  int fpad[588], gpad[588];
  ntt1176_512(fpad, f);
  ntt1176_512(gpad, g);
  basemul_1176(fpad, fpad, gpad);
  intt1176_1024(h, fpad);
}

void gf_polymul_384x384_2x2_x2p2_1 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;
  int B753_1[385], B753_2[385];
  int * BB753_1 = (int *)((void *)B753_1 + 2);
  int * BB753_2 = (int *)((void *)B753_2 + 2);

  B753_1[0] = B753_2[0] = 0;
  gf_polymul_384x384(BB753_1, fh, M+512); 	// x * u * fh
  gf_polymul_384x384(BB753_2, gh, M+768);	// x * v * gh
  for (X=V, Y=B753_1, Z=B753_2, W=M, i=192; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  }

  gf_polymul_384x384(B753_1, fh, M+1024);	// r * fh
  gf_polymul_384x384(B753_2, gh, M+1280);	// s * gh
  for (Y=B753_1, Z=B753_2, W=M+256, i=192; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  } 
}

void gf_polymul_128x128_2x2_x2p2_1 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;
  int B753_1[129], B753_2[129];
  int * BB753_1 = (int *)((void *)B753_1 + 2);
  int * BB753_2 = (int *)((void *)B753_2 + 2);

  B753_1[0] = B753_2[0] = 0;
  gf_polymul_128x128(BB753_1, fh, M+256); 	// x * u * fh
  gf_polymul_128x128(BB753_2, gh, M+384);	// x * v * gh
  for (X=V, Y=B753_1, Z=B753_2, W=M, i=64; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  }

  gf_polymul_128x128(B753_1, fh, M+512);	// r * fh
  gf_polymul_128x128(B753_2, gh, M+640);	// s * gh
  for (Y=B753_1, Z=B753_2, W=M+128, i=64; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  } 
}

void gf_polymul_128x256_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2){ // M = M2*M1, length M1 : 512*4   M2 : 32*4
  int i, T, *X, *Y;
  int B753_1[193];
  int * BB753_1 = (int *)((void *)B753_1 + 2);

  B753_1[0] = 0;
  gf_polymul_128x256(BB753_1, M2, M1); // x * u2 * u1 
  gf_polymul_128x256(M, M2+64, M1+256); // v2 * r1
  for (i=192, X=M, Y=B753_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_128x256(BB753_1, M2, M1+128); // x * u2 * v1
  gf_polymul_128x256(M+256, M2+64, M1+384); // v2 * s1
  for (i=192, X=M+256, Y=B753_1; i>0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }
}

/* polymul 512x512 is faster than polymul 384x512.*/
void gf_polymul_384x512_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2){ // M = M2*M1, length M1 : 512*4
  int i, T, *X, *Y, *Z;

  int B753_1[513], B753[512];
  int * BB753_1 = (int *)((void *)B753_1 + 2);

  B753_1[0] = 0;
  gf_polymul_512x512_1(BB753_1, M2, M1); // x * u2 * u1 
  gf_polymul_512x512_1(B753, M2+256, M1+512); // v2 * r1
  for (i=448, X=M, Y=B753_1, Z=B753; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(__SADD16((*Z++),*(Y++)));
    *(X++) = T;
  }

  gf_polymul_512x512_1(BB753_1, M2, M1+256); // x * u2 * v1
  gf_polymul_512x512_1(B753, M2+256, M1+768); // v2 * s1
  for (i=448, X=M+480, Y=B753_1, Z=B753; i>0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16((*Z++),*(Y++)));
    *(X++) = T;
  }
}

// M: f(128), g(128), u(960), v(960)
int jump896divsteps(int minusdelta, int *M, int *f, int *g){
  int i;
  int M1[1536], M2[768], M3[384], fg1[384], fg2[128], tmp[512]={0};

  minusdelta = jump512divsteps(minusdelta, M1, f, g);
  gf_polymul_384x384_2x2_x2p2_1(fg1,M1,f+256,g+256); // fg : f1 head , fg+192 : g1 head
  minusdelta = jump256divsteps(minusdelta, M2, fg1, fg1+192);
  gf_polymul_128x128_2x2_x2p2_1(fg2,M2,fg1+128,fg1+320); // fg : f1 head , fg+64 : g1 head
  minusdelta = jump128divsteps(minusdelta, M3, fg2, fg2+64);
  
  for(i=0;i<128;i++)M[i]=M3[i];

  gf_polymul_128x256_2x2_x_2x2_onlyuv(tmp,M2+256,M3+128);
  gf_polymul_384x512_2x2_x_2x2_onlyuv(M+128,M1+512,tmp);

  return(minusdelta);
}
