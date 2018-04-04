#include "poly.h"
#include "fips202.h"
#include "api.h"
#include <stdio.h>
extern int32_t bitrev[PARAM_N];
extern poly omega;
extern poly omegainv;
extern poly psi;
extern poly psiinv;

void poly_bitrev(poly a){
  int32_t i,t;
  for(i=0;i<PARAM_N;i++){
    if(i<bitrev[i]){
      t=a[i];
      a[i]=a[bitrev[i]];
      a[bitrev[i]]=t;

    }

  }
}

void poly_ntt(poly a, const poly w){
  int NumoProblems = 1, ProblemSize = PARAM_N_LOG;
  while(ProblemSize > 0) {
    int jFirst;
    for(jFirst = 0; jFirst < NumoProblems;jFirst++) {
      int j = jFirst, jTwiddle = 0;
      while(j < PARAM_N - 1) {
        int W = w[jTwiddle];
	int temp = a[j];
	a[j] = (temp + a[j + NumoProblems]) % PARAM_Q;
	a[j + NumoProblems] = (W * (temp + (PARAM_Q - a[j + NumoProblems]))) % PARAM_Q;
	jTwiddle++;
	j = j + 2*NumoProblems;
      }
    }
    NumoProblems = NumoProblems * 2;
    ProblemSize--;
  }
}

void poly_pointwise(poly result, const poly x, const poly y){
  int32_t i;
  for(i=0;i<PARAM_N;i++)
    result[i] = (x[i]*y[i])%PARAM_Q;
}


/**
 * Polynomial multiplication with in place reduction for (X^N+1)
 */
void poly_mul(poly result, const poly x, const poly y)
{
  poly x_ntt, y_ntt;
  int i;
  
  poly_pointwise(x_ntt,x,psi);
  poly_bitrev(x_ntt);
  poly_ntt(x_ntt,omega);
  
  poly_pointwise(y_ntt,y,psi);
  poly_bitrev(y_ntt);
  poly_ntt(y_ntt,omega);

  poly_pointwise(result,x_ntt,y_ntt);

  poly_bitrev(result);
  poly_ntt(result,omegainv);
  poly_pointwise(result,result,psiinv);

}

void poly_uniform(poly a, const unsigned char *seed)
{
  unsigned int pos=0, i=0;
  uint32_t val;
  unsigned int nblocks=16;
  int32_t buf[SHAKE128_RATE*nblocks];
  int16_t ctr=0;
  cshake128_simple((uint8_t*)buf, SHAKE128_RATE*nblocks*4,ctr++,seed, CRYPTO_RANDOMBYTES);    
  i=0;
  while(i < PARAM_N)
  {
    val = buf[pos++]&0x3FFFFFFF;
    if(val < 133*PARAM_Q){
      a[i] = val;
      i++;
    }
    if(pos > SHAKE128_RATE*nblocks-2)
    {
      cshake128_simple((uint8_t*)buf, SHAKE128_RATE*nblocks*4,ctr++,seed, CRYPTO_RANDOMBYTES);    
      pos=0;
    }
  }
  
}


/**
 * Polynomial addition
 */
void poly_add(poly result, const poly x, const poly y)
{
    unsigned int i;

    for(i = 0; i < PARAM_N; i++)
    {
        result[i] = (x[i] + y[i])%PARAM_Q;
    }
}
/**
 * Polynomial Subtraction
 */
void poly_sub(poly result, const poly x, const poly y)
{
    unsigned int i;

    for(i = 0; i < PARAM_N; i++)
    {
        result[i] = (x[i] + (PARAM_Q- y[i]))%PARAM_Q;
    }
}
