#include "fft.h"

static const complex_fp32_16 roots[] = {
    {.real = +65536L, .imag = +0L},     {.real = +65531L, .imag = -804L},
    {.real = +65516L, .imag = -1608L},  {.real = +65492L, .imag = -2412L},
    {.real = +65457L, .imag = -3216L},  {.real = +65413L, .imag = -4019L},
    {.real = +65358L, .imag = -4821L},  {.real = +65294L, .imag = -5623L},
    {.real = +65220L, .imag = -6424L},  {.real = +65137L, .imag = -7224L},
    {.real = +65043L, .imag = -8022L},  {.real = +64940L, .imag = -8820L},
    {.real = +64827L, .imag = -9616L},  {.real = +64704L, .imag = -10411L},
    {.real = +64571L, .imag = -11204L}, {.real = +64429L, .imag = -11996L},
    {.real = +64277L, .imag = -12785L}, {.real = +64115L, .imag = -13573L},
    {.real = +63944L, .imag = -14359L}, {.real = +63763L, .imag = -15143L},
    {.real = +63572L, .imag = -15924L}, {.real = +63372L, .imag = -16703L},
    {.real = +63162L, .imag = -17479L}, {.real = +62943L, .imag = -18253L},
    {.real = +62714L, .imag = -19024L}, {.real = +62476L, .imag = -19792L},
    {.real = +62228L, .imag = -20557L}, {.real = +61971L, .imag = -21320L},
    {.real = +61705L, .imag = -22078L}, {.real = +61429L, .imag = -22834L},
    {.real = +61145L, .imag = -23586L}, {.real = +60851L, .imag = -24335L},
    {.real = +60547L, .imag = -25080L}, {.real = +60235L, .imag = -25821L},
    {.real = +59914L, .imag = -26558L}, {.real = +59583L, .imag = -27291L},
    {.real = +59244L, .imag = -28020L}, {.real = +58896L, .imag = -28745L},
    {.real = +58538L, .imag = -29466L}, {.real = +58172L, .imag = -30182L},
    {.real = +57798L, .imag = -30893L}, {.real = +57414L, .imag = -31600L},
    {.real = +57022L, .imag = -32303L}, {.real = +56621L, .imag = -33000L},
    {.real = +56212L, .imag = -33692L}, {.real = +55794L, .imag = -34380L},
    {.real = +55368L, .imag = -35062L}, {.real = +54934L, .imag = -35738L},
    {.real = +54491L, .imag = -36410L}, {.real = +54040L, .imag = -37076L},
    {.real = +53581L, .imag = -37736L}, {.real = +53114L, .imag = -38391L},
    {.real = +52639L, .imag = -39040L}, {.real = +52156L, .imag = -39683L},
    {.real = +51665L, .imag = -40320L}, {.real = +51166L, .imag = -40951L},
    {.real = +50660L, .imag = -41576L}, {.real = +50146L, .imag = -42194L},
    {.real = +49624L, .imag = -42806L}, {.real = +49095L, .imag = -43412L},
    {.real = +48559L, .imag = -44011L}, {.real = +48015L, .imag = -44604L},
    {.real = +47464L, .imag = -45190L}, {.real = +46906L, .imag = -45769L},
    {.real = +46341L, .imag = -46341L}, {.real = +45769L, .imag = -46906L},
    {.real = +45190L, .imag = -47464L}, {.real = +44604L, .imag = -48015L},
    {.real = +44011L, .imag = -48559L}, {.real = +43412L, .imag = -49095L},
    {.real = +42806L, .imag = -49624L}, {.real = +42194L, .imag = -50146L},
    {.real = +41576L, .imag = -50660L}, {.real = +40951L, .imag = -51166L},
    {.real = +40320L, .imag = -51665L}, {.real = +39683L, .imag = -52156L},
    {.real = +39040L, .imag = -52639L}, {.real = +38391L, .imag = -53114L},
    {.real = +37736L, .imag = -53581L}, {.real = +37076L, .imag = -54040L},
    {.real = +36410L, .imag = -54491L}, {.real = +35738L, .imag = -54934L},
    {.real = +35062L, .imag = -55368L}, {.real = +34380L, .imag = -55794L},
    {.real = +33692L, .imag = -56212L}, {.real = +33000L, .imag = -56621L},
    {.real = +32303L, .imag = -57022L}, {.real = +31600L, .imag = -57414L},
    {.real = +30893L, .imag = -57798L}, {.real = +30182L, .imag = -58172L},
    {.real = +29466L, .imag = -58538L}, {.real = +28745L, .imag = -58896L},
    {.real = +28020L, .imag = -59244L}, {.real = +27291L, .imag = -59583L},
    {.real = +26558L, .imag = -59914L}, {.real = +25821L, .imag = -60235L},
    {.real = +25080L, .imag = -60547L}, {.real = +24335L, .imag = -60851L},
    {.real = +23586L, .imag = -61145L}, {.real = +22834L, .imag = -61429L},
    {.real = +22078L, .imag = -61705L}, {.real = +21320L, .imag = -61971L},
    {.real = +20557L, .imag = -62228L}, {.real = +19792L, .imag = -62476L},
    {.real = +19024L, .imag = -62714L}, {.real = +18253L, .imag = -62943L},
    {.real = +17479L, .imag = -63162L}, {.real = +16703L, .imag = -63372L},
    {.real = +15924L, .imag = -63572L}, {.real = +15143L, .imag = -63763L},
    {.real = +14359L, .imag = -63944L}, {.real = +13573L, .imag = -64115L},
    {.real = +12785L, .imag = -64277L}, {.real = +11996L, .imag = -64429L},
    {.real = +11204L, .imag = -64571L}, {.real = +10411L, .imag = -64704L},
    {.real = +9616L, .imag = -64827L},  {.real = +8820L, .imag = -64940L},
    {.real = +8022L, .imag = -65043L},  {.real = +7224L, .imag = -65137L},
    {.real = +6424L, .imag = -65220L},  {.real = +5623L, .imag = -65294L},
    {.real = +4821L, .imag = -65358L},  {.real = +4019L, .imag = -65413L},
    {.real = +3216L, .imag = -65457L},  {.real = +2412L, .imag = -65492L},
    {.real = +1608L, .imag = -65516L},  {.real = +804L, .imag = -65531L},
    {.real = +0L, .imag = -65536L},     {.real = -804L, .imag = -65531L},
    {.real = -1608L, .imag = -65516L},  {.real = -2412L, .imag = -65492L},
    {.real = -3216L, .imag = -65457L},  {.real = -4019L, .imag = -65413L},
    {.real = -4821L, .imag = -65358L},  {.real = -5623L, .imag = -65294L},
    {.real = -6424L, .imag = -65220L},  {.real = -7224L, .imag = -65137L},
    {.real = -8022L, .imag = -65043L},  {.real = -8820L, .imag = -64940L},
    {.real = -9616L, .imag = -64827L},  {.real = -10411L, .imag = -64704L},
    {.real = -11204L, .imag = -64571L}, {.real = -11996L, .imag = -64429L},
    {.real = -12785L, .imag = -64277L}, {.real = -13573L, .imag = -64115L},
    {.real = -14359L, .imag = -63944L}, {.real = -15143L, .imag = -63763L},
    {.real = -15924L, .imag = -63572L}, {.real = -16703L, .imag = -63372L},
    {.real = -17479L, .imag = -63162L}, {.real = -18253L, .imag = -62943L},
    {.real = -19024L, .imag = -62714L}, {.real = -19792L, .imag = -62476L},
    {.real = -20557L, .imag = -62228L}, {.real = -21320L, .imag = -61971L},
    {.real = -22078L, .imag = -61705L}, {.real = -22834L, .imag = -61429L},
    {.real = -23586L, .imag = -61145L}, {.real = -24335L, .imag = -60851L},
    {.real = -25080L, .imag = -60547L}, {.real = -25821L, .imag = -60235L},
    {.real = -26558L, .imag = -59914L}, {.real = -27291L, .imag = -59583L},
    {.real = -28020L, .imag = -59244L}, {.real = -28745L, .imag = -58896L},
    {.real = -29466L, .imag = -58538L}, {.real = -30182L, .imag = -58172L},
    {.real = -30893L, .imag = -57798L}, {.real = -31600L, .imag = -57414L},
    {.real = -32303L, .imag = -57022L}, {.real = -33000L, .imag = -56621L},
    {.real = -33692L, .imag = -56212L}, {.real = -34380L, .imag = -55794L},
    {.real = -35062L, .imag = -55368L}, {.real = -35738L, .imag = -54934L},
    {.real = -36410L, .imag = -54491L}, {.real = -37076L, .imag = -54040L},
    {.real = -37736L, .imag = -53581L}, {.real = -38391L, .imag = -53114L},
    {.real = -39040L, .imag = -52639L}, {.real = -39683L, .imag = -52156L},
    {.real = -40320L, .imag = -51665L}, {.real = -40951L, .imag = -51166L},
    {.real = -41576L, .imag = -50660L}, {.real = -42194L, .imag = -50146L},
    {.real = -42806L, .imag = -49624L}, {.real = -43412L, .imag = -49095L},
    {.real = -44011L, .imag = -48559L}, {.real = -44604L, .imag = -48015L},
    {.real = -45190L, .imag = -47464L}, {.real = -45769L, .imag = -46906L},
    {.real = -46341L, .imag = -46341L}, {.real = -46906L, .imag = -45769L},
    {.real = -47464L, .imag = -45190L}, {.real = -48015L, .imag = -44604L},
    {.real = -48559L, .imag = -44011L}, {.real = -49095L, .imag = -43412L},
    {.real = -49624L, .imag = -42806L}, {.real = -50146L, .imag = -42194L},
    {.real = -50660L, .imag = -41576L}, {.real = -51166L, .imag = -40951L},
    {.real = -51665L, .imag = -40320L}, {.real = -52156L, .imag = -39683L},
    {.real = -52639L, .imag = -39040L}, {.real = -53114L, .imag = -38391L},
    {.real = -53581L, .imag = -37736L}, {.real = -54040L, .imag = -37076L},
    {.real = -54491L, .imag = -36410L}, {.real = -54934L, .imag = -35738L},
    {.real = -55368L, .imag = -35062L}, {.real = -55794L, .imag = -34380L},
    {.real = -56212L, .imag = -33692L}, {.real = -56621L, .imag = -33000L},
    {.real = -57022L, .imag = -32303L}, {.real = -57414L, .imag = -31600L},
    {.real = -57798L, .imag = -30893L}, {.real = -58172L, .imag = -30182L},
    {.real = -58538L, .imag = -29466L}, {.real = -58896L, .imag = -28745L},
    {.real = -59244L, .imag = -28020L}, {.real = -59583L, .imag = -27291L},
    {.real = -59914L, .imag = -26558L}, {.real = -60235L, .imag = -25821L},
    {.real = -60547L, .imag = -25080L}, {.real = -60851L, .imag = -24335L},
    {.real = -61145L, .imag = -23586L}, {.real = -61429L, .imag = -22834L},
    {.real = -61705L, .imag = -22078L}, {.real = -61971L, .imag = -21320L},
    {.real = -62228L, .imag = -20557L}, {.real = -62476L, .imag = -19792L},
    {.real = -62714L, .imag = -19024L}, {.real = -62943L, .imag = -18253L},
    {.real = -63162L, .imag = -17479L}, {.real = -63372L, .imag = -16703L},
    {.real = -63572L, .imag = -15924L}, {.real = -63763L, .imag = -15143L},
    {.real = -63944L, .imag = -14359L}, {.real = -64115L, .imag = -13573L},
    {.real = -64277L, .imag = -12785L}, {.real = -64429L, .imag = -11996L},
    {.real = -64571L, .imag = -11204L}, {.real = -64704L, .imag = -10411L},
    {.real = -64827L, .imag = -9616L},  {.real = -64940L, .imag = -8820L},
    {.real = -65043L, .imag = -8022L},  {.real = -65137L, .imag = -7224L},
    {.real = -65220L, .imag = -6424L},  {.real = -65294L, .imag = -5623L},
    {.real = -65358L, .imag = -4821L},  {.real = -65413L, .imag = -4019L},
    {.real = -65457L, .imag = -3216L},  {.real = -65492L, .imag = -2412L},
    {.real = -65516L, .imag = -1608L},  {.real = -65531L, .imag = -804L}};

