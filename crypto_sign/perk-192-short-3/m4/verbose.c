
/**
 * @file verbose.c
 * @brief Implementation of function for printing intermediate values (VERBOSE mode)
 */

#include "verbose.h"
#include <stdio.h>
#include "api.h"
#include "parameters.h"

void sig_perk_verbose_print_string(const char *var) {
    printf("\n\n\n\n### %s ###", var);
}

void sig_perk_verbose_print_uint8_t_array(const char *var, const uint8_t *input, uint16_t size) {
    printf("\n\n%s: ", var);
    for (uint16_t i = 0; i < size; i++) {
        printf("%02x", input[i]);
    }
}

void sig_perk_verbose_print_uint16_t_array(const char *var, const uint16_t *input, uint16_t size) {
    printf("\n\n%s: ", var);
    for (uint16_t i = 0; i < size; i++) {
        printf("%d ", input[i]);
    }
}

void sig_perk_verbose_print_x(const vect1_t x[PARAM_T]) {
    printf("\n\nx\n");
    for (int i = 0; i < PARAM_T; ++i) {
        printf(" x_%d: ", i + 1);
        for (uint16_t j = 0; j < PARAM_N1; j++) {
            printf("%03d ", x[i][j]);
        }
        printf("\n");
    }
}

void sig_perk_verbose_print_y(const vect2_t y[PARAM_T]) {
    printf("\n\ny\n");
    for (int i = 0; i < PARAM_T; ++i) {
        printf(" y_%d: ", i + 1);
        for (uint16_t j = 0; j < PARAM_M; j++) {
            printf("%03d ", y[i][j]);
        }
        printf("\n");
    }
}

void sig_perk_verbose_print_matrix(const mat_t m_input) {
    printf("\n\nH: \n");
    for (int i = 0; i < PARAM_M; i++) {
        printf("  ");
        for (int j = 0; j < PARAM_N1; j++) {
            printf("%03d ", m_input[i][j]);
        }
        printf("\n");
    }
}

void sig_perk_verbose_print_theta_cmt_1_and_v(theta_t theta, cmt_t input, vect1_t v, uint16_t round_number) {
    printf("\n\n Round %02d: ", round_number);
    printf("\n  theta: ");
    for (int i = 0; i < SEED_BYTES; ++i) {
        printf("%02x", theta[i]);
    }
    printf("\n  cmt_1: ");
    for (uint16_t i = 0; i < sizeof(cmt_t); i++) {
        printf("%02x", ((uint8_t *)input)[i]);
    }
    printf("\n  v: ");
    for (uint16_t i = 0; i < PARAM_N1; i++) {
        printf("%d ", v[i]);
    }
}

void sig_perk_verbose_print_challenges(challenge_t *challenges) {
    printf("\n\nchallenges: ");
    printf("\n\n kappa: ");
    for (int i = 0; i < PARAM_TAU; i++) {
        printf("\n  kappa_i (round %02d): ", i + 1);
        for (int j = 0; j < PARAM_T; ++j) {
            printf("%03d ", challenges[i].kappa[j]);
        }
    }
    printf("\n\n alpha: ");
    for (int i = 0; i < PARAM_TAU; i++) printf("%d ", challenges[i].alpha);
}

void sig_perk_verbose_print_signature(const perk_signature_t *signature) {
    printf("\n\nsignature: ");
    sig_perk_verbose_print_uint8_t_array(" h1", signature->h1, sizeof(digest_t));
    sig_perk_verbose_print_uint8_t_array(" h2", signature->h2, sizeof(digest_t));
    printf("\n\n responses");
    for (int i = 0; i < PARAM_TAU; ++i) {
        printf("\n\n  response round %d", i + 1);
        sig_perk_verbose_print_uint16_t_array("   z1", signature->responses[i].z1, PARAM_N1);
        sig_perk_verbose_print_uint8_t_array("   z2_pi", signature->responses[i].z2_pi, PARAM_N1);
        printf("\n\n   z2_theta");
        for (int j = 0; j < THETA_TREE_LEVELS; ++j) {
            printf("\n    z2_theta seed # %d: ", j + 1);
            for (int k = 0; k < SEED_BYTES; ++k) {
                printf("%02x", signature->responses[i].z2_theta[j][k]);
            }
        }
        sig_perk_verbose_print_uint8_t_array("  cmt_1_alpha", signature->responses[i].cmt_1_alpha, COMMITMENT_BYTES);
    }
}

void sig_perk_verbose_print_signature_raw(const uint8_t *m, uint64_t mlen, const uint8_t *signature) {
    sig_perk_verbose_print_uint8_t_array("m", m, mlen);
    printf("\n\nsm(CRYPTO_BYTES):");
    for (uint16_t i = 0; i < CRYPTO_BYTES; ++i) {
        if (i % 32 == 0)
            printf("\n");
        printf("%02x", signature[i]);
    }
    printf("\n\n");
}

void sig_perk_verbose_print_thetas(perk_instance_t *instances) {
    printf("\n\nthetas: ");
    for (int i = 0; i < PARAM_TAU; ++i) {
        printf("\n theta round %02d: ", i + 1);
        for (int j = 0; j < SEED_BYTES; ++j) {
            printf("%02x", instances[i].theta_tree[0][j]);
        }
    }
}