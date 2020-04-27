#include "params.h"
#include "randombytes.h"
#include "sha512_hash.h"
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
#include <string.h>
#include "cmsis.h"

extern void gf_polymul_768x768_1s(int16 *h, int16 *c, int16 *f);
extern void gf_polymul_768x768_mod3(int8 *h, int8 *c, int8 *f);
extern int Rq_recip3_jumpdivsteps(int16 *h, int8 *c);
extern int R3_recip_jumpdivsteps(int8* H, int8* G);
extern void Rq_redp(int16 *h, const int16 *f);
extern void Rq_mult3_asm(int16 *h, const int16 *f);
extern void Rq_mov(int16 *h, const int16 *f);
extern void Rq_fromR3(int16 *h, const int8 *f);
extern int Weightw_mask_asm(int8 *ev);
extern void copy_p_F3_mod3(int8 *f, int8 *fp, int8 *g, int8 *gp);
extern void reduce_2p_minus1_mod3_F3(int8 *h, int8 *fg);
extern void Short_fromlist_asm(int8 *out,const uint32 *in);

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

typedef int8 small;
#define q12 ((q-1)/2)
typedef int16 Fq;

#if 1
#include "arith.h"
#else
/* ----- arithmetic mod 3 */
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
#define F3_freeze_short F3_freeze
#define Fq_freeze_short Fq_freeze
#endif

#ifndef LPR

static Fq Fq_recip(Fq a1)
{
  int i = 1;
  Fq ai = a1;

  while (i < q-2) {
    ai = Fq_freeze(a1*(int32)ai);
    i += 1;
  }
  return ai;
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

#if 1
  int i;
  for (i = 0;i < p;++i) out[i] = F3_freeze_short(r[i]);
#else
 XXX todo
#endif
}

/* h = f*g in the ring R3 */
static void R3_mult(small *h,const small *f,const small *g)
{
#if 0
  small fg[p+p-1];
  small result;
  int i,j;

  for (i = 0;i < p;++i) {
    result = 0;
    for (j = 0;j <= i;++j) result = F3_freeze(result+f[j]*g[i-j]);
    fg[i] = result;
  }
  for (i = p;i < p+p-1;++i) {
    result = 0;
    for (j = i-p+1;j < p;++j) result = F3_freeze(result+f[j]*g[i-j]);
    fg[i] = result;
  }

  for (i = p+p-2;i >= p;--i) {
    fg[i-p] = F3_freeze_short(fg[i-p]+fg[i]);
    fg[i-p+1] = F3_freeze_short(fg[i-p+1]+fg[i]);
  }
  for (i = 0;i < p;++i) h[i] = fg[i];
#else
  small fg[1536];
  small f_mod3[768];
  small g_mod3[768];
  int i;
  /*
  for (i = 0; i < p; ++i) {
    f_mod3[i] = F3_freeze_short(f[i] - 1) + 1;
    g_mod3[i] = F3_freeze_short(g[i] - 1) + 1;
  }
  for (; i < 768; ++i) {
    f_mod3[i] = 0;
    g_mod3[i] = 0;
  }
  */
  copy_p_F3_mod3(f, f_mod3, g, g_mod3);
  gf_polymul_768x768_mod3(fg, f_mod3, g_mod3);
  reduce_2p_minus1_mod3_F3(h, fg);
#endif
}

