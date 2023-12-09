#!/bin/sh

# Read audio sent by input.sh,
# process it and send to another ZeroMQ address.

. ./common.sh

level_in=40
ffmpeg \
	$SUB_INPUT \
	-filter "alimiter=level_in=${level_in}:limit=0.95" \
	$PUB_PROCESSED
