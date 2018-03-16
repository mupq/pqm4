CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -Wpedantic -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

SOURCES =          hash_shake256.c hash_address.c wots.c utils.c fors.c sign.c
HEADERS = params.h hash.h          hash_address.h wots.h utils.h fors.h api.h
OBJECTS =          hash_shake256.o hash_address.o wots.o utils.o fors.o sign.o

libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean

clean:
	-rm -f libpqm4.a
	-rm -f *.o
