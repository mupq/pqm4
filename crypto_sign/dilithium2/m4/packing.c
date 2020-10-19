#include "packing.h"
#include "params.h"
#include "poly.h"
#include "polyvec.h"

/*************************************************
* Name:        pack_pk
*
* Description: Bit-pack public key pk = (rho, t1).
*
* Arguments:   - unsigned char pk[]: output byte array
*              - const unsigned char rho[]: byte array containing rho
*              - const polyveck *t1: pointer to vector t1
**************************************************/
void pack_pk(unsigned char pk[CRYPTO_PUBLICKEYBYTES],
                                      const unsigned char rho[SEEDBYTES],
                                      const polyveck *t1) {
    unsigned int i;

    pack_pk_rho(pk, rho);
    for (i = 0; i < K; ++i) {
        pack_pk_t1(pk, &t1->vec[i], i);
    }
}

/*************************************************
* Name:        pack_pk_rho
*
* Description: Bit-pack only rho in public key pk = (rho, t1).
*
* Arguments:   - unsigned char pk[]: output byte array
*              - const unsigned char rho[]: byte array containing rho
**************************************************/
void pack_pk_rho(unsigned char pk[CRYPTO_PUBLICKEYBYTES],
                 const unsigned char rho[SEEDBYTES]) {
    for (size_t i = 0; i < SEEDBYTES; ++i) {
        pk[i] = rho[i];
    }
}

/*************************************************
* Name:        pack_pk_t1
*
* Description: Bit-pack only the t1 elem at idx in public key pk = (rho, t1).
*
* Arguments:   - unsigned char pk[]: output byte array
*              - const polyveck *t1: pointer to vector t1
*              - const size_t idx: index to the elem to pack
**************************************************/
void pack_pk_t1(unsigned char pk[CRYPTO_PUBLICKEYBYTES],
             const poly *t1,
             const size_t idx) {
    pk += SEEDBYTES;
    polyt1_pack(pk + idx * POLYT1_PACKEDBYTES, t1);
}

/*************************************************
* Name:        unpack_pk
*
* Description: Unpack public key pk = (rho, t1).
*
* Arguments:   - const unsigned char rho[]: output byte array for rho
*              - const polyveck *t1: pointer to output vector t1
*              - unsigned char pk[]: byte array containing bit-packed pk
**************************************************/
void unpack_pk(unsigned char rho[SEEDBYTES],
                                        polyveck *t1,
                                        const unsigned char pk[CRYPTO_PUBLICKEYBYTES]) {
    unsigned int i;

    for (i = 0; i < SEEDBYTES; ++i) {
        rho[i] = pk[i];
    }
    pk += SEEDBYTES;

    for (i = 0; i < K; ++i) {
        polyt1_unpack(&t1->vec[i], pk + i * POLYT1_PACKEDBYTES);
    }
}

/*************************************************
* Name:        getoffset_pk_rho
*
* Description: Unpack only rho from public key pk = (rho, t1).
*
* Arguments:   - const unsigned char *rho: pointer to rho inside of pk
*              - unsigned char pk[]: byte array containing bit-packed pk
*
* The lifetime of rho MUST NOT exceed the lifetime of pk!
**************************************************/
const unsigned char *getoffset_pk_rho(const unsigned char pk[CRYPTO_PUBLICKEYBYTES]) {
    return pk;
}

/*************************************************
* Name:        unpack_pk_t1
*
* Description: Unpack public key pk = (rho, t1).
*
* Arguments:   - const polyvec *t1: pointer to output vector t1
*              - const size_t idx: unpack n'th element from t1
*              - unsigned char pk[]: byte array containing bit-packed pk
**************************************************/
void unpack_pk_t1(poly *t1, size_t idx, const unsigned char pk[CRYPTO_PUBLICKEYBYTES]) {
    pk += SEEDBYTES;
    polyt1_unpack(t1, pk + idx * POLYT1_PACKEDBYTES);
}

/*************************************************
* Name:        pack_sk_rho
*
* Description: Bit-pack only rho in secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: output byte array
*              - const unsigned char rho[]: byte array containing rho
**************************************************/
void pack_sk_rho(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                 const unsigned char rho[SEEDBYTES]) {
    for (size_t i = 0; i < SEEDBYTES; ++i) {
        sk[i] = rho[i];
    }
}

/*************************************************
* Name:        pack_sk_key
*
* Description: Bit-pack only key in secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: output byte array
*              - const unsigned char key[]: byte array containing key
**************************************************/
void pack_sk_key(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                 const unsigned char key[SEEDBYTES]) {
    sk += SEEDBYTES;
    for (size_t i = 0; i < SEEDBYTES; ++i) {
        sk[i] = key[i];
    }
}

