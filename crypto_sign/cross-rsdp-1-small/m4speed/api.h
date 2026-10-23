/**
 *
 * Reference ISO-C11 Implementation of CROSS.
 *
 * @version 2.2 (July 2025)
 *
 * Authors listed in alphabetical order:
 * 
 * @author: Alessandro Barenghi <alessandro.barenghi@polimi.it>
 * @author: Marco Gianvecchio <marco.gianvecchio@mail.polimi.it>
 * @author: Patrick Karl <patrick.karl@tum.de>
 * @author: Gerardo Pelosi <gerardo.pelosi@polimi.it>
 * @author: Jonas Schupp <jonas.schupp@tum.de>
 * 
 * 
 * This code is hereby placed in the public domain.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS ''AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 **/


#pragma once

#include "CROSS.h"
#include "parameters.h"

#define CRYPTO_ALGNAME "CROSS"

/*  no. of bytes of the secret key */
#define CRYPTO_SECRETKEYBYTES (sizeof(sk_t))

/*  no. of bytes of the public key */
#define CRYPTO_PUBLICKEYBYTES (sizeof(pk_t))

/* no. of bytes of overhead in a signed message */
#define CRYPTO_BYTES (sizeof(CROSS_sig_t))

/* required bytes of input randomness */
#define  CRYPTO_RANDOMBYTES (SEED_LENGTH_BYTES) //CROSS library -  parameters.h


int crypto_sign_keypair(unsigned char *pk,
                        unsigned char *sk
                       );

int crypto_sign(unsigned char *sm,
                size_t *smlen,
                const unsigned char *m,
                size_t mlen,
                const unsigned char *sk
               );

int crypto_sign_open(unsigned char *m,
                     size_t *mlen,
                     const unsigned char *sm,
                     size_t smlen,
                     const unsigned char *pk
                    );
