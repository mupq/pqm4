
/**
 * @file verify.c
 * @brief Implementation of verify function
 */

#include "verify.h"
#include <string.h>
#include "common.h"
#include "parsing.h"

static void sig_perk_verify_compute_cmt_1_i(sig_perk_hash_state_t *hash_state, const perk_theta_seeds_tree_t theta_tree,
                                            const perk_response_t *response, const challenge_t challenge,
                                            const uint8_t tau, salt_t salt) {
    sig_perk_hash_state_t state;
    cmt_t cmt_1_i;

    for (int i = PARAM_N - 1; i >= 0; --i) {
        uint8_t idx = i;
        if (i == 0 && (0 != (challenge.alpha - 1))) {
            sig_perk_hash_init(&state, salt, &tau, &idx);
            sig_perk_hash_update(&state, response->z2_pi, sizeof(perm_t));
            sig_perk_hash_update(&state, theta_tree[THETA_SEEDS_OFFSET], sizeof(theta_t));
            sig_perk_hash_final(&state, cmt_1_i, H0);

            sig_perk_hash_update(hash_state, cmt_1_i, sizeof(cmt_1_i));
        }
        if (i != 0 && (i != (challenge.alpha - 1))) {
            sig_perk_hash_init(&state, salt, &tau, &idx);
            sig_perk_hash_update(&state, theta_tree[THETA_SEEDS_OFFSET + i], sizeof(theta_t));
            sig_perk_hash_final(&state, cmt_1_i, H0);

            sig_perk_hash_update(hash_state, cmt_1_i, sizeof(cmt_1_i));
        }
        if (i == (challenge.alpha - 1)) {
            sig_perk_hash_update(hash_state, response->cmt_1_alpha, sizeof(cmt_t));
        }
    }
}

static void sig_perk_verify_compute_s_i_and_h2(sig_perk_hash_state_t *h2_state, const perk_response_t *response,
                                               const perk_theta_seeds_tree_t theta_tree, const challenge_t challenge,
                                               vect1_t s_0, salt_t salt) {
    sig_perk_prg_state_t state;
    vect1_t v_i;
    vect1_t s_i;
    perm_t pi_i;
    uint16_t rnd_buffer_pi_i[PARAM_N1];
    uint16_t rnd_buff_v_i[PRNG_BLOCK_SIZE / 2];
    for (int i = 0; i < PARAM_N; ++i) {
        if (i != (challenge.alpha - 1)) {
            if (i != 0) {  // skip the generation of pi_1
                sig_perk_gen_one_pi_i(pi_i, salt, rnd_buffer_pi_i, &state, theta_tree[THETA_SEEDS_OFFSET + i]);
            } else {  // fetch pi_1 from z_2
                memcpy(pi_i, response->z2_pi, sizeof(perm_t));
            }
            sig_perk_gen_one_v_i(v_i, salt, rnd_buff_v_i, &state, theta_tree[THETA_SEEDS_OFFSET + i]);
            for (int j = 0; j < PARAM_N1; ++j) {
                s_i[pi_i[j]] = s_0[j];
            }
            sig_perk_vect1_add(s_i, s_i, v_i);
            memcpy(s_0, s_i, sizeof(vect1_t));
            sig_perk_hash_update(h2_state, (uint8_t *)s_i, sizeof(vect1_t));
        }
        if (i == (challenge.alpha - 1)) {
            memcpy(s_0, response->z1, sizeof(vect1_t));
            sig_perk_hash_update(h2_state, (uint8_t *)response->z1, sizeof(vect1_t));
        }
    }
}

