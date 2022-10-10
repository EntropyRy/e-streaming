#!/bin/sh
set -e

############################# List of services ##############################

# Services that can always be running
SERVICES_BASE="input process"
# Services that are started when streaming is on
SERVICES_STREAMING="icecast_unprocessed icecast_unprocessed_opus icecast_opus icecast_mp3 icecast_aac record"
# Services to be enabled
SERVICES_ENABLED="${SERVICES_BASE} icecast_unprocessed icecast_opus icecast_mp3"

############################# Paths #########################################

SERVICE_DIR="${HOME}/.config/systemd/user"
SCRIPT_DIR="$(pwd)"

mkdir -p "${SERVICE_DIR}"

#############################################################################

# Write a service file.
# First argument is the name of the script file but without the .sh suffix.
# Second argument is the target to which the service belongs.
write_service()
{
	SERVICE_NAME="es_$1.service"
	SERVICE_FILE="${SERVICE_DIR}/${SERVICE_NAME}"
	SCRIPT_FILE="${SCRIPT_DIR}/$1.sh"
	echo Writing "${SERVICE_FILE}"
	cat > "${SERVICE_FILE}"  <<EOF
[Unit]
Description=e-streaming: $1
PartOf=$2

[Service]
WorkingDirectory=${SCRIPT_DIR}
ExecStart=${SCRIPT_FILE}

StandardOutput=journal
StandardError=journal

Restart=always

[Install]
WantedBy=$2

EOF
}

enable_service()
{
	SERVICE_NAME="es_$1.service"
	echo Enabling "${SERVICE_NAME}"
	systemctl --user enable "${SERVICE_NAME}"
}

############################# Target files ##################################

echo "Writing target files"

cat > "${SERVICE_DIR}/es_base.target" <<EOF
[Unit]
Description=e-streaming: Base services

[Install]
WantedBy=default.target
EOF


cat > "${SERVICE_DIR}/es_streaming.target" <<EOF
[Unit]
Description=e-streaming: Streaming on
EOF

#############################################################################

for name in ${SERVICES_BASE}
do
	write_service "$name" es_base.target
done

for name in ${SERVICES_STREAMING}
do
	write_service "$name" es_streaming.target
done

#############################################################################

echo "Service files written. Running daemon-reload"
systemctl --user daemon-reload

#############################################################################

for name in ${SERVICES_ENABLED}
do
	enable_service "$name"
done

systemctl --user enable es_base.target

