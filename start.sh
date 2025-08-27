#!/bin/sh

USER=${USERNAME:-admin}
PASS=${PASSWORD:-password}
HASHEDPASS=$(filebrowser hash $PASS)

TARGET_DIR=${TARGET_DIR:-/src/servers}

if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
fi

filebrowser -d /src/filebrowser.db -a 0.0.0.0 -r $TARGET_DIR -p 80 --username $USER --password $HASHEDPASS