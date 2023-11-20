#include "fp84_76.h"
#include "fpa.h"
#include "inttypes.h"
#include <stddef.h>

// we only need positive values, the accumulator will be different data type

void fp_convert_84_76_to_96_76(fp96_76 *dest, const fp84_76 *src){
    uint32_t s0 = src->digit[0];
    uint32_t s1 = src->digit[1];
    uint32_t s2 = src->digit[2];

    uint64_t d0_mask = ((1ULL<<FP_96_76_DIGIT_SIZE)-1);
    size_t d1_shmnt = (FP_96_76_DIGIT_SIZE-FP_84_76_DIGIT_SIZE);
    size_t shmnt84 = FP_84_76_DIGIT_SIZE;

    dest->limb48[0] = (((uint64_t) s1 << shmnt84) | s0) & d0_mask;
    dest->limb48[1] = (((uint64_t) s2 << shmnt84) | s1) >> d1_shmnt;
}

static inline uint32_t low_word(int64_t x){
    return (uint32_t) (x & ((1ULL << 32)-1));
}

static inline int32_t extract_bits_20_to_27(uint32_t bits){
    // extract bit 20..27 from bits
    return (int32_t) ((bits >> 20) & ((1<<8)-1));
}

static inline int32_t assemble_8_and_20_bits(int32_t lo_bits, uint32_t hi_bits){
    return (int32_t) ((lo_bits | (hi_bits << 8)) & ((1<<28)-1));;
}

/**********************************************************************
 * Name: fp84_76_square
 * Description: Square a normalized, positive, 80-bit value using 
 *              schoolbook multiplication. 
 *              
 * Input:
 *      fp84_76 *x:   The value to be squared. 
 * Output:
 *      fp84_76 *sqx: The square of x as a positive, normalized 
 *                    84-bit value.
 **********************************************************************/
void fp84_76_square(fp84_76 *sqx, const fp84_76 *x){
    digit28 xl = x->digit[0];
    digit28 xm = x->digit[1];
    digit28 xh = x->digit[2];
    digit28 sl = 0;
    digit28 sm = 0;
    digit28 sh = 0;
    int64_t tmp;
    int64_t tmp2;
    uint32_t bits;

    tmp = (int64_t) xl * xl;
    tmp >>= FP_84_76_DIGIT_SIZE;

    tmp += (int64_t) xm * (xl << 1);
    tmp >>= FP_84_76_DIGIT_SIZE;

    tmp += (int64_t) xh * (xl << 1);
    tmp += (int64_t) xm * xm;
    tmp += (1ULL<<19); // rounding
    bits = low_word(tmp);
    sl = extract_bits_20_to_27(bits);
    tmp >>= FP_84_76_DIGIT_SIZE;

    tmp2 = (int64_t) xh * xm;
    tmp += tmp2;
    tmp += tmp2;
    bits = low_word(tmp);
    sl = assemble_8_and_20_bits(sl, bits);
    sm = extract_bits_20_to_27(bits);
    tmp >>= FP_84_76_DIGIT_SIZE;

    tmp += (int64_t) xh * xh;
    bits = low_word(tmp);
    sm = assemble_8_and_20_bits(sm, bits);
    bits = low_word(tmp >> 20);
    sh = bits & ((1<<28)-1);

    sqx->digit[0] = sl;
    sqx->digit[1] = sm;
    sqx->digit[2] = sh;
} 


/**********************************************************************
 * Name: fp84_76_mul
 * Description: Multiply two normalized, positive, 80-bit value using 
 *              schoolbook multiplication. 
 *              
 * Input:
 *      fp84_76 *a:   The first factor of the product
 *      fp84_76 *b:   The second factor of the product
 * Output:
 *      fp84_76 *result: The product of a and b.
 **********************************************************************/
void fp84_76_mul(fp84_76 *result, const fp84_76 *a, const fp84_76 *b){
    const digit28 al = a->digit[0];
    const digit28 am = a->digit[1];
    const digit28 ah = a->digit[2];
    const digit28 bl = b->digit[0];
    const digit28 bm = b->digit[1];
    const digit28 bh = b->digit[2];
    digit28 rl = 0;
    digit28 rm = 0;
    digit28 rh = 0;
    int64_t tmp;
    uint32_t bits;

    tmp = (int64_t) al * bl;
    tmp >>= FP_84_76_DIGIT_SIZE;

    tmp += (int64_t) am * bl;
    tmp += (int64_t) al * bm;
    tmp >>= FP_84_76_DIGIT_SIZE;

    tmp += (int64_t) ah * bl;
    tmp += (int64_t) am * bm;
    tmp += (int64_t) al * bh;
    tmp += (1ULL<<19); // rounding
    bits = low_word(tmp);
    rl = extract_bits_20_to_27(bits);
    tmp >>= FP_84_76_DIGIT_SIZE;

    tmp += (int64_t) ah * bm;
    tmp += (int64_t) am * bh;
    bits = low_word(tmp);
    rl = assemble_8_and_20_bits(rl, bits);
    rm = extract_bits_20_to_27(bits);
    tmp >>= FP_84_76_DIGIT_SIZE;

    tmp += (int64_t) ah * bh;
    bits = low_word(tmp);
    rm = assemble_8_and_20_bits(rm, bits);
    bits = low_word(tmp >> 20);
    rh = bits & ((1<<28)-1);

    result->digit[0] = rl;
    result->digit[1] = rm;
    result->digit[2] = rh;
} 

