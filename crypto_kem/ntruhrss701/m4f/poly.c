#include "poly.h"
#include "fips202.h"
#include "verify.h"

#include "NTT_params.h"
#include "NTT.h"

uint16_t mod3(uint16_t a) {
    uint16_t r;
    int16_t t, c;

    r = (a >> 8) + (a & 0xff); // r mod 255 == a mod 255
    r = (r >> 4) + (r & 0xf); // r' mod 15 == r mod 15
    r = (r >> 2) + (r & 0x3); // r' mod 3 == r mod 3
    r = (r >> 2) + (r & 0x3); // r' mod 3 == r mod 3

    t = r - 3;
    c = t >> 15;

    return (c & r) ^ (~c & t);
}

/* Map {0, 1, 2} -> {0,1,q-1} in place */
void poly_Z3_to_Zq(poly *r) {
    int i;
    for (i = 0; i < NTRU_N; i++) {
        r->coeffs[i] = r->coeffs[i] | ((-(r->coeffs[i] >> 1)) & (NTRU_Q - 1));
    }
}

/* Map {0, 1, 2} -> {0, 1, -1} in place */
void poly_Z3_to_SignedZ3(poly *r) {
    int i;
    for (i = 0; i < NTRU_N; i++) {
        r->coeffs[i] = r->coeffs[i] | (-(r->coeffs[i] >> 1));
    }
}

/* Map {0, 1, q-1} -> {0,1,2} in place */
void poly_trinary_Zq_to_Z3(poly *r) {
    int i;
    for (i = 0; i < NTRU_N; i++) {
        r->coeffs[i] = 3 & (r->coeffs[i] ^ (r->coeffs[i] >> (NTRU_LOGQ - 1)));
    }
}

extern void polymul_asm(uint16_t *h, const uint16_t *f, const uint16_t *g);
void poly_Rq_mul(poly *r, const poly *a, const poly *b) {
 uint16_t rtmp[2 * NTRU_N - 1];
  polymul_asm(rtmp, a->coeffs, b->coeffs);

  for(int i=0; i<NTRU_N - 1; i++)
  {
    r->coeffs[i] = MODQ(rtmp[i] + rtmp[i + NTRU_N]);
  }
  r->coeffs[NTRU_N - 1] = MODQ(rtmp[NTRU_N - 1]);
}

void poly_SignedZ3_Rq_mul(poly *r, const poly *a, const poly *b){

    int32_t poly1_NTT[ARRAY_N];
    int32_t poly2_NTT[ARRAY_N];

    NTT_forward(poly1_NTT, b->coeffs);
    NTT_forward_small(poly2_NTT, a->coeffs);
    NTT_mul(poly1_NTT, poly1_NTT, poly2_NTT);
    NTT_inv(poly1_NTT);
    NTT_final_map(r->coeffs, poly1_NTT);

}

void poly_Sq_mul(poly *r, const poly *a, const poly *b) {
    int i;
    poly_Rq_mul(r, a, b);
    for (i = 0; i < NTRU_N; i++) {
        r->coeffs[i] = MODQ(r->coeffs[i] - r->coeffs[NTRU_N - 1]);
    }
}

void poly_SignedZ3_Sq_mul(poly *r, const poly *a, const poly *b) {
    int i;
    poly_SignedZ3_Rq_mul(r, a, b);
    for (i = 0; i < NTRU_N; i++) {
        r->coeffs[i] = MODQ(r->coeffs[i] - r->coeffs[NTRU_N - 1]);
    }
}

extern void gf_polymul_768x768_mod3(uint8_t *h, const uint8_t *c, const uint8_t *f);
void poly_S3_mul(poly *r, const poly *a, const poly *b) {

    int k;
    poly_Rq_mul(r, a, b);

    for (k = 0; k < NTRU_N; k++) {
        r->coeffs[k] = mod3(r->coeffs[k] + 2 * r->coeffs[NTRU_N - 1]);
    }

    // uint8_t tmp_r[1024], tmp_a[1024], tmp_b[1024];
    // for(int i = 0; i < NTRU_N; i++){
    //     tmp_a[i] = a->coeffs[i] & 0xff;
    //     tmp_b[i] = b->coeffs[i] & 0xff;
    // }

    // for(int i = NTRU_N; i < 768; i++){
    //     tmp_a[i] = tmp_b[i] = 0;
    // }

    // gf_polymul_768x768_mod3(tmp_r, tmp_a, tmp_b);

    // for(int i = 1535; i >= NTRU_N; i--){
    //     tmp_r[i - NTRU_N] = tmp_r[i] + tmp_r[i - NTRU_N];
    // }

    // for(int i = 0; i < NTRU_N; i++){
    //     r->coeffs[i] = mod3((uint16_t) (tmp_r[i] + 2 * tmp_r[NTRU_N - 1]));
    // }
}

