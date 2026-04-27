#include <string.h>
#include "api.h"
#include "params.h"
#include "structs.h"
#include "mlwq.h"
#include "poly.h"

/*
 * Byte layout of the packed public key (MLWQ_PUBLICKEYBYTES bytes):
 *   b_q[0..K-1] packed  (MLWQ_POLYVECBYTES bytes, 10-bit per coeff)
 *   seed_A               (SEEDBYTES bytes)
 *
 * Byte layout of the packed KEM secret key (MLWQ_KEM_SECRETKEYBYTES bytes):
 *   s[0..K-1] packed     (MLWQ_POLYVECBYTES bytes)
 *   packed public key    (MLWQ_PUBLICKEYBYTES bytes)
 *   H(pk)                (HASHBYTES bytes)
 *   z                    (SEEDBYTES bytes)
 *
 * Byte layout of the packed ciphertext (MLWQ_CIPHERTEXTBYTES bytes):
 *   u[0..K-1] compressed (MLWQ_POLYVECCOMPRESSEDBYTES bytes, 10-bit per coeff)
 *   v compressed         (MLWQ_POLYCOMPRESSEDBYTES bytes, 5-bit per coeff)
 */

static void pack_pk(unsigned char *out, const mlwq_pk *pk)
{
    for (int i = 0; i < MLWQ_K; i++)
        ref_poly_tobytes(out + i * MLWQ_POLYBYTES, &pk->b_q.vec[i]);
    memcpy(out + MLWQ_POLYVECBYTES, pk->seed_A, SEEDBYTES);
}

static void unpack_pk(mlwq_pk *pk, const unsigned char *in)
{
    for (int i = 0; i < MLWQ_K; i++)
        ref_poly_frombytes(&pk->b_q.vec[i], in + i * MLWQ_POLYBYTES);
    memcpy(pk->seed_A, in + MLWQ_POLYVECBYTES, SEEDBYTES);
    /* seed_d is not serialized in packed pk used by this KEM API. */
    memset(pk->seed_d, 0, SEEDBYTES);
}

static void pack_sk(unsigned char *out, const mlwq_kem_sk *sk,
                    const unsigned char *pk_bytes)
{
    for (int i = 0; i < MLWQ_K; i++)
        ref_poly_tobytes(out + i * MLWQ_POLYBYTES, &sk->pke_sk.s.vec[i]);
    memcpy(out + MLWQ_POLYVECBYTES, pk_bytes, MLWQ_PUBLICKEYBYTES);
    memcpy(out + MLWQ_POLYVECBYTES + MLWQ_PUBLICKEYBYTES, sk->h_pk, HASHBYTES);
    memcpy(out + MLWQ_POLYVECBYTES + MLWQ_PUBLICKEYBYTES + HASHBYTES, sk->z,
           SEEDBYTES);
}

static void unpack_sk(mlwq_kem_sk *sk, const unsigned char *in)
{
    for (int i = 0; i < MLWQ_K; i++)
        ref_poly_frombytes(&sk->pke_sk.s.vec[i], in + i * MLWQ_POLYBYTES);
    unpack_pk(&sk->pk, in + MLWQ_POLYVECBYTES);
    memcpy(sk->h_pk,
           in + MLWQ_POLYVECBYTES + MLWQ_PUBLICKEYBYTES,
           HASHBYTES);
    memcpy(sk->z,
           in + MLWQ_POLYVECBYTES + MLWQ_PUBLICKEYBYTES + HASHBYTES,
           SEEDBYTES);
}

static void pack_ct(unsigned char *out, const mlwq_ciphertext *ct)
{
    for (int i = 0; i < MLWQ_K; i++)
        ref_poly_compress_u(out + i * MLWQ_POLY_U_BYTES, &ct->u.vec[i]);
    ref_poly_compress_v(out + MLWQ_POLYVECCOMPRESSEDBYTES, &ct->v);
}

static void unpack_ct(mlwq_ciphertext *ct, const unsigned char *in)
{
    for (int i = 0; i < MLWQ_K; i++)
        ref_poly_decompress_u(&ct->u.vec[i], in + i * MLWQ_POLY_U_BYTES);
    ref_poly_decompress_v(&ct->v, in + MLWQ_POLYVECCOMPRESSEDBYTES);
}

int crypto_kem_keypair(unsigned char *pk, unsigned char *sk)
{
    mlwq_pk pk_s;
    mlwq_kem_sk sk_s;

    /* Generate key pair; ref_mlwq_kem_keygen computes h_pk = SHAKE128(packed pk)
     * and stores z, so no additional overrides are needed here. */
    ref_mlwq_kem_keygen(&pk_s, &sk_s);

    /* Pack public key */
    pack_pk(pk, &pk_s);

    /* Pack secret key: s || pk || H(pk) || z */
    pack_sk(sk, &sk_s, pk);

    return 0;
}

int crypto_kem_enc(unsigned char *ct, unsigned char *ss,
                   const unsigned char *pk)
{
    mlwq_pk pk_s;
    mlwq_ciphertext ct_s;

    unpack_pk(&pk_s, pk);
    ref_mlwq_kem_encaps(&ct_s, ss, &pk_s);

    pack_ct(ct, &ct_s);
    return 0;
}

int crypto_kem_dec(unsigned char *ss, const unsigned char *ct,
                   const unsigned char *sk)
{
    mlwq_kem_sk sk_s;
    mlwq_ciphertext ct_s;

    unpack_sk(&sk_s, sk);
    unpack_ct(&ct_s, ct);

    ref_mlwq_kem_decaps(ss, &sk_s, &ct_s);
    return 0;
}