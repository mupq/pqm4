/*************************************************************************************
* qTESLA: an efficient post-quantum signature scheme based on the R-LWE problem
*
* Abstract: high-level functions of the signature scheme
**************************************************************************************/

#include <string.h>
#include <stdlib.h>
#include "api.h"
#include "params.h"
#include "poly.h"
#include "sample.h"
#include "fips202.h"
#include "randombytes.h"

#ifdef DEBUG
unsigned long long rejwctr;
unsigned long long rejyzctr;
unsigned long long ctr_keygen;
unsigned long long ctr_sign;
#endif


static void pack_sk(unsigned char *sk, poly s, poly e, unsigned char *seeds)
{ // Pack secret key sk
  int i;
  int16_t *isk = (int16_t *)sk;

  for (i=0; i<PARAM_N; i++)
    isk[i] = s[i];

  isk += PARAM_N;
  for (i=0; i<(PARAM_N); i++)
    isk[i] = e[i];
  
  memcpy(&isk[PARAM_N], seeds, 2*CRYPTO_SEEDBYTES);
} 


static void encode_pk(unsigned char *pk, const poly t, const unsigned char *seedA)
{ // Encode public key pk
  unsigned int i, j=0;
  uint32_t *pt = (uint32_t*)pk;
  
  for (i=0; i<(PARAM_N*PARAM_Q_LOG/32); i+=PARAM_Q_LOG) {
    pt[i   ] = t[j] | (t[j+1] << 23);
    pt[i+ 1] = (t[j+ 1] >>  9) | (t[j+ 2] << 14); pt[i+ 2] = (t[j+ 2] >> 18) | (t[j+ 3] <<  5) | (t[j+ 4] << 28);
    pt[i+ 3] = (t[j+ 4] >>  4) | (t[j+ 5] << 19);
    pt[i+ 4] = (t[j+ 5] >> 13) | (t[j+ 6] << 10); pt[i+ 5] = (t[j+ 6] >> 22) | (t[j+ 7] <<  1) | (t[j+ 8] << 24);
    pt[i+ 6] = (t[j+ 8] >>  8) | (t[j+ 9] << 15); pt[i+ 7] = (t[j+ 9] >> 17) | (t[j+10] <<  6) | (t[j+11] << 29);
    pt[i+ 8] = (t[j+11] >>  3) | (t[j+12] << 20);
    pt[i+ 9] = (t[j+12] >> 12) | (t[j+13] << 11); pt[i+10] = (t[j+13] >> 21) | (t[j+14] <<  2) | (t[j+15] << 25);
    pt[i+11] = (t[j+15] >>  7) | (t[j+16] << 16); pt[i+12] = (t[j+16] >> 16) | (t[j+17] <<  7) | (t[j+18] << 30);
    pt[i+13] = (t[j+18] >>  2) | (t[j+19] << 21);
    pt[i+14] = (t[j+19] >> 11) | (t[j+20] << 12); pt[i+15] = (t[j+20] >> 20) | (t[j+21] <<  3) | (t[j+22] << 26);
    pt[i+16] = (t[j+22] >>  6) | (t[j+23] << 17); pt[i+17] = (t[j+23] >> 15) | (t[j+24] <<  8) | (t[j+25] << 31);
    pt[i+18] = (t[j+25] >>  1) | (t[j+26] << 22);
    pt[i+19] = (t[j+26] >> 10) | (t[j+27] << 13); pt[i+20] = (t[j+27] >> 19) | (t[j+28] <<  4) | (t[j+29] << 27);
    pt[i+21] = (t[j+29] >>  5) | (t[j+30] << 18);
    pt[i+22] = (t[j+30] >> 14) | (t[j+31] <<  9);
    j += 32;
  }
  memcpy(&pk[PARAM_N*PARAM_Q_LOG/8], seedA, CRYPTO_SEEDBYTES);
}


