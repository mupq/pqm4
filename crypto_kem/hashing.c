#include "api.h"
#include "hal.h"

#include <stdio.h>
#include <stdint.h>
#include <string.h>

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
  unsigned char key_a[CRYPTO_BYTES], key_b[CRYPTO_BYTES];
  unsigned char sk[CRYPTO_SECRETKEYBYTES];
  unsigned char pk[CRYPTO_PUBLICKEYBYTES];
  unsigned char ct[CRYPTO_CIPHERTEXTBYTES];

  hal_setup(CLOCK_BENCHMARK);

  hal_send_str("==========================");

  // Key-pair generation
  hash_cycles = 0;
  crypto_kem_keypair(pk, sk);
  printcycles("keypair hash cycles:", hash_cycles);

  // Encapsulation
  hash_cycles = 0;
  crypto_kem_enc(ct, key_a, pk);
  printcycles("sign hash cycles: ", hash_cycles);

  // Decapsulation
  hash_cycles = 0;
  crypto_kem_dec(key_b, ct, sk);
  printcycles("verify hash cycles: ", hash_cycles);

  if (memcmp(key_a, key_b, CRYPTO_BYTES)) {
    hal_send_str("ERROR KEYS\n");
  }
  else {
    hal_send_str("OK KEYS\n");
  }

  hal_send_str("#");
  while(1);
  return 0;
}
