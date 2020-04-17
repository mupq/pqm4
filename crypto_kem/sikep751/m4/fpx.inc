/********************************************************************************************
* Supersingular Isogeny Key Encapsulation Library
*
* Abstract: core functions over GF(p) and GF(p^2)
*********************************************************************************************/

#include "P751_internal.h"

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

#define P_MUL_MID_OP_B(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR P_OP_B0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_A3, P_OP_B1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_A2, P_OP_B2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_A1, P_OP_B3        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_A0, P_OP_B0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR P_OP_B1, [OP_P, CV(4*P_OFF + 4)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL P_RST0,  P_RST1, P_OP_A3, P_OP_B2       EOL\
    UMAAL P_RST0,  P_RST2, P_OP_A2, P_OP_B3       EOL\
    UMAAL P_RST0,  P_RST3, P_OP_A1, P_OP_B0       EOL\
    UMAAL P_TMP,  P_RST0, P_OP_A0, P_OP_B1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    LDR P_OP_B2, [OP_P, CV(4*P_OFF + 8)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    UMAAL P_RST0,  P_RST1, P_OP_A3, P_OP_B3       EOL\
    UMAAL P_RST0,  P_RST2, P_OP_A2, P_OP_B0       EOL\
    UMAAL P_RST0,  P_RST3, P_OP_A1, P_OP_B1       EOL\
    UMAAL P_TMP,  P_RST0, P_OP_A0, P_OP_B2        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR P_OP_B3, [OP_P, CV(4*P_OFF + 12)]   EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    UMAAL P_RST0,  P_RST1, P_OP_A3, P_OP_B0       EOL\
    UMAAL P_RST0,  P_RST2, P_OP_A2, P_OP_B1       EOL\
    UMAAL P_RST0,  P_RST3, P_OP_A1, P_OP_B2       EOL\
    UMAAL P_TMP,  P_RST0, P_OP_A0, P_OP_B3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\

#define P_MUL_MID_OP_A(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR P_OP_A0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    UMAAL P_RST0,  P_RST1, P_OP_A3, P_OP_B1       EOL\
    UMAAL P_RST0,  P_RST2, P_OP_A2, P_OP_B2       EOL\
    UMAAL P_RST0,  P_RST3, P_OP_A1, P_OP_B3       EOL\
    UMAAL P_TMP,  P_RST0, P_OP_A0, P_OP_B0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR P_OP_A1, [OP_P, CV(4*P_OFF + 4)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL P_RST0,  P_RST1, P_OP_A0, P_OP_B1       EOL\
    UMAAL P_RST0,  P_RST2, P_OP_A3, P_OP_B2       EOL\
    UMAAL P_RST0,  P_RST3, P_OP_A2, P_OP_B3       EOL\
    UMAAL P_TMP,  P_RST0, P_OP_A1, P_OP_B0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    LDR P_OP_A2, [OP_P, CV(4*P_OFF + 8)]    EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    UMAAL P_RST0,  P_RST1, P_OP_A1, P_OP_B1       EOL\
    UMAAL P_RST0,  P_RST2, P_OP_A0, P_OP_B2       EOL\
    UMAAL P_RST0,  P_RST3, P_OP_A3, P_OP_B3       EOL\
    UMAAL P_TMP,  P_RST0, P_OP_A2, P_OP_B0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR P_OP_A3, [OP_P, CV(4*P_OFF + 12)]   EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    UMAAL P_RST0,  P_RST1, P_OP_A2, P_OP_B1       EOL\
    UMAAL P_RST0,  P_RST2, P_OP_A1, P_OP_B2       EOL\
    UMAAL P_RST0,  P_RST3, P_OP_A0, P_OP_B3       EOL\
    UMAAL P_TMP,  P_RST0, P_OP_A3, P_OP_B0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\

#define P_MASK11 #0xEEB00000
#define P_MASK11L #0x0000
#define P_MASK11H #0xEEB0

#define P_MASK12 #0x49F878A8
#define P_MASK12L #0x78A8
#define P_MASK12H #0x49F8

#define P_MASK13 #0xE3EC9685
#define P_MASK13L #0x9685
#define P_MASK13H #0xE3EC

#define P_MASK14 #0x13F7CC76
#define P_MASK14L #0xCC76
#define P_MASK14H #0x13F7

#define P_MASK15 #0xDA959B1A
#define P_MASK15L #0x9B1A
#define P_MASK15H #0xDA95

#define P_MASK16 #0xD6EBE876
#define P_MASK16L #0xE876
#define P_MASK16H #0xD6EB

#define P_MASK17 #0x84E9867
#define P_MASK17L #0x9867
#define P_MASK17H #0x84E

#define P_MASK18 #0x5CB25748
#define P_MASK18L #0x5748
#define P_MASK18H #0x5CB2

#define P_MASK19 #0x8562B504
#define P_MASK19L #0xB504
#define P_MASK19H #0x8562

#define P_MASK20 #0x97BADC66
#define P_MASK20L #0xDC66
#define P_MASK20H #0x97BA

#define P_MASK21 #0xE12909F
#define P_MASK21L #0x909F
#define P_MASK21H #0xE12

#define P_MASK22 #0xD541F71C
#define P_MASK22L #0xF71C
#define P_MASK22H #0xD541

#define P_MASK23 #0x6FE5
#define P_MASK23L #0x6FE5
#define P_MASK23H #0x0000


#define P_OP_Q0 R2
#define P_OP_Q1 R3
#define P_OP_Q2 R4
#define P_OP_Q3 R5

#define P_OP_M0 R6
#define P_OP_M1 R7
#define P_OP_M2 R8
#define P_OP_M3 R9

#define P_LOAD_M \
	MOVW P_OP_M0, P_MASK11L		EOL\
	MOVT P_OP_M0, P_MASK11H		EOL\
	MOVW P_OP_M1, P_MASK12L		EOL\
	MOVT P_OP_M1, P_MASK12H		EOL\
	MOVW P_OP_M2, P_MASK13L		EOL\
	MOVT P_OP_M2, P_MASK13H		EOL\
	MOVW P_OP_M3, P_MASK14L		EOL\
	MOVT P_OP_M3, P_MASK14H		EOL\

#define P_LOAD_Q(OP, Q0, Q1, Q2, Q3, OFFSET) \
    LDR Q0, [OP, CV(4*OFFSET)]            EOL\
    LDR Q1, [OP, CV(4*OFFSET+4)]          EOL\
    LDR Q2, [OP, CV(4*OFFSET+8)]          EOL\
    LDR Q3, [OP, CV(4*OFFSET+12)]         EOL\

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
    STR P_TMP, [R_IN, CV(4*IN_OFFSET + 0)]  EOL\
    LDR P_TMP, [R_IN, CV(4*IN_OFFSET + 4)]  EOL\
	UMAAL P_TMP, P_RST0, P_OP_Q1, P_OP_M0         EOL\
    MOV P_RST1, CV(0)                       EOL\
    UMAAL P_TMP, P_RST1, P_OP_Q0, P_OP_M1         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 0)]    EOL\
    LDR P_TMP, [R_IN, CV(4*IN_OFFSET + 8)]  EOL\
	UMAAL P_TMP, P_RST0, P_OP_Q2, P_OP_M0         EOL\
    UMAAL P_TMP, P_RST1, P_OP_Q1, P_OP_M1         EOL\
    MOV P_RST2, CV(0)                       EOL\
    UMAAL P_TMP, P_RST2, P_OP_Q0, P_OP_M2         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 4)]    EOL\
    LDR P_TMP, [R_IN, CV(4*IN_OFFSET + 12)] EOL\
	UMAAL P_TMP, P_RST0, P_OP_Q3, P_OP_M0         EOL\
    UMAAL P_TMP, P_RST1, P_OP_Q2, P_OP_M1         EOL\
    UMAAL P_TMP, P_RST2, P_OP_Q1, P_OP_M2         EOL\
    MOV P_RST3, CV(0)                       EOL\
    UMAAL P_TMP, P_RST3, P_OP_Q0, P_OP_M3         EOL\
    STR P_TMP, [R_OUT, CV(4*OFFSET + 8)]    EOL\



