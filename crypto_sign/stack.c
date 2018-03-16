#include "api.h"
#include "randombytes.h"
#include "stm32wrapper.h"
#include <stdio.h>
#include <string.h>
#define NTESTS 1
#define MLEN 32

// STM32F407 stack is from 0x20020000 to 0x20000000, growing downwards
//#define MIN_STACK_ADDR 0x20000000
//#define MAX_STACK_ADDR 0x20020000
#define MAX_SIZE 0x16000
static void send_stack_usage(const char *s, unsigned int c) {
  char outs[120];
  send_USART_str(s);
  if (c >= MAX_SIZE) {
    send_USART_str("stack usage exceeds MAX_SIZE");
  } else {
    sprintf(outs, "%u\n", c);
    send_USART_str(outs);
  }
}

volatile unsigned char *p;
unsigned int c;
int i, j, rc;
uint8_t canary = 0x42;

unsigned char pk[CRYPTO_PUBLICKEYBYTES];
unsigned char sk[CRYPTO_SECRETKEYBYTES];
unsigned char sm[MLEN + CRYPTO_BYTES];
unsigned char m[MLEN];
unsigned char m_out[MLEN + CRYPTO_BYTES];

unsigned long long mlen;
unsigned long long smlen;

#define FILL_STACK()                                                           \
  p = &a;                                                                      \
  while (p > &a - MAX_SIZE)                                                    \
    *(p--) = canary;
#define CHECK_STACK(s)                                                         \
  c = MAX_SIZE;                                                                \
  p = &a - MAX_SIZE + 1;                                                       \
  while (*p == canary && p < &a) {                                             \
    p++;                                                                       \
    c--;                                                                       \
  }                                                                            \
  send_stack_usage(s, c);

static int test_sign(void) {
  volatile unsigned char a;
  for (i = 0; i < NTESTS; i++) {
    // Alice generates a public key
    FILL_STACK()
    crypto_sign_keypair(pk, sk);
    CHECK_STACK("crypto_sign_keypair stack usage")
    // Bob derives a secret key and creates a response

    randombytes(m, MLEN);
    FILL_STACK()
    crypto_sign(sm, &smlen, m, MLEN, sk);
    CHECK_STACK("crypto_sign stack usage")

    // Alice uses Bobs response to get her secret key
    FILL_STACK()
    rc = crypto_sign_open(m_out, &mlen, sm, smlen, pk);
    CHECK_STACK("crypto_sign_open stack usage")

    if (rc) {
      send_USART_str("Signature did not verify correctly!\n");
    } else {
      send_USART_str("Signature valid!\n");
    }

    canary++;
  }

  return 0;
}

int main(void) {
  clock_setup(CLOCK_FAST);
  gpio_setup();
  usart_setup(115200);
  rng_enable();

 // marker for automated benchmarks
  send_USART_str("==========================");
 
  test_sign();

  // marker for automated benchmarks
  send_USART_str("#");


  while (1)
    ;

  return 0;
}