#!/bin/sh
case $1 in
	input)
		ZMQPORT=42011
		WINDOWTITLE="Input signal from soundcard"
		break
		;;
	processed)
		ZMQPORT=42012
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
	-f s24be -ar 48000 -ac 2 -i "zmq:tcp://127.0.0.1:$ZMQPORT" \
	-lavfi "showwaves=mode=p2p:colors=White:split_channels=1:draw=full:rate=1" \
	-f sdl -window_title "$WINDOWTITLE" -