static void decode_pk(int32_t *pk, unsigned char *seedA, const unsigned char *pk_in)
{ // Decode public key pk
  unsigned int i, j=0;
  uint32_t *pt = (uint32_t*)pk_in, *pp = (uint32_t*)pk, mask23 = (1<<PARAM_Q_LOG)-1;

  for (i=0; i<PARAM_N; i+=32) {
    pp[i   ] = pt[j] & mask23; 
    pp[i+ 1] = ((pt[j+ 0] >> 23) | (pt[j+ 1] <<  9)) & mask23; 
    pp[i+ 2] = ((pt[j+ 1] >> 14) | (pt[j+ 2] << 18)) & mask23; pp[i+ 3] = (pt[j+ 2] >> 5) & mask23;
    pp[i+ 4] = ((pt[j+ 2] >> 28) | (pt[j+ 3] <<  4)) & mask23;
    pp[i+ 5] = ((pt[j+ 3] >> 19) | (pt[j+ 4] << 13)) & mask23;
    pp[i+ 6] = ((pt[j+ 4] >> 10) | (pt[j+ 5] << 22)) & mask23; pp[i+ 7] = (pt[j+ 5] >> 1) & mask23;
    pp[i+ 8] = ((pt[j+ 5] >> 24) | (pt[j+ 6] <<  8)) & mask23;
    pp[i+ 9] = ((pt[j+ 6] >> 15) | (pt[j+ 7] << 17)) & mask23; pp[i+10] = (pt[j+ 7] >> 6) & mask23;
    pp[i+11] = ((pt[j+ 7] >> 29) | (pt[j+ 8] <<  3)) & mask23;
    pp[i+12] = ((pt[j+ 8] >> 20) | (pt[j+ 9] << 12)) & mask23;
    pp[i+13] = ((pt[j+ 9] >> 11) | (pt[j+10] << 21)) & mask23; pp[i+14] = (pt[j+10] >> 2) & mask23;
    pp[i+15] = ((pt[j+10] >> 25) | (pt[j+11] <<  7)) & mask23;
    pp[i+16] = ((pt[j+11] >> 16) | (pt[j+12] << 16)) & mask23; pp[i+17] = (pt[j+12] >> 7) & mask23;
    pp[i+18] = ((pt[j+12] >> 30) | (pt[j+13] <<  2)) & mask23;
    pp[i+19] = ((pt[j+13] >> 21) | (pt[j+14] << 11)) & mask23;
    pp[i+20] = ((pt[j+14] >> 12) | (pt[j+15] << 20)) & mask23; pp[i+21] = (pt[j+15] >> 3) & mask23;
    pp[i+22] = ((pt[j+15] >> 26) | (pt[j+16] <<  6)) & mask23;
    pp[i+23] = ((pt[j+16] >> 17) | (pt[j+17] << 15)) & mask23; pp[i+24] = (pt[j+17] >> 8) & mask23;
    pp[i+25] = ((pt[j+17] >> 31) | (pt[j+18] <<  1)) & mask23;
    pp[i+26] = ((pt[j+18] >> 22) | (pt[j+19] << 10)) & mask23;
    pp[i+27] = ((pt[j+19] >> 13) | (pt[j+20] << 19)) & mask23; pp[i+28] = (pt[j+20] >> 4) & mask23;
    pp[i+29] = ((pt[j+20] >> 27) | (pt[j+21] <<  5)) & mask23;
    pp[i+30] = ((pt[j+21] >> 18) | (pt[j+22] << 14)) & mask23;
    pp[i+31] = pt[j+22] >> 9;
    j += 23;
  }   
  memcpy(seedA, &pk_in[PARAM_N*PARAM_Q_LOG/8], CRYPTO_SEEDBYTES);
}

