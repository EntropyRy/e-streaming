#!/bin/sh

# Read audio sent by input.sh,
# process it and send to another ZeroMQ address.

level_in=3
ffmpeg \
	-f s24be -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42011 \
	-filter "highpass=f=20,alimiter=level_in=${level_in}:limit=0.95" \
	-f s24be zmq:tcp://*:42012
