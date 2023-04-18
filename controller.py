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

def check_streaming_enabled():
    try:
        with open('streaming_enabled', 'r') as f:
            return int(f.read()) != 0
    except:
        return False

def main(blocksize = 12000, threshold = 2000000, silence_time = 1200):
    audioin = AudioIn()
    # Start counter from silence_time to avoid unnecessarily
    # starting stream when the script is started.
    silence_counter = silence_time
    streaming_enabled_prev = False
    stream_on_prev = False
    running = True
    while running:
        streaming_enabled = check_streaming_enabled()
        # If streaming was just enabled, reset the silence counter
        # so that streaming can start even if there is silence.
        if streaming_enabled and (not streaming_enabled_prev):
            silence_counter = 0

        amplitude = read_amplitude(audioin, blocksize)
        if amplitude >= threshold:
            # There is sound
            silence_counter = 0
            sound_ok = True
        elif silence_counter < silence_time:
            # There is silence but time has not been exceeded yet
            silence_counter += 1
            sound_ok = True
        else:
            # Silence time has been exceeded
            sound_ok = False

        stream_on = sound_ok and streaming_enabled

        if stream_on and (not stream_on_prev):
            stream_start()
        elif (not stream_on) and stream_on_prev:
            stream_stop()

        stream_on_prev = stream_on
        streaming_enabled_prev = streaming_enabled

def test_amplitude(blocksize = 12000):
    """Alternative main loop for testing amplitude levels."""
    audioin = AudioIn()
    while True:
        amplitude = read_amplitude(audioin, blocksize)
        print('%10d' % amplitude, flush=True)

if __name__ == '__main__':
    main()