void poly_Rq_mul_x_minus_1(poly *r, const poly *a) {
    int i;
    uint16_t last_coeff = a->coeffs[NTRU_N - 1];

    for (i = NTRU_N - 1; i > 0; i--) {
        r->coeffs[i] = MODQ(a->coeffs[i - 1] + (NTRU_Q - a->coeffs[i]));
    }
    r->coeffs[0] = MODQ(last_coeff + (NTRU_Q - a->coeffs[0]));
}

void poly_lift(poly *r, const poly *a) {
    /* NOTE: Assumes input is in {0,1,2}^N */
    /*       Produces output in [0,Q-1]^N */
    int i;
    poly b;
    uint16_t t, zj;

    /* Define z by <z*x^i, x-1> = delta_{i,0} mod 3:      */
    /*   t      = -1/N mod p = -N mod 3                   */
    /*   z[0]   = 2 - t mod 3                             */
    /*   z[1]   = 0 mod 3                                 */
    /*   z[j]   = z[j-1] + t mod 3                        */
    /* We'll compute b = a/(x-1) mod (3, Phi) using       */
    /*   b[0] = <z, a>, b[1] = <z*x,a>, b[2] = <z*x^2,a>  */
    /*   b[i] = b[i-3] - (a[i] + a[i-1] + a[i-2])         */
    t = 3 - (NTRU_N % 3);
    b.coeffs[0] = a->coeffs[0] * (2 - t) + a->coeffs[1] * 0 + a->coeffs[2] * t;
    b.coeffs[1] = a->coeffs[1] * (2 - t) + a->coeffs[2] * 0;
    b.coeffs[2] = a->coeffs[2] * (2 - t);

    zj = 0; /* z[1] */
    for (i = 3; i < NTRU_N; i++) {
        b.coeffs[0] += a->coeffs[i] * (zj + 2 * t);
        b.coeffs[1] += a->coeffs[i] * (zj + t);
        b.coeffs[2] += a->coeffs[i] * zj;
        zj = (zj + t) % 3;
    }
    b.coeffs[1] += a->coeffs[0] * (zj + t);
    b.coeffs[2] += a->coeffs[0] * zj;
    b.coeffs[2] += a->coeffs[1] * (zj + t);

    b.coeffs[0] = b.coeffs[0];
    b.coeffs[1] = b.coeffs[1];
    b.coeffs[2] = b.coeffs[2];
    for (i = 3; i < NTRU_N; i++) {
        b.coeffs[i] = b.coeffs[i - 3] + 2 * (a->coeffs[i] + a->coeffs[i - 1] + a->coeffs[i - 2]);
    }

    /* Finish reduction mod Phi by subtracting Phi * b[N-1] */
    for (i = 0; i < NTRU_N; i++) {
        b.coeffs[i] = mod3(b.coeffs[i] + 2 * b.coeffs[NTRU_N - 1]);
    }

    /* Switch from {0,1,2} to {0,1,q-1} coefficient representation */
    poly_Z3_to_Zq(&b);

    /* Multiply by (x-1) */
    poly_Rq_mul_x_minus_1(r, &b);
}

void poly_Rq_to_S3(poly *r, const poly *a) {
    /* NOTE: Assumes input is in [0,Q-1]^N */
    /*       Produces output in {0,1,2}^N */
    int i;

    /* Center coeffs around 3Q: [0, Q-1] -> [3Q - Q/2, 3Q + Q/2) */
    for (i = 0; i < NTRU_N; i++) {
        r->coeffs[i] = ((a->coeffs[i] >> (NTRU_LOGQ - 1)) ^ 3) << NTRU_LOGQ;
        r->coeffs[i] += a->coeffs[i];
    }
    /* Reduce mod (3, Phi) */
    r->coeffs[NTRU_N - 1] = mod3(r->coeffs[NTRU_N - 1]);
    for (i = 0; i < NTRU_N; i++) {
        r->coeffs[i] = mod3(r->coeffs[i] + 2 * r->coeffs[NTRU_N - 1]);
    }
}

#define POLY_R2_ADD(I,A,B,S) \
    for ((I)=0; (I)<NTRU_N; (I)++) { \
        (A).coeffs[(I)] ^= (B).coeffs[(I)] * (S); \
    }

static void cswappoly(poly *a, poly *b, int swap) {
    int i;
    uint16_t t;
    swap = -swap;
    for (i = 0; i < NTRU_N; i++) {
        t = (a->coeffs[i] ^ b->coeffs[i]) & swap;
        a->coeffs[i] ^= t;
        b->coeffs[i] ^= t;
    }
}

static inline void poly_divx(poly *a, int s) {
    int i;

    for (i = 1; i < NTRU_N; i++) {
        a->coeffs[i - 1] = (unsigned char) ((s * a->coeffs[i]) | (!s * a->coeffs[i - 1]));
    }
    a->coeffs[NTRU_N - 1] = (!s * a->coeffs[NTRU_N - 1]);
}

static inline void poly_mulx(poly *a, int s) {
    int i;

    for (i = 1; i < NTRU_N; i++) {
        a->coeffs[NTRU_N - i] = (unsigned char) ((s * a->coeffs[NTRU_N - i - 1]) | (!s * a->coeffs[NTRU_N - i]));
    }
    a->coeffs[0] = (!s * a->coeffs[0]);
}

