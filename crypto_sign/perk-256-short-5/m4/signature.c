
/**
 * @file signature.c
 * @brief Implementation of sign function
 */

#include "signature.h"
#include "parameters.h"

#include <stdio.h>
#include <string.h>
#include "common.h"
#include "crypto_memset.h"
#include "data_structures.h"
#include "parsing.h"
#include "randombytes.h"
#include "symmetric.h"
#include "theta_tree.h"
#include "verbose.h"

/**
 * @brief Generate the commitments TODO: update
 *
 * @param [out] signature a pointer to a signature structure
 * @param [out,in] instances an array of PARAM_TAU instances
 * @param [in] pi a variable that containing the permutation pi
 * @param [in] H a variable containing the public matrix H
 */
static void sig_perk_gen_commitment(perk_signature_t *signature, sig_perk_hash_state_t *h1_state,
                                    sig_perk_hash_state_t *h2_state, perm_t pi_0[PARAM_TAU], seed_t mseed,
                                    const uint8_t *m, const uint64_t mlen, const uint8_t *pk_bytes, const perm_t pi,
                                    const mat_t H) {
    uint8_t rand_bytes[SEED_BYTES + SALT_BYTES] = {0};
    sig_perk_prg_state_t prg_state;
    vect1_t v = {0};
    perm_t pi_inv;

    sig_perk_perm_inverse(pi_inv, pi);

    randombytes(rand_bytes, sizeof(rand_bytes));
    memcpy(mseed, rand_bytes, SEED_BYTES);
    memcpy(signature->salt, rand_bytes + SEED_BYTES, SALT_BYTES);
    sig_perk_prg_init(&prg_state, PRG1, signature->salt, mseed);

    sig_perk_hash_init(h1_state, signature->salt, NULL, NULL);
    sig_perk_hash_update(h1_state, m, mlen);
    sig_perk_hash_update(h1_state, pk_bytes, PUBLIC_KEY_BYTES);
    memcpy(h2_state, h1_state, sizeof(sig_perk_hash_state_t));

    SIG_PERK_VERBOSE_PRINT_uint8_t_array("mseed", mseed, SEED_BYTES);
    SIG_PERK_VERBOSE_PRINT_uint8_t_array("salt", signature->salt, SALT_BYTES);

    for (uint8_t e = 0; e < PARAM_TAU; ++e) {
        perm_t pi_1;
        perm_t pi_comp;
        cmt_t cmt_1_i;
        vect1_t v_i;
        perk_theta_seeds_tree_t theta_tree;

        memcpy(pi_1, pi_inv, sizeof(perm_t));

        sig_perk_prg(&prg_state, theta_tree[0], sizeof(theta_t));
        sig_perk_expand_theta_tree(signature->salt, theta_tree);

        sig_perk_hash_state_t h_state;
        sig_perk_prg_state_t p_state;
        uint16_t rnd_buffer_pi_i[PARAM_N1];
        uint16_t rnd_buff_v_i[PRNG_BLOCK_SIZE / 2];

        for (int i = PARAM_N - 1; i > 0; i--) {  // i ∈ {N, . . . , 2}
            perm_t pi_i;
            uint8_t idx = i;

            sig_perk_gen_one_v_i(v_i, signature->salt, rnd_buff_v_i, &p_state, theta_tree[THETA_SEEDS_OFFSET + i]);

            sig_perk_hash_init(&h_state, signature->salt, &e, &idx);
            sig_perk_hash_update(&h_state, theta_tree[THETA_SEEDS_OFFSET + i], sizeof(theta_t));
            sig_perk_hash_final(&h_state, cmt_1_i, H0);
            sig_perk_hash_update(h1_state, cmt_1_i, sizeof(cmt_t));

            sig_perk_gen_one_pi_i_and_compose(pi_1, pi_i, signature->salt, rnd_buffer_pi_i, &p_state,
                                              theta_tree[THETA_SEEDS_OFFSET + i]);

            if (i == (PARAM_N - 1)) {
                memcpy(v, v_i, sizeof(vect1_t));
                memcpy(pi_comp, pi_i, sizeof(perm_t));
            } else {
                sig_perk_perm_vect_permute(v_i, pi_comp, v_i);
                sig_perk_vect1_add(v, v, v_i);
                sig_perk_perm_compose(pi_comp, pi_comp, pi_i);
            }
        }

        sig_perk_perm_inverse(pi_1, pi_1);
        /* remove ??? see specification*/ memcpy(pi_0[e], pi_1, sizeof(perm_t));

        uint8_t idx = 0;
        sig_perk_hash_init(&h_state, signature->salt, &e, &idx);
        sig_perk_hash_update(&h_state, pi_1, PARAM_N1);
        sig_perk_hash_update(&h_state, theta_tree[THETA_SEEDS_OFFSET + 0], sizeof(theta_t));
        sig_perk_hash_final(&h_state, cmt_1_i, H0);
        sig_perk_hash_update(h1_state, cmt_1_i, sizeof(cmt_t));

        sig_perk_gen_one_v_i(v_i, signature->salt, rnd_buff_v_i, &p_state, theta_tree[THETA_SEEDS_OFFSET + 0]);

        sig_perk_perm_vect_permute(v_i, pi_comp, v_i);
        sig_perk_vect1_add(v, v, v_i);

        memset_zero(rnd_buffer_pi_i, sizeof(rnd_buffer_pi_i));
        memset_zero(rnd_buff_v_i, sizeof(rnd_buff_v_i));
        memset_zero(&p_state, sizeof(sig_perk_prg_state_t));
        memset_zero(&h_state, sizeof(sig_perk_hash_state_t));

        // reuse cmt_1_i for cmt_1
        sig_perk_gen_instance_commitment_cmt_1(cmt_1_i, signature->salt, e, H, v);
        sig_perk_hash_update(h1_state, cmt_1_i, sizeof(cmt_t));

        SIG_PERK_VERBOSE_PRINT_theta_cmt_1_and_v(theta_tree[0], cmt_1_i, v, e + 1);
    }
}

