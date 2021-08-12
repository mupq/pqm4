#include "params.h"

#include "randombytes.h"
#include "sha2.h"
#ifdef LPR
#include "aes.h"
#endif

#include "int8.h"
#include "int16.h"
#include "int32.h"
#include "uint16.h"
#include "uint32.h"
#include "Encode.h"
#include "Decode.h"

extern int R3_recip_jumpdivsteps(int8* H, int8* G);
extern int Rq_recip3_jumpdivsteps(int8* H, int8* G);

/* ----- masks */

#ifndef LPR

/* return -1 if x!=0; else return 0 */
static int int16_nonzero_mask(int16 x)
{
  uint16 u = x; /* 0, else 1...65535 */
  uint32 v = u; /* 0, else 1...65535 */
  v = -v; /* 0, else 2^32-65535...2^32-1 */
  v >>= 31; /* 0, else 1 */
  return -v; /* 0, else -1 */
}

#endif

/* return -1 if x<0; otherwise return 0 */
static int int16_negative_mask(int16 x)
{
  uint16 u = x;
  u >>= 15;
  return -(int) u;
  /* alternative with gcc -fwrapv: */
  /* x>>15 compiles to CPU's arithmetic right shift */
}

/* ----- arithmetic mod 3 */

typedef int8 small;
#define q12 ((q-1)/2)
typedef int16 Fq;

#if 1
#include "arith.h"
#else
/* F3 is always represented as -1,0,1 */
/* so ZZ_fromF3 is a no-op */

/* x must not be close to top int16 */
static small F3_freeze(int16 x)
{
  return int32_mod_uint14(x+1,3)-1;
}

/* ----- arithmetic mod q */

/* always represented as -q12...q12 */
/* so ZZ_fromFq is a no-op */

/* x must not be close to top int32 */
static Fq Fq_freeze(int32 x)
{
  return int32_mod_uint14(x+q12,q)-q12;
}
#endif


/* ----- Top and Right */

#ifdef LPR
#define tau 16

static int8 Top(Fq C)
{
  return (tau1*(int32)(C+tau0)+16384)>>15;
}

static Fq Right(int8 T)
{
  return Fq_freeze(tau3*(int32)T-tau2);
}
#endif

/* ----- small polynomials */

#ifndef LPR

/* 0 if Weightw_is(r), else -1 */
static int Weightw_mask(small *r)
{
  int weight = 0;
  int i;

  for (i = 0;i < p;++i) weight += r[i]&1;
  return int16_nonzero_mask(weight-w);
}

/* R3_fromR(R_fromRq(r)) */
static void R3_fromRq(small *out,const Fq *r)
{
  int i;
  for (i = 0;i < p;++i) out[i] = F3_freeze(r[i]);
}

extern void copy_p_F3_mod3(const small *, small *, const small *, small *);
extern void gf_polymul_1024x1024_mod3(small *, small *, small *);
extern void reduce_2p_minus1_mod3_F3(small *, small *);
/* h = f*g in the ring R3 */
static void R3_mult(small *h,const small *f,const small *g)
{
  small fg[2048];
  small f_mod3[1024];
  small g_mod3[1024];
  int i;
  for(i=1013;i<1024;++i)f_mod3[i]=g_mod3[i]=0;
  copy_p_F3_mod3(f, f_mod3, g, g_mod3);
  gf_polymul_1024x1024_mod3(fg, f_mod3, g_mod3);
  reduce_2p_minus1_mod3_F3(h, fg); 
}


#endif

/* ----- polynomials mod q */
extern polymul_1013x1013_mod7177(Fq *h,const Fq *f,const small *g);
/* h = f*g in the ring Rq */
static void Rq_mult_small(Fq *h,const Fq *f,const small *g)
{
  polymul_1013x1013_mod7177(h,f,g);
}

#ifndef LPR

/* h = 3f in Rq */
static void Rq_mult3(Fq *h,const Fq *f)
{
  int i;

  for (i = 0;i < p;++i) h[i] = Fq_freeze(3*f[i]);
}

#endif

/* ----- rounded polynomials mod q */

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
extern void Short_fromlist_asm(small *out,const uint32 *in);
static void Short_fromlist(small *out,const uint32 *in)
{
  Short_fromlist_asm(out, in);
}

/* ----- underlying hash function */

#define Hash_bytes 32

/* e.g., b = 0 means out = Hash0(in) */
static void Hash(unsigned char *out,int b,const unsigned char *in,int inlen)
{
  unsigned char x[inlen+1];
  unsigned char h[64];
  int i;

  x[0] = b;
  for (i = 0;i < inlen;++i) x[i+1] = in[i];
  sha512(h,x,inlen+1);
  for (i = 0;i < 32;++i) out[i] = h[i];
}

