#!/usr/bin/env python3
from mupq import mupq
from interface import parse_arguments, get_platform

if __name__ == "__main__":
    args, rest = parse_arguments()
    platform, settings = get_platform(args)
    with platform:
        if "--nostack" not in rest:
            test = mupq.StackBenchmark(settings, platform)
            test.test_all(rest)

        if "--nospeed" not in rest:
            test = mupq.SpeedBenchmark(settings, platform)
            test.test_all(rest)

        if "--nohashing" not in rest:
            test = mupq.HashingBenchmark(settings, platform)
            test.test_all(rest)

        if "--nosize" not in rest:
            test = mupq.SizeBenchmark(settings, platform)
            test.test_all(rest)
