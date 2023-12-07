
/**
 * @file signature.h
 * @brief Header file for signature.c
 */

#ifndef SIG_PERK_SIGNATURE_H
#define SIG_PERK_SIGNATURE_H

#include <stdint.h>
#include "data_structures.h"

/** @struct challenge_t
 *  @brief This structure contains the challenges of one round of the scheme
 *  @var challenge_t::kappa
 *  Member 'kappa' is an array of integers containing challenge kappa[i] with i in 0 .. PARAM_T - 1
 *  @var challenge_t::alpha
 *  Member 'alpha' is an integer containing challenge alpha
 */
typedef struct {
    uint16_t kappa[PARAM_T];
    uint16_t alpha;
} challenge_t;

/**
 * @brief Generate challenges kappa for PARAM_TAU rounds
 *
 * @param [out] challenge an array of PARAM_TAU challenge_t struct
 * @param [out,in] saved_state a pointer to Keccak state after absorbing salt, m and pk_bytes
 * @param [out] h1 a variable containing the digest h1
 * @param [in] salt a salt
 * @param [in] m a pointer to message
 * @param [in] mlen length of message
 * @param [in] pk_bytes a pointer to the public key bytes
 * @param [in] instances an array of PARAM_TAU instances
 */
void sig_perk_gen_first_challenge(challenge_t challenge[PARAM_TAU], sig_perk_hash_state_t *saved_state, digest_t h1,
                                  const salt_t salt, const uint8_t *m, const uint64_t mlen, const uint8_t *pk_bytes,
                                  const perk_instance_t instances[PARAM_TAU]);

/**
 * @brief Generate h2 and the challenges alpha for tau rounds
 *
 * @param [out] h2 a variable containing the digest h2
 * @param [out] challenge an array of tau challenge_t struct
 * @param [out,in] saved_state a pointer to Keccak state
 * @param [out] h1 a variable containing the digest h1
 * @param [in] instances an array of PARAM_TAU instances
 */
void sig_perk_gen_second_challenge(digest_t h2, challenge_t challenge[PARAM_TAU], sig_perk_hash_state_t *saved_state,
                                   const digest_t h1, perk_instance_t instances[PARAM_TAU]);

/**
 * @brief Generate a signature
 *
 * @param [out] signature a pointer to signature structure
 * @param [in] sk a pointer to private key structure
 * @param [in] message_bytes a string containing a message
 * @param [in] message_length an integer containing the length of the message
 */
uint8_t sig_perk_sign(perk_signature_t *signature, const perk_private_key_t *sk, const uint8_t *message_bytes,
                      const uint64_t message_length);

#endif