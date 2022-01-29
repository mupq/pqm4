#ifndef INDCPA_H
#define INDCPA_H

void indcpa_keypair(unsigned char *pk,
                    unsigned char *sk);

void indcpa_enc(unsigned char *c,
                const unsigned char *m,
                const unsigned char *pk,
                const unsigned char *coins);

unsigned char indcpa_enc_cmp(const unsigned char *ct,
                             const unsigned char *m,
                             const unsigned char *pk,
                             const unsigned char *coins);

void indcpa_dec(unsigned char *m,
                const unsigned char *c,
                const unsigned char *sk);

#endif