static void sig_perk_verify_gen_instance_commitment_cmt(cmt_t cmt_1, const perk_public_key_t *public_key,
                                                        const vect1_t s_N, const uint16_t kappa[3], const salt_t salt,
                                                        const uint8_t tau) {
    vect2_t tmp1, tmp2, tmp3;
    sig_perk_hash_state_t state;

    sig_perk_mat_vect_mul(tmp1, public_key->H, s_N);
    sig_perk_vect2_mult_scalar_vect(tmp2, kappa[0], public_key->y[0]);
    for (int i = 1; i < PARAM_T; i++) {
        sig_perk_vect2_mult_scalar_vect(tmp3, kappa[i], public_key->y[i]);
        sig_perk_vect2_add(tmp2, tmp2, tmp3);
    }
    sig_perk_vect2_sub(tmp1, tmp1, tmp2);

    sig_perk_hash_init(&state, salt, &tau, NULL);
    sig_perk_hash_update(&state, (uint8_t *)tmp1, sizeof(tmp1));
    sig_perk_hash_final(&state, cmt_1, H0);
}

static void sig_perk_verify_generic_h(sig_perk_hash_state_t *hash_state, const salt_t salt,
                                      const uint8_t *message_bytes, const uint64_t message_length,
                                      const uint8_t *pk_bytes) {
    sig_perk_hash_init(hash_state, salt, NULL, NULL);
    sig_perk_hash_update(hash_state, message_bytes, message_length);
    sig_perk_hash_update(hash_state, pk_bytes, PUBLIC_KEY_BYTES);
}

static void sig_perk_streamlined_verify_compute_s_0(vect1_t s_0, const challenge_t challenge,
                                                    const vect1_t x[PARAM_T]) {
    vect1_t tmp;
    sig_perk_vect1_mult_scalar_vect(s_0, challenge.kappa[0], x[0]);
    for (int i = 1; i < PARAM_T; i++) {
        sig_perk_vect1_mult_scalar_vect(tmp, challenge.kappa[i], x[i]);
        sig_perk_vect1_add(s_0, s_0, tmp);
    }
}

int sig_perk_verify(perk_signature_t *signature, const challenge_t challenge[PARAM_TAU], const uint8_t *message_bytes,
                    const uint64_t message_length, const uint8_t *pk_bytes) {
    perk_public_key_t public_key = {0};
    digest_t h1_prime, h2_prime;
    sig_perk_hash_state_t h1_state, h2_state;
    sig_perk_verify_generic_h(&h1_state, signature->salt, message_bytes, message_length, pk_bytes);
    h2_state = h1_state;
    sig_perk_hash_update(&h2_state, signature->h1, sizeof(digest_t));

    for (int i = 0; i < PARAM_TAU; ++i) {
        if (challenge[i].alpha == 1) {
            for (int j = 0; j < PARAM_N1; j++) {
                if (signature->responses[i].z2_pi[j] != j) {
                    return EXIT_FAILURE;
                }
            }
        }
    }
    if (EXIT_SUCCESS != sig_perk_public_key_from_bytes(&public_key, pk_bytes)) {
        return EXIT_FAILURE;
    }

    for (int i = 0; i < PARAM_TAU; ++i) {
        perk_theta_seeds_tree_t theta_tree;
        vect1_t s_0;
        cmt_t cmt_1 = {0};  // fix cppcheck error

        sig_perk_expand_theta_partial_tree(signature->salt, theta_tree,
                                           (const theta_t *)signature->responses[i].z2_theta, challenge[i].alpha - 1);
        sig_perk_verify_compute_cmt_1_i(&h1_state, (const theta_t *)theta_tree, &signature->responses[i], challenge[i],
                                        i, signature->salt);
        sig_perk_streamlined_verify_compute_s_0(s_0, challenge[i], (const vect1_t *)public_key.x);
        // s_N is stored in s_0
        sig_perk_verify_compute_s_i_and_h2(&h2_state, &signature->responses[i], (const theta_t *)theta_tree,
                                           challenge[i], s_0, signature->salt);
        sig_perk_verify_gen_instance_commitment_cmt(cmt_1, &public_key, s_0, challenge[i].kappa, signature->salt, i);
        sig_perk_hash_update(&h1_state, cmt_1, sizeof(cmt_t));
    }

    sig_perk_hash_final(&h1_state, h1_prime, H1);
    sig_perk_hash_final(&h2_state, h2_prime, H2);

    if (memcmp(h1_prime, signature->h1, sizeof(digest_t))) {
        return EXIT_FAILURE;
    }

    if (memcmp(h2_prime, signature->h2, sizeof(digest_t))) {
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}