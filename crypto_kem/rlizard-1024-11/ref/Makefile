CC = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

CC_HOST = gcc
CFLAGS_HOST = -Wall -Wextra -O3
AR_HOST = gcc-ar

OBJECTS = RLizard.o sha512.o

OBJECTS_HOST = $(patsubst %.o,%_host.o,$(OBJECTS))
libpqm4.a: $(OBJECTS) libkeccak/pqm4libkeccak
	rm -f libkeccak/*.o
	cd libkeccak && $(AR) x pqm4libkeccak
	$(AR) rcs $@ $(OBJECTS) libkeccak/*.o


libpqhost.a: $(OBJECTS_HOST) libkeccak/pqm4libkeccakhost
	rm -f libkeccak/*.o
	cd libkeccak && $(AR) x pqm4libkeccakhost
	$(AR_HOST) rcs $@ $(OBJECTS_HOST) libkeccak/*.o



%_host.o: %.c $(HEADERS)
	$(CC_HOST) -I$(INCPATH) $(CFLAGS_HOST) -c -o $@ $<

%.o: %.c
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

%.o: %.s
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<
  

.PHONY: clean
.INTERMEDIATE: $(OBJECTS) $(OBJECTS_HOST)

clean:
	-rm -f libpqhost.a
	-rm -f libpqm4.a
	-rm -f *.o
	-rm -f libkeccak/*.o
