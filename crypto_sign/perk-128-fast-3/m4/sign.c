
/**
 * @file sign.c
 * @brief Implementation of the NIST api functions
 */

#include <stdlib.h>
#include "api.h"
#include "crypto_memset.h"
#include "keygen.h"
#include "parsing.h"
#include "signature.h"
#include "verbose.h"
#include "verify.h"

/**
 * @brief Generate a keypair.
 *
 * @param [out] pk pointer to public key bytes
 * @param [out] sk pointer to public key bytes
 * @returns 0 if key generation is successful and -1 otherwise
 */
int crypto_sign_keypair(unsigned char *pk, unsigned char *sk) {
    SIG_PERK_VERBOSE_PRINT_string("KEYGEN");
    perk_public_key_t public_key = {0};
    perk_private_key_t private_key = {0};

    if (sig_perk_generate_keypair(&public_key, &private_key) != EXIT_SUCCESS) {
        memset_zero(&private_key, sizeof(private_key));
        return -1;
    }

    sig_perk_public_key_to_bytes(pk, &public_key);
    sig_perk_private_key_to_bytes(sk, &private_key);

    memset_zero(&private_key, sizeof(private_key));

    SIG_PERK_VERBOSE_PRINT_uint8_t_array("pk", pk, PUBLIC_KEY_BYTES);
    SIG_PERK_VERBOSE_PRINT_uint8_t_array("sk", sk, PRIVATE_KEY_BYTES);

    return 0;
}

/**
 * @brief Generate a signature of a message.
 *
 * @param [out] sm pointer to output signed message
 *                 (allocated array with CRYPTO_BYTES + mlen bytes), can be equal to m
 * @param [out] smlen pointer to output length of signed message
 * @param [in] m pointer to message to be signed
 * @param [in] mlen length of the message
 * @param [in] sk pointer to the secret key bytes
 * @returns 0 if signing is successful and -1 otherwise
 */
int crypto_sign(unsigned char *sm, size_t *smlen, const unsigned char *m, size_t mlen, const unsigned char *sk) {
    SIG_PERK_VERBOSE_PRINT_string("SIGN");
    perk_private_key_t private_key = {0};
    perk_signature_t signature = {0};
    sig_perk_private_key_from_bytes(&private_key, sk);

    for (size_t i = 0; i < mlen; ++i) sm[CRYPTO_BYTES + mlen - 1 - i] = m[mlen - 1 - i];

    if (sig_perk_sign(&signature, &private_key, sm + CRYPTO_BYTES, (uint64_t)mlen) != EXIT_SUCCESS) {
        memset_zero(&private_key, sizeof(private_key));
        memset_zero(&signature, sizeof(signature));
        return -1;
    }

    sig_perk_signature_to_bytes(sm, &signature);
    memset_zero(&private_key, sizeof(private_key));

    *smlen = mlen + CRYPTO_BYTES;

    SIG_PERK_VERBOSE_PRINT_signature_raw(m, mlen, sm);

    return 0;
}

/**
 * @brief Verify a signed message
 *
 * @param [out] m pointer to output message
 *                (allocated array with smlen bytes), can be equal to sm
 * @param [out] mlen pointer to output length of message
 * @param [in] sm pointer to signed message
 * @param [in] smlen length of signed message
 * @param [in] pk pointer to the public key bytes
 * @returns 0 if signed message could be verified correctly and -1 otherwise
 */
int crypto_sign_open(unsigned char *m, size_t *mlen, const unsigned char *sm, size_t smlen, const unsigned char *pk) {
    SIG_PERK_VERBOSE_PRINT_string("SIGN OPEN");
    if (smlen < CRYPTO_BYTES)
        goto badsig;

    *mlen = smlen - CRYPTO_BYTES;

    perk_signature_t signature;
    challenge_t challenges[PARAM_TAU] = {0};

    if (EXIT_SUCCESS != sig_perk_signature_from_bytes(&signature, sm)) {
        goto badsig;
    }

    sig_perk_challenges_from_bytes(challenges, signature.h1, signature.h2);

    // check the signature
    if (EXIT_SUCCESS != sig_perk_verify(&signature, challenges, (uint8_t *)(sm + CRYPTO_BYTES), *mlen, (uint8_t *)pk)) {
        goto badsig;
    } else {
        /* All good, copy msg, return 0 */
        for (size_t i = 0; i < *mlen; ++i) m[i] = sm[CRYPTO_BYTES + i];
        return 0;
    }

badsig:
    /* Signature verification failed */
    *mlen = -1;
    return -1;
}