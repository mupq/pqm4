#!/usr/bin/env python3
import serial
import sys
import os
import subprocess

dev = serial.Serial("/dev/ttyUSB0", 115200, timeout=10)

try:
    binaries = [x for x in os.listdir('bin') if 'test.bin' in x]
except FileNotFoundError:
    print("There is no bin/ folder. Please first make binaries.")
    sys.exit(1)

def doTest(binary):
    binpath = os.path.join("bin", binary)
    info = binary.split('_')
    primitive = '_'.join(info[:2])
    scheme = '_'.join(info[2:-2])
    implementation = info[-2]


    # skip SPHINCS and SIKE for testing
    #if scheme == "sphincs-shake256-128s" or scheme == "sikep751":
    #    print("skipping SPHINCS/SIKE")            
    #    return

    if len(sys.argv) > 1 and scheme not in sys.argv[1:]:
       return

    print("Flashing {}..".format(binpath))

    subprocess.run(["st-flash", "write", binpath, "0x8000000"],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    print("Flashed, now running tests...")

    state = 'waiting'
    marker = b''

    # This parses test vector output starting with a number of leading '=',
    #  and expects a hashtag '#' after the test vector output.
    while True:
        x = dev.read()
        if x == b'' and state == 'waiting':
            print("timed out while waiting for the markers")
            doTest(binary)
            return
        if state == 'waiting':
            if x == b'=':
                marker += x
                continue
            # If we saw at least 5 equal signs, assume we've probably started
            elif marker.count(b'=') > 5:
                state = 'beginning'
                vector = []
                print("  .. found output marker..")
        if state == 'beginning':
            if x == b'=':
                continue
            else:
                state = 'reading'
        elif state == 'reading':
            if x == b'#':
                break
            else:
                vector.append(x)
    print("Testing if tests were successful..")
    
    contents = b''.join(vector).decode('utf-8').strip()
    # can we find a nicer way of checking if tests ran correctly?
    if contents.count("ERROR") != 0 or contents.count("OK") != 30:
        print("FAILED!")
    else:
        print("passed.")




for binary in binaries:
    doTest(binary);    
