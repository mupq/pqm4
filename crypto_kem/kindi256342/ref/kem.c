#include "api.h"
#include "params.h"
#include "core.h"

int crypto_kem_keypair(unsigned char *pk, unsigned char *sk) {
	int i;

	memset(sk, 0, KINDI_KEM_SECRETKEYBYTES);
	memset(pk, 0, KINDI_KEM_PUBLICKEYBYTES);
	kindi_pk pk_p;
	poly_d sk_p[KINDI_KEM_L];
	
	kindi_keygen(&pk_p, sk_p);

	int offset_pk = 0;
	int offset_sk = 0;

	// compress pk and convert to byte-array
	for (i = 0; i < KINDI_KEM_L; i++) {
		poly_compress(pk_p.b[i], KINDI_KEM_T);  // b_bar = Compress(b,t)
		poly_tobytes_bitlen(pk + offset_pk, pk_p.b[i], KINDI_KEM_LOGQ - KINDI_KEM_T);
		offset_pk += KINDI_KEM_PK_POLYBYTES;
	}

	memcpy(pk + offset_pk, pk_p.seed, KINDI_KEM_SEEDSIZE);

	// convert sk to byte-array
	for (i = 0; i < KINDI_KEM_L; i++) {
		poly_neg_tobytes_bitlen(sk + offset_sk, sk_p[i],
		KINDI_KEM_SK_COEFFICIENTBITS);
		offset_sk += KINDI_KEM_SK_POLYBYTES;
	}

	memcpy(sk + offset_sk, pk, KINDI_KEM_PUBLICKEYBYTES);
	return 0;
}

int crypto_kem_enc(unsigned char *ct, unsigned char *ss,
		const unsigned char *pk) {

	int i;
	kindi_pk pk_p;

	// convert pk from byte-array to polynomials and decompress
	int offset_pk = 0;
	for (i = 0; i < KINDI_KEM_L; i++) {
		poly_frombytes_bitlen(pk_p.b[i], pk + offset_pk, KINDI_KEM_LOGQ - KINDI_KEM_T);
		poly_decompress(pk_p.b[i], KINDI_KEM_T);
		offset_pk += KINDI_KEM_PK_POLYBYTES;
	}

	memcpy(pk_p.seed, pk + offset_pk, KINDI_KEM_SEEDSIZE);

	kindi_kem_encaps(&pk_p, ct, ss);
	return 0;

}
int crypto_kem_dec(unsigned char *ss, const unsigned char *ct,
		const unsigned char *sk) {

	int i;
	kindi_pk pk_p;

	poly_d cipher[KINDI_KEM_NUMBER_CIPHERPOLY];
	poly_d sk_p[KINDI_KEM_L];

	int offset_sk = 0;
	int offset_c = 0;

	// convert sk from byte-array to polynomials
	for (i = 0; i < KINDI_KEM_L; i++) {
		poly_neg_frombytes_bitlen(sk_p[i], sk + offset_sk,
		KINDI_KEM_SK_COEFFICIENTBITS);
		offset_sk += KINDI_KEM_SK_POLYBYTES;
		//poly_print_d("sk_p_dec",sk_p[i]);
	}

	// convert pk from byte-array to polynomials and decompress
	for (i = 0; i < KINDI_KEM_L; i++) {
		poly_frombytes_bitlen(pk_p.b[i], sk + offset_sk, KINDI_KEM_LOGQ - KINDI_KEM_T);
		poly_decompress(pk_p.b[i], KINDI_KEM_T);
		offset_sk += KINDI_KEM_PK_POLYBYTES;
		//poly_print_d("pk_p_dec",pk_p.p[i]);
	}

	// convert ciphertext from byte-array to polynomials
	memcpy(pk_p.seed, sk + offset_sk, KINDI_KEM_SEEDSIZE);

	for (i = 0; i < KINDI_KEM_NUMBER_CIPHERPOLY; i++) {
		poly_frombytes_bitlen(cipher[i], ct + offset_c, KINDI_KEM_LOGQ);
		offset_c += KINDI_KEM_CIPHER_POLYBYTES;
	}

	kindi_kem_decaps(sk_p, &pk_p, cipher, ct, ss);
	return 0;
}
