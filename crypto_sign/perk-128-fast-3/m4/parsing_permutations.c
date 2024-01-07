
/**
 * @file parsing_permutations.c
 * @brief Implementation of parsing functions
 */

#include "parsing_permutations.h"
#include "parameters.h"

#include <string.h>
#include "arithmetic.h"
#include "data_structures.h"
#include "symmetric.h"

// bits needed to store two permutation coefficients
#if (PARAM_N1 > 64) && (PARAM_N1 <= 90)
#define PARAM_N1_BITSx2 13
#elif (PARAM_N1 > 90) && (PARAM_N1 <= 128)
#define PARAM_N1_BITSx2 14
#elif (PARAM_N1 > 128) && (PARAM_N1 <= 181)
#define PARAM_N1_BITSx2 15
#else
#error PARAM_N1 bit size not supported
#endif

#if (PARAM_N1_BITSx2 == 14)
/**
 * @brief store a 7 bit value in a byte array at bit position i*7
 *        must be called sequentially with increasing index
 *
 * @param sb  byte array pointer
 * @param i   position in the byte array
 * @param val 7 bit value to store
 */
static inline void store_7bit_in_bytearray(uint8_t* sb, int i, uint16_t val) {
    val &= 0x7F;
    int k = (i * 7) / 8;
    switch (i % 8) {
        case 0:
            sb[k + 0] = val;
            break;
        case 1:
            sb[k + 0] |= val << 7;
            sb[k + 1] = val >> 1;
            break;
        case 2:
            sb[k + 0] |= val << 6;
            sb[k + 1] = val >> 2;
            break;
        case 3:
            sb[k + 0] |= val << 5;
            sb[k + 1] = val >> 3;
            break;
        case 4:
            sb[k + 0] |= val << 4;
            sb[k + 1] = val >> 4;
            break;
        case 5:
            sb[k + 0] |= val << 3;
            sb[k + 1] = val >> 5;
            break;
        case 6:
            sb[k + 0] |= val << 2;
            sb[k + 1] = val >> 6;
            break;
        case 7:
            sb[k + 0] |= val << 1;
            break;
    }
}

/**
 * @brief load a 7 bit value from a byte array at bit position i*7
 *
 * @param sb byte array pointer
 * @param i  position in the byte array
 * @return   uint8_t loaded value
 */
static inline uint8_t load_7bit_from_bytearray(const uint8_t* sb, int i) {
    uint8_t val = 0;
    int k = (i * 7) / 8;
    switch (i % 8) {
        case 0:
            val = (sb[k + 0] & 0x7F);
            break;
        case 1:
            val = sb[k + 0] >> 7;
            val |= (sb[k + 1] & 0x3F) << 1;
            break;
        case 2:
            val = sb[k + 0] >> 6;
            val |= (sb[k + 1] & 0x1F) << 2;
            break;
        case 3:
            val = sb[k + 0] >> 5;
            val |= (sb[k + 1] & 0x0F) << 3;
            break;
        case 4:
            val = sb[k + 0] >> 4;
            val |= (sb[k + 1] & 0x07) << 4;
            break;
        case 5:
            val = sb[k + 0] >> 3;
            val |= (sb[k + 1] & 0x03) << 5;
            break;
        case 6:
            val = sb[k + 0] >> 2;
            val |= (sb[k + 1] & 0x01) << 6;
            break;
        case 7:
            val = sb[k + 0] >> 1;
            break;
        default:
            break;
    }

    return val;
}
#endif

#if (PARAM_N1_BITSx2 == 13)
/**
 * @brief store a 13 bit value in a byte array at bit position i*13
 *        must be called sequentially with increasing index
 *
 * @param sb  byte array pointer
 * @param i   position in the byte array
 * @param val 13 bit value to store
 */
static inline void store_13bit_in_bytearray(uint8_t* sb, int i, uint16_t val) {
    val &= 0x1FFF;
    int k = (i * 13) / 8;
    switch (i % 8) {
        case 0:
            sb[k + 0] = val;
            sb[k + 1] = val >> 8;
            break;
        case 1:
            sb[k + 0] |= val << 5;
            sb[k + 1] = val >> 3;
            sb[k + 2] = val >> 11;
            break;
        case 2:
            sb[k + 0] |= val << 2;
            sb[k + 1] = val >> 6;
            break;
        case 3:
            sb[k + 0] |= val << 7;
            sb[k + 1] = val >> 1;
            sb[k + 2] = val >> 9;
            break;
        case 4:
            sb[k + 0] |= val << 4;
            sb[k + 1] = val >> 4;
            sb[k + 2] = val >> 12;
            break;
        case 5:
            sb[k + 0] |= val << 1;
            sb[k + 1] = val >> 7;
            break;
        case 6:
            sb[k + 0] |= val << 6;
            sb[k + 1] = val >> 2;
            sb[k + 2] = val >> 10;
            break;
        case 7:
            sb[k + 0] |= val << 3;
            sb[k + 1] = val >> 5;
            break;
    }
}

