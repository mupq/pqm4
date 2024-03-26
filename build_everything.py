#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0 or CC0-1.0
"""
Builds all of the binaries without flashing them.
"""
import sys

from interface import parse_arguments, get_platform
from mupq import mupq


if __name__ == "__main__":
    args, rest = parse_arguments()
    platform, settings = get_platform(args)
    with platform:
        mupq.BuildAll(settings).test_all(rest)
