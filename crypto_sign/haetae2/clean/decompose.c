#include "decompose.h"
#include "params.h"
#include <stdint.h>

/*************************************************
 * Name:        decompose_z1
 *
 * Description: For finite field element r, compute high and lowbits
 *              hb, lb such that r = hb * b + lb with -b/4 < lb <= b/4.
 *
 * Arguments:   - int32_t r: input element
 *              - int32_t *lowbits: pointer to output element lb
 *              - int32_t *highbits: pointer to output element hb
 **************************************************/
void decompose_z1(int32_t *highbits, int32_t *lowbits, const int32_t r) {
    const int alpha = 256; // TODO magic numbers!
    const int log_alpha = 8;

    int32_t lb, center;
    uint32_t alpha_mask = alpha - 1;

    lb = r & alpha_mask;
    center = ((alpha >> 1) - (lb + 1)) >> 31; // if lb >= HALF_ALPHA
    lb -= alpha & center;
    *lowbits = lb;
    *highbits = (r + (alpha >> 1)) >> log_alpha;
}

/*************************************************
 * Name:        decompose_hint
 *
 * Description: For finite field element r, compute highbits
 *              hb, lb such that r = hb * b + lb with -b/4 < lb <= b/4.
 *
 * Arguments:   - int32_t r: input element
 *              - int32_t *highbits: pointer to output element hb
 **************************************************/

void decompose_hint(int32_t *highbits, const int32_t r) {
    int32_t hb, edgecase;

    hb = (r + HALF_ALPHA_HINT) >> LOG_ALPHA_HINT;
    edgecase =
        ((DQ - 2) / ALPHA_HINT - (hb + 1)) >> 31; // if hb == (DQ-2)/ALPHA
    hb -= (DQ - 2) / ALPHA_HINT & edgecase;       // hb = 0

    *highbits = hb;
}

/*************************************************
 * Name:        decompose_vk
 *
 * Description: For finite field element a, compute a0, a1 such that
 *              a mod^+ Q = a1*2^D + a0 with -2^{D-1} <= a0 < 2^{D-1}.
 *              Assumes a to be standard representative.
 *
 * Arguments:   - int32_t a: input element
 *              - int32_t *a0: pointer to output element a0
 *
 * Returns a1
 **************************************************/
int32_t decompose_vk(int32_t *a0, const int32_t a) {
#if D > 1
#error "Only implemented for D = 1"
#endif
    *a0 = a & 1;
    *a0 -= ((a >> 1) & *a0) << 1;
    return (a - *a0) >> 1;
}
