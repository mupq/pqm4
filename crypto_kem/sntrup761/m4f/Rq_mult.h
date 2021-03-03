#ifndef RQ_MULT_H
#define RQ_MULT_H
#include "int8.h"
#include "int16.h"
#include "int32.h"
#include "uint16.h"
#include "uint32.h"
#define UNREFERENCED_PARAMETER(PAR) ((void)(PAR))
#include "polymul.h"


typedef int8 small;
typedef int16 Fq;

void Rq_mult_small(Fq *h,const Fq *f,const small *g);
void Rq_mult_twice(Fq *bG, Fq *bA, const Fq *G, const Fq *A, const small *b);

#endif
