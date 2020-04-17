/********************************************************************************************
* Supersingular Isogeny Key Encapsulation Library
*
* Abstract: core functions over GF(p) and GF(p^2)
*********************************************************************************************/

#include "P434_internal.h"

#define STR(...) #__VA_ARGS__
#define STRFY(...) STR(__VA_ARGS__)
#define EOL \n\t
#define CS #
#define CV(X) CS(X)

__inline void fpcopy(const felm_t a, felm_t c)
{ // Copy a field element, c = a.
    unsigned int i;

    for (i = 0; i < NWORDS_FIELD; i++)
        c[i] = a[i];
}


__inline void fpzero(felm_t a)
{ // Zero a field element, a = 0.
    unsigned int i;

    for (i = 0; i < NWORDS_FIELD; i++)
        a[i] = 0;
}


void to_mont(const felm_t a, felm_t mc)
{ // Conversion to Montgomery representation,
  // mc = a*R^2*R^(-1) mod p = a*R mod p, where a in [0, p-1].
  // The Montgomery constant R^2 mod p is the global value "Montgomery_R2".

    fpmul_mont(a, (digit_t*)&Montgomery_R2, mc);
}


void from_mont(const felm_t ma, felm_t c)
{ // Conversion from Montgomery representation to standard representation,
  // c = ma*R^(-1) mod p = a mod p, where ma in [0, p-1].
    digit_t one[NWORDS_FIELD] = {0};

    one[0] = 1;
    fpmul_mont(ma, one, c);
    fpcorrection(c);
}


void copy_words(const digit_t* a, digit_t* c, const unsigned int nwords)
{ // Copy wordsize digits, c = a, where lng(a) = nwords.
    unsigned int i;

    for (i = 0; i < nwords; i++) {
        c[i] = a[i];
    }
}


#define P_TMP   R1

#define P_OP_A0 R2
#define P_OP_A1 R3
#define P_OP_A2 R4
#define P_OP_A3 R5

#define P_OP_B0 R6
#define P_OP_B1 R7
#define P_OP_B2 R8
#define P_OP_B3 R9

#define P_RST0 R10
#define P_RST1 R11
#define P_RST2 R12
#define P_RST3 R14

#define P_MUL_PROLOG \
 PUSH {R0,R1,R2,R4-R11,R14}      EOL\

#define P_MUL_EPILOG \
 POP {R4-R11,PC}        EOL\

#define P_LOAD(OP, V0, V1, V2, V3, OFFSET) \
    LDR V0, [OP, CV(4*OFFSET)]            EOL\
    LDR V1, [OP, CV(4*OFFSET+4)]          EOL\
    LDR V2, [OP, CV(4*OFFSET+8)]          EOL\
    LDR V3, [OP, CV(4*OFFSET+12)]         EOL\

#define P_LOAD2(OP, V0, V1, OFFSET) \
    LDR V0, [OP, CV(4*OFFSET)]            EOL\
    LDR V1, [OP, CV(4*OFFSET+4)]          EOL\

#define P_MUL_TOP(R_OUT, OFFSET) \
	UMULL P_TMP, P_RST0, P_OP_A0, P_OP_B0         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 0)]    EOL\
    MOV P_TMP, CV(0)                        EOL\
    UMAAL P_TMP, P_RST0, P_OP_A1, P_OP_B0         EOL\
    MOV P_RST1, CV(0)                       EOL\
    UMAAL P_TMP, P_RST1, P_OP_A0, P_OP_B1         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 4)]    EOL\
	UMAAL P_RST0, P_RST1, P_OP_A1, P_OP_B1        EOL\
    STR P_RST0, [R_OUT, CV(4*OFFSET + 8)]   EOL\
    STR P_RST1, [R_OUT, CV(4*OFFSET + 12)]  EOL\

#define P_MUL_FRONT(R_OUT, OFFSET) \
    UMULL P_TMP, P_RST0, P_OP_A0, P_OP_B0         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 0)]    EOL\
    UMULL P_TMP, P_RST1, P_OP_A1, P_OP_B0         EOL\
    UMAAL P_TMP, P_RST0, P_OP_A0, P_OP_B1         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 4)]    EOL\
    UMULL P_TMP, P_RST2, P_OP_A2, P_OP_B0         EOL\
    UMAAL P_TMP, P_RST1, P_OP_A1, P_OP_B1         EOL\
    UMAAL P_TMP, P_RST0, P_OP_A0, P_OP_B2         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 8)]    EOL\
    UMULL P_TMP, P_RST3, P_OP_A0, P_OP_B3         EOL\
    UMAAL P_TMP, P_RST0, P_OP_A3, P_OP_B0         EOL\
    UMAAL P_TMP, P_RST1, P_OP_A2, P_OP_B1         EOL\
    UMAAL P_TMP, P_RST2, P_OP_A1, P_OP_B2         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 12)]   EOL\

#define P_MUL_BACK(R_OUT, OFFSET) \
    UMAAL P_RST0, P_RST1, P_OP_A3, P_OP_B1        EOL\
    UMAAL P_RST0, P_RST2, P_OP_A2, P_OP_B2        EOL\
    UMAAL P_RST0, P_RST3, P_OP_A1, P_OP_B3        EOL\
    STR P_RST0, [R_OUT, CV(4*OFFSET + 0)]   EOL\
    UMAAL P_RST1, P_RST2, P_OP_A3, P_OP_B2        EOL\
    UMAAL P_RST1, P_RST3, P_OP_A2, P_OP_B3        EOL\
    STR P_RST1, [R_OUT, CV(4*OFFSET + 4)]   EOL\
    UMAAL P_RST2, P_RST3, P_OP_A3, P_OP_B3        EOL\
    STR P_RST2, [R_OUT, CV(4*OFFSET + 8)]   EOL\
    STR P_RST3, [R_OUT, CV(4*OFFSET + 12)]  EOL\

#define P_MUL_BACK2(R_OUT, OFFSET) \
    UMAAL P_RST0, P_RST1, P_OP_A1, P_OP_B3        EOL\
    UMAAL P_RST0, P_RST2, P_OP_A0, P_OP_B0        EOL\
    UMAAL P_RST0, P_RST3, P_OP_A3, P_OP_B1        EOL\
    STR P_RST0, [R_OUT, CV(4*OFFSET + 0)]   EOL\
    UMAAL P_RST1, P_RST2, P_OP_A1, P_OP_B0        EOL\
    UMAAL P_RST1, P_RST3, P_OP_A0, P_OP_B1        EOL\
    STR P_RST1, [R_OUT, CV(4*OFFSET + 4)]   EOL\
    UMAAL P_RST2, P_RST3, P_OP_A1, P_OP_B1        EOL\
    STR P_RST2, [R_OUT, CV(4*OFFSET + 8)]   EOL\
    STR P_RST3, [R_OUT, CV(4*OFFSET + 12)]  EOL\

#define P_MUL_MID_OP_B_SHORT(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR P_OP_B0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A3, P_OP_B1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A2, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A1, P_OP_B3        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A0, P_OP_B0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR P_OP_B1, [OP_P, CV(4*P_OFF + 4)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A3, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A2, P_OP_B3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A1, P_OP_B0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A0, P_OP_B1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\

#define P_MUL_MID_OP_B(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR P_OP_B0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A3, P_OP_B1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A2, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A1, P_OP_B3        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A0, P_OP_B0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR P_OP_B1, [OP_P, CV(4*P_OFF + 4)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A3, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A2, P_OP_B3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A1, P_OP_B0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A0, P_OP_B1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    LDR P_OP_B2, [OP_P, CV(4*P_OFF + 8)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A3, P_OP_B3        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A2, P_OP_B0        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A1, P_OP_B1        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A0, P_OP_B2        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR P_OP_B3, [OP_P, CV(4*P_OFF + 12)]   EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A3, P_OP_B0        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A2, P_OP_B1        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A1, P_OP_B2        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A0, P_OP_B3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\

#define P_MUL_MID_OP_A_SHORT(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR P_OP_A0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A0, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A3, P_OP_B3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A2, P_OP_B0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A1, P_OP_B1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR P_OP_A1, [OP_P, CV(4*P_OFF + 4)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A1, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A0, P_OP_B3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A3, P_OP_B0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A2, P_OP_B1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\

#define P_MUL_MID_OP_A(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR P_OP_A0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A0, P_OP_B0        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A3, P_OP_B1        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A2, P_OP_B2        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A1, P_OP_B3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR P_OP_A1, [OP_P, CV(4*P_OFF + 4)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A1, P_OP_B0        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A0, P_OP_B1        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A3, P_OP_B2        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A2, P_OP_B3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    LDR P_OP_A2, [OP_P, CV(4*P_OFF + 8)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A2, P_OP_B0        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A1, P_OP_B1        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A0, P_OP_B2        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A3, P_OP_B3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR P_OP_A3, [OP_P, CV(4*P_OFF + 12)]   EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A3, P_OP_B0        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A2, P_OP_B1        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A1, P_OP_B2        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A0, P_OP_B3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\