static void encode_sig(unsigned char *sm, unsigned char *c, poly z)
{ // Encode signature sm
  unsigned int i, j=0;
  uint64_t *t = (uint64_t*)z;
  uint8_t  *pt = (uint8_t*)sm;

  for (i=0; i<(PARAM_N*PARAM_D/8); i+=PARAM_D) {
    pt[i   ] = (t[j] & ((1<<8)-1));
    pt[i+ 1] = (t[j] >> 8) & ((1<<8)-1);
    pt[i+ 2] = ((t[j+1]<<5) | ((t[j]>>16) & ((1<<5)-1)));
    pt[i+ 3] = (t[j+1] >> 3) & ((1<<8)-1);
    pt[i+ 4] = (t[j+1] >> 11) & ((1<<8)-1);
    pt[i+ 5] = ((t[j+2]<<2) | ((t[j+1]>>19) & ((1<<2)-1)));
    pt[i+ 6] = (t[j+2]>>6) & ((1<<8)-1);
    pt[i+ 7] = ((t[j+3]<<7) | ((t[j+2]>>14) & ((1<<7)-1)));
    pt[i+ 8] = (t[j+3]>>1) & ((1<<8)-1);
    pt[i+ 9] = (t[j+3]>>9) & ((1<<8)-1);
    pt[i+10] = ((t[j+4]<<4) | ((t[j+3]>>17) & ((1<<4)-1)));
    pt[i+11] = (t[j+4]>>4) & ((1<<8)-1);
    pt[i+12] = (t[j+4]>>12) & ((1<<8)-1);
    pt[i+13] = ((t[j+5]<<1) | ((t[j+4]>>20) & ((1<<1)-1)));
    pt[i+14] = (t[j+5]>>7) & ((1<<8)-1);
    pt[i+15] = ((t[j+6]<<6) | ((t[j+5]>>15) & ((1<<6)-1)));
    pt[i+16] = (t[j+6]>>2) & ((1<<8)-1);
    pt[i+17] = (t[j+6]>>10) & ((1<<8)-1);
    pt[i+18] = ((t[j+7]<<3) | ((t[j+6]>>18) & ((1<<3)-1)));
    pt[i+19] = (t[j+7]>>5) & ((1<<8)-1);
    pt[i+20] = (t[j+7]>>13) & ((1<<8)-1);
    j += 8;
  }
  memcpy(&sm[PARAM_N*PARAM_D/8], c, CRYPTO_C_BYTES);
}


static void decode_sig(unsigned char *c, poly z, const unsigned char *sm)
{ // Decode signature sm
  unsigned int i, j=0;
  uint8_t *pt = (uint8_t*)sm;

  for (i=0; i<PARAM_N; i+=8) {
    z[i   ] = ((int32_t)(((uint32_t)pt[j]) | ((uint32_t)pt[j+1]<<8) | ((uint32_t)pt[j+2]<<16))<<11)>>11;
    z[i+ 1] = ((int32_t)(((uint32_t)pt[j+2]>>5) | (((uint32_t)pt[j+3])<<3) | (((uint32_t) pt[j+4])<<11) | ((uint32_t)pt[j+5]<<19))<<11)>>11;
    z[i+ 2] = ((int32_t)(((uint32_t)pt[j+5]>>2) | (((uint32_t)pt[j+6])<<6) | ((uint32_t) pt[j+7]<<14))<<11)>>11;
    z[i+ 3] = ((int32_t)(((uint32_t)pt[j+7]>>7) | (((uint32_t)pt[j+8])<<1) | (((uint32_t)pt[j+9])<<9) | ((uint32_t)pt[j+10]<<17))<<11)>>11;
    z[i+ 4] = ((int32_t)(((uint32_t)pt[j+10]>>4) | (((uint32_t)pt[j+11])<<4) | (((uint32_t)pt[j+12])<<12) | ((uint32_t)pt[j+13]<<20))<<11)>>11;
    z[i+ 5] = ((int32_t)(((uint32_t)pt[j+13]>>1) | (((uint32_t)pt[j+14])<<7) | ((uint32_t)pt[j+15]<<15))<<11)>>11;
    z[i+ 6] = ((int32_t)(((uint32_t)pt[j+15]>>6) | (((uint32_t)pt[j+16])<<2) | (((uint32_t)pt[j+17])<<10) | ((uint32_t)pt[j+18]<<18))<<11)>>11;
    z[i+ 7] = ((int32_t)(((uint32_t)pt[j+18]>>3) | (((uint32_t)pt[j+19])<<5) | ((uint32_t)pt[j+20]<<13))<<11)>>11;
    j += 21;
  }   
  memcpy(c, &sm[PARAM_N*PARAM_D/8], CRYPTO_C_BYTES);
}

static void hash_vm(unsigned char *c_bin, poly v, const unsigned char *m, unsigned long long mlen)
{ // Hash to generate c' 
  unsigned char t[PARAM_N+mlen];
  int64_t mask, cL;
  unsigned int i;  

  for (i=0; i<PARAM_N; i++) { 
    // If v[i] > PARAM_Q/2 then v[i] -= PARAM_Q
    mask = (int64_t)(PARAM_Q/2 - v[i]) >> 63;                    
    v[i] = ((v[i]-PARAM_Q) & mask) | (v[i] & ~mask);
    
    cL = v[i] & ((1<<PARAM_D)-1);
    // If cL > 2^(d-1) then cL -= 2^d
    mask = (int64_t)((1<<(PARAM_D-1)) - cL) >> 63;                    
    cL = ((cL-(1<<PARAM_D)) & mask) | (cL & ~mask);  
    t[i] = (unsigned char)((v[i] - cL) >> PARAM_D);      
  }  
  memcpy(&t[PARAM_N], m, mlen);
  shake256(c_bin, CRYPTO_C_BYTES, t, mlen+PARAM_N);
} 


