#include "api.h"
#include "stm32wrapper.h"
#include "hal.h"

#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define MLEN 59

static void printcycles(const char *s, unsigned long long c)
{
  char outs[32];
  hal_send_str(s);
  snprintf(outs,sizeof(outs),"%llu\n",c);
  hal_send_str(outs);
}

int main(void)
{
  unsigned char sk[CRYPTO_SECRETKEYBYTES];
  unsigned char pk[CRYPTO_PUBLICKEYBYTES];
  unsigned char sm[MLEN+CRYPTO_BYTES];
  unsigned long long smlen;
  unsigned long long t0, t1;

  hal_setup(CLOCK_BENCHMARK);

  hal_send_str("==========================");

  // Key-pair generation
  t0 = hal_get_time();
  crypto_sign_keypair(pk, sk);
  t1 = hal_get_time();
  printcycles("keypair cycles:", t1-t0;

  // Signing
  t0 = hal_get_time();
  crypto_sign(sm, &smlen, sm, MLEN, sk);
  t1 = hal_get_time();
  printcycles("sign cycles: ", t1-t0);

  // Verification
  t0 = hal_get_time();
  crypto_sign_open(sm, &smlen, sm, smlen, pk);
  t1 = hal_get_time();
  printcycles("verify cycles: ", t1-t0);

  hal_send_str("#");
  while(1);
  return 0;
}
