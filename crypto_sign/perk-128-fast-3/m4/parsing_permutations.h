
/**
 * @file parsing_permutations.h
 * @brief Header file for parsing_permutations.c
 */

#ifndef SIG_PERK_PARSING_PERMUTATIONS_H
#define SIG_PERK_PARSING_PERMUTATIONS_H

#include <stdint.h>
#include "data_structures.h"
#include "parameters.h"
#include "signature.h"

/**
 * @brief Parse the permutations into a string
 *
 * @param [out] sb output string
 * @param [in] signature a pointer to signature structure
 */
void sig_perk_signature_perm_to_bytes(uint8_t* sb, const perk_signature_t* signature);

/**
 * @brief Parse the permutations from a string
 *
 * @param [out] signature a pointer to signature structure
 * @param [in] sb input string containing the permutations
 * @return int 0 if the parsing is successful and 1 otherwise
 */
int sig_perk_signature_perm_from_bytes(perk_signature_t* signature, const uint8_t* sb);

/**
 * @brief check the permutation to be valid:
 *        - coefficients < PARAM_N1
 *        - no coefficient duplicates
 *
 * @param p input permutation  to be checked
 * @return int
 */
static inline int sig_perk_permutation_not_valid(const perm_t p) {
    uint8_t c[sizeof(perm_t) / sizeof(**((perm_t*)0))] = {0};

    for (unsigned i = 0; i < sizeof(c); i++) {
        if (p[i] >= sizeof(c))
            return 1;
        if (c[p[i]])
            return 1;
        c[p[i]] = 1;
    }
    return 0;
}

#endif