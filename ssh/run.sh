#!/usr/bin/env bash

set -e

# Create the SSH directory if it doesn't exist
mkdir -p ~/.ssh

# Check if "PUBLICK_KEY" is set, if so, write it to the authorized_keys file
if [ -n "$PUBLIC_KEY" ]; then
    echo "$PUBLIC_KEY" > ~/.ssh/authorized_keys
    # set permissions
    chmod 600 ~/.ssh/authorized_keys
fi

# Check if "PASSWORD" is set, if so, set the password for the root user
if [ -n "$PASSWORD" ]; then
    echo $PASSWORD | passwd --stdin root
fi

# Set correct permissions on the SSH directory
chmod 700 ~/.ssh

# Start SSH
/usr/sbin/sshd -d -p 22