static void poly_R2_inv_to_Rq_inv(poly *r, const poly *ai, const poly *a) {

    int i;
    poly b, c;
    poly s;

    // for 0..4
    //    ai = ai * (2 - a*ai)  mod q
    for (i = 0; i < NTRU_N; i++) {
        b.coeffs[i] = MODQ(NTRU_Q - a->coeffs[i]); // b = -a
    }

    for (i = 0; i < NTRU_N; i++) {
        r->coeffs[i] = ai->coeffs[i];
    }

    poly_Rq_mul(&c, r, &b);
    c.coeffs[0] += 2; // c = 2 - a*ai
    poly_Rq_mul(&s, &c, r); // s = ai*c

    poly_Rq_mul(&c, &s, &b);
    c.coeffs[0] += 2; // c = 2 - a*s
    poly_Rq_mul(r, &c, &s); // r = s*c

    poly_Rq_mul(&c, r, &b);
    c.coeffs[0] += 2; // c = 2 - a*r
    poly_Rq_mul(&s, &c, r); // s = r*c

    poly_Rq_mul(&c, &s, &b);
    c.coeffs[0] += 2; // c = 2 - a*s
    poly_Rq_mul(r, &c, &s); // r = s*c
}

void poly_Rq_inv(poly *r, const poly *a) {
    poly ai2;
    poly_R2_inv_jumpdivsteps(&ai2, a);
    poly_R2_inv_to_Rq_inv(r, &ai2, a);
}

void poly_S3_inv(poly *r, const poly *a) {
    /* Schroeppel--Orman--O'Malley--Spatscheck
     * "Almost Inverse" algorithm as described
     * by Silverman in NTRU Tech Report #14 */
    // with several modifications to make it run in constant-time
    int i, j;
    uint16_t k = 0;
    uint16_t degf = NTRU_N - 1;
    uint16_t degg = NTRU_N - 1;
    int sign, fsign = 0, t, swap;
    int16_t done = 0;
    poly b, c, f, g;
    poly *temp_r = &f;

    /* b(X) := 1 */
    for (i = 1; i < NTRU_N; i++) {
        b.coeffs[i] = 0;
    }
    b.coeffs[0] = 1;

    /* c(X) := 0 */
    for (i = 0; i < NTRU_N; i++) {
        c.coeffs[i] = 0;
    }

    /* f(X) := a(X) */
    for (i = 0; i < NTRU_N; i++) {
        f.coeffs[i] = a->coeffs[i];
    }

    /* g(X) := 1 + X + X^2 + ... + X^{N-1} */
    for (i = 0; i < NTRU_N; i++) {
        g.coeffs[i] = 1;
    }

    for (j = 0; j < 2 * (NTRU_N - 1) - 1; j++) {
        sign = mod3(2 * g.coeffs[0] * f.coeffs[0]);
        swap = (((sign & 2) >> 1) | sign) & !done & ((degf - degg) >> 15);

        cswappoly(&f, &g, swap);
        cswappoly(&b, &c, swap);
        t = (degf ^ degg) & (-swap);
        degf ^= t;
        degg ^= t;

        for (i = 0; i < NTRU_N; i++) {
            f.coeffs[i] = mod3(f.coeffs[i] + ((uint16_t) (sign * (!done))) * g.coeffs[i]);
        }
        for (i = 0; i < NTRU_N; i++) {
            b.coeffs[i] = mod3(b.coeffs[i] + ((uint16_t) (sign * (!done))) * c.coeffs[i]);
        }

        poly_divx(&f, !done);
        poly_mulx(&c, !done);
        degf -= !done;
        k += !done;

        done = 1 - (((uint16_t) - degf) >> 15);
    }

    fsign = f.coeffs[0];
    k = k - NTRU_N * ((uint16_t)(NTRU_N - k - 1) >> 15);

    /* Return X^{N-k} * b(X) */
    /* This is a k-coefficient rotation. We do this by looking at the binary
       representation of k, rotating for every power of 2, and performing a cmov
       if the respective bit is set. */
    for (i = 0; i < NTRU_N; i++) {
        r->coeffs[i] = mod3((uint16_t) fsign * b.coeffs[i]);
    }

    for (i = 0; i < 10; i++) {
        for (j = 0; j < NTRU_N; j++) {
            temp_r->coeffs[j] = r->coeffs[(j + (1 << i)) % NTRU_N];
        }
        cmov((unsigned char *) & (r->coeffs),
                                       (unsigned char *) & (temp_r->coeffs), sizeof(uint16_t) * NTRU_N, k & 1);
        k >>= 1;
    }

    /* Reduce modulo Phi_n */
    for (i = 0; i < NTRU_N; i++) {
        r->coeffs[i] = mod3(r->coeffs[i] + 2 * r->coeffs[NTRU_N - 1]);
    }
}