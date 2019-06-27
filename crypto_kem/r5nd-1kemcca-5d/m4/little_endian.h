//  little_endian.h
//  Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.

#ifndef _LITTLE_ENDIAN_H_
#define _LITTLE_ENDIAN_H_

#include <stdint.h>

#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define LITTLE_ENDIAN64(x) (x)
#else
#define LITTLE_ENDIAN64(x) (             \
    (((x) & 0xFF00000000000000) >> 56) | \
    (((x) & 0x00FF000000000000) >> 40) | \
    (((x) & 0x0000FF0000000000) >> 24) | \
    (((x) & 0x000000FF00000000) >> 8)  | \
    (((x) & 0x00000000FF000000) << 8)  | \
    (((x) & 0x0000000000FF0000) << 24) | \
    (((x) & 0x000000000000FF00) << 40) | \
    (((x) & 0x00000000000000FF) << 56)   \
)
#endif

#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define LITTLE_ENDIAN32(x) (x)
#else
#define LITTLE_ENDIAN32(x) (     \
    (((x) & 0xFF000000) >> 24) | \
    (((x) & 0x00FF0000) >> 8)  | \
    (((x) & 0x0000FF00) << 8)  | \
    (((x) & 0x000000FF) << 24) \
)
#endif

#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define LITTLE_ENDIAN16(x) (x)
#else
#define LITTLE_ENDIAN16(x) ( \
    (((x) & 0xFF00) >> 8) |  \
    (((x) & 0x00FF) << 8)    \
)
#endif

// can handle non-aligned data

#define GETU32_LE(v) \
    (((uint32_t) (v)[0])        ^   (((uint32_t) (v)[1]) <<  8) ^ \
    (((uint32_t) (v)[2]) << 16) ^   (((uint32_t) (v)[3]) << 24))

#define PUTU32_LE(v, x) { \
    (v)[0] = (uint8_t)  (x);        (v)[1] = (uint8_t) ((x) >>  8); \
    (v)[2] = (uint8_t) ((x) >> 16); (v)[3] = (uint8_t) ((x) >> 24); }

#define GETU32_BE(v) \
    (((uint32_t)(v)[0] << 24)   ^   ((uint32_t)(v)[1] << 16) ^ \
     ((uint32_t)(v)[2] <<  8)   ^   ((uint32_t)(v)[3]))

#define PUTU32_BE(v, x) {\
    (v)[0] = (uint8_t)((x) >> 24);  (v)[1] = (uint8_t)((x) >> 16); \
    (v)[2] = (uint8_t)((x) >>  8);  (v)[3] = (uint8_t)(x);  }


#endif /* _LITTLE_ENDIAN_H_ */