/* returns 0 if recip succeeded; else -1 */
static int R3_recip(small *out,const small *in)
{
  small f[p+1],g[p+1],v[p+1],r[p+1];
  int i,loop,delta;
  int sign,swap,t;

  for (i = 0;i < p+1;++i) v[i] = 0;
  for (i = 0;i < p+1;++i) r[i] = 0;
  r[0] = 1;
  for (i = 0;i < p;++i) f[i] = 0;
  f[0] = 1; f[p-1] = f[p] = -1;
  for (i = 0;i < p;++i) g[p-1-i] = in[i];
  g[p] = 0;

  delta = 1;

  for (loop = 0;loop < 2*p-1;++loop) {
    for (i = p;i > 0;--i) v[i] = v[i-1];
    v[0] = 0;

    sign = -g[0]*f[0];
    swap = int16_negative_mask(-delta) & int16_nonzero_mask(g[0]);
    delta ^= swap&(delta^-delta);
    delta += 1;

    for (i = 0;i < p+1;++i) {
      t = swap&(f[i]^g[i]); f[i] ^= t; g[i] ^= t;
      t = swap&(v[i]^r[i]); v[i] ^= t; r[i] ^= t;
    }

    for (i = 0;i < p+1;++i) g[i] = F3_freeze(g[i]+sign*f[i]);
    for (i = 0;i < p+1;++i) r[i] = F3_freeze(r[i]+sign*v[i]);

    for (i = 0;i < p;++i) g[i] = g[i+1];
    g[p] = 0;
  }

  sign = f[0];
  for (i = 0;i < p;++i) out[i] = sign*v[p-1-i];

  return int16_nonzero_mask(delta);
}

#endif

/* ----- polynomials mod q */

/* h = f*g in the ring Rq */
static void Rq_mult_small(Fq *h,const Fq *f,const small *g)
{
#if 0

  Fq fg[p+p-1];
  Fq result;
  int i,j;

  for (i = 0;i < p;++i) {
    result = 0;
    for (j = 0;j <= i;++j) result = Fq_freeze(result+f[j]*(int32)g[i-j]);
    fg[i] = result;
  }
  for (i = p;i < p+p-1;++i) {
    result = 0;
    for (j = i-p+1;j < p;++j) result = Fq_freeze(result+f[j]*(int32)g[i-j]);
    fg[i] = result;
  }

  for (i = p+p-2;i >= p;--i) {
    fg[i-p] = Fq_freeze_short(fg[i-p]+fg[i]);
    fg[i-p+1] = Fq_freeze_short(fg[i-p+1]+fg[i]);
  }

  for (i = 0;i < p;++i) h[i] = fg[i];
#else
  Fq f_modq[768];
  Fq g_modq[768];
  Fq fg[1536];
  int i;
  /*
  for (i = 0; i < p; ++i) {
    f_modq[i] = f[i];
    g_modq[i] = (Fq)g[i];
  }
  for (; i < 768; ++i) {
    f_modq[i] = 0;
    g_modq[i] = 0;
  }
  */
  Rq_mov(f_modq, f);
  Rq_fromR3(g_modq, g);
  gf_polymul_768x768_1s(fg, f_modq, g_modq);

  Rq_redp(h, fg);
#endif
}

#ifndef LPR

/* h = 3f in Rq */
static void Rq_mult3(Fq *h,const Fq *f)
{
  Rq_mult3_asm(h, f);
  /*
  int i;

  for (i = 0;i < p;++i) h[i] = Fq_freeze_short(3*f[i]);
  */
}

/* out = 1/(3*in) in Rq */
/* returns 0 if recip succeeded; else -1 */
static int Rq_recip3(Fq *out,const small *in)
{
  Fq f[p+1],g[p+1],v[p+1],r[p+1];
  int i,loop,delta;
  int swap,t;
  int32 f0,g0;
  Fq scale;

  for (i = 0;i < p+1;++i) v[i] = 0;
  for (i = 0;i < p+1;++i) r[i] = 0;
  r[0] = Fq_recip(3);
  for (i = 0;i < p;++i) f[i] = 0;
  f[0] = 1; f[p-1] = f[p] = -1;
  for (i = 0;i < p;++i) g[p-1-i] = in[i];
  g[p] = 0;

  delta = 1;

  for (loop = 0;loop < 2*p-1;++loop) {
    for (i = p;i > 0;--i) v[i] = v[i-1];
    v[0] = 0;

    swap = int16_negative_mask(-delta) & int16_nonzero_mask(g[0]);
    delta ^= swap&(delta^-delta);
    delta += 1;

    for (i = 0;i < p+1;++i) {
      t = swap&(f[i]^g[i]); f[i] ^= t; g[i] ^= t;
      t = swap&(v[i]^r[i]); v[i] ^= t; r[i] ^= t;
    }

    f0 = f[0];
    g0 = g[0];
    for (i = 0;i < p+1;++i) g[i] = Fq_freeze(f0*g[i]-g0*f[i]);
    for (i = 0;i < p+1;++i) r[i] = Fq_freeze(f0*r[i]-g0*v[i]);

    for (i = 0;i < p;++i) g[i] = g[i+1];
    g[p] = 0;
  }

  scale = Fq_recip(f[0]);
  for (i = 0;i < p;++i) out[i] = Fq_freeze(scale*(int32)v[p-1-i]);

  return int16_nonzero_mask(delta);
}

