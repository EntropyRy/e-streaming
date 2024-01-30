#!/bin/sh
# Read processed audio sent by process.sh
# and send it to Icecast.

. ./common.sh
. ./icecast_address.sh

while true
do
ffmpeg \
	-nostats \
	$SUB_PROCESSED \
	-f mp3 -acodec libmp3lame -ab 160000 \
	-content_type audio/aac \
	-ice_name "Clubroom stream (aac)" \
	-ice_description "Alternative for old phones that don't support the Opus codec" \
	"icecast://${ICECAST_ADDRESS}.aac" \

done

