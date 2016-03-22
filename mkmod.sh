#!/bin/bash
cd "$(dirname "$0")/zip"
branch=$(git rev-parse --abbrev-ref HEAD)
rm -rf ../ParrotMod_Grouper_${branch}.zip
find . -name '.DS_Store' -delete
zip -9 -r -q ../ParrotMod_Grouper_${branch}.zip * 
du -h ../ParrotMod_Grouper_${branch}.zip