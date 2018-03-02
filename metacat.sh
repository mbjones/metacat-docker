#!/bin/bash

set -e

if [ -z $1 ] ;
  then
    echo "Usage: $0 <version>"
    exit
fi

#
VERSION=$1
RELEASE="metacat-bin-${VERSION}.tar.gz"
DIST="https://knb.ecoinformatics.org/software/dist"

# Grab the Metacat release
if [ !  -f "dist/${RELEASE}" ]
    then
        mkdir -p dist
        curl "${DIST}/${RELEASE}" -o "dist/${RELEASE}"
fi

# Launch docker
docker build --build-arg METACAT_VERSION=$VERSION -t metacat:$VERSION .
#docker-compose -p metacat up -d
