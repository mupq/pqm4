#ifndef POLYMUL
#define POLYMUL

#include "int8.h"
#include "int16.h"
#include "int32.h"
#include "uint16.h"
#include "uint32.h"


extern void gf_polymul_768x768_mod3(int8 *h, int8 *c, int8 *f);
extern int Rq_recip3_jumpdivsteps(int16 *h, int8 *c);
extern int R3_recip_jumpdivsteps(int8* H, int8* G);
extern void Rq_redp(int16 *h, const int16 *f);
extern void Rq_mult3_asm(int16 *h, const int16 *f);
extern void Rq_mov(int16 *h, const int16 *f);
extern void Rq_fromR3(int16 *h, const int8 *f);
extern int Weightw_mask_asm(int8 *ev);
extern void copy_p_F3_mod3(const int8 *f, int8 *fp, const int8 *g, int8 *gp);
extern void reduce_2p_minus1_mod3_F3(int8 *h, int8 *fg);
extern void Short_fromlist_asm(int8 *out,const uint32 *in);


#if defined(MIXED1)
#define PARAMS_M 1530
void fft17(int16*f, int16* fpad);
void ntt17_rader(int16* f, int16* fpad);
void ntt17_rader_byte(int8* g, int16* gpad);
void byteToShort(int16* gg, int8* g);
void fft9(int16* fpad);
void polymul_10x10_153_mr(int16* fpad, int16* gpad);
void ifft9(int16* fpad);
void ifft17_mr(int16* fpad, int16* h);
void intt17_rader_mr(int16* fpad, int16* h);
void mod_reduce(int16* h, int16* hpad);
#elif defined(MIXED)
#include "ntt1620.h"
#include "consts_asm_1620.h"
#elif defined(GOODS)
#include "ntt1536.h"
#include "consts_asm_1536.h"
#endif

#endif
