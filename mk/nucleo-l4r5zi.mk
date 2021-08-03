DEVICE=stm32l4r5zi

EXCLUDED_SCHEMES = \
	mupq/pqclean/crypto_kem/mceliece% \
  mupq/crypto_sign/falcon-1024-tree% \
  mupq/pqclean/crypto_sign/rainbow%

DEVICES_DATA := ldscripts/devices.data

elf/boardtest.elf: CPPFLAGS+=-DSRAM_TIMING_TEST -DHAS_SRAM2 -DHAS_SRAM3
elf/boardtest.elf: LDSCRIPT=ldscripts/$(PLATFORM)-ramtest.ld

include mk/opencm3.mk
