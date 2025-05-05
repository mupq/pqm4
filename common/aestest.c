#include "randombytes.h"
#include <hal.h>
#include <aes.h>
#include <sendfn.h>
#include <randombytes.h>

#include <stdio.h>

unsigned char msg[4096];
unsigned char dest[sizeof(msg)];
unsigned char key[16];
aes128ctx ctx;

int main(void)
{
  hal_setup(CLOCK_BENCHMARK);
  hal_send_str("AES_TEST");
  hal_send_str("============");
  randombytes(key, sizeof(key));
  uint32_t t_exp = hal_get_time();
  aes128_ecb_keyexp(&ctx, key);
  t_exp = hal_get_time() - t_exp;
  char buf[64];
  send_unsignedll("Key expansion", t_exp);

  for (size_t size = 16; size <= sizeof(msg); size *= 2) {
    uint32_t t_enc = hal_get_time();
    aes128_ecb(dest, msg, size / 16, &ctx);
    t_enc = hal_get_time() - t_enc;

    snprintf(buf, sizeof(buf), "msg%u", (unsigned) size);
    send_unsignedll(buf, t_enc);
  }
}
