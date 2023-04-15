#!/bin/sh
# Read audio sent by input.sh
# and record it to a file.

. ./common.sh

mkdir -p ../recordings/
exec ffmpeg \
	$SUB_INPUT \
	-acodec flac "../recordings/recording_$(date -Iseconds).flac"