#endif

/* ----- rounded polynomials mod q */

static void Round(Fq *out,const Fq *a)
{
  int i;
#if 0
  for (i = 0; i < p;++i) out[i] = a[i]-F3_freeze_short(a[i]);
#else
  int *o1 = (int *)(void *)out;
  int *a1 = (int *)(void *)a;

  for (i = (p-1)/2; i>0; i--) {
    *(o1++) = F3_round_x2(*(a1++));
  }
  out = (Fq *)(void *) o1;
  a = (Fq *)(void *) a1;
  *out = F3_round_x2(*a);

#endif
}

/* ----- sorting to generate short polynomial */

static void Short_fromlist(small *out,const uint32 *in)
{
#if 1
  Short_fromlist_asm(out, in);
#else
  uint32 L[p];
  int i;

  for (i = 0;i < w;++i) L[i] = in[i]&(uint32)-2;
#if 1
  int32 mask_01 = 1;
  for (i = w;i < p;++i) L[i] = __BFI(in[i], mask_01, 0, 2);
#else
  for (i = w;i < p;++i) L[i] = (in[i]&(uint32)-3)|1;
#endif
  uint32_sort(L,p);
  for (i = 0;i < p;++i) out[i] = (L[i]&3)-1;
#endif
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
  //memcpy(x+1, in, inlen);
  sha512_hash(h,x,inlen+1);
  for (i = 0;i < 32;++i) out[i] = h[i];
  //sha512_hash(out,x,inlen+1);
}

/* ----- higher-level randomness */

static uint32 urandom32(void)
{
  unsigned char c[4];
  uint32 out[4];

  randombytes(c,4);

#if 0
  out[0] = (uint32)c[0];
  out[1] = ((uint32)c[1])<<8;
  out[2] = ((uint32)c[2])<<16;
  out[3] = ((uint32)c[3])<<24;
  return out[0]+out[1]+out[2]+out[3];
#else
  return *((int *)c);
#endif
}

static void Short_random(small *out)
{
  uint32 L[p];
  int i;

#if 0
  for (i = 0;i < p;++i) L[i] = urandom32();
#else
  randombytes(L, 4*p);
#endif
  Short_fromlist(out,L);
}

#ifndef LPR

static void Small_random(small *out)
{
  int i;

#if 0
  for (i = 0;i < p;++i) out[i] = (((urandom32()&0x3fffffff)*3)>>30)-1;
#else
  int *o1 = (int *)(void *)out;
  int x0, x1, x2, x3;
  int L[4];

  for (i = (p-1)/4; i>0; i--) {
    randombytes((small *)(void*)L, 16);
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
#endif
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
    // if (R3_recip(ginv,g) == 0) break;
    if (R3_recip_jumpdivsteps(ginv,g) == 0) break;
  }
  Short_random(f);
  // Rq_recip3(finv,f); /* always works */
  Rq_recip3_jumpdivsteps(finv,f);
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

  mask = //Weightw_mask(ev); /* 0 if weight w, else -1 */
    Weightw_mask_asm(ev);
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
#if 0
  for (i = 0;i < p;++i) G[i] = uint32_mod_uint14(L[i],q)-q12;
#else
  int x0, x1;
  int c = 65536 % q;  if (c > q/2) c -= q;
  for (i = 0;i < p;++i) {
    x1 = (int) (L[i] >> 16) + minusinv65536modq;
    x0 = __UXTH(L[i], 0);
    x0 = __MLA(x1, c, x0);
    G[i] = Fq_freeze(x0);
  }
#endif
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


#if 0
  for (i = 0;i < p/4;++i) {
    x = *f++ + 1;
    x += (*f++ + 1)<<2;
    x += (*f++ + 1)<<4;
    x += (*f++ + 1)<<6;
    *s++ = x;
  }
  x = *f++ + 1;
  *s++ = x;
#else
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
  s = (small *)(void *)ss;
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
#endif
}

