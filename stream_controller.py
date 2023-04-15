#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Script to stop streaming automatically when there is silence.
"""

import numpy as np
import zmq

zctx = zmq.Context()

class AudioIn:
    def __init__(self, addr = 'tcp://127.0.0.1:42011'):
        self.socket = zctx.socket(zmq.SUB)
        self.socket.connect(addr)
        self.socket.subscribe(b'')

    def read(self):
        """Read audio input and return it as a numpy array."""
        return np.frombuffer(self.socket.recv(), dtype=np.int32)

def read_amplitude(audioin, n):
    """Read approximately n samples from audioin
    and return their mean amplitude."""
    accumulator = 0
    blocks_read = 0
    samples_read = 0
    # It is stereo with two numbers per sample,
    # so we want twice the number.
    n *= 2
    while samples_read < n:
        samples = audioin.read()
        accumulator += np.mean(np.abs(samples))
        samples_read += len(samples)
        blocks_read += 1
    return accumulator // blocks_read

def main(blocksize = 12000, threshold = 1000000):
    audioin = AudioIn()
    running = True
    while running:
        amplitude = read_amplitude(audioin, blocksize)
        # Test
        print('%20d: %s' % (amplitude, amplitude >= threshold))

if __name__ == '__main__':
    main()

