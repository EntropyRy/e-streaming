#!/bin/sh

. ./common.sh

case $1 in
	input)
		SUB="$SUB_INPUT"
		WINDOWTITLE="Input signal from soundcard"
		break
		;;
	processed)
		SUB="$SUB_PROCESSED"
		WINDOWTITLE="Processed signal to stream"
		break
		;;
	*)
		echo "To show either the input signal or processed signal, do:"
		echo "$0 input"
		echo "$0 processed"
		exit
		;;
esac
exec ffmpeg \
	$SUB \
	-lavfi "showwaves=mode=p2p:colors=White:split_channels=1:draw=full:rate=1" \
	-f sdl -window_title "$WINDOWTITLE" -

