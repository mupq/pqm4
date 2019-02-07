#!/usr/bin/env python3
import subprocess
import os
import re

def getCodeSize(elf):
  size = subprocess.run(["arm-none-eabi-size", f"elf/{elf}"],
                            stdout=subprocess.PIPE)
  sizeBytes = int(str(size.stdout.splitlines()[1]).split("\\t")[3])
  return sizeBytes

def sort_mixed(l):
  r = []
  for word in l:
      word = re.split(r'(\d+)', word)
      for i, fragment in enumerate(word):
          try:
              word[i] = int(fragment)  # cast ints for proper sorting
          except Exception:
              pass
      r.append(word)
  return [''.join(map(str, x)) for x in sorted(r)]

def printCodeSizes(primitive):
  print(f"| scheme | implementation | code size [bytes] |")
  print(f"| ------ | -------------- | ----------------- |")

  dummyElf  = f"{primitive}_dummy.elf"
  dummySize = getCodeSize(dummyElf)
  try:
    elfs = [x for x in os.listdir('elf') if 'test.elf' in x and primitive in x]
  except FileNotFoundError:
    print("There is no elf/ folder. Please first make elfs.")
    sys.exit(1)

  for elf in sort_mixed(elfs):
    sizeBytes = getCodeSize(elf)
    scheme = elf.split("_")[2]
    impl   = elf.split("_")[3]
    netCodeSize = sizeBytes - dummySize
    print(f"| {scheme} | {impl} | {netCodeSize} |")


print("### Code Size Evaluation")
print("#### Key Encapsulation Schemes")
printCodeSizes("crypto_kem")
print("#### Signature Schemes")
printCodeSizes("crypto_sign")