static void sig_perk_gen_first_challenge_s(challenge_t challenge[PARAM_TAU], sig_perk_hash_state_t *h1_state,
                                           digest_t h1) {
    sig_perk_prg_state_t prg_state;
    uint16_t tmp_kappa;

    sig_perk_hash_final(h1_state, h1, H1);

    sig_perk_prg_init(&prg_state, PRG1, NULL, h1);
    for (int i = 0; i < PARAM_TAU; ++i) {
        uint16_t nonzero_check = 0;
        do {
            for (int j = 0; j < PARAM_T; ++j) {
                do {
                    sig_perk_prg(&prg_state, (uint8_t *)&tmp_kappa, sizeof(tmp_kappa));
                    tmp_kappa = tmp_kappa & PARAM_Q_MASK;
                } while (tmp_kappa >= PARAM_Q);  // 0 <= tmp_kappa < PARAM_Q
                challenge[i].kappa[j] = tmp_kappa;
                nonzero_check |= tmp_kappa;
            }
        } while (!nonzero_check);
    }
}

void sig_perk_gen_first_challenge(challenge_t challenge[PARAM_TAU], sig_perk_hash_state_t *saved_state, digest_t h1,
                                  const salt_t salt, const uint8_t *m, const uint64_t mlen, const uint8_t *pk_bytes,
                                  const perk_instance_t instances[PARAM_TAU]) {
    sig_perk_hash_state_t hash_state;
    sig_perk_prg_state_t prg_state;
    uint16_t tmp_kappa;

    sig_perk_hash_init(&hash_state, salt, NULL, NULL);
    sig_perk_hash_update(&hash_state, m, mlen);
    sig_perk_hash_update(&hash_state, pk_bytes, PUBLIC_KEY_BYTES);
    memcpy(saved_state, &hash_state, sizeof(hash_state));
    for (int i = 0; i < PARAM_TAU; ++i) {
        // absorb cmt_1_N to cmt_1_1
        // Commitments are stored in reverse order: from element (PARAM_N-1) down to element 0.
        sig_perk_hash_update(&hash_state, (uint8_t *)instances[i].cmt_1_i, sizeof(cmt_t) * PARAM_N);
        sig_perk_hash_update(&hash_state, (uint8_t *)instances[i].cmt_1, sizeof(cmt_t));
    }
    sig_perk_hash_final(&hash_state, h1, H1);

    sig_perk_prg_init(&prg_state, PRG1, NULL, h1);
    for (int i = 0; i < PARAM_TAU; ++i) {
        uint16_t nonzero_check = 0;
        do {
            for (int j = 0; j < PARAM_T; ++j) {
                do {
                    sig_perk_prg(&prg_state, (uint8_t *)&tmp_kappa, sizeof(tmp_kappa));
                    tmp_kappa = tmp_kappa & PARAM_Q_MASK;
                } while (tmp_kappa >= PARAM_Q);  // 0 <= tmp_kappa < PARAM_Q
                challenge[i].kappa[j] = tmp_kappa;
                nonzero_check |= tmp_kappa;
            }
        } while (!nonzero_check);
    }
}

