
.macro inverse out, in, tmp, tmp2
   movw   \tmp, #0x58D6
   lsr.w    \out, \tmp, \in
   and.w    \out, #1
   movw   \tmp, #0x2B9C
   lsr.w    \tmp2, \tmp, \in
   and.w    \tmp2, #1
   orr.w    \out, \out, \tmp2, lsl #1
   movw   \tmp, #0xFA30
   lsr.w    \tmp2, \tmp, \in
   and.w    \tmp2, #1
   orr.w    \out, \out, \tmp2, lsl #2
   movw   \tmp, #0x65F0
   lsr.w    \tmp2, \tmp, \in
   and.w    \tmp2, #1
   orr.w    \out, \out, \tmp2, lsl #3
.endm