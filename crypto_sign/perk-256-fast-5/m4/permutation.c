
/**
 * @file permutation.c
 * @brief Implementation of permutation related functions.
 *
 *  This implementation uses memory table lookup
 *  and is constant time only for CPU without RAM cache like Arm M4 CPUs
 */

#include "permutation.h"
#include <string.h>
#include "crypto_memset.h"
#include "djbsort.h"
#include "symmetric.h"

int sig_perk_perm_gen_given_random_input(perm_t p, const uint16_t rnd_buff[PARAM_N1]) {
    uint32_t buffer[PARAM_N1];
    // Use 16 bits for randomness
    for (int i = 0; i < PARAM_N1; i++) {
        buffer[i] = (((uint32_t)rnd_buff[i]) << 16) | i;
    }
    // sort
    uint32_sort(buffer, PARAM_N1);
    // check that no double random values were produced
    for (int i = 1; i < PARAM_N1; i++) {
        if ((buffer[i - 1] >> 16) == (buffer[i] >> 16)) {
            return EXIT_FAILURE;
        }
    }
    // extract permutation from buffer
    for (int i = 0; i < PARAM_N1; i++) {
        p[i] = (uint16_t)(buffer[i]);
    }
    return EXIT_SUCCESS;
}

void sig_perk_perm_set_random(perm_t p, const uint8_t seed[SEED_BYTES]) {
    uint16_t rnd_buff[PARAM_N1];
    sig_perk_prg_state_t prg;
    sig_perk_prg_init(&prg, PRG1, NULL, seed);
    sig_perk_prg(&prg, (uint8_t *)rnd_buff, sizeof(rnd_buff));

    while (sig_perk_perm_gen_given_random_input(p, rnd_buff) != EXIT_SUCCESS) {
        sig_perk_prg(&prg, (uint8_t *)rnd_buff, sizeof(rnd_buff));
    }
    memset(rnd_buff, 0, sizeof(rnd_buff));
}

void sig_perk_perm_vect_permute(vect1_t output, const perm_t p, const vect1_t input) {
    vect1_t buffer = {0};
    for (size_t i = 0; i < PARAM_N1; i++) {
        buffer[p[i]] = input[i];
    }
    memcpy(output, buffer, sizeof(vect1_t));
}

void sig_perk_perm_inverse(perm_t o, const perm_t p) {
    perm_t buffer;
    for (int i = 0; i < PARAM_N1; i++) {
        buffer[p[i]] = i;
    }
    memcpy(o, buffer, sizeof(perm_t));
}

void sig_perk_perm_compose(perm_t o, const perm_t p1, const perm_t p2) {
    perm_t buffer = {0};
    for (size_t i = 0; i < PARAM_N1; i++) {
        buffer[i] = p1[p2[i]];
    }
    memcpy(o, buffer, sizeof(perm_t));
}

// compute p1 compose p2^-1
void sig_perk_perm_compose_inv(perm_t o, const perm_t p1, const perm_t p2) {
    uint32_t buffer[PARAM_N1];
    for (int i = 0; i < PARAM_N1; ++i) {
        buffer[i] = (((uint32_t)p2[i]) << 16) | p1[i];
    }
    uint32_sort(buffer, PARAM_N1);
    for (int i = 0; i < PARAM_N1; ++i) {
        o[i] = (uint16_t)(buffer[i]);
    }
}

void sig_perk_perm_gen_pi_1(perm_t *pi_i, const perm_t pi) {
    sig_perk_perm_inverse(pi_i[0], pi_i[1]);
    for (int i = 2; i < PARAM_N; i++) {
        sig_perk_perm_compose_inv(pi_i[0], pi_i[0], pi_i[i]);
    }
    sig_perk_perm_compose(pi_i[0], pi_i[0], pi);
}