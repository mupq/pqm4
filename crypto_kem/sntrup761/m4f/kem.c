#include "params.h"
#include "randombytes.h"
#include "sha512_hash.h"
#ifdef LPR
#include "aes-publicinputs.h"
#include "aes.h"
#endif


#include "Encode.h"
#include "Decode.h"
#include <string.h>
#include "cmsis.h"
#include "Rq_mult.h"

/* ----- masks */

#define q12 ((q-1)/2)

#include "arith.h"

#ifdef LPR

/*************************************************
* Name:        int16_negative_mask
*
* Description: Return -1 if is input is a negative integer, 0 otherwise.
*
* Argument:
* int16 x : input coefficient
**************************************************/
static int int16_negative_mask(int16 x)
{
  uint16 u = x;
  u >>= 15;
  return -(int) u;
  /* alternative with gcc -fwrapv: */
  /* x>>15 compiles to CPU's arithmetic right shift */
}

/* ----- Top and Right */

#define tau 16
/*************************************************
* Name:        Top
*
* Description: Round ((tau_1 * (C+tau_0)) div 2^15) to the closer integer and return.
*
* Arguments:
* Fq C     : input coefficient
*
**************************************************/
static int8 Top(Fq C)
{
  return (tau1*(int32)(C+tau0)+16384)>>15;
}

/*************************************************
* Name:        Right
*
* Description: Compute (tau_3*T-tau_3) mod q.
*
* Arguments:
* int8 T   : input coefficient
**************************************************/
static Fq Right(int8 T)
{
  return Fq_freeze(tau3*(int32)T-tau2);
}
#endif

/* ----- small polynomials */

#ifndef LPR

/*************************************************
* Name:        R3_mult
*
* Description: Compute polynomial multiplication in Z_3/(X^p-X-1)
*              with Toom-Cook based implementation.
*
* Arguments:
* small *R       : pointer to the output polynomial in R_3
* const small *f : pointer to the input polynomial in R_3
* const small *g : pointer to the input polynomial in R_3
**************************************************/
static void R3_mult(small *h,const small *f,const small *g)
{
  small fg[1536];
  small f_mod3[768];
  small g_mod3[768];
  copy_p_F3_mod3(f, f_mod3, g, g_mod3);
  gf_polymul_768x768_mod3(fg, f_mod3, g_mod3);
  reduce_2p_minus1_mod3_F3(h, fg);

}


/*************************************************
* Name:        R3_fromRq
*
* Description: Return a polynomial that i-th coefficient
*              computed as (r[i] mod q) mod 3.
*
* Arguments:
* small *out  : pointer to the output polynomial in R_3
* const Fq *r : pointer to the input polynomial in R_q
**************************************************/
static void R3_fromRq(small *out,const Fq *r)
{

  int i;
  for (i = 0;i < p;++i) out[i] = F3_freeze_short(r[i]);
}

/*************************************************
* Name:        Rq_mult3
*
* Description: Compute h = 3*f mod R_q.
*
* Arguments:
* Fq *h       : pointer to the output polynomial in R_q
* const Fq *f : pointer to the input polynomial in R_q
**************************************************/
static void Rq_mult3(Fq *h,const Fq *f)
{
  Rq_mult3_asm(h, f);
}

#endif

/* ----- rounded polynomials mod q */
/*************************************************
* Name:        Round
*
* Description:
*
* Arguments:
* Fq *out     : pointer to the output polynomial in R_q
* const Fq *a : pointer to the input polynomial in R_q
**************************************************/
static void Round(Fq *out,const Fq *a)
{
  int i;
  int *o1 = (int *)(void *)out;
  int *a1 = (int *)(void *)a;

  for (i = (p-1)/2; i>0; i--) {
    *(o1++) = F3_round_x2(*(a1++));
  }
  out = (Fq *)(void *) o1;
  a = (Fq *)(void *) a1;
  *out = F3_round_x2(*a);

}

/* ----- sorting to generate short polynomial */
/*************************************************
* Name:        Short_fromlist
*
* Description:
*
* Arguments:
* small *out      : pointer to the output polynomial in R_q
* const uint32 *in: pointer to the input serialized public key
**************************************************/
static void Short_fromlist(small *out,const uint32 *in)
{
  Short_fromlist_asm(out, in);
}

/* ----- underlying hash function */

#define Hash_bytes 32

