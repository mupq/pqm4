/* Deterministic randombytes by Daniel J. Bernstein */
/* taken from SUPERCOP (https://bench.cr.yp.to)     */

#include "api.h"
#include "stm32wrapper.h"
#include "randombytes.h"

#include <stdio.h>
#include <string.h>
#include <stdint.h>

#define MAXMLEN 2048

typedef uint32_t uint32;

static void printbytes(const unsigned char *x, unsigned long long xlen)
{
  char out[3];
  unsigned long long i;
  for(i=0;i<xlen;i++) {
    sprintf(out, "%02x", x[i]);
    send_USART_bytes((unsigned char *)out, 2);
  }
  send_USART_str("");
}

static uint32 seed[32] = { 3,1,4,1,5,9,2,6,5,3,5,8,9,7,9,3,2,3,8,4,6,2,6,4,3,3,8,3,2,7,9,5 } ;
static uint32 in[12];
static uint32 out[8];
static int outleft = 0;

#define ROTATE(x,b) (((x) << (b)) | ((x) >> (32 - (b))))
#define MUSH(i,b) x = t[i] += (((x ^ seed[i]) + sum) ^ ROTATE(x,b));

static void surf(void)
{
  uint32 t[12]; uint32 x; uint32 sum = 0;
  int r; int i; int loop;

  for (i = 0;i < 12;++i) t[i] = in[i] ^ seed[12 + i];
  for (i = 0;i < 8;++i) out[i] = seed[24 + i];
  x = t[11];
  for (loop = 0;loop < 2;++loop) {
    for (r = 0;r < 16;++r) {
      sum += 0x9e3779b9;
      MUSH(0,5) MUSH(1,7) MUSH(2,9) MUSH(3,13)
      MUSH(4,5) MUSH(5,7) MUSH(6,9) MUSH(7,13)
      MUSH(8,5) MUSH(9,7) MUSH(10,9) MUSH(11,13)
    }
    for (i = 0;i < 8;++i) out[i] ^= t[i + 4];
  }
}

void randombytes(unsigned char *x,unsigned long long xlen)
{
  while (xlen > 0) {
    if (!outleft) {
      if (!++in[0]) if (!++in[1]) if (!++in[2]) ++in[3];
      surf();
      outleft = 8;
    }
    *x = out[--outleft];
    ++x;
    --xlen;
  }
}

int main(void)
{
  unsigned char sk[CRYPTO_SECRETKEYBYTES];
  unsigned char pk[CRYPTO_PUBLICKEYBYTES];

  unsigned char mi[MAXMLEN];
  unsigned char sm[MAXMLEN+CRYPTO_BYTES];
  unsigned long long smlen;
  unsigned long long mlen;

  int r;
  unsigned long long i,j;

  clock_setup(CLOCK_FAST);
  gpio_setup();
  usart_setup(115200);
  rng_enable();

  send_USART_str("==========================");

  for(i=0; i<MAXMLEN; i=(i==0)?i+1:i<<1)
  {
    randombytes(mi,i);

    crypto_sign_keypair(pk, sk);

    printbytes(pk,CRYPTO_PUBLICKEYBYTES);
    send_USART_str("\n");
    printbytes(sk,CRYPTO_SECRETKEYBYTES);
    send_USART_str("\n");

    crypto_sign(sm, &smlen, mi, i, sk);

    printbytes(sm, smlen);
    send_USART_str("\n");

    // By relying on m == sm we prevent having to allocate CRYPTO_BYTES twice
    r = crypto_sign_open(sm, &mlen, sm, smlen, pk);

    if(r)
    {
      send_USART_str("ERROR: signature verification failed\n");
      send_USART_str("#");
      return -1;
    }
    for(j=0;j<i;j++)
    {
      if(sm[j]!=mi[j])
      {
        send_USART_str("ERROR: message recovery failed\n");
        send_USART_str("#");
        return -1;
      }
    }
  }

  send_USART_str("#");
  return 0;
}
