
/**
 * @file symmetric.c
 * @brief Implementation of the symmetric functions
 */

#include "symmetric.h"

void sig_perk_prg_init(sig_perk_prg_state_t *state, const uint8_t domain, const salt_t salt, const seed_t seed) {
    Keccak_HashInitialize_SHAKE(state);
    if (salt != NULL) {
        Keccak_HashUpdate_SHAKE(state, salt, sizeof(salt_t));
    }
    if (seed != NULL) {
        Keccak_HashUpdate_SHAKE(state, seed, sizeof(seed_t));
    }
    Keccak_HashUpdate_SHAKE(state, &domain, 1);
    Keccak_HashFinal_SHAKE(state);
}

void sig_perk_prg(sig_perk_prg_state_t *state, uint8_t *output, size_t outlen) {
    Keccak_HashSqueeze_SHAKE(state, output, outlen);
}

void sig_perk_hash_init(sig_perk_hash_state_t *state, const salt_t salt, const uint8_t *tau, const uint8_t *n) {
    Keccak_HashInitialize_SHA3(state);
    Keccak_HashUpdate_SHA3(state, salt, sizeof(salt_t));

    uint8_t counters[2];
    int j = 0;
    if (tau != NULL) {
        counters[j] = *tau;
        j++;
    }
    if (n != NULL) {
        counters[j] = *n;
        j++;
    }
    if (j != 0) {
        Keccak_HashUpdate_SHA3(state, counters, j);
    }
}

void sig_perk_hash_update(sig_perk_hash_state_t *state, const uint8_t *message, const size_t message_size) {
    Keccak_HashUpdate_SHA3(state, message, message_size);
}

void sig_perk_hash_final(sig_perk_hash_state_t *state, digest_t digest, const uint8_t domain) {
    Keccak_HashUpdate_SHA3(state, &domain, 1);
    Keccak_HashFinal_SHA3(state, digest);
}
