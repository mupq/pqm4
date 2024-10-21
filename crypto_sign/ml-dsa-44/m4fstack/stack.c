#include "stack.h"
#include "fips202.h"
#include "symmetric.h"
#include "vector.h"
#include "reduce.h"
#include "rounding.h"

void poly_challenge_compress(uint8_t c[68], const poly *cp){
  unsigned int i, pos;
  uint64_t signs;
  uint64_t mask;
  /* Encode c */
  for(i=0;i<68;i++) c[i] = 0;
  signs = 0;
  mask = 1;
  pos = 0;
  for(i = 0; i < N; ++i){
    if(cp->coeffs[i] != 0){
      c[pos++] = i;
      if(cp->coeffs[i] == -1){
        signs |= mask;
      }
      mask <<= 1;
    }
  }

  for (i = 0; i < 8; ++i) {
    c[60+i] = (unsigned char) (signs >> 8 * i);
  }
}

void poly_challenge_decompress(poly *cp, const uint8_t c[68]){
  unsigned int i;
  unsigned pos;
  uint64_t signs = 0;
  for(i = 0; i < N; i++) cp->coeffs[i] = 0;
  for(i = 0; i < 8; i++) {
    signs |= ((uint64_t)c[60+i]) << (8*i);
  }

  for(i = 0; i < TAU; i++){
    pos = c[i];
    if(signs & 1){
      cp->coeffs[pos] = -1;
    } else {
      cp->coeffs[pos] = 1;
    }
    signs >>= 1;
  }
}


// TODO: buffer at most 8 coeffs at once
static inline int32_t polyt0_unpack_idx(const uint8_t *t0, unsigned idx){
    int32_t coeff;
    // 8 coefficients are packed in 13 bytes
    t0 += 13*(idx >> 3);

    if(idx % 8 == 0){
        coeff  = t0[0];
        coeff |= (uint32_t)t0[1] << 8;
    } else if(idx % 8 == 1){
        coeff  = t0[1] >> 5;
        coeff |= (uint32_t)t0[2] << 3;
        coeff |= (uint32_t)t0[3] << 11;
    } else if(idx % 8 == 2){
        coeff  = t0[3] >> 2;
        coeff |= (uint32_t)t0[4] << 6;
    } else if(idx % 8 == 3){
        coeff  = t0[4] >> 7;
        coeff |= (uint32_t)t0[5] << 1;
        coeff |= (uint32_t)t0[6] << 9;
    } else if(idx % 8 == 4){
        coeff  = t0[6] >> 4;
        coeff |= (uint32_t)t0[7] << 4;
        coeff |= (uint32_t)t0[8] << 12;
    } else if(idx % 8 == 5){
        coeff  = t0[8] >> 1;
        coeff |= (uint32_t)t0[9] << 7;
    } else if(idx % 8 == 6){
        coeff  = t0[9] >> 6;
        coeff |= (uint32_t)t0[10] << 2;
        coeff |= (uint32_t)t0[11] << 10;
    } else if(idx % 8 == 7){
        coeff  = t0[11] >> 3;
        coeff |= (uint32_t)t0[12] << 5;
    }
    coeff &= 0x1FFF;
    return (1 << (D-1)) - coeff;
}

static inline int32_t polyt1_unpack_idx(const uint8_t *t1, unsigned idx){
    int32_t coeff;
    // 4 coefficients are packed in 5 bytes
    t1 += 5*(idx >> 2);

    if(idx % 4 == 0){
        coeff  = (t1[0] >> 0);
        coeff |= ((uint32_t)t1[1] << 8);
    } else if(idx % 4 == 1){
        coeff  =  (t1[1] >> 2);
        coeff |= ((uint32_t)t1[2] << 6);
    } else if(idx % 4 == 2){
        coeff  = (t1[2] >> 4);
        coeff |= ((uint32_t)t1[3] << 4);
    } else if(idx % 4 == 3){
        coeff  = (t1[3] >> 6);
        coeff |= ((uint32_t)t1[4] << 2);
    }
    coeff &= 0x3FF;
    return coeff;
}

