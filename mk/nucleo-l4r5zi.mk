# SPDX-License-Identifier: Apache-2.0 or CC0-1.0
DEVICE=stm32l4r5zi
OPENCM3_TARGET=lib/stm32/l4

EXCLUDED_SCHEMES = \
	mupq/pqclean/crypto_kem/mceliece% \
	mupq/crypto_sign/tuov% \
	mupq/crypto_sign/falcon-1024-tree%

DEVICES_DATA := ldscripts/devices.data

elf/boardtest.elf: CPPFLAGS+=-DSRAM_TIMING_TEST -DHAS_SRAM2 -DHAS_SRAM3
elf/boardtest.elf: LDSCRIPT=ldscripts/$(PLATFORM)-ramtest.ld

elf/boardtest-fast.elf: CPPFLAGS+=-DSRAM_TIMING_TEST -DHAS_SRAM2 -DHAS_SRAM3
elf/boardtest-fast.elf: LDSCRIPT=ldscripts/$(PLATFORM)-ramtest.ld

include mk/opencm3.mk
