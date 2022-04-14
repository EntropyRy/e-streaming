#!/bin/sh
# Read audio from the multicast stream sent by input.sh
# and send it to Icecast.

# ICECAST_ADDRESS should be set like:
# ICECAST_ADDRESS=source:STREAM_USERNAME@ADDRESS:PORT

exec ffmpeg \
-protocol_whitelist file,udp,rtp -f sdp -i inputstream.sdp \
-acodec libopus -ab 160000 -content_type application/ogg "icecast://${ICECAST_ADDRESS}/test.opus"

