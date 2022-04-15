#!/bin/sh

# Read audio from the multicast stream sent by input.sh,
# process it and send to another multicast stream.

# Currently, it does not actually do any processing.
# This is only for testing the multicast streaming trick first.

exec ffmpeg -protocol_whitelist file,udp,rtp \
-f sdp -i inputstream.sdp \
-f rtp -acodec pcm_s24be -sdp_file processedstream.sdp rtp://224.4.20.1:42002?localaddr=127.0.0.1
