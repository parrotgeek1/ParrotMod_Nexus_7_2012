#!/sbin/sh
/sbin/busybox sed -i 's@ro.setupwizard.network_required=.*$@ro.setupwizard.network_required=false@g' /system/build.prop
/sbin/busybox sed -i 's@ro.setupwizard.wifi_required=.*$@ro.setupwizard.wifi_required=false@g' /system/build.prop
/sbin/busybox sed -i 's@ro.logd.size=.*$@ro.logd.size=65536@g' /system/build.prop
/sbin/busybox grep -F -v -q 'ro.setupwizard.network_required=' /system/build.prop && echo 'ro.setupwizard.network_required=false' >> /system/build.prop
/sbin/busybox grep -F -v -q 'ro.setupwizard.wifi_required=' /system/build.prop && echo 'ro.setupwizard.wifi_required=false' >> /system/build.prop
/sbin/busybox grep -F -v -q 'ro.logd.size=' /system/build.prop && echo 'ro.logd.size=65536' >> /system/build.prop
exit 0
