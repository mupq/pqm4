///  @file  sign.c
///  @brief the implementations for functions in api.h
///
///
#include <stdlib.h>
#include <string.h>

#include "rainbow_config.h"
#include "rainbow_keypair.h"
#include "rainbow.h"

#include "api.h"
#include "utils_hash.h"
#include "randombytes.h"




int
crypto_sign_keypair(unsigned char *pk, unsigned char *sk)
{
    unsigned char sk_seed[LEN_SKSEED] = {0};
    randombytes( sk_seed , LEN_SKSEED );

#if defined _RAINBOW_CLASSIC

    generate_keypair( (pk_t*) pk , (sk_t*) sk , sk_seed );

#elif defined _RAINBOW_CYCLIC

    unsigned char pk_seed[LEN_PKSEED] = {0};
    randombytes( pk_seed , LEN_PKSEED );
    generate_keypair_cyclic( (cpk_t*) pk , (sk_t*) sk , pk_seed , sk_seed );

#elif defined _RAINBOW_CYCLIC_COMPRESSED

    unsigned char pk_seed[LEN_PKSEED] = {0};
    randombytes( pk_seed , LEN_PKSEED );
    generate_compact_keypair_cyclic( (cpk_t*) pk , (csk_t*) sk , pk_seed , sk_seed );

#else
error here
#endif
    return 0;
}





int
crypto_sign(unsigned char *sm, size_t *smlen, const unsigned char *m, size_t mlen, const unsigned char *sk)
{
	unsigned char digest[_HASH_LEN];

	hash_msg( digest , _HASH_LEN , m , mlen );

	memcpy( sm , m , mlen );
	smlen[0] = mlen + _SIGNATURE_BYTE;

#if defined _RAINBOW_CLASSIC

	return rainbow_sign( sm + mlen , (const sk_t*)sk , digest );

#elif defined _RAINBOW_CYCLIC

	return rainbow_sign( sm + mlen , (const sk_t*)sk , digest );

#elif defined _RAINBOW_CYCLIC_COMPRESSED

	return rainbow_sign_cyclic( sm + mlen , (const csk_t*)sk , digest );

#else
error here
#endif


}






int
crypto_sign_open(unsigned char *m, size_t *mlen,const unsigned char *sm, size_t smlen,const unsigned char *pk)
{
	if( _SIGNATURE_BYTE > smlen ) return -1;
	memcpy( m , sm , smlen-_SIGNATURE_BYTE );
	mlen[0] = smlen-_SIGNATURE_BYTE;

	unsigned char digest[_HASH_LEN];
	hash_msg( digest , _HASH_LEN , m , *mlen );

#if defined _RAINBOW_CLASSIC

	return rainbow_verify( digest , sm + mlen[0] , (const pk_t *)pk );

#elif defined _RAINBOW_CYCLIC

	return rainbow_verify_cyclic( digest , sm + mlen[0] , (const cpk_t *)pk );

#elif defined _RAINBOW_CYCLIC_COMPRESSED

	return rainbow_verify_cyclic( digest , sm + mlen[0] , (const cpk_t *)pk );

#else
error here
#endif


}

