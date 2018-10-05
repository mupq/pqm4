/* Declarations of functions and data types used for SHA512 sum
library functions.
Copyright (C) 2005, 2006, 2008 Free Software Foundation, Inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

// Simplified for inclusion in Cubby by Keith Rarick.

#ifndef sha512_h
#define sha512_h 1

#include <stdint.h>

#include <stdlib.h>

/* Compute SHA512 message digest for LEN bytes beginning at BUFFER.  The
result is always in little endian byte order, so that a byte-wise
output yields to the wanted ASCII representation of the message
digest.  */
extern void *sha512(const char *buffer, size_t len, void *res, int outlen);

#endif //sha512_h