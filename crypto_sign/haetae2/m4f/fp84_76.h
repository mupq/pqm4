#ifndef FP84_76_H
#define FP84_76_H

#include "config.h"
#include "fpa.h"

#define fp76_30_to_48_bit_digits HAETAE_NAMESPACE(fp76_30_to_48_bit_digits)
void fp_convert_84_76_to_96_76(fp96_76 *dest, const fp84_76 *src);

#define fp84_76_square HAETAE_NAMESPACE(fp84_76_square)
void fp84_76_square(fp84_76 *sqx, const fp84_76 *x);

#define fp84_76_mul HAETAE_NAMESPACE(fp84_76_mul)
void fp84_76_mul(fp84_76 *result, const fp84_76 *a, const fp84_76 *b);

#define fp84_76_mul_high HAETAE_NAMESPACE(fp84_76_mul_high)
void fp84_76_mul_high(fp84_76 *result, const fp84_76 *a, const fp8_4 bits_73_to_80);

#define conditional_accumulate_fp112_96 HAETAE_NAMESPACE(conditional_accumulate_fp112_96)
void conditional_accumulate_fp112_96(fp112_76 *accum, const fp84_76 *x, int accepted);

#define normalize_fp112_96 HAETAE_NAMESPACE(normalize_fp112_96)
void normalize_fp112_96(fp112_76 *x);

#define convert_fp112_76_to_fp96_76 HAETAE_NAMESPACE(convert_fp112_76_to_fp96_76)
void convert_fp112_76_to_fp96_76(fp96_76 *dest, const fp112_76 *src);

#define convert_fp96_76_to_fp112_76 HAETAE_NAMESPACE(convert_fp96_76_to_fp112_76)
void convert_fp96_76_to_fp112_76(fp112_76 *dest, const fp96_76 *src);

#define first_is_lt_second_fp112_76 HAETAE_NAMESPACE(first_is_lt_second_fp112_76)
int32_t first_is_lt_second_fp112_76(const fp112_76 *first, const fp112_76 *second);

//#define set_to_zero_112 HAETAE_NAMESPACE(set_to_zero_112)
void set_to_zero_112(fp112_76 *x);
#endif