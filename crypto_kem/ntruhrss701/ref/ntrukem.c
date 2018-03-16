#include "randombytes.h"
#include "fips202.h"
#include "params.h"
#include "verify.h"
#include "owcpa.h"

// API FUNCTIONS 
int crypto_kem_keypair(unsigned char *pk, unsigned char *sk)
{
  size_t i;
  owcpa_keypair(pk, sk);
  for(i=0;i<NTRU_OWCPA_PUBLICKEYBYTES;i++)
    sk[i+NTRU_OWCPA_SECRETKEYBYTES] = pk[i];

  return 0;
}

int crypto_kem_enc(unsigned char *c, unsigned char *k, const unsigned char *pk)
{
  unsigned char m[NTRU_OWCPA_MSGBYTES];
  unsigned char m_seed[NTRU_SEEDBYTES];
  unsigned char buf[NTRU_COINBYTES + NTRU_SHAREDKEYBYTES + NTRU_OWCPA_MSGBYTES];
  unsigned char *c1 = buf;
  int i;

  randombytes(m_seed, NTRU_SEEDBYTES);
  owcpa_samplemsg(m, m_seed);

  shake128(buf, NTRU_COINBYTES + NTRU_SHAREDKEYBYTES + NTRU_OWCPA_MSGBYTES,
           m, NTRU_OWCPA_MSGBYTES);

  owcpa_enc(c, m, pk, c1);

  for (i = 0; i < NTRU_SHAREDKEYBYTES; i++) {
    k[i] = buf[NTRU_COINBYTES + i];
  }
  for (i = 0; i < NTRU_OWCPA_MSGBYTES; i++) {
    c[NTRU_OWCPA_BYTES + i] = buf[NTRU_COINBYTES + NTRU_SHAREDKEYBYTES + i];
  }

  return 0;
}

int crypto_kem_dec(unsigned char *k, const unsigned char *c, const unsigned char *sk)
{
  int i, fail;
  unsigned char m[NTRU_OWCPA_MSGBYTES];
  unsigned char cmp[NTRU_CIPHERTEXTBYTES];
  unsigned char buf[NTRU_COINBYTES + NTRU_SHAREDKEYBYTES + NTRU_OWCPA_MSGBYTES];
  unsigned char *c1 = buf;

  owcpa_dec(m, c, sk);

  shake128(buf, NTRU_COINBYTES + NTRU_SHAREDKEYBYTES + NTRU_OWCPA_MSGBYTES,
           m, NTRU_OWCPA_MSGBYTES);

  owcpa_enc(cmp, m, sk+NTRU_OWCPA_SECRETKEYBYTES, c1);

  for (i = 0; i < NTRU_OWCPA_MSGBYTES; i++) {
    cmp[NTRU_OWCPA_BYTES + i] = buf[NTRU_COINBYTES + NTRU_SHAREDKEYBYTES + i];
  }

  fail = verify(c, cmp, NTRU_CIPHERTEXTBYTES);

  if(fail) printf("error: reencryption produces a different result\n");

  for (i = 0; i < NTRU_SHAREDKEYBYTES; i++) {
    k[i] = buf[NTRU_COINBYTES + i];
    m[i] = 0;
  }
  cmov(k, m, NTRU_SHAREDKEYBYTES, fail);

  return fail;
}
