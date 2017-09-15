#!/bin/sh

TOMCAT=/usr/local/tomcat

echo "Starting configuration script..."

# Extract metacat and install war files
#if [ !  -f /${TOMCAT}/webapps/metacat.war ]
#    then
#        echo "Copying metacat.war..."
#        mkdir -p /config/metacat
#        cd /config/metacat && tar xzf ../metacat*.tar.gz && cd ..
#        cp /config/metacat/*.war $TOMCAT/webapps
#fi

# Extract war files

# Configure metacat.properties

# Copy password file for administrator
mkdir -p /var/metacat/users
sed -e "s/{{ADMIN}}/$ADMIN/; s|{{ADMINPASS}}|$ADMINPASS|" /config/password.xml > /var/metacat/users/password.xml
echo "Configuration completed."

# Launch tomcat
catalina.sh run
