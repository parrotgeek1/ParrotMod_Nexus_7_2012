cd "$(dirname "$0")"
rm -rf ../ParrotMod_Grouper_Stable.zip
find . -name '.DS_Store' -delete
sed -i '' "s@LMY47V_ParrotMod_.*/g@LMY47V_ParrotMod_$(date +%F_%T)/g@g" edit-prop.sh
zip -9 -r ../ParrotMod_Grouper_Stable.zip * 