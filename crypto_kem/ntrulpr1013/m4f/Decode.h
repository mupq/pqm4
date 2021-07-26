#ifndef Decode_H
#define Decode_H

#include "int16.h"
/* Decode(R,s,M,len) */
/* assumes 0 < M[i] < 16384 */
/* produces 0 <= R[i] < M[i] */
extern void Decode_Rq_asm(int16 *, const unsigned char *);
extern void Decode_Rounded_asm(int16 *, const unsigned char *);

#endif
