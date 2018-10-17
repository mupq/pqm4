#!/usr/bin/env python3
import sys
import os
import subprocess
import hashlib
import utils


try:
    binaries = [x for x in os.listdir('bin') if 'testvectors.bin' in x]
except FileNotFoundError:
    print("There is no bin/ folder. Please first make binaries.")
    sys.exit(1)

try:
    binaries_host = [x for x in os.listdir('bin-host') if 'testvectors' in x]
except FileNotFoundError:
    print("There is no bin-host/ folder. Please first make binaries.")
    sys.exit(1)

print("This script flashes the test vector binaries onto the board, and then")
print(" writes the resulting output to the testvectors directory. It then")
print(" checks if these are internally consistent and match the test vectors")
print(" when running the reference code locally.")

for binary in binaries + binaries_host:
    info = binary.split('_')
    primitive = '_'.join(info[:2])
    scheme = '_'.join(info[2:-2])
    impl = info[-2]

    if len(sys.argv) > 1 and scheme not in sys.argv[1:]:
        continue

    # if this is a binary that needs to be ran on the board:
    if binary[-4:] == '.bin':
        if utils.m4ignore(primitive, scheme, impl):
            continue
        binpath = os.path.join("bin", binary)

        results = utils.m4run(binpath)
        filename = os.path.join('testvectors/', primitive, scheme, impl)
        os.makedirs(os.path.dirname(filename), exist_ok=True)
        with open(filename, 'w') as f:
            f.write(results.lstrip())
    else:
        binpath = os.path.join("bin-host", binary)
        print("Running {}..".format(binpath))
        filename = os.path.join('testvectors/', primitive, scheme, "host")
        os.makedirs(os.path.dirname(filename), exist_ok=True)
        with open(filename, 'w') as f:
            subprocess.run([binpath], stdout=f, stderr=subprocess.DEVNULL)
    print("  .. wrote test vectors!")

if not os.path.isdir('testvectors'):
    sys.exit(0)

print("Testing if test vectors are consistent..")
for primitive in os.listdir('testvectors'):
    for scheme in os.listdir(os.path.join('testvectors', primitive)):
        print("  .. {}: ".format(os.path.join(primitive, scheme)), end='')
        hashes = dict()
        for impl in os.listdir(os.path.join('testvectors', primitive, scheme)):
            path = os.path.join('testvectors', primitive, scheme, impl)
            with open(path, 'rb') as file:
                hashes[file.name] = hashlib.sha3_256(file.read()).hexdigest()
        if len(set(hashes.values())) <= 1:
            print("passed.")
        else:
            print("FAILED!")
            for file, checksum in hashes.items():
                print(("    {: <{width}} sha3:{}").format(
                      file, checksum, width=max(len(file) for file in hashes)))
