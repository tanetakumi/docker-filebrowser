#!/bin/sh

USER=${USERNAME:-admin}
PASS=${PASSWORD:-password}
HASHEDPASS=$(filebrowser hash $PASS)
DISABLE_EXEC=${FB_DISABLE_EXEC:-false}

if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
fi

filebrowser -d /app/config/filebrowser.db -a 0.0.0.0 -r /app/data -p 80 --username $USER --password $HASHEDPASS --disable-exec=$DISABLE_EXEC