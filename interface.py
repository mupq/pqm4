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
        {'scheme': 'falcon-1024-tree', 'implementation': 'opt-leaktime'},
        {'scheme': 'falcon-1024-tree', 'implementation': 'opt-ct'},
        {'scheme': 'frodokem640aes', 'implementation': 'clean'},
        {'scheme': 'frodokem640aes', 'implementation': 'opt'},
        {'scheme': 'frodokem976aes', 'implementation': 'clean'},
        {'scheme': 'frodokem976aes', 'implementation': 'opt'},
        {'scheme': 'frodokem1344aes', 'implementation': 'clean'},
        {'scheme': 'frodokem1344aes', 'implementation': 'opt'},
        {'scheme': 'frodokem640shake', 'implementation': 'clean'},
        {'scheme': 'frodokem976shake', 'implementation': 'clean'},
        {'scheme': 'frodokem976shake', 'implementation': 'opt'},
        {'scheme': 'frodokem1344shake', 'implementation': 'clean'},
        {'scheme': 'frodokem1344shake', 'implementation': 'opt'},
        {'scheme': 'rainbowI-classic', 'implementation': 'clean'},
        {'scheme': 'rainbowI-circumzenithal', 'implementation': 'clean'},
        {'scheme': 'rainbowI-compressed', 'implementation': 'clean'},
        {'scheme': 'rainbowIII-classic', 'implementation': 'clean'},
        {'scheme': 'rainbowIII-circumzenithal', 'implementation': 'clean'},
        {'scheme': 'rainbowIII-compressed', 'implementation': 'clean'},
        {'scheme': 'rainbowV-classic', 'implementation': 'clean'},
        {'scheme': 'rainbowV-circumzenithal', 'implementation': 'clean'},
        {'scheme': 'rainbowV-compressed', 'implementation': 'clean'},
        {'scheme': 'mceliece348864', 'implementation': 'clean'},
        {'scheme': 'mceliece348864f', 'implementation': 'clean'},
        {'scheme': 'mceliece460896', 'implementation': 'clean'},
        {'scheme': 'mceliece460896f', 'implementation': 'clean'},
        {'scheme': 'mceliece6688128', 'implementation': 'clean'},
        {'scheme': 'mceliece6688128f', 'implementation': 'clean'},
        {'scheme': 'mceliece6960119', 'implementation': 'clean'},
        {'scheme': 'mceliece6960119f', 'implementation': 'clean'},
        {'scheme': 'mceliece8192128', 'implementation': 'clean'},
        {'scheme': 'mceliece8192128f', 'implementation': 'clean'},
        {'scheme': 'mceliece348864', 'implementation': 'vec'},
        {'scheme': 'mceliece348864f', 'implementation': 'vec'},
        {'scheme': 'mceliece460896', 'implementation': 'vec'},
        {'scheme': 'mceliece460896f', 'implementation': 'vec'},
        {'scheme': 'mceliece6688128', 'implementation': 'vec'},
        {'scheme': 'mceliece6688128f', 'implementation': 'vec'},
        {'scheme': 'mceliece6960119', 'implementation': 'vec'},
        {'scheme': 'mceliece6960119f', 'implementation': 'vec'},
        {'scheme': 'mceliece8192128', 'implementation': 'vec'},
        {'scheme': 'mceliece8192128f', 'implementation': 'vec'},
        {'scheme': 'hqc-rmrs-192', 'implementation': 'clean'},
        {'scheme': 'hqc-rmrs-256', 'implementation': 'clean'},
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
