/********************************************************************************************
* Supersingular Isogeny Key Encapsulation Library
*
* Abstract: portable modular arithmetic for P434
*********************************************************************************************/

#include "P434_internal.h"


// Global constants
extern const uint64_t p434[NWORDS_FIELD];
extern const uint64_t p434p1[NWORDS_FIELD];
extern const uint64_t p434x2[NWORDS_FIELD];


__inline void fpadd434(const digit_t* a, const digit_t* b, digit_t* c)
{ // Modular addition, c = a+b mod p434.
  // Inputs: a, b in [0, 2*p434-1]
  // Output: c in [0, 2*p434-1]

	asm(

		"push  {r4-r11,lr}			\n\t"
		"MOVW  R14,#0xFFFF	\n\t"
		"MOVT  R14,#0xFFFF	\n\t"

		"mov r3, r2 \n\t"
		"ldmia r0!, {r4-r7} 			\n\t"
		"ldmia r1!, {r8-r11} 			\n\t"

		"adds r4, r4, r8				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r10				\n\t"
		"adcs r7, r7, r11				\n\t"
		"adcs r2, r14, r14				\n\t"

		"MOVW  R8,#0xFFFE	\n\t"
		"MOVT  R8,#0xFFFF	\n\t"

		"subs r4, r4, r8				\n\t"
		"sbcs r5, r5, r14				\n\t"
		"sbcs r6, r6, r14				\n\t"
		"sbcs r7, r7, r14				\n\t"
		"sbcs r12, r12, r12				\n\t"


		"stmia r3!, {r4-r7} 			\n\t"

		"ldmia r0!, {r4-r6} 			\n\t"
		"ldmia r1!, {r8-r10} 			\n\t"

		"adds r2, r14, r2, lsl#31				\n\t"
		"adcs r4, r4, r8				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r10				\n\t"
		"adcs r2, r14, r14				\n\t"

		"MOVW  R10,#0xFFFF	\n\t"
		"MOVT  R10,#0xC5FF	\n\t"

		"subs r12, r0, r12				\n\t"
		"sbcs r4, r4, r14				\n\t"
		"sbcs r5, r5, r14				\n\t"
		"sbcs r6, r6, r10				\n\t"
		"sbcs r12, r12, r12				\n\t"

		"stmia r3!, {r4-r6} 			\n\t"

		"ldmia r0!, {r4-r7} 			\n\t"
		"ldmia r1!, {r8-r11} 			\n\t"

		"adds r2, r14, r2, lsl#31				\n\t"
		"adcs r4, r4, r8				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r10				\n\t"
		"adcs r7, r7, r11				\n\t"
		"adcs r2, r14, r14				\n\t"


		"MOVW  R8,#0xECF5	\n\t"
		"MOVT  R8,#0xFB82	\n\t"
		"MOVW  R9,#0x5D47	\n\t"
		"MOVT  R9,#0x62B1	\n\t"
		"MOVW  R10,#0xB8F0	\n\t"
		"MOVT  R10,#0xF78C	\n\t"
		"MOVW  R11,#0x40AC	\n\t"
		"MOVT  R11,#0x38A	\n\t"

		"subs r12, r0, r12				\n\t"
		"sbcs r4, r4, r8				\n\t"
		"sbcs r5, r5, r9				\n\t"
		"sbcs r6, r6, r10				\n\t"
		"sbcs r7, r7, r11				\n\t"
		"sbcs r12, r12, r12				\n\t"

		"stmia r3!, {r4-r7} 			\n\t"

		"ldmia r0!, {r4-r6} 			\n\t"
		"ldmia r1!, {r8-r10} 			\n\t"

		"adds r2, r14, r2, lsl#31				\n\t"
		"adcs r4, r4, r8				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r10				\n\t"

		"MOVW  R8,#0xBFAD	\n\t"
		"MOVT  R8,#0xD9F8	\n\t"
		"MOVW  R9,#0xE688	\n\t"
		"MOVT  R9,#0x4E2E	\n\t"
		"MOVW  R10,#0x683E	\n\t"
		"MOVT  R10,#0x4	\n\t"

		"subs r12, r0, r12				\n\t"
		"sbcs r4, r4, r8				\n\t"
		"sbcs r5, r5, r9				\n\t"
		"sbcs r6, r6, r10				\n\t"
		"sbcs r12, r12, r12				\n\t"


		"stmia r3!, {r4-r6} 			\n\t"

		"sub r3, r3, #4*14				\n\t"

		"ldmia r3, {r4-r7} 			\n\t"
		"MOVW  R8,#0xFFFE	\n\t"
		"MOVT  R8,#0xFFFF	\n\t"
		"MOVW  R9,#0xFFFF	\n\t"
		"MOVT  R9,#0xFFFF	\n\t"


		"and r8, r8, r12				\n\t"
		"and r9, r9, r12				\n\t"

		"adds r4, r4, r8				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r9				\n\t"
		"adcs r7, r7, r9				\n\t"
		"stmia r3!, {r4-r7} 			\n\t"

		"ldmia r3, {r4-r6} 			\n\t"

		"MOVW  R10,#0xFFFF	\n\t"
		"MOVT  R10,#0xC5FF	\n\t"

		"and r10, r10, r12				\n\t"

		"adcs r4, r4, r9				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r10				\n\t"
		"stmia r3!, {r4-r6} 			\n\t"

		"ldmia r3, {r4-r7} 			\n\t"

		"MOVW  R8,#0xECF5	\n\t"
		"MOVT  R8,#0xFB82	\n\t"
		"MOVW  R9,#0x5D47	\n\t"
		"MOVT  R9,#0x62B1	\n\t"
		"MOVW  R10,#0xB8F0	\n\t"
		"MOVT  R10,#0xF78C	\n\t"
		"MOVW  R11,#0x40AC	\n\t"
		"MOVT  R11,#0x38A	\n\t"

		"and r8, r8, r12				\n\t"
		"and r9, r9, r12				\n\t"
		"and r10, r10, r12				\n\t"
		"and r11, r11, r12				\n\t"

		"adcs r4, r4, r8				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r10				\n\t"
		"adcs r7, r7, r11				\n\t"
		"stmia r3!, {r4-r7} 			\n\t"

		"ldmia r3, {r4-r6} 			\n\t"

		"MOVW  R8,#0xBFAD	\n\t"
		"MOVT  R8,#0xD9F8	\n\t"
		"MOVW  R9,#0xE688	\n\t"
		"MOVT  R9,#0x4E2E	\n\t"
		"MOVW  R10,#0x683E	\n\t"
		"MOVT  R10,#0x4	\n\t"

		"and r8, r8, r12				\n\t"
		"and r9, r9, r12				\n\t"
		"and r10, r10, r12				\n\t"

		"adcs r4, r4, r8				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r10				\n\t"
		"stmia r3!, {r4-r6} 			\n\t"

		"pop  {r4-r11,pc}				\n\t"
:
:
:
);
}


