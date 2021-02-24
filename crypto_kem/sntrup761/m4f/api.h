

#define CRYPTO_SECRETKEYBYTES 1763
#define CRYPTO_PUBLICKEYBYTES 1158
#define CRYPTO_CIPHERTEXTBYTES 1039
#define CRYPTO_BYTES 32
#define crypto_kem_PRIMITIVE "sntrup761"

int crypto_kem_keypair(unsigned char *,unsigned char *);
int crypto_kem_enc(unsigned char *,unsigned char *,const unsigned char *);
int crypto_kem_dec(unsigned char *,const unsigned char *,const unsigned char *);
