#include "api.h"
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

unsigned long long hash_cycles;

int main(void)
{
  unsigned char sk[CRYPTO_SECRETKEYBYTES];
  unsigned char pk[CRYPTO_PUBLICKEYBYTES];
  unsigned char sm[MLEN+CRYPTO_BYTES];
  unsigned long long smlen;

  hal_setup(CLOCK_BENCHMARK);

  hal_send_str("==========================");

  // Key-pair generation
  hash_cycles = 0;
  crypto_sign_keypair(pk, sk);
  printcycles("keypair hash cycles:", hash_cycles);

  // Signing
  hash_cycles = 0;
  crypto_sign(sm, &smlen, sm, MLEN, sk);
  printcycles("sign hash cycles: ", hash_cycles);

  // Verification
  hash_cycles = 0;
  crypto_sign_open(sm, &smlen, sm, smlen, pk);
  printcycles("verify hash cycles: ", hash_cycles);

  hal_send_str("#");
  while(1);
  return 0;
}
