#!/bin/sh
SERVICES="input process icecast_unprocessed icecast_opus"
SERVICE_DEST="${HOME}/.config/systemd/user/"

mkdir -p "${SERVICE_DEST}"

write_service()
{
	SERVICE_NAME="es_$1.service"
	SCRIPT_FILE="$(pwd)/$1.sh"
	cat > "${SERVICE_DEST}${SERVICE_NAME}"  <<EOF
# TODO: service file here for ${SCRIPT_FILE}
EOF
}

enable_service()
{
	SERVICE_NAME="es_$1.service"
	systemctl --user enable "${SERVICE_NAME}"
}


set -e

for name in ${SERVICES}
do
	write_service "$name"
done

echo "Services files written. Running daemon-reload"
systemctl --user daemon-reload

for name in ${SERVICES}
do
	echo "Enabling service for $name"
	enable_service "$name"
done


