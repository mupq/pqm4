#!/usr/bin/env python3
from mupq import mupq
from interface import M4Settings, M4

if __name__ == "__main__":
    with M4() as m4:
        test = mupq.TestVectors(M4Settings(), m4)
        test.test_all()
