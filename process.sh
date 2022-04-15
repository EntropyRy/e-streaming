#!/bin/sh

# Read audio sent by input.sh,
# process it and send to another ZeroMQ address.

# Currently, it does not actually do any processing.
# This is only for testing the ZeroMQ tricks first.

ffmpeg \
	-f s24be -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42011 \
	-filter "alimiter=level_in=3:limit=0.95" \
	-f s24be zmq:tcp://*:42012
