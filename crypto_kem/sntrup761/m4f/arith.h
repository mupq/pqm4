#ifndef ARITH_H
#define ARITH_H

#include "bred_int.h"
#include "params.h"
#include "int8.h"
#include "int16.h"

#define inv3	0x55555555

typedef int8 small;
typedef int16 Fq;



static inline small F3_freeze(int x);
static inline small F3_freeze_short(short x);
static inline int F3_round_x2(int x);
static inline int F3_freeze_x2(int x);
  
static inline Fq Fq_freeze_short(Fq x);
static inline Fq Fq_freeze(int x);
static inline int Fq_freeze_x2(int x);


static inline small F3_freeze_short(short x) {
  return (bred(x, 3, -inv3)) ;
}

static inline small F3_freeze(int x) {
  return (bred(bred(x, 3, -inv3), 3, -inv3)) ;
}

static inline int F3_freeze_x2(int x) {
  return(bred_16x2(x, 3, -inv3));
}

static inline int F3_round_x2(int x) {
  return (bround_16x2(x, 3, inv3));
}


static inline Fq Fq_freeze_short(Fq x) {
  return (bred(x, q, -q32inv));
}

static inline Fq Fq_freeze_short32(int x) {
  return (bred(x, q, -q32inv));
}

static inline int Fq_freeze_x2(int x) {
  return(bred_16x2(x, q, -q32inv));

}
static inline Fq Fq_freeze(int x) {
  return (bred(bred(x, q, -q32inv),q,-q32inv));
}
static inline Fq Fq_2xmuladd(int a, int b, int c) {
  return (bred_2xmuladd(a, b, c, q, -q32inv));
}
static inline Fq Fq_2xmuladdx(int a, int b, int c) {
  return (bred_2xmuladdx(a, b, c, q, -q32inv));
}
static inline Fq Fq_4xmuladd(int a, int b, int c, int d, int e) {
  return (bred_4xmuladd(a, b, c, d, e, q, -q32inv));
}
static inline Fq Fq_4xmuladdx(int a, int b, int c, int d, int e) {
  return (bred_4xmuladdx(a, b, c, d, e, q, -q32inv));
}

#endif
