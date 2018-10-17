#!/usr/bin/env python3
import serial
import sys
import os
import subprocess
import utils


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

    if utils.m4ignore(primitive, scheme, implementation):
        return

    if len(sys.argv) > 1 and scheme not in sys.argv[1:]:
       return

    result = utils.m4run(binpath)


    print("Testing if tests were successful..")
    contents = result.strip()
    # can we find a nicer way of checking if tests ran correctly?
    if contents.count("ERROR") != 0 or contents.count("OK") != 30:
        print("FAILED!")
    else:
        print("passed.")

for binary in binaries:
    doTest(binary)
