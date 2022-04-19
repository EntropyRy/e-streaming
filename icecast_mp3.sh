#!/bin/sh
# Read processed audio sent by process.sh
# and send it to Icecast.

. ./icecast_address.sh

while true
do
ffmpeg \
	-f s24be -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42012 \
	-f mp3 -acodec libmp3lame -ab 160000 \
	-content_type audio/mpeg \
	"icecast://${ICECAST_ADDRESS}.mp3"
done

