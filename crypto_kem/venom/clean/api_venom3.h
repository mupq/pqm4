/********************************************************************************************
* FrodoKEM: Learning with Errors Key Encapsulation
*
* Abstract: parameters and API for FrodoKEM-976
*********************************************************************************************/

#ifndef _API_Frodo976_H_
#define _API_Frodo976_H_


#define CRYPTO_SECRETKEYBYTES  25456     // sizeof(s) + CRYPTO_PUBLICKEYBYTES + 2*PARAMS_N*PARAMS_NBAR + BYTES_PKHASH
#define CRYPTO_PUBLICKEYBYTES   9792     // sizeof(seed_A) + (PARAMS_PK_LOGP*PARAMS_N*PARAMS_NBAR)/8
#define CRYPTO_BYTES              24
#define CRYPTO_CIPHERTEXTBYTES  9816     // (PARAMS_U_LOGP*PARAMS_N*PARAMS_NBAR)/8 + (PARAMS_V_LOGP*PARAMS_NBAR*PARAMS_NBAR)/8 + BYTES_SALT

// Algorithm name
#define CRYPTO_ALGNAME "FrodoKEM-976"


int crypto_kem_keypair_Frodo976(unsigned char *pk, unsigned char *sk);
int crypto_kem_enc_Frodo976(unsigned char *ct, unsigned char *ss, const unsigned char *pk);
int crypto_kem_dec_Frodo976(unsigned char *ss, const unsigned char *ct, const unsigned char *sk);


#endif