/*************************************************
* Name:        pack_sk_tr
*
* Description: Bit-pack only tr in secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: output byte array
*              - const unsigned char tr[]: byte array containing tr
**************************************************/
void pack_sk_tr(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const unsigned char tr[SEEDBYTES]) {
    sk += 2*SEEDBYTES;
    for (size_t i = 0; i < CRHBYTES; ++i) {
        sk[i] = tr[i];
    }
}

/*************************************************
* Name:        pack_sk_s1
*
* Description: Bit-pack only some element of s1 in secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: output byte array
*              - const poly *s1_elem: pointer to vector element idx in s1
*              - const size_t idx: index to the element of s1 that should be packed
**************************************************/
void pack_sk_s1(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *s1_elem,
                const size_t idx) {
    sk += 2*SEEDBYTES + CRHBYTES;
    polyeta_pack(sk + idx * POLYETA_PACKEDBYTES, s1_elem);
}

/*************************************************
* Name:        pack_sk_s2
*
* Description: Bit-pack only some element of s2 in secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: output byte array
*              - const poly *s2_elem: pointer to vector element idx in s2
*              - const size_t idx: index to the element of s1 that should be packed
**************************************************/
void pack_sk_s2(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *s2_elem,
                const size_t idx) {
    sk += 2*SEEDBYTES + CRHBYTES + L * POLYETA_PACKEDBYTES;
    polyeta_pack(sk + idx * POLYETA_PACKEDBYTES, s2_elem);
}

/*************************************************
* Name:        pack_sk_t0
*
* Description: Bit-pack only some element of t0 in secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: output byte array
*              - const poly *t0_elem: pointer to vector element idx in s2
*              - const size_t idx: index to the element of s1 that should be packed
**************************************************/
void pack_sk_t0(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *t0_elem,
                const size_t idx) {
    sk += 2*SEEDBYTES + CRHBYTES + (L + K) * POLYETA_PACKEDBYTES;
    polyt0_pack(sk + idx * POLYT0_PACKEDBYTES, t0_elem);
}

/*************************************************
* Name:        unpack_sk
*
* Description: Unpack secret key sk = (rho, key, tr, s1, s2, t0
 from ).
*
* Arguments:   - const unsigned char rho[]: output byte array for rho
*              - const unsigned char key[]: output byte array for key
*              - const unsigned char tr[]: output byte array for tr
*              - const polyvecl *s1: pointer to output vector s1
*              - const polyveck *s2: pointer to output vector s2
*              - const polyveck *r0: pointer to output vector t0
*              - unsigned char sk[]: byte array containing bit-packed sk
**************************************************/
void unpack_sk(unsigned char rho[SEEDBYTES],
                                        unsigned char key[SEEDBYTES],
                                        unsigned char tr[CRHBYTES],
                                        polyvecl *s1,
                                        polyveck *s2,
                                        polyveck *t0,
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES]) {

    unpack_sk_rho(rho, sk);
    unpack_sk_key(key, sk);
    unpack_sk_tr(tr, sk);
    for (size_t i = 0; i < L; i++) {
        unpack_sk_s1(&s1->vec[i], sk, i);
    }
    for (size_t i = 0; i < K; i++) {   
        unpack_sk_s2(&s2->vec[i], sk, i);
    }
    for (size_t i = 0; i < K; i++) {   
        unpack_sk_t0(&t0->vec[i], sk, i); 
    }
}

/*************************************************
* Name:        unpack_sk_rho
*
* Description: Unpack rho from secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - const unsigned char rho[]: output byte array for rho
*              - unsigned char sk[]: byte array containing bit-packed sk
**************************************************/
void unpack_sk_rho(unsigned char rho[SEEDBYTES],
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES]) {
    for (size_t i = 0; i < SEEDBYTES; ++i) {
        rho[i] = sk[i];
    }
}

/*************************************************
* Name:        getoffset_sk_rho
*
* Description: Unpack rho from secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: byte array containing bit-packed sk
**************************************************/
const uint8_t *getoffset_sk_rho(const unsigned char sk[CRYPTO_SECRETKEYBYTES]) {
    return sk;
}

/*************************************************
* Name:        unpack_sk_key
*
* Description: Unpack key from secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - const unsigned char key[]: output byte array for key
*              - unsigned char sk[]: byte array containing bit-packed sk
**************************************************/
void unpack_sk_key(unsigned char key[SEEDBYTES],
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES]) {
    sk += SEEDBYTES;
    for (size_t i = 0; i < SEEDBYTES; ++i) {
        key[i] = sk[i];
    }
}

