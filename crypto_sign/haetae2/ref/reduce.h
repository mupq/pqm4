#ifndef HAETAE_REDUCE_H
#define HAETAE_REDUCE_H

#include "params.h"
#include <stdint.h>

#define MONT 14321     // 2^32 % Q
#define MONTSQ 4214    // 2^64 % Q
#define QINV 940508161 // q^(-1) mod 2^32
#define QREC 66575     // 2^32 / Q for Barrett
#define DQREC 33287    // 2^32 / DQ for Barrett

#define montgomery_reduce HAETAE_NAMESPACE(montgomery_reduce)
int32_t montgomery_reduce(int64_t a);

#define caddq HAETAE_NAMESPACE(caddq)
int32_t caddq(int32_t a);

#define freeze HAETAE_NAMESPACE(freeze)
int32_t freeze(int32_t a);

#define reduce32_2q HAETAE_NAMESPACE(reduce32_2q)
int32_t reduce32_2q(int32_t a);

#define freeze2q HAETAE_NAMESPACE(freeze2q)
int32_t freeze2q(int32_t a);

#endif
