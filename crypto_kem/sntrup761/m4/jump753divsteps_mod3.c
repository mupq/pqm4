#include <stdint.h>
#include "red_mod3_int.h"
#include "cmsis.h"

extern void gf_polymul_256x512_mod3(int* h,int* f,int* g);

extern void gf_polymul_512x256_2x2_x2p2_mod3 (int *V,int *M,int *fh,int *gh);
extern void gf_polymul_128x128_2x2_x2p2_mod3 (int *V,int *M,int *fh,int *gh);
extern void gf_polymul_64x64_2x2_x2p2_mod3 (int *V,int *M,int *fh,int *gh);
extern void gf_polymul_32x32_2x2_x2p2_mod3 (int *V,int *M,int *fh,int *gh);
extern void gf_polymul_16x16_2x2_x2p2_mod3 (int *V,int *M,int *fh,int *gh);

extern void gf_polymul_16x16_2x2_x_2x2_mod3 (int *M, int *M1, int *M2);
extern void gf_polymul_32x32_2x2_x_2x2_mod3 (int *M, int *M1, int *M2);
extern void gf_polymul_64x64_2x2_x_2x2_mod3 (int *M, int *M1, int *M2);
extern void gf_polymul_128x128_2x2_x_2x2_mod3 (int *M, int *M1, int *M2);
extern void gf_polymul_256x512_2x2_x_2x2_mod3 (int *M, int *M1, int *M2);
void gf_polymul_256x512_2x2_x_2x2_onlyuv_mod3 (int *M, int *M1, int *M2);

extern int jump512divsteps_mod3(int minusdelta, int *M, int *f, int *g);
extern int jump128divsteps_mod3(int minusdelta, int *M, int *f, int *g);
extern int jump64divsteps_mod3(int minusdelta, int *M, int *f, int *g);
extern int jump32divsteps_mod3(int minusdelta, int *M, int *f, int *g);
extern int jump16divsteps_mod3(int minusdelta, int *M, int *f, int *g);
extern int jump8divsteps_mod3_1(int minusdelta, int *M, int *f, int *g);

int jump753divsteps_mod3(int minusdelta, int *M, int *f, int *g);


void gf_polymul_256x512_2x2_x_2x2_onlyuv_mod3 (int *M, int *M1, int *M2){ // M = M2*M1, length M1 : 512*4   M2 : 256*4
int C753_1[193];
C753_1[0]=0;
int * CC753_1 = (int *)((void *)C753_1 + 1);

  int i, T, *X, *Y;

  gf_polymul_256x512_mod3(CC753_1, M2, M1); // x * u2 * u1 
  gf_polymul_256x512_mod3(M, M2+64, M1+256); // v2 * r1
  for (i=192, X=M, Y=C753_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = (add_ub3(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_256x512_mod3(CC753_1, M2, M1+128); // x * u2 * v1
  gf_polymul_256x512_mod3(M+192, M2+64, M1+384); // v2 * s1
  for (i=192, Y=C753_1; i>0; i--) {	// v = x u2 v1 + v2 s1
    T = (add_ub3(*X,*(Y++)));
    *(X++) = T;
  }
/*
  gf_polymul_256x512_mod3(CC753_1, M2+128, M1); // x * r2 * u1
  gf_polymul_256x512_mod3(M+384, M2+192, M1+256); // s2 * r1
  for (i=192, Y=C753_1; i>0; i--) { // r = x r2 u1 + s2 r1
    T = (add_ub3(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_256x512_mod3(CC753_1, M2+128, M1+128); // x * r2 * v1
  gf_polymul_256x512_mod3(M+576, M2+192, M1+384); // s2 * s1
  for (i=192, Y=C753_1; i>0; i--) { // s = x r2 v1 + s2 s1
    T = (add_ub3(*X,*(Y++)));
    *(X++) = T;
  }
*/
}

int jump753divsteps_mod3(int minusdelta, int *M, int *f, int *g){
  int i;
  uint32_t M1[768], M2[192], M3[96], M4[48], M5[24], M6[24], fg1[384],fg2[128],fg3[64],fg4[32],fg5[16];
  uint32_t h1[32],h2[64],h3[128],h4[256];

  minusdelta = jump512divsteps_mod3(minusdelta, M1, f, g);
  gf_polymul_512x256_2x2_x2p2_mod3(fg1,M1,f+128,g+128); // fg : f1 head , fg+384 : g1 head
  minusdelta = jump128divsteps_mod3(minusdelta, M2, fg1, fg1+192);
  gf_polymul_128x128_2x2_x2p2_mod3(fg2,M2,fg1+32,fg1+224);
  minusdelta = jump64divsteps_mod3(minusdelta, M3, fg2, fg2+64);
  gf_polymul_64x64_2x2_x2p2_mod3(fg3,M3,fg2+16,fg2+80);
  minusdelta = jump32divsteps_mod3(minusdelta, M4, fg3, fg3+32);
  gf_polymul_32x32_2x2_x2p2_mod3(fg4,M4,fg3+8,fg3+40);
  minusdelta = jump16divsteps_mod3(minusdelta, M5, fg4, fg4+16);
  gf_polymul_16x16_2x2_x2p2_mod3(fg5,M5,fg4+4,fg4+20); //fg 0~15 f, 16~31 g
  minusdelta = jump8divsteps_mod3_1(minusdelta, M6, fg5, fg5+8);


  unsigned int a,b,c,d,e,y;
  a=M6[0];//f'
  b=M6[2];//g'
  c=M6[5];
  d=M6[7];
  e=M6[9];
  y=M6[11];

  for(i=0;i<24;i++)M6[i]=0;
  M6[23]=y;
  M6[19]=e;
  M6[15]=d;
  M6[11]=c;
  M6[0]=a;
  M6[1]=b;


  gf_polymul_16x16_2x2_x_2x2_mod3(h1,M5+8,M6+8);
  gf_polymul_32x32_2x2_x_2x2_mod3(h2,M4+16,h1);
  gf_polymul_64x64_2x2_x_2x2_mod3(h3,M3+32,h2);
  gf_polymul_128x128_2x2_x_2x2_mod3(h4,M2+64,h3);
  gf_polymul_256x512_2x2_x_2x2_onlyuv_mod3(M+384,M1+256,h4);

  for(i=0;i<384;i++)M[i]=0;
  M[0]=M6[0];
  M[192]=M6[1];

  return(minusdelta);
}