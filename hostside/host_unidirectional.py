#!/usr/bin/env python3
import serial
import sys
import platform

if platform.system() == "Linux":
    dev = serial.Serial("/dev/ttyUSB0", 115200)
elif platform.system() == "Darwin":
    dev = serial.Serial("/dev/tty.usbserial-0001", 115200)
else:
    raise Exception("OS not supported, you should check the name of the device under your OS.")

print("> Returned data:", file=sys.stderr)

while True:
    x = dev.read()
    sys.stdout.buffer.write(x)
    sys.stdout.flush()
