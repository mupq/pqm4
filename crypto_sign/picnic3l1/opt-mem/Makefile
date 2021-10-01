LIBPICNIC=libpicnic.a

SOURCES=$(wildcard *.c)
SOURCES_ASM=$(wildcard *.S)
INCLUDE=../../targets/stm32l432/src
CC=arm-none-eabi-gcc

CFLAGS= -O3  -fno-common  -Wall -Wextra -Wvla -Werror -Wmissing-prototypes -Wredundant-decls -std=gnu99 -fvisibility=default -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -MD -DSTM32F4 -DKECCAK_ASM 

all: $(LIBPICNIC)

.c.o:
	$(CC) -c $(CFLAGS) -I$(INCLUDE) $< -o $@

.S.o:
	$(CC) -c $(CFLAGS) -I$(INCLUDE) $< -o $@


$(LIBPICNIC): $(SOURCES:.c=.o) $(SOURCES_ASM:.S=.o)
	ar rcs $@ $^

kats: $(LIBPICNIC) tests/kats_test.c
	$(CC) $(CFLAGS) -o kats.out tests/kats_test.c ${LIBPICNIC}

example: $(LIBPICNIC) tests/example.c
	$(CC) $(CFLAGS) -o example.out tests/example.c ${LIBPICNIC}

bench: $(OBJECTS) tests/bench.c tests/bench_timing.c tests/bench_utils.c
	$(CC) $(CFLAGS) -D_GNU_SOURCE -o bench.out tests/bench.c tests/bench_timing.c tests/bench_utils.c $(LIBPICNIC)
clean:
	rm -f $(wildcard *.o) $(wildcard *.d) $(LIBPICNIC) $(wildcard kats.out) $(wildcard example.out)
