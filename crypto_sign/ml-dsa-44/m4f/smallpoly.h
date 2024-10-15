#ifndef SMALLPOLY_H
#define SMALLPOLY_H
#include "params.h"
#include "poly.h"
#include "polyvec.h"



#if DILITHIUM_MODE == 3 // use q=769
#define SMALL_POLY_16_BIT
typedef struct {
    int16_t coeffs[N];
} smallpoly;

typedef smallpoly smallhalfpoly;

#else // use q=257
#define SMALL_POLY_32_BIT
typedef struct {
    int32_t coeffs[N];
} smallpoly;

typedef struct {
    int16_t coeffs[N];
} smallhalfpoly;
#endif


void poly_small_ntt_precomp(smallpoly *out, smallhalfpoly *out2, poly *in);
void polyvecl_small_ntt(smallpoly v[L]);
void polyveck_small_ntt(smallpoly v[K]);


void polyvecl_small_basemul_invntt(polyvecl *r, const smallpoly *a, const smallhalfpoly *aprime, const smallpoly b[L]);
void poly_small_basemul_invntt(poly *r, const smallpoly *a, const smallhalfpoly *aprime, const smallpoly *b);

void small_polyeta_unpack(smallpoly *r, const uint8_t *a);

#endif