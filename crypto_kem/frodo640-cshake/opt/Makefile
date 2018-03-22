CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

HEADERS = api.h config.h frodo_macrify.h 
SOURCES = frodo640.c util.c 
OBJECTS = frodo640.o util.o 

libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean
.INTERMEDIATE: $(OBJECTS)

clean:
	-rm -f libpqm4.a
	-rm -f *.o