void poly_schoolbook(poly *c, const uint8_t ccomp[68], const uint8_t *t0){
  unsigned i,j,idx;
  uint64_t signs = 0;
  for(i = 0; i < N; i++) c->coeffs[i] = 0;
  for(i = 0; i < 8; i++) {
    signs |= ((uint64_t)ccomp[60+i]) << (8*i);
  }

  for(idx = 0; idx < TAU; idx++){
    i = ccomp[idx];
    if(!(signs & 1)){
        for(j = 0; i+j < N; j++){
            c->coeffs[i+j] += polyt0_unpack_idx(t0, j);
        }
        for(j = N-i; j<N; j++){
            c->coeffs[i+j-N] -= polyt0_unpack_idx(t0, j);
        }
    } else {
        for(j = 0; i+j < N; j++){
            c->coeffs[i+j] -= polyt0_unpack_idx(t0, j);
        }
        for(j = N-i; j<N; j++){
            c->coeffs[i+j-N] += polyt0_unpack_idx(t0, j);
        }
    }

    signs >>= 1;
  }
}

void poly_schoolbook_t1(poly *c, const uint8_t ccomp[68], const uint8_t *t1){
  unsigned i,j,idx;
  uint64_t signs = 0;
  for(i = 0; i < N; i++) c->coeffs[i] = 0;
  for(i = 0; i < 8; i++) {
    signs |= ((uint64_t)ccomp[60+i]) << (8*i);
  }

  for(idx = 0; idx < TAU; idx++){
    i = ccomp[idx];
    if(!(signs & 1)){
        for(j = 0; i+j < N; j++){
            c->coeffs[i+j] += (polyt1_unpack_idx(t1, j) << D);
        }
        for(j = N-i; j<N; j++){
            c->coeffs[i+j-N] -= (polyt1_unpack_idx(t1, j) << D);
        }
    } else {
        for(j = 0; i+j < N; j++){
            c->coeffs[i+j] -= (polyt1_unpack_idx(t1, j) << D);
        }
        for(j = N-i; j<N; j++){
            c->coeffs[i+j-N] += (polyt1_unpack_idx(t1, j) << D);
        }
    }

    signs >>= 1;
  }
}


void polyw_pack(uint8_t buf[3*256], poly *w){
  poly_reduce(w);
  poly_caddq(w);
  unsigned int i;
  for(i = 0; i < N; i++){
    buf[i*3 + 0] = w->coeffs[i];
    buf[i*3 + 1] = w->coeffs[i] >> 8;
    buf[i*3 + 2] = w->coeffs[i] >> 16;
  }
}

void polyw_unpack(poly *w, const uint8_t buf[3*256]) {
  unsigned int i;
  for(i = 0; i < N; i++){
    w->coeffs[i] =  buf[i*3 + 0];
    w->coeffs[i] |= (int32_t)buf[i*3 + 1] << 8;
    w->coeffs[i] |= (int32_t)buf[i*3 + 2] << 16;
  }
}


static void polyw_add_idx(uint8_t buf[3*256], int32_t a, size_t i){
  int32_t coeff;
  coeff =  buf[i*3 + 0];
  coeff |= (int32_t)buf[i*3 + 1] << 8;
  coeff |= (int32_t)buf[i*3 + 2] << 16;

  coeff += a;

  coeff = freeze(coeff);

  buf[i*3 + 0] = coeff;
  buf[i*3 + 1] = coeff >> 8;
  buf[i*3 + 2] = coeff >> 16;
}

