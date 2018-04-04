#include <string.h>
#include <stdlib.h>
#include "api.h"
#include "oracle.h"
#include "params.h"
#include "poly.h"
#include "sample.h"
#include "fips202.h"
#include "randombytes.h"

static void compress_sk(unsigned char *sk, poly s, poly e, unsigned char *seedA)
{
  int i;
  int8_t *isk = (int8_t *)sk;

  for(i=0; i<PARAM_N; i++)
    isk[i] = s[i];

  isk += PARAM_N;

  for(i=0; i<(PARAM_N); i++)
    isk[i] = e[i];
  
  memcpy(&isk[i],seedA,2*CRYPTO_RANDOMBYTES);

} 

static void compress_pk(unsigned char *pk, poly t, unsigned char *seedA)
{
  int i;
  int32_t *ipk = (int32_t *)pk;

  for(i=0; i<(PARAM_N); i++)
      ipk[i] = t[i];
  
  memcpy(&ipk[i],seedA,CRYPTO_RANDOMBYTES);
}

static void compress_sig(unsigned char *sm, unsigned char *c, poly z)
{
  int i,k;
  int ptr =0;
  int32_t t=0;

  //store the hash value
  for (i=0; i<32; i++){
    sm[ptr++] =c[i];
  }
  //compress the signature vector z  
  for(i=0; i<PARAM_N; i++)
  {
    t = (int32_t)z[i];
    for(k=0;k<3;k++)
      sm[ptr++] = ((t>>(8*(k))) & 0xff);
  }
}

static void decompress_sig(unsigned char *c, poly z, const unsigned char *sm)
{
  int i,k;
  int ptr =0;
  int32_t t;

  //load the hash value
  for (i=0; i<32; i++){
    c[i] =sm[ptr++];
  }

  //decompress the signature vector z  
  for(i=0; i<PARAM_N; i++)
  {
    t = 0;
    for(k=0;k<3;k++)
      t |= ((uint32_t)sm[ptr++]) << (8*(k+1));
    z[i] = (int32_t)(t>>8);
  }  
}  

static int test_rejection(poly z)
{
  int i, ret=0;
  for(i=0; i<PARAM_N; i++){
     ret |= (z[i] < -(PARAM_B-PARAM_U) || z[i] > (PARAM_B-PARAM_U));
  }
  return ret;
}

static int test_z(poly z)
{
  int i, ret=0;
  int64_t val;
  
  for(i=0; i<PARAM_N; i++)
  {
    val = (z[i]) % PARAM_Q;

    while (val > PARAM_Q/2){
      val = val - PARAM_Q;
    }

    while (val < -PARAM_Q/2){
      val = val + PARAM_Q;
    }

    ret |= (abs(val) > (PARAM_B-PARAM_U));
  }
  return ret;
}

/*************************************************
* Name:          test_v
* Description:	 Checks whether parameter v fulfills
* 		 certain properties
* 		 needed in Sign algorithm
* Parameters:   input:
*			- poly v
*
* 		output: none
*
* Returns: 	0:  parameter ok
* 		1:  parameter not ok
**************************************************/
static int test_v(poly v)
{
  int i, ret=0;
  int64_t left, right, val;
  
  for(i=0; i<PARAM_N; i++)
  {
    val = v[i];
    val = val % PARAM_Q;

    if (val < 0){
      val = val + PARAM_Q;
    }

    left = val;
    left = left % (1<<(PARAM_D)); 

    left -= (1<<PARAM_D)/2; 
    left++;

    right = (1<<(PARAM_D-1))-PARAM_REJECTION;

    ret |= (abs(left) > right);
  }
  return ret;
}

/*************************************************
* Name:          check_E
* Description:	 Checks the generated parameter E
* 		 needed in KeyGen algorithm
* Parameters:    input:
*			 - poly e
*
* 		 output: none
*
* Returns: 	 0:  parameter ok
* 		 1:  parameter not ok
**************************************************/
static int check_E(poly e)
{
  int i,j,l, ret=0;
  int bound = PARAM_KEYGEN_BOUND_E;
  int pos;

  int8_t vals[PARAM_N];
  int16_t max;
  int16_t threshold =0;

  for(j=0; j<PARAM_N; j++){
    vals[j] = (int8_t)(e[j]);
    if(vals[j]<0)
      vals[j] *= -1;
  } 

  threshold = 0;
  for(i=0; i< PARAM_W; i++){
    max =0;
    pos =0;
    for(l=0; l< PARAM_N; l++){
      if (vals[l] > max){
        max = vals[l];
        pos = l;
      }
    }
    vals[pos] = 0;
    threshold += max;
  }

  ret |= (threshold > bound);
  return ret;
}

