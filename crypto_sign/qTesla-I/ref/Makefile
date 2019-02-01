CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -flto
AR     = arm-none-eabi-gcc-ar

CC_HOST = gcc
CC_CLFAGS = -Wall -Wextra -O3
AR_HOST = gcc-ar

OBJECTS= sign.o consts.o sample.o poly.o  
HEADERS= api.h params.h sample.h poly.h
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
	-rm -f libpqhost.a
	-rm -f libpqm4.a
	-rm -f *.o