/* ----- higher-level randomness */

static uint32 urandom32(void)
{
  unsigned char c[4];
  uint32 out[4];

  randombytes(c,4);
  out[0] = (uint32)c[0];
  out[1] = ((uint32)c[1])<<8;
  out[2] = ((uint32)c[2])<<16;
  out[3] = ((uint32)c[3])<<24;
  return out[0]+out[1]+out[2]+out[3];
}

static void Short_random(small *out)
{
  uint32 L[p];
  int i;

  for (i = 0;i < p;++i) L[i] = urandom32();
  Short_fromlist(out,L);
}

#ifndef LPR

static void Small_random(small *out)
{
  int i;

  for (i = 0;i < p;++i) out[i] = (((urandom32()&0x3fffffff)*3)>>30)-1;
}

#endif

/* ----- Streamlined NTRU Prime Core */

#ifndef LPR

/* h,(f,ginv) = KeyGen() */
static void KeyGen(Fq *h,small *f,small *ginv)
{
  small g[p];
  Fq finv[p];

  for (;;) {
    Small_random(g);
    if (R3_recip_jumpdivsteps(ginv,g) == 0) break;
  }
  Short_random(f);
  Rq_recip3_jumpdivsteps(finv,f); /* always works */
  Rq_mult_small(h,finv,g);
}

/* c = Encrypt(r,h) */
static void Encrypt(Fq *c,const small *r,const Fq *h)
{
  Fq hr[p];

  Rq_mult_small(hr,h,r);
  Round(c,hr);
}

/* r = Decrypt(c,(f,ginv)) */
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

  mask = Weightw_mask(ev); /* 0 if weight w, else -1 */
  for (i = 0;i < w;++i) r[i] = ((ev[i]^1)&~mask)^1;
  for (i = w;i < p;++i) r[i] = ev[i]&~mask;
}

#endif

/* ----- NTRU LPRime Core */

#ifdef LPR

/* (G,A),a = KeyGen(G); leaves G unchanged */
static void KeyGen(Fq *A,small *a,const Fq *G)
{
  Fq aG[p];

  Short_random(a);
  Rq_mult_small(aG,G,a);
  Round(A,aG);
}

/* B,T = Encrypt(r,(G,A),b) */
static void Encrypt(Fq *B,int8 *T,const int8 *r,const Fq *G,const Fq *A,const small *b)
{
  Fq bG[p];
  Fq bA[p];
  int i;

  Rq_mult_small(bG,G,b);
  Round(B,bG);
  Rq_mult_small(bA,A,b);
  for (i = 0;i < I;++i) T[i] = Top(Fq_freeze(bA[i]+r[i]*q12));
}

/* r = Decrypt((B,T),a) */
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

static void Inputs_encode(unsigned char *s,const Inputs r)
{
  int i;
  for (i = 0;i < Inputs_bytes;++i) s[i] = 0;
  for (i = 0;i < I;++i) s[i>>3] |= r[i]<<(i&7);
}

#endif

/* ----- Expand */

#ifdef LPR

static const unsigned char aes_nonce[16] = {0};

static void Expand(uint32 *L,const unsigned char *k)
{
  aes256ctx ctx;
  aes256_ctr_keyexp(&ctx, k);
  aes256_ctr((unsigned char *) L, 4*p, aes_nonce, &ctx);
}

#endif

/* ----- Seeds */

#ifdef LPR

#define Seeds_bytes 32

static void Seeds_random(unsigned char *s)
{
  randombytes(s,Seeds_bytes);
}

#endif

/* ----- Generator, HashShort */

#ifdef LPR

/* G = Generator(k) */
static void Generator(Fq *G,const unsigned char *k)
{
  uint32 L[p];
  int i;

  Expand(L,k);
  for (i = 0;i < p;++i) G[i] = uint32_mod_uint14(L[i],q)-q12;
}

/* out = HashShort(r) */
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

#endif

/* ----- NTRU LPRime Expand */

#ifdef LPR

/* (S,A),a = XKeyGen() */
static void XKeyGen(unsigned char *S,Fq *A,small *a)
{
  Fq G[p];

  Seeds_random(S);
  Generator(G,S);
  KeyGen(A,a,G);
}

/* B,T = XEncrypt(r,(S,A)) */
static void XEncrypt(Fq *B,int8 *T,const int8 *r,const unsigned char *S,const Fq *A)
{
  Fq G[p];
  small b[p];

  Generator(G,S);
  HashShort(b,r);
  Encrypt(B,T,r,G,A,b);
}