static inline int32_t _mulrnd16(const int32_t x, const int32_t y) {
    int64_t r = ((int64_t)x * (int64_t)y) + (1 << 15);
    return r >> 16;
}

static inline int32_t _complex_mul_real(const complex_fp32_16 x,
                                        const complex_fp32_16 y) {
    return _mulrnd16(x.real, y.real) - _mulrnd16(x.imag, y.imag);
}

static inline int32_t _complex_mul_imag(const complex_fp32_16 x,
                                        const complex_fp32_16 y) {
    return _mulrnd16(x.real, y.imag) + _mulrnd16(x.imag, y.real);
}

static void _complex_mul(complex_fp32_16 *r, const complex_fp32_16 x,
                         const complex_fp32_16 y) {
    r->real = _complex_mul_real(x, y);
    r->imag = _complex_mul_imag(x, y);
}

const uint16_t brv9[] = {
    0,   256, 128, 384, 64,  320, 192, 448, 32,  288, 160, 416, 96,  352, 224,
    480, 16,  272, 144, 400, 80,  336, 208, 464, 48,  304, 176, 432, 112, 368,
    240, 496, 8,   264, 136, 392, 72,  328, 200, 456, 40,  296, 168, 424, 104,
    360, 232, 488, 24,  280, 152, 408, 88,  344, 216, 472, 56,  312, 184, 440,
    120, 376, 248, 504, 4,   260, 132, 388, 68,  324, 196, 452, 36,  292, 164,
    420, 100, 356, 228, 484, 20,  276, 148, 404, 84,  340, 212, 468, 52,  308,
    180, 436, 116, 372, 244, 500, 12,  268, 140, 396, 76,  332, 204, 460, 44,
    300, 172, 428, 108, 364, 236, 492, 28,  284, 156, 412, 92,  348, 220, 476,
    60,  316, 188, 444, 124, 380, 252, 508, 2,   258, 130, 386, 66,  322, 194,
    450, 34,  290, 162, 418, 98,  354, 226, 482, 18,  274, 146, 402, 82,  338,
    210, 466, 50,  306, 178, 434, 114, 370, 242, 498, 10,  266, 138, 394, 74,
    330, 202, 458, 42,  298, 170, 426, 106, 362, 234, 490, 26,  282, 154, 410,
    90,  346, 218, 474, 58,  314, 186, 442, 122, 378, 250, 506, 6,   262, 134,
    390, 70,  326, 198, 454, 38,  294, 166, 422, 102, 358, 230, 486, 22,  278,
    150, 406, 86,  342, 214, 470, 54,  310, 182, 438, 118, 374, 246, 502, 14,
    270, 142, 398, 78,  334, 206, 462, 46,  302, 174, 430, 110, 366, 238, 494,
    30,  286, 158, 414, 94,  350, 222, 478, 62,  318, 190, 446, 126, 382, 254,
    510, 1,   257, 129, 385, 65,  321, 193, 449, 33,  289, 161, 417, 97,  353,
    225, 481, 17,  273, 145, 401, 81,  337, 209, 465, 49,  305, 177, 433, 113,
    369, 241, 497, 9,   265, 137, 393, 73,  329, 201, 457, 41,  297, 169, 425,
    105, 361, 233, 489, 25,  281, 153, 409, 89,  345, 217, 473, 57,  313, 185,
    441, 121, 377, 249, 505, 5,   261, 133, 389, 69,  325, 197, 453, 37,  293,
    165, 421, 101, 357, 229, 485, 21,  277, 149, 405, 85,  341, 213, 469, 53,
    309, 181, 437, 117, 373, 245, 501, 13,  269, 141, 397, 77,  333, 205, 461,
    45,  301, 173, 429, 109, 365, 237, 493, 29,  285, 157, 413, 93,  349, 221,
    477, 61,  317, 189, 445, 125, 381, 253, 509, 3,   259, 131, 387, 67,  323,
    195, 451, 35,  291, 163, 419, 99,  355, 227, 483, 19,  275, 147, 403, 83,
    339, 211, 467, 51,  307, 179, 435, 115, 371, 243, 499, 11,  267, 139, 395,
    75,  331, 203, 459, 43,  299, 171, 427, 107, 363, 235, 491, 27,  283, 155,
    411, 91,  347, 219, 475, 59,  315, 187, 443, 123, 379, 251, 507, 7,   263,
    135, 391, 71,  327, 199, 455, 39,  295, 167, 423, 103, 359, 231, 487, 23,
    279, 151, 407, 87,  343, 215, 471, 55,  311, 183, 439, 119, 375, 247, 503,
    15,  271, 143, 399, 79,  335, 207, 463, 47,  303, 175, 431, 111, 367, 239,
    495, 31,  287, 159, 415, 95,  351, 223, 479, 63,  319, 191, 447, 127, 383,
    255, 511};

