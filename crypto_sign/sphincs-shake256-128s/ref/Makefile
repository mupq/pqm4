CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -Wpedantic -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -flto
AR     = arm-none-eabi-gcc-ar

CC_HOST = gcc
CFLAGS_HOST = -Wall -Wextra -O3
AR_HOST = gcc-ar

SOURCES =          hash_shake256.c hash_address.c wots.c utils.c fors.c sign.c
HEADERS = params.h hash.h          hash_address.h wots.h utils.h fors.h api.h
OBJECTS =          hash_shake256.o hash_address.o wots.o utils.o fors.o sign.o

OBJECTS_HOST = $(patsubst %.o,%_host.o,$(OBJECTS))

libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

libpqhost.a: $(OBJECTS_HOST)
	$(AR_HOST) rcs $@ $(OBJECTS_HOST)

%_host.o: %.c $(HEADERS)
	$(CC_HOST) -I$(INCPATH) $(CFLAGS_HOST) -c -o $@ $<

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean
.INTERMEDIATE: $(OBJECTS)

clean:
	-rm -f libpqhost.a
	-rm -f libpqm4.a
	-rm -f *.o