/**********************************************************************
 * Name: fp84_76_mul_high
 * Description: Multiply two normalized, positive, 80-bit value using 
 *              schoolbook multiplication. 
 *              
 * Input:
 *      fp84_76 *a:   The first factor of the product
 *      fp84_76 *b:   The second factor of the product
 * Output:
 *      fp84_76 *result: The product of a and b.
 **********************************************************************/
void fp84_76_mul_high(fp84_76 *result, const fp84_76 *a, const fp8_4 bits_73_to_80){
    const digit28 al = a->digit[0];             // fp_28_76
    const digit28 am = a->digit[1];             // fp_28_48
    const digit28 ah = a->digit[2];             // fp_28_20
    const digit28 bh = bits_73_to_80 << 16;
    digit28 rl = 0;
    digit28 rm = 0;
    digit28 rh = 0;
    int64_t tmp;
    uint32_t bits;

    tmp  = (int64_t) al * bh;
    tmp += (1ULL<<19); // rounding
    bits = low_word(tmp);
    rl = extract_bits_20_to_27(bits);
    tmp >>= FP_84_76_DIGIT_SIZE;

    tmp += (int64_t) am * bh;
    bits = low_word(tmp);
    rl = assemble_8_and_20_bits(rl, bits);
    rm = extract_bits_20_to_27(bits);
    tmp >>= FP_84_76_DIGIT_SIZE;

    tmp += (int64_t) ah * bh;
    bits = low_word(tmp);
    rm = assemble_8_and_20_bits(rm, bits);
    bits = low_word(tmp >> 20);
    rh = bits & ((1<<28)-1);

    result->digit[0] = rl;
    result->digit[1] = rm;
    result->digit[2] = rh;
} 

void convert_fp112_76_to_fp96_76(fp96_76 *dest, const fp112_76 *src){
    digit28 src0 = src->digit[0];
    digit28 src1 = src->digit[1];
    digit28 src2 = src->digit[2];
    digit28 src3 = src->digit[3];
    uint64_t dest0;
    uint64_t dest1;

    dest0  = (uint64_t) src1 << 28;
    dest0 += src0;
    dest0 &= ((1ULL<<FP_96_76_DIGIT_SIZE)-1);
    dest1  = (uint64_t) src3 << (3 * FP_112_76_DIGIT_SIZE - FP_96_76_DIGIT_SIZE); // 36
    dest1 += (uint64_t) src2 << (2 * FP_112_76_DIGIT_SIZE - FP_96_76_DIGIT_SIZE); //  8
    dest1 += (uint64_t) src1 >> (FP_96_76_DIGIT_SIZE - FP_112_76_DIGIT_SIZE);     // 20

    dest->limb48[0] = dest0;
    dest->limb48[1] = dest1;
}

void conditional_accumulate_fp112_96(fp112_76 *accum, const fp84_76 *x, int accepted){
    accum->digit[0] += x->digit[0]  & -(digit28)accepted;
    accum->digit[1] += x->digit[1]  & -(digit28)accepted;
    accum->digit[2] += x->digit[2]  & -(digit28)accepted;
    // There are only three digits in x, so the fourth digit
    // of accum remains untouched.
    return;
}

void normalize_fp112_96(fp112_76 *x){
    digit28 x0 = x->digit[0];
    digit28 x1 = x->digit[1];
    digit28 x2 = x->digit[2];
    digit28 x3 = x->digit[3];
    digit28 carry;

    carry = x0 >> FP_112_76_DIGIT_SIZE;     
    x1 += carry;     
    x0 -= carry << FP_112_76_DIGIT_SIZE;
    
    carry = x1 >> FP_112_76_DIGIT_SIZE;     
    x2 += carry;     
    x1 -= carry << FP_112_76_DIGIT_SIZE;
    
    carry = x2 >> FP_112_76_DIGIT_SIZE;     
    x3 += carry;     
    x2 -= carry << FP_112_76_DIGIT_SIZE;

    x->digit[0] = x0;
    x->digit[1] = x1;
    x->digit[2] = x2;
    x->digit[3] = x3;
    return;
}

void convert_fp96_76_to_fp112_76(fp112_76 *dest, const fp96_76 *src){
    // untested
    uint64_t src0 = src->limb48[0];
    uint64_t src1 = src->limb48[1];
    digit28 dest0;
    digit28 dest1;
    digit28 dest2;
    digit28 dest3;

    dest0  = src0 & FP_112_76_DIGIT_MASK;
    dest1  = (src0 >> 28) & ((1<<20)-1);
    dest1 |= (src1 & ((1<<8)-1)<<20);
    dest2  = (src1 >> 8) & FP_112_76_DIGIT_MASK;
    dest3  = src1 >> (8+28);  

    dest->digit[0] = dest0;
    dest->digit[1] = dest1;
    dest->digit[2] = dest2;
    dest->digit[3] = dest3;

}

int32_t first_is_lt_second_fp112_76(const fp112_76 *first, const fp112_76 *second){
    int32_t carry;
    int32_t sign;
    carry = (first->digit[0] - second->digit[0]        ) >> FP_112_76_DIGIT_SIZE;
    carry = (first->digit[1] - second->digit[1] + carry) >> FP_112_76_DIGIT_SIZE;
    carry = (first->digit[2] - second->digit[2] + carry) >> FP_112_76_DIGIT_SIZE;
    sign  = (first->digit[3] - second->digit[3] + carry) >> (FP_112_76_WORD_LEN - 1); // 0 or -1
    return sign + 1;
}

void set_to_zero_112(fp112_76 *x){
    x->digit[0] = 0;
    x->digit[1] = 0;
    x->digit[2] = 0;
    x->digit[3] = 0;
};