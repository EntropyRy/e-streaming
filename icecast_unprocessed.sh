#!/bin/sh
# Read audio sent by input.sh
# and send it to Icecast.

. ./common.sh
. ./icecast_address.sh

while true
do
ffmpeg \
	$SUB_INPUT \
	-f ogg -acodec flac \
	-content_type application/ogg \
	-ice_name "Clubroom stream (unprocessed)" \
	-ice_description "Unprocessed high quality stream. Primarily used for recordings to be processed later" \
	"icecast://${ICECAST_ADDRESS}_unprocessed.flac" \

done
