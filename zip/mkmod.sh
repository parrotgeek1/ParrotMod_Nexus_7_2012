#!/bin/bash
cd "$(dirname "$0")"
branch=$(git rev-parse --abbrev-ref HEAD)
rm -rf ../ParrotMod_Grouper_${branch}.zip
find . -name '.DS_Store' -delete
zip -9 -r ../ParrotMod_Grouper_${branch}.zip * -x "ParrotMod_Grouper_*.zip" -x "Readme.txt" -x "To Do.txt" -x "mkmod.sh" -x "upmod.sh"