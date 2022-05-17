#!/bin/sh
# Read audio sent by input.sh
# and send it to Icecast.

. ./icecast_address.sh

while true
do
ffmpeg \
	-f s24be -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42011 \
	-f ogg -acodec flac \
	-content_type application/ogg \
	-ice_name "Clubroom stream (unprocessed)" \
	-ice_description "Unprocessed high quality stream. Primarily used for recordings to be processed later" \
	"icecast://${ICECAST_ADDRESS}_unprocessed.flac" \

done
