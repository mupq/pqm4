CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

HEADERS = api.h config.h P751_internal.h
SOURCES = ec_isogeny.c fpx.c P751.c sidh.c sike.c generic/fp_generic.c
OBJECTS = P751.o generic/fp_generic.o

libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean

clean:
	-rm -f libpqm4.a
	-rm -f *.o */*.o

