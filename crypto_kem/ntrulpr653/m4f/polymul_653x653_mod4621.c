#include <stdint.h>

extern void ntt11_rader(int16_t* fpad, int16_t* f);
extern void byteToShort_653(int16_t* gg, int8_t* g);
extern void ntt12(int16_t* fpad);
extern void polymul_10x10_132_mr(int16_t* fpad, int16_t* gpad);
extern void intt12(int16_t* fpad);
extern void intt11_rader_mr(int16_t* fpad, int16_t* h);
extern void mod_reduce_653(int16_t* h, int16_t* hpad);
void polymul_653x653_mod4621(int16_t* h, int16_t* f, int8_t* g);
void polymul_653x653_mod4621(int16_t* h, int16_t* f, int8_t* g){
    int16_t fpad[1320], gpad[1320];
    int16_t gg[653];
    ntt11_rader(fpad, f);
    ntt12(fpad);
    byteToShort_653(gg, g);
    ntt11_rader(gpad, gg);
    ntt12(gpad);
    polymul_10x10_132_mr(fpad, gpad);
    intt12(fpad);
    intt11_rader_mr(gpad, fpad);
    mod_reduce_653(h, gpad);
}
