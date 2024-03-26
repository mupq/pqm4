# SPDX-License-Identifier: Apache-2.0 or CC0-1.0
.PHONY: all
all: tests tests-bin

include mupq/mk/config.mk
include mk/config.mk
include mk/crypto.mk
include mupq/mk/host-crypto.mk
include mupq/mk/rules.mk
include mupq/mk/schemes.mk
include mk/tests.mk

.PHONY: clean libclean

clean: libclean
	rm -rf elf/
	rm -rf bin/
	rm -rf bin-host/
	rm -rf obj/
	rm -rf testvectors/
	rm -rf benchmarks/

.SECONDARY:
