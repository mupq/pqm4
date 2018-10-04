#include "api.h"
#include "stm32wrapper.h"

#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define MLEN 59

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
  unsigned char sk[CRYPTO_SECRETKEYBYTES];
  unsigned char pk[CRYPTO_PUBLICKEYBYTES];
  unsigned char sm[MLEN+CRYPTO_BYTES];
  unsigned long long smlen;
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
  crypto_sign_keypair(pk, sk);
  t1 = systick_get_value();
  printcycles("keypair cycles:", (t0+overflowcnt*2400000llu)-t1);

  // Signing
  t0 = systick_get_value();
  overflowcnt = 0;
  crypto_sign(sm, &smlen, sm, MLEN, sk);
  t1 = systick_get_value();
  printcycles("sign cycles: ", (t0+overflowcnt*2400000llu)-t1);

  // Verification
  t0 = systick_get_value();
  overflowcnt = 0;
  crypto_sign_open(sm, &smlen, sm, smlen, pk);
  t1 = systick_get_value();
  printcycles("verify cycles: ", (t0+overflowcnt*2400000llu)-t1);

  send_USART_str("#");
  while(1);
  return 0;
}