#define P_RED_MID(R_OUT, R_OFF) \
    MOVW P_OP_M0, P_MASK15L		EOL\
	MOVT P_OP_M0, P_MASK15H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M3        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    MOVW P_OP_M1, P_MASK16L		EOL\
	MOVT P_OP_M1, P_MASK16H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    MOVW P_OP_M2, P_MASK17L		EOL\
	MOVT P_OP_M2, P_MASK17H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M0        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M1        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M2        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    MOVW P_OP_M3, P_MASK18L		EOL\
	MOVT P_OP_M3, P_MASK18H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M0        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M2        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    MOVW P_OP_M0, P_MASK19L		EOL\
	MOVT P_OP_M0, P_MASK19H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 16)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M3        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 16)]    EOL\
    MOVW P_OP_M1, P_MASK20L		EOL\
	MOVT P_OP_M1, P_MASK20H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 20)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 20)]    EOL\
    MOVW P_OP_M2, P_MASK21L		EOL\
	MOVT P_OP_M2, P_MASK21H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 24)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M0        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M1        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M2        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 24)]    EOL\
    MOVW P_OP_M3, P_MASK22L		EOL\
	MOVT P_OP_M3, P_MASK22H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 28)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M0        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M2        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 28)]    EOL\
    MOVW P_OP_M0, P_MASK23L		EOL\
	MOVT P_OP_M0, P_MASK23H		EOL\
    LDR P_TMP, [R_OUT, CV(4*R_OFF + 32)]    EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M3        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 32)]    EOL\
	UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M0        EOL\
    LDR P_OP_M1, [R_OUT, CV(4*R_OFF + 36)]  EOL\
    ADCS P_RST3, P_OP_M1, P_RST3				  EOL\
	STR P_RST3, [R_OUT, CV(4*R_OFF + 36)]   EOL\
	UMAAL P_RST2,  P_RST0, P_OP_Q3, P_OP_M3        EOL\
    UMAAL P_RST2,  P_RST1, P_OP_Q2, P_OP_M0        EOL\
    LDR P_OP_M1, [R_OUT, CV(4*R_OFF + 40)]  EOL\
    ADCS P_RST2, P_OP_M1, P_RST2				  EOL\
	STR P_RST2, [R_OUT, CV(4*R_OFF + 40)]   EOL\
	UMAAL P_RST1,  P_RST0, P_OP_Q3, P_OP_M0        EOL\
    LDR P_OP_M1, [R_OUT, CV(4*R_OFF + 44)]  EOL\
	LDR P_OP_M2, [R_OUT, CV(4*R_OFF + 48)]  EOL\
	ADCS P_RST1, P_OP_M1, P_RST1				  EOL\
	ADCS P_RST0, P_OP_M2, P_RST0				  EOL\
	STR P_RST1, [R_OUT, CV(4*R_OFF + 44)]   EOL\
	STR P_RST0, [R_OUT, CV(4*R_OFF + 48)]   EOL\

#define P_RED_MID2(R_OUT, R_IN, R_OFF, R_IN_OFF) \
    MOVW P_OP_M0, P_MASK15L		EOL\
	MOVT P_OP_M0, P_MASK15H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 0)]   EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M3        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    MOVW P_OP_M1, P_MASK16L		EOL\
	MOVT P_OP_M1, P_MASK16H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 4)]   EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    MOVW P_OP_M2, P_MASK17L		EOL\
	MOVT P_OP_M2, P_MASK17H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 8)]   EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M0        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M1        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M2        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    MOVW P_OP_M3, P_MASK18L		EOL\
	MOVT P_OP_M3, P_MASK18H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 12)]  EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M0        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M2        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    MOVW P_OP_M0, P_MASK19L		EOL\
	MOVT P_OP_M0, P_MASK19H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 16)]  EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M3        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 16)]    EOL\
    MOVW P_OP_M1, P_MASK20L		EOL\
	MOVT P_OP_M1, P_MASK20H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 20)]  EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M0        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M1        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 20)]    EOL\
    MOVW P_OP_M2, P_MASK21L		EOL\
	MOVT P_OP_M2, P_MASK21H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 24)]  EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M0        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M1        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M2        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 24)]    EOL\
    MOVW P_OP_M3, P_MASK22L		EOL\
	MOVT P_OP_M3, P_MASK22H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 28)]  EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M0        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M2        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M3        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 28)]    EOL\
    MOVW P_OP_M0, P_MASK23L		EOL\
	MOVT P_OP_M0, P_MASK23H		EOL\
    LDR P_TMP, [R_IN, CV(4*R_IN_OFF + 32)]  EOL\
    UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M1        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M3        EOL\
    UMAAL P_TMP,  P_RST3, P_OP_Q0, P_OP_M0        EOL\
    STR P_TMP, [R_OUT, CV(4*R_OFF + 32)]    EOL\
	UMAAL P_RST3,  P_RST0, P_OP_Q3, P_OP_M2        EOL\
    UMAAL P_RST3,  P_RST1, P_OP_Q2, P_OP_M3        EOL\
    UMAAL P_RST3,  P_RST2, P_OP_Q1, P_OP_M0        EOL\
    LDR P_OP_M1, [R_IN, CV(4*R_IN_OFF + 36)] EOL\
    ADCS P_RST3, P_OP_M1, P_RST3				  EOL\
	STR P_RST3, [R_OUT, CV(4*R_OFF + 36)]   EOL\
	UMAAL P_RST2,  P_RST0, P_OP_Q3, P_OP_M3        EOL\
    UMAAL P_RST2,  P_RST1, P_OP_Q2, P_OP_M0        EOL\
    LDR P_OP_M1, [R_IN, CV(4*R_IN_OFF + 40)] EOL\
    ADCS P_RST2, P_OP_M1, P_RST2				  EOL\
	STR P_RST2, [R_OUT, CV(4*R_OFF + 40)]   EOL\
	UMAAL P_RST1,  P_RST0, P_OP_Q3, P_OP_M0        EOL\
	LDR P_OP_M1, [R_IN, CV(4*R_IN_OFF + 44)] EOL\
	LDR P_OP_M2, [R_IN, CV(4*R_IN_OFF + 48)] EOL\
    ADCS P_RST1, P_RST1, P_OP_M1				  EOL\
    ADCS P_RST0, P_RST0, P_OP_M2				  EOL\
	STR P_RST1, [R_OUT, CV(4*R_OFF + 44)]	  EOL\
	STR P_RST0, [R_OUT, CV(4*R_OFF + 48)]   EOL\

