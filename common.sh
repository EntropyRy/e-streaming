#!/bin/sh
# Common things used by multiple scripts.
#


# ffmpeg parameters to publish input audio from soundcard
PUB_INPUT='-f s32le zmq:tcp://*:42011'
# ffmpeg parameters to subscribe to above
SUB_INPUT='-f s32le -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42011'

# ffmpeg parameters to publish processed audio
PUB_PROCESSED='-f s32le zmq:tcp://*:42012'
# ffmpeg parameters to subscribe to above
SUB_PROCESSED='-f s32le -ar 48000 -ac 2 -i zmq:tcp://127.0.0.1:42012'


