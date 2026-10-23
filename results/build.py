#!/usr/bin/env python3
# Regenerate results/<type>/summary.md (the reproduced rows, in the format of
# the old benchmarks.md) and results/<type>/<family>.md (one per reproduced
# family) from the records alone. legacy.md is never written here.
# One record per family and type, in <runs>/<family>/<type>/:
#   converted.md    that type's section of `convert_benchmarks.py md`, the
#                   family's rows only (written by results/record.py)
#   conditions.txt  date, pqm4 commit, mupq commit, toolchain
#   commands.txt    the commands that reproduce the record, at the measured
#                   commit, from the run to this script
# A re-measurement replaces the record's folder.
# Usage: python3 results/build.py <runs> <results>
#   reads the records under <runs>, writes <results>/<type>/summary.md and
#   <results>/<type>/<family>.md; e.g. python3 results/build.py results/runs results
import os, re, sys
if len(sys.argv) != 3:
    sys.exit("usage: build.py <runs> <results>")
RUNS, RESULTS = sys.argv[1], sys.argv[2]
TYPES = {"speed": "Speed Evaluation", "stack": "Memory Evaluation",
         "hashing": "Hashing Evaluation", "size": "Size Evaluation"}

def sections(text):
    """'## Sub' -> non-empty lines, within the one '# ' section of a record."""
    out, sub = {}, None
    for line in text.splitlines():
        if line.startswith("## "):
            sub = line[3:].strip(); out[sub] = []
        elif sub and line.strip():
            out[sub].append(line)
    return out

def load(r):
    cmds = open(f"{r}/commands.txt").read().rstrip("\n")
    return dict(tables=sections(open(f"{r}/converted.md").read()),
                cond=open(f"{r}/conditions.txt").read().splitlines(),
                cmds=cmds,
                iterations=re.search(r"benchmarks\.py .*-i (\d+)", cmds).group(1))

families = sorted(os.listdir(RUNS))
runs = {}
for fam in families:
    for t in TYPES:
        r = f"{RUNS}/{fam}/{t}"
        if not os.path.isdir(r):
            continue
        # a record cut by record.py before its conditions and commands are written
        # (a family recorded for the first time) is left out, not an error
        missing = [f for f in ("converted.md", "conditions.txt", "commands.txt")
                   if not os.path.isfile(f"{r}/{f}")]
        if missing:
            print(f"{r}: skipped, no {' or '.join(missing)}")
            continue
        runs[(fam, t)] = load(r)
families = sorted({fam for fam, _ in runs})

for stem, title in TYPES.items():
    out = f"{RESULTS}/{stem}"
    os.makedirs(out, exist_ok=True)
    mine = [runs[(fam, stem)] for fam in families if (fam, stem) in runs]
    summary = [f"# {title} (reproduced)"]
    for sub in ("Key Encapsulation Schemes", "Signature Schemes"):
        have = [run["tables"][sub] for run in mine if sub in run["tables"]]
        if have:
            summary += [f"## {sub}", *have[0][:2],
                        *[l for rows in have for l in rows[2:]]]
    with open(f"{out}/summary.md", "w") as f:
        f.write("\n".join(summary) + "\n")
    for fam in families:
        if (fam, stem) not in runs:
            continue
        run = runs[(fam, stem)]
        cond = run["cond"]
        gcc = next(l for l in cond if l.startswith("arm-none-eabi-gcc"))
        body = [f"# {title}: {fam}", "",
                f"- Commit: `{cond[1]}` (mupq `{cond[2]}`)",
                f"- Date: {cond[0]}",
                "- Platform: `nucleo-l4r5zi`",
                f"- Toolchain: {gcc}",
                "- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as"
                " one translation unit (`AIO=1`), no LTO"]
        if stem in ("speed", "hashing"):
            body.append("- Clock: 20 MHz (`CLOCK_BENCHMARK`)")
        if stem != "size":
            body.append(f"- Iterations: {run['iterations']}")
        for sub, rows in run["tables"].items():
            body += ["", f"## {sub}", "", *rows]
        body += ["", "## Reproducing", "", "```sh",
                 "git clone --recursive https://github.com/mupq/pqm4.git && cd pqm4",
                 f"git checkout {cond[1]}",
                 "git submodule update --init --recursive",
                 run["cmds"], "```", ""]
        with open(f"{out}/{fam}.md", "w") as f:
            f.write("\n".join(body))
print(f"{RESULTS}: {sum(1 for _ in runs)} records")