#define P_MUL_MID_OP_A2(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR P_OP_A2, [OP_P, CV(4*P_OFF + 0)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A2, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A1, P_OP_B3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A0, P_OP_B0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A3, P_OP_B1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR P_OP_A3, [OP_P, CV(4*P_OFF + 4)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A3, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A2, P_OP_B3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A1, P_OP_B0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A0, P_OP_B1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    LDR P_OP_A0, [OP_P, CV(4*P_OFF + 8)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A0, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A3, P_OP_B3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A2, P_OP_B0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A1, P_OP_B1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR P_OP_A1, [OP_P, CV(4*P_OFF + 12)]   EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A1, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A0, P_OP_B3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A3, P_OP_B0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A2, P_OP_B1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\

#define P_MASK6  #0xE3000000
#define P_MASK6L #0x0000
#define P_MASK6H #0xE300

#define P_MASK7  #0xFDC1767A
#define P_MASK7L #0x767A
#define P_MASK7H #0xFDC1

#define P_MASK8  #0x3158AEA3
#define P_MASK8L #0xAEA3
#define P_MASK8H #0x3158

#define P_MASK9  #0x7BC65C78
#define P_MASK9L #0x5C78
#define P_MASK9H #0x7BC6

#define P_MASK10 #0x81C52056
#define P_MASK10L #0x2056
#define P_MASK10H #0x81C5

#define P_MASK11 #0x6CFC5FD6
#define P_MASK11L #0x5FD6
#define P_MASK11H #0x6CFC

#define P_MASK12 #0x27177344
#define P_MASK12L #0x7344
#define P_MASK12H #0x2717

#define P_MASK13 #0x2341F
#define P_MASK13L #0x341F
#define P_MASK13H #0x2

#define P_OP_Q0 R2
#define P_OP_Q1 R3
#define P_OP_Q2 R4
#define P_OP_Q3 R5

#define P_OP_M0 R6
#define P_OP_M1 R7
#define P_OP_M2 R8
#define P_OP_M3 R9

#define P_RED_PROLOG \
 PUSH {R4-R7,R14}      EOL\
 MOV R4, R8            EOL\
 MOV R5, R9            EOL\
 MOV R6, R10           EOL\
 MOV R7, R11           EOL\
 PUSH {R4-R7}          EOL\

#define P_RED_EPILOG \
 POP {R4-R7}           EOL\
 MOV R8, R4            EOL\
 MOV R9, R5            EOL\
 MOV R10, R6           EOL\
 MOV R11, R7           EOL\
 POP {R4-R7,PC}        EOL\

#define P_LOAD_M \
	MOVW P_OP_M0, P_MASK6L		EOL\
	MOVT P_OP_M0, P_MASK6H		EOL\
	MOVW P_OP_M1, P_MASK7L		EOL\
	MOVT P_OP_M1, P_MASK7H		EOL\
	MOVW P_OP_M2, P_MASK8L		EOL\
	MOVT P_OP_M2, P_MASK8H		EOL\
	MOVW P_OP_M3, P_MASK9L		EOL\
	MOVT P_OP_M3, P_MASK9H		EOL\

#define P_LOAD_M2 \
	MOVW P_OP_M0, P_MASK6L		EOL\
	MOVT P_OP_M0, P_MASK6H		EOL\
	MOVW P_OP_M1, P_MASK7L		EOL\
	MOVT P_OP_M1, P_MASK7H		EOL\

#define P_LOAD_Q(OP, Q0, Q1, Q2, Q3, OFFSET) \
    LDR Q0, [OP, CV(4*OFFSET)]            EOL\
    LDR Q1, [OP, CV(4*OFFSET+4)]          EOL\
    LDR Q2, [OP, CV(4*OFFSET+8)]          EOL\
    LDR Q3, [OP, CV(4*OFFSET+12)]         EOL\

#define P_LOAD_Q2(OP, Q0, Q1, OFFSET) \
    LDR Q0, [OP, CV(4*OFFSET)]            EOL\
    LDR Q1, [OP, CV(4*OFFSET+4)]          EOL\

#define P_RED_FRONT(R_OUT, R_IN, OFFSET, IN_OFFSET) \
    LDR P_TMP, [R_IN, CV(4*IN_OFFSET + 0)]  EOL\
	MOV P_RST0, CV(0)                       EOL\
    UMAAL P_TMP, P_RST0, P_OP_Q0, P_OP_M0         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 0)]    EOL\
    LDR P_TMP, [R_IN, CV(4*IN_OFFSET + 4)]  EOL\
	UMAAL P_TMP, P_RST0, P_OP_Q1, P_OP_M0         EOL\
    MOV P_RST1, CV(0)                       EOL\
    UMAAL P_TMP, P_RST1, P_OP_Q0, P_OP_M1         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 4)]    EOL\
    LDR P_TMP, [R_IN, CV(4*IN_OFFSET + 8)]  EOL\
	UMAAL P_TMP, P_RST0, P_OP_Q2, P_OP_M0         EOL\
    UMAAL P_TMP, P_RST1, P_OP_Q1, P_OP_M1         EOL\
    MOV P_RST2, CV(0)                       EOL\
    UMAAL P_TMP, P_RST2, P_OP_Q0, P_OP_M2         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 8)]    EOL\
    LDR P_TMP, [R_IN, CV(4*IN_OFFSET + 12)] EOL\
	UMAAL P_TMP, P_RST0, P_OP_Q3, P_OP_M0         EOL\
    UMAAL P_TMP, P_RST1, P_OP_Q2, P_OP_M1         EOL\
    UMAAL P_TMP, P_RST2, P_OP_Q1, P_OP_M2         EOL\
    MOV P_RST3, CV(0)                       EOL\
    UMAAL P_TMP, P_RST3, P_OP_Q0, P_OP_M3         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 12)]   EOL\

#define P_RED_FRONT2(R_OUT, R_IN, OFFSET, IN_OFFSET) \
    LDR P_TMP, [R_IN, CV(4*IN_OFFSET + 0)]  EOL\
	MOV P_RST0, CV(0)                       EOL\
    UMAAL P_TMP, P_RST0, P_OP_Q0, P_OP_M0         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 0)]    EOL\
    LDR P_TMP, [R_IN, CV(4*IN_OFFSET + 4)]  EOL\
	UMAAL P_TMP, P_RST0, P_OP_Q1, P_OP_M0         EOL\
    MOV P_RST1, CV(0)                       EOL\
    UMAAL P_TMP, P_RST1, P_OP_Q0, P_OP_M1         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 4)]    EOL\

#define P_RED_MID(R_OUT, R_OFF) \
	MOVW P_OP_M0, P_MASK10L		EOL\
	MOVT P_OP_M0, P_MASK10H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M3        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
	MOVW P_OP_M1, P_MASK11L		EOL\
	MOVT P_OP_M1, P_MASK11H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
	MOVW P_OP_M2, P_MASK12L		EOL\
	MOVT P_OP_M2, P_MASK12H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M0        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M1        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M2        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
	MOVW P_OP_M3, P_MASK13L		EOL\
	MOVT P_OP_M3, P_MASK13H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M0        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M2        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
	UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M3        EOL\
    LDR P_OP_M1, [R_OUT, CV(4*R_OFF + 16)]  EOL\
    ADCS P_RST3, P_OP_M1, P_RST3				  EOL\
	STR P_RST3, [R_OUT, CV(4*R_OFF + 16)]   EOL\
	UMAAL P_RST2,  P_RST0, P_OP_Q3, P_OP_M2        EOL\
    UMAAL P_RST2,  P_RST1, P_OP_Q2, P_OP_M3        EOL\
    LDR P_OP_M1, [R_OUT, CV(4*R_OFF + 20)]  EOL\
    ADCS P_RST2, P_OP_M1, P_RST2				  EOL\
	STR P_RST2, [R_OUT, CV(4*R_OFF + 20)]   EOL\
	UMAAL P_RST1,  P_RST0, P_OP_Q3, P_OP_M3        EOL\
    LDR P_OP_M1, [R_OUT, CV(4*R_OFF + 24)]  EOL\
	LDR P_OP_M2, [R_OUT, CV(4*R_OFF + 28)]  EOL\
	ADCS P_RST1, P_OP_M1, P_RST1				  EOL\
	ADCS P_RST0, P_OP_M2, P_RST0				  EOL\
	STR P_RST1, [R_OUT, CV(4*R_OFF + 24)]   EOL\
	STR P_RST0, [R_OUT, CV(4*R_OFF + 28)]   EOL\