/**
 * @brief Generate the first response
 *
 * @param [out] instances an array of PARAM_TAU instances
 * @param [in] challenges an array of PARAM_TAU challenges
 * @param [in] x an array of PARAM_T public values x_i
 */
static void sig_perk_gen_first_response(sig_perk_hash_state_t *h2_state, digest_t h1, const perm_t pi_0[PARAM_TAU],
                                        const seed_t mseed, salt_t salt, const challenge_t challenges[PARAM_TAU],
                                        const vect1_t x[PARAM_T]) {
    sig_perk_prg_state_t prg_state;

    sig_perk_hash_update(h2_state, h1, sizeof(digest_t));

    sig_perk_prg_init(&prg_state, PRG1, salt, mseed);

    sig_perk_prg_state_t state;
    uint16_t rnd_buffer_pi_i[PARAM_N1];
    uint16_t rnd_buff_v_i[PRNG_BLOCK_SIZE / 2];

    for (int e = 0; e < PARAM_TAU; ++e) {
        vect1_t tmp;
        vect1_t v_i;  // TODO:  tmp and v_i can share memory??
        vect1_t s_0;
        vect1_t s_i;
        perk_theta_seeds_tree_t theta_tree;

        // compute s_0
        sig_perk_vect1_mult_scalar_vect(s_0, challenges[e].kappa[0], x[0]);
        for (int j = 1; j < PARAM_T; j++) {
            sig_perk_vect1_mult_scalar_vect(tmp, challenges[e].kappa[j], x[j]);
            sig_perk_vect1_add(s_0, s_0, tmp);
        }

        // sample seeds
        sig_perk_prg(&prg_state, theta_tree[0], sizeof(theta_t));
        sig_perk_expand_theta_tree(salt, theta_tree);

        sig_perk_gen_one_v_i(v_i, salt, rnd_buff_v_i, &state, theta_tree[THETA_SEEDS_OFFSET + 0]);

        sig_perk_perm_vect_permute(tmp, pi_0[e], s_0);
        sig_perk_vect1_add(s_i, tmp, v_i);

        sig_perk_hash_update(h2_state, (uint8_t *)s_i, sizeof(vect1_t));

        for (int i = 1; i < PARAM_N; ++i) {
            perm_t pi_i;

            // sample p_i and v_i
            sig_perk_gen_one_pi_i(pi_i, salt, rnd_buffer_pi_i, &state, theta_tree[THETA_SEEDS_OFFSET + i]);
            sig_perk_gen_one_v_i(v_i, salt, rnd_buff_v_i, &state, theta_tree[THETA_SEEDS_OFFSET + i]);

            sig_perk_perm_vect_permute(tmp, pi_i, s_i);
            sig_perk_vect1_add(s_i, tmp, v_i);

            sig_perk_hash_update(h2_state, (uint8_t *)s_i, sizeof(vect1_t));
        }
    }

    memset_zero(rnd_buffer_pi_i, sizeof(rnd_buffer_pi_i));
    memset_zero(rnd_buff_v_i, sizeof(rnd_buff_v_i));
    memset_zero(&state, sizeof(sig_perk_prg_state_t));
}

