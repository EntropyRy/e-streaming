#!/bin/sh
# Read audio from the multicast stream sent by input.sh
# and send it to Icecast.

# ICECAST_ADDRESS should be set like:
# ICECAST_ADDRESS=source:PASSWORD@ADDRESS:PORT
. ./icecast_address.sh

exec ffmpeg \
-protocol_whitelist file,udp,rtp -f sdp -i inputstream.sdp \
-f ogg -acodec flac -content_type application/ogg "icecast://${ICECAST_ADDRESS}/kerde_unprocessed.flac"