#define P_RED_MID3(R_OUT, R_IN, R_OFF, R_IN_OFF) \
	MOVW P_OP_M0, P_MASK8L		EOL\
	MOVT P_OP_M0, P_MASK8H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 0)]   EOL\
    UMAAL P_TMP,  P_RST0, P_OP_Q1, P_OP_M1        EOL\
    UMAAL P_TMP,  P_RST1, P_OP_Q0, P_OP_M0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
	MOVW P_OP_M1, P_MASK9L		EOL\
	MOVT P_OP_M1, P_MASK9H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 4)]   EOL\
    UMAAL P_TMP,  P_RST0, P_OP_Q1, P_OP_M0        EOL\
    UMAAL P_TMP,  P_RST1, P_OP_Q0, P_OP_M1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
	MOVW P_OP_M0, P_MASK10L		EOL\
	MOVT P_OP_M0, P_MASK10H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 8)]   EOL\
    UMAAL P_TMP,  P_RST0, P_OP_Q1, P_OP_M1        EOL\
    UMAAL P_TMP,  P_RST1, P_OP_Q0, P_OP_M0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
	MOVW P_OP_M1, P_MASK11L		EOL\
	MOVT P_OP_M1, P_MASK11H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 12)]  EOL\
    UMAAL P_TMP,  P_RST0, P_OP_Q1, P_OP_M0        EOL\
    UMAAL P_TMP,  P_RST1, P_OP_Q0, P_OP_M1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
	MOVW P_OP_M0, P_MASK12L		EOL\
	MOVT P_OP_M0, P_MASK12H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 16)]  EOL\
    UMAAL P_TMP,  P_RST0, P_OP_Q1, P_OP_M1        EOL\
    UMAAL P_TMP,  P_RST1, P_OP_Q0, P_OP_M0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 16)]    EOL\
	MOVW P_OP_M1, P_MASK13L		EOL\
	MOVT P_OP_M1, P_MASK13H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 20)]  EOL\
    UMAAL P_TMP,  P_RST0, P_OP_Q1, P_OP_M0        EOL\
    UMAAL P_TMP,  P_RST1, P_OP_Q0, P_OP_M1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 20)]    EOL\
	UMAAL P_RST0,  P_RST1, P_OP_Q1, P_OP_M1       EOL\
	LDR P_RST2, [R_IN, CV(4*R_IN_OFF + 24)]    EOL\
	LDR P_RST3, [R_IN, CV(4*R_IN_OFF + 28)]    EOL\
	ADCS P_RST0, P_RST0, P_RST2				  EOL\
	ADCS P_RST1, P_RST1, P_RST3				  EOL\
	STR P_RST0, [R_OUT, CV(4*R_OFF + 24)]   EOL\
	STR P_RST1, [R_OUT, CV(4*R_OFF + 28)]   EOL\






void __attribute__ ((naked)) fpmul_mont(const felm_t ma, const felm_t mb, felm_t mc)
{ // Multiprecision multiplication, c = a*b mod p.
    //dfelm_t temp = {0};
asm volatile(\
STRFY(P_MUL_PROLOG)
"SUB SP, #4*28 			\n\t"

//ROUND#1
STRFY(P_LOAD2(R0, P_OP_A0, P_OP_A1, 12))
STRFY(P_LOAD(R1, P_OP_B0, P_OP_B1, P_OP_B2, P_OP_B3, 0))
STRFY(P_MUL_TOP(SP, 12))

//ROUND#2
STRFY(P_LOAD(R0, P_OP_A0, P_OP_A1, P_OP_A2, P_OP_A3, 8))
STRFY(P_MUL_FRONT(SP, 8))
"LDR R0, [SP, #4 * 29] \n\t"
STRFY(P_MUL_MID_OP_B_SHORT(SP, 12, R0, 4))
"LDR R0, [SP, #4 * 28] \n\t"
STRFY(P_MUL_MID_OP_A_SHORT(SP, 14, R0, 12))
STRFY(P_MUL_BACK2(SP, 16))

//ROUND#3
"LDR R0, [SP, #4 * 28] \n\t"// OP_A
"LDR R1, [SP, #4 * 29] \n\t"// OP_B
STRFY(P_LOAD(R0, P_OP_A0, P_OP_A1, P_OP_A2, P_OP_A3, 4))
STRFY(P_LOAD2(R1, P_OP_B0, P_OP_B1, 0))
STRFY(P_MUL_FRONT(SP, 4))
"LDR R0, [SP, #4 * 29] \n\t"
STRFY(P_MUL_MID_OP_B(SP, 8, R0, 4))
STRFY(P_MUL_MID_OP_B_SHORT(SP, 12, R0, 8))
"LDR R0, [SP, #4 * 28] \n\t"
STRFY(P_MUL_MID_OP_A_SHORT(SP, 14, R0, 8))
STRFY(P_MUL_MID_OP_A2(SP, 16, R0, 10))
STRFY(P_MUL_BACK2(SP, 20))

//ROUND#4
"LDR R0, [SP, #4 * 28] \n\t"// OP_A
"LDR R1, [SP, #4 * 29] \n\t"// OP_B
STRFY(P_LOAD(R0, P_OP_A0, P_OP_A1, P_OP_A2, P_OP_A3, 0))
STRFY(P_LOAD(R1, P_OP_B0, P_OP_B1, P_OP_B2, P_OP_B3, 0))
STRFY(P_MUL_FRONT(SP, 0))
"LDR R0, [SP, #4 * 29] \n\t"
STRFY(P_MUL_MID_OP_B(SP, 4, R0, 4))
STRFY(P_MUL_MID_OP_B(SP, 8, R0, 8))
STRFY(P_MUL_MID_OP_B_SHORT(SP, 12, R0, 12))
"LDR R0, [SP, #4 * 28] \n\t"
STRFY(P_MUL_MID_OP_A_SHORT(SP, 14, R0, 4))
STRFY(P_MUL_MID_OP_A2(SP, 16, R0, 6))
STRFY(P_MUL_MID_OP_A2(SP, 20, R0, 10))
STRFY(P_MUL_BACK2(SP, 24))

//TEST
"MOV R1, #0			   \n\t"//CARRY
"ADDS R1, R1, R1	\n\t"
"LDR R0, [SP, #4 * 30] \n\t"//RESULT POINTER

//ROUND#1
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 0))
STRFY(P_RED_FRONT(SP, SP, 6, 6))
STRFY(P_RED_MID(SP, 10))

//ROUND#2
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 4))
STRFY(P_RED_FRONT(SP, SP, 10, 10))
STRFY(P_RED_MID(SP, 14))

//ROUND#3
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 8))
"LDR R0, [SP, #4 * 30] \n\t"// RESULT
STRFY(P_RED_FRONT(R0, SP, 0, 14))
//STRFY(RED_MID2(R0, SP, 4, 18))
STRFY(P_RED_MID(SP, 18))

//ROUND#4
STRFY(P_LOAD_M2)
STRFY(P_LOAD_Q2(SP, P_OP_Q0, P_OP_Q1, 12))
"LDR R0, [SP, #4 * 30] \n\t"// RESULT
STRFY(P_RED_FRONT2(R0, SP, 4, 18))
STRFY(P_RED_MID3(R0, SP, 6,  20))

"ADD SP, #4*31 		   \n\t"
STRFY(P_MUL_EPILOG)
  :
  :
  : "cc", "memory"
);
}


//SQR
#define S_TMP  R1

#define S_RST0 R2
#define S_RST1 R3
#define S_RST2 R4
#define S_RST3 R5

#define S_OP_A0 R6
#define S_OP_A1 R7
#define S_OP_A2 R8
#define S_OP_A3 R9

#define S_OP_D0 R10
#define S_OP_D1 R11
#define S_OP_D2 R12
#define S_OP_D3 R14

#define SQR_PROLOG \
 PUSH {R0, R1,R4-R11,R14}      	EOL\

#define SQR_EPILOG \
 POP {R4-R11,PC}        		EOL\

