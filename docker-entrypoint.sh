#!/usr/bin/env bash
set -e

if [ "$1" = 'catalina.sh' ]; then

    USER_PWFILE="/var/metacat/users/password.xml"

	# look specifically for the user password file, as it is expected if the configuration is completed
	if [ ! -s "$USER_PWFILE" ]; then

        # Copy password file for administrator
        mkdir -p /var/metacat/users
        ## Note: a bug in the Java library prevents it from reading from hashes starting with 2y like here
        printf -v script 'import bcrypt; hpw = bcrypt.hashpw("%s", bcrypt.gensalt(12, prefix=b"2a")); print(hpw)' $ADMINPASS
        HASHEDPW=`echo $script | python -`
        sed -e "s/{{ADMIN}}/$ADMIN/; s|{{ADMINPASS}}|$HASHEDPW|" /config/password.xml > $USER_PWFILE

        # Set up metacat.properties with database configuration options

		echo
		echo 'Metacat init process complete; ready for start up.'
		echo
	fi
fi

exec "$@"