/*************************************************
* Name:        getoffset_sk_key
*
* Description: Unpack key from secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: byte array containing bit-packed sk
**************************************************/
const uint8_t *getoffset_sk_key(const unsigned char sk[CRYPTO_SECRETKEYBYTES]) {
    sk += SEEDBYTES;
    return sk;
}

/*************************************************
* Name:        unpack_sk_tr
*
* Description: Unpack tr from secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - const unsigned char tr[]: output byte array for tr
*              - unsigned char sk[]: byte array containing bit-packed sk
**************************************************/
void unpack_sk_tr(unsigned char tr[CRHBYTES],
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES]) {
    sk += 2 * SEEDBYTES;
    for (size_t i = 0; i < CRHBYTES; ++i) {
        tr[i] = sk[i];
    }
}

/*************************************************
* Name:        getoffset_sk_tr
*
* Description: Unpack tr from secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: byte array containing bit-packed sk
**************************************************/
const uint8_t *getoffset_sk_tr(const unsigned char sk[CRYPTO_SECRETKEYBYTES]) {
    sk += 2 * SEEDBYTES;
    return sk;
}

/*************************************************
* Name:        unpack_sk_s1
*
* Description: Unpack s1 from secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - const polyvecl *s1: pointer to output vector s1
*              - unsigned char sk[]: byte array containing bit-packed sk
**************************************************/
void unpack_sk_s1(poly *s1_elem,
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES],
                                        const size_t idx) {
    sk += 2 * SEEDBYTES + CRHBYTES;
    polyeta_unpack(s1_elem, sk + idx * POLYETA_PACKEDBYTES);
}
\
/*************************************************
* Name:        unpack_sk_s2
*
* Description: Unpack s2 from secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - const polyveck *s2: pointer to output vector s2
*              - unsigned char sk[]: byte array containing bit-packed sk
**************************************************/
void unpack_sk_s2(poly *s2_elem,
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES],
                                        const size_t idx) {
    sk += 2 * SEEDBYTES + CRHBYTES + L * POLYETA_PACKEDBYTES;
    polyeta_unpack(s2_elem, sk + idx * POLYETA_PACKEDBYTES);
}

/*************************************************
* Name:        unpack_sk_t0
*
* Description: Unpack t0 from secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - const polyveck *t0: pointer to output vector t0
*              - unsigned char sk[]: byte array containing bit-packed sk
**************************************************/
void unpack_sk_t0(poly *t0_elem,
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES],
                                        const size_t idx) {
    sk += 2 * SEEDBYTES + CRHBYTES + (L + K) * POLYETA_PACKEDBYTES;
    polyt0_unpack(t0_elem, sk + idx * POLYT0_PACKEDBYTES);
}

/*************************************************
* Name:        pack_sig
*
* Description: Bit-pack signature sig = (z, h, c).
*
* Arguments:   - unsigned char sig[]: output byte array
*              - const polyvecl *z: pointer to vector z
*              - const polyveck *h: pointer to hint vector h
*              - const poly *c: pointer to challenge polynomial
**************************************************/
void pack_sig(unsigned char sig[CRYPTO_BYTES],
                                       const polyvecl *z,
                                       const polyveck *h,
                                       const poly *c) {
    unsigned int i, j, k;
    uint64_t signs, mask;

    for (i = 0; i < L; ++i) {
        polyz_pack(sig + i * POLYZ_PACKEDBYTES, &z->vec[i]);
    }
    sig += L * POLYZ_PACKEDBYTES;

    /* Encode h */
    k = 0;
    for (i = 0; i < K; ++i) {
        for (j = 0; j < N; ++j) {
            if (h->vec[i].coeffs[j] != 0) {
                sig[k++] = (unsigned char) j;
            }
        }
        sig[OMEGA + i] = (unsigned char) k;
    }
    while (k < OMEGA) {
        sig[k++] = 0;
    }
    sig += OMEGA + K;

    /* Encode c */
    signs = 0;
    mask = 1;
    for (i = 0; i < N / 8; ++i) {
        sig[i] = 0;
        for (j = 0; j < 8; ++j) {
            if (c->coeffs[8 * i + j] != 0) {
                sig[i] |= (unsigned char) (1U << j);
                if (c->coeffs[8 * i + j] == (Q - 1)) {
                    signs |= mask;
                }
                mask <<= 1;
            }
        }
    }
    sig += N / 8;
    for (i = 0; i < 8; ++i) {
        sig[i] = (unsigned char) (signs >> 8 * i);
    }
}

