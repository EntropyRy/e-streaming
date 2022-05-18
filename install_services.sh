#!/bin/sh
# Services that can always be running
SERVICES_ALWAYS="input process"
# Services that are started when streaming is on
SERVICES_STREAM="icecast_unprocessed icecast_opus"
# Services to be enabled
SERVICES_ENABLED="${SERVICES_ALWAYS} ${SERVICES_STREAM}"


# Paths
SERVICE_DIR="${HOME}/.config/systemd/user"
SCRIPT_DIR="$(pwd)"

mkdir -p "${SERVICE_DIR}"


write_service()
{
	SERVICE_NAME="es_$1.service"
	SERVICE_FILE="${SERVICE_DIR}/${SERVICE_NAME}"
	SCRIPT_FILE="${SCRIPT_DIR}/$1.sh"
	echo Writing "${SERVICE_FILE}"
	cat > "${SERVICE_FILE}"  <<EOF
[Unit]
Description=e-streaming $1

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


set -e

for name in ${SERVICES_ALWAYS}
do
	write_service "$name" default.target
done

for name in ${SERVICES_STREAM}
do
	write_service "$name" es_stream.target
done

cat > "${SERVICE_DIR}/es_stream.target" <<EOF
[Unit]
Description=e-streaming on
EOF

echo "Service files written. Running daemon-reload"
systemctl --user daemon-reload

for name in ${SERVICES_ENABLED}
do
	enable_service "$name"
done