/*************************************************
* Name:        Hash
*
* Description: Domain separeted hash function that computes out=H_b(in)
*
* Arguments:
* unsigned char *out      : pointer to the output bitstring
* int b                   : Domain separetor
* const unsigned char *in : The input bitstring
* int inlen               : The lenght of the input bitstring
**************************************************/
static void Hash(unsigned char *out,int b,const unsigned char *in,int inlen)
{
  unsigned char x[inlen+1];
  unsigned char h[64];
  int i;

  x[0] = b;
  for (i = 0;i < inlen;++i) x[i+1] = in[i];
  //memcpy(x+1, in, inlen);
  sha512_hash(h,x,inlen+1);
  for (i = 0;i < 32;++i) out[i] = h[i];
  //sha512_hash(out,x,inlen+1);
}

/*************************************************
* Name:        Short_random
*
* Description: Generate random sparse polynomial with coefficients are in {-1,0,1}
*              and weight is w. It generates an unsigned 32-bit integer array, uses the
*              least significant two bits to indicate {-1,0,1}, then uses djbsort
*              to shuffle the array and maps values to {-1,0,1}.
*
* Arguments:
* small *out : pointer to the output polynomial with coefficients in {-1,0,1}
**************************************************/
static void Short_random(small *out)
{
  uint32 L[p];
  randombytes((unsigned char*)L, 4*p);
  Short_fromlist(out,L);
}

#ifndef LPR
/*************************************************
* Name:        urandom32
*
* Description: Return random 32-bit unsigned integer
*
**************************************************/
static uint32 urandom32(void)
{
  unsigned char c[4];

  randombytes(c,4);

  return *((int *)c);
}
/*************************************************
* Name:        Small_random
*
* Description: Generate uniformly random polynomial that coefficients are in {-1,0,1}
*
* Arguments:
* small *out : pointer to the output polynomial in R_q
**************************************************/
static void Small_random(small *out)
{
  int i;

  int *o1 = (int *)(void *)out;
  int x0, x1, x2, x3;
  int L[4];

  for (i = (p-1)/4; i>0; i--) {
    randombytes((unsigned char *)(void*)L, 16);
    x0 = L[0]; x1 = L[1]; x2 = L[2]; x3 = L[3];
    x0 = __BFC(x0, 30, 2); x0 = __SMMLA(x0, 12, -1);
    x1 = __BFC(x1, 30, 2); x1 = __SMMLA(x1, 12, -1);
    x2 = __BFC(x2, 30, 2); x2 = __SMMLA(x2, 12, -1);
    x3 = __BFC(x3, 30, 2); x3 = __SMMLA(x3, 12, -1);
    x0 = __BFI(x0, x1, 8, 8);
    x0 = __BFI(x0, x2, 16, 8);
    x0 = __BFI(x0, x3, 24, 8);
    *(o1++) = x0;
  }
  x0 = __BFC(urandom32(), 30, 2); x0 = __SMMLA(x0, 12, -1);
  out = (small *)(void *)o1;
  *out = x0;
}

/* ----- Streamlined NTRU Prime Core */

/*************************************************
* Name:        KeyGen
*
* Description: Generate f and g polynomials and compute h=f^{-1}*g mod R_q
*              and g^{-1} mod R_3
*
* Arguments:
* Fq *h       : pointer to the output public-key polynomial h
* small *f    : pointer to the output secret-key polynomial f
* small *ginv : pointer to the output secret-key polynomial ginv
**************************************************/
static void KeyGen(Fq *h,small *f,small *ginv)
{
  small g[p];
  Fq finv[p];
  for (;;) {
    Small_random(g);
    if (R3_recip_jumpdivsteps(ginv,g) == 0) break;
  }
  Short_random(f);
  Rq_recip3_jumpdivsteps(finv,f);
  Rq_mult_small(h,finv,g);
}

/*************************************************
* Name:        Encrypt
*
* Description: Encrypt small polynomial r with the public-key h return
*              the ciphertext c
*
* Arguments:
* Fq *c          : pointer to the output ciphertext polynomial
* const small *r : pointer to the input polynomial r
* const Fq *h    : pointer to the public-key
**************************************************/
static void Encrypt(Fq *c,const small *r,const Fq *h)
{
  Fq hr[p];
  Rq_mult_small(hr,h,r);
  Round(c,hr);
}

