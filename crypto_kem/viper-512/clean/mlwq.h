#ifndef REF_MLWQ_H
#define REF_MLWQ_H

#include "structs.h"

// PKE
void ref_mlwq_keygen(mlwq_pk *pk, mlwq_sk *sk, const uint8_t *seed_A);
void ref_mlwq_encrypt(mlwq_ciphertext *ct, const mlwq_pk *pk, const uint8_t *msg, const uint8_t *seed_ct);
void ref_mlwq_decrypt(uint8_t *msg, const mlwq_sk *sk, const mlwq_ciphertext *ct);

// KEM
void ref_mlwq_kem_keygen(mlwq_pk *pk, mlwq_kem_sk *sk);
void ref_mlwq_kem_encaps(mlwq_ciphertext *ct, uint8_t *ss, const mlwq_pk *pk);
int ref_mlwq_kem_decaps(uint8_t *ss, const mlwq_kem_sk *sk, const mlwq_ciphertext *ct);

#endif