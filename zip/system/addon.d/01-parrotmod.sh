
#!/sbin/sh
# 
# /system/addon.d/01-parrotmod.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
su.d/01ParrotMod.sh
etc/parrotmod/busybox
etc/parrotmod/postboot.sh
etc/permissions/android.hardware.bluetooth_le.xml
lib/hw/bluetooth.default.so
lib/libbt-hci.so
lib/libbt-utils.so
EOF
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
cat /system/etc/parrotmod/libstagefright_wfd.so.orig > /system/lib/libstagefright_wfd.so 
rm /system/etc/parrotmod/libstagefright_wfd.so.orig
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
LC_ALL=C /sbin/busybox sed -i 's@intra-refresh-mode@intra-refresh-NOPE@g' /system/lib/libstagefright_wfd.so
chcon -R u:object_r:system_file:s0 /system/etc/parrotmod
chcon u:object_r:system_file:s0 /system/su.d/01ParrotMod.sh
/sbin/busybox fstrim -v /system
  ;;
esac