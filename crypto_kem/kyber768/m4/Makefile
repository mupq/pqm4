CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

HEADERS = api.h cbd.h indcpa.h ntt.h params.h poly.h polyvec.h reduce.h verify.h
SOURCES = cbd.c indcpa.c kem.c ntt.c poly.c polyvec.c precomp.c reduce.c verify.c kyber.S
OBJECTS = cbd.o indcpa.o kem.o ntt.o poly.o polyvec.o precomp.o reduce.o verify.o kyber.o

libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

%.o: %.S $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean
.INTERMEDIATE: $(OBJECTS)

clean:
	-rm -f libpqm4.a
	-rm -f *.o
