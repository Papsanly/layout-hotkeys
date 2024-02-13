#!/bin/bash

if [[ "${UID}" = "0" ]]; then
    echo "This should not be run as root"
    exit 1
fi

DESTINATION=~/.local/share/gnome-shell/extensions/$(jq -r ".uuid" src/metadata.json)
if [[ -d $DESTINATION ]]; then
    echo The extension is already installed in path \"$DESTINATION\"!
    exit 2
fi

echo Copying files...
mkdir -p $DESTINATION
cp -r src/* $DESTINATION

echo Compiling schemas...
glib-compile-schemas $DESTINATION/schemas/ 

unset DESTINATION

echo Done!