void __attribute__ ((naked)) fpmul_mont(const felm_t ma, const felm_t mb, felm_t mc)
{ // Multiprecision multiplication, c = a*b mod p.
asm volatile(\
STRFY(P_MUL_PROLOG)
"SUB SP, #4*64 			\n\t"

//ROUND#1
STRFY(P_LOAD(R0, P_OP_A0, P_OP_A1, P_OP_A2, P_OP_A3, 20))
STRFY(P_LOAD(R1, P_OP_B0, P_OP_B1, P_OP_B2, P_OP_B3, 0))
STRFY(P_MUL_FRONT(SP, 20))
STRFY(P_MUL_BACK(SP, 24))

//ROUND#2
STRFY(P_LOAD(R0, P_OP_A0, P_OP_A1, P_OP_A2, P_OP_A3, 16))
STRFY(P_MUL_FRONT(SP, 16))
"LDR R0, [SP, #4 * 65] \n\t"
STRFY(P_MUL_MID_OP_B(SP, 20, R0, 4))
"LDR R0, [SP, #4 * 64] \n\t"
STRFY(P_MUL_MID_OP_A(SP, 24, R0, 20))
STRFY(P_MUL_BACK(SP, 28))

//ROUND#3
"LDR R0, [SP, #4 * 64] \n\t"// OP_A
"LDR R1, [SP, #4 * 65] \n\t"// OP_B
STRFY(P_LOAD(R0, P_OP_A0, P_OP_A1, P_OP_A2, P_OP_A3, 12))
STRFY(P_LOAD(R1, P_OP_B0, P_OP_B1, P_OP_B2, P_OP_B3, 0))
STRFY(P_MUL_FRONT(SP, 12))
"LDR R0, [SP, #4 * 65] \n\t"
STRFY(P_MUL_MID_OP_B(SP, 16, R0, 4))
STRFY(P_MUL_MID_OP_B(SP, 20, R0, 8))
"LDR R0, [SP, #4 * 64] \n\t"
STRFY(P_MUL_MID_OP_A(SP, 24, R0, 16))
STRFY(P_MUL_MID_OP_A(SP, 28, R0, 20))
STRFY(P_MUL_BACK(SP, 32))

//ROUND#4
"LDR R0, [SP, #4 * 64] \n\t"// OP_A
"LDR R1, [SP, #4 * 65] \n\t"// OP_B
STRFY(P_LOAD(R0, P_OP_A0, P_OP_A1, P_OP_A2, P_OP_A3, 8))
STRFY(P_LOAD(R1, P_OP_B0, P_OP_B1, P_OP_B2, P_OP_B3, 0))
STRFY(P_MUL_FRONT(SP, 8))
"LDR R0, [SP, #4 * 65] \n\t"
STRFY(P_MUL_MID_OP_B(SP, 12, R0, 4))
STRFY(P_MUL_MID_OP_B(SP, 16, R0, 8))
STRFY(P_MUL_MID_OP_B(SP, 20, R0, 12))
"LDR R0, [SP, #4 * 64] \n\t"
STRFY(P_MUL_MID_OP_A(SP, 24, R0, 12))
STRFY(P_MUL_MID_OP_A(SP, 28, R0, 16))
STRFY(P_MUL_MID_OP_A(SP, 32, R0, 20))
STRFY(P_MUL_BACK(SP, 36))

//ROUND#5
"LDR R0, [SP, #4 * 64] \n\t"// OP_A
"LDR R1, [SP, #4 * 65] \n\t"// OP_B
STRFY(P_LOAD(R0, P_OP_A0, P_OP_A1, P_OP_A2, P_OP_A3, 4))
STRFY(P_LOAD(R1, P_OP_B0, P_OP_B1, P_OP_B2, P_OP_B3, 0))
STRFY(P_MUL_FRONT(SP, 4))
"LDR R0, [SP, #4 * 65] \n\t"
STRFY(P_MUL_MID_OP_B(SP, 8, R0, 4))
STRFY(P_MUL_MID_OP_B(SP, 12, R0, 8))
STRFY(P_MUL_MID_OP_B(SP, 16, R0, 12))
STRFY(P_MUL_MID_OP_B(SP, 20, R0, 16))
"LDR R0, [SP, #4 * 64] \n\t"
STRFY(P_MUL_MID_OP_A(SP, 24, R0, 8))
STRFY(P_MUL_MID_OP_A(SP, 28, R0, 12))
STRFY(P_MUL_MID_OP_A(SP, 32, R0, 16))
STRFY(P_MUL_MID_OP_A(SP, 36, R0, 20))
STRFY(P_MUL_BACK(SP, 40))

//ROUND#6
"LDR R0, [SP, #4 * 64] \n\t"// OP_A
"LDR R1, [SP, #4 * 65] \n\t"// OP_B
STRFY(P_LOAD(R0, P_OP_A0, P_OP_A1, P_OP_A2, P_OP_A3, 0))
STRFY(P_LOAD(R1, P_OP_B0, P_OP_B1, P_OP_B2, P_OP_B3, 0))
STRFY(P_MUL_FRONT(SP, 0))
"LDR R0, [SP, #4 * 65] \n\t"
STRFY(P_MUL_MID_OP_B(SP, 4 , R0, 4))
STRFY(P_MUL_MID_OP_B(SP, 8 , R0, 8))
STRFY(P_MUL_MID_OP_B(SP, 12, R0, 12))
STRFY(P_MUL_MID_OP_B(SP, 16, R0, 16))
STRFY(P_MUL_MID_OP_B(SP, 20, R0, 20))
"LDR R0, [SP, #4 * 64] \n\t"
STRFY(P_MUL_MID_OP_A(SP, 24, R0, 4))
STRFY(P_MUL_MID_OP_A(SP, 28, R0, 8))
STRFY(P_MUL_MID_OP_A(SP, 32, R0, 12))
STRFY(P_MUL_MID_OP_A(SP, 36, R0, 16))
STRFY(P_MUL_MID_OP_A(SP, 40, R0, 20))
STRFY(P_MUL_BACK(SP, 44))


//TEST
"MOV R1, #0			   \n\t"//CARRY
"ADDS R1, R1,R1			   \n\t"//CARRY
"LDR R0, [SP, #4 * 66] \n\t"//RESULT POINTER

//ROUND#1
//"LDR R0, [SP, #4 * 33] \n\t"// OP_Q
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 0))
STRFY(P_RED_FRONT(SP, SP, 11, 11))
STRFY(P_RED_MID(SP, 15))

//ROUND#2
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 4))
STRFY(P_RED_FRONT(SP, SP, 15, 15))
STRFY(P_RED_MID(SP, 19))

//ROUND#3
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 8))
STRFY(P_RED_FRONT(SP, SP, 19, 19))
STRFY(P_RED_MID(SP, 23))

//ROUND#4
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 12))
STRFY(P_RED_FRONT2(R0, SP, 0, 23))
STRFY(P_RED_MID(SP, 27))

//ROUND#5
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 16))
STRFY(P_RED_FRONT(R0, SP, 3, 27))
STRFY(P_RED_MID(SP, 31))

//ROUND#6
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 20))
STRFY(P_RED_FRONT(R0, SP, 7, 31))
STRFY(P_RED_MID2(R0, SP, 11,  35))

"ADD SP, #4*67 		   \n\t"
STRFY(P_MUL_EPILOG)
  :
  :
  : "cc", "memory"
);
}


