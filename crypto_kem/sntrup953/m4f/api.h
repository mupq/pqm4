#define CRYPTO_SECRETKEYBYTES 2254
#define CRYPTO_PUBLICKEYBYTES 1505
#define CRYPTO_CIPHERTEXTBYTES 1349
#define CRYPTO_BYTES 32
#define crypto_kem_PRIMITIVE "sntrup953"

int crypto_kem_keypair(unsigned char *,unsigned char *);
int crypto_kem_enc(unsigned char *,unsigned char *,const unsigned char *);
int crypto_kem_dec(unsigned char *,const unsigned char *,const unsigned char *);
