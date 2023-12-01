#ifndef HAETAE_SIGN_H
#define HAETAE_SIGN_H

#include "params.h"
#include "poly.h"
#include "polymat.h"
#include "polyvec.h"
#include "polyfix.h"
#include <stddef.h>
#include <stdint.h>

typedef union {
    polyvecl cs1;
    polyvecl z1rnd;
    polyfixvecl z1tmp;
} vecl1;

typedef union {
    polyveck cs2;
    polyveck z2rnd;
    polyfixveck z2tmp;
} veck1;

typedef union {
    polyfixvecl y1;
    polyvecl lb_z1;
} vecl2;

typedef union {
    polyfixveck y2;
    polyveck htmp;
} veck2;

typedef union {
    polyfixvecl z1;
    polyvecl hb_z1;
} vecl3;

typedef union {
    polyfixveck z2;
    polyveck h;
} veck3;

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
