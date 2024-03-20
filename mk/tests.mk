# SPDX-License-Identifier: Apache-2.0 or CC0-1.0
ifeq ($(AIO),1)
elf/boardtest.elf: common/test.c $(LINKDEPS) $(CONFIG)
	$(compiletest)

elf/boardtest-fast.elf: common/testfast.c $(LINKDEPS) $(CONFIG)
	$(compiletest)

elf/boardtest-fast.elf: CPPFLAGS += -DCLOCK_TEST=CLOCK_FAST

elf/aestest.elf: common/aestest.c $(LINKDEPS) $(CONFIG)
	$(compiletest)

elf/keccaktest.elf: common/keccaktest.c $(LINKDEPS) $(CONFIG)
	$(compiletest)
else
elf/boardtest.elf: $(call objs,common/test.c) $(LINKDEPS) $(CONFIG)

elf/boardtest-fast.elf: $(call objs,common/testfast.c) $(LINKDEPS) $(CONFIG)

$(call objs,common/testfast.c): CPPFLAGS += -DCLOCK_TEST=CLOCK_FAST

elf/aestest.elf: $(call objs,common/aestest.c) $(LINKDEPS) $(CONFIG)

elf/keccaktest.elf: $(call objs,common/keccaktest.c) $(LINKDEPS) $(CONFIG)
endif

tests: elf/boardtest.elf elf/aestest.elf elf/keccaktest.elf
tests-bin: bin/boardtest.bin bin/aestest.bin bin/keccaktest.bin