__inline void fpsub434(const digit_t* a, const digit_t* b, digit_t* c)
{

// Modular subtraction, c = a-b mod p434.
  // Inputs: a, b in [0, 2*p434-1]
  // Output: c in [0, 2*p434-1]

	asm(

		"push  {r4-r11,lr}			\n\t"

		"mov r3, r2 \n\t"

		"ldmia r0!, {r4-r7} 			\n\t"
		"ldmia r1!, {r8-r11} 			\n\t"

		"subs r4, r4, r8				\n\t"
		"sbcs r5, r5, r9				\n\t"
		"sbcs r6, r6, r10				\n\t"
		"sbcs r7, r7, r11				\n\t"

		"stmia r3!, {r4-r7} 			\n\t"

		"ldmia r0!, {r4-r7} 			\n\t"
		"ldmia r1!, {r8-r11} 			\n\t"

		"sbcs r4, r4, r8				\n\t"
		"sbcs r5, r5, r9				\n\t"
		"sbcs r6, r6, r10				\n\t"
		"sbcs r7, r7, r11				\n\t"

		"stmia r3!, {r4-r7} 			\n\t"

		"ldmia r0!, {r4-r7} 			\n\t"
		"ldmia r1!, {r8-r11} 			\n\t"

		"sbcs r4, r4, r8				\n\t"
		"sbcs r5, r5, r9				\n\t"
		"sbcs r6, r6, r10				\n\t"
		"sbcs r7, r7, r11				\n\t"

		"stmia r3!, {r4-r7} 			\n\t"

		"ldmia r0!, {r4-r5} 			\n\t"
		"ldmia r1!, {r8-r9} 			\n\t"

		"sbcs r4, r4, r8				\n\t"
		"sbcs r5, r5, r9				\n\t"

		"sbcs r12, r12, r12				\n\t"

		"stmia r3!, {r4-r5} 			\n\t"

		"sub r3, r3, #4*14				\n\t"

		"ldmia r3, {r4-r7} 			\n\t"



		"MOVW  R8,#0xFFFE	\n\t"
		"MOVT  R8,#0xFFFF	\n\t"
		"MOVW  R9,#0xFFFF	\n\t"
		"MOVT  R9,#0xFFFF	\n\t"


		"and r8, r8, r12				\n\t"
		"and r9, r9, r12				\n\t"

		"adds r4, r4, r8				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r9				\n\t"
		"adcs r7, r7, r9				\n\t"
		"stmia r3!, {r4-r7} 			\n\t"

		"ldmia r3, {r4-r6} 			\n\t"

		"MOVW  R10,#0xFFFF	\n\t"
		"MOVT  R10,#0xC5FF	\n\t"

		"and r10, r10, r12				\n\t"

		"adcs r4, r4, r9				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r10				\n\t"
		"stmia r3!, {r4-r6} 			\n\t"

		"ldmia r3, {r4-r7} 			\n\t"

		"MOVW  R8,#0xECF5	\n\t"
		"MOVT  R8,#0xFB82	\n\t"
		"MOVW  R9,#0x5D47	\n\t"
		"MOVT  R9,#0x62B1	\n\t"
		"MOVW  R10,#0xB8F0	\n\t"
		"MOVT  R10,#0xF78C	\n\t"
		"MOVW  R11,#0x40AC	\n\t"
		"MOVT  R11,#0x38A	\n\t"

		"and r8, r8, r12				\n\t"
		"and r9, r9, r12				\n\t"
		"and r10, r10, r12				\n\t"
		"and r11, r11, r12				\n\t"

		"adcs r4, r4, r8				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r10				\n\t"
		"adcs r7, r7, r11				\n\t"
		"stmia r3!, {r4-r7} 			\n\t"

		"ldmia r3, {r4-r6} 			\n\t"

					"MOVW  R8,#0xBFAD	\n\t"
		"MOVT  R8,#0xD9F8	\n\t"
		"MOVW  R9,#0xE688	\n\t"
		"MOVT  R9,#0x4E2E	\n\t"
		"MOVW  R10,#0x683E	\n\t"
		"MOVT  R10,#0x4	\n\t"

		"and r8, r8, r12				\n\t"
		"and r9, r9, r12				\n\t"
		"and r10, r10, r12				\n\t"

		"adcs r4, r4, r8				\n\t"
		"adcs r5, r5, r9				\n\t"
		"adcs r6, r6, r10				\n\t"
		"stmia r3!, {r4-r6} 			\n\t"

		"pop  {r4-r11,pc}				\n\t"
:
:
:
);
}


