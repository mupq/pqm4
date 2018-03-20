#!/usr/bin/env python3
import serial
import sys
import os
import subprocess
import hashlib
import datetime
import time
from utils import m4ignore

dev = serial.Serial("/dev/ttyUSB0", 115200,timeout=10)

def benchmarkBinary(benchmark, binary):
    binpath = os.path.join("bin", binary)

    info = binary.split('_')
    primitive = '_'.join(info[:2])
    scheme = '_'.join(info[2:-2])
    implementation = info[-2]

    if m4ignore(primitive, scheme, implementation):
        return

    # skip SPHINCS and SIKE for testing
    #if scheme == "sphincs-shake256-128s" or scheme == "sikep751":
    #    print("skipping SPHINCS/SIKE")            
    #    return
    if len(sys.argv) > 1 and scheme not in sys.argv[1:]:
        return
    print("Flashing {}..".format(binpath))
    subprocess.run(["st-flash", "write", binpath, "0x8000000"],
                   stdout=sys.stdout.buffer, stderr=sys.stdout.buffer)
    print("Flashed, now running benchmarks..".format(binary))
    state = 'waiting'
    marker = b''
    # This parses test vector output starting with a number of leading '=',
    #  and expects a hashtag '#' after the test vector output.
    while True:
        x = dev.read()
        if x == b'' and state == 'waiting':
            print("timed out while waiting for the markers")
            benchmarkBinary(benchmark, binary)
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
    timestamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y%m%d%H%M%S')
    filename = os.path.join('benchmarks/', benchmark, primitive, scheme, implementation, timestamp)
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    with open(filename, 'w') as f:
        f.write(b''.join(vector).decode('utf-8').strip())
    print("  .. wrote benchmarks!")

def doBenchmarks(benchmark):
    try:
        binaries = [x for x in os.listdir('bin') if (benchmark+".bin") in x]
    except FileNotFoundError:
        print("There is no bin/ folder. Please first make binaries.")
        sys.exit(1)

    print("This script flashes the benchmarking binaries onto the board, ")
    print(" and then writes the resulting output to the benchmarks directory.")

    for binary in binaries:
        benchmarkBinary(benchmark, binary)

doBenchmarks("stack")
doBenchmarks("speed")