/*************************************************
* Name:        Decrypt
*
* Description: Decrypt the ciphertext c with using the secret-key f and ginv
*
* Arguments:
* small *r          : pointer to the output decrypted polynomial
* const Fq *c       : pointer to the input ciphertext
* const small *f    : pointer to the input polynomial which is a part of the secret-key
* const small *ginv : pointer to the input polinomial which is a part of the secret-key
**************************************************/
static void Decrypt(small *r,const Fq *c,const small *f,const small *ginv)
{
  Fq cf[p];
  Fq cf3[p];
  small e[p];
  small ev[p];
  int mask;
  int i;
  Rq_mult_small(cf,c,f);
  Rq_mult3(cf3,cf);
  R3_fromRq(e,cf3);
  R3_mult(ev,e,ginv);

  mask = //Weightw_mask(ev); /* 0 if weight w, else -1 */
    Weightw_mask_asm(ev);
  for (i = 0;i < w;++i) r[i] = ((ev[i]^1)&~mask)^1;
  for (i = w;i < p;++i) r[i] = ev[i]&~mask;
}

#endif

/* ----- NTRU LPRime Core */

#ifdef LPR

/*************************************************
* Name:        Keygen
*
* Description: Generates the public-key A and the secret-key a
*
* Arguments:
* Fq *A       : pointer to the output polynomial which is a part of the public-key
* small *a    : pointer to the output secret-key polynomial
* const Fq *G : pointer to the input polynomial which is a part of the public-key
**************************************************/
static void KeyGen(Fq *A,small *a,const Fq *G)
{
  Fq aG[p];

  Short_random(a);

  Rq_mult_small(aG,G,a);
  Round(A,aG);
}

/*************************************************
* Name:        Encrypt
*
* Description: Encrpts the polynomial r compute the ciphertext as B and T
*
* Arguments:
* Fq *B          : pointer to the output polynomial
* int8 *T        : pointer to the output top bits of message encoded polynomial
* const int8 *r  : pointer to the input bitstring
* const Fq *G    : pointer to the input polynomial (public-key)
* const Fq *A    : pointer to the input polynomial (public-key)
* const small *b : pointer to the input polynomial
**************************************************/
static void Encrypt(Fq *B,int8 *T,const int8 *r,const Fq *G,const Fq *A,const small *b)
{
  Fq bG[p];
  Fq bA[p];
  int i;

  Rq_mult_twice(bG, bA, G, A, b);
  Round(B,bG);
  for (i = 0;i < I;++i) T[i] = Top(Fq_freeze(bA[i]+r[i]*q12));
}

/*************************************************
* Name:        Decrypt
*
* Description: Decrypt ciphertext in B and T with using the secret-key a
*
* Arguments:
* int8 *r        : pointer to the output plaintext
* const Fq *B    : pointer to the input polynomial as part of ciphertext
* const int8 *T  : pointer to the input top bits of message encoded polynomial
* const small *a : pointer to the input secret-key polynomial
**************************************************/
static void Decrypt(int8 *r,const Fq *B,const int8 *T,const small *a)
{
  Fq aB[p];
  int i;
  Rq_mult_small(aB,B,a);
  for (i = 0;i < I;++i)
    r[i] = -int16_negative_mask(Fq_freeze(Right(T[i])-aB[i]+4*w+1));
}

#endif

/* ----- encoding I-bit inputs */

#ifdef LPR

#define Inputs_bytes (I/8)
typedef int8 Inputs[I]; /* passed by reference */

/*************************************************
* Name:        Inputs_encode
*
* Description: Compress r into the bitstring s
*
* Arguments:
* unsigned char *s : pointer to the output bitstring
* const Inputs *r  : pointer to the input byte array in {0,1}^I
**************************************************/
static void Inputs_encode(unsigned char *s,const Inputs r)
{
  int i;
  for (i = 0;i < Inputs_bytes;++i) s[i] = 0;
  for (i = 0;i < I;++i) s[i>>3] |= r[i]<<(i&7);
}



static const unsigned char aes_nonce[16] = {0};

/*************************************************
* Name:        Expand
*
* Description:
*
* Arguments:
* uint32 *L              : pointer to the output expanded array of random numbers
* const unsigned char *k : pointer to the input bitstring which is used as seed
**************************************************/
static void Expand(uint32 *L,const unsigned char *k)
{
  aes256ctx ctx;
  aes256_ctr_keyexp(&ctx, k);
  aes256_ctr((unsigned char *) L, 4*p, aes_nonce, &ctx);
}
static void Expand_publicinputs(uint32 *L,const unsigned char *k)
{
  aes256ctx_publicinputs ctx;
  aes256_ctr_keyexp_publicinputs(&ctx, k);
  aes256_ctr_publicinputs((unsigned char *) L, 4*p, aes_nonce, &ctx);
}

