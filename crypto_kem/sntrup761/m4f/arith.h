#ifndef ARITH_H
#define ARITH_H

#include "bred_int.h"
#include "params.h"
#include "int8.h"
#include "int16.h"

#define inv3	0x55555555

typedef int8 small;
typedef int16 Fq;



inline small F3_freeze(int x);
inline small F3_freeze_short(short x);
inline int F3_round_x2(int x);
inline int F3_freeze_x2(int x);
  
inline Fq Fq_freeze_short(Fq x);
inline Fq Fq_freeze(int x);
inline int Fq_freeze_x2(int x);


inline small F3_freeze_short(short x) {
  return (bred(x, 3, -inv3)) ;
}
inline small F3_freeze(int x) {
  return (bred(bred(x, 3, -inv3), 3, -inv3)) ;
}

inline int F3_freeze_x2(int x) {
  return(bred_16x2(x, 3, -inv3));
}

inline int F3_round_x2(int x) {
  return (bround_16x2(x, 3, inv3));
}



inline Fq Fq_freeze_short(Fq x) {
  return (bred(x, q, -q32inv));
}
inline int Fq_freeze_x2(int x) {
  return(bred_16x2(x, q, -q32inv));

}
inline Fq Fq_freeze(int x) {
  return (bred(bred(x, q, -q32inv),q,-q32inv));
}


#endif
