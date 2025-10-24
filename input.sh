#!/bin/sh
# Read audio from the soundcard and distribute it by ZeroMQ.

. ./common.sh

# Traktor Audio 6 USB audio interface is hw:CARD=T6,DEV=0
# It has 6 channels and does not directly support 2-channel recording.
# ALSA will convert it to stereo if "plughw" is used instead of "hw".
# A better way might be to use ffmpeg (or whatever)
# to pick the correct channels from those 6.
# This works though.
exec ffmpeg \
	-f alsa -acodec pcm_s32le -i "plughw:CARD=T6,DEV=0" \
	$PUB_INPUT