/**
 * @brief load a 13 bit value from a byte array at bit position i*13
 *
 * @param sb byte array pointer
 * @param i  position in the byte array
 * @return   uint16_t loaded value
 */
static inline uint16_t load_13bit_from_bytearray(const uint8_t* sb, int i) {
    int k = (i * 13) / 8;
    uint16_t val = 0;
    switch (i % 8) {
        case 0:
            val = sb[k + 0];
            val |= ((uint16_t)sb[k + 1] & 0x1F) << 8;
            break;
        case 1:
            val = sb[k + 0] >> 5;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 3;
            val |= ((uint16_t)sb[k + 2] & 0x03) << 11;
            break;
        case 2:
            val = sb[k + 0] >> 2;
            val |= ((uint16_t)sb[k + 1] & 0x7F) << 6;
            break;
        case 3:
            val = sb[k + 0] >> 7;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 1;
            val |= ((uint16_t)sb[k + 2] & 0x0F) << 9;
            break;
        case 4:
            val = sb[k + 0] >> 4;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 4;
            val |= ((uint16_t)sb[k + 2] & 0x01) << 12;
            break;
        case 5:
            val = sb[k + 0] >> 1;
            val |= ((uint16_t)sb[k + 1] & 0x3F) << 7;
            break;
        case 6:
            val = sb[k + 0] >> 6;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 2;
            val |= ((uint16_t)sb[k + 2] & 0x07) << 10;
            break;
        case 7:
            val = sb[k + 0] >> 3;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 5;
            break;
    }

    return val;
}
#endif

#if (PARAM_N1_BITSx2 == 15)
/**
 * @brief store a 15 bit value in a byte array at bit position i*15
 *        must be called sequentially with increasing index
 *
 * @param sb  byte array pointer
 * @param i   position in the byte array
 * @param val 15 bit value to store
 */
static inline void store_15bit_in_bytearray(uint8_t* sb, int i, uint16_t val) {
    val &= 0x7FFF;
    int k = (i * 15) / 8;
    switch (i % 8) {
        case 0:
            sb[k + 0] = val;
            sb[k + 1] = val >> 8;
            break;
        case 1:
            sb[k + 0] |= val << 7;
            sb[k + 1] = val >> 1;
            sb[k + 2] = val >> 9;
            break;
        case 2:
            sb[k + 0] |= val << 6;
            sb[k + 1] = val >> 2;
            sb[k + 2] = val >> 10;
            break;
        case 3:
            sb[k + 0] |= val << 5;
            sb[k + 1] = val >> 3;
            sb[k + 2] = val >> 11;
            break;
        case 4:
            sb[k + 0] |= val << 4;
            sb[k + 1] = val >> 4;
            sb[k + 2] = val >> 12;
            break;
        case 5:
            sb[k + 0] |= val << 3;
            sb[k + 1] = val >> 5;
            sb[k + 2] = val >> 13;
            break;
        case 6:
            sb[k + 0] |= val << 2;
            sb[k + 1] = val >> 6;
            sb[k + 2] = val >> 14;
            break;
        case 7:
            sb[k + 0] |= val << 1;
            sb[k + 1] = val >> 7;
            break;
    }
}

/**
 * @brief load a 15 bit value from a byte array at bit position i*15
 *
 * @param sb byte array pointer
 * @param i  position in the byte array
 * @return   uint16_t loaded value
 */
static inline uint16_t load_15bit_from_bytearray(const uint8_t* sb, int i) {
    int k = (i * 15) / 8;
    uint16_t val = 0;
    switch (i % 8) {
        case 0:
            val = sb[k + 0];
            val |= ((uint16_t)sb[k + 1] & 0x7F) << 8;
            break;
        case 1:
            val = sb[k + 0] >> 7;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 1;
            val |= ((uint16_t)sb[k + 2] & 0x3F) << 9;
            break;
        case 2:
            val = sb[k + 0] >> 6;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 2;
            val |= ((uint16_t)sb[k + 2] & 0x1F) << 10;
            break;
        case 3:
            val = sb[k + 0] >> 5;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 3;
            val |= ((uint16_t)sb[k + 2] & 0x0F) << 11;
            break;
        case 4:
            val = sb[k + 0] >> 4;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 4;
            val |= ((uint16_t)sb[k + 2] & 0x07) << 12;
            break;
        case 5:
            val = sb[k + 0] >> 3;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 5;
            val |= ((uint16_t)sb[k + 2] & 0x03) << 13;
            break;
        case 6:
            val = sb[k + 0] >> 2;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 6;
            val |= ((uint16_t)sb[k + 2] & 0x01) << 14;
            break;
        case 7:
            val = sb[k + 0] >> 1;
            val |= ((uint16_t)sb[k + 1] & 0xFF) << 7;
            break;
    }

    return val;
}
#endif

