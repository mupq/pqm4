#ifndef PARAMS_H
#define PARAMS_H

// this is a temporary workaround because llrint (libm) is broken in newlib
// We've fixed this in https://www.sourceware.org/ml/newlib/2018/msg00358.html, 
// but it may take a while until it is actually in the ARM toolchain 

//TODO remove once llrint was fixed in the ARM toolchain
#define llrint llrint_fixed

#define PARAM_N 1024
#define PARAM_N_LOG 10
#define PARAM_SIGMA 8.5
#define PARAM_Q 8058881
#define PARAM_Q_LOG 23
#define PARAM_B 1048575
#define PARAM_B_BITS 20

#define PARAM_K 1
#define PARAM_SIGMA_E PARAM_SIGMA

#define PARAM_W 36
#define PARAM_D 21
	
#define PARAM_KEYGEN_BOUND_E 798 
#define PARAM_REJECTION PARAM_KEYGEN_BOUND_E
#define PARAM_KEYGEN_BOUND_S 758
#define PARAM_U PARAM_KEYGEN_BOUND_S

#endif