#define Seeds_bytes 32
/*************************************************
* Name:        Seeds_random
*
* Description: Generates Seeds_bytes random bytes in s
*
* Arguments:
* unsigned char *s: pointer to the output serialized public key
**************************************************/
static void Seeds_random(unsigned char *s)
{
  randombytes(s,Seeds_bytes);
}


/*************************************************
* Name:        Generator
*
* Description: Generate random polynomial G in R_q from the seed k
*
* Arguments:
* Fq *G                 : pointer to the output public-key polynomial
* const unsigned char *k: pointer to the input seed
**************************************************/
static void Generator_publicinputs(Fq *G,const unsigned char *k)
{
  uint32 L[p];
  int i;

  Expand_publicinputs(L,k);
  union llreg_u{
  uint32_t w32[2];
  uint64_t w64;
  } llr;
  for (i = 0;i < p;++i) {
    llr.w64 = __UMULL(q32inv, L[i]);
#ifndef __ARMEB__
    int qq = llr.w32[1];
#else
    int qq = llr.w32[0];
#endif
    G[i] = Fq_freeze_short(__MLS(qq, q, L[i])-q12);
  }
}

/*************************************************
* Name:        HashShort
*
* Description: Generate random polynomial out with coefficients in {-1,0,1} from input r
*
* Arguments:
* small *out      : pointer to the output polynomial with coefficients in {-1,0,1}
* const Inputs *r : pointer to the input byte array of input bits
**************************************************/
static void HashShort(small *out,const Inputs r)
{
  unsigned char s[Inputs_bytes];
  unsigned char h[Hash_bytes];
  uint32 L[p];

  Inputs_encode(s,r);
  Hash(h,5,s,sizeof s);
  Expand(L,h);
  Short_fromlist(out,L);
}


/*************************************************
* Name:        XKeyGen
*
* Description: Generates S and G then calls KeyGen
*
* Arguments:
* unsigned char *S : pointer to the output byte array, seed for generating G
* Fq *A            : pointer to the output polynomial A for public-key
* small *a         : pointer to the output polynomial a for secret-key
**************************************************/
static void XKeyGen(unsigned char *S,Fq *A,small *a)
{
  Fq G[p];

  Seeds_random(S);
  Generator_publicinputs(G,S);
  KeyGen(A,a,G);
}

/*************************************************
* Name:        XEncrypt
*
* Description: Generates G and b then calls Encrypt
*
* Arguments:
* Fq *B                  : pointer to the output polynomial as a part of ciphertext
* int8 *T                : pointer to the output top bits of message encoded polynomial
* const int8 *r          : pointer to the input serialized public key
* const unsigned char *S : pointer to the input byte array, seed for generating G
* const Fq *A            : pointer to the input polynomial
**************************************************/
static void XEncrypt(Fq *B,int8 *T,const int8 *r,const unsigned char *S,const Fq *A)
{
  Fq G[p];
  small b[p];

  Generator_publicinputs(G,S);
  HashShort(b,r);
  Encrypt(B,T,r,G,A,b);
}

#define XDecrypt Decrypt

#endif


#define Small_bytes ((p+3)/4)

/* these are the only functions that rely on p mod 4 = 1 */

/*************************************************
* Name:        Small_encode
*
* Description: Serialization of small polynomial into byte array
*
* Arguments:
* unsigned char *s : pointer to the output byte array
* const small *f   : pointer to the input small polynomial
**************************************************/
static void Small_encode(unsigned char *s,const small *f)
{
  small x;
  int i;


  int xx = 0x01010101;
  int x0, x1, x2, x3, y;
  int *ff = (int *)(void *)f;
  int *ss = (int *)(void *)s;
  for (i = (p/16); i>0; i--) {
    x1 = *(ff+1);
    x2 = *(ff+2);
    x3 = *(ff+3);
    x0 = *ff; ff+=4;
    x0 = __UADD8(x0, xx);
    x1 = __UADD8(x1, xx);
    x2 = __UADD8(x2, xx);
    x3 = __UADD8(x3, xx);
    y  = x0 + (x0 >> 6);
    y += (x0 >> 12);
    x0 = y+ (x0 >> 18);
    y  = x1 + (x1 >> 6);
    y += (x1 >> 12);
    x1 = y+ (x1 >> 18);
    y  = x2 + (x2 >> 6);
    y += (x2 >> 12);
    x2 = y+ (x2 >> 18);
    y  = x3 + (x3 >> 6);
    y += (x3 >> 12);
    x3 = y+ (x3 >> 18);
    x0 = __BFI(x0, x1, 8, 8);
    x0 = __BFI(x0, x2, 16, 8);
    x0 = __BFI(x0, x3, 24, 8);
    *ss++ = x0;
  }
  s = (unsigned char *)(void *)ss;
  for (i = ((p%16)/4); i>0; i--) {
    x0 = *(ff++);
    x0 = __UADD8(x0, xx);
    y  = x0 + (x0 >> 6);
    y += (x0 >> 12);
    x0 = y+ (x0 >> 18);
    *s++ = x0;
  }
  f = (small *)(void *)ff;
  x = *f++ + 1;
  *s++ = x;
}

