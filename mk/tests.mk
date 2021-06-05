ifeq ($(AIO),1)
elf/boardtest.elf: common/test.c $(LINKDEPS) $(CONFIG)
	$(compiletest)

elf/aestest.elf: common/aestest.c $(LINKDEPS) $(CONFIG)
	$(compiletest)
else
elf/boardtest.elf: $(call objs,common/test.c) $(LINKDEPS) $(CONFIG)

elf/aestest.elf: $(call objs,common/aestest.c) $(LINKDEPS) $(CONFIG)
endif


tests: elf/boardtest.elf elf/aestest.elf
tests-bin: bin/boardtest.bin bin/aestest.bin
