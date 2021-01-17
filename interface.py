import abc
import argparse

import serial
import select
import subprocess
import re

from mupq import mupq
import logging


def parse_arguments():
    parser = argparse.ArgumentParser(description="PQM4 Specific Settings")
    parser.add_argument(
        "-p",
        "--platform",
        help="The PQM4 platform",
        choices=["stm32f4discovery", "nucleo-l476rg", "cw308t-stm32f3", "mps2-an386"],
        default="stm32f4discovery",
    )
    parser.add_argument(
        "-o",
        "--opt",
        help="Optimization flags",
        choices=["speed", "size", "debug"],
        default="speed",
    )
    parser.add_argument(
        "-l", "--lto", help="Enable LTO flags", default=False, action="store_true"
    )
    parser.add_argument(
        "-a", "--aio", help="Enable all-in-one compilation", default=False, action="store_true"
    )
    parser.add_argument("-u", "--uart", help="Path to UART output")
    return parser.parse_known_args()


def get_platform(args):
    platform = None
    bin_type = 'bin'
    allschemes = False
    if args.platform in ['stm32f4discovery', 'nucleo-l476rg']:
        platform = StLink(args.uart)
    elif args.platform == "cw308t-stm32f3":
        bin_type = 'hex'
        platform = ChipWhisperer()
    elif args.platform == 'mps2-an386':
        bin_type = 'bin'
        platform = Qemu('mps2-an386')
        allschemes = True
    else:
        raise NotImplementedError("Unsupported Platform")
    settings = M4Settings(args.platform, args.opt, args.lto, args.aio, bin_type, allschemes)
    return platform, settings


class M4Settings(mupq.PlatformSettings):
    #: Specify folders to include
    scheme_folders = [  # mupq.PlatformSettings.scheme_folders + [
        ("pqm4", "crypto_kem", ""),
        ("pqm4", "crypto_sign", ""),
        ("mupq", "mupq/crypto_kem", ""),
        ("mupq", "mupq/crypto_sign", ""),
        ("pqclean", "mupq/pqclean/crypto_kem", "PQCLEAN"),
        ("pqclean", "mupq/pqclean/crypto_sign", "PQCLEAN"),
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

    def __init__(self, platform, opt="speed", lto=False, aio=False, binary_type='bin', allschemes=False):
        if allschemes:
            self.skip_list = ()
        """Initialize with a specific platform"""
        self.binary_type = binary_type
        optflags = {"speed": [], "size": ["OPT_SIZE=1"], "debug": ["DEBUG=1"]}
        if opt not in optflags:
            raise ValueError(f"Optimization flag should be in {list(optflags.keys())}")
        super(M4Settings, self).__init__()
        self.makeflags = [f"PLATFORM={platform}"]
        self.makeflags += optflags[opt]
        if lto:
            self.makeflags += ["LTO=1"]
        if aio:
            self.makeflags += ["AIO=1"]


class Qemu(mupq.Platform):

    start_pat = re.compile(b'.*={4,}\n', re.DOTALL)
    end_pat = re.compile(b'#\n', re.DOTALL)

    def __init__(self, machine):
        super().__init__()
        self.machine = machine
        self.platformname = "qemu"

    def __enter__(self):
        return super().__enter__()

    def __exit__(self, *args, **kwargs):
        return super().__exit__(*args, **kwargs)

    def run(self, binary_path):
        args = [
            "qemu-system-arm",
            "-M",
            self.machine,
            "-nographic",
            "-semihosting",
            "-kernel",
            binary_path,
        ]
        self.log.info(f'Running QEMU: {" ".join(args)}')
        output = subprocess.check_output(args,
                                         stdin=subprocess.DEVNULL)
        start = self.start_pat.search(output)
        end = self.end_pat.search(output, start.end())
        if end is None:
            raise Exception('QEMU execution failed!')
        return output[start.end():end.start()].decode('utf-8', 'ignore')


class SerialCommsPlatform(mupq.Platform):

    # Start pattern is at least five equal signs
    start_pat = re.compile(b'.*={4,}\n', re.DOTALL)

    def __init__(self, tty="/dev/ttyACM0", baud=38400, timeout=60):
        super().__init__()
        self._dev = serial.Serial(tty, baud, timeout=timeout)

    def __enter__(self):
        return super().__enter__()

    def __exit__(self, *args, **kwargs):
        self._dev.close()
        return super().__exit__(*args, **kwargs)

    def run(self, binary_path):
        self.flash(binary_path)
        self._dev.reset_input_buffer()
        # Wait for the first equal sign
        if self._dev.read_until(b'=') != b'=':
            raise Exception('Timout waiting for start')
        # Wait for the end of the equal delimiter
        start = self._dev.read_until(b'\n')
        self.log.debug(f'Found start pattern: {start}')
        if self.start_pat.fullmatch(start) is None:
            raise Exception('Start does not match')
        # Wait for the end
        output = bytearray()
        while len(output) == 0 or output[-1] != b'#'[0]:
            data = self._dev.read_until(b'#')
            output.extend(data)
        return output[:-1].decode('utf-8', 'ignore')

    @abc.abstractmethod
    def flash(self, binary_path):
        pass


class OpenOCD(SerialCommsPlatform):
    def __init__(self, script, tty="/dev/ttyACM0", baud=38400, timeout=60):
        super().__init__(tty, baud, timeout)
        self.script = script

    def flash(self, binary_path):
        subprocess.check_call(
            ["openocd", "-f", self.script, "-c", f"program {binary_path} verify reset exit"],
            # stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )


class StLink(SerialCommsPlatform):
    def flash(self, binary_path):
        subprocess.check_call(
            ["st-flash", "--reset", "write", binary_path, "0x8000000"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )


try:
    import chipwhisperer as cw
    import time
    HAS_CW = True
except ImportError:
    pass


class ChipWhisperer(mupq.Platform):

    # Start pattern is at least five equal signs
    start_pat = re.compile('.*={4,}\n', re.DOTALL)
    # End pattern is a hash with a newline
    end_pat = re.compile('.*#\n', re.DOTALL)

    def __init__(self):
        super().__init__()
        self.platformname = "cw"
        self.scope = cw.scope()
        self.target = cw.target(self.scope)
        self.scope.default_setup()

    def __enter__(self):
        return super().__enter__()

    def __exit__(self, *args, **kwargs):
        self.target.close()
        return super().__exit__(*args, **kwargs)

    def device(self):
        return self.wrapper

    def reset_target(self):
        self.scope.io.nrst = 'low'
        time.sleep(0.05)
        self.scope.io.nrst = 'high'
        time.sleep(0.05)

    def flash(self, binary_path):
        prog = cw.programmers.STM32FProgrammer()
        prog.scope = self.scope
        prog.open()
        prog.find()
        prog.erase()
        prog.program(binary_path, memtype="flash", verify=False)
        prog.close()

    def run(self, binary_path):
        self.flash(binary_path)
        self.target.flush()
        self.reset_target()
        data = ''
        # Wait for the first equal sign
        while '=' not in data:
            data += self.target.read()
        # Wait for the end of the equal delimiter
        match = None
        while match is None:
            data += self.target.read()
            match = self.start_pat.match(data)
        # Remove the start pattern
        data = data[:match.end()]
        # Wait for the end
        match = None
        while match is None:
            data += self.target.read()
            match = self.end_pat.match(data)
        # Remove stop pattern and return
        return data[:match.end() - 2]


# logging.getLogger().setLevel(logging.DEBUG)
