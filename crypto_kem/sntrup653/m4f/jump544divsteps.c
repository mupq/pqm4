#include <stdint.h>
#include "cmsis.h"
#include "ntt132x.h"
extern void gf_polymul_512x32_2x2_x2p2 (int *V,int *M,int *fh,int *gh);
void gf_polymul_32x512_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2);

extern int jump512divsteps(int minusdelta, int *M, int *f, int *g);
extern int jump32divsteps(int minusdelta, int *M, int *f, int *g);

int jump544divsteps(int minusdelta, int *M, int *f, int *g);

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

// void gf_polymul_32x512(int *h, int *f, int *g){
//     int16_t *ptr = (int16_t *)h;
//     for (int i = 0; i < 544; i++) *ptr++ = 0;
    
//     for (int i = 0; i < 32; i++)
//     {
//         int16_t *result = (int16_t *)h + i;
//         int16_t *f_i = (int16_t *)f + i;
//         for (int j = 0; j < 512; j++)
//         {
//             int16_t *g_i = (int16_t *)g + j;
//             int new_val = (*f_i * *g_i) + *(result);
//             *(result++) = (int16_t)(new_val % q);
//         }
//     }
// }
extern void gf_polymul_32x32(int *h, int *f, int *g);

// void gf_polymul_32x32(int *h, int *f, int *g){
//     int16_t *ptr = (int16_t *)h;
//     for (int i = 0; i < 64; i++) *ptr++ = 0;
    
//     for (int i = 0; i < 32; i++)
//     {
//         int16_t *result = (int16_t *)h + i;
//         int16_t *f_i = (int16_t *)f + i;
//         for (int j = 0; j < 32; j++)
//         {
//             int16_t *g_i = (int16_t *)g + j;
//             int new_val = (*f_i * *g_i) + *(result);
//             *(result++) = (int16_t)(new_val % q);
//         }
//     }
// }

void gf_polymul_512x32_2x2_x2p2 (int *V,int *M,int *fh,int *gh){
  int i, T, *X, *Y, *Z, *W;

  //static
  int B753_1[385], B753_2[385];
  int * BB753_1 = (int *)((void *)B753_1 + 2);
  int * BB753_2 = (int *)((void *)B753_2 + 2);

  B753_1[0] = B753_2[0] = 0;
  gf_polymul_32x32(BB753_1, fh, M+512); 	// x * u * fh
  gf_polymul_32x32(BB753_2, gh, M+768);	// x * v * gh
  for (X=V, Y=B753_1, Z=B753_2, W=M, i=16; i>0; i--) {// x(u fh+v gh)+f1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  }

  gf_polymul_32x32(B753_1, fh, M+1024);	// r * fh
  gf_polymul_32x32(B753_2, gh, M+1280);	// s * gh
  for (Y=B753_1, Z=B753_2, W=M+256, i=16; i>0; i--) {	// x(r fh+s gh) + g1
    T = barrett_16x2i(__SADD16(__SADD16(*(W++),*(Y++)),*(Z++))); *(X++) = T;
  } 
}

// void gf_polymul_32x512_2x2_x_2x2_onlyuv (int *M, int *M1, int *M2){ // M = M2*M1, length M1 : 512*4   M2 : 32*4
//   int i, T, *X, *Y;

//   //static
//   int B753_1[385];
//   int * BB753_1 = (int *)((void *)B753_1 + 2);

//   B753_1[0] = 0;
//   gf_polymul_32x512(BB753_1, M2, M1); // x * u2 * u1 
//   gf_polymul_32x512(M, M2+16, M1+512); // v2 * r1
//   for (i=272, X=M, Y=B753_1; i>0; i--) {	// u = x u2 u1 + v2 r1
//     T = barrett_16x2i(__SADD16(*X,*(Y++)));
//     *(X++) = T;
//   }

//   gf_polymul_32x512(BB753_1, M2, M1+256); // x * u2 * v1
//   gf_polymul_32x512(M+384, M2+16, M1+768); // v2 * s1
//   for (i=272, X=M+384, Y=B753_1; i>0; i--) {	// v = x u2 v1 + v2 s1
//     T = barrett_16x2i(__SADD16(*X,*(Y++)));
//     *(X++) = T;
//   }
// }

// M: f(32), g(32), u(768), v(768)
// int jump544divsteps(int minusdelta, int *M, int *f, int *g){
//   int i;
//   int M1[1536], M2[96], fg1[32];

//   minusdelta = jump512divsteps(minusdelta, M1, f, g);
//   gf_polymul_512x32_2x2_x2p2(fg1,M1,f+256,g+256); // fg : f1 head , fg+16 : g1 head
//   minusdelta = jump32divsteps(minusdelta, M2, fg1, fg1+16);
  
//   for(i=0;i<32;i++)M[i]=M2[i];

//   gf_polymul_32x512_2x2_x_2x2_onlyuv(M+32,M1+512,M2+32);

//   return(minusdelta);
// }

int jump544divsteps(int minusdelta, int *M, int *f, int *g){
  int i;
  int M1[1536], M2[96], fg1[32];

  minusdelta = jump512divsteps(minusdelta, M1, f, g);
  gf_polymul_512x32_2x2_x2p2(fg1,M1,f+256,g+256); // fg : f1 head , fg+16 : g1 head
  minusdelta = jump32divsteps(minusdelta, M2, fg1, fg1+16);
  
  for(i=0;i<32;i++)M[i]=M2[i];

  // gf_polymul_32x512_2x2_x_2x2_onlyuv(M+32,M1+512,M2+32);
  int u1[396], v1[396], r1[396], s1[396], tmp1[396], tmp2[396];
  int u2[396], v2[396];
  int T, *X, *Y;
  ntt792_512x(u1, M1+512);
  ntt792_512x(v1, M1+768);
  ntt792_512(r1, M1+1024);
  ntt792_512(s1, M1+1280);

  for(i=16;i<128;++i)tmp1[i]=0;
  for(X = M2+32, Y = tmp1, i=16;i>0;--i)*(Y++) = *(X++);
  ntt792_256x(u2, tmp1);
  for(X = M2+48, Y = tmp1, i=16;i>0;--i)*(Y++) = *(X++);
  ntt792_256x(v2, tmp1);

  basemul_792(tmp1, u2, u1);
  basemul_792(tmp2, v2, r1);
  for(X=tmp1, Y=tmp2, i=396;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt792_768x(M+32, tmp1);
  for (i=384, X=M+32 ; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(*X); *(X++) = T;
  }

  basemul_792(tmp1, u2, v1);
  basemul_792(tmp2, v2, s1);
  for(X=tmp1, Y=tmp2, i=396;i>0;--i){
      T = __SADD16(*(Y++),*X);
      *(X++) = T;
  }
  intt792_768x(M+416, tmp1);
  for (i=384, X=M+416 ; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = barrett_16x2i(*X); *(X++) = T;
  }

  return(minusdelta);
}