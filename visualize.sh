#!/bin/sh
ffmpeg -f s24be -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42011 -lavfi "showwaves=mode=p2p:colors=White:rate=3" -f sdl - &
ffmpeg -f s24be -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42012 -lavfi "showwaves=mode=p2p:colors=White:rate=3" -f sdl - &