void polyw_add(uint8_t buf[3*256], poly *p){
  unsigned int i;
  for(i = 0; i < N; i++){
    polyw_add_idx(buf, p->coeffs[i], i);
  }
}
void polyw_sub(poly* c, uint8_t buf[3*256], poly *a){
  int32_t coeff;


  for(size_t i=0;i<N;i++){
    coeff =  buf[i*3 + 0];
    coeff |= (int32_t)buf[i*3 + 1] << 8;
    coeff |= (int32_t)buf[i*3 + 2] << 16;

    c->coeffs[i] = coeff - a->coeffs[i];
  }
}

static int32_t highbits(int32_t a){
  int32_t a1;

  a1  = (a + 127) >> 7;
#if GAMMA2 == (Q-1)/32
  a1  = (a1*1025 + (1 << 21)) >> 22;
  a1 &= 15;
#elif GAMMA2 == (Q-1)/88
  a1  = (a1*11275 + (1 << 23)) >> 24;
  a1 ^= ((43 - a1) >> 31) & a1;
#endif

  return a1;
}

void poly_highbits(poly *a1, const poly *a) {
  unsigned int i;

  for(i = 0; i < N; ++i)
    a1->coeffs[i] = highbits(a->coeffs[i]);
}

static int32_t lowbits(int32_t a){
  int32_t a1;
  int32_t a0;

  a1  = (a + 127) >> 7;
#if GAMMA2 == (Q-1)/32
  a1  = (a1*1025 + (1 << 21)) >> 22;
  a1 &= 15;
#elif GAMMA2 == (Q-1)/88
  a1  = (a1*11275 + (1 << 23)) >> 24;
  a1 ^= ((43 - a1) >> 31) & a1;
#endif

  a0  = a - a1*2*GAMMA2;
  a0 -= (((Q-1)/2 - a0) >> 31) & Q;
  return a0;
}

void poly_lowbits(poly *a0, const poly *a){
  unsigned int i;

  for(i = 0; i < N; ++i)
    a0->coeffs[i] = lowbits(a->coeffs[i]);
}

void unpack_sk_s1(smallpoly *a, const uint8_t *sk, size_t idx) {
  small_polyeta_unpack(a, sk + 2*SEEDBYTES + TRBYTES + idx*POLYETA_PACKEDBYTES);
}
void unpack_sk_s2(smallpoly *a, const uint8_t *sk, size_t idx) {
  small_polyeta_unpack(a, sk + 2*SEEDBYTES + TRBYTES + L*POLYETA_PACKEDBYTES + idx*POLYETA_PACKEDBYTES);
}


// TODO: in the end increase this buffer size as far as possible
#define POLY_UNIFORM_BUFFERSIZE 3
void poly_uniform_pointwise_montgomery_polywadd_stack(uint8_t wcomp[3*N], poly *b, const uint8_t seed[SEEDBYTES], uint16_t nonce, shake128incctx *state){
  int32_t t;
  uint8_t buf[POLY_UNIFORM_BUFFERSIZE*3];
  {
    size_t ctr = 0;
    stream128_init(state, seed, nonce);

    do {
      shake128_inc_squeeze(buf, sizeof buf, state);

      for(size_t pos=0; pos < sizeof buf && ctr < N; pos += 3){
        t  = buf[pos];
        t |= (uint32_t)buf[pos+1] << 8;
        t |= (uint32_t)buf[pos+2] << 16;
        t &= 0x7FFFFF;

        if(t < Q) {
          t = montgomery_reduce((int64_t)t * b->coeffs[ctr]);
          polyw_add_idx(wcomp, t, ctr);
          ctr++;
        }
      }
    } while(ctr < N);

  }
}

#define POLY_UNIFORM_GAMMA1_BUFFERSIZE 1
#if GAMMA1 == (1 << 17)
#define POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS (POLY_UNIFORM_GAMMA1_BUFFERSIZE*4)
#define POLY_UNIFORM_GAMMA1_BUFFERSIZE_BYTES  (POLY_UNIFORM_GAMMA1_BUFFERSIZE*9)
#elif GAMMA1 == (1 << 19)
#define POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS (POLY_UNIFORM_GAMMA1_BUFFERSIZE*2)
#define POLY_UNIFORM_GAMMA1_BUFFERSIZE_BYTES  (POLY_UNIFORM_GAMMA1_BUFFERSIZE*5)
#endif

