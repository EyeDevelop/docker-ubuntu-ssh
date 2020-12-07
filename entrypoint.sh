#!/bin/bash

info() {
    echo "[+] $1"
}

info "Updating root password..."

# Generate a password for the root user.
ROOT_PASSWD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

# Set that root password.
echo -e "$ROOT_PASSWD\n$ROOT_PASSWD" | passwd root > /dev/null 2>&1

# Put the password in the container logs.
info "The password for the root user is '$ROOT_PASSWD'"

# Make sure root can login to the machine.
info "Updating SSH configuration to allow root login..."
sed -i 's/^#\?PermitRootLogin .*$/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication .*$/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# Run SSH
info "Starting SSHd..."
/usr/sbin/sshd -D