/*************************************************
* Name:        Small_decode
*
* Description: De-serialization of small polynomial from byte array
*
* Arguments:
* small *f               : pointer to the output small polynomial
* const unsigned char *s : pointer to the input serialized small polynomial
**************************************************/
static void Small_decode(small *f,const unsigned char *s)
{
  unsigned char x;
  int i;

  int xx = 0x01010101;
  int xxx = 0x03030303;
  int xoxo = 0xff00ff00;
  int *ff = (int *)(void *)f;
  int *ss = (int *)(void *)s;
  for (i = (p/16); i>0; i--) {
    int y = *(ss++);
    int x00 = xxx & y;      // (f0, f4, f8, f12)
    int x01 = xxx & (y >> 2);   // (f1, f5, f9, f13)
    int x02 = xxx & (y >> 4);   // (f2, f6, f10, f14)
    int x03 = xxx & (y >> 6);   // (f3, f7, f11, f15)
    int x10 = __PKHBT(x00, x02, 16);  // (f0, f4, f2, f6)
    int x12 = __PKHTB(x02, x00, 16);  // (f8, f12, f10, f14)
    int x11 = __PKHBT(x01, x03, 16);  // (f1, f5, f3, f7)
    int x13 = __PKHTB(x03, x01, 16);  // (f9, f13, f11, f15)
    y = xoxo & (x11 << 8); int x0 = __USUB8(__UXTAB16(y, x10, 0), xx);
    y = xoxo & x11;        int x1 = __USUB8(__UXTAB16(y, x10, 8), xx);
    y = xoxo & (x13 << 8); int x2 = __USUB8(__UXTAB16(y, x12, 0), xx);
    y = xoxo & x13;        int x3 = __USUB8(__UXTAB16(y, x12, 8), xx);
    *(ff+1) = x1;
    *(ff+2) = x2;
    *(ff+3) = x3;
    *(ff)   = x0; ff += 4;
  }
  f = (small *)(void *)ff;
  s = (unsigned char *)(void *)ss;
  for (i = (p%16)/4; i>0 ; i--) {
    x = *s++;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1;
  }
  x = *s++;
  *f++ = ((small)(x&3))-1;
}


#ifndef LPR

/*************************************************
* Name:        Rq_encode
*
* Description: Serialization of a polynomial
*
* Arguments:
* unsigned char *s : pointer to the output serialized polynomial
* const Fq *r      : pointer to the input polynomial
**************************************************/
static void Rq_encode(unsigned char *s,const Fq *r)
{
  Encode_Rq_asm(s, (int16 *)r);
}

/*************************************************
* Name:        Rq_decode
*
* Description: De-serialization of a polynomial
*
* Arguments:
* Fq *r                  : pointer to the output polynomial
* const unsigned char *s : pointer to the input serialized polynomial
**************************************************/
static void Rq_decode(Fq *r,const unsigned char *s)
{
  Decode_Rq_asm((int16 *)r, s);
}

#endif

/*************************************************
* Name:        Rounded_encode
*
* Description: Compression and subsequent serialization of a polynomial
*
* Arguments:
* unsigned char *s : pointer to the output serialized polynomial
* const Fq *r      : pointer to the input  polynomial
**************************************************/
static void Rounded_encode(unsigned char *s,const Fq *r)
{
  Encode_Rounded_asm(s, (int16 *)r);
}

/*************************************************
* Name:        Rounded_decode
*
* Description: De-serialization and subsequent uncompression of a polynomial
*
* Arguments:
* int16 *R              : pointer to the output polynomial
* const unsigned char *s: pointer to the input serialized polynomial
**************************************************/
static void Rounded_decode(Fq *r,const unsigned char *s)
{
  Decode_Rounded_asm((int16 *)r, s);
}

