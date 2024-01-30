#!/bin/sh
# Read audio sent by input.sh
# and send it to Icecast.

. ./common.sh
. ./icecast_address.sh

while true
do
ffmpeg \
	-nostats \
	$SUB_INPUT \
	-f ogg -acodec libopus -ab 256000 \
	-content_type application/ogg \
	-ice_name "Clubroom stream (unprocessed)" \
	-ice_description "Unprocessed stream. Primarily used for recordings to be processed later" \
	"icecast://${ICECAST_ADDRESS}_unprocessed.opus" \

done

