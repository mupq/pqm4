//  encrypt.h
//  2018-06-17  Markku-Juhani O. Saarinen <mjos@iki.fi>

#ifndef _ENCRYPT_H_
#define _ENCRYPT_H_

#include <stdint.h>
#include <stddef.h>

int encrypt_rho(uint8_t *c, const uint8_t *m,
    const uint8_t *rho, const uint8_t *pk);

int generate_keypair(uint8_t *pk, uint8_t *sk);

int encrypt(uint8_t *c, const uint8_t *m, const uint8_t *pk);

int decrypt(uint8_t *m, const uint8_t *c, const uint8_t *sk);

#endif /* _ENCRYPT_H_ */
