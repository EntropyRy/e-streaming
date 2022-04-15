#!/bin/sh
# Read processed audio from the multicast stream sent by process.sh
# and send it to Icecast.

# ICECAST_ADDRESS should be set like:
# ICECAST_ADDRESS=source:PASSWORD@ADDRESS:PORT
. ./icecast_address.sh

exec ffmpeg \
-protocol_whitelist file,udp,rtp -f sdp -i processedstream.sdp \
-acodec libmp3lame -ab 160000 -content_type application/ogg "icecast://${ICECAST_ADDRESS}/kerde.mp3"

