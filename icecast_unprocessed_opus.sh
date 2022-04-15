#!/bin/sh
# Read audio sent by input.sh
# and send it to Icecast.

# ICECAST_ADDRESS should be set like:
# ICECAST_ADDRESS=source:PASSWORD@ADDRESS:PORT
. ./icecast_address.sh

while true
do
ffmpeg \
	-f s24be -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42011 \
	-f ogg -acodec libopus -ab 160000 \
	-content_type application/ogg \
	"icecast://${ICECAST_ADDRESS}/kerde_unprocessed.opus"
done

