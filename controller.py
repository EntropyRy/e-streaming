#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Script to stop streaming automatically when there is silence.
"""

import os

import numpy as np
import zmq

zctx = zmq.Context()


def stream_start():
    """Start streaming."""
    os.system('systemctl --user start es_streaming.target')

def stream_stop():
    """Stop streaming."""
    os.system('systemctl --user stop es_streaming.target')


class AudioIn:
    """Class to read audio shared using ZeroMQ."""
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

def main(blocksize = 12000, threshold = 2000000, silence_time = 480):
    audioin = AudioIn()
    # Start counter from silence_time to avoid unnecessarily
    # starting stream when the script is started.
    silence_counter = silence_time
    stream_on_prev = False
    running = True
    while running:
        amplitude = read_amplitude(audioin, blocksize)
        if amplitude >= threshold:
            # There is sound
            silence_counter = 0
            stream_on = True
            print('%10d sound' % (amplitude, ))
        elif silence_counter < silence_time:
            # There is silence but time has not been exceeded yet
            silence_counter += 1
            stream_on = True
            print('%10d silence %5d' % (amplitude, silence_counter))
        else:
            # Silence time has been exceeded
            stream_on = False
            print('%10d stopped' % (amplitude, ))

        if stream_on and (not stream_on_prev):
            print('Starting')
            stream_start()
        elif (not stream_on) and stream_on_prev:
            print('Stopping')
            stream_stop()

        stream_on_prev = stream_on

if __name__ == '__main__':
    main()

