#!/bin/sh
# Read audio from the soundcard and distribute it by ZeroMQ.
# The PCH soundcard supports S16LE and S32LE formats, but the 32-bit data
# seems to be sampled with 24 bits, with the lowest 8 bits always zero.
# Thus, it can be converted to 24-bit samples without losing anything.

exec ffmpeg \
	-f alsa -acodec pcm_s32le -i hw:CARD=PCH,DEV=0 \
	-f s24be zmq:tcp://*:42011
