#!/bin/sh
# Read audio sent by process.sh
# and record it to a file.

. ./common.sh

mkdir -p ../recordings/
exec ffmpeg \
	$SUB_PROCESSED \
	-acodec flac "../recordings/recording_processed_$(date -Iseconds).flac"
