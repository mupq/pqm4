//  ct_util.h
//  Copyright (c) 2019, PQShield Ltd.

//  Constant-time utility functions.

#ifndef _CT_UTIL_H_
#define _CT_UTIL_H_

#include <stdint.h>
#include <stddef.h>

//  constant time comparison; return nonzero if not equal
uint8_t ct_memcmp(const void *a, const void *b, size_t len);

//  conditional move; overwrite d with a if flag is nonzero
void ct_cmov(void *d, const void * a, size_t len, uint8_t flag);

#endif /* _CT_UTIL_H_ */
