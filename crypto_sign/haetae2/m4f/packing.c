#include "packing.h"
#include "encoding.h"
#include "params.h"
#include "poly.h"
#include "polymat.h"
#include "polyvec.h"
#include <string.h>

/*************************************************
 * Name:        pack_pk
 *
 * Description: Bit-pack public key pk = (seed, b).
 *
 * Arguments:   - uint8_t pk[]: output byte array
 *              - const polyveck *b: polynomial vector of length K containg b
 *              - const uint8_t seed[]: seed for A'
 **************************************************/
void pack_pk(uint8_t pk[CRYPTO_PUBLICKEYBYTES], polyveck *b,
             const uint8_t seed[SEEDBYTES]) {
    unsigned int i;

    memcpy(pk, seed, SEEDBYTES);

    pk += SEEDBYTES;
    for (i = 0; i < K; ++i) {
        polyq_pack(pk + i * POLYQ_PACKEDBYTES, &b->vec[i]);
    }
}

/*************************************************
 * Name:        unpack_pk
 *
 * Description: Unpack public key pk = (seed, b).
 *
 * Arguments:   - uint8_t seed[]: seed for A'
 *              - polyveck *b: polynomial vector of length K containg b
 *              - const uint8_t pk[]: output byte array
 **************************************************/
void unpack_pk(polyveck *b, uint8_t seed[SEEDBYTES],
               const uint8_t pk[CRYPTO_PUBLICKEYBYTES]) {
    unsigned int i;

    memcpy(seed, pk, SEEDBYTES);

    pk += SEEDBYTES;
    for (i = 0; i < K; ++i) {
        polyq_unpack(&b->vec[i], pk + i * POLYQ_PACKEDBYTES);
    }
}

/*************************************************
 * Name:        pack_sk
 *
 * Description: Bit-pack secret key sk = (pk, s).
 *
 * Arguments:   - uint8_t sk[]: output byte array
 *              - const uint8_t pk[PUBLICKEYBYTES]: packed pk
 *              - const polyvecl *s0: polyvecl pointer containing s0 (encoding
 *starting at offset 1)
 *              - const polyveck *s1: polyveck pointer containing s1
 **************************************************/
void pack_sk(uint8_t sk[CRYPTO_SECRETKEYBYTES],
             const uint8_t pk[CRYPTO_PUBLICKEYBYTES], const polyvecm *s0,
             const polyveck *s1, const uint8_t key[SEEDBYTES]) {
    unsigned int i;
    memcpy(sk, pk, CRYPTO_PUBLICKEYBYTES);

    sk += CRYPTO_PUBLICKEYBYTES;
    for (i = 0; i < M; ++i)
        polyeta_pack(sk + i * POLYETA_PACKEDBYTES, &s0->vec[i]);

    sk += (L - 1) * POLYETA_PACKEDBYTES;
#if D == 1
    for (i = 0; i < K; ++i)
        poly2eta_pack(sk + i * POLY2ETA_PACKEDBYTES, &s1->vec[i]);
    sk += K * POLY2ETA_PACKEDBYTES;
#elif D == 0
    for (i = 0; i < K; ++i)
        polyeta_pack(sk + i * POLYETA_PACKEDBYTES, &s1->vec[i]);
    sk += K * POLYETA_PACKEDBYTES;
#else
#error "Not yet implemented."
#endif
    memcpy(sk, key, SEEDBYTES);
}

/*************************************************
 * Name:        unpack_sk
 *
 * Description: Unpack secret key sk = (A, s).
 *
 * Arguments:   - polyvecl A[K]: output polyvecl array for A
 *              - polyvecl s0: output polyvecl pointer for s0
 *              - polyveck s1: output polyveck pointer for s1
 *              - const uint8_t sk[]: byte array containing bit-packed sk
 **************************************************/
void unpack_sk(polyvecl_frozen A[K], polyvecm *s0, polyveck *s1, uint8_t *key,
               const uint8_t sk[CRYPTO_SECRETKEYBYTES]) {
    unsigned int i;


#ifdef ENABLE_SIGNATURE_MATRIX_BUFFER
    // Expand matrix A, if buffer is enabled. Otherwise
    // the matrix elements will be computed (repeatedly)
    // on demand.
    for (size_t row = 0; row < K; row++)
        for (size_t column = 0; column < L; column++)
            expand_pk_matrix_elem_frozen(&A[row].vec[column], row, column, sk);
#else
    // TODO: Remove A[K] from the unpack_sk() signature, if A[K] is not bufferd
    {
        // This block is introduced only to avoid the compiler warning
        // that A[K] is not being used if ENABLE_SIGNATURE_MATRIX_BUFFER
        // is not defined. Beware, in this case A[0] points to 
        // the start of the secret key. See initialization in
        // crypto_sign_signature()
        int32_t dummy;
        dummy = A[K].vec[0].coeffs[0];
        A[K].vec[0].coeffs[0] = dummy;
    }
#endif  /* ENABLE_SIGNATURE_MATRIX_BUFFER */

    sk += CRYPTO_PUBLICKEYBYTES;
    for (i = 0; i < M; ++i)
        polyeta_unpack(&s0->vec[i], sk + i * POLYETA_PACKEDBYTES);

    sk += M * POLYETA_PACKEDBYTES;
#if D == 1
    for (i = 0; i < K; ++i)
        poly2eta_unpack(&s1->vec[i], sk + i * POLY2ETA_PACKEDBYTES);

    sk += K * POLY2ETA_PACKEDBYTES;
#elif D == 0
    for (i = 0; i < K; ++i)
        polyeta_unpack(&s1->vec[i], sk + i * POLYETA_PACKEDBYTES);

    sk += K * POLYETA_PACKEDBYTES;
#else
#error "Not yet implemented."
#endif
    memcpy(key, sk, SEEDBYTES);

}

