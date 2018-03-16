#ifndef OWCPA_H
#define OWCPA_H

#include "params.h"

void owcpa_samplemsg(unsigned char msg[NTRU_OWCPA_MSGBYTES],
                     unsigned char seed[NTRU_SEEDBYTES]);

void owcpa_keypair(unsigned char *pk, 
                   unsigned char *sk);

void owcpa_enc(unsigned char *c,
               const unsigned char *m,
               const unsigned char *pk,
               const unsigned char *coins);

void owcpa_dec(unsigned char *m,
               const unsigned char *c,
               const unsigned char *sk);

#endif
