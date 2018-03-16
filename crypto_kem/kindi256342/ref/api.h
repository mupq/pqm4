#include "params.h"

#define CRYPTO_SECRETKEYBYTES KINDI_KEM_SECRETKEYBYTES
#define CRYPTO_PUBLICKEYBYTES KINDI_KEM_PUBLICKEYBYTES
#define CRYPTO_BYTES KINDI_KEM_HASHSIZE
#define CRYPTO_CIPHERTEXTBYTES KINDI_KEM_CIPHERBYTES

#define CRYPTO_ALGNAME "KINDI_KEM"

int crypto_kem_keypair(unsigned char *pk, unsigned char *sk);
int crypto_kem_enc(unsigned char *ct, unsigned char *ss, const unsigned char *pk);
int crypto_kem_dec(unsigned char *ss, const unsigned char *ct, const unsigned char *sk);

