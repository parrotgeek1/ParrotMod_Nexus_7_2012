
#!/sbin/sh
# 
# /system/addon.d/01ParrotMod.sh
#
. /tmp/backuptool.functions

list_files() {
echo "etc/nvram.txt"
echo "su.d/01ParrotMod.sh"
echo "addon.d/01ParrotMod.sh"
if /sbin/busybox test -e /system/etc/parrotmod/libc_installed_flag; then
	echo "lib/libc.so"
fi
if /sbin/busybox test -e /system/etc/parrotmod/libart_installed_flag; then
	if /sbin/busybox test -e /system/xposed.prop; then
		echo "lib/libart.so.orig"
	else
		echo "lib/libart.so"
	fi
fi
cd /system
/sbin/busybox find etc/parrotmod -type f
if ! /sbin/busybox test -e /system/etc/permissions/android.hardware.bluetooth_le.xml; then
cat << 'EOF'
etc/permissions/android.hardware.bluetooth_le.xml
lib/hw/bluetooth.default.so
lib/libbt-hci.so
lib/libbt-utils.so
EOF
fi
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
LC_ALL=C /sbin/busybox sed -i 's@intra-refresh-NOPE@intra-refresh-mode@g' /system/lib/libstagefright_wfd.so
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
. /system/etc/parrotmod/bprop.sh # @me: don't remove the .
/sbin/busybox fstrim -v /system
  ;;
esac
