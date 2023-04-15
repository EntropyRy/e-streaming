#!/bin/sh
# Shell script would not be really needed here since a service could
# just directly start the python script.
# Starting it from a shell script, however, makes it more consistent with
# other scripts and minimizes additions needed to install_services.sh.
exec python3 controller.py
