DEVICE=stm32f303rct7

EXCLUDED_SCHEMES = \
	mupq/pqclean/crypto_sign/sphincs-haraka-256f% \
	mupq/pqclean/crypto_sign/sphincs-shake256-256f% \
	mupq/pqclean/crypto_sign/sphincs-sha256-256f% \
	mupq/pqclean/crypto_kem/mceliece% \
  mupq/pqclean/crypto_sign/rainbow% \
	mupq/pqclean/crypto_kem/frodokem1344% \
	mupq/pqclean/crypto_kem/frodokem976% \
  mupq/crypto_sign/falcon-1024% \
  mupq/crypto_sign/falcon-512% \
  crypto_sign/falcon-1024% \
  crypto_sign/falcon-512% \

include mk/opencm3.mk