#define S_TMP   R1

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
  AND S_OP_D0, CV(0XFFFFFFFE)             EOL\
  EOR S_TMP, S_TMP                       EOL\
  UMAAL S_TMP, S_RST3, S_OP_A3, S_OP_D0   EOL\
  LDR S_OP_D0, [A_PNT, CV(4*A_OFF + 4*7)]               EOL\
  ADCS S_OP_D3, S_OP_D0, S_OP_D0           EOL\
  UMAAL S_TMP, S_RST1, S_OP_A1, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A2, S_OP_D1   EOL\
  UMAAL S_TMP, S_RST0, S_OP_A0, S_OP_D3   EOL\
    LDR S_OP_A0, [R0, CV(4*4)]               EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*7)]                EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*8)]                EOL\
  UMAAL S_TMP, S_RST0, S_OP_A1, S_OP_D3   EOL\
  UMAAL S_TMP, S_RST1, S_OP_A2, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A3, S_OP_D1   EOL\
  UMAAL S_TMP, S_RST3, S_OP_A0, S_OP_A0   EOL\
  AND S_OP_D1, CV(0XFFFFFFFE)             EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*8)]                EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*9)]                EOL\
  UMAAL S_RST0, S_RST1, S_OP_A2, S_OP_D3  EOL\
  UMAAL S_RST0, S_RST2, S_OP_A3, S_OP_D2  EOL\
  UMAAL S_RST0, S_RST3, S_OP_A0, S_OP_D1  EOL\
  ADDS S_RST0, S_RST0, S_TMP			  EOL\
  LDR S_OP_A1, [A_PNT, CV(4*A_OFF + 4*5)]              EOL\
  LDR S_OP_A2, [A_PNT, CV(4*A_OFF + 4*6)]              EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*9)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*10)]                EOL\
  UMAAL S_TMP, S_RST1, S_OP_A3, S_OP_D3   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A0, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST3, S_OP_A1, S_OP_A1   EOL\
  ADCS S_TMP, S_TMP, CV(0)			  EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*10)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*11)]                EOL\
  AND S_OP_D2, CV(0XFFFFFFFE)             EOL\
  UMAAL S_RST1, S_RST2, S_OP_A0, S_OP_D3   EOL\
  UMAAL S_RST1, S_RST3, S_OP_A1, S_OP_D2   EOL\
  ADCS S_RST1, S_RST1, S_TMP			  EOL\
  STR S_RST1, [R_PNT, CV(4*R_OFF + 4*11)]               EOL\
  LDR S_OP_D1, [R_PNT, CV(4*R_OFF + 4*12)]                EOL\
  UMAAL S_OP_D1, S_RST2, S_OP_A1, S_OP_D3   EOL\
  UMAAL S_OP_D1, S_RST3, S_OP_A2, S_OP_A2   EOL\
  ADCS S_OP_D1, S_OP_D1, CV(0)			  EOL\
  STR S_OP_D1, [R_PNT, CV(4*R_OFF + 4*12)]               EOL\
  LDR S_OP_A0, [R_PNT, CV(4*R_OFF + 4*13)]                EOL\
  LDR S_RST0, [R_PNT, CV(4*R_OFF + 4*14)]                EOL\
  LDR S_OP_A1, [R_PNT, CV(4*R_OFF + 4*15)]                EOL\
  AND S_OP_D3, CV(0XFFFFFFFE)             EOL\
  UMAAL S_RST2, S_RST3, S_OP_A2, S_OP_D3   EOL\
  UMAAL S_RST0, S_RST3, S_OP_D0, S_OP_D0   EOL\
  ADCS S_RST2, S_RST2, S_OP_A0		EOL\
  ADCS S_RST0, S_RST0, CV(0)		EOL\
  ADCS S_RST3, S_RST3, S_OP_A1		EOL\
  STR S_RST2, [R_PNT, CV(4*R_OFF + 4*13)]               EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*14)]               EOL\
  STR S_RST3, [R_PNT, CV(4*R_OFF + 4*15)]               EOL\



#define SQR_MID(R_PNT, R_OFF, A_PNT, A_OFF, B_OFF)\
  LDR S_OP_A0, [A_PNT, CV(4*A_OFF + 4*0)]               EOL\
  LDR S_OP_A1, [A_PNT, CV(4*A_OFF + 4*1)]               EOL\
  LDR S_OP_A2, [A_PNT, CV(4*A_OFF + 4*2)]               EOL\
  LDR S_OP_A3, [A_PNT, CV(4*A_OFF + 4*3)]               EOL\
  LDR S_OP_D0, [A_PNT, CV(4*A_OFF + 4*4)]               EOL\
  LDR S_RST3,  [A_PNT, CV(4*A_OFF + 4*5)]               EOL\
  ADD S_RST0, SP, CV(4*48)								EOL\
  LDR S_OP_D1, [S_RST0, CV(4*B_OFF + 4*1)]              EOL\
  LDR S_OP_D2, [S_RST0, CV(4*B_OFF + 4*2)]              EOL\
  LDR S_OP_D3, [S_RST0, CV(4*B_OFF + 4*3)]              EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*0)]                 EOL\
  EOR S_RST0, S_RST0									EOL\
  UMAAL S_TMP, S_RST0, S_OP_A0, S_OP_A0					EOL\
  ADCS S_TMP, S_TMP, CV(0)								EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*0)]                 EOL\
  AND S_OP_D1, CV(0XFFFFFFFE)							EOL\
  LDR S_RST1, [R_PNT, CV(4*R_OFF + 4*1)]                EOL\
  UMAAL S_RST0, S_RST1, S_OP_A0, S_OP_D1				EOL\
  ADCS S_RST0, S_RST0, CV(0)							EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*1)]                EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*2)]                 EOL\
  EOR S_RST2, S_RST2									EOL\
  UMAAL S_TMP, S_RST2, S_OP_A1, S_OP_A1					EOL\
  UMAAL S_TMP, S_RST1, S_OP_A0, S_OP_D2					EOL\
  ADCS S_TMP, S_TMP, CV(0)								EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*2)]					EOL\
  AND S_OP_D2, CV(0XFFFFFFFE)							EOL\
  LDR S_RST0, [R_PNT, CV(4*R_OFF + 4*3)]                EOL\
  UMAAL S_RST1, S_RST2, S_OP_A0, S_OP_D3				EOL\
  UMAAL S_RST0, S_RST1, S_OP_A1, S_OP_D2				EOL\
  ADCS S_RST0, S_RST0, CV(0)							EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*3)]                EOL\
  ADD S_RST0, SP, CV(4*48)								EOL\
  LDR S_OP_D0, [S_RST0, CV(4*B_OFF + 4*4)]              EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*4)]                 EOL\
  EOR S_RST0, S_RST0									EOL\
  UMAAL S_TMP, S_RST0, S_OP_A0, S_OP_D0					EOL\
  UMAAL S_TMP, S_RST1, S_OP_A1, S_OP_D3					EOL\
  UMAAL S_TMP, S_RST2, S_OP_A2, S_OP_A2					EOL\
  ADCS S_TMP, S_TMP, CV(0)								EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*4)]					EOL\
  ADD S_TMP, SP, CV(4*48)								EOL\
  LDR S_OP_D1, [S_TMP, CV(4*B_OFF + 4*5)]               EOL\
  AND S_OP_D3, CV(0XFFFFFFFE)							EOL\
  LDR S_RST3, [R_PNT, CV(4*R_OFF + 4*5)]                EOL\
  UMAAL S_RST0, S_RST1, S_OP_A0, S_OP_D1				EOL\
  UMAAL S_RST0, S_RST2, S_OP_A1, S_OP_D0				EOL\
  UMAAL S_RST3, S_RST0, S_OP_A2, S_OP_D3				EOL\
  ADCS S_RST3, S_RST3, CV(0)							EOL\
  STR S_RST3, [R_PNT, CV(4*R_OFF + 4*5)]                EOL\
  ADD S_RST3, SP, CV(4*48)								EOL\
  LDR S_OP_D2, [S_RST3, CV(4*B_OFF + 4*6)]              EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*6)]                 EOL\
  EOR S_RST3, S_RST3									EOL\
  UMAAL S_RST0, S_RST1, S_OP_A1, S_OP_D1				EOL\
  UMAAL S_RST0, S_RST2, S_OP_A2, S_OP_D0				EOL\
  UMAAL S_TMP, S_RST3, S_OP_A0, S_OP_D2					EOL\
  UMAAL S_TMP, S_RST0, S_OP_A3, S_OP_A3					EOL\
  ADCS S_TMP, S_TMP, CV(0)								EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*6)]					EOL\
  AND S_OP_D0, CV(0XFFFFFFFE)							EOL\
  ADD S_TMP, SP, CV(4*48)								EOL\
  LDR S_OP_D3, [S_TMP, CV(4*B_OFF + 4*7)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*7)]                 EOL\
  UMAAL S_TMP, S_RST3, S_OP_A3, S_OP_D0   EOL\
  UMAAL S_TMP, S_RST1, S_OP_A2, S_OP_D1   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A1, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST0, S_OP_A0, S_OP_D3   EOL\
  ADCS S_TMP, S_TMP, CV(0)				  EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*7)]                EOL\
  LDR S_OP_A0, [A_PNT, CV(4*A_OFF + 4*4)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*8)]                 EOL\
  UMAAL S_TMP, S_RST0, S_OP_A1, S_OP_D3		EOL\
  UMAAL S_TMP, S_RST1, S_OP_A2, S_OP_D2		EOL\
  UMAAL S_TMP, S_RST2, S_OP_A3, S_OP_D1		EOL\
  UMAAL S_TMP, S_RST3, S_OP_A0, S_OP_A0		EOL\
  ADCS S_TMP, S_TMP, CV(0)					EOL\
  AND S_OP_D1, CV(0XFFFFFFFE)				EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*8)]                EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*9)]                 EOL\
  UMAAL S_RST0, S_RST1, S_OP_A2, S_OP_D3	EOL\
  UMAAL S_RST0, S_RST2, S_OP_A3, S_OP_D2	EOL\
  UMAAL S_RST0, S_RST3, S_OP_A0, S_OP_D1	EOL\
  ADCS S_RST0, S_RST0, S_TMP				EOL\
  LDR S_OP_A1, [A_PNT, CV(4*A_OFF + 4*5)]              EOL\
  LDR S_OP_A2, [A_PNT, CV(4*A_OFF + 4*6)]              EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*9)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*10)]                 EOL\
  UMAAL S_TMP, S_RST1, S_OP_A3, S_OP_D3   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A0, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST3, S_OP_A1, S_OP_A1   EOL\
  ADCS S_TMP, S_TMP, CV(0)				EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*10)]               EOL\
  AND S_OP_D2, CV(0XFFFFFFFE)             EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*11)]                 EOL\
  UMAAL S_RST1, S_RST2, S_OP_A0, S_OP_D3   EOL\
  UMAAL S_RST1, S_RST3, S_OP_A1, S_OP_D2   EOL\
  ADCS S_RST1, S_RST1, S_TMP				EOL\
  STR S_RST1, [R_PNT, CV(4*R_OFF + 4*11)]               EOL\
  LDR S_OP_D1, [R_PNT, CV(4*R_OFF + 4*12)]                 EOL\
  UMAAL S_OP_D1, S_RST2, S_OP_A1, S_OP_D3   EOL\
  UMAAL S_OP_D1, S_RST3, S_OP_A2, S_OP_A2   EOL\
  ADCS S_OP_D1, S_OP_D1, CV(0)			   EOL\
  STR S_OP_D1, [R_PNT, CV(4*R_OFF + 4*12)]               EOL\
  AND S_OP_D3, CV(0XFFFFFFFE)              EOL\
  LDR S_OP_D0, [A_PNT, CV(4*A_OFF + 4*7)]               EOL\
  EOR S_RST0, S_RST0                       EOL\
  UMAAL S_RST2, S_RST3, S_OP_A2, S_OP_D3   EOL\
  UMAAL S_RST0, S_RST3, S_OP_D0, S_OP_D0   EOL\
  LDR S_OP_A0, [R_PNT, CV(4*R_OFF + 4*13)]                 EOL\
  LDR S_OP_A1, [R_PNT, CV(4*R_OFF + 4*14)]                 EOL\
  LDR S_OP_A2, [R_PNT, CV(4*R_OFF + 4*15)]                 EOL\
  ADCS S_RST2, S_RST2, S_OP_A0		EOL\
  ADCS S_RST0, S_RST0, S_OP_A1		EOL\
  ADCS S_RST3, S_RST3, S_OP_A2		EOL\
  STR S_RST2, [R_PNT, CV(4*R_OFF + 4*13)]               EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*14)]               EOL\
  STR S_RST3, [R_PNT, CV(4*R_OFF + 4*15)]               EOL\

