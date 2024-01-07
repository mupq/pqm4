
/**
 * @file parsing_permutations.c
 * @brief Implementation of parsing functions
 */

#include "parsing_permutations.h"
#include "parameters.h"

#include <string.h>
#include "arithmetic.h"
#include "data_structures.h"
#include "rank_unrank_table.h"
#include "symmetric.h"

#define PARAM_RANK_UNRANK_LEN_T \
    ((1 << (PARAM_RANK_UNRANK_K + 1)) - 1) /**< Length of list used in rank/unrank compression */

void sig_perk_perm_encode(const perm_t in_p, uint8_t* out_buff) {
    struct bn mul, code, tmp;

    uint8_t T[PARAM_RANK_UNRANK_LEN_T] = {0};
    bignum_init(&code);
    for (int i = 0; i < PARAM_N1; ++i) {
        uint8_t ctr = in_p[i];
        uint16_t node = (1 << PARAM_RANK_UNRANK_K) + in_p[i];
        for (int j = 0; j < PARAM_RANK_UNRANK_K; ++j) {
            if (node & 0x1) {
                ctr -= T[(node >> 1) << 1];
            }
            T[node] += 1;
            node = node >> 1;
        }
        T[node] += 1;
        bignum_from_int(&tmp, PARAM_N1 - i);
        bignum_mul(&code, &tmp, &mul);
        bignum_from_int(&tmp, ctr);
        bignum_add(&mul, &tmp, &code);
    }

    memset(out_buff, 0, PARAM_PERM_COMPRESSION_BYTES);
    memcpy(out_buff, &code, PARAM_PERM_COMPRESSION_BYTES);
}

int sig_perk_perm_decode(const uint8_t* in_buff, perm_t out_p) {
    struct bn code, tmp, tmp2, tmp3;
    bignum_init(&code);

    memcpy(&code, in_buff, PARAM_PERM_COMPRESSION_BYTES);

    // validate the permutation encoding to be < n!
    if (bignum_cmp(&factorial[PARAM_N1], &code) < 1) {
        return EXIT_FAILURE;
    }

    bignum_mod(&code, &factorial[PARAM_N1], &tmp);
    bignum_assign(&tmp3, &tmp);
    bignum_divmod(&tmp3, &factorial[PARAM_N1 - 1], &tmp, &tmp2);
    out_p[0] = bignum_to_int(&tmp);

    for (int i = 1; i < PARAM_N1 - 1; ++i) {
        bignum_assign(&tmp3, &tmp2);
        bignum_divmod(&tmp3, &factorial[PARAM_N1 - i - 1], &tmp, &tmp2);
        out_p[i] = bignum_to_int(&tmp);
    }

    bignum_div(&tmp2, &factorial[0], &tmp);
    out_p[PARAM_N1 - 1] = bignum_to_int(&tmp);

    uint8_t T[PARAM_RANK_UNRANK_LEN_T] = {0};
    for (int i = 0; i <= PARAM_RANK_UNRANK_K; ++i) {
        for (int j = 0; j < (1 << i); ++j) {
            T[((1 << i)) + j - 1] = 1 << (PARAM_RANK_UNRANK_K - i);
        }
    }

    for (int i = 0; i < PARAM_N1; ++i) {
        int digit = out_p[i];
        uint16_t node = 1;
        for (int j = 0; j < PARAM_RANK_UNRANK_K; ++j) {
            T[node] -= 1;
            node <<= 1;
            if (digit >= T[node]) {
                digit -= T[node];
                node += 1;
            }
        }
        T[node] = 0;
        out_p[i] = node - (1 << PARAM_RANK_UNRANK_K);
    }

    return EXIT_SUCCESS;
}

void sig_perk_signature_perm_to_bytes(uint8_t* sb, const perk_signature_t* signature) {
    for (int i = 0; i < (PARAM_TAU); i++) {
        sig_perk_perm_encode(signature->responses[i].z2_pi, sb);
        sb += PARAM_PERM_COMPRESSION_BYTES;
    }
}

int sig_perk_signature_perm_from_bytes(perk_signature_t* signature, const uint8_t* sb) {
    for (int i = 0; i < PARAM_TAU; i++) {
        if (sig_perk_perm_decode(sb, signature->responses[i].z2_pi) != EXIT_SUCCESS) {
            return EXIT_FAILURE;
        }
        sb += PARAM_PERM_COMPRESSION_BYTES;
    }

    return EXIT_SUCCESS;
}