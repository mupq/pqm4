#include "api.h"
#include "stm32wrapper.h"

#include <stdio.h>
#include <stdint.h>
#include <string.h>

static unsigned long long overflowcnt = 0;

void sys_tick_handler(void)
{
  ++overflowcnt;
}

static void printcycles(const char *s, unsigned long long c)
{
  char outs[32];
  send_USART_str(s);
  snprintf(outs,sizeof(outs),"%llu\n",c);
  send_USART_str(outs);
}


int main(void)
{
  unsigned char key_a[CRYPTO_BYTES], key_b[CRYPTO_BYTES];
  unsigned char sk[CRYPTO_SECRETKEYBYTES];
  unsigned char pk[CRYPTO_PUBLICKEYBYTES];
  unsigned char ct[CRYPTO_CIPHERTEXTBYTES];
  unsigned int t0, t1;

  clock_setup(CLOCK_BENCHMARK);
  gpio_setup();
  usart_setup(115200);
  systick_setup();
  rng_enable();

  send_USART_str("==========================");

  // Key-pair generation
  t0 = systick_get_value();
  overflowcnt = 0;
  crypto_kem_keypair(pk, sk);
  t1 = systick_get_value();
  printcycles("keypair cycles:", (t0+overflowcnt*2400000llu)-t1);

  // Encapsulation
  t0 = systick_get_value();
  overflowcnt = 0;
  crypto_kem_enc(ct, key_a, pk);
  t1 = systick_get_value();
  printcycles("encaps cycles: ", (t0+overflowcnt*2400000llu)-t1);

  // Decapsulation
  t0 = systick_get_value();
  overflowcnt = 0;
  crypto_kem_dec(key_b, ct, sk);
  t1 = systick_get_value();
  printcycles("decaps cycles: ", (t0+overflowcnt*2400000llu)-t1);

  if (memcmp(key_a, key_b, CRYPTO_BYTES)) {
    send_USART_str("ERROR KEYS\n");
  }
  else {
    send_USART_str("OK KEYS\n");
  }

  send_USART_str("#");
  while(1);
  return 0;
}