#define SQR_BACK(R_PNT, R_OFF, A_PNT, A_OFF, B_OFF)\
  LDR S_OP_A0, [A_PNT, CV(4*A_OFF + 4*0)]               EOL\
  LDR S_OP_A1, [A_PNT, CV(4*A_OFF + 4*1)]               EOL\
  LDR S_OP_A2, [A_PNT, CV(4*A_OFF + 4*2)]               EOL\
  LDR S_OP_A3, [A_PNT, CV(4*A_OFF + 4*3)]               EOL\
  LDR S_OP_D0, [A_PNT, CV(4*A_OFF + 4*4)]               EOL\
  LDR S_RST3,  [A_PNT, CV(4*A_OFF + 4*5)]               EOL\
  ADD S_RST0, SP, CV(4*48)					EOL\
  LDR S_OP_D1, [S_RST0, CV(4*B_OFF + 4*1)]               EOL\
  LDR S_OP_D2, [S_RST0, CV(4*B_OFF + 4*2)]               EOL\
  LDR S_OP_D3, [S_RST0, CV(4*B_OFF + 4*3)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*0)]                  EOL\
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
  ADD S_RST0, SP, CV(4*48)					EOL\
  LDR S_OP_D0, [S_RST0, CV(4*B_OFF + 4*4)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*4)]                 EOL\
  EOR S_RST0, S_RST0                       EOL\
  UMAAL S_TMP, S_RST0, S_OP_A0, S_OP_D0   EOL\
  UMAAL S_TMP, S_RST1, S_OP_A1, S_OP_D3   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A2, S_OP_A2   EOL\
  ADCS S_TMP, S_TMP, CV(0)				EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*4)]                EOL\
  ADD S_TMP, SP, CV(4*48)					EOL\
  LDR S_OP_D1, [S_TMP, CV(4*B_OFF + 4*5)]               EOL\
  AND S_OP_D3, CV(0XFFFFFFFE)             EOL\
  LDR S_RST3, [R_PNT, CV(4*R_OFF + 4*5)]                 EOL\
  UMAAL S_RST0, S_RST1, S_OP_A0, S_OP_D1   EOL\
  UMAAL S_RST0, S_RST2, S_OP_A1, S_OP_D0   EOL\
  UMAAL S_RST3, S_RST0, S_OP_A2, S_OP_D3   EOL\
  ADCS S_RST3, S_RST3, CV(0)				EOL\
  STR S_RST3, [R_PNT, CV(4*R_OFF + 4*5)]                EOL\
  ADD S_RST3, SP, CV(4*48)					EOL\
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
  ADD S_TMP, SP, CV(4*48)					EOL\
  LDR S_OP_D3, [S_TMP, CV(4*B_OFF + 4*7)]               EOL\
  LDR S_TMP, [R_PNT, CV(4*R_OFF + 4*7)]                 EOL\
  UMAAL S_TMP, S_RST3, S_OP_A3, S_OP_D0   EOL\
  UMAAL S_TMP, S_RST1, S_OP_A2, S_OP_D1   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A1, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST0, S_OP_A0, S_OP_D3   EOL\
  ADCS S_TMP, S_TMP, CV(0)				  EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*7)]                EOL\
  LDR S_OP_A0, [A_PNT, CV(4*A_OFF + 4*4)]               EOL\
  EOR S_TMP, S_TMP                       EOL\
  UMAAL S_TMP, S_RST0, S_OP_A1, S_OP_D3   EOL\
  UMAAL S_TMP, S_RST1, S_OP_A2, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A3, S_OP_D1   EOL\
  UMAAL S_TMP, S_RST3, S_OP_A0, S_OP_A0   EOL\
  ADCS S_TMP, S_TMP, CV(0)				EOL\
  AND S_OP_D1, CV(0XFFFFFFFE)             EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*8)]                EOL\
  UMAAL S_RST0, S_RST1, S_OP_A2, S_OP_D3  EOL\
  UMAAL S_RST0, S_RST2, S_OP_A3, S_OP_D2  EOL\
  UMAAL S_RST0, S_RST3, S_OP_A0, S_OP_D1  EOL\
  ADCS S_RST0, S_RST0, CV(0)				EOL\
  LDR S_OP_A1, [A_PNT, CV(4*A_OFF + 4*5)]              EOL\
  LDR S_OP_A2, [A_PNT, CV(4*A_OFF + 4*6)]              EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*9)]               EOL\
  EOR S_TMP, S_TMP                       EOL\
  UMAAL S_TMP, S_RST1, S_OP_A3, S_OP_D3   EOL\
  UMAAL S_TMP, S_RST2, S_OP_A0, S_OP_D2   EOL\
  UMAAL S_TMP, S_RST3, S_OP_A1, S_OP_A1   EOL\
  ADCS S_TMP, S_TMP, CV(0)				EOL\
  STR S_TMP, [R_PNT, CV(4*R_OFF + 4*10)]               EOL\
  AND S_OP_D2, CV(0XFFFFFFFE)             EOL\
  UMAAL S_RST1, S_RST2, S_OP_A0, S_OP_D3   EOL\
  UMAAL S_RST1, S_RST3, S_OP_A1, S_OP_D2   EOL\
  ADCS S_RST1, S_RST1, CV(0)				EOL\
  STR S_RST1, [R_PNT, CV(4*R_OFF + 4*11)]               EOL\
  EOR S_OP_D1, S_OP_D1                       EOL\
  UMAAL S_OP_D1, S_RST2, S_OP_A1, S_OP_D3   EOL\
  UMAAL S_OP_D1, S_RST3, S_OP_A2, S_OP_A2   EOL\
  ADCS S_OP_D1, S_OP_D1, CV(0)			  EOL\
  STR S_OP_D1, [R_PNT, CV(4*R_OFF + 4*12)]               EOL\
  AND S_OP_D3, CV(0XFFFFFFFE)             EOL\
  LDR S_OP_D0, [A_PNT, CV(4*A_OFF + 4*7)]               EOL\
  EOR S_RST0, S_RST0                       EOL\
  UMAAL S_RST2, S_RST3, S_OP_A2, S_OP_D3   EOL\
  UMAAL S_RST0, S_RST3, S_OP_D0, S_OP_D0   EOL\
  ADCS S_RST2, S_RST2, CV(0)		EOL\
  ADCS S_RST0, S_RST0, CV(0)		EOL\
  ADCS S_RST3, S_RST3, CV(0)		EOL\
  STR S_RST2, [R_PNT, CV(4*R_OFF + 4*13)]               EOL\
  STR S_RST0, [R_PNT, CV(4*R_OFF + 4*14)]               EOL\
  STR S_RST3, [R_PNT, CV(4*R_OFF + 4*15)]               EOL\

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
  LDR PS_OP_A3, [R0, CV(4*7)]               EOL\
  ADDS PS_OP_A3, PS_OP_A3, PS_OP_A3           EOL\
  LDR PS_OP_B0, [R0, CV(4*8)]               EOL\
  LDR PS_OP_B1, [R0, CV(4*9)]               EOL\
  LDR PS_OP_B2, [R0, CV(4*10)]               EOL\
  LDR PS_OP_B3, [R0, CV(4*11)]               EOL\
  LDR PS_OP_A0, [R0, CV(4*12)]               EOL\
  LDR PS_OP_A1, [R0, CV(4*13)]               EOL\
  LDR PS_OP_A2, [R0, CV(4*14)]               EOL\
  LDR PS_OP_A3, [R0, CV(4*15)]               EOL\
  ADCS PS_OP_B0, PS_OP_B0, PS_OP_B0           EOL\
  ADCS PS_OP_B1, PS_OP_B1, PS_OP_B1           EOL\
  ADCS PS_OP_B2, PS_OP_B2, PS_OP_B2           EOL\
  ADCS PS_OP_B3, PS_OP_B3, PS_OP_B3           EOL\
  ADCS PS_OP_A0, PS_OP_A0, PS_OP_A0           EOL\
  ADCS PS_OP_A1, PS_OP_A1, PS_OP_A1           EOL\
  ADCS PS_OP_A2, PS_OP_A2, PS_OP_A2           EOL\
  ADCS PS_OP_A3, PS_OP_A3, PS_OP_A3           EOL\
  STR PS_OP_B0, [SP, CV(4*OFFSET+4*8)]                EOL\
  STR PS_OP_B1, [SP, CV(4*OFFSET+4*9)]                EOL\
  STR PS_OP_B2, [SP, CV(4*OFFSET+4*10)]               EOL\
  STR PS_OP_B3, [SP, CV(4*OFFSET+4*11)]               EOL\
  STR PS_OP_A0, [SP, CV(4*OFFSET+4*12)]               EOL\
  STR PS_OP_A1, [SP, CV(4*OFFSET+4*13)]               EOL\
  STR PS_OP_A2, [SP, CV(4*OFFSET+4*14)]               EOL\
  STR PS_OP_A3, [SP, CV(4*OFFSET+4*15)]               EOL\
  LDR PS_OP_B0, [R0, CV(4*16)]               EOL\
  LDR PS_OP_B1, [R0, CV(4*17)]               EOL\
  LDR PS_OP_B2, [R0, CV(4*18)]               EOL\
  LDR PS_OP_B3, [R0, CV(4*19)]               EOL\
  LDR PS_OP_A0, [R0, CV(4*20)]               EOL\
  LDR PS_OP_A1, [R0, CV(4*21)]               EOL\
  LDR PS_OP_A2, [R0, CV(4*22)]               EOL\
  LDR PS_OP_A3, [R0, CV(4*23)]               EOL\
  ADCS PS_OP_B0, PS_OP_B0, PS_OP_B0           EOL\
  ADCS PS_OP_B1, PS_OP_B1, PS_OP_B1           EOL\
  ADCS PS_OP_B2, PS_OP_B2, PS_OP_B2           EOL\
  ADCS PS_OP_B3, PS_OP_B3, PS_OP_B3           EOL\
  ADCS PS_OP_A0, PS_OP_A0, PS_OP_A0           EOL\
  ADCS PS_OP_A1, PS_OP_A1, PS_OP_A1           EOL\
  ADCS PS_OP_A2, PS_OP_A2, PS_OP_A2           EOL\
  ADCS PS_OP_A3, PS_OP_A3, PS_OP_A3           EOL\
  STR PS_OP_B0, [SP, CV(4*OFFSET+4*16)]                EOL\
  STR PS_OP_B1, [SP, CV(4*OFFSET+4*17)]                EOL\
  STR PS_OP_B2, [SP, CV(4*OFFSET+4*18)]               EOL\
  STR PS_OP_B3, [SP, CV(4*OFFSET+4*19)]               EOL\
  STR PS_OP_A0, [SP, CV(4*OFFSET+4*20)]               EOL\
  STR PS_OP_A1, [SP, CV(4*OFFSET+4*21)]               EOL\
  STR PS_OP_A2, [SP, CV(4*OFFSET+4*22)]               EOL\
  STR PS_OP_A3, [SP, CV(4*OFFSET+4*23)]               EOL\

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

