#include <inttypes.h>

extern int jump64divsteps_mod3(int minusdelta, uint32_t *M1, uint32_t *f, uint32_t *g);
int jump1408divsteps_mod3_64(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g);

extern void __update_fg_64x704(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_VS_64x64(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x128(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x192(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x256(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x320(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x384(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x448(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x512(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x576(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x640(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x704(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x720(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_fg_64x640(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x576(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x512(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x448(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x384(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x320(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x256(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x192(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x128(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x64(uint32_t *f, uint32_t *g, uint32_t *M1);

int jump1408divsteps_mod3_64(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g){
	uint32_t V[180];
	uint32_t S[180];
	uint32_t M1[96]; // 64 coefficients * 6
	uint32_t *ptr = M;
	for(int i = 0; i < 180; i++){
	    V[i] = 0;
	    S[i] = 0;
	}
	*(S) = 1;
	// 1: 11
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x64(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x64(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x128(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x192(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x256(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x320(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x384(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x448(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x512(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x576(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x640(V, S, M1+32);
	// 2
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x704(f, g, M1+32);
	__update_VS_64x704(V, S, M1+32);
	// 3
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x640(f, g, M1+32);
	__update_VS_64x704(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x576(f, g, M1+32);
	__update_VS_64x704(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x512(f, g, M1+32);
	__update_VS_64x704(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x448(f, g, M1+32);
	__update_VS_64x704(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x384(f, g, M1+32);
	__update_VS_64x704(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x320(f, g, M1+32);
	__update_VS_64x704(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x256(f, g, M1+32);
	__update_VS_64x704(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x192(f, g, M1+32);
	__update_VS_64x704(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x128(f, g, M1+32);
	__update_VS_64x704(V, S, M1+32);
	minusdelta = jump64divsteps_mod3(minusdelta,M1,f,g);
	__update_fg_64x64(f, g, M1+32);
	__update_VS_64x720(V, S, M1+32);
	

	for (int i = 0; i < 180; i++)
	{
	    *ptr++ = V[i];
	}
	return minusdelta;
}
