#ifndef Encode_H
#define Encode_H
#include "int16.h"
#
/* Encode(s,R,M,len) */
/* assumes 0 <= R[i] < M[i] < 16384 */
extern void Encode_Rq(unsigned char *,int16 *);
extern void Encode_Rounded(unsigned char *,int16 *);

#endif
