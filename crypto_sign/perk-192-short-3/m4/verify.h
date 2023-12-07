
/**
 * @file verify.h
 * @brief Header file for verify.c
 */

#ifndef SIG_PERK_VERIFY_H
#define SIG_PERK_VERIFY_H

#include "data_structures.h"
#include "signature.h"

/**
 * @brief Verify a signature
 *
 * @param [out] signature a pointer to signature structure
 * @param [in] challenge an array containing the challenges
 * @param [in] message_bytes a pointer to a string containing the message
 * @param [in] message_length an integer that is the size of the message
 * @param [in] pk_bytes a string containing the public key
 * @return int 0 if the verification is successful and 1 otherwise
 */
int sig_perk_verify(perk_signature_t *signature, const challenge_t challenge[PARAM_TAU], const uint8_t *message_bytes,
                    const uint64_t message_length, const uint8_t *pk_bytes);

#endif