/*************************************************
* Name:        pack_sig_z
*
* Description: Bit-pack z element idx in signature sig = (z, h, c).
*
* Arguments:   - unsigned char sig[]: output byte array
*              - const poly *z_elem: pointer to poly from vector z
*              - const size_t idx: index of z element to pack into sig
**************************************************/
void pack_sig_z(unsigned char sig[CRYPTO_BYTES],
                const poly *z_elem,
                const size_t idx) {
    polyz_pack(sig + idx * POLYZ_PACKEDBYTES, z_elem);
}

/*************************************************
* Name:        pack_sig_h
*
* Description: Bit-pack h elem at index idx in signature sig = (z, h, c).
*
* Arguments:   - unsigned char sig[]: output byte array
*              - const poly *h_elem: pointer to hint vector elem in h
*              - const size_t idx: index of the poly element in h
*              - size_t *hints_written: pointer to counter counting how many hints have been written
**************************************************/
void pack_sig_h(unsigned char sig[CRYPTO_BYTES],
                const poly *h_elem,
                const size_t idx,
                size_t *hints_written) {
    sig += L * POLYZ_PACKEDBYTES;

    // Encode h
    for (size_t j = 0; j < N; j++) {
        if (h_elem->coeffs[j] != 0) {
            sig[*hints_written] = (uint8_t)j;
            (*hints_written)++;
        }
    }
    sig[OMEGA + idx] = (uint8_t)*hints_written;
}

/*************************************************
* Name:        pack_sig_h
*
* Description: Set the rest of h in signature sig = (z, h, c) to zero.
*
* Arguments:   - unsigned char sig[]: output byte array
*              - size_t *hints_written: pointer to counter counting how many hints have been written
**************************************************/
void pack_sig_h_zero(unsigned char sig[CRYPTO_BYTES],
                size_t *hints_written) {
    sig += L * POLYZ_PACKEDBYTES;
    while (*hints_written < OMEGA) {
        sig[*hints_written] = 0;
        (*hints_written)++;
    }
}

/*************************************************
* Name:        pack_sig_c
*
* Description: Bit-pack c in signature sig = (z, h, c).
*
* Arguments:   - unsigned char sig[]: output byte array
*              - const poly *c: pointer to challenge polynomial
**************************************************/
void pack_sig_c(unsigned char sig[CRYPTO_BYTES],
                const poly *c) {
    unsigned int i, j;
    uint64_t signs, mask;

    sig += L * POLYZ_PACKEDBYTES;
    sig += OMEGA + K;

    /* Encode c */
    signs = 0;
    mask = 1;
    for (i = 0; i < N / 8; ++i) {
        sig[i] = 0;
        for (j = 0; j < 8; ++j) {
            if (c->coeffs[8 * i + j] != 0) {
                sig[i] |= (unsigned char) (1U << j);
                if (c->coeffs[8 * i + j] == -1) {
                    signs |= mask;
                }
                mask <<= 1;
            }
        }
    }
    sig += N / 8;
    for (i = 0; i < 8; ++i) {
        sig[i] = (unsigned char) (signs >> 8 * i);
    }
}

/*************************************************
* Name:        unpack_sig
*
* Description: Unpack signature sig = (z, h, c).
*
* Arguments:   - polyvecl *z: pointer to output vector z
*              - polyveck *h: pointer to output hint vector h
*              - poly *c: pointer to output challenge polynomial
*              - const unsigned char sig[]: byte array containing
*                bit-packed signature
*
* Returns 1 in case of malformed signature; otherwise 0.
**************************************************/
int unpack_sig(polyvecl *z,
                                        polyveck *h,
                                        poly *c,
                                        const unsigned char sig[CRYPTO_BYTES]) {
    unsigned int i, j, k;
    uint64_t signs;

    for (i = 0; i < L; ++i) {
        polyz_unpack(&z->vec[i], sig + i * POLYZ_PACKEDBYTES);
    }
    sig += L * POLYZ_PACKEDBYTES;

    /* Decode h */
    k = 0;
    for (i = 0; i < K; ++i) {
        for (j = 0; j < N; ++j) {
            h->vec[i].coeffs[j] = 0;
        }

        if (sig[OMEGA + i] < k || sig[OMEGA + i] > OMEGA) {
            return 1;
        }

        for (j = k; j < sig[OMEGA + i]; ++j) {
            /* Coefficients are ordered for strong unforgeability */
            if (j > k && sig[j] <= sig[j - 1]) {
                return 1;
            }
            h->vec[i].coeffs[sig[j]] = 1;
        }

        k = sig[OMEGA + i];
    }

    /* Extra indices are zero for strong unforgeability */
    for (j = k; j < OMEGA; ++j) {
        if (sig[j]) {
            return 1;
        }
    }
    sig += OMEGA + K;

    /* Decode c */
    for (i = 0; i < N; ++i) {
        c->coeffs[i] = 0;
    }

    signs = 0;
    for (i = 0; i < 8; ++i) {
        signs |= (uint64_t)sig[N / 8 + i] << 8 * i;
    }

    /* Extra sign bits are zero for strong unforgeability */
    if (signs >> 60) {
        return 1;
    }

    for (i = 0; i < N / 8; ++i) {
        for (j = 0; j < 8; ++j) {
            if ((sig[i] >> j) & 0x01) {
                c->coeffs[8 * i + j] = 1;
                c->coeffs[8 * i + j] ^= -((int32_t) signs & 1) & (1 ^ (Q - 1));
                signs >>= 1;
            }
        }
    }

    return 0;
}

