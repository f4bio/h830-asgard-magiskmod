#!/bin/bash

set -xe

KERNEL_INPUT=$(basename -s ".zip" $1)
KERNEL_OUTPUT="$KERNEL_INPUT-magiskmod"

cd build/

rhash -c "$KERNEL_INPUT.zip.md5"

unzip "$KERNEL_INPUT.zip"
# curl -L build/Magisk-v11.1.zip http://tiny.cc/latestmagisk

rm rootzip/SuperSU-*.zip
cp Magisk-v11.1.zip rootzip/Magisk-v11.1.zip
cp Magisk-v11.1.zip.md5 rootzip/Magisk-v11.1.zip.md5
cp updater-script META-INF/com/google/android/updater-script

zip -r "$KERNEL_OUTPUT.zip" boot.img META-INF/ rootzip/ system/

rhash --md5 --output "$KERNEL_OUTPUT.zip.md5" "$KERNEL_OUTPUT.zip"

rm -rf boot.img META-INF rootzip system