static void sig_perk_gen_second_challenge_s(digest_t h2, challenge_t challenge[PARAM_TAU],
                                            sig_perk_hash_state_t *h2_state) {
    sig_perk_prg_state_t prg_state;
    uint16_t tmp_alpha;

    sig_perk_hash_final(h2_state, h2, H2);

    sig_perk_prg_init(&prg_state, PRG1, NULL, h2);
    for (int i = 0; i < PARAM_TAU; ++i) {
        sig_perk_prg(&prg_state, (uint8_t *)&tmp_alpha, sizeof(tmp_alpha));
        tmp_alpha = (tmp_alpha & PARAM_N_MASK) + 1;  // 0 < tmp_alpha <= PARAM_N
        challenge[i].alpha = tmp_alpha;
    }
}

void sig_perk_gen_second_challenge(digest_t h2, challenge_t challenge[PARAM_TAU], sig_perk_hash_state_t *saved_state,
                                   const digest_t h1, perk_instance_t instances[PARAM_TAU]) {
    sig_perk_prg_state_t prg_state;
    uint16_t tmp_alpha;

    sig_perk_hash_update(saved_state, h1, sizeof(digest_t));
    for (int i = 0; i < PARAM_TAU; ++i) {
        sig_perk_hash_update(saved_state, (uint8_t *)instances[i].s_i[1], sizeof(vect1_t) * PARAM_N);
    }
    sig_perk_hash_final(saved_state, h2, H2);

    sig_perk_prg_init(&prg_state, PRG1, NULL, h2);
    for (int i = 0; i < PARAM_TAU; ++i) {
        sig_perk_prg(&prg_state, (uint8_t *)&tmp_alpha, sizeof(tmp_alpha));
        tmp_alpha = (tmp_alpha & PARAM_N_MASK) + 1;  // 0 < tmp_alpha <= PARAM_N
        challenge[i].alpha = tmp_alpha;
    }
}

/**
 * @brief Generate second response
 *
 * @param [out] signature a pointer to a signature structure
 * @param [in] challenges an array of PARAM_TAU challenges
 * @param [in] instances an array of PARAM_TAU instances
 */
