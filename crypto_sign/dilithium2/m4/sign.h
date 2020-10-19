#ifndef SIGN_H
#define SIGN_H

#include <stddef.h>
#include "params.h"
#include "poly.h"
#include "polyvec.h"

#ifndef SIGN_STACKSTRATEGY
# error "SIGN_STACKSTRATEGY not defined"
#endif

#if SIGN_STACKSTRATEGY == 1

struct strategy_1_sk_precomp {
    polyveck t0hat, s2hat;
    polyvecl mat[K], s1hat;
    uint8_t key[SEEDBYTES], tr[CRHBYTES];
};

void precompute_strategy_1_sk_parts(struct strategy_1_sk_precomp *precomp, const uint8_t *sk);

int crypto_sign_signature(
    uint8_t *sig, size_t *siglen,
    const uint8_t *m, size_t mlen,
    const struct strategy_1_sk_precomp *precomp);

#else

int crypto_sign_signature(
    uint8_t *sig, size_t *siglen,
    const uint8_t *m, size_t mlen, const uint8_t *sk);

#endif

int crypto_sign(
        uint8_t *sm, size_t *smlen,
        const uint8_t *msg, size_t len,
#if SIGN_STACKSTRATEGY == 1
        const struct strategy_1_sk_precomp *sk_precomp
#else 
        const uint8_t *sk
#endif
);

void challenge(poly *c, const unsigned char mu[CRHBYTES],
                                        const polyveck *w1);

int crypto_sign_keypair(uint8_t *pk, uint8_t *sk);





int crypto_sign_verify(
    const uint8_t *sig, size_t siglen,
    const uint8_t *m, size_t mlen, const uint8_t *pk);



int crypto_sign_open(uint8_t *m, size_t *mlen,
        const uint8_t *sm, size_t smlen,
        const uint8_t *pk);

#endif