static __inline uint64_t Abs(int64_t value)
{ // Compute absolute value

    uint64_t mask = (uint64_t)(value >> 63);
    return ((mask ^ value) - mask);
}


static int test_rejection(poly z)
{ // Check bounds for signature vector z during signing. Returns 0 if valid, otherwise outputs 1 if invalid (rejected).
  // This function leaks the position of the coefficient that fails the test (but this is independent of the secret data). 
  // It does not leak the sign of the coefficients.
  unsigned int i;

  for (i=0; i<PARAM_N; i++) {
    if (Abs(z[i]) > (PARAM_B-PARAM_U))
      return 1;
  }
  return 0;
}


static int test_v(poly v)
{ // Check bounds for w = v - ec during signature verification. Returns 0 if valid, otherwise outputs 1 if invalid (rejected).
  // This function leaks the position of the coefficient that fails the test (but this is independent of the secret data). 
  // It does not leak the sign of the coefficients.
  unsigned int i;
  int64_t mask, left, val;
  uint64_t t0, t1;
  
  for (i=0; i<PARAM_N; i++) {      
    // If v[i] > PARAM_Q/2 then v[i] -= PARAM_Q
    mask = (int64_t)(PARAM_Q/2 - v[i]) >> 63;
    val = ((v[i]-PARAM_Q) & mask) | (v[i] & ~mask);
    // If (Abs(val) > PARAM_Q/2 - PARAM_REJECTION) then t0 = 1, else t0 = 0
    t0 = (uint64_t)((int64_t)(PARAM_Q/2 - PARAM_REJECTION) - (int64_t)Abs(val)) >> 63;
                     
    left = val;
    val = (int32_t)((val + (1<<(PARAM_D-1))-1) >> PARAM_D); 
    val = left - (val << PARAM_D);
    // If (Abs(val) > (1<<(PARAM_D-1))-PARAM_REJECTION) then t1 = 1, else t1 = 0 
    t1 = (uint64_t)((int64_t)((1<<(PARAM_D-1))-PARAM_REJECTION) - (int64_t)Abs(val)) >> 63; 

    if ((t0 | t1) == 1)  // Returns 1 if any of the two tests failed
      return 1;
  }
  return 0;
}


static int test_z(poly z)
{ // Check bounds for signature vector z during signature verification
  // Returns 0 if valid, otherwise outputs 1 if invalid (rejected)
  unsigned int i;
  
  for (i=0; i<PARAM_N; i++) {                                  
    if (z[i] < -(PARAM_B-PARAM_U) || z[i] > (PARAM_B-PARAM_U))
      return 1;
  }
  return 0;
}


static int check_ES(poly p, unsigned int bound)
{ // Checks the generated secret polynomial s
  // Returns 0 if ok, otherwise returns 1
  unsigned int i, j, sum = 0, limit = PARAM_N;
  int16_t temp, mask, list[PARAM_N];

  for (j=0; j<PARAM_N; j++)    
    list[j] = (int16_t)(Abs(p[j]));

  for (j=0; j<PARAM_W; j++) {
    for (i=0; i<limit-1; i++) {
      // If list[i+1] > list[i] then exchange contents
      mask = (list[i+1] - list[i]) >> 15;  
      temp = (list[i+1] & mask) | (list[i] & ~mask);
      list[i+1] = (list[i] & mask) | (list[i+1] & ~mask);
      list[i] = temp;
    }
    sum += list[limit-1];
    limit -= 1;
  }

  if (sum > bound)
    return 1;
  return 0;
}


