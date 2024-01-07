#ifndef FPA_H
#define FPA_H

#include <inttypes.h>

#define FP_63_48_SCALE (48)
#define FP_63_48_DIGIT_SIZE (24)                             // bit-length of the digits
#define FP_63_48_WORD_LEN (32)                               // bit-length of the word the digit is embedded in
#define FP_63_48_WORD_MASK ((1LL << FP_63_48_WORD_LEN) - 1)  // corresponding mask

#define FP_84_76_SCALE (76)
#define FP_84_76_DIGIT_SIZE (28)                             // bit-length of the digits
#define FP_84_76_DIGIT_MASK ((1 << FP_84_76_DIGIT_SIZE) - 1) // bit-length of the digits
#define FP_84_76_WORD_LEN (32)                               // bit-length of the word the digit is embedded in

#define FP_112_76_SCALE (76)
#define FP_112_76_DIGIT_SIZE (28)                             // bit-length of the digits
#define FP_112_76_DIGIT_MASK ((1 << FP_112_76_DIGIT_SIZE) - 1) // bit-length of the digits
#define FP_112_76_WORD_LEN (32)                               // bit-length of the word the digit is embedded in

#define FP_96_76_SCALE (76)
#define FP_96_76_DIGIT_SIZE (48)                             // bit-length of the digits
#define FP_96_76_WORD_LEN (64)                               // bit-length of the word the digit is embedded in


typedef int32_t digit24;            // digit with 24 bits
typedef int32_t digit28;            // digit with 30 bits

typedef int64_t fp63_48;            // does not use digits
typedef uint64_t fp63_48_digits;    // digits storage container

typedef int32_t fp8_4;

typedef struct {
    digit28 digit[3];
} fp84_76;

typedef struct {
    uint64_t limb48[2];
} fp96_76;

typedef struct {
    digit28 digit[4];
} fp112_76;


#endif