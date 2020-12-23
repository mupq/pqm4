elf/boardtest.elf: $(call objs,common/test.c)

elf/aestest.elf: $(call objs,common/aestest.c)

tests: elf/boardtest.elf elf/aestest.elf
tests-bin: bin/boardtest.bin bin/aestest.bin
