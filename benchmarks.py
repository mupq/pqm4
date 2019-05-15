#!/usr/bin/env python3
from mupq import mupq
from interface import M4Settings, M4

import sys

if __name__ == "__main__":
    with M4() as m4:
        if "--nostack" not in sys.argv:
            test = mupq.StackBenchmark(M4Settings(), m4)
            test.test_all(sys.argv[1:])

        if "--nospeed" not in sys.argv:
            test = mupq.SpeedBenchmark(M4Settings(), m4)
            test.test_all(sys.argv[1:])

        if "--nohashing" not in sys.argv:
            test = mupq.HashingBenchmark(M4Settings(), m4)
            test.test_all(sys.argv[1:])

        if "--nosize" not in sys.argv:
            test = mupq.SizeBenchmark(M4Settings(), m4)
            test.test_all(sys.argv[1:])
