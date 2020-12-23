.PHONY: all
all: tests

include common/config.mk
include common/crypto.mk
include common/rules.mk
include common/schemes.mk
include common/tests.mk

.PHONY: clean libclean

clean: libclean
	rm -rf elf/
	rm -rf bin/
	rm -rf bin-host/
	rm -rf obj/
	rm -rf testvectors/
	rm -rf benchmarks/

.SECONDARY:
