#include "api.h"

int crypto_kem_keypair(unsigned char *pk, unsigned char *sk)
{
  (void) pk;
  (void) sk;
  return 0;
}
int crypto_kem_enc(unsigned char *ct, unsigned char *ss, const unsigned char *pk)
{
  (void) ct;
  (void) ss;
  (void) pk;
  return 0;
}
int crypto_kem_dec(unsigned char *ss, const unsigned char *ct, const unsigned char *sk)
{
  (void) ss;
  (void) ct;
  (void) sk;
  return 0;
}
