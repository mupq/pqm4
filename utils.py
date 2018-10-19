import os
import serial
import subprocess
import sys
import string

dev = serial.Serial("/dev/ttyUSB0", 115200,timeout=10)

def m4run(binpath):
    print("Flashing {}..".format(binpath))
    rc = subprocess.run(["st-flash", "--reset",  "write", binpath, "0x8000000"],
                   stdout=sys.stdout.buffer, stderr=sys.stdout.buffer)

    if rc.returncode != 0:
        raise Exception("Flashing failed.")

    state = 'waiting'
    marker = b''
    # This parses test vector output starting with a number of leading '=',
    #  and expects a hashtag '#' after the test vector output.
    while True:
        x = dev.read()
        if x == b'' and state == 'waiting':
            print("timed out while waiting for the markers")
            run(binpath)
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
    return b''.join(vector).decode('utf-8', 'ignore')

def m4ignore(primitive, scheme, implementation):
    ignores = [os.path.join(primitive, scheme, implementation, '.m4ignore'),
               os.path.join(primitive, scheme, '.m4ignore'),
               os.path.join(primitive, '.m4ignore')]
    return any(os.path.exists(path) for path in ignores)