__inline void fpneg434(digit_t* a)
{ // Modular negation, a = -a mod p434.
  // Input/output: a in [0, 2*p434-1]
    unsigned int i, borrow = 0;

    for (i = 0; i < NWORDS_FIELD; i++) {
        SUBC(borrow, ((digit_t*)p434x2)[i], a[i], borrow, a[i]);
    }
}


void fpdiv2_434(const digit_t* a, digit_t* c)
{ // Modular division by two, c = a/2 mod p434.
  // Input : a in [0, 2*p434-1]
  // Output: c in [0, 2*p434-1]
    unsigned int i, carry = 0;
    digit_t mask;

    mask = 0 - (digit_t)(a[0] & 1);    // If a is odd compute a+p434
    for (i = 0; i < NWORDS_FIELD; i++) {
        ADDC(carry, a[i], ((digit_t*)p434)[i] & mask, carry, c[i]);
    }

    mp_shiftr1(c, NWORDS_FIELD);
}


void fpcorrection434(digit_t* a)
{ // Modular correction to reduce field element a in [0, 2*p434-1] to [0, p434-1].
    unsigned int i, borrow = 0;
    digit_t mask;

    for (i = 0; i < NWORDS_FIELD; i++) {
        SUBC(borrow, a[i], ((digit_t*)p434)[i], borrow, a[i]);
    }
    mask = 0 - (digit_t)borrow;

    borrow = 0;
    for (i = 0; i < NWORDS_FIELD; i++) {
        ADDC(borrow, a[i], ((digit_t*)p434)[i] & mask, borrow, a[i]);
    }
}


