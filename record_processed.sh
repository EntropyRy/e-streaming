#!/bin/sh
# Read audio sent by process.sh
# and record it to a file.

mkdir -p ../recordings/
exec ffmpeg \
	-f s24be -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42012 \
	-acodec flac "../recordings/recording_processed_$(date -Iseconds).flac"
