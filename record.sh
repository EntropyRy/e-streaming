#!/bin/sh
# Read audio from the multicast stream sent by input.sh
# and record it to a file.
# This is useful for testing the multicast stream.

exec ffmpeg -protocol_whitelist file,udp,rtp -f sdp -i inputstream.sdp test_$(date +%s).wav
