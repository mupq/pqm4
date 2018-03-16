#include "api.h"
#include "randombytes.h"
#include "stm32wrapper.h"
#include <string.h>

#define NTESTS 15
#define MLEN 32

int test_sign(void)
{
    unsigned char pk[CRYPTO_PUBLICKEYBYTES];
    unsigned char sk[CRYPTO_SECRETKEYBYTES];
    unsigned char sm[MLEN + CRYPTO_BYTES];
    unsigned char m[MLEN];

    unsigned long long mlen;
    unsigned long long smlen;

    int i;

    for (i = 0; i < NTESTS; i++) {
        crypto_sign_keypair(pk, sk);
        send_USART_str("crypto_sign_keypair DONE.\n");

        randombytes(m, MLEN);
        crypto_sign(sm, &smlen, m, MLEN, sk);
        send_USART_str("crypto_sign DONE.\n");

        // By relying on m == sm we prevent having to allocate CRYPTO_BYTES twice
        if (crypto_sign_open(sm, &mlen, sm, smlen, pk)) {
            send_USART_str("ERROR Signature did not verify correctly!\n");
        } else {
            send_USART_str("OK Signature did verify correctly!\n");
        }
        send_USART_str("crypto_sign_open DONE.\n");
    }

    return 0;
}

void test_wrong_pk()
{
    unsigned char pk[CRYPTO_PUBLICKEYBYTES];
    unsigned char pk2[CRYPTO_PUBLICKEYBYTES];
    unsigned char sk[CRYPTO_SECRETKEYBYTES];
    unsigned char sm[MLEN + CRYPTO_BYTES];
    unsigned char m[MLEN];

    unsigned long long mlen;
    unsigned long long smlen;

    int i;

    for (i = 0; i < NTESTS; i++) {
        crypto_sign_keypair(pk2, sk);
        send_USART_str("crypto_sign_keypair DONE.\n");

        crypto_sign_keypair(pk, sk);
        send_USART_str("crypto_sign_keypair DONE.\n");


        randombytes(m, MLEN);
        crypto_sign(sm, &smlen, m, MLEN, sk);
        send_USART_str("crypto_sign DONE.\n");

        // By relying on m == sm we prevent having to allocate CRYPTO_BYTES twice
        if (crypto_sign_open(sm, &mlen, sm, smlen, pk2)) 
        {
            send_USART_str("OK Signature did not verify correctly under wrong public key!\n");
        } 
        else 
        {
            send_USART_str("ERROR Signature did verify correctly under wrong public key!\n");
        }
        send_USART_str("crypto_sign_open DONE.\n");
    }

    return 0;

}

int main(void)
{
    clock_setup(CLOCK_FAST);
    gpio_setup();
    usart_setup(115200);
    rng_enable();

    // marker for automated testing
    send_USART_str("==========================");
    test_sign();
    test_wrong_pk();
    send_USART_str("#");

    return 0;
}
