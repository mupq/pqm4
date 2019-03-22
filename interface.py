import subprocess

import serial

from mupq import mupq


class M4Settings(mupq.PlatformSettings):
    #: Specify folders to include
    scheme_folders = [  # mupq.PlatformSettings.scheme_folders + [
        ('pqm4', 'crypto_kem'),
        ('pqm4', 'crypto_sign'),
    ]

    #: List of dicts, in each dict specify (Scheme class) attributes of the
    #: scheme with values, if all attributes match the scheme is skipped.
    skip_list = (
        {'scheme': 'frodo640-aes', 'implementation': 'ref'},
        {'scheme': 'frodo640-cshake', 'implementation': 'ref'},
    )


dev = serial.Serial("/dev/ttyUSB0", 115200, timeout=10)


class M4(mupq.Platform):

    def device(self):
        return dev

    def flash(self, binary_path):
        super().flash(binary_path)
        subprocess.check_call(
            ["st-flash", "--reset", "write", binary_path, "0x8000000"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