/* ----- encoding top polynomials */

#ifdef LPR

#define Top_bytes (I/2)
/*************************************************
* Name:        Top_encode
*
* Description: Serialization of top polynomial
*
* Arguments:
* unsigned char *s : pointer to the output serialized top polynomial
* const int8 *T    : pointer to the input top polynomial
**************************************************/
static void Top_encode(unsigned char *s,const int8 *T)
{
  int i;
  for (i = 0;i < Top_bytes;++i)
    s[i] = T[2*i]+(T[2*i+1]<<4);
}

/*************************************************
* Name:        Top_decode
*
* Description: De-serialization of top polynomial
*
* Arguments:
* int8 *T                : pointer to the output top polynomial
* const unsigned char *s : pointer to the input serialized top polynomial
**************************************************/
static void Top_decode(int8 *T,const unsigned char *s)
{
  int i;
  for (i = 0;i < Top_bytes;++i) {
    T[2*i] = s[i]&15;
    T[2*i+1] = s[i]>>4;
  }
}

#endif

/* ----- Streamlined NTRU Prime Core plus encoding */

#ifndef LPR

typedef small Inputs[p]; /* passed by reference */
#define Inputs_random Short_random
#define Inputs_encode Small_encode
#define Inputs_bytes Small_bytes

#define Ciphertexts_bytes Rounded_bytes
#define SecretKeys_bytes (2*Small_bytes)
#define PublicKeys_bytes Rq_bytes

/*************************************************
* Name:        ZKeyGen
*
* Description: Calls keygen for Streamlined NTRU Prime and encode the keys
*
* Arguments:
* unsigned char *pk : pointer to the output public-key
* unsigned char *sk : pointer to the output secret-key
**************************************************/
static void ZKeyGen(unsigned char *pk,unsigned char *sk)
{
  Fq h[p];
  small f[p],v[p];

  KeyGen(h,f,v);
  Rq_encode(pk,h);
  Small_encode(sk,f); sk += Small_bytes;
  Small_encode(sk,v);
}

/*************************************************
* Name:        ZEncrypt
*
* Description: Decode public-key, call Envrypt and then encode ciphertext
*
* Arguments:
* unsigned char *C        : pointer to the output ciphertext
* const Inputs r          : pointer to the input plaintext
* const unsigned char *pk : pointer to the input public-key
**************************************************/
static void ZEncrypt(unsigned char *C,const Inputs r,const unsigned char *pk)
{
  Fq h[p];
  Fq c[p];
  Rq_decode(h,pk);
  Encrypt(c,r,h);
  Rounded_encode(C,c);
}


/*************************************************
* Name:        ZDecrypt
*
* Description: Decode secret-key and ciphertext then call Decrypt
*
* Arguments:
* Inputs r                : pointer to the output plaintext
* const unsigned char *C  : pointer to the input ciphertext
* const unsigned char *sk : pointer to the input secret-key
**************************************************/
static void ZDecrypt(Inputs r,const unsigned char *C,const unsigned char *sk)
{
  small f[p],v[p];
  Fq c[p];

  Small_decode(f,sk); sk += Small_bytes;
  Small_decode(v,sk);
  Rounded_decode(c,C);
  Decrypt(r,c,f,v);
}

#endif

/* ----- NTRU LPRime Expand plus encoding */

#ifdef LPR

#define Ciphertexts_bytes (Rounded_bytes+Top_bytes)
#define SecretKeys_bytes Small_bytes
#define PublicKeys_bytes (Seeds_bytes+Rounded_bytes)

/*************************************************
* Name:        Inputs_random
*
* Description: Random plaintext bits as elements of byte arrays
*
* Arguments:
* Inputs r : pointer to the output plaintext
**************************************************/
static void Inputs_random(Inputs r)
{
  unsigned char s[Inputs_bytes];
  int i;

  randombytes(s,sizeof s);
  for (i = 0;i < I;++i) r[i] = 1&(s[i>>3]>>(i&7));
}

/*************************************************
* Name:        Zkeygen
*
* Description: Call XKeygen then encode public-key and secret-key
*
* Arguments:
* unsigned char *pk : pointer to the output public-key
* unsigned char *sk : pointer to the ioutput secret-key
**************************************************/
static void ZKeyGen(unsigned char *pk,unsigned char *sk)
{
  Fq A[p];
  small a[p];

  XKeyGen(pk,A,a); pk += Seeds_bytes;
  Rounded_encode(pk,A);
  Small_encode(sk,a);
}

