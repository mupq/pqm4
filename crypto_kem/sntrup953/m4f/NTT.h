#ifndef NTT_H
#define NTT_H

#ifndef NTRU_Q
#define NTRU_Q 6343
#endif
#ifndef NTRU_P
#define NTRU_P 953
#endif

#define ARRAY_N 640
#define NTT_N 128
#define LOGNTT_N 7

#define MOD 6045313
#define Mhalf 3022656
#define pr 5

#define omega3 -522136
// -522136 = -(7 * 2^16 + 63384)
#define omega3_2 522135
// 522135 = 7 * 2^16 + 63383

#define omega3_RmodM 475667
// 475667 = 7 * 2^16 + 16915
#define omega3_2_RmodM 2774580
// 2774580 = 42 * 2^16 + 22068

#define _inv_3 -2015104

#define RmodM 2795066
// 2795066 = 42 * 2^16 + 42554
#define R2modM -317422
#define Mprime -1581646209
#define invN -47229
#define invN_RmodM -2717446
#define invN_R2modM -852602
#define invN_inv3_R2modM -2299305
// -2299305 = -(35 * 2^16 + 5545)

#define O_Mbar 677119
// 677119 = 10 * 2^16 + 21759
#define O_M 6343

#endif