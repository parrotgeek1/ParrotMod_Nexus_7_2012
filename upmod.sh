#!/bin/bash
cd "$(dirname "$0")"
branch=$(git rev-parse --abbrev-ref HEAD)
branchend=$(echo $branch|cut -d _ -f 2)
[ "$branchend" != "Test" ] && rm -rf "ParrotMod/${branch}_Test"
rm -rf /Users/ethan/Desktop/Website/web/downloads/Android/ParrotMod
cp -r ParrotMod /Users/ethan/Desktop/Website/web/downloads/Android/