#define XDecrypt Decrypt

#endif

/* ----- encoding small polynomials (including short polynomials) */

#define Small_bytes ((p+3)/4)

/* these are the only functions that rely on p mod 4 = 1 */

static void Small_encode(unsigned char *s,const small *f)
{
  small x;
  int i;

  for (i = 0;i < p/4;++i) {
    x = *f++ + 1;
    x += (*f++ + 1)<<2;
    x += (*f++ + 1)<<4;
    x += (*f++ + 1)<<6;
    *s++ = x;
  }
  x = *f++ + 1;
  *s++ = x;
}

static void Small_decode(small *f,const unsigned char *s)
{
  unsigned char x;
  int i;

  for (i = 0;i < p/4;++i) {
    x = *s++;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1;
  }
  x = *s++;
  *f++ = ((small)(x&3))-1;
}

/* ----- encoding general polynomials */

#ifndef LPR

static void Rq_encode(unsigned char *s,const Fq *r)
{
  Encode_Rq_asm(s, (int16 *)r);

}

static void Rq_decode(Fq *r,const unsigned char *s)
{
  Decode_Rq_asm((int16 *)r, s);
}

#endif

/* ----- encoding rounded polynomials */

static void Rounded_encode(unsigned char *s,const Fq *r)
{
  Encode_Rounded_asm(s, (int16 *)r);
}

static void Rounded_decode(Fq *r,const unsigned char *s)
{
  Decode_Rounded_asm((int16 *)r, s);
}

/* ----- encoding top polynomials */

#ifdef LPR

#define Top_bytes (I/2)

static void Top_encode(unsigned char *s,const int8 *T)
{
  int i;
  for (i = 0;i < Top_bytes;++i)
    s[i] = T[2*i]+(T[2*i+1]<<4);
}

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

/* pk,sk = ZKeyGen() */
static void ZKeyGen(unsigned char *pk,unsigned char *sk)
{
  Fq h[p];
  small f[p],v[p];

  KeyGen(h,f,v);
  Rq_encode(pk,h);
  Small_encode(sk,f); sk += Small_bytes;
  Small_encode(sk,v);
}

/* C = ZEncrypt(r,pk) */
static void ZEncrypt(unsigned char *C,const Inputs r,const unsigned char *pk)
{
  Fq h[p];
  Fq c[p];
  Rq_decode(h,pk);
  Encrypt(c,r,h);
  Rounded_encode(C,c);
}

/* r = ZDecrypt(C,sk) */
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

static void Inputs_random(Inputs r)
{
  unsigned char s[Inputs_bytes];
  int i;

  randombytes(s,sizeof s);
  for (i = 0;i < I;++i) r[i] = 1&(s[i>>3]>>(i&7));
}

/* pk,sk = ZKeyGen() */
static void ZKeyGen(unsigned char *pk,unsigned char *sk)
{
  Fq A[p];
  small a[p];

  XKeyGen(pk,A,a); pk += Seeds_bytes;
  Rounded_encode(pk,A);
  Small_encode(sk,a);
}

/* c = ZEncrypt(r,pk) */
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

/* r = ZDecrypt(C,sk) */
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

/* h = HashConfirm(r,pk,cache); cache is Hash4(pk) */
static void HashConfirm(unsigned char *h,const unsigned char *r,const unsigned char *pk,const unsigned char *cache)
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

/* pk,sk = KEM_KeyGen() */
static void KEM_KeyGen(unsigned char *pk,unsigned char *sk)
{
  int i;

  ZKeyGen(pk,sk); sk += SecretKeys_bytes;
  for (i = 0;i < PublicKeys_bytes;++i) *sk++ = pk[i];
  randombytes(sk,Inputs_bytes); sk += Inputs_bytes;
  Hash(sk,4,pk,PublicKeys_bytes);
}

/* c,r_enc = Hide(r,pk,cache); cache is Hash4(pk) */
static void Hide(unsigned char *c,unsigned char *r_enc,const Inputs r,const unsigned char *pk,const unsigned char *cache)
{
  Inputs_encode(r_enc,r);
  ZEncrypt(c,r,pk); c += Ciphertexts_bytes;
  HashConfirm(c,r_enc,pk,cache);
}

/* c,k = Encap(pk) */
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
static int Ciphertexts_diff_mask(const unsigned char *c,const unsigned char *c2)
{
  uint16 differentbits = 0;
  int len = Ciphertexts_bytes+Confirm_bytes;

  while (len-- > 0) differentbits |= (*c++)^(*c2++);
  return (1&((differentbits-1)>>8))-1;
}

/* k = Decap(c,sk) */
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
