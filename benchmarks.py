#!/usr/bin/env python3
from mupq import mupq
from interface import parse_arguments, get_platform
import sys

if __name__ == "__main__":
    args, rest = parse_arguments()
    platform, settings = get_platform(args)
    with platform:
        schemes = [s for s in rest if s not in ['--nostack',
                                                '--nospeed',
                                                '--nohashing',
                                                '--nosize']]
        if "--nostack" not in rest:
            test = mupq.StackBenchmark(settings, platform)
            if test.test_all(schemes):
                sys.exit(1)

        if "--nospeed" not in rest:
            test = mupq.SpeedBenchmark(settings, platform)
            if test.test_all(schemes):
                sys.exit(1)

        if "--nohashing" not in rest:
            test = mupq.HashingBenchmark(settings, platform)
            if test.test_all(schemes):
                sys.exit(1)

        if "--nosize" not in rest:
            test = mupq.SizeBenchmark(settings, platform)
            if test.test_all(schemes):
                sys.exit(1)
