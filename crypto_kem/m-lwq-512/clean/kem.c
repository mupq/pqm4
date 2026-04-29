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
for (int i = 0; i < MLWQ_K; i++) {
// 创建临时多项式，避免修改原始 sk 结构
poly temp_s = sk->pke_sk.s.vec[i];

for (int j = 0; j < MLWQ_N; j++) {
/* * 关键修改：将 [-3, 3] 范围的系数转换为 10-bit 无符号正数。
* 例如：-2 的 int16 表示为 0xFFFE，经过 & 0x3FF 变为 1022 (0x3FE)。
* 这样在 ref_poly_tobytes 内部，t[j] = 1022 + 0 = 1022，
* 1022 可以完美塞进 10 个 bit，不会发生之前的截断错误。
*/
temp_s.coeffs[j] = (int16_t)((uint16_t)temp_s.coeffs[j] & 0x3FF);
}

ref_poly_tobytes(out + i * MLWQ_POLYBYTES, &temp_s);
}
memcpy(out + MLWQ_POLYVECBYTES, pk_bytes, MLWQ_PUBLICKEYBYTES);
memcpy(out + MLWQ_POLYVECBYTES + MLWQ_PUBLICKEYBYTES, sk->h_pk, HASHBYTES);
memcpy(out + MLWQ_POLYVECBYTES + MLWQ_PUBLICKEYBYTES + HASHBYTES, sk->z,
SEEDBYTES);
}

static void unpack_sk(mlwq_kem_sk *sk, const unsigned char *in)
{
for (int i = 0; i < MLWQ_K; i++) {
// 1. 调用原有的解包函数，得到 [0, 1023] 范围的系数
ref_poly_frombytes(&sk->pke_sk.s.vec[i], in + i * MLWQ_POLYBYTES);

// 2. 核心修改：将 10-bit 无符号表示恢复为有符号表示
for (int j = 0; j < MLWQ_N; j++) {
uint16_t v = (uint16_t)sk->pke_sk.s.vec[i].coeffs[j];

/* * 如果 v > 512，说明它原本是一个负数（补码表示）。
* 例如：v = 1022, 则 1022 - 1024 = -2。
* 如果 v < 512，则是正数，保持不变。
*/
if (v > 512) {
sk->pke_sk.s.vec[i].coeffs[j] = (int16_t)(v - 1024);
} else {
sk->pke_sk.s.vec[i].coeffs[j] = (int16_t)v;
}
}
}
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