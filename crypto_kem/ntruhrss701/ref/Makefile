CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

SOURCES =          cbd.c owcpa.c poly.c verify.c ntrukem.c
HEADERS = params.h cbd.h owcpa.h poly.h verify.h api.h
OBJECTS =          cbd.o owcpa.o poly.o verify.o ntrukem.o

libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean

clean:
	-rm -f libpqm4.a
	-rm -f *.o
