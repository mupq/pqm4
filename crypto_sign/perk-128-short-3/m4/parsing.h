
/**
 * @file parsing.h
 * @brief Header file for parsing.c
 */

#ifndef SIG_PERK_PARSING_H
#define SIG_PERK_PARSING_H

#include <stdint.h>
#include "data_structures.h"
#include "parameters.h"
#include "signature.h"

/**
 * @brief Parse a private key into a string
 *
 * As technicality, the public key is appended to the private key in order to respect NIST API.
 *
 * @param [out] sk_bytes a string containing the private key
 * @param [in] sk a pointer to private key structure
 */
void sig_perk_private_key_to_bytes(uint8_t sk_bytes[PRIVATE_KEY_BYTES], const perk_private_key_t* sk);

/**
 * @brief Parse a private key from a string
 *
 * @param [out] sk a pointer to private key structure
 * @param [in] sk_bytes a string containing the private key
 */
void sig_perk_private_key_from_bytes(perk_private_key_t* sk, const uint8_t sk_bytes[PRIVATE_KEY_BYTES]);

/**
 * @brief Parse a public key into a string
 *
 * @param [out] pk_bytes a string containing the public key
 * @param [in] pk a pointer to public key structure
 */
void sig_perk_public_key_to_bytes(uint8_t pk_bytes[PUBLIC_KEY_BYTES], const perk_public_key_t* pk);

/**
 * @brief Parse a public key from a string
 *
 * @param [out] pk a pointer to public key structure
 * @param [in] pk_bytes a string containing the public key
 */
int sig_perk_public_key_from_bytes(perk_public_key_t* pk, const uint8_t pk_bytes[PUBLIC_KEY_BYTES]);

/**
 * @brief Generate challenges based on Fiat-Shamir transform
 *
 * @param [out] challenges an array containing the challenges for Pall the rounds
 * @param [out] h1 a variable containing the digest h1
 * @param [out] h2 a variable containing the digest h2
 */
void sig_perk_challenges_from_bytes(challenge_t challenges[PARAM_TAU], const digest_t h1, const digest_t h2);

/**
 * @brief Parse a signature into a string
 *
 * @param [out] sb a string containing the signature
 * @param [in] signature a pointer to signature structure
 */
void sig_perk_signature_to_bytes(uint8_t sb[SIGNATURE_BYTES], const perk_signature_t* signature);

/**
 * @brief Parse a signature from a string
 *
 * @param [out] signature a pointer to signature structure
 * @param [in] sb a string containing the signature
 * @return int 0 if the parsing is successful and 1 otherwise
 */
int sig_perk_signature_from_bytes(perk_signature_t* signature, const uint8_t sb[SIGNATURE_BYTES]);

#endif