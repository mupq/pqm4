#include "api.h"
#include "verify.h"
#include "fips202.h"
#include "randombytes.h"
#include "SABER_indcpa.h"
#include <string.h>

int crypto_kem_keypair(uint8_t *pk, uint8_t *sk)
{
    indcpa_kem_keypair(pk, sk); // sk[0:SABER_INDCPA_SECRETKEYBYTES-1] <-- sk

    memcpy(sk + SABER_INDCPA_SECRETKEYBYTES, pk, SABER_INDCPA_PUBLICKEYBYTES); // sk[SABER_INDCPA_SECRETKEYBYTES:SABER_INDCPA_SECRETKEYBYTES+SABER_INDCPA_SECRETKEYBYTES-1] <-- pk

    sha3_256(sk + SABER_SECRETKEYBYTES - 64, pk, SABER_INDCPA_PUBLICKEYBYTES); // Then hash(pk) is appended.

    randombytes(sk + SABER_SECRETKEYBYTES - SABER_KEYBYTES, SABER_KEYBYTES); // Remaining part of sk contains a pseudo-random number, this is output when check in crypto_kem_dec() fails.

    return (0);
}

int crypto_kem_enc(uint8_t *c, uint8_t *k, const uint8_t *pk)
{
    uint8_t kr[64]; // Will contain key, coins
    uint8_t buf[64];

    randombytes(buf, 32);

    sha3_256(buf, buf, 32); // BUF[0:31] <-- random message (will be used as the key for client) Note: hash doesnot release system RNG output

    sha3_256(buf + 32, pk, SABER_INDCPA_PUBLICKEYBYTES); // BUF[32:63] <-- Hash(public key);  Multitarget countermeasure for coins + contributory KEM

    sha3_512(kr, buf, 64); // kr[0:63] <-- Hash(buf[0:63]), K^ <-- kr[0:31], noiseseed (r) <-- kr[32:63]

    indcpa_kem_enc(buf, kr + 32, pk, c); // buf[0:31] contains message; kr[32:63] contains randomness r;

    sha3_256(kr + 32, c, SABER_BYTES_CCA_DEC);

    sha3_256(k, kr, 64); // hash concatenation of pre-k and h(c) to k

    return (0);
}

int crypto_kem_dec(uint8_t *k, const uint8_t *c, const uint8_t *sk)
{
    uint8_t fail;
    uint8_t buf[64];
    uint8_t kr[64]; // Will contain key, coins
    const uint8_t *pk = sk + SABER_INDCPA_SECRETKEYBYTES;
    const uint8_t *hpk = sk + SABER_SECRETKEYBYTES - 64; // Save hash by storing h(pk) in sk

    indcpa_kem_dec(sk, c, buf); // buf[0:31] <-- message

    memcpy(buf + 32, hpk, 32);  // Multitarget countermeasure for coins + contributory KEM

    sha3_512(kr, buf, 64);

    fail = indcpa_kem_enc_cmp(buf, kr + 32, pk, c); //in-place verification of the re-encryption

    sha3_256(kr + 32, c, SABER_BYTES_CCA_DEC); // overwrite coins in kr with h(c)

    cmov(kr, sk + SABER_SECRETKEYBYTES - SABER_KEYBYTES, SABER_KEYBYTES, fail);

    sha3_256(k, kr, 64); // hash concatenation of pre-k and h(c) to k

    return (0);
}
