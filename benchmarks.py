#!/usr/bin/env python3
import sys
import os
import datetime
import time
import utils


def benchmarkBinary(benchmark, binary):
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
    if 'ERROR KEYS' in result:
        print("")
        print("!!! KEY MISMATCH DURING BENCHMARKING !!!")
        print("  This could indicate illegal stack usage,")
        print("  leading to errors when measurement interrupts occur.")
        print("")
        print("  .. exiting with errors!")
        sys.exit(1)

    timestamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y%m%d%H%M%S')
    filename = os.path.join('benchmarks/', benchmark, primitive, scheme, implementation, timestamp)
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    with open(filename, 'w') as f:
        f.write(result.strip())
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
