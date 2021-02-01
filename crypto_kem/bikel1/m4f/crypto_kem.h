
#ifndef _CRYPTO_KEM_H_
#define _CRYPTO_KEM_H_




////////////////////////////////////////////////////////////////
//Below three APIs (keygen, encaps, decaps) are defined by NIST:
////////////////////////////////////////////////////////////////
//Keygenerate - pk is the public key,
//              sk is the private key,
int crypto_kem_keypair( unsigned char *pk,  unsigned char *sk);

//Encapsulate - pk is the public key,
//              ct is a key encapsulation message (ciphertext),
//              ss is the shared secret.
int crypto_kem_enc( unsigned char *ct,
         unsigned char *ss,
         const unsigned char *pk);

//Decapsulate - ct is a key encapsulation message (ciphertext),
//              sk is the private key,
//              ss is the shared secret
int crypto_kem_dec( unsigned char *ss,
         const unsigned char *ct,
         const unsigned char *sk);

#endif

