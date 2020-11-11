#!/bin/bash -e

VERSION=$(curl -s https://api.github.com/repos/fabiocolacio/Marker/releases/latest | jq '.name' | sed 's/"//g')

wget "https://github.com/fabiocolacio/Marker/releases/download/${VERSION}/marker.zip"
unzip marker.zip
cd marker
dch -v "${VERSION}" "Upstream ${VERSION}"
debuild -i -us -uc -b
echo BUILD DONE
cp ../marker_*_amd64.deb $1
chown 1000:1000 $1/marker_*_amd64.deb