#define PS_MUL_BACK(R_OUT, OFFSET) \
    UMAAL PS_RST0, PS_RST1, PS_OP_A3, PS_OP_B1        EOL\
    UMAAL PS_RST0, PS_RST2, PS_OP_A2, PS_OP_B2        EOL\
    UMAAL PS_RST0, PS_RST3, PS_OP_A1, PS_OP_B3        EOL\
    STR PS_RST0, [R_OUT, CV(4*OFFSET + 0)]   EOL\
    UMAAL PS_RST1, PS_RST2, PS_OP_A3, PS_OP_B2        EOL\
    UMAAL PS_RST1, PS_RST3, PS_OP_A2, PS_OP_B3        EOL\
    STR PS_RST1, [R_OUT, CV(4*OFFSET + 4)]   EOL\
    UMAAL PS_RST2, PS_RST3, PS_OP_A3, PS_OP_B3        EOL\
    STR PS_RST2, [R_OUT, CV(4*OFFSET + 8)]   EOL\
    STR PS_RST3, [R_OUT, CV(4*OFFSET + 12)]  EOL\

#define PS_MUL_MID_OP_B(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR PS_OP_B0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    UMAAL PS_RST3,  PS_RST0, PS_OP_A3, PS_OP_B1        EOL\
    UMAAL PS_RST3,  PS_RST1, PS_OP_A2, PS_OP_B2        EOL\
    UMAAL PS_RST3,  PS_RST2, PS_OP_A1, PS_OP_B3        EOL\
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
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B3       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B0       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B1       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B2        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR PS_OP_B3, [OP_P, CV(4*P_OFF + 12)]   EOL\
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B0       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B2       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B3        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]	EOL\

