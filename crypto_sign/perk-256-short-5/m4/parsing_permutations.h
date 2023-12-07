
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
 * @brief Permutation rank encoding. Encode a permutation into a bytearray.
 *
 * @param in_p      input permutation
 * @param out_buff  output buffer byte string
 */
#if defined(__has_feature)
#if __has_feature(memory_sanitizer)
__attribute__((no_sanitize("memory")))
#endif
#if __has_feature(address_sanitizer)
__attribute__((no_sanitize("address")))
#endif
#endif
void sig_perk_perm_encode(const perm_t in_p, uint8_t* out_buff);

/**
 * @brief Permutation unrank decoding. Decode a bytearray into a permutation.
 *
 * @param in_buff input buffer byte string
 * @param out_p   output permutation
 * @return EXIT_SUCCESS or EXIT_FAILURE
 */
#if defined(__has_feature)
#if __has_feature(memory_sanitizer)
__attribute__((no_sanitize("memory")))
#endif
#if __has_feature(address_sanitizer)
__attribute__((no_sanitize("address")))
#endif
#endif
int sig_perk_perm_decode(const uint8_t* in_buff, perm_t out_p);

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

#endif