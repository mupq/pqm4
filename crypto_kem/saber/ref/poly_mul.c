#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "poly_mul.h"

void pol_mul(uint16_t* a, uint16_t* b, uint16_t* res, uint16_t p, uint32_t n,uint32_t start)

{ 
	// Polynomial multiplication using the schoolbook method, c[x] = a[x]*b[x] 
	// SECURITY NOTE: TO BE USED FOR TESTING ONLY.  

	uint32_t i;
	uint32_t j,  mask = 2*n - 1;


//-------------------normal multiplication-----------------

	
	
	uint16_t c[2*SABER_N];
	for (i = 0; i < mask+1; i++) c[i] = 0;

	for (i = start; i < start+n; i++) {
		for (j = start; j < start+n; j++) {
			c[i+j-2*start]=( c[i+j-2*start] + (a[i] * b[j]) )&(p-1);
		}
	}

	//---------------reduction-------
	for(i=n;i<2*n-1;i++){
		c[i-n]=(c[i-n]-c[i])&(p-1);
	}
	
	c[n]=0; //256th coefficient=0;
//----------------------copy result back----------------

	for(i=0; i<n; i++){
            res[i] = c[i];
	}
		

}