/*************************************************
 * Name:        pack_sig
 *
 * Description: Bit-pack signature sig = (c, LB(z1), len(x), x= Enc(HB(z1)),
 *Enc(h)).
 *
 * Arguments:   - uint8_t sig[]: output byte array
 *              - const poly *c: pointer to challenge polynomial
 *              - const polyvecl *lowbits_z1: pointer to vector LowBits(z1) of
 *                length L
 *              - const polyvecl *highbits_z1: pointer to vector HighBits(z1) of
 *                length L
 *              - const polyveck *h: pointer t vector h of length K
 * Returns 1 in case the signature size is above the threshold; otherwise 0.
 **************************************************/
int pack_sig(uint8_t sig[CRYPTO_BYTES], const poly *c,
             const polyvecl *lowbits_z1, const polyvecl *highbits_z1,
             const polyveck *h) {

    uint8_t encoded_h[N * K];
    uint8_t encoded_hb_z1[N * L];
    uint16_t size_enc_h, size_enc_hb_z1;
    uint8_t offset_enc_h, offset_enc_hb_z1;

    // init/padding with zeros:
    memset(sig, 0, CRYPTO_BYTES);
    
    // encode challenge
    for (size_t i = 0; i < N; i++)
    {
      sig[i/8] |= c->coeffs[i] << (i%8);
    }
    sig += N / 8;

    for (int i = 0; i < L; ++i)
        poly_decomposed_pack(sig + N * i, &lowbits_z1->vec[i]);
    sig += L * N;

    size_enc_hb_z1 =
        encode_hb_z1(encoded_hb_z1, &highbits_z1->vec[0].coeffs[0]);
    size_enc_h = encode_h(encoded_h, &h->vec[0].coeffs[0]);

    if(size_enc_h == 0 || size_enc_hb_z1 == 0) {
        return 1; // encoding failed
    }

    // The size of the encoded h and HB(z1) does not always fit in one byte,
    // thus we output a one byte offset to a fixed baseline
    if(size_enc_h < BASE_ENC_H || size_enc_hb_z1 < BASE_ENC_HB_Z1 ||
        size_enc_h > BASE_ENC_H + 255 || size_enc_hb_z1 > BASE_ENC_HB_Z1 + 255) {
            return 1; // encoding size offset out of range
        }
    
    offset_enc_hb_z1 = size_enc_hb_z1 - BASE_ENC_HB_Z1;
    offset_enc_h = size_enc_h - BASE_ENC_H;

    if (SEEDBYTES + L * N + 2 + size_enc_hb_z1 + size_enc_h >
        CRYPTO_BYTES) {
        return 1; // signature too big     
    }

    sig[0] = offset_enc_hb_z1;
    sig[1] = offset_enc_h;
    sig += 2;

    memcpy(sig, encoded_hb_z1, size_enc_hb_z1);
    sig += size_enc_hb_z1;

    memcpy(sig, encoded_h, size_enc_h);
    sig += size_enc_h;
  
    return 0;
}

/*************************************************
 * Name:        unpack_sig
 *
 * Description: Unpack signature sig = (c, LB(z1), len(x), x= Enc(HB(z1)),
 *Enc(h)).
 *
 * Arguments:   - poly *c: pointer to output challenge polynomial
 *              - polyvecl *lowbits_z1: pointer to output vector LowBits(z1)
 *              - polyvecl *highbits_z1: pointer to output vector HighBits(z1)
 *              - polyveck *h: pointer to output vector h
 *              - const uint8_t sig[]: byte array containing
 *                bit-packed signature
 *
 * Returns 1 in case of malformed signature; otherwise 0.
 **************************************************/
int unpack_sig(poly *c, polyvecl *lowbits_z1,
               polyvecl *highbits_z1, polyveck *h,
               const uint8_t sig[CRYPTO_BYTES]) {

    uint16_t size_enc_hb_z1, size_enc_h;

    // decode challenge
    for (size_t i = 0; i < N; i++)
    {
      c->coeffs[i] = (sig[i/8] >> (i%8)) & 1;
    }
    sig += N / 8;

    for (unsigned int i = 0; i < L; ++i)
        poly_decomposed_unpack(&lowbits_z1->vec[i], sig + N * i);
    sig += L * N;

    size_enc_hb_z1 = (uint16_t)sig[0] + BASE_ENC_HB_Z1;
    size_enc_h = (uint16_t)sig[1] + BASE_ENC_H;
    sig += 2;

    if(CRYPTO_BYTES < (2 + L*N + SEEDBYTES + size_enc_h + size_enc_hb_z1))
        return 1; // invalid size_enc_h and/or size_enc_hb_z1

    if(decode_hb_z1(&highbits_z1->vec[0].coeffs[0], sig, size_enc_hb_z1)) {
        return 1; // decoding failed
    }
        
    sig += size_enc_hb_z1;

    if(decode_h(&h->vec[0].coeffs[0], sig, size_enc_h)) {
        return 1; // decoding failed
    }
        
    sig += size_enc_h;

    for(int i=0; i < CRYPTO_BYTES - (SEEDBYTES + L * N + 2 + size_enc_hb_z1 + size_enc_h); i++)
        if(sig[i] != 0) return 1; // verify zero padding

    return 0;
}
