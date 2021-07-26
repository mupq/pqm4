#define CRYPTO_SECRETKEYBYTES 2231
#define CRYPTO_PUBLICKEYBYTES 1847
#define CRYPTO_CIPHERTEXTBYTES 1975
#define CRYPTO_BYTES 32
#define crypto_kem_PRIMITIVE "ntrulpr1277"

int crypto_kem_keypair(unsigned char *,unsigned char *);
int crypto_kem_enc(unsigned char *,unsigned char *,const unsigned char *);
int crypto_kem_dec(unsigned char *,const unsigned char *,const unsigned char *);