/*************************************************
* Name:        ZEncrypt
*
* Description: Decode public-key, call XEncrypt and then encode ciphertext
*
* Arguments:
* unsigned char *c        : pointer to the output ciphertext
* const Inputs r          : pointer to the input plaintext
* const unsigned char *pk : pointer to the input public-key
**************************************************/
static void ZEncrypt(unsigned char *c,const Inputs r,const unsigned char *pk)
{
  Fq A[p];
  Fq B[p];
  int8 T[I];

  Rounded_decode(A,pk+Seeds_bytes);
  XEncrypt(B,T,r,pk,A);
  Rounded_encode(c,B); c += Rounded_bytes;
  Top_encode(c,T);
}

/*************************************************
* Name:        ZDecrypt
*
* Description: Decode secret-key and ciphertext then call XDecrypt
*
* Arguments:
* Inputs r                : pointer to the output plaintext
* const unsigned char *c  : pointer to the input ciphertext
* const unsigned char *sk : pointer to the input secret-key
**************************************************/
static void ZDecrypt(Inputs r,const unsigned char *c,const unsigned char *sk)
{
  small a[p];
  Fq B[p];
  int8 T[I];

  Small_decode(a,sk);
  Rounded_decode(B,c);
  Top_decode(T,c+Rounded_bytes);
  XDecrypt(r,B,T,a);
}

#endif

/* ----- confirmation hash */

#define Confirm_bytes 32

/*************************************************
* Name:        HashConfirm
*
* Description: Computes hash_2 of r||cache, where cache is hash_4 of public-key
*
* Arguments:
* unsigned char *h           : pointer to the output hash
* const unsigned char *r     : pointer to the input byte array
* const unsigned char *cache : pointer to the input hash of public-key
**************************************************/
static void HashConfirm(unsigned char *h,const unsigned char *r,/*const unsigned char *pk,*/const unsigned char *cache)
{
#ifndef LPR
  unsigned char x[Hash_bytes*2];
  int i;

  Hash(x,3,r,Inputs_bytes);
  for (i = 0;i < Hash_bytes;++i) x[Hash_bytes+i] = cache[i];
#else
  unsigned char x[Inputs_bytes+Hash_bytes];
  int i;

  for (i = 0;i < Inputs_bytes;++i) x[i] = r[i];
  for (i = 0;i < Hash_bytes;++i) x[Inputs_bytes+i] = cache[i];
#endif
  Hash(h,2,x,sizeof x);
}

/* ----- session-key hash */

/* k = HashSession(b,y,z) */
/*************************************************
* Name:        HashSession
*
* Description: Generate session key
*
* Arguments:
* unsigned char *k       : pointer to the output session key
* int b                  : domain separetor
* const unsigned char *y : pointer to the input plaintext
* const unsigned char *z : pointer to the input ciphertext
**************************************************/
static void HashSession(unsigned char *k,int b,const unsigned char *y,const unsigned char *z)
{
#ifndef LPR
  unsigned char x[Hash_bytes+Ciphertexts_bytes+Confirm_bytes];
  int i;

  Hash(x,3,y,Inputs_bytes);
  for (i = 0;i < Ciphertexts_bytes+Confirm_bytes;++i) x[Hash_bytes+i] = z[i];
#else
  unsigned char x[Inputs_bytes+Ciphertexts_bytes+Confirm_bytes];
  int i;

  for (i = 0;i < Inputs_bytes;++i) x[i] = y[i];
  for (i = 0;i < Ciphertexts_bytes+Confirm_bytes;++i) x[Inputs_bytes+i] = z[i];
#endif
  Hash(k,b,x,sizeof x);
}

/* ----- Streamlined NTRU Prime and NTRU LPRime */

/*************************************************
* Name:        KEM_KeyGen
*
* Description: Key generation function for both Streamlined NTRU Prime
*              and NTRU LPRime
*
* Arguments:
* unsigned char *pk : pointer to the output public-key
* unsigned char *sk : pointer to the output secret-key
**************************************************/
static void KEM_KeyGen(unsigned char *pk,unsigned char *sk)
{
  int i;

  ZKeyGen(pk,sk); sk += SecretKeys_bytes;
  for (i = 0;i < PublicKeys_bytes;++i) *sk++ = pk[i];
  randombytes(sk,Inputs_bytes); sk += Inputs_bytes;
  Hash(sk,4,pk,PublicKeys_bytes);
}

