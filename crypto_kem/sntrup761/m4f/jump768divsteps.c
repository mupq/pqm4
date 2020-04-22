#include <stdint.h>
#include "cmsis.h"

extern void gf_polymul_256x256(void *h, void *f, void *g);
extern void gf_polymul_256x512(void *h, void *f, void *g); // length f : 256 , g : 512
extern int jump256divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump512divsteps(int minusdelta, int *M, int *f, int *g);
void gf_polymul_512x256_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_256x512_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_256x512_2x2_x_2x2 (int *M, int *M1, int *M2); // M = M2*M1, length M1 : 512*4   M2 : 256*4 (u,v,r,s)
int jump768divsteps(int minusdelta, int *M, int *f, int *g);

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

//static
int B768_1[385], B768_2[385];
int * BB768_1 = (int *)((void *)B768_1 + 2);
int * BB768_2 = (int *)((void *)B768_2 + 2);

void gf_polymul_512x256_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;

  B768_1[0] = B768_2[0] = 0;

  gf_polymul_256x512(BB768_1, fh, M+512); // x * u * fh
  gf_polymul_256x512(BB768_2, gh, M+768); // x * v * gh
  for(X=V, Y=B768_1, Z=B768_2, W=M, i=256; i>0; i--){ // x(u fh+v gh)+f1, length ,u*fh & v*gh : 768, f1 : 512
    *(X++) = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++)));
  }
  for (i=128; i>0; i--) {  
    *(X++) = barrett_16x2i(__SADD16(*(Y++),*(Z++)));
  }

  gf_polymul_256x512(V+384, fh, M+1024); // r * fh
  gf_polymul_256x512(BB768_1, gh, M+1280); // s * gh

  for (Y=BB768_1, i=256; i>0; i--) {	// x(r fh+s gh) + g1, length ,r*fh & s*gh : 768, g1 : 512
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X));
    *(X++) = T;
  }
  for (i=128; i>0; i--) {  
    T = barrett_16x2i(__SADD16(*X, *(Y++)));
    *(X++) = T;
  }
}

void gf_polymul_256x512_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;

  B768_1[0] = B768_2[0] = 0;
  gf_polymul_256x512(BB768_1, M+256, fh); // x * u * fh
  gf_polymul_256x512(BB768_2, M+384, gh);	// x * v * gh
  for (X=V, Y=B768_1, Z=B768_2, W=M, i=128; i>0; i--) {// x(u fh+v gh)+f1
    *(X++) = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++)));
  }  
  for (i=256; i>0; i--) {  
    *(X++) = barrett_16x2i(__SADD16(*(Y++),(*Z++)));
  } 


  gf_polymul_256x512(V+384, M+512, fh);	// r * fh
  gf_polymul_256x512(BB768_1, M+640, gh);	// s * gh
  for (Y=BB768_1, i=128; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*X));
    *(X++) = T;
  } 
  for (i=256; i>0; i--) {  
    T = barrett_16x2i(__SADD16(*X, *(Y++)));
    *(X++) = T;
  } 
}

void gf_polymul_256x512_2x2_x_2x2 (int *M, int *M1, int *M2){ // M = M2*M1, length M1 : 512*4   M2 : 256*4
  int i, T, *X, *Y;

  B768_1[0] = B768_2[0] = 0;

  gf_polymul_256x512(BB768_1, M2, M1); // x * u2 * u1 
  gf_polymul_256x512(M, M2+128, M1+512); // v2 * r1
  for (i=384, X=M, Y=B768_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_256x512(BB768_1, M2, M1+256); // x * u2 * v1
  gf_polymul_256x512(M+384, M2+128, M1+768); // v2 * s1
  for (i=384, Y=B768_1; i>0; i--) {	// v = x u2 v1 + v2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_256x512(BB768_1, M2+256, M1); // x * r2 * u1
  gf_polymul_256x512(M+768, M2+384, M1+512); // s2 * r1
  for (i=384, Y=B768_1; i>0; i--) { // r = x r2 u1 + s2 r1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_256x512(BB768_1, M2+256, M1+256); // x * r2 * v1
  gf_polymul_256x512(M+1152, M2+384, M1+768); // s2 * s1
  for (i=384, Y=B768_1; i>0; i--) { // s = x r2 v1 + s2 s1
    T = barrett_16x2i(__SADD16(*X,*(Y++)));
    *(X++) = T;
  }
}

int jump768divsteps(int minusdelta, int *M, int *f, int *g){
    int M1[1536], M2[768], fg[768];

    minusdelta = jump512divsteps(minusdelta,M1,f,g);

    gf_polymul_512x256_2x2_x2p2(fg,M1,f+256,g+256);

    minusdelta = jump256divsteps(minusdelta,M2,fg,fg+384);

    gf_polymul_256x512_2x2_x2p2(M,M2,fg+128,fg+512);

    gf_polymul_256x512_2x2_x_2x2(M+768,M1+512,M2+256);

    return(minusdelta);
}
