
@ static const uint8_t gf16_inv_lut[] = {
@     0, 1, 9, 14, 13, 11, 7, 6, 15, 2, 12, 5, 10, 4, 3, 8
@ };
// gf16 := gf2[x]/x^4+x+1


.macro gf16_inverse out, in, tmp, tmp2
   movw   \tmp, #0x4976
   lsr.w    \out, \tmp, \in
   and.w    \out, #1
   movw   \tmp, #0x53E8
   lsr.w    \tmp2, \tmp, \in
   and.w    \tmp2, #1
   orr.w    \out, \out, \tmp2, lsl #1
   movw   \tmp, #0x2DD8
   lsr.w    \tmp2, \tmp, \in
   and.w    \tmp2, #1
   orr.w    \out, \out, \tmp2, lsl #2
   movw   \tmp, #0x953C
   lsr.w    \tmp2, \tmp, \in
   and.w    \tmp2, #1
   orr.w    \out, \out, \tmp2, lsl #3
.endm