void fft_bitrev(complex_fp32_16 r[FFT_N], const poly *x) {
    int i, inv_i;
    for (i = 0; i < N; i++) {
        inv_i = brv9[i];
        r[inv_i].imag = 0;
        r[inv_i].real = x->coeffs[i] << 16;
    }
    for (i = N; i < FFT_N; i++) {
        inv_i = brv9[i];
        r[inv_i].imag = 0;
        r[inv_i].real = 0;
    }
}

int32_t complex_fp_sqabs(complex_fp32_16 x) {
    return _mulrnd16(x.real, x.real) + _mulrnd16(x.imag, x.imag);
}

void fft(complex_fp32_16 data[FFT_N]) {
    unsigned int r, m, md2, n, k, even, odd, twid;
    complex_fp32_16 u, t;

    for (r = 1; r <= FFT_LOGN; r++) {
        m = 1 << r;
        md2 = m >> 1;
        for (n = 0; n < FFT_N; n += m) {
            for (k = 0; k < md2; k++) {
                even = n + k;
                odd = even + md2;
                twid = k << (FFT_LOGN - r);

                u = data[even];
                _complex_mul(&t, roots[twid], data[odd]);
                data[even].real = u.real + t.real;
                data[even].imag = u.imag + t.imag;
                data[odd].real = u.real - t.real;
                data[odd].imag = u.imag - t.imag;
            }
        }
    }
}
