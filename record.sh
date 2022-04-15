#!/bin/sh
# Read audio sent by input.sh
# and record it to a file.

ffmpeg \
	-f s24be -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42011 \
	-acodec pcm_s24le test_$(date +%s).wav