/*************************************************
* Name:          check_S
* Description:	 Checks the generated parameter S
* Parameters:    input:
*			- poly s
*
* 		 output: none
*
* Returns: 	 0:  parameter ok
* 		 1:  parameter not ok
**************************************************/
static int check_S(poly s)
{
  int i,j,l, ret=0;
  int bound = PARAM_KEYGEN_BOUND_S;
  int pos;

  int8_t vals[PARAM_N];
  int16_t max;
  int16_t threshold =0;

  for(j=0; j<PARAM_N; j++){    
    vals[j] = (int8_t)(s[j]);
    if(vals[j]<0)
      vals[j] *= -1;
  } 

  threshold = 0;
  for(i=0; i< PARAM_W; i++){
    max =0;
    pos =0;
    for(l=0; l< PARAM_N; l++){
      if (vals[l] > max){
        max = vals[l];
        pos = l;
      }
    }
    vals[pos] = 0;
    threshold += max;
  }

  ret |= (threshold > bound);
  return ret;
}

/*************************************************
* Name:          crypto_sign_keypair
* Description:	 Generates public- and private key for qTesla signature scheme
* Parameters:    input:  none
* 		 output:
* 			- unsigned char *pk: contains public key
* 			- unsigned char *sk: contains secret key
* Returns: 	0: successful execution
**************************************************/
int crypto_sign_keypair(unsigned char *pk, unsigned char *sk)
{
  unsigned char randomness[CRYPTO_RANDOMBYTES];
  randombytes(randomness,CRYPTO_RANDOMBYTES);
  
  poly s, e;
  poly a, t;

  // domain seperator for error polynomial
  int c=0;
  // Extend randombytes to seed generation of E_k and S
  unsigned char randomness_extended[4*CRYPTO_RANDOMBYTES];
  cshake128_simple(randomness_extended, 4*CRYPTO_RANDOMBYTES, 0, randomness, CRYPTO_RANDOMBYTES);
  // Sample an error polynomial that fulfills the criteria
  do
  {
    sample_gauss_poly(e,randomness_extended,c++);
  }
  while(check_E(e) != 0);
  // reset the domain seperator for secret polynomial
  c=0;
  
  // Sample the secret polynomial that fulfills the criteria
  do
  {
    sample_gauss_poly(s,&randomness_extended[CRYPTO_RANDOMBYTES],c++);
  }
  while(check_S(s) != 0);

  //generate uniform polynomail
  poly_uniform(a,&randomness_extended[2*CRYPTO_RANDOMBYTES]);
  
  //Compute the public key t = as+e
  poly_mul(t,s,a);
  poly_add(t,t,e);
    
  //Compress polynomials and seeds
  compress_pk(pk, t, &randomness_extended[2*CRYPTO_RANDOMBYTES]);
  compress_sk(sk, s, e, &randomness_extended[2*CRYPTO_RANDOMBYTES]);

  return 0;
}

/************************************************************
* Name:         computeEc
*
* Description:	computeEc performs sparse polynomial
* 		multiplication for a value needed during
* 		signing of messages
*
* Parameters:   input:
* 			- const unsigned char* sk: Secret key
*			- const uint32_t pos_list[PARAM_W]: list of indices of nonzore elements in c
* 			- const int16_t sign_list[PARAM_W]: list of signs of nonzore elements in c
* 		output:
* 			- poly Ec: Product of 2 polynomials
*
* Returns: 	0: Successful execution 
************************************************************/
static void computeEc(poly Ec, const unsigned char *sk, const uint32_t pos_list[PARAM_W], const int16_t sign_list[PARAM_W])
{
  int i,j;
  int pos, temp;
  int8_t * e;
  e = (int8_t*)sk;

  for(i=0;i<PARAM_N;i++){
    Ec[i] = 0;
    temp = e[i];
  }

  for(i=0;i<PARAM_W;i++)
  {
    pos = pos_list[i];
    for(j=0;j<pos;j++) {
        Ec[j] = (Ec[j]-sign_list[i]*e[j+PARAM_N - pos])%PARAM_Q;
    }
    for(j=pos;j<PARAM_N;j++) {
        Ec[j] = (Ec[j]+sign_list[i]*e[j-pos])%PARAM_Q;
    }
  }
}

/************************************************************
* Name:         computeTc
*
* Description:	computeTc performs sparse polynomial
* 		multiplication for a value needed during
* 		signing of messages
*
* Parameters:   input:
* 			- const unsigned char* pk: Public key
*			- const uint32_t pos_list[PARAM_W]: list of indices of nonzore elements in c
* 			- const int16_t sign_list[PARAM_W]: list of signs of nonzore elements in c
* 		output:
* 			- poly Tc: Product of 2 polynomials
*
* Returns: 	0: Successful execution 
************************************************************/
static void computeTc(poly Tc, const unsigned char *pk, const uint32_t pos_list[PARAM_W], const int16_t sign_list[PARAM_W])
{
  int i,j;
  int pos, temp;
  int32_t * e;
  e = (int32_t*)pk;

  for(i=0;i<PARAM_N;i++){
    Tc[i] = 0;
    temp = e[i];
  }
  
  for(i=0;i<PARAM_W;i++)
  {
    pos = pos_list[i];
    for(j=0;j<pos;j++) {
        Tc[j] = (Tc[j]-sign_list[i]*e[j+PARAM_N - pos])%PARAM_Q;
    }
    for(j=pos;j<PARAM_N;j++) {
        Tc[j] = (Tc[j]+sign_list[i]*e[j-pos])%PARAM_Q;
    }
  }
}

