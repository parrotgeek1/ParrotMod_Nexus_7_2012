
#!/sbin/sh
# 
# /system/addon.d/01ParrotMod_CNF.sh
#
. /tmp/backuptool.functions

list_files() {
if /sbin/busybox test -e /system/priv-app/Settings/Settings.apk; then # only 5.0+
	echo "app/ChargingNoiseFix/ChargingNoiseFix.apk"
else
	echo "app/ChargingNoiseFix.apk"
fi
echo /system/addon.d/01ParrotMod_CNF.sh
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
/sbin/busybox fstrim -v /system
  ;;
esac