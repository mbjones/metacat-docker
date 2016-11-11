#!/bin/sh

# Copy configuration data to the proper volume
echo "Starting configuration script..."
mkdir -p /var/metacat/users
sed -e "s/{{ADMIN}}/$ADMIN/; s|{{ADMINPASS}}|$ADMINPASS|" /config/password.xml > /var/metacat/users/password.xml
echo "Configuration completed."

catalina.sh run
