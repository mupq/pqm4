#!/usr/bin/env python3
from mupq import mupq
from interface import parse_arguments, get_platform

if __name__ == "__main__":
    args, rest = parse_arguments()
    platform, settings = get_platform(args)
    with platform:
        test = mupq.TestVectors(settings, platform)
        test.test_all(rest)
