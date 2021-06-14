#!/usr/bin/env python3
import serial
import sys
import platform

if platform.system() == "Darwin":
    dev = serial.Serial("/dev/tty.usbserial-0001", 38400)
else:
    dev = serial.Serial("/dev/ttyUSB0", 38400)

print("> Returned data:", file=sys.stderr)

while True:
    x = dev.read()
    sys.stdout.buffer.write(x)
    sys.stdout.flush()