/************************************************************
* Name:         crypto_sign
*
* Description:	crypto_sign outputs for a given message m
* 		a signature according to the ring-tesla signature scheme
*
* Parameters:   input:
* 		 	- const unsigned char *m: Message to be signed
* 	 		- unsigned long long mlen: To be signed message's length
* 	 		- const unsigned char* sk: Secret key
* 		output:
* 	 		- unsigned char *sm: Output package containing signature
* 	 		- unsigned long long *smlen: Output package's (containing signature) length*
*
* Returns: 	0: after successful execution
************************************************************/
int crypto_sign(unsigned char *sm, 
                unsigned long long *smlen, 
                const unsigned char *m,
                unsigned long long mlen,
                const unsigned char* sk)
{
  unsigned char randomness[CRYPTO_RANDOMBYTES],randomness_input[CRYPTO_RANDOMBYTES+mlen];
  memcpy(randomness_input,&sk[CRYPTO_SECRETKEYBYTES-CRYPTO_RANDOMBYTES],CRYPTO_RANDOMBYTES);
  memcpy(randomness_input+CRYPTO_RANDOMBYTES,m,mlen);
  cshake128_simple(randomness, CRYPTO_RANDOMBYTES, 0, randomness_input, CRYPTO_RANDOMBYTES+mlen);
  
  uint32_t pos_list[PARAM_W];
  int16_t sign_list[PARAM_W];
  poly y;
  poly v;
  poly Sc;
  poly Ec;
  poly z;
  poly a;

  unsigned char c[64];
  unsigned long long i;
  // domain seperator for sampling y
  int ctr=0;
  poly_uniform(a,&sk[CRYPTO_SECRETKEYBYTES-2*CRYPTO_RANDOMBYTES]);
  //Loop due to possible rejections
  while(1)
  {
    //Sample y uniformly random from [-B,B]
    //Sign algo line 9
    sample_y(y, randomness,ctr++);
    //Sign algo line 10/11
    poly_mul(v, y, a);
        
    //Hash v together with the message;
    //corresponds to c' in Paper
    //Sign algo line 12
    random_oracle(c, v, m, mlen);
    //Sign algo line 13
    generate_c(pos_list, sign_list, c);
    
    //Sign algo line 15/16
    computeEc(Ec, sk+(sizeof(int8_t)*PARAM_N), pos_list, sign_list);
    poly_sub(v, v, Ec);
    
    //test v
    if (test_v(v) != 0)
    {
      continue;
    }
    
    // Sign algo line 14
    computeEc(Sc, sk, pos_list, sign_list);
    poly_add(z, y, Sc);
    
    // rejection sampling
    if (test_rejection(z) != 0)
    {
      continue;
    }
      

    //Copy the message into the signature package
    for(i=0; i<mlen; i++)
      sm[i]=m[i];
    
    //Length of the output
    *smlen = CRYPTO_BYTES + mlen;  

    //Put the signature into the output package
    //Sign algo line 19
    compress_sig(sm+mlen, c, z);
    return 0;
  }
}

/************************************************************
* Name:         crypto_sign_open
*
* Description:	For a given signature package sm,
* 		crypto_sign extracts the original message m and
* 		checks, whether the generated signature is valid
*
* Parameters:   input:
* 		 	- const unsigned char *m: Message
* 	 		- unsigned long long mlen: message's length
* 	 		- const unsigned char* pk: Public Key
* 		output:
* 			- unsigned char *m: Original (signed) message
* 			- unsigned long long *mlen: Output package's (containing signature) length*
*
* Returns: 	0 : signature correct
* 		-1: signature not correct
************************************************************/
int crypto_sign_open(unsigned char *m,
                     unsigned long long *mlen,
                     const unsigned char *sm,
                     unsigned long long smlen,
                     const unsigned char *pk)
{
  unsigned char c[32];
  unsigned char c_sig[64];

  uint32_t pos_list[PARAM_W];
  int16_t sign_list[PARAM_W];
  
  poly w;
  poly z;
  poly Tc;
  poly a;

  if (smlen < CRYPTO_BYTES) return -1;

  decompress_sig(c, z, sm+smlen-CRYPTO_BYTES);
  //Check norm of z
  if (test_z(z) != 0) return -1;
  //From hash (bytes) to polynomial c: F(c)
  generate_c(pos_list, sign_list, c);
  // Generate a polynomial
  poly_uniform(a,&pk[CRYPTO_PUBLICKEYBYTES-CRYPTO_RANDOMBYTES]);

  //w = Az-Tc
  poly_mul(w, z, a);
  computeTc(Tc, pk, pos_list, sign_list);
  poly_sub(w, w, Tc);
    
  //obtain the hash c
  random_oracle(c_sig, w, sm, ((int)smlen - (int)CRYPTO_BYTES));

  // check if same with the one from signature
  if(memcmp(c,c_sig,32)) return -1;
  
  *mlen = smlen-CRYPTO_BYTES;
  memcpy(m,sm,*mlen);

  return 0;
}