static void polyz_unpack_inplace(int32_t *r){
  uint8_t *a = (uint8_t *)r;

  unsigned int i,j;
  #if GAMMA1 == (1 << 17)
  for(j = 0; j < POLY_UNIFORM_GAMMA1_BUFFERSIZE; ++j) {
    i = POLY_UNIFORM_GAMMA1_BUFFERSIZE-1-j;
    int32_t t0;


    r[4*i+3]  = a[9*i+6] >> 6;
    r[4*i+3] |= (uint32_t)a[9*i+7] << 2;
    r[4*i+3] |= (uint32_t)a[9*i+8] << 10;
    r[4*i+3] &= 0x3FFFF;

    r[4*i+2]   = a[9*i+4] >> 4;
    r[4*i+2]  |= (uint32_t)a[9*i+5] << 4;
    r[4*i+2]  |= (uint32_t)a[9*i+6] << 12;
    r[4*i+2]  &= 0x3FFFF;


    r[4*i+1] = (uint32_t)a[9*i+4] << 14;
    r[4*i+1] |= a[9*i+2] >> 2;
    r[4*i+1] |= (uint32_t)a[9*i+3] << 6;
    r[4*i+1] &= 0x3FFFF;

    t0  = a[9*i+0];
    t0 |= (uint32_t)a[9*i+1] << 8;
    t0 |= (uint32_t)a[9*i+2] << 16;
    t0 &= 0x3FFFF;

    r[4*i+0] = GAMMA1 - t0;
    r[4*i+1] = GAMMA1 - r[4*i+1];
    r[4*i+2] = GAMMA1 - r[4*i+2];
    r[4*i+3] = GAMMA1 - r[4*i+3];

  }
#elif GAMMA1 == (1 << 19)
  for(j = 0; j < POLY_UNIFORM_GAMMA1_BUFFERSIZE; ++j) {
    i = POLY_UNIFORM_GAMMA1_BUFFERSIZE-1-j;
    int32_t tmp0, tmp1;

    tmp0  = a[5*i+2] >> 4;
    tmp0 |= (uint32_t)a[5*i+3] << 4;
    tmp0 |= (uint32_t)a[5*i+4] << 12;
    tmp0 &= 0xFFFFF;

    tmp1  = a[5*i+0];
    tmp1 |= (uint32_t)a[5*i+1] << 8;
    tmp1 |= (uint32_t)a[5*i+2] << 16;
    tmp1 &= 0xFFFFF;

    r[2*i+0] = GAMMA1 - tmp1;
    r[2*i+1] = GAMMA1 - tmp0;
  }
#endif
}

void poly_uniform_gamma1_stack(poly *a, const uint8_t seed[CRHBYTES], uint16_t nonce, shake256incctx *state){
  int32_t buf[POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS];

  stream256_init(state, seed, nonce);
  for(size_t i = 0; i < N/POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS; i++){
    shake256_inc_squeeze((uint8_t *)buf, POLY_UNIFORM_GAMMA1_BUFFERSIZE_BYTES, state);
    polyz_unpack_inplace(buf);

    for(size_t j = 0; j < POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS; j++){
      a->coeffs[i*POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS + j] = buf[j];
    }
  }
}

void poly_uniform_gamma1_add_stack(poly *a, poly *b, const uint8_t seed[CRHBYTES], uint16_t nonce, shake256incctx *state){
  int32_t buf[POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS];

  stream256_init(state, seed, nonce);
  for(size_t i = 0; i < N/POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS; i++){
    shake256_inc_squeeze((uint8_t *)buf, POLY_UNIFORM_GAMMA1_BUFFERSIZE_BYTES, state);
    polyz_unpack_inplace(buf);

    for(size_t j = 0; j < POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS; j++){
      a->coeffs[i*POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS + j] = buf[j] + b->coeffs[i*POLY_UNIFORM_GAMMA1_BUFFERSIZE_COEFFS + j];
    }
  }
}


