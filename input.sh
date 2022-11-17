#!/bin/sh
# Read audio from the soundcard and distribute it by ZeroMQ.

exec ffmpeg \
	-f alsa -acodec pcm_s32le -i "plughw:CARD=T6,DEV=0" \
	-f s24be zmq:tcp://*:42011
