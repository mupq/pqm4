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

#else
#error "no parameter set defined"
#endif

#ifdef LPR
#define I 256
#endif

#endif
