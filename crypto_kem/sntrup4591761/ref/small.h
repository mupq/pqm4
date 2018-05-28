#ifndef small_h
#define small_h

#include <stdint.h>

typedef int8_t small;

#define small_encode crypto_kem_sntrup4591761_ref_small_encode
extern void small_encode(unsigned char *,const small *);

#define small_decode crypto_kem_sntrup4591761_ref_small_decode
extern void small_decode(small *,const unsigned char *);

#define small_random32 crypto_kem_sntrup4591761_ref_small_random32
extern int32_t small_random32(void);

#define small_random crypto_kem_sntrup4591761_ref_small_random
extern void small_random(small *);

#define small_random_weightw crypto_kem_sntrup4591761_ref_small_random_weightw
extern void small_random_weightw(small *);

#endif
