#!/bin/bash
cd "$(dirname "$0")"
branch=$(git rev-parse --abbrev-ref HEAD)
rm -f ~/Google\ Drive/Website\ Downloads/Android/ParrotMod_Grouper_${branch}.zip
cp ParrotMod_Grouper_${branch}.zip ~/Google\ Drive/Website\ Downloads/Android/ParrotMod_Grouper_${branch}.zip