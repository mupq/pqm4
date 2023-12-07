
/**
 * @file keygen.c
 * @brief Implementation of key generation
 */

#include "keygen.h"
#include <string.h>
#include "arithmetic.h"
#include "data_structures.h"
#include "parameters.h"
#include "parsing.h"
#include "randombytes.h"
#include "symmetric.h"
#include "verbose.h"

uint8_t sig_perk_generate_keypair(perk_public_key_t *pk, perk_private_key_t *sk) {
    vect1_t tmp;
    // sample seeds
    randombytes(pk->seed, sizeof(pk->seed));
    randombytes(sk->seed, sizeof(sk->seed));

    // sample private key
    sig_perk_perm_set_random(sk->pi, sk->seed);

    sig_perk_prg_state_t prg;
    // initialize prg
    sig_perk_prg_init(&prg, PRG1, NULL, pk->seed);

    // Generate H and x
    sig_perk_mat_set_random(pk->H, &prg);
    sig_perk_vect1_set_random_list(pk->x, &prg);

    // compute y
    for (int i = 0; i < PARAM_T; i++) {
        // compute tmp = pi(x)
        sig_perk_perm_vect_permute(tmp, sk->pi, pk->x[i]);
        sig_perk_mat_vect_mul(pk->y[i], (const vect1_t *)pk->H, tmp);
    }

    sig_perk_public_key_to_bytes(sk->pk_bytes, pk);

    SIG_PERK_VERBOSE_PRINT_uint8_t_array("sk_seed", sk->seed, SEED_BYTES);
    SIG_PERK_VERBOSE_PRINT_uint8_t_array("pi", sk->pi, PARAM_N1);
    SIG_PERK_VERBOSE_PRINT_uint8_t_array("pk_seed", pk->seed, SEED_BYTES);
    SIG_PERK_VERBOSE_PRINT_matrix((const vect1_t *)pk->H);
    SIG_PERK_VERBOSE_PRINT_x((const vect1_t *)pk->x);
    SIG_PERK_VERBOSE_PRINT_y((const vect2_t *)pk->y);

    return EXIT_SUCCESS;
}