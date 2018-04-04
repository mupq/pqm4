#include <stdint.h>
#include <stdio.h>
#include "params.h"
#include "fips202.h"
#include "poly.h"

static void compress_v(int64_t t[PARAM_N], int64_t *v)
{
  int i; int64_t temp;
  for(i=0;i<PARAM_N;i++){
    temp = v[i];
    while(temp<0)
      temp += PARAM_Q;
    while(temp>=PARAM_Q)
      temp -= PARAM_Q;
    t[i] = ((int64_t)(temp))>>PARAM_D;
  }
}



void random_oracle(unsigned char *c_bin, poly v, const unsigned char *m, unsigned long long mlen)
{
  int64_t t[PARAM_N];
  unsigned long long i;
  unsigned char buf[PARAM_N+mlen];
  int k;

  compress_v(t, v);
  for(i=0; i<PARAM_N; i++)
    buf[i] = t[i];
  
  for(i=0; i<mlen; i++)
    buf[i+PARAM_N] = m[i];

  cshake256_simple(c_bin, 32, 0,buf, mlen+PARAM_N);
}


