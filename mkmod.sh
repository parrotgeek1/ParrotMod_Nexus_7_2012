#!/bin/bash
branch=$(git rev-parse --abbrev-ref HEAD)
mkdir -p "ParrotMod/$branch"
mv ParrotMod_Grouper_${branch}_2*.zip $branch/ 2>/dev/null
date=$(date +%Y-%m-%d_%H.%M.%S)
cd "$(dirname "$0")/zip"
cd system/etc/parrotmod
rm -f busybox
curl -# -L -o busybox https://busybox.net/downloads/binaries/busybox-armv5l 
cd ../../../
rm -rf ../ParrotMod_Grouper_${branch}_${date}.zip
find . -name '.DS_Store' -delete
zip -9 -r -q ../ParrotMod_Grouper_${branch}_${date}.zip * 
du -h ../ParrotMod_Grouper_${branch}_${date}.zip
cd system/etc/parrotmod
rm -f busybox
cd ../../../../
mv ParrotMod_Grouper_${branch}_2*.zip ParrotMod/$branch/ 2>/dev/null
cd ParrotMod/$branch
cn=1
for i in `echo ParrotMod_Grouper_${branch}_2*.zip | tr ' ' '\n' | sort -r`; do 
	[ "$cn" -gt 4 ] && rm "$i"
	cn=$(($cn+1))
done
