#include <stddef.h>

#define CRYPTO_SECRETKEYBYTES   57344
#define CRYPTO_PUBLICKEYBYTES   897
#define CRYPTO_BYTES            690

#define CRYPTO_ALGNAME          "Falcon-512-tree"

int crypto_sign_keypair(unsigned char *pk, unsigned char *sk);

int crypto_sign(unsigned char *sm, size_t *smlen,
	const unsigned char *m, size_t mlen,
	const unsigned char *sk);

int crypto_sign_open(unsigned char *m, size_t *mlen,
	const unsigned char *sm, size_t smlen,
	const unsigned char *pk);