/*************************************************
* Name:        Hide
*
* Description: Helper function for Encapsulation and decapsulation functions.
*              It computes ciphertext and HashConfirm for a given plaintext
*              and public-key
*
* Arguments:
* unsigned char *c           : pointer to the output ciphertext
* unsigned char *r_enc       : pointer to the output encoded plaintext
* const Inputs r             : pointer to the input plaintext
* const unsigned char *pk    : pointer to the input public-key
* const unsigned char *cache : pointer to the input hash of public-key
**************************************************/
static void Hide(unsigned char *c,unsigned char *r_enc,const Inputs r,const unsigned char *pk,const unsigned char *cache)
{
  Inputs_encode(r_enc,r);
  ZEncrypt(c,r,pk); c += Ciphertexts_bytes;
  HashConfirm(c,r_enc,/*pk,*/cache);
}

/*************************************************
* Name:        Encap
*
* Description: Encapsulation function for both Streamlined NTRU Prime
*              and NTRU LPRime
*
* Arguments:
* unsigned char *c        : pointer to the output ciphertext
* unsigned char *k        : pointer to the output session key
* const unsigned char *pk : pointer to the input public-key
**************************************************/
static void Encap(unsigned char *c,unsigned char *k,const unsigned char *pk)
{
  Inputs r;
  unsigned char r_enc[Inputs_bytes];
  unsigned char cache[Hash_bytes];

  Hash(cache,4,pk,PublicKeys_bytes);
  Inputs_random(r);
  Hide(c,r_enc,r,pk,cache);
  HashSession(k,1,r_enc,c);
}

/* 0 if matching ciphertext+confirm, else -1 */
/*************************************************
* Name:        Ciphertexts_diff_mask
*
* Description: Returns 0 if ciphertexts and Confirm bytes, -1 otherwise
*
* Arguments:
* const unsigned char *c  : pointer to the input first ciphertext
* const unsigned char *c2 : pointer to the input second ciphertext
**************************************************/
static int Ciphertexts_diff_mask(const unsigned char *c,const unsigned char *c2)
{
  uint16 differentbits = 0;
  int len = Ciphertexts_bytes+Confirm_bytes;

  int *cc = (int *)(void *)c;
  int *cc2 = (int *)(void *)c2;
  int differentbits2 = 0;
  for (len-=4 ;len>=0; len-=4) {
    differentbits2 = __USADA8((*cc++),(*cc2++),differentbits2);
  }
  c = (unsigned char *)(void *) cc;
  c2 = (unsigned char *)(void *) cc2;
  for (len &= 3; len > 0; len--)
    differentbits2 =__USADA8((*c++),(*c2++),differentbits2);
  return ((-1)-((differentbits2-1)>>31));
}

/*************************************************
* Name:        Decap
*
* Description: Decapsulation function for both Streamlined NTRU Prime
*              and NTRU LPRime
*
* Arguments:
* unsigned char *k        : pointer to the output session key
* const unsigned char *c  : pointer to the input ciphertext
* const unsigned char *sk : pointer to the input secret-key
**************************************************/
static void Decap(unsigned char *k,const unsigned char *c,const unsigned char *sk)
{
  const unsigned char *pk = sk + SecretKeys_bytes;
  const unsigned char *rho = pk + PublicKeys_bytes;
  const unsigned char *cache = rho + Inputs_bytes;
  Inputs r;
  unsigned char r_enc[Inputs_bytes];
  unsigned char cnew[Ciphertexts_bytes+Confirm_bytes];
  int mask;
  int i;

  ZDecrypt(r,c,sk);
  Hide(cnew,r_enc,r,pk,cache);
  mask = Ciphertexts_diff_mask(c,cnew);
  for (i = 0;i < Inputs_bytes;++i) r_enc[i] ^= mask&(r_enc[i]^rho[i]);
  HashSession(k,1+mask,r_enc,c);
}

/* ----- crypto_kem API */

#include "api.h"


int crypto_kem_keypair(unsigned char *pk,unsigned char *sk)
{
  KEM_KeyGen(pk,sk);
  return 0;
}

int crypto_kem_enc(unsigned char *c,unsigned char *k,const unsigned char *pk)
{
  Encap(c,k,pk);
  return 0;
}

int crypto_kem_dec(unsigned char *k,const unsigned char *c,const unsigned char *sk)
{
  Decap(k,c,sk);
  return 0;
}