/********************************************************************************************
* Name:        sparse_mul16
* Description: performs sparse polynomial multiplication
* Parameters:  inputs:
*              - const unsigned char* sk: part of the secret key
*              - const uint32_t pos_list[PARAM_W]: list of indices of nonzero elements in c
*              - const int16_t sign_list[PARAM_W]: list of signs of nonzero elements in c
*              outputs:
*              - poly prod: product of 2 polynomials
*
* Note: pos_list[] and sign_list[] contain public information since c is public
*********************************************************************************************/
static void sparse_mul16(poly prod, const unsigned char *sk, const uint32_t pos_list[PARAM_W], const int16_t sign_list[PARAM_W])
{
  int i, j, pos;
  int16_t *t = (int16_t*)sk;

  for (i=0; i<PARAM_N; i++)
    prod[i] = 0;

  for (i=0; i<PARAM_W; i++) {
    pos = pos_list[i];
    for (j=0; j<pos; j++) {
        prod[j] = prod[j] - sign_list[i]*t[j+PARAM_N-pos];
    }
    for (j=pos; j<PARAM_N; j++) {
        prod[j] = prod[j] + sign_list[i]*t[j-pos];
    }
  }
}


/********************************************************************************************
* Name:        sparse_mul32
* Description: performs sparse polynomial multiplication 
* Parameters:  inputs:
*              - const int32_t* pk: part of the public key
*              - const uint32_t pos_list[PARAM_W]: list of indices of nonzero elements in c
*              - const int16_t sign_list[PARAM_W]: list of signs of nonzero elements in c
*              outputs:
*              - poly prod: product of 2 polynomials
*********************************************************************************************/
static void sparse_mul32(poly prod, const int32_t *pk, const uint32_t pos_list[PARAM_W], const int16_t sign_list[PARAM_W])
{
  int i, j, pos;

  for (i=0; i<PARAM_N; i++)
    prod[i] = 0;
  
  for (i=0; i<PARAM_W; i++) {
    pos = pos_list[i];
    for (j=0; j<pos; j++) {
        prod[j] = prod[j] - sign_list[i]*pk[j+PARAM_N-pos];
    }
    for (j=pos; j<PARAM_N; j++) {
        prod[j] = prod[j] + sign_list[i]*pk[j-pos];
    }
  }
  for (i=0; i<PARAM_N; i++)
    prod[i] = barr_reduce(prod[i]);
}


/*********************************************************
* Name:        crypto_sign_keypair
* Description: generates a public and private key pair
* Parameters:  inputs:  none
*              outputs:
*              - unsigned char *pk: public key
*              - unsigned char *sk: secret key
* Returns:     0 for successful execution
**********************************************************/
int crypto_sign_keypair(unsigned char *pk, unsigned char *sk)
{
  unsigned char randomness[CRYPTO_RANDOMBYTES], randomness_extended[4*CRYPTO_SEEDBYTES];
  poly s, e, a, t;  
  int nonce = 0;  // Initialize domain separator for error and secret polynomials

  // Get randomness_extended <- seed_e, seed_s, seed_a, seed_y
  randombytes(randomness, CRYPTO_RANDOMBYTES);
  shake256(randomness_extended, 4*CRYPTO_SEEDBYTES, randomness, CRYPTO_RANDOMBYTES);

  do {        // Sample the error polynomial
    sample_gauss_poly(e, randomness_extended, ++nonce);        
  } while(check_ES(e, (int)PARAM_KEYGEN_BOUND_E) != 0);  
 
  do {        // Sample the secret polynomial
    sample_gauss_poly(s, &randomness_extended[CRYPTO_SEEDBYTES], ++nonce);
  } while(check_ES(s, (int)PARAM_KEYGEN_BOUND_S) != 0);

  // Generate uniform polynomial "a"
  poly_uniform(a, &randomness_extended[2*CRYPTO_SEEDBYTES]);
  
  // Compute the public key t = as+e
  poly_mul(t, a, s);
  poly_add(t, t, e);
    
  // Pack public and private keys
  pack_sk(sk, s, e, &randomness_extended[2*CRYPTO_SEEDBYTES]);
  encode_pk(pk, t, &randomness_extended[2*CRYPTO_SEEDBYTES]);

  return 0;
}


