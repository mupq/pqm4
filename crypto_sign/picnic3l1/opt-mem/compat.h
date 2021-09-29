/*
 *  This file is part of the optimized implementation of the Picnic signature scheme.
 *  See the accompanying documentation for complete details.
 *
 *  The code is provided under the MIT license, see LICENSE for
 *  more details.
 *  SPDX-License-Identifier: MIT
 */

#ifndef PICNIC_COMPAT_H
#define PICNIC_COMPAT_H

/* in case cmake checks were not run, define HAVE_* for known good configurations */
#if !defined(HAVE_ALIGNED_ALLOC) && !defined(__APPLE__) && !defined(__MINGW32__) &&                \
    !defined(__MINGW64__) &&                                                                       \
    (defined(_ISOC11_SOURCE) || (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L))
#define HAVE_ALIGNED_ALLOC
#endif /* HAVE_ALIGNED_ALLOC */

#if defined(__NetBSD__) || defined(__OpenBSD__)
#include <sys/param.h>
#endif /* __NetBSD__ || __OpenBSD__ */

#if !defined(HAVE_CONSTTIME_MEMEQUAL) && defined(__NetBSD_Version__) && __NetBSD_Version__ >= 7000000000
/* consttime_memequal was introduced in NetBSD 7.0 */
#define HAVE_CONSTTIME_MEMEQUAL
#endif /* HAVE_CONSTTIME_MEMEQUAL */

#if !defined(HAVE_TIMINGSAFE_BCMP) && (defined(__OpenBSD__) && OpenBSD >= 201105) ||               \
    (defined(__FreeBSD__) && __FreeBSD__ >= 12)
/* timingsafe_bcmp was introduced in OpenBSD 4.9 and FreeBSD 12.0 */
#define HAVE_TIMINGSAFE_BCMP
#endif /* HAVE_TIMINGSAFE_BCMP */

#if defined(MUPQ)
#define HAVE_TIMINGSAFE_BCMP
#include <string.h>
#endif /* STM32F4 */

#if defined(HAVE_ALIGNED_ALLOC)
#include <stdlib.h>

#define aligned_free(ptr) free((ptr))
#else
#include <stddef.h>

/**
 * Compatibility implementation of aligned_alloc from ISO C 2011.
 */
void* aligned_alloc(size_t alignment, size_t size);
/**
 * Some aligned_alloc compatbility implementations require custom free
 * functions, so we provide one too.
 */
void aligned_free(void* ptr);
#endif /* HAVE_ALIGNED_ALLOC */

#include "endian_compat.h"

#if !defined(HAVE_TIMINGSAFE_BCMP)
/**
 * Compatibility implementation of timingsafe_bcmp from OpenBSD 4.9 and FreeBSD 12.0.
 */
static inline int timingsafe_bcmp(const void* a, const void* b, size_t len) {
#if defined(HAVE_CONSTTIME_MEMEQUAL)
  return !consttime_memequal(a, b, len);
#else
  const unsigned char* p1 = a;
  const unsigned char* p2 = b;

  unsigned int res = 0;
  for (; len; --len, ++p1, ++p2) {
    res |= *p1 ^ *p2;
  }
  return res;
#endif
}
#endif /* HAVE_TIMINGSAFE_BCMP */

#endif
