#!/usr/bin/env python3
"""
Builds all of the binaries without flashing them.
"""

from interface import M4Settings
from mupq import mupq


if __name__ == "__main__":
    mupq.BuildAll(M4Settings()).test_all()