/***************************************************************
* Name:        crypto_sign
* Description: outputs a signature for a given message m
* Parameters:  inputs:
*              - const unsigned char *m: message to be signed
*              - unsigned long long mlen: message length
*              - const unsigned char* sk: secret key
*              outputs:
*              - unsigned char *sm: signature
*              - unsigned long long *smlen: signature length*
* Returns:     0 for successful execution
***************************************************************/
int crypto_sign(unsigned char *sm, unsigned long long *smlen, const unsigned char *m, unsigned long long mlen, const unsigned char* sk)
{
  poly y, v, Sc, Ec, z, a;
  unsigned char c[CRYPTO_C_BYTES], randomness[CRYPTO_SEEDBYTES], randomness_input[CRYPTO_RANDOMBYTES+CRYPTO_SEEDBYTES+mlen];
  uint32_t pos_list[PARAM_W];
  int16_t sign_list[PARAM_W];

  int nonce = 0;  // Initialize domain separator for sampling y   

  // Get H(seed_y, r, m) to sample y
  randombytes(randomness_input+CRYPTO_RANDOMBYTES, CRYPTO_RANDOMBYTES);
  memcpy(randomness_input, &sk[CRYPTO_SECRETKEYBYTES-CRYPTO_SEEDBYTES], CRYPTO_SEEDBYTES);
  memcpy(randomness_input+CRYPTO_RANDOMBYTES+CRYPTO_SEEDBYTES, m, mlen);
  shake256(randomness, CRYPTO_SEEDBYTES, randomness_input, CRYPTO_RANDOMBYTES+CRYPTO_SEEDBYTES+mlen);
  
  poly_uniform(a, &sk[CRYPTO_SECRETKEYBYTES-2*CRYPTO_SEEDBYTES]);

  while (1) {
    sample_y(y, randomness, ++nonce);           // Sample y uniformly at random from [-B,B]
    poly_mul(v, a, y); 
    hash_vm(c, v, m, mlen);
    encode_c(pos_list, sign_list, c);           // Generate c = Enc(c'), where c' is the hashing of v together with m
    sparse_mul16(Sc, sk, pos_list, sign_list);
    poly_add(z, y, Sc);                         // Compute z = y + sc
    
    if (test_rejection(z) != 0) {               // Rejection sampling
      continue;
    }
 
    sparse_mul16(Ec, sk+(sizeof(int16_t)*PARAM_N), pos_list, sign_list);
    poly_sub(v, v, Ec);                         
    
    if (test_v(v) != 0) {
      continue;
    }    

    // Copy message to signature package, and pack signature
    memcpy(sm, m, mlen);
    *smlen = CRYPTO_BYTES + mlen;  
    encode_sig(sm+mlen, c, z);

    return 0;
  }
}


/************************************************************
* Name:        crypto_sign_open
* Description: verification of a signature sm
* Parameters:  inputs:
*              - const unsigned char *sm: signature
*              - unsigned long long smlen: signature length
*              - const unsigned char* pk: public Key
*              outputs:
*              - unsigned char *m: original (signed) message
*              - unsigned long long *mlen: message length*
* Returns:     0 for valid signature
*              <0 for invalid signature
************************************************************/
int crypto_sign_open(unsigned char *m, unsigned long long *mlen, const unsigned char *sm, unsigned long long smlen, const unsigned char *pk)
{
  unsigned char c[CRYPTO_C_BYTES], c_sig[CRYPTO_C_BYTES], seed[CRYPTO_SEEDBYTES];
  uint32_t pos_list[PARAM_W];
  int16_t sign_list[PARAM_W]; 
  int32_t pk_t[PARAM_N];
  poly w, z, a, Tc;

  if (smlen < CRYPTO_BYTES) return -1;

  decode_sig(c, z, sm+smlen-CRYPTO_BYTES);  
  if (test_z(z) != 0) return -2;                 // Check norm of z
  decode_pk((int32_t*)pk_t, seed, pk);
  poly_uniform(a, seed);
  encode_c(pos_list, sign_list, c);    
  poly_mul(w, a, z);                             
  sparse_mul32(Tc, pk_t, pos_list, sign_list);     
  poly_sub(w, w, Tc);                            // Compute w = az - tc
  hash_vm(c_sig, w, sm, ((int)smlen - (int)CRYPTO_BYTES));

  // Check if the calculated c matches c from the signature
  if (memcmp(c, c_sig, CRYPTO_C_BYTES)) return -3;
  
  *mlen = smlen-CRYPTO_BYTES;
  memcpy(m, sm, *mlen);

  return 0;
}