#define SQR_FRONT(R_PNT, R_OFF, A_PNT, A_OFF)\
  LDR S_OP_A0, [A_PNT, CV(4*A_OFF + 4*0)]               EOL\
  LDR S_OP_A1, [A_PNT, CV(4*A_OFF + 4*1)]               EOL\
  LDR S_OP_A2, [A_PNT, CV(4*A_OFF + 4*2)]               EOL\
  LDR S_OP_A3, [A_PNT, CV(4*A_OFF + 4*3)]               EOL\
  LDR S_OP_D0, [A_PNT, CV(4*A_OFF + 4*4)]               EOL\
  LDR S_RST3,  [A_PNT, CV(4*A_OFF + 4*5)]               EOL\
  ADDS S_OP_D1, S_OP_A1, S_OP_A1           EOL\
  ADCS S_OP_D2, S_OP_A2, S_OP_A2           EOL\
  ADCS S_OP_D3, S_OP_A3, S_OP_A3           EOL\
  UMULL S_TMP, S_RST0, S_OP_A0, S_OP_A0    EOL\
  EOR S_RST1, S_RST1                       EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*0)]                 EOL\
  UMAAL S_RST0, S_RST1, S_OP_A0, S_OP_D1   EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*1)]                EOL\
  UMULL S_TMP, S_RST2, S_OP_A1, S_OP_A1   EOL\
  UMAAL S_TMP, S_RST1, S_OP_A0, S_OP_D2   EOL\
  AND S_OP_D2, CV(0XFFFFFFFE)             EOL\
  EOR S_RST0, S_RST0                       EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*2)]                EOL\
  UMAAL S_RST1, S_RST2, S_OP_A0, S_OP_D3   EOL\
  UMAAL S_RST0, S_RST1, S_OP_A1, S_OP_D2   EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*3)]                EOL\
  ADCS S_OP_D0, S_OP_D0, S_OP_D0           EOL\
  UMULL S_TMP, S_RST0, S_OP_A0, S_OP_D0   EOL\
  UMAAL S_TMP, S_RST1, S_OP_A1, S_OP_D3   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A2, S_OP_A2   EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*4)]                EOL\
  ADCS S_OP_D1, S_RST3, S_RST3           EOL\
  AND S_OP_D3, CV(0XFFFFFFFE)             EOL\
  EOR S_RST3, S_RST3                       EOL\
  UMAAL S_RST0, S_RST1, S_OP_A0, S_OP_D1   EOL\
  UMAAL S_RST0, S_RST2, S_OP_A1, S_OP_D0   EOL\
  UMAAL S_RST3, S_RST0, S_OP_A2, S_OP_D3   EOL\
  LDR S_OP_D2, [A_PNT, CV(4*A_OFF + 4*6)]               EOL\
  ADCS S_OP_D2, S_OP_D2, S_OP_D2           EOL\
  STR S_RST3, [R_PNT, CV(4*R_OFF + 4*5)]                EOL\
  UMAAL S_RST0, S_RST1, S_OP_A1, S_OP_D1    EOL\
  UMAAL S_RST0, S_RST2, S_OP_A2, S_OP_D0    EOL\
  UMULL S_TMP, S_RST3, S_OP_A0, S_OP_D2    EOL\
  UMAAL S_TMP, S_RST0, S_OP_A3, S_OP_A3    EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*6)]                EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*7)]                EOL\
  AND S_OP_D0, CV(0XFFFFFFFE)             EOL\
  UMAAL S_RST0, S_RST1, S_OP_A1, S_OP_D2   EOL\
  UMAAL S_RST0, S_RST2, S_OP_A2, S_OP_D1   EOL\
  UMAAL S_RST0, S_RST3, S_OP_A3, S_OP_D0   EOL\
  ADDS S_RST0, S_RST0, S_TMP			  EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*7)]                EOL\
  LDR S_OP_A0, [A_PNT, CV(4*A_OFF + 4*4)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*8)]                EOL\
  UMAAL S_TMP, S_RST1, S_OP_A2, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A3, S_OP_D1   EOL\
  UMAAL S_TMP, S_RST3, S_OP_A0, S_OP_A0   EOL\
  ADCS S_TMP, S_TMP, CV(0)			  EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*8)]                EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*9)]                EOL\
  AND S_OP_D1, CV(0XFFFFFFFE)             EOL\
  UMAAL S_RST1, S_RST2, S_OP_A3, S_OP_D2   EOL\
  UMAAL S_RST1, S_RST3, S_OP_A0, S_OP_D1   EOL\
  ADCS S_RST1, S_RST1, S_TMP			  EOL\
  STR S_RST1, [R_PNT, CV(4*R_OFF + 4*9)]                EOL\
  LDR S_OP_A1, [A_PNT, CV(4*A_OFF + 4*5)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*10)]                EOL\
  UMAAL S_TMP, S_RST2, S_OP_A0, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST3, S_OP_A1, S_OP_A1   EOL\
  ADCS S_TMP, S_TMP, CV(0)			  EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*10)]                EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*11)]                EOL\
  AND S_OP_D2, CV(0XFFFFFFFE)             EOL\
  UMAAL S_RST2, S_RST3, S_OP_A1, S_OP_D2   EOL\
  ADCS S_RST2, S_RST2, S_TMP			  EOL\
  STR S_RST2, [R_PNT, CV(4*R_OFF + 4*11)]                EOL\
  LDR S_OP_A2, [A_PNT, CV(4*A_OFF + 4*6)]               EOL\
  LDR S_RST0, [R_PNT, CV(4*R_OFF + 4*12)]                EOL\
  LDR S_RST1, [R_PNT, CV(4*R_OFF + 4*13)]                EOL\
  UMAAL S_RST0, S_RST3, S_OP_A2, S_OP_A2   EOL\
  ADCS S_RST0, S_RST0, CV(0)			  EOL\
  ADCS S_RST1, S_RST1, S_RST3			  EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*12)]                EOL\
  STR S_RST1, [R_PNT, CV(4*R_OFF + 4*13)]                EOL\

#define SQR_BACK(R_PNT, R_OFF, A_PNT, A_OFF, B_OFF)\
  LDR S_OP_A0, [A_PNT, CV(4*A_OFF + 4*0)]               EOL\
  LDR S_OP_A1, [A_PNT, CV(4*A_OFF + 4*1)]               EOL\
  LDR S_OP_A2, [A_PNT, CV(4*A_OFF + 4*2)]               EOL\
  LDR S_OP_A3, [A_PNT, CV(4*A_OFF + 4*3)]               EOL\
  LDR S_OP_D0, [A_PNT, CV(4*A_OFF + 4*4)]               EOL\
  LDR S_RST3,  [A_PNT, CV(4*A_OFF + 4*5)]               EOL\
  ADD S_RST0, SP, CV(4*28)					EOL\
  LDR S_OP_D1, [S_RST0, CV(4*B_OFF + 4*1)]               EOL\
  LDR S_OP_D2, [S_RST0, CV(4*B_OFF + 4*2)]               EOL\
  LDR S_OP_D3, [S_RST0, CV(4*B_OFF + 4*3)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*0)]                 EOL\
  EOR S_RST0, S_RST0                       EOL\
  UMAAL S_TMP, S_RST0, S_OP_A0, S_OP_A0    EOL\
  ADCS S_TMP, S_TMP, CV(0)					EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*0)]                 EOL\
  AND S_OP_D1, CV(0XFFFFFFFE)              EOL\
  LDR S_RST1, [R_PNT, CV(4*R_OFF + 4*1)]                 EOL\
  UMAAL S_RST0, S_RST1, S_OP_A0, S_OP_D1   EOL\
  ADCS S_RST0, S_RST0, CV(0)					EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*1)]                EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*2)]                 EOL\
  EOR S_RST2, S_RST2                       EOL\
  UMAAL S_TMP, S_RST2, S_OP_A1, S_OP_A1   EOL\
  UMAAL S_TMP, S_RST1, S_OP_A0, S_OP_D2   EOL\
  ADCS S_TMP, S_TMP, CV(0)					EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*2)]                EOL\
  AND S_OP_D2, CV(0XFFFFFFFE)             EOL\
  LDR S_RST0, [R_PNT, CV(4*R_OFF + 4*3)]                 EOL\
  UMAAL S_RST1, S_RST2, S_OP_A0, S_OP_D3   EOL\
  UMAAL S_RST0, S_RST1, S_OP_A1, S_OP_D2   EOL\
  ADCS S_RST0, S_RST0, CV(0)					EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*3)]                EOL\
  ADD S_RST0, SP, CV(4*28)					EOL\
  LDR S_OP_D0, [S_RST0, CV(4*B_OFF + 4*4)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*4)]                 EOL\
  EOR S_RST0, S_RST0                       EOL\
  UMAAL S_TMP, S_RST0, S_OP_A0, S_OP_D0   EOL\
  UMAAL S_TMP, S_RST1, S_OP_A1, S_OP_D3   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A2, S_OP_A2   EOL\
  ADCS S_TMP, S_TMP, CV(0)				EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*4)]                EOL\
  ADD S_TMP, SP, CV(4*28)					EOL\
  LDR S_OP_D1, [S_TMP, CV(4*B_OFF + 4*5)]               EOL\
  AND S_OP_D3, CV(0XFFFFFFFE)             EOL\
  LDR S_RST3, [R_PNT, CV(4*R_OFF + 4*5)]                 EOL\
  UMAAL S_RST0, S_RST1, S_OP_A0, S_OP_D1   EOL\
  UMAAL S_RST0, S_RST2, S_OP_A1, S_OP_D0   EOL\
  UMAAL S_RST3, S_RST0, S_OP_A2, S_OP_D3   EOL\
  ADCS S_RST3, S_RST3, CV(0)				EOL\
  STR S_RST3, [R_PNT, CV(4*R_OFF + 4*5)]                EOL\
  ADD S_RST3, SP, CV(4*28)					EOL\
  LDR S_OP_D2, [S_RST3, CV(4*B_OFF + 4*6)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*6)]                 EOL\
  EOR S_RST3, S_RST3                       EOL\
  UMAAL S_RST0, S_RST1, S_OP_A1, S_OP_D1    EOL\
  UMAAL S_RST0, S_RST2, S_OP_A2, S_OP_D0    EOL\
  UMAAL S_TMP, S_RST3, S_OP_A0, S_OP_D2    EOL\
  UMAAL S_TMP, S_RST0, S_OP_A3, S_OP_A3    EOL\
  ADCS S_TMP, S_TMP, CV(0)				EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*6)]                EOL\
  AND S_OP_D0, CV(0XFFFFFFFE)             EOL\
  UMAAL S_RST0, S_RST1, S_OP_A3, S_OP_D0   EOL\
  UMAAL S_RST0, S_RST2, S_OP_A2, S_OP_D1   EOL\
  UMAAL S_RST0, S_RST3, S_OP_A1, S_OP_D2   EOL\
  ADCS S_RST0, S_RST0, CV(0)				  EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*7)]                EOL\
  LDR S_OP_A0, [A_PNT, CV(4*A_OFF + 4*4)]              EOL\
  EOR S_TMP, S_TMP                       EOL\
  UMAAL S_TMP, S_RST1, S_OP_A2, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A3, S_OP_D1   EOL\
  UMAAL S_TMP, S_RST3, S_OP_A0, S_OP_A0   EOL\
  ADCS S_TMP, S_TMP, CV(0)				EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*8)]                EOL\
  AND S_OP_D1, CV(0XFFFFFFFE)             EOL\
  UMAAL S_RST1, S_RST2, S_OP_A0, S_OP_D1   EOL\
  UMAAL S_RST1, S_RST3, S_OP_A3, S_OP_D2   EOL\
  ADCS S_RST1, S_RST1, CV(0)				  EOL\
  STR S_RST1, [R_PNT, CV(4*R_OFF + 4*9)]                EOL\
  LDR S_OP_A1, [A_PNT, CV(4*A_OFF + 4*5)]              EOL\
  EOR S_TMP, S_TMP                       EOL\
  UMAAL S_TMP, S_RST2, S_OP_A0, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST3, S_OP_A1, S_OP_A1   EOL\
  ADCS S_TMP, S_TMP, CV(0)				EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*10)]                EOL\
  AND S_OP_D2, CV(0XFFFFFFFE)             EOL\
  UMAAL S_RST2, S_RST3, S_OP_A1, S_OP_D2   EOL\
  ADCS S_RST2, S_RST2, CV(0)				  EOL\
  STR S_RST2, [R_PNT, CV(4*R_OFF + 4*11)]                EOL\
  LDR S_OP_A2, [A_PNT, CV(4*A_OFF + 4*6)]              EOL\
  EOR S_TMP, S_TMP                       EOL\
  UMAAL S_TMP, S_RST3, S_OP_A2, S_OP_A2   EOL\
  ADCS S_TMP, S_TMP, CV(0)				EOL\
  ADCS S_RST3, S_RST3, CV(0)				EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*12)]                EOL\
  STR S_RST3, [R_PNT, CV(4*R_OFF + 4*13)]                EOL\

