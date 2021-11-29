#include <inttypes.h>

extern int jump128divsteps_mod2(int minusdelta, uint32_t *M1, uint32_t *f, uint32_t *g);
int jump1664divsteps_mod2_128(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g);

extern void __update_fg_128x832_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_VS_128x128_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_128x256_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_128x384_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_128x512_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_128x640_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_128x768_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_128x832_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_128x864_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_fg_128x768_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_128x640_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_128x512_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_128x384_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_128x256_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_128x128_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);

int jump1664divsteps_mod2_128(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g){
	uint32_t V[108]={0};
	uint32_t S[108]={0};
	uint32_t M1[96]; // 128 coefficients * 6
	uint32_t *ptr = M;
	*(S) = 1;
	// 1: 6
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x832_mod2(f, g, M1+32);
	__update_VS_128x128_mod2(V, S, M1+32);
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x832_mod2(f, g, M1+32);
	__update_VS_128x128_mod2(V, S, M1+32);
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x832_mod2(f, g, M1+32);
	__update_VS_128x256_mod2(V, S, M1+32);
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x832_mod2(f, g, M1+32);
	__update_VS_128x384_mod2(V, S, M1+32);
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x832_mod2(f, g, M1+32);
	__update_VS_128x512_mod2(V, S, M1+32);
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x832_mod2(f, g, M1+32);
	__update_VS_128x640_mod2(V, S, M1+32);
	// 2
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x832_mod2(f, g, M1+32);
	__update_VS_128x768_mod2(V, S, M1+32);
	// 3
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x768_mod2(f, g, M1+32);
	__update_VS_128x832_mod2(V, S, M1+32);
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x640_mod2(f, g, M1+32);
	__update_VS_128x832_mod2(V, S, M1+32);
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x512_mod2(f, g, M1+32);
	__update_VS_128x832_mod2(V, S, M1+32);
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x384_mod2(f, g, M1+32);
	__update_VS_128x832_mod2(V, S, M1+32);
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x256_mod2(f, g, M1+32);
	__update_VS_128x832_mod2(V, S, M1+32);
	minusdelta = jump128divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_128x128_mod2(f, g, M1+32);
	__update_VS_128x864_mod2(V, S, M1+32);
	
	for (int i = 0; i < 108; i++)
	{
	    *ptr++ = V[i];
	}
	return minusdelta;
}
