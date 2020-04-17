#include <stdint.h>
#include "red_mod3_int.h"
#include "cmsis.h"

extern void gf_polymul_256x256_mod3(void *h, void *f, void *g);
extern void gf_polymul_256x512_mod3(void *h, void *f, void *g); // length f : 256 , g : 512
extern int jump256divsteps_mod3(int minusdelta, int *M, int *f, int *g);
extern int jump512divsteps_mod3(int minusdelta, int *M, int *f, int *g);
void gf_polymul_512x256_2x2_x2p2_mod3 (int *V,int *M,int *fh,int *gh);
void gf_polymul_256x512_2x2_x2p2_mod3 (int *V,int *M,int *fh,int *gh);
void gf_polymul_256x512_2x2_x_2x2_mod3 (int *M, int *M1, int *M2); // M = M2*M1, length M1 : 512*4   M2 : 256*4 (u,v,r,s)
int jump768divsteps_mod3(int minusdelta, int *M, int *f, int *g);



void gf_polymul_512x256_2x2_x2p2_mod3 (int *V,int *M,int *fh,int *gh){
int C768_1[193], C768_2[193];
C768_1[0]=C768_2[0]=0;
int * CC768_1 = (int *)((void *)C768_1 + 1);
int * CC768_2 = (int *)((void *)C768_2 + 1);

  int i, T, *X, *Y, *Z, *W;

  gf_polymul_256x512_mod3(CC768_1, fh, M+256); // x * u * fh
  gf_polymul_256x512_mod3(CC768_2, gh, M+384); // x * v * gh
  for(X=V, Y=C768_1, Z=C768_2, W=M, i=128; i>0; i--){ // x(u fh+v gh)+f1, length ,u*fh & v*gh : 768, f1 : 512
    *(X++) = (add_ub3(add_ub3(*(W++),*(Y++)),*(Z++)));
  }
  for (i=64; i>0; i--) {  
    *(X++) = (add_ub3(*(Y++),*(Z++)));
  }

  gf_polymul_256x512_mod3(V+192, fh, M+512); // r * fh
  gf_polymul_256x512_mod3(CC768_1, gh, M+640); // s * gh

  for (Y=CC768_1, i=128; i>0; i--) {	// x(r fh+s gh) + g1, length ,r*fh & s*gh : 768, g1 : 512
    T = (add_ub3(add_ub3(*(W++),*(Y++)),*X));
    *(X++) = T;
  }
  for (i=64; i>0; i--) {  
    T = (add_ub3(*X, *(Y++)));
    *(X++) = T;
  }
}

void gf_polymul_256x512_2x2_x2p2_mod3 (int *V,int *M,int *fh,int *gh){
int C768_1[193], C768_2[193];
C768_1[0]=C768_2[0]=0;
int * CC768_1 = (int *)((void *)C768_1 + 1);
int * CC768_2 = (int *)((void *)C768_2 + 1);

  int i, T, *X, *Y, *Z, *W;

  gf_polymul_256x512_mod3(CC768_1, M+128, fh); // x * u * fh
  gf_polymul_256x512_mod3(CC768_2, M+192, gh);	// x * v * gh
  for (X=V, Y=C768_1, Z=C768_2, W=M, i=64; i>0; i--) {// x(u fh+v gh)+f1
    *(X++) = (add_ub3(add_ub3(*(W++),*(Y++)),*(Z++)));
  }  
  for (i=128; i>0; i--) {  
    *(X++) = (add_ub3(*(Y++),(*Z++)));
  } 


  gf_polymul_256x512_mod3(V+192, M+256, fh);	// r * fh
  gf_polymul_256x512_mod3(CC768_1, M+320, gh);	// s * gh
  for (Y=CC768_1, i=64; i>0; i--) {	// x(r fh+s gh) + g1
    T = (add_ub3(add_ub3(*(W++),*(Y++)),*X));
    *(X++) = T;
  } 
  for (i=128; i>0; i--) {  
    T = (add_ub3(*X, *(Y++)));
    *(X++) = T;
  } 
}

void gf_polymul_256x512_2x2_x_2x2_mod3 (int *M, int *M1, int *M2){ // M = M2*M1, length M1 : 512*4   M2 : 256*4
int C768_1[193], C768_2[193];
C768_1[0]=C768_2[0]=0;
int * CC768_1 = (int *)((void *)C768_1 + 1);
int * CC768_2 = (int *)((void *)C768_2 + 1);
  int i, T, *X, *Y;

  gf_polymul_256x512_mod3(CC768_1, M2, M1); // x * u2 * u1 
  gf_polymul_256x512_mod3(M, M2+64, M1+256); // v2 * r1
  for (i=192, X=M, Y=C768_1; i>0; i--) {	// u = x u2 u1 + v2 r1
    T = (add_ub3(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_256x512_mod3(CC768_1, M2, M1+128); // x * u2 * v1
  gf_polymul_256x512_mod3(M+192, M2+64, M1+384); // v2 * s1
  for (i=192, Y=C768_1; i>0; i--) {	// v = x u2 v1 + v2 s1
    T = (add_ub3(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_256x512_mod3(CC768_1, M2+128, M1); // x * r2 * u1
  gf_polymul_256x512_mod3(M+384, M2+192, M1+256); // s2 * r1
  for (i=192, Y=C768_1; i>0; i--) { // r = x r2 u1 + s2 r1
    T = (add_ub3(*X,*(Y++)));
    *(X++) = T;
  }

  gf_polymul_256x512_mod3(CC768_1, M2+128, M1+128); // x * r2 * v1
  gf_polymul_256x512_mod3(M+576, M2+192, M1+384); // s2 * s1
  for (i=192, Y=C768_1; i>0; i--) { // s = x r2 v1 + s2 s1
    T = (add_ub3(*X,*(Y++)));
    *(X++) = T;
  }
}

int jump768divsteps_mod3(int minusdelta, int *M, int *f, int *g){
    int M1[768], M2[384], fg[384];

    minusdelta = jump512divsteps_mod3(minusdelta,M1,f,g);

    gf_polymul_512x256_2x2_x2p2_mod3(fg,M1,f+128,g+128);

    minusdelta = jump256divsteps_mod3(minusdelta,M2,fg,fg+192);

    gf_polymul_256x512_2x2_x2p2_mod3(M,M2,fg+64,fg+256);

    gf_polymul_256x512_2x2_x_2x2_mod3(M+384,M1+256,M2+128);

    return(minusdelta);
}
