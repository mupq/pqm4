#include <stdint.h>
#include "red_mod3_int.h"
#include "cmsis.h"

extern void gf_polymul_256x256_mod3(void *h, void *f, void *g);
void gf_polymul_256x512_mod3(int *h, int *f, int *g);

void gf_polymul_256x512_mod3(int *h, int *f, int *g){
    int i, T, *start, *H_local;
    int h_tmp[128];
    gf_polymul_256x256_mod3(h,f,g);
    gf_polymul_256x256_mod3(h_tmp,f,g+64);
    start = h + 64;
    H_local = h_tmp;
    for(i = 0; i < 64; ++i){
        T = add_ub3(*start, *(H_local++));
        *(start++) = T;
    }
    for(i = 0; i < 64; ++i) *(start++) = *(H_local++);
}