#define PS_MUL_MID_OP_B_NO_RESULT(R_OUT, R_OFF, OP_P, P_OFF) \
    EOR PS_TMP, PS_TMP EOL\
    LDR PS_OP_B0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    UMAAL PS_RST3,  PS_RST0, PS_OP_A3, PS_OP_B1        EOL\
    UMAAL PS_RST3,  PS_RST1, PS_OP_A2, PS_OP_B2        EOL\
    UMAAL PS_RST3,  PS_RST2, PS_OP_A1, PS_OP_B3        EOL\
    UMAAL PS_TMP,  PS_RST3, PS_OP_A0, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR PS_OP_B1, [OP_P, CV(4*P_OFF + 4)]    EOL\
    EOR PS_TMP, PS_TMP EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B3       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B0       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B1        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    LDR PS_OP_B2, [OP_P, CV(4*P_OFF + 8)]    EOL\
    EOR PS_TMP, PS_TMP EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B3       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B0       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B1       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B2        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR PS_OP_B3, [OP_P, CV(4*P_OFF + 12)]   EOL\
    EOR PS_TMP, PS_TMP EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B0       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B2       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B3        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\

#define PS_MUL_MID_OP_B(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR PS_OP_B0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    UMAAL PS_RST3,  PS_RST0, PS_OP_A3, PS_OP_B1        EOL\
    UMAAL PS_RST3,  PS_RST1, PS_OP_A2, PS_OP_B2        EOL\
    UMAAL PS_RST3,  PS_RST2, PS_OP_A1, PS_OP_B3        EOL\
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
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B3       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B0       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B1       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B2        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR PS_OP_B3, [OP_P, CV(4*P_OFF + 12)]   EOL\
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B0       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B2       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B3        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\

#define PS_MUL_MID_OP_B_DOUBLING(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR PS_OP_B0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    UMAAL PS_RST3,  PS_RST0, PS_OP_A3, PS_OP_B1        EOL\
    UMAAL PS_RST3,  PS_RST1, PS_OP_A2, PS_OP_B2        EOL\
    UMAAL PS_RST3,  PS_RST2, PS_OP_A1, PS_OP_B3        EOL\
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
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B3       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B0       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B1       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B2        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR PS_OP_B3, [OP_P, CV(4*P_OFF + 12)]   EOL\
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
	AND PS_OP_A0, CV(0XFFFFFFFE)             EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B0       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B2       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B3        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\

#define PS_MUL_MID_OP_A(R_OUT, R_OFF, OP_P, P_OFF) \
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR PS_OP_A0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR PS_OP_A1, [OP_P, CV(4*P_OFF + 4)]    EOL\
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A0, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A3, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A2, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A1, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    LDR PS_OP_A2, [OP_P, CV(4*P_OFF + 8)]    EOL\
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A1, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A0, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A3, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A2, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR PS_OP_A3, [OP_P, CV(4*P_OFF + 12)]   EOL\
    LDR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A2, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A1, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A0, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A3, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\

#define PS_MUL_MID_OP_A_NO_RESULT(R_OUT, R_OFF, OP_P, P_OFF) \
    EOR PS_TMP, PS_TMP EOL\
    LDR PS_OP_A0, [OP_P, CV(4*P_OFF + 0)]    EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A3, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A2, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A1, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A0, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 0)]     EOL\
    LDR PS_OP_A1, [OP_P, CV(4*P_OFF + 4)]    EOL\
    EOR PS_TMP, PS_TMP EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A0, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A3, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A2, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A1, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 4)]     EOL\
    LDR PS_OP_A2, [OP_P, CV(4*P_OFF + 8)]    EOL\
    EOR PS_TMP, PS_TMP EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A1, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A0, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A3, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A2, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 8)]     EOL\
    LDR PS_OP_A3, [OP_P, CV(4*P_OFF + 12)]   EOL\
    EOR PS_TMP, PS_TMP EOL\
    UMAAL PS_RST0,  PS_RST1, PS_OP_A2, PS_OP_B1       EOL\
    UMAAL PS_RST0,  PS_RST2, PS_OP_A1, PS_OP_B2       EOL\
    UMAAL PS_RST0,  PS_RST3, PS_OP_A0, PS_OP_B3       EOL\
    UMAAL PS_TMP,  PS_RST0, PS_OP_A3, PS_OP_B0        EOL\
    STR PS_TMP, [R_OUT, CV(4*R_OFF + 12)]    EOL\


void __attribute__ ((naked)) fpsqr_mont(const felm_t ma, felm_t mc)
{ // Multiprecision squaring, c = a^2 mod p.
asm volatile(\
STRFY(SQR_PROLOG)
"SUB SP, #4*72 		\n\t"//48 result + 24 operands


STRFY(PS_DOUBLING(48))

//ROUND#1
"MOV R1, R0 		\n\t"
"ADD R0, SP, #4*48 	\n\t"
STRFY(PS_LOAD(R0, PS_OP_A0, PS_OP_A1, PS_OP_A2, PS_OP_A3, 12))
STRFY(PS_LOAD(R1, PS_OP_B0, PS_OP_B1, PS_OP_B2, PS_OP_B3, 0))
STRFY(PS_MUL_FRONT(SP, 12))

"ADD R0, SP, #4*48 	\n\t"
STRFY(PS_MUL_MID_OP_A_NO_RESULT(SP, 16, R0, 16))
STRFY(PS_MUL_MID_OP_A_NO_RESULT(SP, 20, R0, 20))
"LDR R0, [SP, #4 * 72] \n\t"
STRFY(PS_MUL_MID_OP_B_NO_RESULT(SP, 24, R0, 4))
STRFY(PS_MUL_MID_OP_B_NO_RESULT(SP, 28, R0, 8))
STRFY(PS_MUL_BACK(SP, 32))

//ROUND#2
"ADD R0, SP, #4*48 	\n\t"
STRFY(PS_LOAD(R0, PS_OP_A0, PS_OP_A1, PS_OP_A2, PS_OP_A3, 8))
"LDR R0, [SP, #4 * 72] \n\t"
STRFY(PS_LOAD(R0, PS_OP_B0, PS_OP_B1, PS_OP_B2, PS_OP_B3, 0))

STRFY(PS_MUL_FRONT(SP, 8))
STRFY(PS_MUL_MID_OP_B_DOUBLING(SP, 12, R0, 4))
"ADD R0, SP, #4*48 	\n\t"
STRFY(PS_MUL_MID_OP_A(SP, 16, R0, 12))
STRFY(PS_MUL_MID_OP_A(SP, 20, R0, 16))

"LDR R0, [SP, #4 * 72] \n\t"
STRFY(PS_MUL_MID_OP_B(SP, 24, R0, 8))
STRFY(PS_MUL_MID_OP_B_DOUBLING(SP, 28, R0, 12))

"ADD R0, SP, #4*48 	\n\t"
STRFY(PS_MUL_MID_OP_A(SP, 32, R0, 20))
STRFY(PS_MUL_BACK(SP, 36))


//SQR
"LDR R0, [SP, #4 * 72] \n\t"
STRFY(SQR_FRONT(SP, 0, R0, 0))
STRFY(SQR_MID(SP, 16, R0, 8, 8))
STRFY(SQR_BACK(SP, 32, R0, 16, 16))

"MOV R1, #0			   \n\t"//CARRY
"ADDS R1, R1, R1	\n\t"
"LDR R0, [SP, #4 * 73] \n\t"//RESULT POINTER

//ROUND#1
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 0))
STRFY(P_RED_FRONT(SP, SP, 11, 11))
STRFY(P_RED_MID(SP, 15))

