import subprocess
import logging

import serial

dev = serial.Serial("/dev/ttyUSB0", 115200, timeout=10)

class Platform(object):
    """Implements the M4 platform"""

    def __init__(self, binary_path):
        self.log = logging.getLogger("m4 interface")
        self.binary_path = binary_path

    def _flash(self):
        self.log.info("Flashing %s to device", self.binary_path)
        self.state = 'waiting'
        self.equals_seen = 0
        subprocess.check_call(
            ["st-flash", "--reset", "write", self.binary_path, "0x8000000"],
        )

    def run(self):
        """Runs the flashed target and collects the result"""
        self._flash()
        self._wait_for_start()
        self.log.info("Output started")
        return self._read_output()

    def _wait_for_start(self):
        """Waits until we read five equals signs"""
        while self.state == 'waiting':
            x = dev.read()
            if x == b'':
                self.log.warning(
                    "timed out while waiting for the markers, reflashing")
                self._flash()
            elif x == b'=':
                self.equals_seen += 1
                continue
            elif self.equals_seen > 5:
                self.state = 'beginning'
                self.log.debug("Found output marker")
            elif self.equals_seen > 1:
                logging.warning(
                    "Got garbage after finding first equals sign, restarting"
                )
                self._flash()
        # Read remaining = signs
        while self.state == 'beginning':
            x = dev.read()
            # Consume remaining =
            if x != b'=':
                self.state = 'reading'
                break

    def _read_output(self):
        output = []
        while self.state == 'reading':
            x = dev.read()
            if x == b'#':
                self.state = 'done'
                break
            elif x != b'':
                output.append(x)
        output = b''.join(output).decode('utf-8', 'ignore')
        # sometimes there's a line full of markers; strip out to avoid errors
        lines = (x for x in output.split('\n') if not all(c == '=' for c in x))
        return "{}\n".format('\n'.join(lines))
