#!/usr/bin/env python3
import os
import numpy as np

BENCHMARK_DIR = 'benchmarks/'

def parseData(fileContents):
    parts = fileContents.split("\n")
    keygen = int(parts[1])
    encsign = int(parts[4])
    decverify = int(parts[7])
    return [keygen, encsign, decverify]
    
def getStats(l):
    return "AVG: {0} <br /> MIN: {1} <br /> MAX: {2}".format(int(np.mean(l)), min(l), max(l));    

def formatData(scheme, implementation, data):
    keygen    = getStats([item[0] for item in data])
    encsign   = getStats([item[1] for item in data])
    decverify = getStats([item[2] for item in data])
    print("| {0} | {1} | {2} |  {3} | {4} |".format(scheme, implementation, keygen, encsign, decverify))
            
def processPrimitives(path):
    for scheme in os.listdir(path):
        for implementation in os.listdir(path+"/"+scheme):
            measurements = []
            for measurement in os.listdir(path+"/"+scheme+"/"+implementation):
                with open(path+"/"+scheme+"/"+implementation+"/"+measurement, "r") as f:
                    d = parseData(f.read())
                    measurements.append(d)
            formatData(scheme, implementation, measurements)
    

print("# Speed Evaluation")
print("## Key Encapsulation Schemes")
print("| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |")
print("| ------ | -------------- | ----------------------- | ---------------------- | -----------------------|")
processPrimitives(BENCHMARK_DIR+"speed/crypto_kem/")

print("## Signature Schemes")
print("| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |")
print("| ------ | -------------- | ----------------------- | ------------- | ----------------|")
processPrimitives(BENCHMARK_DIR+"speed/crypto_sign/")


print("# Memory Evaluation")
print("## Key Encapsulation Schemes")
print("| scheme | implementation | key generation [bytes] | encapsulation [bytes] | decapsulation [bytes] |")
print("| ------ | -------------- | ----------------------- | ---------------------- | -----------------------|")
processPrimitives(BENCHMARK_DIR+"stack/crypto_kem/")

print("## Signature Schemes")

print("| scheme | implementation | key generation [bytes] | sign [bytes] | verify [bytes] |")
print("| ------ | -------------- | ----------------------- | ------------- | ----------------|")
processPrimitives(BENCHMARK_DIR+"stack/crypto_sign/")
