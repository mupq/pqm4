#include "api.h"
#include "cpapke.h"
#include "fips202.h"
#include "poly.h"
#include "randombytes.h"
#include <stdio.h>
#include <string.h>


/*************************************************
* Name:        encode_pk
*
* Description: Serialize the public key as concatenation of the
*              serialization of the polynomial pk and the public seed
*              used to generete the polynomial a.
*
* Arguments:   unsigned char *r:          pointer to the output serialized public key
*              const poly *pk:            pointer to the input public-key polynomial
*              const unsigned char *seed: pointer to the input public seed
**************************************************/
static void encode_pk(unsigned char *r, const poly *pk, const unsigned char *seed) {
  poly_tobytes(r, pk);
  memcpy(r+NEWHOPE_POLYBYTES, seed, NEWHOPE_SYMBYTES);
}

/*************************************************
* Name:        cpapke_keypair
*
* Description: Generates public and private key
*              for the CPA public-key encryption scheme underlying
*              the NewHope KEMs
*
* Arguments:   - unsigned char *pk: pointer to output public key
*              - unsigned char *sk: pointer to output private key
**************************************************/
void cpapke_keypair(unsigned char *pk,
                    unsigned char *sk)
{
  poly shat;
  unsigned char z[2*NEWHOPE_SYMBYTES];
  unsigned char *publicseed = z;
  unsigned char *noiseseed = z+NEWHOPE_SYMBYTES;

  randombytes(z, NEWHOPE_SYMBYTES);
  shake256(z, 2*NEWHOPE_SYMBYTES, z, NEWHOPE_SYMBYTES);

  poly_getnoise(&shat, noiseseed, 0);
  poly_ntt(&shat);
  poly_tobytes(sk, &shat);

  poly_uniform_mul_s(&shat, publicseed);
#ifdef OPTIMIZE_STACK 
  poly_invntt(&shat);

  poly_addnoise(&shat, noiseseed, 1);
  poly_ntt(&shat);
#else
  poly ehat;
  poly_getnoise(&ehat, noiseseed, 1);
  poly_ntt(&ehat);
  poly_add(&shat,&ehat);
#endif   
  encode_pk(pk, &shat, publicseed);
}

/*************************************************
* Name:        cpapke_enc
*
* Description: Encryption function of
*              the CPA public-key encryption scheme underlying
*              the NewHope KEMs
*
* Arguments:   - unsigned char *c:          pointer to output ciphertext
*              - const unsigned char *m:    pointer to input message (of length NEWHOPE_SYMBYTES bytes)
*              - const unsigned char *pk:   pointer to input public key
*              - const unsigned char *coin: pointer to input random coins used as seed
*                                           to deterministically generate all randomness
**************************************************/
void cpapke_enc(unsigned char *c,
                const unsigned char *m,
                const unsigned char *pk,
                const unsigned char *coin)
{
  poly sprime, vprime;
  poly *eprime = &vprime;
  poly *uhat = &vprime;
  unsigned char publicseed[NEWHOPE_SYMBYTES];

  poly_getnoise(&sprime, coin, 0);
  poly_ntt(&sprime);

  poly_frombytes(&vprime,pk);
  poly_mul_pointwise(&vprime, &sprime);
  poly_invntt(&vprime);
  poly_bitrev(&vprime);
  poly_addnoise(&vprime, coin, 2);

  poly_frommsg(&vprime, m); // add message
  poly_reduce(&vprime);
  poly_compress(c+NEWHOPE_POLYBYTES,&vprime);

  poly_getnoise(eprime, coin, 1);
  poly_ntt(eprime);

  memcpy(publicseed,pk+NEWHOPE_POLYBYTES,NEWHOPE_SYMBYTES);
  poly_uniform_mul_s(&sprime, publicseed);
  poly_add(eprime, &sprime);

  poly_tobytes(c, uhat);
}

/*************************************************
* Name:        cpapke_dec
*
* Description: Decryption function of
*              the CPA public-key encryption scheme underlying
*              the NewHope KEMs
*
* Arguments:   - unsigned char *m:        pointer to output decrypted message
*              - const unsigned char *c:  pointer to input ciphertext
*              - const unsigned char *sk: pointer to input secret key
**************************************************/
void __attribute__ ((noinline)) cpapke_dec(unsigned char *m,
                                           const unsigned char *c,
                                           const unsigned char *sk)
{
  poly tmp;

  poly_frombytes_mul(&tmp, sk, c);
  poly_invntt(&tmp);
  poly_bitrev(&tmp);

  poly_decompress_sub(&tmp, c+NEWHOPE_POLYBYTES);
  poly_tomsg(m, &tmp);
}