static inline int32_t make_hint_stack(int32_t z, int32_t r){
  int32_t r1, v1;

  r1 = highbits(r);
  v1 = highbits(r+z);

  if(r1 != v1) return 1;
  return 0;
}

size_t poly_make_hint_stack(poly *a, poly *t, uint8_t w[768]){
  int32_t coeff;
  size_t hints_n = 0;
  for(size_t i=0;i<N;i++){
    // unpack coeff from w (contains w - cs2)
    coeff =  w[i*3 + 0];
    coeff |= (int32_t)w[i*3 + 1] << 8;
    coeff |= (int32_t)w[i*3 + 2] << 16;


    // compute w - cs2 + c*t0
    coeff  = coeff + t->coeffs[i];

    a->coeffs[i] = make_hint_stack(-t->coeffs[i], coeff);
    if(a->coeffs[i] == 1){
      hints_n++;
    }
  }
  return hints_n;
}

/*************************************************
* Name:        unpack_sig_h_indices
*
* Description: Unpack only h from signature sig = (c, z, h).
*
* Arguments:   - polyveck *h: pointer to output hint vector h
*              - const unsigned char sig[]: byte array containing
*                bit-packed signature
*
* Returns 1 in case of malformed signature; otherwise 0.
**************************************************/
int unpack_sig_h_indices(uint8_t h_i[OMEGA], unsigned int * number_of_hints, unsigned int idx, const unsigned char sig[CRYPTO_BYTES]) {
    sig += L * POLYZ_PACKEDBYTES;
    sig += CTILDEBYTES;
    /* Decode h */
    unsigned int k = 0;
    unsigned int hidx = 0;

    if (idx > 0)
    {
        k = sig[OMEGA + (idx - 1)];
    }

    if (sig[OMEGA + idx] < k || sig[OMEGA + idx] > OMEGA) {
        return 1;
    }

    for (unsigned int j = k; j < sig[OMEGA + idx]; ++j) {
        /* Coefficients are ordered for strong unforgeability */
        if (j > k && sig[j] <= sig[j - 1]) {
            return 1;
        }
        h_i[hidx++] = sig[j];
    }

    *number_of_hints = hidx;

    /* TODO: extract this check, redundant here */
    k = sig[OMEGA + (K - 1)];
    /* Extra indices are zero for strong unforgeability */
    for (unsigned int j = k; j < OMEGA; ++j) {
        if (sig[j]) {
            return 1;
        }
    }
    return 0;
}