void digit_x_digit(const digit_t a, const digit_t b, digit_t* c)
{ // Digit multiplication, digit * digit -> 2-digit result
    register digit_t al, ah, bl, bh, temp;
    digit_t albl, albh, ahbl, ahbh, res1, res2, res3, carry;
    digit_t mask_low = (digit_t)(-1) >> (sizeof(digit_t)*4), mask_high = (digit_t)(-1) << (sizeof(digit_t)*4);

    al = a & mask_low;                        // Low part
    ah = a >> (sizeof(digit_t) * 4);          // High part
    bl = b & mask_low;
    bh = b >> (sizeof(digit_t) * 4);

    albl = al*bl;
    albh = al*bh;
    ahbl = ah*bl;
    ahbh = ah*bh;
    c[0] = albl & mask_low;                   // C00

    res1 = albl >> (sizeof(digit_t) * 4);
    res2 = ahbl & mask_low;
    res3 = albh & mask_low;
    temp = res1 + res2 + res3;
    carry = temp >> (sizeof(digit_t) * 4);
    c[0] ^= temp << (sizeof(digit_t) * 4);    // C01

    res1 = ahbl >> (sizeof(digit_t) * 4);
    res2 = albh >> (sizeof(digit_t) * 4);
    res3 = ahbh & mask_low;
    temp = res1 + res2 + res3 + carry;
    c[1] = temp & mask_low;                   // C10
    carry = temp & mask_high;
    c[1] ^= (ahbh & mask_high) + carry;       // C11
}


void mp_mul(const digit_t* a, const digit_t* b, digit_t* c, const unsigned int nwords)
{ // Multiprecision comba multiply, c = a*b, where lng(a) = lng(b) = nwords.
    unsigned int i, j;
    digit_t t = 0, u = 0, v = 0, UV[2];
    unsigned int carry = 0;

    for (i = 0; i < nwords; i++) {
        for (j = 0; j <= i; j++) {
            MUL(a[j], b[i-j], UV+1, UV[0]);
            ADDC(0, UV[0], v, carry, v);
            ADDC(carry, UV[1], u, carry, u);
            t += carry;
        }
        c[i] = v;
        v = u;
        u = t;
        t = 0;
    }

    for (i = nwords; i < 2*nwords-1; i++) {
        for (j = i-nwords+1; j < nwords; j++) {
            MUL(a[j], b[i-j], UV+1, UV[0]);
            ADDC(0, UV[0], v, carry, v);
            ADDC(carry, UV[1], u, carry, u);
            t += carry;
        }
        c[i] = v;
        v = u;
        u = t;
        t = 0;
    }
    c[2*nwords-1] = v;
}


void rdc_mont(const dfelm_t ma, felm_t mc)
{ // Efficient Montgomery reduction using comba and exploiting the special form of the prime p434.
  // mc = ma*R^-1 mod p434x2, where R = 2^768.
  // If ma < 2^768*p434, the output mc is in the range [0, 2*p434-1].
  // ma is assumed to be in Montgomery representation.
    unsigned int i, j, carry, count = p434_ZERO_WORDS;
    digit_t UV[2], t = 0, u = 0, v = 0;

    for (i = 0; i < NWORDS_FIELD; i++) {
        mc[i] = 0;
    }

    for (i = 0; i < NWORDS_FIELD; i++) {
        for (j = 0; j < i; j++) {
            if (j < (i-p434_ZERO_WORDS+1)) {
                MUL(mc[j], ((digit_t*)p434p1)[i-j], UV+1, UV[0]);
                ADDC(0, UV[0], v, carry, v);
                ADDC(carry, UV[1], u, carry, u);
                t += carry;
            }
        }
        ADDC(0, v, ma[i], carry, v);
        ADDC(carry, u, 0, carry, u);
        t += carry;
        mc[i] = v;
        v = u;
        u = t;
        t = 0;
    }

    for (i = NWORDS_FIELD; i < 2*NWORDS_FIELD-1; i++) {
        if (count > 0) {
            count -= 1;
        }
        for (j = i-NWORDS_FIELD+1; j < NWORDS_FIELD; j++) {
            if (j < (NWORDS_FIELD-count)) {
                MUL(mc[j], ((digit_t*)p434p1)[i-j], UV+1, UV[0]);
                ADDC(0, UV[0], v, carry, v);
                ADDC(carry, UV[1], u, carry, u);
                t += carry;
            }
        }
        ADDC(0, v, ma[i], carry, v);
        ADDC(carry, u, 0, carry, u);
        t += carry;
        mc[i-NWORDS_FIELD] = v;
        v = u;
        u = t;
        t = 0;
    }
    ADDC(0, v, ma[2*NWORDS_FIELD-1], carry, v);
    mc[NWORDS_FIELD-1] = v;
}
