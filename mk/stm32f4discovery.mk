DEVICE=stm32f407vg
OPENCM3_TARGET=lib/stm32/f4

EXCLUDED_SCHEMES = \
	mupq/pqclean/crypto_kem/mceliece% \
	mupq/crypto_sign/falcon-1024-tree%

include mk/opencm3.mk

elf/boardtest.elf: CPPFLAGS+=-DSRAM_TIMING_TEST -DHAS_SRAM2 -DHAS_CCM
elf/boardtest-fast.elf: CPPFLAGS+=-DSRAM_TIMING_TEST -DHAS_SRAM2 -DHAS_CCM

elf/crypto_kem_frodokem640aes_m4_%.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
elf/mupq_pqclean_crypto_kem_frodokem640shake_opt_%.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
elf/crypto_sign_dilithium5_m4f_%.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
