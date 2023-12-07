
/**
 * @file common.c
 * @brief Common functions
 */

#include "common.h"
#include <string.h>
#include "crypto_memset.h"
#include "symmetric.h"

void sig_perk_gen_one_pi_i(perm_t pi_i, const salt_t salt, uint16_t rnd_buffer_pi_i[PARAM_N1],
                           sig_perk_prg_state_t *state, const theta_t theta) {
    sig_perk_prg_init(state, PRG1, salt, theta);
    sig_perk_prg(state, (uint8_t *)rnd_buffer_pi_i, PARAM_N1 * sizeof(uint16_t));
    while (sig_perk_perm_gen_given_random_input(pi_i, rnd_buffer_pi_i) != EXIT_SUCCESS) {
        sig_perk_prg(state, (uint8_t *)rnd_buffer_pi_i, PARAM_N1 * sizeof(uint16_t));
    }
}

void sig_perk_gen_one_v_i(vect1_t v_i, const salt_t salt, uint16_t rnd_buff_v_i[PRNG_BLOCK_SIZE / 2],
                          sig_perk_prg_state_t *state, const theta_t theta) {
    // To make easier the times4 optimized implementation
    // we reinitialise the PRNG with a different domain separator, thus we use
    // PRG1 to sample the pi_i and PRG2 to sample the v_i
    sig_perk_prg_init(state, PRG2, salt, theta);
    int j = 0;
    while (j < PARAM_N1) {
        int k = 0;
        sig_perk_prg(state, (uint8_t *)rnd_buff_v_i, (PRNG_BLOCK_SIZE / 2) * sizeof(uint16_t));
        while ((j < PARAM_N1) && (k < PRNG_BLOCK_SIZE / 2)) {
            v_i[j] = PARAM_Q_MASK & rnd_buff_v_i[k++];
            if (v_i[j] < PARAM_Q) {  // accept the sample
                j++;
            }
        }
    }
}

void sig_perk_gen_pi_i_and_v_i(perm_t *pi_i, vect1_t *v_i, const salt_t salt,
                               const perk_theta_seeds_tree_t theta_tree) {
    sig_perk_prg_state_t state;
    uint16_t rnd_buffer_pi_i[PARAM_N1];
    uint16_t rnd_buff_v_i[PRNG_BLOCK_SIZE / 2];
    for (int i = 0; i < PARAM_N; ++i) {
        if (i != 0) {  // skip the generation of pi_1
            sig_perk_gen_one_pi_i(pi_i[i], salt, rnd_buffer_pi_i, &state, theta_tree[THETA_SEEDS_OFFSET + i]);
        }
        sig_perk_gen_one_v_i(v_i[i], salt, rnd_buff_v_i, &state, theta_tree[THETA_SEEDS_OFFSET + i]);
    }
    memset_zero(rnd_buffer_pi_i, sizeof(rnd_buffer_pi_i));
    memset_zero(rnd_buff_v_i, sizeof(rnd_buff_v_i));
    memset_zero(&state, sizeof(sig_perk_prg_state_t));
}

void sig_perk_gen_vect_v(vect1_t o, perm_t *pi_i, vect1_t *v_i, const perm_t pi) {
    vect1_t tmp_vect;
    perm_t tmp_compose_perm;

    sig_perk_perm_compose_inv(tmp_compose_perm, pi, pi_i[0]);
    sig_perk_perm_vect_permute(o, tmp_compose_perm, v_i[0]);
    for (int i = 1; i < PARAM_N - 1; ++i) {
        sig_perk_perm_compose_inv(tmp_compose_perm, tmp_compose_perm, pi_i[i]);
        sig_perk_perm_vect_permute(tmp_vect, tmp_compose_perm, v_i[i]);
        sig_perk_vect1_add(o, o, tmp_vect);
    }
    sig_perk_vect1_add(o, o, v_i[PARAM_N - 1]);
}

// Commitments are stored in reverse order: from element (PARAM_N-1) down to element 0.
void sig_perk_gen_commitment_cmt_1_i(perk_instance_t *instance, salt_t salt, uint8_t tau) {
    for (int i = 0; i < PARAM_N; ++i) {
        sig_perk_hash_state_t state;
        uint8_t idx = i;
        if (i == 0) {
            sig_perk_hash_init(&state, salt, &tau, &idx);
            sig_perk_hash_update(&state, instance->pi_i[0], PARAM_N1);
            sig_perk_hash_update(&state, instance->theta_tree[THETA_SEEDS_OFFSET], sizeof(theta_t));
            sig_perk_hash_final(&state, instance->cmt_1_i[PARAM_N - 1], H0);
        } else {
            sig_perk_hash_init(&state, salt, &tau, &idx);
            sig_perk_hash_update(&state, instance->theta_tree[THETA_SEEDS_OFFSET + i], sizeof(theta_t));
            sig_perk_hash_final(&state, instance->cmt_1_i[(PARAM_N - 1) - i], H0);
        }
    }
}

void sig_perk_gen_instance_commitments(perk_instance_t *instance, salt_t salt, uint8_t tau, const perm_t pi) {
    sig_perk_gen_pi_i_and_v_i(instance->pi_i, instance->v_i, salt, (const theta_t *)instance->theta_tree);
    sig_perk_perm_gen_pi_1(instance->pi_i, pi);
    sig_perk_gen_commitment_cmt_1_i(instance, salt, tau);
}

void sig_perk_gen_instance_commitment_cmt_1(cmt_t cmt_1, const salt_t salt, uint8_t tau, const mat_t H,
                                            const vect1_t v) {
    sig_perk_hash_state_t state;
    vect2_t tmp;
    sig_perk_mat_vect_mul(tmp, H, v);
    sig_perk_hash_init(&state, salt, &tau, NULL);
    sig_perk_hash_update(&state, (uint8_t *)tmp, sizeof(tmp));
    sig_perk_hash_final(&state, cmt_1, H0);
}