import argparse

from mupq import mupq
from mupq import platforms


def parse_arguments():
    parser = argparse.ArgumentParser(description="PQM4 Specific Settings")
    parser.add_argument(
        "-p",
        "--platform",
        help="The PQM4 platform",
        choices=["stm32f4discovery", "nucleo-l476rg", "nucleo-l4r5zi", "cw308t-stm32f3", "cw308t-stm32f415", "mps2-an386"],
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
        "--no-aio", help="Disable all-in-one compilation", default=False, action="store_true"
    )
    parser.add_argument("-u", "--uart", default="/dev/ttyUSB0", help="Path to UART output")
    parser.add_argument("-i", "--iterations", type=int, default=1, help="Number of iterations for benchmarks")
    return parser.parse_known_args()


def get_platform(args):
    platform = None
    bin_type = 'bin'
    if args.platform in ['stm32f4discovery', 'nucleo-l476rg']:
        platform = platforms.StLink(args.uart)
    elif args.platform == "nucleo-l4r5zi":
        bin_type = 'hex'
        platform = platforms.OpenOCD("st_nucleo_l4r5.cfg", args.uart)
    elif args.platform in ["cw308t-stm32f3", "cw308t-stm32f415"]:
        bin_type = 'hex'
        platform = platforms.ChipWhisperer()
    elif args.platform == 'mps2-an386':
        bin_type = 'bin'
        platform = platforms.Qemu('qemu-system-arm', 'mps2-an386')
    else:
        raise NotImplementedError("Unsupported Platform")
    settings = M4Settings(args.platform, args.opt, args.lto, not args.no_aio, args.iterations, bin_type)
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

    platform_memory = {
        'stm32f4discovery': 128*1024,
        'nucleo-l476rg': 128*1024,
        'cw308t-stm32f3': 64*1024,
        'cw308t-stm32f415': 192*1024,
        'mps2-an386': 4096*1024,
        'nucleo-l4r5zi': 640*1024
    }

    def __init__(self, platform, opt="speed", lto=False, aio=False, iterations=1, binary_type='bin'):
        """Initialize with a specific platform"""
        import skiplist
        self.skip_list = []
        for impl in skiplist.skip_list:
            if impl['estmemory'] > self.platform_memory[platform]:
                impl = impl.copy()
                del impl['estmemory']
                self.skip_list.append(impl)
        self.skip_list.append({'implementation': 'vec'})
        self.binary_type = binary_type
        optflags = {"speed": [], "size": ["OPT_SIZE=1"], "debug": ["DEBUG=1"]}
        if opt not in optflags:
            raise ValueError(f"Optimization flag should be in {list(optflags.keys())}")
        super(M4Settings, self).__init__()
        self.makeflags = [f"PLATFORM={platform}"]
        self.makeflags += [f"MUPQ_ITERATIONS={iterations}"]
        self.makeflags += optflags[opt]
        self.iterations = iterations
        if lto:
            self.makeflags += ["LTO=1"]
        else:
            self.makeflags += ["LTO="]
        if aio:
            self.makeflags += ["AIO=1"]
        else:
            self.makeflags += ["AIO="]
