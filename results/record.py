#!/usr/bin/env python3
# Cut the output of `convert_benchmarks.py md` into the record of one type:
# that type's section only, with only the rows of the listed schemes; a
# table left with no row (the signature table of a KEM family, the KEM
# table of a signature family) is dropped.
# Usage: python3 results/record.py <type> <input.md> <output.md> <scheme>...
#   e.g. python3 results/record.py stack benchmarks/converted.md \
#          results/runs/ml-kem/stack/converted.md ml-kem-512 ml-kem-768 ml-kem-1024
import os, sys
TITLES = {"speed": "Speed Evaluation", "stack": "Memory Evaluation",
          "hashing": "Hashing Evaluation", "size": "Size Evaluation"}

if len(sys.argv) < 5 or sys.argv[1] not in TITLES:
    sys.exit(__doc__ or "usage: record.py <type> <input.md> <output.md> <scheme>...")
t, src, dst, schemes = sys.argv[1], sys.argv[2], sys.argv[3], set(sys.argv[4:])
text = open(src).read().splitlines()

if True:
    out, keep = [], False
    for line in text:
        if line.startswith("# "):
            keep = line[2:].strip() == TITLES[t]
        if not keep:
            continue
        if line.startswith("| ") and not line.startswith("| -"):
            cell = line.split("|")[1].split()[0]
            if cell.lower() != "scheme" and cell not in schemes:
                continue
        out.append(line)
    # drop a '## ' table with no row: header and separator only
    kept, i = [], 0
    while i < len(out):
        if out[i].startswith("## "):
            j = i + 1
            while j < len(out) and not out[j].startswith("#"):
                j += 1
            if j - i > 3:
                kept += out[i:j]
            i = j
        else:
            kept.append(out[i]); i += 1
    out = kept
    if not any(l.startswith("| ") and not l.startswith("| -") and
               l.split("|")[1].split()[0].lower() != "scheme" for l in out):
        sys.exit(f"{src}: no row of {' '.join(sorted(schemes))} under {TITLES[t]}")
    os.makedirs(os.path.dirname(os.path.abspath(dst)), exist_ok=True)
    with open(dst, "w") as f:
        f.write("\n".join(out) + "\n")
    print(f"{dst}: {sum(1 for l in out if l.startswith('| ')) - 2 * sum(1 for l in out if l.startswith('## '))} rows")
