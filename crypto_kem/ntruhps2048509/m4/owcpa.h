#ifndef OWCPA_H
#define OWCPA_H

#include "params.h"

void owcpa_samplemsg(unsigned char msg[NTRU_OWCPA_MSGBYTES],
        const unsigned char seed[NTRU_SEEDBYTES]);

void owcpa_keypair(unsigned char *pk,
        unsigned char *sk,
        const unsigned char seed[NTRU_SEEDBYTES]);

void owcpa_enc(unsigned char *c,
        const unsigned char *rm,
        const unsigned char *pk);

int owcpa_dec(unsigned char *rm,
        const unsigned char *ciphertext,
        const unsigned char *secretkey);
#endif
