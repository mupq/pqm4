#ifndef __CORE_H
#define __CORE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "params.h"
#include "poly.h"
#include "fips202.h"
#include "gen_randomness.h"

typedef struct {
	poly_d b[KINDI_KEM_L];
	uint8_t seed[KINDI_KEM_SEEDSIZE];
} kindi_pk;

void xor_bytes(uint8_t *r, const uint8_t *f, const uint8_t *g, int len);
void recover_s1(uint8_t *s1, poly_d v);

void kindi_keygen(kindi_pk *pk, poly_d *sk);

void kindi_kem_encrypt(kindi_pk *pk, uint8_t *d, uint8_t *s1, poly_d *cipher);
void kindi_kem_decrypt(poly_d *sk_r, kindi_pk *pk, poly_d *cipher, uint8_t *d_rec,
		uint8_t *s1_rec);

void kindi_kem_encaps(kindi_pk *pk_p, uint8_t *ct, uint8_t *ss);
void kindi_kem_decaps(poly_d *sk_p, kindi_pk *pk_p, poly_d *cipher,
		const uint8_t *ct, uint8_t *ss);

#endif

