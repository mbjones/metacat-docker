#!/bin/bash

#
VER=2.8.4
RELEASE="metacat-bin-${VER}.tar.gz"
DIST="https://knb.ecoinformatics.org/software/dist"
export PGUSER=metacat
export PGDB=metacat 

# Grab the Metacat release
if [ !  -f "dist/${RELEASE}" ]
    then
        mkdir -p dist
        curl "${DIST}/${RELEASE}" -o "dist/${RELEASE}"
fi

# Launch docker
#docker-compose -p metacat up -d
