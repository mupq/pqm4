#!/usr/bin/env python3
from mupq import mupq
from interface import M4Settings, M4

if __name__ == "__main__":
    test = mupq.TestVectors(M4Settings(), M4())
    test.test_all()
