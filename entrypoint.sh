#!/bin/sh

set -e

# Get PUID/PGID from environment
PUID=${PUID:-1000}
PGID=${PGID:-1000}

echo "Setting up user: appuser (UID: $PUID) and group: appuser (GID: $PGID)"

# 指定されたGIDのグループ処理
if getent group "$PGID" >/dev/null 2>&1; then
    EXISTING_GROUP=$(getent group "$PGID" | cut -d: -f1)
    if [ "$EXISTING_GROUP" != "appuser" ]; then
        echo "Renaming existing group '$EXISTING_GROUP' (GID $PGID) to 'appuser'"
        groupmod -n appuser "$EXISTING_GROUP"
    else
        echo "Group 'appuser' with GID $PGID already exists"
    fi
else
    echo "Creating new group 'appuser' with GID $PGID"
    groupadd -g "$PGID" appuser
fi

# 指定されたUIDのユーザー処理
if getent passwd "$PUID" >/dev/null 2>&1; then
    EXISTING_USER=$(getent passwd "$PUID" | cut -d: -f1)
    if [ "$EXISTING_USER" != "appuser" ]; then
        echo "Renaming existing user '$EXISTING_USER' (UID $PUID) to 'appuser'"
        usermod -l appuser "$EXISTING_USER"
    else
        echo "User 'appuser' with UID $PUID already exists"
    fi
else
    echo "Creating new user 'appuser' with UID $PUID"
    useradd -u "$PUID" -g appuser appuser
fi

chown $PUID:$PGID /app/data

# Start the command as appuser user in background
exec sudo -u appuser -E env PATH="$PATH" "$@"