static void sig_perk_gen_second_response(perk_signature_t *signature, const seed_t mseed,
                                         const challenge_t challenges[PARAM_TAU], const vect1_t x[PARAM_T],
                                         const perm_t pi_0[PARAM_TAU]) {
    sig_perk_prg_state_t prg_state;

    sig_perk_prg_init(&prg_state, PRG1, signature->salt, mseed);

    sig_perk_prg_state_t p_state;
    sig_perk_hash_state_t h_state;
    uint16_t rnd_buffer_pi_i[PARAM_N1];
    uint16_t rnd_buff_v_i[PRNG_BLOCK_SIZE / 2];

    for (uint8_t e = 0; e < PARAM_TAU; ++e) {
        vect1_t tmp;
        vect1_t v_i;  // TODO:  tmp and v_i can share memory??
        vect1_t s_0;
        vect1_t s_i;
        perk_theta_seeds_tree_t theta_tree;
        const uint16_t alpha = challenges[e].alpha;

        // compute s_0
        sig_perk_vect1_mult_scalar_vect(s_0, challenges[e].kappa[0], x[0]);
        for (int j = 1; j < PARAM_T; j++) {
            sig_perk_vect1_mult_scalar_vect(tmp, challenges[e].kappa[j], x[j]);
            sig_perk_vect1_add(s_0, s_0, tmp);
        }

        // sample seeds
        sig_perk_prg(&prg_state, theta_tree[0], sizeof(theta_t));
        sig_perk_expand_theta_tree(signature->salt, theta_tree);

        sig_perk_gen_one_v_i(v_i, signature->salt, rnd_buff_v_i, &p_state, theta_tree[THETA_SEEDS_OFFSET + 0]);

        sig_perk_perm_vect_permute(tmp, pi_0[e], s_0);
        sig_perk_vect1_add(s_i, tmp, v_i);
        for (int i = 1; i < alpha; ++i) {
            perm_t pi_i;

            // sample p_i and v_i
            sig_perk_gen_one_pi_i(pi_i, signature->salt, rnd_buffer_pi_i, &p_state, theta_tree[THETA_SEEDS_OFFSET + i]);
            sig_perk_gen_one_v_i(v_i, signature->salt, rnd_buff_v_i, &p_state, theta_tree[THETA_SEEDS_OFFSET + i]);

            sig_perk_perm_vect_permute(tmp, pi_i, s_i);
            sig_perk_vect1_add(s_i, tmp, v_i);
        }
        memcpy(signature->responses[e].z1, s_i, sizeof(vect1_t));

        if (alpha != 1) {
            memcpy(signature->responses[e].z2_pi, pi_0[e], sizeof(perm_t));
        } else {
            for (int j = 0; j < PARAM_N1; j++) {
                signature->responses[e].z2_pi[j] = j;
            }
        }
        sig_perk_get_theta_partial_tree_seeds(signature->responses[e].z2_theta, (const theta_t *)theta_tree, alpha - 1);

        uint8_t idx = alpha - 1;
        sig_perk_hash_init(&h_state, signature->salt, &e, &idx);
        if (alpha == 1) {
            sig_perk_hash_update(&h_state, pi_0[e], PARAM_N1);
        }
        sig_perk_hash_update(&h_state, theta_tree[THETA_SEEDS_OFFSET + idx], sizeof(theta_t));
        sig_perk_hash_final(&h_state, signature->responses[e].cmt_1_alpha, H0);
    }

    memset_zero(rnd_buffer_pi_i, sizeof(rnd_buffer_pi_i));
    memset_zero(rnd_buff_v_i, sizeof(rnd_buff_v_i));
    memset_zero(&p_state, sizeof(sig_perk_prg_state_t));
    memset_zero(&h_state, sizeof(sig_perk_hash_state_t));
}

uint8_t sig_perk_sign(perk_signature_t *signature, const perk_private_key_t *sk, const uint8_t *message_bytes,
                      const uint64_t message_length) {
    perk_public_key_t pk;
    perm_t pi_0[PARAM_TAU];
    challenge_t challenges[PARAM_TAU] = {0};
    sig_perk_hash_state_t h1_state;
    sig_perk_hash_state_t h2_state;  // initialized with a copy of h1_state after absorbing salt, m and pk_bytes
    seed_t mseed = {0};

    SIG_PERK_VERBOSE_PRINT_uint8_t_array("message m", message_bytes, message_length);

    if (EXIT_SUCCESS != sig_perk_public_key_from_bytes(&pk, sk->pk_bytes)) {
        return EXIT_FAILURE;
    }

    sig_perk_gen_commitment(signature, &h1_state, &h2_state, pi_0, mseed, message_bytes, message_length, sk->pk_bytes,
                            sk->pi, (const vect1_t *)pk.H);
    sig_perk_gen_first_challenge_s(challenges, &h1_state, signature->h1);
    sig_perk_gen_first_response(&h2_state, signature->h1, (const perm_t *)pi_0, mseed, signature->salt, challenges,
                                (const vect1_t *)pk.x);

    sig_perk_gen_second_challenge_s(signature->h2, challenges, &h2_state);
    sig_perk_gen_second_response(signature, mseed, challenges, (const vect1_t *)pk.x, (const perm_t *)pi_0);

    SIG_PERK_VERBOSE_PRINT_challenges(challenges);
    SIG_PERK_VERBOSE_PRINT_signature(signature);

    return EXIT_SUCCESS;
}