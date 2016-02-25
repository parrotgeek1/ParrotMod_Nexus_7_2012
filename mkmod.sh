#!/bin/sh
cd "$(dirname "$0")/zip"
rm -rf ../ParrotMod_Grouper_Stable_Univ.zip
find . -name '.DS_Store' -delete
zip -9 -r -q ../ParrotMod_Grouper_Stable_Univ.zip * 
du -h ../ParrotMod_Grouper_Stable_Univ.zip