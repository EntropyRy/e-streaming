#!/bin/sh
# Read audio from the soundcard and distribute it by ZeroMQ.

. ./common.sh

exec ffmpeg \
	-f alsa -acodec pcm_s32le -i hw:CARD=DGX,DEV=0 \
	$PUB_INPUT
