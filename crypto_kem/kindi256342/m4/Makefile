CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar 

SOURCES = core.c gen_randomness.c kem.c poly.c poly_encode.c
OBJECTS = core.o gen_randomness.o kem.o poly.o poly_encode.o mult_notoom_256_16.o
HEADERS = api.h core.h gen_randomness.h params.h poly.h


libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)


%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

%.o: %.s 
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean
.INTERMEDIATE: $(OBJECTS) $(OBJECTS_HOST)

clean:
	-rm libpqm4.a
	-rm *.o
