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

/* c*t0 with the loop over t0 outside: each t0 coefficient is unpacked once, without a second polynomial buffer. */
void poly_schoolbook(poly *c, const uint8_t ccomp[68], const uint8_t *t0){
  unsigned i,j,idx,pos,wrap;
  uint64_t signs = 0, s;
  int32_t t, mask;
  for(i = 0; i < N; i++) c->coeffs[i] = 0;
  for(i = 0; i < 8; i++) {
    signs |= ((uint64_t)ccomp[60+i]) << (8*i);
  }

  // loop over t0 outside: every coefficient of t0 is unpacked once
  for(j = 0; j < N; j++){
    t = polyt0_unpack_idx(t0, j);
    s = signs;
    for(idx = 0; idx < TAU; idx++){
      i = ccomp[idx];
      pos = i + j;
      wrap = pos >> 8;                        // 1 iff i + j >= N
      pos &= 0xFF;
      mask = -(int32_t)((s & 1) ^ wrap);      // 0 or -1
      c->coeffs[pos] += (t ^ mask) - mask;    // +t or -t
      s >>= 1;
    }
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


void unpack_sk_s1(smallpoly *a, const uint8_t *sk, size_t idx) {
  small_polyeta_unpack(a, sk + 2*SEEDBYTES + TRBYTES + idx*POLYETA_PACKEDBYTES);
}
void unpack_sk_s2(smallpoly *a, const uint8_t *sk, size_t idx) {
  small_polyeta_unpack(a, sk + 2*SEEDBYTES + TRBYTES + L*POLYETA_PACKEDBYTES + idx*POLYETA_PACKEDBYTES);
}


static inline int32_t make_hint_stack(int32_t z, int32_t r){
  int32_t r1, v1;

  r1 = highbits(r);
  v1 = highbits(r+z);

  if(r1 != v1) return 1;
  return 0;
}


/* Sample the challenge using caller-provided SHAKE state and 68 bytes of scratch
 * (storage the caller already has and does not use at this point), so that the call needs no SHAKE state
 * and no buffer of its own. */
void poly_challenge_extbuf(poly *c, const uint8_t seed[CTILDEBYTES], shake256incctx *state, uint8_t buf[68]) {
  unsigned int i, b, pos;
  uint64_t signs;

  shake256_inc_init(state);
  shake256_inc_absorb(state, seed, CTILDEBYTES);
  shake256_inc_finalize(state);
  shake256_inc_squeeze(buf, 68, state);

  signs = 0;
  for(i = 0; i < 8; ++i)
    signs |= (uint64_t)buf[i] << 8*i;
  pos = 8;

  for(i = 0; i < N; ++i)
    c->coeffs[i] = 0;
  for(i = N-TAU; i < N; ++i) {
    do {
      if(pos >= 68) {
        shake256_inc_squeeze(buf, 68, state);
        pos = 0;
      }

      b = buf[pos++];
    } while(b > i);

    c->coeffs[i] = c->coeffs[b];
    c->coeffs[b] = 1 - 2*(signs & 1);
    signs >>= 1;
  }
}

/* Samples a_ij from SHAKE128(seed, nonce) and accumulates a_ij * b into the 24-bit packed wcomp,
 * buflen bytes (a positive multiple of 3) of the stream per squeeze. */
static inline __attribute__((always_inline)) void polywadd_sample(uint8_t wcomp[3*N], const poly *b, const uint8_t seed[SEEDBYTES], uint16_t nonce, shake128incctx *state, uint8_t *buf, unsigned int buflen){
  unsigned int ctr = 0;
  stream128_init(state, seed, nonce);

  do {
    shake128_inc_squeeze(buf, buflen, state);
    ctr = asm_rej_mulacc24(wcomp, b->coeffs, ctr, buf, buflen);
  } while(ctr < N);
}

/* Verification: 20 candidates per squeeze, which keeps the stack below that of the former challenge sampling. */
void poly_uniform_pointwise_montgomery_polywadd_stack(uint8_t wcomp[3*N], const poly *b, const uint8_t seed[SEEDBYTES], uint16_t nonce, shake128incctx *state){
  uint8_t buf[3*20];
  polywadd_sample(wcomp, b, seed, nonce, state, buf, sizeof buf);
}

/* Signing: one SHAKE128 block (56 candidates) per squeeze. */
void poly_uniform_pointwise_montgomery_polywadd_block(uint8_t wcomp[3*N], const poly *b, const uint8_t seed[SEEDBYTES], uint16_t nonce, shake128incctx *state){
  uint8_t buf[SHAKE128_RATE];
  polywadd_sample(wcomp, b, seed, nonce, state, buf, sizeof buf);
}

void poly_uniform_gamma1_keep(poly *a, uint8_t ypacked[POLYZ_PACKEDBYTES], const uint8_t seed[CRHBYTES], uint16_t nonce, shake256incctx *state){
  stream256_init(state, seed, nonce);
  shake256_inc_squeeze(ypacked, POLYZ_PACKEDBYTES, state);
  polyz_unpack(a, ypacked);
}

/* z = y + cs1 inside the signature buffer: zy holds the packed mask y kept by poly_uniform_gamma1_keep and receives the packed z group by group.
 * Returns -1 at the first coefficient that reaches the bound (the slot is then partly overwritten; the attempt is discarded). */
int polyz_add_reduce_check_inplace(uint8_t zy[POLYZ_PACKEDBYTES], const smallpoly *cs1, int32_t bound){
#if GAMMA1 == (1 << 17)
  for(size_t i = 0; i < N/4; ++i) {
    uint32_t t[4];

    t[0]  = zy[9*i+0];
    t[0] |= (uint32_t)zy[9*i+1] << 8;
    t[0] |= (uint32_t)zy[9*i+2] << 16;
    t[0] &= 0x3FFFF;

    t[1]  = zy[9*i+2] >> 2;
    t[1] |= (uint32_t)zy[9*i+3] << 6;
    t[1] |= (uint32_t)zy[9*i+4] << 14;
    t[1] &= 0x3FFFF;

    t[2]  = zy[9*i+4] >> 4;
    t[2] |= (uint32_t)zy[9*i+5] << 4;
    t[2] |= (uint32_t)zy[9*i+6] << 12;
    t[2] &= 0x3FFFF;

    t[3]  = zy[9*i+6] >> 6;
    t[3] |= (uint32_t)zy[9*i+7] << 2;
    t[3] |= (uint32_t)zy[9*i+8] << 10;
    t[3] &= 0x3FFFF;

    for(size_t j = 0; j < 4; j++) {
      int32_t v = reduce32(GAMMA1 - (int32_t)t[j] + cs1->coeffs[4*i+j]);
      int32_t m = v >> 31;
      m = v - (m & 2*v);
      if(m >= bound) return -1;
      t[j] = GAMMA1 - v;
    }

    zy[9*i+0]  = t[0];
    zy[9*i+1]  = t[0] >> 8;
    zy[9*i+2]  = t[0] >> 16;
    zy[9*i+2] |= t[1] << 2;
    zy[9*i+3]  = t[1] >> 6;
    zy[9*i+4]  = t[1] >> 14;
    zy[9*i+4] |= t[2] << 4;
    zy[9*i+5]  = t[2] >> 4;
    zy[9*i+6]  = t[2] >> 12;
    zy[9*i+6] |= t[3] << 6;
    zy[9*i+7]  = t[3] >> 2;
    zy[9*i+8]  = t[3] >> 10;
  }
#elif GAMMA1 == (1 << 19)
  for(size_t i = 0; i < N/2; ++i) {
    uint32_t t[2];

    t[0]  = zy[5*i+0];
    t[0] |= (uint32_t)zy[5*i+1] << 8;
    t[0] |= (uint32_t)zy[5*i+2] << 16;
    t[0] &= 0xFFFFF;

    t[1]  = zy[5*i+2] >> 4;
    t[1] |= (uint32_t)zy[5*i+3] << 4;
    t[1] |= (uint32_t)zy[5*i+4] << 12;

    for(size_t j = 0; j < 2; j++) {
      int32_t v = reduce32(GAMMA1 - (int32_t)t[j] + cs1->coeffs[2*i+j]);
      int32_t m = v >> 31;
      m = v - (m & 2*v);
      if(m >= bound) return -1;
      t[j] = GAMMA1 - v;
    }

    zy[5*i+0]  = t[0];
    zy[5*i+1]  = t[0] >> 8;
    zy[5*i+2]  = t[0] >> 16;
    zy[5*i+2] |= t[1] << 4;
    zy[5*i+3]  = t[1] >> 4;
    zy[5*i+4]  = t[1] >> 12;
  }
#endif
  return 0;
}

/* wcomp <- w - c*s2 (24-bit packed, canonical) for a 16-bit c*s2.
 * Returns -1 at the first coefficient whose low bits r0 reach the bound (wcomp is then partly updated; the attempt is discarded). */
int polyw_sub_cs2_check_r0(uint8_t wcomp[3*N], const smallpoly *cs2, int32_t bound){
  for(size_t i = 0; i < N; i++){
    int32_t w_i  = wcomp[i*3 + 0];
    w_i |= (int32_t)wcomp[i*3 + 1] << 8;
    w_i |= (int32_t)wcomp[i*3 + 2] << 16;

    w_i -= cs2->coeffs[i];
    w_i = reduce32(w_i);
    w_i = caddq(w_i);

    wcomp[i*3 + 0] = (uint8_t)w_i;
    wcomp[i*3 + 1] = (uint8_t)(w_i >> 8);
    wcomp[i*3 + 2] = (uint8_t)(w_i >> 16);

    int32_t a0 = lowbits(w_i);
    a0 = reduce32(a0);
    int32_t t = a0 >> 31;
    t = a0 - (t & 2*a0);
    if(t >= bound) return -1;
  }
  return 0;
}

/* w is frozen, stored in the 24-bit packed form (as polyw_pack) and its high bits are packed into w1 (as polyw1_pack).
 * w1 may be w itself (w1 == (uint8_t *)w) or disjoint from w: every group is read completely before its
 * bytes are written, and those bytes lie below the next group. buf must not overlap w or w1. */
void polyw_pack_w1(uint8_t buf[3*256], uint8_t w1[POLYW1_PACKEDBYTES], const poly *w){
#if GAMMA2 == (Q-1)/88
  for(size_t i = 0; i < N/4; ++i) {
    int32_t t[4];
    for(size_t j = 0; j < 4; j++) {
      int32_t c = freeze(w->coeffs[4*i+j]);
      buf[(4*i+j)*3 + 0] = c;
      buf[(4*i+j)*3 + 1] = c >> 8;
      buf[(4*i+j)*3 + 2] = c >> 16;
      t[j] = highbits(c);
    }
    w1[3*i+0]  = t[0];
    w1[3*i+0] |= t[1] << 6;
    w1[3*i+1]  = t[1] >> 2;
    w1[3*i+1] |= t[2] << 4;
    w1[3*i+2]  = t[2] >> 4;
    w1[3*i+2] |= t[3] << 2;
  }
#elif GAMMA2 == (Q-1)/32
  for(size_t i = 0; i < N/2; ++i) {
    int32_t t[2];
    for(size_t j = 0; j < 2; j++) {
      int32_t c = freeze(w->coeffs[2*i+j]);
      buf[(2*i+j)*3 + 0] = c;
      buf[(2*i+j)*3 + 1] = c >> 8;
      buf[(2*i+j)*3 + 2] = c >> 16;
      t[j] = highbits(c);
    }
    w1[i] = t[0] | (t[1] << 4);
  }
#endif
}

/* c = c * a * 2^-32 coefficient-wise, a given in the 24-bit packed form of polyw_pack (canonical). */
void poly_pointwise_montgomery_polyw(poly *c, const uint8_t buf[3*256]){
  unsigned int i;
  for(i = 0; i < N; i++){
    int32_t a;
    a  = buf[i*3 + 0];
    a |= (int32_t)buf[i*3 + 1] << 8;
    a |= (int32_t)buf[i*3 + 2] << 16;
    c->coeffs[i] = montgomery_reduce((int64_t)a * c->coeffs[i]);
  }
}

/* Computes the hints of row k from c*t0 and the packed w - c*s2 and writes their indices directly into the signature.
 * hints_written is the running total over the rows. Returns -1 if the total would exceed OMEGA. */
int poly_make_hint_pack_stack(uint8_t *sig, unsigned int k,
                              unsigned int *hints_written,
                              const poly *ct0, const uint8_t w[768]){
  uint8_t *h_sig = sig + CTILDEBYTES + L*POLYZ_PACKEDBYTES;
  for(size_t i=0;i<N;i++){
    int32_t coeff =  w[i*3 + 0];
    coeff |= (int32_t)w[i*3 + 1] << 8;
    coeff |= (int32_t)w[i*3 + 2] << 16;

    // compute w - cs2 + c*t0
    coeff += ct0->coeffs[i];
    if(make_hint_stack(-ct0->coeffs[i], coeff)){
      if(*hints_written == OMEGA) {
        return -1;
      }
      h_sig[(*hints_written)++] = (uint8_t)i;
    }
  }
  h_sig[OMEGA + k] = (uint8_t)*hints_written;
  return 0;
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
