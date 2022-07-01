# e-streaming
Software and configuration on the streaming machine

# Installation and configuration
## Icecast address

The address and password of the Icecast server are not kept in
this repository. Please create `icecast_address.sh` like:

    ICECAST_ADDRESS=source:PASSWORD@ADDRESS:PORT/NAME

Where PASSWORD is the source password, ADDRESS:PORT is the address
and NAME forms part of the name of the stream.

## Services

To install the services, `cd` to this directory and do:

    ./install_services.sh

Check that audio input and processing are working:

    journalctl --user -u es_input.service
    journalctl --user -u es_process.service

If they didn't start at all, you might have to do:

    systemctl --user start default.target

To make it start on boot:

    # assuming stream is the username running this
    sudo loginctl enable-linger stream

To start or stop streaming, do:

    systemctl --user start es_streaming.target
    systemctl --user stop es_streaming.target