/*************************************************
* Name:        unpack_sig_z
*
* Description: Unpack only z from signature sig = (z, h, c).
*
* Arguments:   - polyvecl *z: pointer to output vector z
*              - const unsigned char sig[]: byte array containing
*                bit-packed signature
*
* Returns 1 in case of malformed signature; otherwise 0.
**************************************************/
int unpack_sig_z(polyvecl *z, const unsigned char sig[CRYPTO_BYTES]) {
    for (size_t i = 0; i < L; ++i) {
        polyz_unpack(&z->vec[i], sig + i * POLYZ_PACKEDBYTES);
    }
    return 0;
}

/*************************************************
* Name:        unpack_sig_h
*
* Description: Unpack only h from signature sig = (z, h, c).
*
* Arguments:   - polyveck *h: pointer to output hint vector h
*              - const unsigned char sig[]: byte array containing
*                bit-packed signature
*
* Returns 1 in case of malformed signature; otherwise 0.
**************************************************/
int unpack_sig_h(poly *h, size_t idx, const unsigned char sig[CRYPTO_BYTES]) {
    sig += L * POLYZ_PACKEDBYTES;

    /* Decode h */
    size_t k = 0;
    for (size_t i = 0; i < K; ++i) {
        for (size_t j = 0; j < N; ++j) {
            if (i == idx) {
                h->coeffs[j] = 0;
            }
        }

        if (sig[OMEGA + i] < k || sig[OMEGA + i] > OMEGA) {
            return 1;
        }

        for (size_t j = k; j < sig[OMEGA + i]; ++j) {
            /* Coefficients are ordered for strong unforgeability */
            if (j > k && sig[j] <= sig[j - 1]) {
                return 1;
            }
            if (i == idx) {
                h->coeffs[sig[j]] = 1;
            }
        }

        k = sig[OMEGA + i];
    }

    /* Extra indices are zero for strong unforgeability */
    for (size_t j = k; j < OMEGA; ++j) {
        if (sig[j]) {
            return 1;
        }
    }
    return 0;
}

/*************************************************
* Name:        unpack_sig_c
*
* Description: Unpack only c from signature sig = (z, h, c).
*
* Arguments:   - poly *c: pointer to output challenge polynomial
*              - const unsigned char sig[]: byte array containing
*                bit-packed signature
*
* Returns 1 in case of malformed signature; otherwise 0.
**************************************************/
int unpack_sig_c(poly *c, const unsigned char sig[CRYPTO_BYTES]) {
    sig += L * POLYZ_PACKEDBYTES;
    sig += OMEGA + K;

    /* Decode c */
    for (size_t i = 0; i < N; ++i) {
        c->coeffs[i] = 0;
    }

    uint64_t signs = 0;
    for (size_t i = 0; i < 8; ++i) {
        signs |= (uint64_t)sig[N / 8 + i] << 8 * i;
    }

    /* Extra sign bits are zero for strong unforgeability */
    if (signs >> 60) {
        return 1;
    }

    for (size_t i = 0; i < N / 8; ++i) {
        for (size_t j = 0; j < 8; ++j) {
            if ((sig[i] >> j) & 0x01) {
                c->coeffs[8 * i + j] = 1;
                c->coeffs[8 * i + j] ^= -((int32_t) signs & 1) & (1 ^ (-1));
                signs >>= 1;
            }
        }
    }
    return 0;
}