static void Small_decode(small *f,const unsigned char *s)
{
  unsigned char x;
  int i;

#if 0
  for (i = 0;i < p/4;++i) {
    x = *s++;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1;
  }
  x = *s++;
  *f++ = ((small)(x&3))-1;

#else
  int xx = 0x01010101;
  int xxx = 0x03030303;
  int xoxo = 0xff00ff00;
  int *ff = (int *)(void *)f;
  int *ss = (int *)(void *)s;
  for (i = (p/16); i>0; i--) {
    int y = *(ss++);
    int x00 = xxx & y;			// (f0, f4, f8, f12)
    int x01 = xxx & (y >> 2);		// (f1, f5, f9, f13)
    int x02 = xxx & (y >> 4);		// (f2, f6, f10, f14)
    int x03 = xxx & (y >> 6);		// (f3, f7, f11, f15)
    int x10 = __PKHBT(x00, x02, 16);	// (f0, f4, f2, f6)
    int x12 = __PKHTB(x02, x00, 16);	// (f8, f12, f10, f14)
    int x11 = __PKHBT(x01, x03, 16);	// (f1, f5, f3, f7)
    int x13 = __PKHTB(x03, x01, 16);	// (f9, f13, f11, f15)
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
  s = (small *)(void *)ss;
  for (i = (p%16)/4; i>0 ; i--) {
    x = *s++;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1; x >>= 2;
    *f++ = ((small)(x&3))-1;
  }
  x = *s++;
  *f++ = ((small)(x&3))-1;
#endif
}

/* ----- encoding general polynomials */

#ifndef LPR

static void Rq_encode(unsigned char *s,const Fq *r)
{
  Encode_Rq(s, (int16 *)r);
}

static void Rq_decode(Fq *r,const unsigned char *s)
{
  Decode_Rq((int16 *)r, s);
}

#endif

/* ----- encoding rounded polynomials */

static void Rounded_encode(unsigned char *s,const Fq *r)
{
  Encode_Rounded(s, (int16 *)r);
}

static void Rounded_decode(Fq *r,const unsigned char *s)
{
  Decode_Rounded((int16 *)r, s);
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

#if 0
  while (len-- > 0) differentbits |= (*c++)^(*c2++);
  return (1&((differentbits-1)>>8))-1;
#else
  int *cc = (int *)(void *)c;
  int *cc2 = (int *)(void *)c2;
  int differentbits2 = 0;
  for (len-=4 ;len>=0; len-=4) {
    differentbits2 = __USADA8((*cc++),(*cc2++),differentbits2);
    //int scr0, scr1;
    //__asm__ volatile ("ldr %3, [%1], #4\n\t"				\
    //		      "ldr %4, [%2], #4\n\t"				\
    //		      "eor %3, %3, %4 \n\t"				\
    //		      "orr %0, %0, %3 \n\t"				\
    //		      :"+&r"(differentbits2), "+r"(cc), "+r"(cc2),	\
    //		       "=r" (scr0), "=r"(scr1)				\
    //		      ::);
  }
  c = (unsigned char *)(void *) cc;
  c2 = (unsigned char *)(void *) cc2;
  for (len &= 3; len > 0; len--)
    differentbits2 =__USADA8((*c++),(*c2++),differentbits2);
  return ((-1)-((differentbits-1)>>31));
#endif


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
