
/**
 * @file keygen.h
 * @brief Header file for keygen.c
 */

#ifndef SIG_PERK_KEYGEN_H
#define SIG_PERK_KEYGEN_H

#include "data_structures.h"

/**
 * @brief Generate a key pair
 *
 * @param [out] pk a pointer to public key structure
 * @param [out] sk a pointer to private key structure
 * @return int 0 if the key generation is successful
 */
uint8_t sig_perk_generate_keypair(perk_public_key_t *pk, perk_private_key_t *sk);

#endif