#ifndef NTT_H
#define NTT_H

#ifndef NTRU_Q
#define NTRU_Q 7177
#endif
#ifndef NTRU_P
#define NTRU_P 1013
#endif

#define ARRAY_N 2048
#define NTT_N 512
#define LOGNTT_N 9

#define MOD 7272449
#define Mhalf 3636224
#define pr 3

#define RmodM -3050063
// -3050063 = - (46 * 2^16 + 35407)
#define R2modM -3367035
#define Mprime -265357313
#define invN -14204
#define invN_RmodM 1116159
#define invN_R2modM 1740516
// 1740516 = 26 * 2^16 + 36580

#define O_Mbar 598435
// 598435 = 9 * 2^16 + 8611
#define O_M 7177

#endif