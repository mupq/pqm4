#include "api.h"
#include "randombytes.h"
#include "stm32wrapper.h"
#include "hal.h"

#include <stdio.h>
#include <string.h>

#define MAX_SIZE 0x16000

static void send_stack_usage(const char *s, unsigned int c) {
  char outs[120];
  hal_send_str(s);
  sprintf(outs, "%u\n", c);
  hal_send_str(outs);
}

unsigned int canary_size = MAX_SIZE;
volatile unsigned char *p;
unsigned int c;
uint8_t canary = 0x42;

unsigned char key_a[CRYPTO_BYTES], key_b[CRYPTO_BYTES];
unsigned char pk[CRYPTO_PUBLICKEYBYTES];
unsigned char sendb[CRYPTO_CIPHERTEXTBYTES];
unsigned char sk_a[CRYPTO_SECRETKEYBYTES];
unsigned int stack_key_gen, stack_encaps, stack_decaps;

#define FILL_STACK()                                                           \
  p = &a;                                                                      \
  while (p > &a - canary_size)                                                 \
    *(p--) = canary;
#define CHECK_STACK()                                                          \
  c = canary_size;                                                             \
  p = &a - canary_size + 1;                                                    \
  while (*p == canary && p < &a) {                                             \
    p++;                                                                       \
    c--;                                                                       \
  }                                                                            

static int test_keys(void) {
  volatile unsigned char a;
  // Alice generates a public key
  FILL_STACK()
  crypto_kem_keypair(pk, sk_a);
  CHECK_STACK()
  if(c >= canary_size) return -1; 
  stack_key_gen = c;

  // Bob derives a secret key and creates a response
  FILL_STACK()
  crypto_kem_enc(sendb, key_b, pk);
  CHECK_STACK()
  if(c >= canary_size) return -1; 
  stack_encaps = c;

  // Alice uses Bobs response to get her secret key
  FILL_STACK()
  crypto_kem_dec(key_a, sendb, sk_a);
  CHECK_STACK()
  if(c >= canary_size) return -1; 
  stack_decaps = c;

  if (memcmp(key_a, key_b, CRYPTO_BYTES)){
    return -1;
  } else {    
    send_stack_usage("key gen stack usage", stack_key_gen);
    send_stack_usage("encaps stack usage", stack_encaps);
    send_stack_usage("decaps stack usage", stack_decaps);
    hal_send_str("OK KEYS\n");
    return 0;
  }
}

int main(void) {
  hal_setup(CLOCK_FAST)

  // marker for automated benchmarks
  hal_send_str("==========================");
  canary_size = MAX_SIZE;
  while(test_keys()){
    canary_size -= 0x1000;
    if(canary_size == 0) {
      hal_send_str("failed to measure stack usage.\n");
      break;
    }
  }
  // marker for automated benchmarks
  hal_send_str("#");

  while (1);

  return 0;
}
