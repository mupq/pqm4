DEVICE=stm32f407vg

EXCLUDED_SCHEMES = \
	mupq/pqclean/crypto_kem/mceliece% \
	mupq/crypto_sign/falcon-1024-tree% \
	mupq/pqclean/crypto_sign/rainbow%

include mk/opencm3.mk

elf/crypto_kem_frodokem640aes_m4_%.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
elf/mupq_pqclean_crypto_kem_frodokem640shake_opt_%.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
