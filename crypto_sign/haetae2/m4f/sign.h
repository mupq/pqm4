#ifndef HAETAE_SIGN_H
#define HAETAE_SIGN_H

#include "params.h"
#include "poly.h"
#include "polymat.h"
#include "polyvec.h"
#include <stddef.h>
#include <stdint.h>

typedef union MatrixPointerL_frozen{
    const uint8_t *seed;
    polyvecl_frozen *vec;
} uMatrixPointerL_frozen;

typedef union MatrixPointerM_frozen{
    const uint8_t *seed;
    polyvecm_frozen *vec;
} uMatrixPointerM_frozen;

#define crypto_sign_keypair HAETAE_NAMESPACE(keypair)
int crypto_sign_keypair(uint8_t *pk, uint8_t *sk);

#define crypto_sign_signature HAETAE_NAMESPACE(signature)
int crypto_sign_signature(uint8_t *sig, size_t *siglen, const uint8_t *m,
                          size_t mlen, const uint8_t *sk);

#define crypto_sign HAETAE_NAMESPACE(sign)
int crypto_sign(uint8_t *sm, size_t *smlen, const uint8_t *m, size_t mlen,
                     const uint8_t *sk);

#define crypto_sign_verify HAETAE_NAMESPACE(verify)
int crypto_sign_verify(const uint8_t *sig, size_t siglen, const uint8_t *m,
                       size_t mlen, const uint8_t *pk);

#define crypto_sign_open HAETAE_NAMESPACE(open)
int crypto_sign_open(uint8_t *m, size_t *mlen, const uint8_t *sm, size_t smlen,
                     const uint8_t *pk);

#endif // HAETAE_SIGN_H