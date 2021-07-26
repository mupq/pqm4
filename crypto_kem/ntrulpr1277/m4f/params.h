#ifndef params_H
#define params_H

/* menu of parameter choices: */

#include "paramsmenu.h"

/* what the menu means: */

#if defined(SIZE761)
#define p 761
#define q 4591
#define q32inv 935519
#define Rounded_bytes 1007
#ifndef LPR
#define Rq_bytes 1158
#define w 286
#else
#define w 250
#define tau0 2156
#define tau1 114
#define tau2 2007
#define tau3 287
#define minusinv65536modq 1748
#endif

#elif defined(SIZE653)
#define p 653
#define q 4621
#define q32inv 929445
#define Rounded_bytes 865
#ifndef LPR
#define Rq_bytes 994
#define w 288
#else
#define w 252
#define tau0 2175
#define tau1 113
#define tau2 2031
#define tau3 290
#define minusinv65536modq 1040
#endif

#elif defined(SIZE857)
#define p 857
#define q 5167
#define q32inv 831230
#define Rounded_bytes 1152
#ifndef LPR
#define Rq_bytes 1322
#define w 322
#else
#define w 281
#define tau0 2433
#define tau1 101
#define tau2 2265
#define tau3 324
#define minusinv65536modq 779
#endif

#elif defined(SIZE953)
#define p 953
#define q 6343
#define q32inv 677119
#define Rounded_bytes 1317
#ifndef LPR
#define Rq_bytes 1505
#define w 396
#else
#define w 345
#define tau0 2997
#define tau1 82
#define tau2 2798
#define tau3 400
#endif

#elif defined(SIZE1013)
#define p 1013
#define q 7177
#define q32inv 598435
#define Rounded_bytes 1423
#ifndef LPR
#define Rq_bytes 1623
#define w 448
#else
#define w 392
#define tau0 3367
#define tau1 73
#define tau2 3143
#define tau3 449
#endif

#elif defined(SIZE1277)
#define p 1277
#define q 7879
#define q32inv 545116
#define Rounded_bytes 1815
#ifndef LPR
#define Rq_bytes 2067
#define w 492
#else
#define w 429
#define tau0 3724
#define tau1 66
#define tau2 3469
#define tau3 496
#endif

#else
#error "no parameter set defined"
#endif

#ifdef LPR
#define I 256
#endif

#endif
