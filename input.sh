#!/bin/sh
# Read audio from the soundcard and distribute it by ZeroMQ.
# The PCH soundcard supports S16LE and S32LE formats, but the 32-bit data
# seems to be sampled with 24 bits, with the lowest 8 bits always zero.
# Thus, it can be converted to 24-bit samples without losing anything.
# TODO: Check if above is true for the DGX soundcard as well.
# At least it supports the same formats.

. ./common.sh

exec ffmpeg \
	-f alsa -acodec pcm_s32le -i hw:CARD=DGX,DEV=0 \
	$PUB_INPUT
