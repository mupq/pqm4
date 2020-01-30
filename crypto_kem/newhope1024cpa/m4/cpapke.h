#ifndef INDCPA_H
#define INDCPA_H

void cpapke_keypair(unsigned char *pk,
                    unsigned char *sk);

void cpapke_enc(unsigned char *c,
                const unsigned char *m,
                const unsigned char *pk,
                const unsigned char *coins);

unsigned char cpapke_enc_cmp(const unsigned char *c,
                             const unsigned char *m,
                             const unsigned char *pk,
                             const unsigned char *coins);

void cpapke_dec(unsigned char *m,
                const unsigned char *c,
                const unsigned char *sk);

#endif
