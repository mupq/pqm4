#include "api.h"
#include "randombytes.h"
#include "stm32wrapper.h"
#include <stdio.h>
#include <string.h>
#define NTESTS 1

// STM32F407 stack is from 0x20020000 to 0x20000000, growing downwards
//#define MIN_STACK_ADDR 0x20000000
//#define MAX_STACK_ADDR 0x20020000
#define MAX_SIZE 0x15000
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
int i, j;
uint8_t canary = 0x42;

unsigned char key_a[CRYPTO_BYTES], key_b[CRYPTO_BYTES];
unsigned char pk[CRYPTO_PUBLICKEYBYTES];
unsigned char sendb[CRYPTO_CIPHERTEXTBYTES];
unsigned char sk_a[CRYPTO_SECRETKEYBYTES];

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

static int test_keys(void) {
  volatile unsigned char a;
  for (i = 0; i < NTESTS; i++) {
    // Alice generates a public key
    FILL_STACK()
    crypto_kem_keypair(pk, sk_a);
    CHECK_STACK("key gen stack usage")
    // Bob derives a secret key and creates a response

    FILL_STACK()
    crypto_kem_enc(sendb, key_b, pk);
    CHECK_STACK("encaps stack usage")

    // Alice uses Bobs response to get her secret key
    FILL_STACK()
    crypto_kem_dec(key_a, sendb, sk_a);
    CHECK_STACK("decaps stack usage")

    if (memcmp(key_a, key_b, CRYPTO_BYTES))
      send_USART_str("ERROR KEYS\n");
    else
      send_USART_str("KEYS CORRECT\n");
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
  test_keys();
  // marker for automated benchmarks
  send_USART_str("#");

  while (1);

  return 0;
}