#if (PARAM_Q_BITS != 10)
#error PARAM_Q bit size not supported
#endif

#if (PARAM_N1_BITSx2 == 13)
static void store_2_perm_coeff_to_bytearray(uint8_t* sb, int i, uint16_t c0, uint16_t c1) {
    store_13bit_in_bytearray(sb, i, (c1 * 90) + c0);
}

static void load_2_perm_coeff_from_bytearray(uint16_t* c0, uint16_t* c1, const uint8_t* sb, int i) {
    uint16_t val = load_13bit_from_bytearray(sb, i);
    *c0 = val % 90;
    *c1 = val / 90;
}
#elif (PARAM_N1_BITSx2 == 14)
static void store_2_perm_coeff_to_bytearray(uint8_t* sb, int i, uint16_t c0, uint16_t c1) {
    store_7bit_in_bytearray(sb, i * 2 + 0, c0);
    store_7bit_in_bytearray(sb, i * 2 + 1, c1);
}

static void load_2_perm_coeff_from_bytearray(uint16_t* c0, uint16_t* c1, const uint8_t* sb, int i) {
    *c0 = load_7bit_from_bytearray(sb, i * 2 + 0);
    *c1 = load_7bit_from_bytearray(sb, i * 2 + 1);
}
#elif (PARAM_N1_BITSx2 == 15)
static void store_2_perm_coeff_to_bytearray(uint8_t* sb, int i, uint16_t c0, uint16_t c1) {
    store_15bit_in_bytearray(sb, i, (c1 * 181) + c0);
}

static void load_2_perm_coeff_from_bytearray(uint16_t* c0, uint16_t* c1, const uint8_t* sb, int i) {
    uint16_t val = load_15bit_from_bytearray(sb, i);
    *c0 = val % 181;
    *c1 = val / 181;
}
#else
#error PARAM_N1 bit size not supported
#endif

void sig_perk_signature_perm_to_bytes(uint8_t* sb, const perk_signature_t* signature) {
    for (int i = 0; i < ((PARAM_TAU * PARAM_N1) / 2); i++) {
        uint16_t z2_pi0 = signature->responses[(i * 2 + 0) / PARAM_N1].z2_pi[(i * 2 + 0) % PARAM_N1];
        uint16_t z2_pi1 = signature->responses[(i * 2 + 1) / PARAM_N1].z2_pi[(i * 2 + 1) % PARAM_N1];
        store_2_perm_coeff_to_bytearray(sb, i, z2_pi0, z2_pi1);
    }
}

/**
 * @brief check the permutations to be valid:
 *        - coefficients < PARAM_N1
 *        - no coefficient duplicates
 *
 * @param responses perk_response_t array of size PARAM_TAU to be checked
 * @return int != 0 if a not valid permutation is found
 */
static int permutations_not_valid(const perk_response_t responses[PARAM_TAU]) {
    for (int i = 0; i < PARAM_TAU; i++) {
        if (sig_perk_permutation_not_valid(responses[i].z2_pi)) {
            return 1;
        }
    }
    return 0;
}

#define Z2_PI_USED_BITS (uint8_t)((PARAM_TAU * PARAM_N1 * PARAM_N1_BITSx2 / 2 + 7) % 8 + 1)
static const uint8_t z2_p1_unused_mask = (uint8_t)(((1U << (Z2_PI_USED_BITS)) - 1) ^ 0xFFU);

int sig_perk_signature_perm_from_bytes(perk_signature_t* signature, const uint8_t* sb) {
    for (int i = 0; i < ((PARAM_TAU * PARAM_N1) / 2); i++) {
        uint16_t z2_pi0;
        uint16_t z2_pi1;

        load_2_perm_coeff_from_bytearray(&z2_pi0, &z2_pi1, sb, i);
        signature->responses[(i * 2 + 0) / PARAM_N1].z2_pi[(i * 2 + 0) % PARAM_N1] = z2_pi0;
        signature->responses[(i * 2 + 1) / PARAM_N1].z2_pi[(i * 2 + 1) % PARAM_N1] = z2_pi1;
    }
    sb += ((PARAM_TAU * PARAM_N1 * PARAM_N1_BITSx2 / 2 + 7) / 8) - 1;

    // cppcheck-suppress knownConditionTrueFalse
    // cppcheck-suppress unmatchedSuppression
    if (sb[0] & z2_p1_unused_mask) {
        // unused bits after the z2_pi != 0
        return EXIT_FAILURE;
    }

    if (permutations_not_valid(signature->responses)) {
        // loaded permutations are not valid
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}