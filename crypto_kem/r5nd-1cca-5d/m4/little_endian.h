//	little_endian.h
//	2019-10-29	Markku-Juhani O. Saarinen <mjos@pqshield.com>
//	Copyright (c) 2019, PQShield Ltd. All rights reserved.

#ifndef _LITTLE_ENDIAN_H_
#define _LITTLE_ENDIAN_H_

#include <stdint.h>

#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define LITTLE_ENDIAN64(x) (x)
#else
#define LITTLE_ENDIAN64(x) (			 \
	(((x) & 0xFF00000000000000) >> 56) | \
	(((x) & 0x00FF000000000000) >> 40) | \
	(((x) & 0x0000FF0000000000) >> 24) | \
	(((x) & 0x000000FF00000000) >> 8)  | \
	(((x) & 0x00000000FF000000) << 8)  | \
	(((x) & 0x0000000000FF0000) << 24) | \
	(((x) & 0x000000000000FF00) << 40) | \
	(((x) & 0x00000000000000FF) << 56)	 \
)
#endif

#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define LITTLE_ENDIAN32(x) (x)
#else
#define LITTLE_ENDIAN32(x) (	 \
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
	(((x) & 0xFF00) >> 8) |	 \
	(((x) & 0x00FF) << 8)	 \
)
#endif

#endif /* _LITTLE_ENDIAN_H_ */
