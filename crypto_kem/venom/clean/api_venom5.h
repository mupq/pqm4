/********************************************************************************************
* FrodoKEM: Learning with Errors Key Encapsulation
*
* Abstract: parameters and API for FrodoKEM-1344
*********************************************************************************************/

#ifndef _API_Frodo1344_H_
#define _API_Frodo1344_H_


#define CRYPTO_SECRETKEYBYTES  35040     // sizeof(s) + CRYPTO_PUBLICKEYBYTES + 2*PARAMS_N*PARAMS_NBAR + BYTES_PKHASH
#define CRYPTO_PUBLICKEYBYTES  13472     // sizeof(seed_A) + (PARAMS_PK_LOGP*PARAMS_N*PARAMS_NBAR)/8
#define CRYPTO_BYTES              32
#define CRYPTO_CIPHERTEXTBYTES 13504     // (PARAMS_U_LOGP*PARAMS_N*PARAMS_NBAR)/8 + (PARAMS_V_LOGP*PARAMS_NBAR*PARAMS_NBAR)/8 + BYTES_SALT

// Algorithm name
#define CRYPTO_ALGNAME "FrodoKEM-1344"


int crypto_kem_keypair_Frodo1344(unsigned char *pk, unsigned char *sk);
int crypto_kem_enc_Frodo1344(unsigned char *ct, unsigned char *ss, const unsigned char *pk);
int crypto_kem_dec_Frodo1344(unsigned char *ss, const unsigned char *ct, const unsigned char *sk);


#endif
