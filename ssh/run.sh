#!/usr/bin/env bash

set -e

# Create the SSH directory if it doesn't exist
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys

# Check if 'AUTHORIZED_KEYS' is set, if so, write it to ~/.ssh/authorized_keys file
if [ -n "$AUTHORIZED_KEYS" ]; then
    cat <<< $AUTHORIZED_KEYS > ~/.ssh/authorized_keys
    # set permissions
    chmod 600 ~/.ssh/authorized_keys
fi

# Check if "PUBLICK_KEY" is set, if so, write it to the authorized_keys file
if [ -n "$PUBLIC_KEY" ]; then
    echo "$PUBLIC_KEY" >> ~/.ssh/authorized_keys
    # set permissions
    chmod 600 ~/.ssh/authorized_keys
fi

# Check if "PASSWORD" is set, if so, set the password for the root user
if [ -n "$PASSWORD" ]; then
    echo -e "$PASSWORD\n$PASSWORD" | passwd root
fi

# Set correct permissions on the SSH directory
chmod 700 ~/.ssh

# Start SSH
/usr/sbin/sshd -D -e -p 22
