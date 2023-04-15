#!/bin/sh
# Read processed audio sent by process.sh
# and send it to Icecast.

. ./common.sh
. ./icecast_address.sh

while true
do
ffmpeg \
	$SUB_PROCESSED \
	-f ogg -acodec libopus -ab 192000 \
	-content_type application/ogg \
	-ice_name "Clubroom stream" \
	-ice_description "Recommended stream for listening" \
	"icecast://${ICECAST_ADDRESS}.opus" \

done

