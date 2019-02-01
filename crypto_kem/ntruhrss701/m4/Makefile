CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -flto
AR     = arm-none-eabi-gcc-ar

CC_HOST = gcc
CFLAGS_HOST = -Wall -Wextra -O3
AR_HOST = gcc-ar

SOURCES =          cbd.c owcpa.c poly.c verify.c ntrukem.c
HEADERS = params.h cbd.h owcpa.h poly.h verify.h api.h
OBJECTS =          cbd.o owcpa.o poly.o verify.o ntrukem.o


libpqm4.a: mult_toom4_701_11.o $(OBJECTS)
	$(AR) rcs $@ $< $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

%.o: %.s 
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean
.INTERMEDIATE: $(OBJECTS) $(OBJECTS_HOST)

clean:
	-rm libpqm4.a
	-rm *.o
