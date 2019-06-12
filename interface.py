import subprocess

import serial

from mupq import mupq


class M4Settings(mupq.PlatformSettings):
    #: Specify folders to include
    scheme_folders = [  # mupq.PlatformSettings.scheme_folders + [
        ('pqm4', 'crypto_kem', ''),
        ('pqm4', 'crypto_sign', ''),
        ('mupq', 'mupq/crypto_kem', ''),
        ('mupq', 'mupq/crypto_sign', ''),
        ('pqclean', 'mupq/pqclean/crypto_kem', "PQCLEAN"),
        ('pqclean', 'mupq/pqclean/crypto_sign', "PQCLEAN"),
    ]

    #: List of dicts, in each dict specify (Scheme class) attributes of the
    #: scheme with values, if all attributes match the scheme is skipped.
    skip_list = (
        {'scheme': 'frodokem640aes', 'implementation': 'clean'},
        {'scheme': 'frodokem976aes', 'implementation': 'clean'},
        {'scheme': 'frodokem1344aes', 'implementation': 'clean'},
        {'scheme': 'frodokem640shake', 'implementation': 'clean'},
        {'scheme': 'frodokem976shake', 'implementation': 'clean'},
        {'scheme': 'frodokem1344shake', 'implementation': 'clean'},
        {'scheme': 'mqdss-48', 'implementation': 'clean'},
        {'scheme': 'mqdss-64', 'implementation': 'clean'},
        {'scheme': 'luov-80-76-363-chacha', 'implementation': 'ref'},
        {'scheme': 'luov-80-76-363-keccak', 'implementation': 'ref'},
        {'scheme': 'luov-8-82-323-chacha', 'implementation': 'ref'},
        {'scheme': 'luov-8-82-323-keccak', 'implementation': 'ref'},
        {'scheme': 'luov-8-107-371-chacha', 'implementation': 'ref'},
        {'scheme': 'luov-8-107-371-keccak', 'implementation': 'ref'},
    )


class M4(mupq.Platform):

    def __enter__(self):
        self._dev = serial.Serial("/dev/ttyUSB0", 115200, timeout=10)
        return super().__enter__()

    def __exit__(self,*args, **kwargs):
        self._dev.close()
        return super().__exit__(*args, **kwargs)

    def device(self):
        return self._dev

    def flash(self, binary_path):
        super().flash(binary_path)
        subprocess.check_call(
            ["st-flash", "--reset", "write", binary_path, "0x8000000"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
