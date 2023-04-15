#!/bin/sh
# Read processed audio sent by process.sh
# and send it to Icecast.

. ./common.sh
. ./icecast_address.sh

while true
do
ffmpeg \
	$SUB_PROCESSED \
	-f mp3 -acodec libmp3lame -ab 320000 \
	-content_type audio/mpeg \
	-ice_name "Clubroom stream (mp3)" \
	-ice_description "Alternative for old phones that don't support the Opus codec" \
	"icecast://${ICECAST_ADDRESS}.mp3" \

done

