#ifndef HAETAE_SAMPLER_H
#define HAETAE_SAMPLER_H

#include "fixpoint.h"
#include "params.h"
#include "reduce.h"
#include "fpa.h"
#include <stdint.h>

#define rej_uniform HAETAE_NAMESPACE(rej_uniform)
unsigned int rej_uniform(int32_t *a, unsigned int len, const uint8_t *buf,
                         unsigned int buflen);

#define rej_uniform_frozen HAETAE_NAMESPACE(rej_uniform_frozen)
unsigned int rej_uniform_frozen(uint16_t *a, unsigned int len, const uint8_t *buf,
                         unsigned int buflen);

#define rej_eta HAETAE_NAMESPACE(rej_eta)
unsigned int rej_eta(int32_t *a, unsigned int len, const uint8_t *buf,
                     unsigned int buflen);

#define GAUSS_RAND_BYTES (((72 + 16 + 48) + 7) / 8)
#define sample_gauss_sigma76 HAETAE_NAMESPACE(sample_gauss_sigma76)
int sample_gauss_sigma76(uint64_t *r, fp84_76 *sqr84, const uint8_t rand[GAUSS_RAND_BYTES]);

#define sample_gauss HAETAE_NAMESPACE(sample_gauss)
int sample_gauss(uint64_t *r, fp112_76 *sqsum, const uint8_t *buf, const size_t buflen, 
                 const size_t len, const int dont_write_last);

#define sample_gauss_N HAETAE_NAMESPACE(sample_gauss_N)
void sample_gauss_N(uint64_t *r, uint8_t *signs, fp112_76 *sqsum,
                    const uint8_t seed[CRHBYTES], const uint16_t nonce,
                    const size_t len);

#endif
