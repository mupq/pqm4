#include <stdint.h>

extern void Good17x9_Rader17(int16_t* fpad, const int16_t* f);
extern void ntt9_rader(int16_t* fpad);
extern void byteToShort_761(int16_t* gg, const int8_t* g);
extern void polymul_10x10_153_mr(int16_t* fpad, int16_t* gpad);
extern void intt9_rader(int16_t* fpad);
extern void iRader17_iGood17x9(int16_t* hpad, int16_t* fpad);
extern void mod_reduce_761(int16_t* h, int16_t* hpad);
void polymul_761x761_mod4591(int16_t* h, const int16_t* f, const int8_t* g);
// input  : int16_t f[761], int8_t g[761]
// output  : int16_t h[761]
// h = f * g mod x^761 -x -1 mod 4591
void polymul_761x761_mod4591(int16_t* h, const int16_t* f, const int8_t* g){
    int16_t fpad[1530], gpad[1530];
    int16_t gg[761];
    Good17x9_Rader17(fpad, f);
	ntt9_rader(fpad);
	byteToShort_761(gg, g);
	Good17x9_Rader17(gpad, gg);
	ntt9_rader(gpad);
	polymul_10x10_153_mr(fpad, gpad);
	intt9_rader(fpad);
	iRader17_iGood17x9(gpad, fpad);
	mod_reduce_761(h, gpad);
}
