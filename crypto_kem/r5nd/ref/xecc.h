//  xecc.h
//  2018-06-15  Markku-Juhani O. Saarinen <mjos@iki.fi>

#ifndef _XECC_H_
#define _XECC_H_

// Add error correction to (payload | xe). On first round, zeroize xe.
void xe_compute(void *block);

// fix errors on block (payload | xe)
void xe_fixerr(void *block);

#endif /* _XECC_H_ */
