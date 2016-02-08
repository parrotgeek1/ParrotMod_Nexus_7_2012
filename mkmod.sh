cd "$(dirname "$0")/zip"
rm -rf ../ParrotMod_Grouper_Stable.zip
find . -name '.DS_Store' -delete
zip -9 -r ../ParrotMod_Grouper_Stable.zip * 