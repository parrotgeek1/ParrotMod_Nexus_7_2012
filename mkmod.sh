#!/bin/bash
branch=$(git rev-parse --abbrev-ref HEAD)
cd "$(dirname "$0")/zip"
cd system/etc/parrotmod
rm -f busybox
curl -# -L -o busybox https://busybox.net/downloads/binaries/busybox-armv5l 
cd ../../../
rm -rf ../ParrotMod_Grouper_${branch}.zip
find . -name '.DS_Store' -delete
zip -9 -r -q ../ParrotMod_Grouper_${branch}.zip * 
du -h ../ParrotMod_Grouper_${branch}.zip
cd system/etc/parrotmod
rm -f busybox
