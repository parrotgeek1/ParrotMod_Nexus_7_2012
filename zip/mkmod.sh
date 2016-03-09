cd "$(dirname "$0")"
rm -rf ../ParrotMod_Grouper_ChargingNoiseFix.zip
find . -name '.DS_Store' -delete
zip -9 -r ../ParrotMod_Grouper_ChargingNoiseFix.zip * -x "mkmod.sh" -x "upmod.sh"