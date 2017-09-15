#!/bin/bash

#
VER=2.8.4
RELEASE="metacat-bin-${VER}.tar.gz"
DIST="https://knb.ecoinformatics.org/software/dist"
export PGUSER=metacat
export PGDB=metacat 

# Grab the Metacat release
if [ !  -f "config/${RELEASE}" ]
    then
        curl "${DIST}/${RELEASE}" -o "config/${RELEASE}"
fi

# Launch docker
docker-compose -p metacat up -d --build