//ROUND#2
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 4))
STRFY(P_RED_FRONT(SP, SP, 15, 15))
STRFY(P_RED_MID(SP, 19))

//ROUND#3
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 8))
STRFY(P_RED_FRONT(SP, SP, 19, 19))
STRFY(P_RED_MID(SP, 23))

//ROUND#4
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 12))
STRFY(P_RED_FRONT2(R0, SP, 0, 23))
STRFY(P_RED_MID(SP, 27))

//ROUND#5
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 16))
STRFY(P_RED_FRONT(R0, SP, 3, 27))
STRFY(P_RED_MID(SP, 31))

//ROUND#6
STRFY(P_LOAD_M)
STRFY(P_LOAD_Q(SP, P_OP_Q0, P_OP_Q1, P_OP_Q2, P_OP_Q3, 20))
STRFY(P_RED_FRONT(R0, SP, 7, 31))
STRFY(P_RED_MID2(R0, SP, 11,  35))

"ADD SP, #4*74 		\n\t"
STRFY(SQR_EPILOG)
  :
  :
  : "cc", "memory"
);
}


void fpinv_mont(felm_t a)
{ // Field inversion using Montgomery arithmetic, a = a^(-1)*R mod p.
    felm_t tt;

    fpcopy(a, tt);
    fpinv_chain_mont(tt);
    fpsqr_mont(tt, tt);
    fpsqr_mont(tt, tt);
    fpmul_mont(a, tt, a);
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


void __attribute__ ((noinline, naked)) mp_addfast(const digit_t* a, const digit_t* b, digit_t* c)
{ // Multiprecision addition, c = a+b.

    	asm(

			"push  {r4-r11,lr}			\n\t"


			"ldmia r0!, {r4-r7} 			\n\t"
			"ldmia r1!, {r8-r11} 			\n\t"

			"adds r4, r4, r8				\n\t"
			"adcs r5, r5, r9				\n\t"
			"adcs r6, r6, r10				\n\t"
			"adcs r7, r7, r11				\n\t"

			"stmia r2!, {r4-r7} 			\n\t"

			"ldmia r0!, {r4-r7} 			\n\t"
			"ldmia r1!, {r8-r11} 			\n\t"

			"adcs r4, r4, r8				\n\t"
			"adcs r5, r5, r9				\n\t"
			"adcs r6, r6, r10				\n\t"
			"adcs r7, r7, r11				\n\t"

			"stmia r2!, {r4-r7} 			\n\t"

			"ldmia r0!, {r4-r7} 			\n\t"
			"ldmia r1!, {r8-r11} 			\n\t"

			"adcs r4, r4, r8				\n\t"
			"adcs r5, r5, r9				\n\t"
			"adcs r6, r6, r10				\n\t"
			"adcs r7, r7, r11				\n\t"

			"stmia r2!, {r4-r7} 			\n\t"

			"ldmia r0!, {r4-r7} 			\n\t"
			"ldmia r1!, {r8-r11} 			\n\t"

			"adcs r4, r4, r8				\n\t"
			"adcs r5, r5, r9				\n\t"
			"adcs r6, r6, r10				\n\t"
			"adcs r7, r7, r11				\n\t"

			"stmia r2!, {r4-r7} 			\n\t"

			"ldmia r0!, {r4-r7} 			\n\t"
			"ldmia r1!, {r8-r11} 			\n\t"

			"adcs r4, r4, r8				\n\t"
			"adcs r5, r5, r9				\n\t"
			"adcs r6, r6, r10				\n\t"
			"adcs r7, r7, r11				\n\t"

			"stmia r2!, {r4-r7} 			\n\t"


			"ldmia r0!, {r4-r7} 			\n\t"
			"ldmia r1!, {r8-r11} 			\n\t"


			"adcs r4, r4, r8				\n\t"
			"adcs r5, r5, r9				\n\t"
			"adcs r6, r6, r10				\n\t"
			"adcs r7, r7, r11				\n\t"

			"stmia r2!, {r4-r7} 			\n\t"

			"pop  {r4-r11,pc}				\n\t"
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
//MUL768(ma, ma, temp_2);

static unsigned int tt1_2[48+4]={0,};
static unsigned int tt2_2[48+4]={0,};
static unsigned int tt3_2[48+4]={0,};

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
{ // Chain to compute a^(p-3)/4 using Montgomery arithmetic.
    unsigned int i, j;
    felm_t t[27], tt;

    // Precomputed table
    fpsqr_mont(a, tt);
    fpmul_mont(a, tt, t[0]);
    fpmul_mont(t[0], tt, t[1]);
    fpmul_mont(t[1], tt, t[2]);
    fpmul_mont(t[2], tt, t[3]);
    fpmul_mont(t[3], tt, t[3]);
    for (i = 3; i <= 8; i++) fpmul_mont(t[i], tt, t[i+1]);
    fpmul_mont(t[9], tt, t[9]);
    for (i = 9; i <= 20; i++) fpmul_mont(t[i], tt, t[i+1]);
    fpmul_mont(t[21], tt, t[21]);
    for (i = 21; i <= 24; i++) fpmul_mont(t[i], tt, t[i+1]);
    fpmul_mont(t[25], tt, t[25]);
    fpmul_mont(t[25], tt, t[26]);

    fpcopy(a, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[20], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[24], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[11], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[8], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[2], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[23], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[2], tt, tt);
    for (i = 0; i < 9; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[2], tt, tt);
    for (i = 0; i < 10; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[15], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[13], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[26], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[20], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[11], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[10], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[14], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[4], tt, tt);
    for (i = 0; i < 10; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[18], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[1], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[22], tt, tt);
    for (i = 0; i < 10; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[6], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[24], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[9], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[18], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[17], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(a, tt, tt);
    for (i = 0; i < 10; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[16], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[7], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[0], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[12], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[19], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[22], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[25], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[2], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[10], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[22], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[18], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[4], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[14], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[13], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[5], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[23], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[21], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[2], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[23], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[12], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[9], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[3], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[13], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[17], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[26], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[5], tt, tt);
    for (i = 0; i < 8; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[8], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[2], tt, tt);
    for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[11], tt, tt);
    for (i = 0; i < 7; i++) fpsqr_mont(tt, tt);
    fpmul_mont(t[20], tt, tt);
    for (j = 0; j < 61; j++) {
        for (i = 0; i < 6; i++) fpsqr_mont(tt, tt);
        fpmul_mont(t[26], tt, tt);
    }
    fpcopy(tt, a);
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


__inline unsigned int mp_add(const digit_t* a, const digit_t* b, digit_t* c, const unsigned int nwords)
{ // Multiprecision addition, c = a+b, where lng(a) = lng(b) = nwords. Returns the carry bit.
    unsigned int i, carry = 0;

    for (i = 0; i < nwords; i++) {
        ADDC(carry, a[i], b[i], carry, c[i]);
    }

    return carry;
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
