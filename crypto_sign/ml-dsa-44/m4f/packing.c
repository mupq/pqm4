#include "params.h"
#include "packing.h"
#include "polyvec.h"
#include "poly.h"
#include <stddef.h>

/*************************************************
* Name:        pack_pk
*
* Description: Bit-pack public key pk = (rho, t1).
*
* Arguments:   - uint8_t pk[]: output byte array
*              - const uint8_t rho[]: byte array containing rho
*              - const polyveck *t1: pointer to vector t1
**************************************************/
void pack_pk(uint8_t pk[CRYPTO_PUBLICKEYBYTES],
             const uint8_t rho[SEEDBYTES],
             const polyveck *t1)
{
  unsigned int i;

  for(i = 0; i < SEEDBYTES; ++i)
    pk[i] = rho[i];
  pk += SEEDBYTES;

  for(i = 0; i < K; ++i)
    polyt1_pack(pk + i*POLYT1_PACKEDBYTES, &t1->vec[i]);
}

/*************************************************
* Name:        unpack_pk
*
* Description: Unpack public key pk = (rho, t1).
*
* Arguments:   - const uint8_t rho[]: output byte array for rho
*              - const polyveck *t1: pointer to output vector t1
*              - uint8_t pk[]: byte array containing bit-packed pk
**************************************************/
void unpack_pk(uint8_t rho[SEEDBYTES],
               polyveck *t1,
               const uint8_t pk[CRYPTO_PUBLICKEYBYTES])
{
  unsigned int i;

  for(i = 0; i < SEEDBYTES; ++i)
    rho[i] = pk[i];
  pk += SEEDBYTES;

  for(i = 0; i < K; ++i)
    polyt1_unpack(&t1->vec[i], pk + i*POLYT1_PACKEDBYTES);
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
* Name:        pack_sk
*
* Description: Bit-pack secret key sk = (rho, tr, key, t0, s1, s2).
*
* Arguments:   - uint8_t sk[]: output byte array
*              - const uint8_t rho[]: byte array containing rho
*              - const uint8_t tr[]: byte array containing tr
*              - const uint8_t key[]: byte array containing key
*              - const polyveck *t0: pointer to vector t0
*              - const polyvecl *s1: pointer to vector s1
*              - const polyveck *s2: pointer to vector s2
**************************************************/
void pack_sk(uint8_t sk[CRYPTO_SECRETKEYBYTES],
             const uint8_t rho[SEEDBYTES],
             const uint8_t tr[TRBYTES],
             const uint8_t key[SEEDBYTES],
             const polyveck *t0,
             const polyvecl *s1,
             const polyveck *s2)
{
  unsigned int i;

  for(i = 0; i < SEEDBYTES; ++i)
    sk[i] = rho[i];
  sk += SEEDBYTES;

  for(i = 0; i < SEEDBYTES; ++i)
    sk[i] = key[i];
  sk += SEEDBYTES;

  for(i = 0; i < TRBYTES; ++i)
    sk[i] = tr[i];
  sk += TRBYTES;

  for(i = 0; i < L; ++i)
    polyeta_pack(sk + i*POLYETA_PACKEDBYTES, &s1->vec[i]);
  sk += L*POLYETA_PACKEDBYTES;

  for(i = 0; i < K; ++i)
    polyeta_pack(sk + i*POLYETA_PACKEDBYTES, &s2->vec[i]);
  sk += K*POLYETA_PACKEDBYTES;

  for(i = 0; i < K; ++i)
    polyt0_pack(sk + i*POLYT0_PACKEDBYTES, &t0->vec[i]);
}

/*************************************************
* Name:        unpack_sk
*
* Description: Unpack secret key sk = (rho, tr, key, t0, s1, s2).
*
* Arguments:   - const uint8_t rho[]: output byte array for rho
*              - const uint8_t tr[]: output byte array for tr
*              - const uint8_t key[]: output byte array for key
*              - const polyveck *t0: pointer to output vector t0
*              - const polyvecl *s1: pointer to output vector s1
*              - const polyveck *s2: pointer to output vector s2
*              - uint8_t sk[]: byte array containing bit-packed sk
**************************************************/
void unpack_sk(uint8_t rho[SEEDBYTES],
               uint8_t tr[TRBYTES],
               uint8_t key[SEEDBYTES],
               polyveck *t0,
               smallpoly s1[L],
               smallpoly s2[K],
               const uint8_t sk[CRYPTO_SECRETKEYBYTES])
{
  unsigned int i;

  for(i = 0; i < SEEDBYTES; ++i)
    rho[i] = sk[i];
  sk += SEEDBYTES;

  for(i = 0; i < SEEDBYTES; ++i)
    key[i] = sk[i];
  sk += SEEDBYTES;

  for(i = 0; i < TRBYTES; ++i)
    tr[i] = sk[i];
  sk += TRBYTES;

  for(i=0; i < L; ++i)
    small_polyeta_unpack(&s1[i], sk + i*POLYETA_PACKEDBYTES);
  sk += L*POLYETA_PACKEDBYTES;

  for(i=0; i < K; ++i)
    small_polyeta_unpack(&s2[i], sk + i*POLYETA_PACKEDBYTES);
  sk += K*POLYETA_PACKEDBYTES;

  for(i=0; i < K; ++i)
    polyt0_unpack(&t0->vec[i], sk + i*POLYT0_PACKEDBYTES);
}


/*************************************************
* Name:        pack_sig
*
* Description: Bit-pack signature sig = (c, z, h).
*
* Arguments:   - uint8_t sig[]: output byte array
*              - const uint8_t *c: pointer to challenge hash length SEEDBYTES
*              - const polyvecl *z: pointer to vector z
*              - const polyveck *h: pointer to hint vector h
**************************************************/
void pack_sig(uint8_t sig[CRYPTO_BYTES],
              const uint8_t c[CTILDEBYTES],
              const polyvecl *z,
              const polyveck *h)
{
  unsigned int i, j, k;

  for(i=0; i < CTILDEBYTES; ++i)
    sig[i] = c[i];
  sig += CTILDEBYTES;

  for(i = 0; i < L; ++i)
    polyz_pack(sig + i*POLYZ_PACKEDBYTES, &z->vec[i]);
  sig += L*POLYZ_PACKEDBYTES;

  /* Encode h */
  for(i = 0; i < OMEGA + K; ++i)
    sig[i] = 0;

  k = 0;
  for(i = 0; i < K; ++i) {
    for(j = 0; j < N; ++j)
      if(h->vec[i].coeffs[j] != 0)
        sig[k++] = j;

    sig[OMEGA + i] = k;
  }
}

void pack_sig_c(uint8_t sig[CRYPTO_BYTES],
              const uint8_t c[CTILDEBYTES])
{
  unsigned int i;

  for(i=0; i < CTILDEBYTES; ++i)
    sig[i] = c[i];
  sig += CTILDEBYTES;
}

void pack_sig_z(uint8_t sig[CRYPTO_BYTES],
              const polyvecl *z)
{
  unsigned int i;
  sig += CTILDEBYTES;
  for(i = 0; i < L; ++i)
    polyz_pack(sig + i*POLYZ_PACKEDBYTES, &z->vec[i]);
}


void pack_sig_h(unsigned char sig[CRYPTO_BYTES],
                const poly *h_elem,
                const unsigned int idx,
                unsigned int *hints_written)
{
  sig += CTILDEBYTES;
  sig += L*POLYZ_PACKEDBYTES;

  // Encode h
  for (unsigned int j = 0; j < N; j++) {
      if (h_elem->coeffs[j] != 0) {
          sig[*hints_written] = (uint8_t)j;
          (*hints_written)++;
      }
  }
  sig[OMEGA + idx] = (uint8_t)*hints_written;
}

void pack_sig_h_zero(unsigned char sig[CRYPTO_BYTES],
                unsigned int *hints_written) {
    sig += CTILDEBYTES;
    sig += L * POLYZ_PACKEDBYTES;
    while (*hints_written < OMEGA) {
        sig[*hints_written] = 0;
        (*hints_written)++;
    }
}

/*************************************************
* Name:        unpack_sig
*
* Description: Unpack signature sig = (c, z, h).
*
* Arguments:   - uint8_t *c: pointer to output challenge hash
*              - polyvecl *z: pointer to output vector z
*              - polyveck *h: pointer to output hint vector h
*              - const uint8_t sig[]: byte array containing
*                bit-packed signature
*
* Returns 1 in case of malformed signature; otherwise 0.
**************************************************/
int unpack_sig(uint8_t c[CTILDEBYTES],
               polyvecl *z,
               polyveck *h,
               const uint8_t sig[CRYPTO_BYTES])
{
  unsigned int i, j, k;

  for(i = 0; i < CTILDEBYTES; ++i)
    c[i] = sig[i];
  sig += CTILDEBYTES;

  for(i = 0; i < L; ++i)
    polyz_unpack(&z->vec[i], sig + i*POLYZ_PACKEDBYTES);
  sig += L*POLYZ_PACKEDBYTES;

  /* Decode h */
  k = 0;
  for(i = 0; i < K; ++i) {
    for(j = 0; j < N; ++j)
      h->vec[i].coeffs[j] = 0;

    if(sig[OMEGA + i] < k || sig[OMEGA + i] > OMEGA)
      return 1;

    for(j = k; j < sig[OMEGA + i]; ++j) {
      /* Coefficients are ordered for strong unforgeability */
      if(j > k && sig[j] <= sig[j-1]) return 1;
      h->vec[i].coeffs[sig[j]] = 1;
    }

    k = sig[OMEGA + i];
  }

  /* Extra indices are zero for strong unforgeability */
  for(j = k; j < OMEGA; ++j)
    if(sig[j])
      return 1;

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
int unpack_sig_c(uint8_t c[CTILDEBYTES], const unsigned char sig[CRYPTO_BYTES]) {
  for(size_t i = 0; i < CTILDEBYTES; ++i)
    c[i] = sig[i];
  sig += CTILDEBYTES;
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
    sig += CTILDEBYTES;
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
    sig += CTILDEBYTES;
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

