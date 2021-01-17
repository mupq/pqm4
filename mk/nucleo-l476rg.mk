DEVICE=stm32l476rg

EXCLUDED_SCHEMES = \
	mupq/pqclean/crypto_kem/mceliece% \
  mupq/crypto_sign/falcon-1024-tree% \
  mupq/pqclean/crypto_sign/rainbow%

include mk/opencm3.mk
