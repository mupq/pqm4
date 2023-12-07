
/**
 * @file permutation.h
 * @brief header file for permutation.c
 */

#ifndef SIG_PERK_PERMUTATION_H
#define SIG_PERK_PERMUTATION_H

#include <stdint.h>
#include "arithmetic.h"
#include "parameters.h"

/**
 * @brief Permutation perm_t
 *
 * This structure contains an array of integers that is a permutation
 */
typedef uint8_t perm_t[PARAM_N1];

/**
 * @brief Set permutation to zero
 *
 * @param [out,in] input_perm a permutation
 */
void sig_perk_perm_set_zero(perm_t input_perm);

/**
 * @brief Generate a random permutation form a seed
 *
 * @param [out] p a permutation
 * @param [in] seed a string containing a seed
 */
void sig_perk_perm_set_random(perm_t p, const uint8_t seed[SEED_BYTES]);

/**
 * @brief Generate a random permutation form random values
 *
 * @param [out] p a permutation
 * @param [in] rnd_buff an array containing random values
 */
int sig_perk_perm_gen_given_random_input(perm_t p, const uint16_t rnd_buff[PARAM_N1]);

/**
 * @brief Generate a random permutation form random values and compose
 *
 * @param [out,in] pi_comp a permutation to be composed
 * @param [out] p a permutation
 * @param [in] rnd_buff an array containing random values
 */
int sig_perk_perm_gen_given_random_input_and_compose(perm_t pi_comp, perm_t p, const uint16_t rnd_buff[PARAM_N1]);

/**
 * @brief Apply a permutation on a vector
 *
 * @param [out] output a permuted vector
 * @param [in] p a permutation
 * @param [in] input a vector
 */
void sig_perk_perm_vect_permute(vect1_t output, const perm_t p, const vect1_t input);

/**
 * @brief Compute the composition on two permutations
 *
 * o = p1(p2)
 *
 * @param [out] o a permutation
 * @param [in] p1 a permutation
 * @param [in] p2 a permutation
 */
void sig_perk_perm_compose(perm_t o, const perm_t p1, const perm_t p2);

/**
 * @brief Compute the composition p1 compose p2^-1
 *
 * o = p1(p2)
 *
 * @param [out] o a permutation
 * @param [in] p1 a permutation
 * @param [in] p2 a permutation
 */
void sig_perk_perm_compose_inv(perm_t o, const perm_t p1, const perm_t p2);

/**
 * @brief Compute the inverse of a permutation
 *
 * o = p1^(-1)
 *
 * @param [out] o a permutation
 * @param [in] p a permutation
 */
void sig_perk_perm_inverse(perm_t o, const perm_t p);

/**
 * @brief Compute the composition of given permutations
 *
 * @param [out] o a permutation
 * @param [in] pi_i a pointer to permutations
 * @param [in] nb_permutations an integer that is the number of permutations to be composed
 */
void sig_perk_perm_compose_set(perm_t o, perm_t *pi_i, const int nb_permutations);

/**
 * @brief Compute the permutation pi_1
 *
 * @param [out,in] pi_i a pointer to permutations
 * @param [in] pi the secret permutation pi in the scheme
 */
void sig_perk_perm_gen_pi_1(perm_t *pi_i, const perm_t pi);

#endif