#define PS_TMP   R1

#define PS_OP_A0 R2
#define PS_OP_A1 R3
#define PS_OP_A2 R4
#define PS_OP_A3 R5

#define PS_OP_B0 R6
#define PS_OP_B1 R7
#define PS_OP_B2 R8
#define PS_OP_B3 R9

#define PS_RST0 R10
#define PS_RST1 R11
#define PS_RST2 R12
#define PS_RST3 R14

#define PS_DOUBLING(OFFSET) \
  LDR PS_OP_B1, [R0, CV(4*1)]               EOL\
  LDR PS_OP_B2, [R0, CV(4*2)]               EOL\
  LDR PS_OP_B3, [R0, CV(4*3)]               EOL\
  LDR PS_OP_A0, [R0, CV(4*4)]               EOL\
  LDR PS_OP_A1, [R0, CV(4*5)]               EOL\
  LDR PS_OP_A2, [R0, CV(4*6)]               EOL\
  LDR PS_OP_A3, [R0, CV(4*7)]               EOL\
  ADDS PS_OP_B1, PS_OP_B1, PS_OP_B1           EOL\
  ADCS PS_OP_B2, PS_OP_B2, PS_OP_B2           EOL\
  ADCS PS_OP_B3, PS_OP_B3, PS_OP_B3           EOL\
  ADCS PS_OP_A0, PS_OP_A0, PS_OP_A0           EOL\
  ADCS PS_OP_A1, PS_OP_A1, PS_OP_A1           EOL\
  ADCS PS_OP_A2, PS_OP_A2, PS_OP_A2           EOL\
  ADCS PS_OP_A3, PS_OP_A3, PS_OP_A3           EOL\
  STR PS_OP_B1, [SP, CV(4*OFFSET+4*1)]               EOL\
  STR PS_OP_B2, [SP, CV(4*OFFSET+4*2)]               EOL\
  STR PS_OP_B3, [SP, CV(4*OFFSET+4*3)]               EOL\
  STR PS_OP_A0, [SP, CV(4*OFFSET+4*4)]               EOL\
  STR PS_OP_A1, [SP, CV(4*OFFSET+4*5)]               EOL\
  STR PS_OP_A2, [SP, CV(4*OFFSET+4*6)]               EOL\
  STR PS_OP_A3, [SP, CV(4*OFFSET+4*7)]               EOL\
  LDR PS_OP_B0, [R0, CV(4*8)]               EOL\
  LDR PS_OP_B1, [R0, CV(4*9)]               EOL\
  LDR PS_OP_B2, [R0, CV(4*10)]               EOL\
  LDR PS_OP_A0, [R0, CV(4*11)]               EOL\
  LDR PS_OP_A1, [R0, CV(4*12)]               EOL\
  LDR PS_OP_A2, [R0, CV(4*13)]               EOL\
  ADCS PS_OP_B0, PS_OP_B0, PS_OP_B0           EOL\
  ADCS PS_OP_B1, PS_OP_B1, PS_OP_B1           EOL\
  ADCS PS_OP_B2, PS_OP_B2, PS_OP_B2           EOL\
  ADCS PS_OP_A0, PS_OP_A0, PS_OP_A0           EOL\
  ADCS PS_OP_A1, PS_OP_A1, PS_OP_A1           EOL\
  ADCS PS_OP_A2, PS_OP_A2, PS_OP_A2           EOL\
  STR PS_OP_B0, [SP, CV(4*OFFSET+4*8)]                EOL\
  STR PS_OP_B1, [SP, CV(4*OFFSET+4*9)]                EOL\
  STR PS_OP_B2, [SP, CV(4*OFFSET+4*10)]               EOL\
  STR PS_OP_A0, [SP, CV(4*OFFSET+4*11)]               EOL\
  STR PS_OP_A1, [SP, CV(4*OFFSET+4*12)]               EOL\
  STR PS_OP_A2, [SP, CV(4*OFFSET+4*13)]               EOL\

#define PS_TOP(R_OUT, OFFSET) \
	UMULL PS_TMP, PS_RST0, PS_OP_A0, PS_OP_B0         EOL\
    STR PS_TMP, [R_OUT, CV(4*OFFSET + 0)]    EOL\
    UMULL PS_TMP, PS_RST1, PS_OP_A1, PS_OP_B0         EOL\
    UMAAL PS_TMP, PS_RST0, PS_OP_A0, PS_OP_B1         EOL\
    STR PS_TMP, [R_OUT, CV(4*OFFSET + 4)]    EOL\
    UMULL PS_TMP, PS_RST2, PS_OP_A2, PS_OP_B0         EOL\
    UMAAL PS_TMP, PS_RST1, PS_OP_A1, PS_OP_B1         EOL\
    UMAAL PS_TMP, PS_RST0, PS_OP_A0, PS_OP_B2         EOL\
    STR PS_TMP, [R_OUT, CV(4*OFFSET + 8)]    EOL\
	UMAAL PS_RST0, PS_RST1, PS_OP_A2, PS_OP_B1         EOL\
    UMAAL PS_RST0, PS_RST2, PS_OP_A1, PS_OP_B2         EOL\
    STR PS_RST0, [R_OUT, CV(4*OFFSET + 12)]    EOL\
	UMAAL PS_RST1, PS_RST2, PS_OP_A2, PS_OP_B2         EOL\
    STR PS_RST1, [R_OUT, CV(4*OFFSET + 16)]    EOL\
	STR PS_RST2, [R_OUT, CV(4*OFFSET + 20)]    EOL\

#define PS_LOAD(OP, V0, V1, V2, V3, OFFSET) \
    LDR V0, [OP, CV(4*OFFSET)]            EOL\
    LDR V1, [OP, CV(4*OFFSET+4)]          EOL\
    LDR V2, [OP, CV(4*OFFSET+8)]          EOL\
    LDR V3, [OP, CV(4*OFFSET+12)]         EOL\

#define PS_MUL_FRONT(R_OUT, OFFSET) \
    UMULL PS_TMP, PS_RST0, PS_OP_A0, PS_OP_B0         EOL\
    STR PS_TMP, [R_OUT, CV(4*OFFSET + 0)]    EOL\
    UMULL PS_TMP, PS_RST1, PS_OP_A1, PS_OP_B0         EOL\
    UMAAL PS_TMP, PS_RST0, PS_OP_A0, PS_OP_B1         EOL\
    STR PS_TMP, [R_OUT, CV(4*OFFSET + 4)]    EOL\
    UMULL PS_TMP, PS_RST2, PS_OP_A2, PS_OP_B0         EOL\
    UMAAL PS_TMP, PS_RST1, PS_OP_A1, PS_OP_B1         EOL\
    UMAAL PS_TMP, PS_RST0, PS_OP_A0, PS_OP_B2         EOL\
    STR PS_TMP, [R_OUT, CV(4*OFFSET + 8)]    EOL\
    UMULL PS_TMP, PS_RST3, PS_OP_A0, PS_OP_B3         EOL\
    UMAAL PS_TMP, PS_RST0, PS_OP_A3, PS_OP_B0         EOL\
    UMAAL PS_TMP, PS_RST1, PS_OP_A2, PS_OP_B1         EOL\
    UMAAL PS_TMP, PS_RST2, PS_OP_A1, PS_OP_B2         EOL\
    STR PS_TMP, [R_OUT, CV(4*OFFSET + 12)]   EOL\