/*************************************************
* Name:        poly_use_hint_stack
*
* Description: Use hint polynomial to correct the high bits of a polynomial.
*
* Arguments:   - poly *b: pointer to output polynomial with corrected high bits
*              - const poly *a: pointer to input polynomial
*              - const poly *h: pointer to input hint polynomial
**************************************************/
void poly_use_hint_stack(poly *b, const poly *a, uint8_t h_i[OMEGA], unsigned int number_of_hints) {
  unsigned int i;
  unsigned int in_list;

  for(i = 0; i < N; ++i)
  {
    in_list = 0;
    for (size_t hidx = 0; hidx < number_of_hints; hidx++)
    {
      if (i == h_i[hidx])
      {
        in_list = 1;
        break;
      }
    }
    if (in_list)
    {
      b->coeffs[i] = use_hint(a->coeffs[i], 1);
    }
    else
    {
      b->coeffs[i] = use_hint(a->coeffs[i], 0);
    }
    
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
    for (unsigned int i = 0; i < SEEDBYTES; ++i) {
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
*              - const unsigned int idx: index to the elem to pack
**************************************************/
void pack_pk_t1(unsigned char pk[CRYPTO_PUBLICKEYBYTES],
             const poly *t1,
             const unsigned int idx) {
    pk += SEEDBYTES;
    polyt1_pack(pk + idx * POLYT1_PACKEDBYTES, t1);
}

/*************************************************
* Name:        pack_sk_s1
*
* Description: Bit-pack only some element of s1 in secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: output byte array
*              - const poly *s1_elem: pointer to vector element idx in s1
*              - const unisgned int idx: index to the element of s1 that should be packed
**************************************************/
void pack_sk_s1(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *s1_elem,
                const unsigned int idx) {
    sk += 2 * SEEDBYTES + TRBYTES;
    polyeta_pack(sk + idx * POLYETA_PACKEDBYTES, s1_elem);
}

/*************************************************
* Name:        pack_sk_s2
*
* Description: Bit-pack only some element of s2 in secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: output byte array
*              - const poly *s2_elem: pointer to vector element idx in s2
*              - const unsigned int idx: index to the element of s1 that should be packed
**************************************************/
void pack_sk_s2(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *s2_elem,
                const unsigned int idx) {
    sk += 2 * SEEDBYTES + TRBYTES + L * POLYETA_PACKEDBYTES;
    polyeta_pack(sk + idx * POLYETA_PACKEDBYTES, s2_elem);
}

/*************************************************
* Name:        pack_sk_t0
*
* Description: Bit-pack only some element of t0 in secret key sk = (rho, key, tr, s1, s2, t0).
*
* Arguments:   - unsigned char sk[]: output byte array
*              - const poly *t0_elem: pointer to vector element idx in s2
*              - const unsigned int idx: index to the element of s1 that should be packed
**************************************************/
void pack_sk_t0(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *t0_elem,
                const unsigned int idx) {
    sk += 2 * SEEDBYTES + TRBYTES + L * POLYETA_PACKEDBYTES + K * POLYETA_PACKEDBYTES;
    polyt0_pack(sk + idx * POLYT0_PACKEDBYTES, t0_elem);
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
  for (unsigned int i = 0; i < SEEDBYTES; ++i) {
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
    for (unsigned int i = 0; i < SEEDBYTES; ++i) {
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
                const unsigned char tr[TRBYTES]) {
    sk += 2*SEEDBYTES;
    for (unsigned int i = 0; i < TRBYTES; ++i) {
        sk[i] = tr[i];
    }
}

/*************************************************
* Name:        challenge
*
* Description: Implementation of H. Samples polynomial with TAU nonzero
*              coefficients in {-1,1} using the output stream of
*              SHAKE256(seed). Stack optimized.
*
* Arguments:   - poly *c: pointer to output polynomial
*              - const uint8_t mu[]: byte array containing seed of length SEEDBYTES
**************************************************/
#define CHALLENGE_STACK_BUF_SIZE 8
void poly_challenge_stack(poly *c, const uint8_t seed[CTILDEBYTES]) {
  unsigned int i, b, pos;
  uint64_t signs;
  uint8_t buf[CHALLENGE_STACK_BUF_SIZE];
  shake256incctx state;

  shake256_inc_init(&state);
  shake256_inc_absorb(&state, seed, CTILDEBYTES);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(buf, CHALLENGE_STACK_BUF_SIZE, &state);
  signs = 0;
  for(i = 0; i < 8; ++i)
  {
    signs |= (uint64_t)buf[i] << 8*i;
  }
  pos = 8;

  for(i = 0; i < N; ++i)
    c->coeffs[i] = 0;
  for(i = N-TAU; i < N; ++i) {
    do {
      if(pos >= CHALLENGE_STACK_BUF_SIZE) {
        shake256_inc_squeeze(buf, CHALLENGE_STACK_BUF_SIZE, &state);
        pos = 0;
      }

      b = buf[pos++];
    } while(b > i);

    c->coeffs[i] = c->coeffs[b];
    c->coeffs[b] = 1 - 2*(signs & 1);
    signs >>= 1;
  }
}