#ifndef INT32_H
#define INT32_H

#include "uint16.h"

typedef int32_t int32;

/*
assuming 1 <= m < 16384:
q = int32_div_uint14(x,m) means q = x/m
r = int32_mod_uint14(x,m) means r = x/m
int32_moddiv_uint14(&q,&r,x,m) means q = x/m, r = x%m
*/

extern int32 int32_div_uint14(int32,uint16);
extern uint16 int32_mod_uint14(int32,uint16);
extern void int32_divmod_uint14(int32 *,uint16 *,int32,uint16);

#endif
