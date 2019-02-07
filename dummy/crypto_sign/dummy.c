#include "api.h"

int crypto_sign_keypair(unsigned char *pk, unsigned char *sk)
{
  (void) pk;
  (void) sk;
  return 0;
}

int crypto_sign(unsigned char *sm, unsigned long long *smlen,
                const unsigned char *msg, unsigned long long len,
                const unsigned char *sk)
{
  (void) sm;
  (void) smlen;
  (void) msg;
  (void) len;
  (void) sk;
  return 0;
}

int crypto_sign_open(unsigned char *m, unsigned long long *mlen,
                     const unsigned char *sm, unsigned long long smlen,
                     const unsigned char *pk)
{
  (void) m;
  (void) mlen;
  (void) sm;
  (void) smlen;
  (void) pk;
  return 0;
}
