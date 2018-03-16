#include "api.h"
#include "randombytes.h"
#include "stm32wrapper.h"
#include <string.h>

#define NTESTS 100
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
            send_USART_str("Signature did not verify correctly!\n");
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

    test_sign();

    return 0;
}