#define PS_MUL_MID_OP_B_DOUBLING(R_OUT, R_OFF, OP_P, P_OFF, P_OFF2) \
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR PS_OP_B0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A3, PS_OP_B1        EOL\
    UMAAL PS_TMP,  PS_RST1, PS_OP_A2, PS_OP_B2        EOL\
    UMAAL PS_TMP,  PS_RST2, PS_OP_A1, PS_OP_B3        EOL\
    UMAAL PS_TMP,  PS_RST3, PS_OP_A0, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR PS_OP_B1, [OP_P, CV(4*P_OFF + 4)]    EOL\
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B3       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B0       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B1        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    LDR PS_OP_B2, [OP_P, CV(4*P_OFF + 8)]    EOL\
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    AND PS_OP_A0, CV(0XFFFFFFFE)             EOL\
	UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B3       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B0       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B1       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B2        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    ADD OP_P, SP, CV(4*28)     EOL\
	LDR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]     EOL\
    LDR PS_OP_A0, [OP_P, CV(4*P_OFF2 + 0)]    EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A2, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A1, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A0, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A3, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]     EOL\
    LDR PS_OP_A1, [OP_P, CV(4*P_OFF2 + 4)]    EOL\
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 16)]     EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 16)]     EOL\
    LDR PS_OP_A2, [OP_P, CV(4*P_OFF2 + 8)]    EOL\
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 20)]     EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A0, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A3, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A2, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A1, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 20)]     EOL\
    UMAAL PS_RST0, PS_RST1, PS_OP_A0, PS_OP_B2        EOL\
    UMAAL PS_RST0, PS_RST2, PS_OP_A1, PS_OP_B1        EOL\
    UMAAL PS_RST0, PS_RST3, PS_OP_A2, PS_OP_B0        EOL\
    STR PS_RST0, [R_OUT, CV(4*R_OFF + 24)]   EOL\
    UMAAL PS_RST1, PS_RST2, PS_OP_A1, PS_OP_B2        EOL\
    UMAAL PS_RST1, PS_RST3, PS_OP_A2, PS_OP_B1        EOL\
    STR PS_RST1, [R_OUT, CV(4*R_OFF + 28)]   EOL\
    UMAAL PS_RST2, PS_RST3, PS_OP_A2, PS_OP_B2        EOL\
    STR PS_RST2, [R_OUT, CV(4*R_OFF + 32)]   EOL\
    STR PS_RST3, [R_OUT, CV(4*R_OFF + 36)]  EOL\

#define PS_MUL_TEST \
    LDR R0, [SP, CV(4*43)]   EOL\
    LDR R1, [SP, CV(4*0)]    EOL\
    STR R1, [R0, CV(4*0)]    EOL\
    LDR R1, [SP, CV(4*1)]    EOL\
    STR R1, [R0, CV(4*1)]    EOL\
    LDR R1, [SP, CV(4*2)]    EOL\
    STR R1, [R0, CV(4*2)]    EOL\
    LDR R1, [SP, CV(4*3)]    EOL\
    STR R1, [R0, CV(4*3)]    EOL\
    LDR R1, [SP, CV(4*4)]    EOL\
    STR R1, [R0, CV(4*4)]    EOL\
    LDR R1, [SP, CV(4*5)]    EOL\
    STR R1, [R0, CV(4*5)]    EOL\
    LDR R1, [SP, CV(4*6)]    EOL\
    STR R1, [R0, CV(4*6)]    EOL\
    LDR R1, [SP, CV(4*7)]    EOL\
    STR R1, [R0, CV(4*7)]    EOL\
    LDR R1, [SP, CV(4*8)]    EOL\
    STR R1, [R0, CV(4*8)]    EOL\
    LDR R1, [SP, CV(4*9)]    EOL\
    STR R1, [R0, CV(4*9)]    EOL\
    LDR R1, [SP, CV(4*10)]   EOL\
    STR R1, [R0, CV(4*10)]   EOL\
    LDR R1, [SP, CV(4*11)]   EOL\
    STR R1, [R0, CV(4*11)]   EOL\
    LDR R1, [SP, CV(4*12)]   EOL\
    STR R1, [R0, CV(4*12)]   EOL\
    LDR R1, [SP, CV(4*13)]   EOL\
    STR R1, [R0, CV(4*13)]   EOL\
    LDR R1, [SP, CV(4*14)]   EOL\
    STR R1, [R0, CV(4*14)]   EOL\
    LDR R1, [SP, CV(4*15)]   EOL\
    STR R1, [R0, CV(4*15)]   EOL\
    LDR R1, [SP, CV(4*16)]   EOL\
    STR R1, [R0, CV(4*16)]   EOL\
    LDR R1, [SP, CV(4*17)]   EOL\
    STR R1, [R0, CV(4*17)]   EOL\
    LDR R1, [SP, CV(4*18)]   EOL\
    STR R1, [R0, CV(4*18)]   EOL\
    LDR R1, [SP, CV(4*19)]   EOL\
    STR R1, [R0, CV(4*19)]   EOL\
    LDR R1, [SP, CV(4*20)]   EOL\
    STR R1, [R0, CV(4*20)]   EOL\
    LDR R1, [SP, CV(4*21)]   EOL\
    STR R1, [R0, CV(4*21)]   EOL\
    LDR R1, [SP, CV(4*22)]   EOL\
    STR R1, [R0, CV(4*22)]   EOL\
    LDR R1, [SP, CV(4*23)]   EOL\
    STR R1, [R0, CV(4*23)]   EOL\
    LDR R1, [SP, CV(4*24)]   EOL\
    STR R1, [R0, CV(4*24)]   EOL\
    LDR R1, [SP, CV(4*25)]   EOL\
    STR R1, [R0, CV(4*25)]   EOL\
    LDR R1, [SP, CV(4*26)]   EOL\
    STR R1, [R0, CV(4*26)]   EOL\
    LDR R1, [SP, CV(4*27)]   EOL\
    STR R1, [R0, CV(4*27)]   EOL\
    LDR R1, [SP, CV(4*28)]   EOL\
    STR R1, [R0, CV(4*28)]   EOL\

#define SP_MASK6  #0xE3000000
#define SP_MASK6L #0x0000
#define SP_MASK6H #0xE300

#define SP_MASK7  #0xFDC1767A
#define SP_MASK7L #0x767A
#define SP_MASK7H #0xFDC1

#define SP_MASK8  #0x3158AEA3
#define SP_MASK8L #0xAEA3
#define SP_MASK8H #0x3158

#define SP_MASK9  #0x7BC65C78
#define SP_MASK9L #0x5C78
#define SP_MASK9H #0x7BC6

#define SP_MASK10 #0x81C52056
#define SP_MASK10L #0x2056
#define SP_MASK10H #0x81C5

#define SP_MASK11 #0x6CFC5FD6
#define SP_MASK11L #0x5FD6
#define SP_MASK11H #0x6CFC

#define SP_MASK12 #0x27177344
#define SP_MASK12L #0x7344
#define SP_MASK12H #0x2717

#define SP_MASK13 #0x2341F
#define SP_MASK13L #0x341F
#define SP_MASK13H #0x2

#define SP_TMP   R1

#define SP_OP_Q0 R2
#define SP_OP_Q1 R3
#define SP_OP_Q2 R4
#define SP_OP_Q3 R5

#define SP_OP_M0 R6
#define SP_OP_M1 R7
#define SP_OP_M2 R8
#define SP_OP_M3 R9

#define SP_RST0 R10
#define SP_RST1 R11
#define SP_RST2 R12
#define SP_RST3 R14

#define SP_LOAD_M \
	MOVW SP_OP_M0, SP_MASK6L		EOL\
	MOVT SP_OP_M0, SP_MASK6H		EOL\
	MOVW SP_OP_M1, SP_MASK7L		EOL\
	MOVT SP_OP_M1, SP_MASK7H		EOL\
	MOVW SP_OP_M2, SP_MASK8L		EOL\
	MOVT SP_OP_M2, SP_MASK8H		EOL\
	MOVW SP_OP_M3, SP_MASK9L		EOL\
	MOVT SP_OP_M3, SP_MASK9H		EOL\

#define SP_LOAD_M2 \
	MOVW SP_OP_M0, SP_MASK6L		EOL\
	MOVT SP_OP_M0, SP_MASK6H		EOL\
	MOVW SP_OP_M1, SP_MASK7L		EOL\
	MOVT SP_OP_M1, SP_MASK7H		EOL\

#define SP_LOAD_Q(OP, Q0, Q1, Q2, Q3, OFFSET) \
    LDR Q0, [OP, CV(4*OFFSET)]            EOL\
    LDR Q1, [OP, CV(4*OFFSET+4)]          EOL\
    LDR Q2, [OP, CV(4*OFFSET+8)]          EOL\
    LDR Q3, [OP, CV(4*OFFSET+12)]         EOL\

#define SP_LOAD_Q2(OP, Q0, Q1, OFFSET) \
    LDR Q0, [OP, CV(4*OFFSET)]            EOL\
    LDR Q1, [OP, CV(4*OFFSET+4)]          EOL\

