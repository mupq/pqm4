CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -flto
AR     = arm-none-eabi-gcc-ar 

CC_HOST = gcc
CFLAGS_HOST = -Wall -Wextra -O3
AR_HOST = gcc-ar

SOURCES = core.c fft_transform.c gen_randomness.c kem.c poly.c poly_encode.c
OBJECTS = core.o fft_transform.o gen_randomness.o kem.o poly.o poly_encode.o
HEADERS = api.h core.h gen_randomness.h params.h poly.h

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
.INTERMEDIATE: $(OBJECTS) $(OBJECTS_HOST)

clean:
	-rm -f libpqm4.a
	-rm -f *.o 
	-rm -f libpqhost.a

