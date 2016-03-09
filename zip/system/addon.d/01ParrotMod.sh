
#!/sbin/sh
# 
# /system/addon.d/01ParrotMod.sh
#
. /tmp/backuptool.functions

list_files() {
echo "su.d/01ParrotMod.sh"
echo "addon.d/01ParrotMod.sh"
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
/sbin/busybox sed -i 's@ro.setupwizard.network_required=.*$@ro.setupwizard.network_required=false@' /system/build.prop
/sbin/busybox sed -i 's@ro.setupwizard.wifi_required=.*$@ro.setupwizard.wifi_required=false@' /system/build.prop
/sbin/busybox sed -i 's@ro.logd.size=.*$@ro.logd.size=65536@' /system/build.prop
/sbin/busybox grep -F -v -q 'ro.setupwizard.network_required=' /system/build.prop && echo 'ro.setupwizard.network_required=false' >> /system/build.prop
/sbin/busybox grep -F -v -q 'ro.setupwizard.wifi_required=' /system/build.prop && echo 'ro.setupwizard.wifi_required=false' >> /system/build.prop
/sbin/busybox grep -F -v -q 'ro.logd.size=' /system/build.prop && echo 'ro.logd.size=65536' >> /system/build.prop
/sbin/busybox fstrim -v /system
  ;;
esac