#define SP_RED_FRONT(R_OUT, R_IN, OFFSET, IN_OFFSET) \
    LDR SP_TMP, [R_IN, CV(4*IN_OFFSET + 0)]  EOL\
	MOV SP_RST0, CV(0)                       EOL\
    UMAAL SP_TMP, SP_RST0, SP_OP_Q0, SP_OP_M0         EOL\
    STR SP_TMP, [R_OUT, CV(4*OFFSET + 0)]    EOL\
    LDR SP_TMP, [R_IN, CV(4*IN_OFFSET + 4)]  EOL\
	UMAAL SP_TMP, SP_RST0, SP_OP_Q1, SP_OP_M0         EOL\
    MOV SP_RST1, CV(0)                       EOL\
    UMAAL SP_TMP, SP_RST1, SP_OP_Q0, SP_OP_M1         EOL\
    STR SP_TMP, [R_OUT, CV(4*OFFSET + 4)]    EOL\
    LDR SP_TMP, [R_IN, CV(4*IN_OFFSET + 8)]  EOL\
	UMAAL SP_TMP, SP_RST0, SP_OP_Q2, SP_OP_M0         EOL\
    UMAAL SP_TMP, SP_RST1, SP_OP_Q1, SP_OP_M1         EOL\
    MOV SP_RST2, CV(0)                       EOL\
    UMAAL SP_TMP, SP_RST2, SP_OP_Q0, SP_OP_M2         EOL\
    STR SP_TMP, [R_OUT, CV(4*OFFSET + 8)]    EOL\
    LDR SP_TMP, [R_IN, CV(4*IN_OFFSET + 12)] EOL\
	UMAAL SP_TMP, SP_RST0, SP_OP_Q3, SP_OP_M0         EOL\
    UMAAL SP_TMP, SP_RST1, SP_OP_Q2, SP_OP_M1         EOL\
    UMAAL SP_TMP, SP_RST2, SP_OP_Q1, SP_OP_M2         EOL\
    MOV SP_RST3, CV(0)                       EOL\
    UMAAL SP_TMP, SP_RST3, SP_OP_Q0, SP_OP_M3         EOL\
    STR SP_TMP, [R_OUT, CV(4*OFFSET + 12)]   EOL\

#define SP_RED_FRONT2(R_OUT, R_IN, OFFSET, IN_OFFSET) \
    LDR SP_TMP, [R_IN, CV(4*IN_OFFSET + 0)]  EOL\
	MOV SP_RST0, CV(0)                       EOL\
    UMAAL SP_TMP, SP_RST0, SP_OP_Q0, SP_OP_M0         EOL\
    STR SP_TMP, [R_OUT, CV(4*OFFSET + 0)]    EOL\
    LDR SP_TMP, [R_IN, CV(4*IN_OFFSET + 4)]  EOL\
	UMAAL SP_TMP, SP_RST0, SP_OP_Q1, SP_OP_M0         EOL\
    MOV SP_RST1, CV(0)                       EOL\
    UMAAL SP_TMP, SP_RST1, SP_OP_Q0, SP_OP_M1         EOL\
    STR SP_TMP, [R_OUT, CV(4*OFFSET + 4)]    EOL\

void __attribute__ ((naked)) fpsqr_mont(const felm_t ma, felm_t mc)
{ // Multiprecision squaring, c = a^2 mod p.
asm volatile(\
STRFY(SQR_PROLOG)
"SUB SP, #4*42 		\n\t"//32 result + 16 operands

STRFY(PS_DOUBLING(28))
//ROUND#1
"MOV R1, R0 		\n\t"
"ADD R0, SP, #4*28 	\n\t"
STRFY(PS_LOAD(R1, PS_OP_B0, PS_OP_B1, PS_OP_B2, PS_OP_B3, 0))
STRFY(PS_TOP(SP,11))


//ROUND#2
STRFY(PS_LOAD(R0, PS_OP_A0, PS_OP_A1, PS_OP_A2, PS_OP_A3, 7))
STRFY(PS_MUL_FRONT(SP, 7))
"LDR R0, [SP, #4 * 42] \n\t"
STRFY(PS_MUL_MID_OP_B_DOUBLING(SP, 11, R0, 4,11))

//PS_MUL_MID_OP_B_DOUBLING
"LDR R0, [SP, #4 * 42] \n\t"
STRFY(SQR_FRONT(SP, 0, R0, 0))
STRFY(SQR_BACK(SP, 14, R0, 7, 7))

//TEST
"MOV R1, #0			   \n\t"//CARRY
"ADDS R1, R1, R1 \n\t"
"LDR R0, [SP, #4 * 43] \n\t"//RESULT POINTER

//ROUND#1
STRFY(SP_LOAD_M)
STRFY(SP_LOAD_Q(SP, SP_OP_Q0, SP_OP_Q1, SP_OP_Q2, SP_OP_Q3, 0))
STRFY(SP_RED_FRONT(SP, SP, 6, 6))
STRFY(P_RED_MID(SP, 10))

//ROUND#2
STRFY(SP_LOAD_M)
STRFY(SP_LOAD_Q(SP, SP_OP_Q0, SP_OP_Q1, SP_OP_Q2, SP_OP_Q3, 4))
STRFY(SP_RED_FRONT(SP, SP, 10, 10))
STRFY(P_RED_MID(SP, 14))

//ROUND#3
STRFY(SP_LOAD_M)
STRFY(SP_LOAD_Q(SP, SP_OP_Q0, SP_OP_Q1, SP_OP_Q2, SP_OP_Q3, 8))
"LDR R0, [SP, #4 * 43] \n\t"// RESULT
STRFY(SP_RED_FRONT(R0, SP, 0, 14))
STRFY(P_RED_MID(SP, 18))

//ROUND#4
STRFY(SP_LOAD_M2)
STRFY(SP_LOAD_Q2(SP, SP_OP_Q0, SP_OP_Q1, 12))
"LDR R0, [SP, #4 * 43] \n\t"// RESULT
STRFY(SP_RED_FRONT2(R0, SP, 4, 18))
STRFY(P_RED_MID3(R0, SP, 6,  20))

"ADD SP, #4*44 		\n\t"
STRFY(SQR_EPILOG)
//////////////////////////////
  :
  :
  : "cc", "memory"
);
}


void fpinv_mont(felm_t a)
{ // Field inversion using Montgomery arithmetic, a = a^(-1)*R mod p.
    fpinv_chain_mont(a);
}


void fp2copy(const f2elm_t a, f2elm_t c)
{ // Copy a GF(p^2) element, c = a.
    fpcopy(a[0], c[0]);
    fpcopy(a[1], c[1]);
}


void fp2zero(f2elm_t a)
{ // Zero a GF(p^2) element, a = 0.
    fpzero(a[0]);
    fpzero(a[1]);
}


void fp2neg(f2elm_t a)
{ // GF(p^2) negation, a = -a in GF(p^2).
    fpneg(a[0]);
    fpneg(a[1]);
}


__inline void fp2add(const f2elm_t a, const f2elm_t b, f2elm_t c)
{ // GF(p^2) addition, c = a+b in GF(p^2).
    fpadd(a[0], b[0], c[0]);
    fpadd(a[1], b[1], c[1]);
}


__inline void fp2sub(const f2elm_t a, const f2elm_t b, f2elm_t c)
{ // GF(p^2) subtraction, c = a-b in GF(p^2).
    fpsub(a[0], b[0], c[0]);
    fpsub(a[1], b[1], c[1]);
}


void fp2div2(const f2elm_t a, f2elm_t c)
{ // GF(p^2) division by two, c = a/2  in GF(p^2).
    fpdiv2(a[0], c[0]);
    fpdiv2(a[1], c[1]);
}


void fp2correction(f2elm_t a)
{ // Modular correction, a = a in GF(p^2).
    fpcorrection(a[0]);
    fpcorrection(a[1]);
}


void __attribute__ ((noinline, naked))  mp_addfast(const digit_t* a, const digit_t* b, digit_t* c)
{ // Multiprecision addition, c = a+b.
    asm(

			"push  {r4-r9,lr}			\n\t"
			"mov r14, r2				\n\t"

			"ldmia r0!, {r2-r5} 			\n\t"
			"ldmia r1!, {r6-r9} 			\n\t"

			"adds r2, r2, r6				\n\t"
			"adcs r3, r3, r7				\n\t"
			"adcs r4, r4, r8				\n\t"
			"adcs r5, r5, r9				\n\t"

			"stmia r14!, {r2-r5} 			\n\t"

			"ldmia r0!, {r2-r5} 			\n\t"
			"ldmia r1!, {r6-r9} 			\n\t"

			"adcs r2, r2, r6				\n\t"
			"adcs r3, r3, r7				\n\t"
			"adcs r4, r4, r8				\n\t"
			"adcs r5, r5, r9				\n\t"

			"stmia r14!, {r2-r5} 			\n\t"

			"ldmia r0!, {r2-r5} 			\n\t"
			"ldmia r1!, {r6-r9} 			\n\t"

			"adcs r2, r2, r6				\n\t"
			"adcs r3, r3, r7				\n\t"
			"adcs r4, r4, r8				\n\t"
			"adcs r5, r5, r9				\n\t"

			"stmia r14!, {r2-r5} 			\n\t"

			"ldmia r0!, {r2-r3} 			\n\t"
			"ldmia r1!, {r6-r7} 			\n\t"


			"adcs r2, r2, r6				\n\t"
			"adcs r3, r3, r7				\n\t"

			"stmia r14!, {r2-r3} 			\n\t"

			"pop  {r4-r9,pc}				\n\t"
	:
	:
	:
	);

}


__inline static void mp_addfastx2(const digit_t* a, const digit_t* b, digit_t* c)
{ // Double-length multiprecision addition, c = a+b.

    mp_add(a, b, c, 2*NWORDS_FIELD);
}


