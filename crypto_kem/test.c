#include "api.h"
#include "randombytes.h"
#include "stm32wrapper.h"
#include <string.h>

#define NTESTS 10

static int test_keys(void)
{
  unsigned char key_a[CRYPTO_BYTES], key_b[CRYPTO_BYTES];
  unsigned char pk[CRYPTO_PUBLICKEYBYTES];
  unsigned char sendb[CRYPTO_CIPHERTEXTBYTES];
  unsigned char sk_a[CRYPTO_SECRETKEYBYTES];
  int i;

  for(i=0; i<NTESTS; i++)
  {
    //Alice generates a public key
    crypto_kem_keypair(pk, sk_a);
    send_USART_str("PASS key pair generation!");

    //Bob derives a secret key and creates a response
    crypto_kem_enc(sendb, key_b, pk);
    send_USART_str("PASS encapsulation!");

    //Alice uses Bobs response to get her secret key
    crypto_kem_dec(key_a, sendb, sk_a);
    send_USART_str("PASS decapsulation!");

    if(memcmp(key_a, key_b, CRYPTO_BYTES))
    {
      send_USART_str("ERROR KEYS\n");
    } 
    else 
    {
      send_USART_str("OK KEYS\n");
    }
  }

  return 0;
}


static int test_invalid_sk_a(void)
{
  unsigned char sk_a[CRYPTO_SECRETKEYBYTES];
  unsigned char key_a[CRYPTO_BYTES], key_b[CRYPTO_BYTES];
  unsigned char pk[CRYPTO_PUBLICKEYBYTES];
  unsigned char sendb[CRYPTO_CIPHERTEXTBYTES];
  int i;

  for(i=0; i<NTESTS; i++)
  {
    //Alice generates a public key
    crypto_kem_keypair(pk, sk_a);

    //Bob derives a secret key and creates a response
    crypto_kem_enc(sendb, key_b, pk);

    //Replace secret key with random values
    randombytes(sk_a, CRYPTO_SECRETKEYBYTES);

    //Alice uses Bobs response to get her secre key
    crypto_kem_dec(key_a, sendb, sk_a);

    if(!memcmp(key_a, key_b, CRYPTO_BYTES)) 
    {
      send_USART_str("ERROR invalid sk_a\n");
    } 
    else 
    {
      send_USART_str("OK invalid sk_a\n");
    }
  }

  return 0;
}


static int test_invalid_ciphertext(void)
{
  unsigned char sk_a[CRYPTO_SECRETKEYBYTES];
  unsigned char key_a[CRYPTO_BYTES], key_b[CRYPTO_BYTES];
  unsigned char pk[CRYPTO_PUBLICKEYBYTES];
  unsigned char sendb[CRYPTO_CIPHERTEXTBYTES];
  int i;
  size_t pos;

  for(i=0; i<NTESTS; i++)
  {
    randombytes((unsigned char *)&pos, sizeof(size_t));

    //Alice generates a public key
    crypto_kem_keypair(pk, sk_a);

    //Bob derives a secret key and creates a response
    crypto_kem_enc(sendb, key_b, pk);

    //Change some byte in the ciphertext (i.e., encapsulated key)
    sendb[pos % CRYPTO_CIPHERTEXTBYTES] ^= 23;

    //Alice uses Bobs response to get her secret key
    crypto_kem_dec(key_a, sendb, sk_a);

    if(!memcmp(key_a, key_b, CRYPTO_BYTES))
    {
      send_USART_str("ERROR invalid ciphertext\n");
    } 
    else 
    {
      send_USART_str("OK invalid ciphertext\n");
    }
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
  test_keys();
  test_invalid_sk_a();
  test_invalid_ciphertext();
  send_USART_str("#");

  while(1);

  return 0;
}
