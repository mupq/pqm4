CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

HEADERS = api.h params.h sign.h polyvec.h packing.h poly.h reduce.h ntt.h rounding.h
SOURCES = sign.c polyvec.c packing.c poly.c reduce.c ntt.c ntt_asm.s rounding.c
OBJECTS = sign.o polyvec.o packing.o poly.o reduce.o ntt.o ntt_asm.o rounding.o

libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

%.o: %.s $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean
.INTERMEDIATE: $(OBJECTS)

clean:
	-rm -f libpqm4.a
	-rm -f *.o
