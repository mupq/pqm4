//	nist_kem.h
//	Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.

//	The NIST API for KEM (Key Encapsulation Mechanism)

#ifndef _NIST_KEM_H_
#define _NIST_KEM_H_

int crypto_kem_keypair(unsigned char *pk, unsigned char *sk);

int crypto_kem_enc(unsigned char *ct,
	unsigned char *k, const unsigned char *pk);

int crypto_kem_dec(unsigned char *k,
	const unsigned char *ct, const unsigned char *sk);

#endif /* _NIST_KEM_H_ */