void fp2sqr_mont(const f2elm_t a, f2elm_t c)
{ // GF(p^2) squaring using Montgomery arithmetic, c = a^2 in GF(p^2).
  // Inputs: a = a0+a1*i, where a0, a1 are in [0, 2*p-1]
  // Output: c = c0+c1*i, where c0, c1 are in [0, 2*p-1]
    felm_t t1, t2, t3;

    mp_addfast(a[0], a[1], t1);                      // t1 = a0+a1
    fpsub(a[0], a[1], t2);                           // t2 = a0-a1
    mp_addfast(a[0], a[0], t3);                      // t3 = 2a0
    fpmul_mont(t1, t2, c[0]);                        // c0 = (a0+a1)(a0-a1)
    fpmul_mont(t3, a[1], c[1]);                      // c1 = 2a0*a1
}


__inline unsigned int mp_sub(const digit_t* a, const digit_t* b, digit_t* c, const unsigned int nwords)
{ // Multiprecision subtraction, c = a-b, where lng(a) = lng(b) = nwords. Returns the borrow bit.
    unsigned int i, borrow = 0;

    for (i = 0; i < nwords; i++) {
        SUBC(borrow, a[i], b[i], borrow, c[i]);
    }

    return borrow;
}


__inline static digit_t mp_subfast(const digit_t* a, const digit_t* b, digit_t* c)
{ // Multiprecision subtraction, c = a-b, where lng(a) = lng(b) = 2*NWORDS_FIELD.
  // If c < 0 then returns mask = 0xFF..F, else mask = 0x00..0

	return (0 - (digit_t)mp_sub(a, b, c, 2*NWORDS_FIELD));
}

void fp2mul_mont(const f2elm_t a, const f2elm_t b, f2elm_t c)
{ // GF(p^2) multiplication using Montgomery arithmetic, c = a*b in GF(p^2).
  // Inputs: a = a0+a1*i and b = b0+b1*i, where a0, a1, b0, b1 are in [0, 2*p-1]
  // Output: c = c0+c1*i, where c0, c1 are in [0, 2*p-1]
    felm_t t1, t2;
    dfelm_t tt1, tt2, tt3;
    digit_t mask;
    unsigned int i;

    mp_addfast(a[0], a[1], t1);                      // t1 = a0+a1
    mp_addfast(b[0], b[1], t2);                      // t2 = b0+b1

	fpmul_mont(a[0], b[0], c[0]);
	fpmul_mont(a[1], b[1], tt2);
	fpmul_mont(t1, t2, c[1]);

	fpsub(c[1],c[0],c[1]);
	fpsub(c[1],tt2,c[1]);

	fpsub(c[0],tt2,c[0]);
}


void fpinv_chain_mont(felm_t a)
{// Field inversion using Montgomery arithmetic, a = a^-1*R mod p434
    felm_t t[20], tt;
    unsigned int i, j;

    // Precomputed table
    fpsqr_mont(a, tt);
    fpmul_mont(tt, tt, t[0]);
	fpmul_mont(t[0], tt, t[0]);
	fpmul_mont(a, t[0], t[0]);
    fpmul_mont(t[0], tt, t[1]);
	fpmul_mont(t[1], tt, t[1]);
	fpmul_mont(t[1], tt, t[2]);
	fpmul_mont(t[2], tt, t[3]);
	fpmul_mont(t[3], tt, t[4]);
	fpmul_mont(t[4], tt, t[4]);
	fpmul_mont(t[4], tt, t[4]);
    for (i = 4; i <= 6; i++) fpmul_mont(t[i], tt, t[i+1]);
    fpmul_mont(t[7], tt, t[7]);
    for (i = 7; i <= 8; i++) fpmul_mont(t[i], tt, t[i+1]);
	fpmul_mont(t[9], tt, t[9]);
	fpmul_mont(t[9], tt, t[10]);
    fpmul_mont(t[10], tt, t[10]);
    for (i = 10; i <= 12; i++) fpmul_mont(t[i], tt, t[i+1]);
    fpmul_mont(t[13], tt, t[13]);
    for (i = 13; i <= 17; i++) fpmul_mont(t[i], tt, t[i+1]);
    fpmul_mont(t[18], tt, t[18]);
    fpmul_mont(t[18], tt, t[18]);
	fpmul_mont(t[18], tt, t[19]);


    fpcopy434(a, tt);
	for(i = 0; i < 7; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[2], tt, tt);
	for(i = 0; i < 10; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[8], tt, tt);
	for(i = 0; i < 8; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[10], tt, tt);
	for(i = 0; i < 8; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[5], tt, tt);
	for(i = 0; i < 4; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[0], tt, tt);
	for(i = 0; i < 6; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[2], tt, tt);
	for(i = 0; i < 9; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[9], tt, tt);
	for(i = 0; i < 7; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[15], tt, tt);
	for(i = 0; i < 4; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[3], tt, tt);
	for(i = 0; i < 9; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[13], tt, tt);
	for(i = 0; i < 5; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[7], tt, tt);
	for(i = 0; i < 5; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[2], tt, tt);
	for(i = 0; i < 9; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[0], tt, tt);
	for(i = 0; i < 9; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[11], tt, tt);
	for(i = 0; i < 12; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[12], tt, tt);
	for(i = 0; i < 8; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[18], tt, tt);
	for(i = 0; i < 3; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[0], tt, tt);
	for(i = 0; i < 8; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[6], tt, tt);
	for(i = 0; i < 4; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[0], tt, tt);
	for(i = 0; i < 7; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[3], tt, tt);
	for(i = 0; i < 11; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[14], tt, tt);
	for(i = 0; i < 5; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[1], tt, tt);
	for(i = 0; i < 9; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[12], tt, tt);
	for(i = 0; i < 5; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[4], tt, tt);
	for(i = 0; i < 9; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[19], tt, tt);
	for(i = 0; i < 6; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[17], tt, tt);
	for(i = 0; i < 10; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[5], tt, tt);
	for(i = 0; i < 7; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[15], tt, tt);
	for(i = 0; i < 6; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[16], tt, tt);
	for(i = 0; i < 6; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[14], tt, tt);
	for(i = 0; i < 7; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[19], tt, tt);
	for(j = 0; j < 34; j++){
		for(i = 0; i < 6; i++)fpsqr_mont(tt, tt);
		fpmul_mont(t[19], tt, tt);
	}
	for(i = 0; i < 6; i++)fpsqr_mont(tt, tt);
	fpmul_mont(t[18], tt, a);
return;
}

void fp2inv_mont(f2elm_t a)
{// GF(p^2) inversion using Montgomery arithmetic, a = (a0-i*a1)/(a0^2+a1^2).

	f2elm_t t1;

    fpsqr_mont(a[0], t1[0]);                         // t10 = a0^2
    fpsqr_mont(a[1], t1[1]);                         // t11 = a1^2
    fpadd(t1[0], t1[1], t1[0]);                      // t10 = a0^2+a1^2
    fpinv_mont(t1[0]);                               // t10 = (a0^2+a1^2)^-1
    fpneg(a[1]);                                     // a = a0-i*a1
    fpmul_mont(a[0], t1[0], a[0]);
    fpmul_mont(a[1], t1[0], a[1]);                   // a = (a0-i*a1)*(a0^2+a1^2)^-1

}


void to_fp2mont(const f2elm_t a, f2elm_t mc)
{ // Conversion of a GF(p^2) element to Montgomery representation,
  // mc_i = a_i*R^2*R^(-1) = a_i*R in GF(p^2).

    to_mont(a[0], mc[0]);
    to_mont(a[1], mc[1]);
}


void from_fp2mont(const f2elm_t ma, f2elm_t c)
{ // Conversion of a GF(p^2) element from Montgomery representation to standard representation,
  // c_i = ma_i*R^(-1) = a_i in GF(p^2).

    from_mont(ma[0], c[0]);
    from_mont(ma[1], c[1]);
}

unsigned int __attribute__ ((noinline, naked)) mp_add(const digit_t* a, const digit_t* b, digit_t* c, const unsigned int nwords)
{ // Multiprecision addition, c = a+b, where lng(a) = lng(b) = nwords. Returns the carry bit.
}


void mp_shiftleft(digit_t* x, unsigned int shift, const unsigned int nwords)
{
    unsigned int i, j = 0;

    while (shift > RADIX) {
        j += 1;
        shift -= RADIX;
    }

    for (i = 0; i < nwords-j; i++)
        x[nwords-1-i] = x[nwords-1-i-j];
    for (i = nwords-j; i < nwords; i++)
        x[nwords-1-i] = 0;
    if (shift != 0) {
        for (j = nwords-1; j > 0; j--)
            SHIFTL(x[j], x[j-1], shift, x[j], RADIX);
        x[0] <<= shift;
    }
}


void mp_shiftr1(digit_t* x, const unsigned int nwords)
{ // Multiprecision right shift by one.
    unsigned int i;

    for (i = 0; i < nwords-1; i++) {
        SHIFTR(x[i+1], x[i], 1, x[i], RADIX);
    }
    x[nwords-1] >>= 1;
}


void mp_shiftl1(digit_t* x, const unsigned int nwords)
{ // Multiprecision left shift by one.
    int i;

    for (i = nwords-1; i > 0; i--) {
        SHIFTL(x[i], x[i-1], 1, x[i], RADIX);
    }
    x[0] <<= 1;
}
