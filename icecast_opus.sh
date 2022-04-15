#!/bin/sh
# Read processed audio sent by process.sh
# and send it to Icecast.

# ICECAST_ADDRESS should be set like:
# ICECAST_ADDRESS=source:PASSWORD@ADDRESS:PORT
. ./icecast_address.sh

exec ffmpeg \
	-f s24be -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42012 \
	-f ogg -acodec libopus -ab 160000 \
	-content_type application/ogg \
	"icecast://${ICECAST_ADDRESS}/kerde.opus"

