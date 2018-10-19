#!/usr/bin/env python3
import os
import numpy as np

BENCHMARK_DIR = 'benchmarks/'

def parseData(fileContents):
    parts = fileContents.split("\n")
    keygen = int(parts[1])
    encsign = int(parts[3])
    decverify = int(parts[5])
    return [keygen, encsign, decverify]

def getStats(l):
    return "AVG: {:,} <br /> MIN: {:,} <br /> MAX: {:,}".format(int(np.mean(l)), min(l), max(l));

def formatData(scheme, implementation, data, printStats):
    if printStats:
        keygen    = getStats([item[0] for item in data])
        encsign   = getStats([item[1] for item in data])
        decverify = getStats([item[2] for item in data])
        print("| {} ({} executions) | {} | {} |  {} | {} |".format(scheme,len(data), implementation, keygen, encsign, decverify))
    else:
        keygen     = "{:,}".format(max([item[0] for item in data]))
        encsign    = "{:,}".format(max([item[1] for item in data]))
        decverify  = "{:,}".format( max([item[2] for item in data]))
        print("| {} | {} | {} |  {} | {} |".format(scheme, implementation, keygen, encsign, decverify))

def processPrimitives(path, printStats):
    if os.path.exists(path) == False:
        return;
    for scheme in sorted(os.listdir(path)):
        for implementation in sorted(os.listdir(path+"/"+scheme)):
            measurements = []
            for measurement in os.listdir(path+"/"+scheme+"/"+implementation):
                with open(path+"/"+scheme+"/"+implementation+"/"+measurement, "r") as f:
                    d = parseData(f.read())
                    measurements.append(d)
            formatData(scheme, implementation, measurements, printStats)


print("### Speed Evaluation")
print("#### Key Encapsulation Schemes")
print("| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |")
print("| ------ | -------------- | ----------------------- | ---------------------- | -----------------------|")
processPrimitives(BENCHMARK_DIR+"speed/crypto_kem/", True)

print("#### Signature Schemes")
print("| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |")
print("| ------ | -------------- | ----------------------- | ------------- | ----------------|")
processPrimitives(BENCHMARK_DIR+"speed/crypto_sign/", True)


print("### Memory Evaluation")
print("#### Key Encapsulation Schemes")
print("| scheme | implementation | key generation [bytes] | encapsulation [bytes] | decapsulation [bytes] |")
print("| ------ | -------------- | ----------------------- | ---------------------- | -----------------------|")
processPrimitives(BENCHMARK_DIR+"stack/crypto_kem/", False)

print("#### Signature Schemes")

print("| scheme | implementation | key generation [bytes] | sign [bytes] | verify [bytes] |")
print("| ------ | -------------- | ----------------------- | ------------- | ----------------|")
processPrimitives(BENCHMARK_DIR+"stack/crypto_sign/", False)
