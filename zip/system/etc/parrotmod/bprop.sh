#!/sbin/sh
/sbin/busybox sed -i 's@ro.setupwizard.network_required=.*$@ro.setupwizard.network_required=false@' /system/build.prop
/sbin/busybox sed -i 's@ro.setupwizard.wifi_required=.*$@ro.setupwizard.wifi_required=false@' /system/build.prop
/sbin/busybox sed -i 's@ro.logd.size=.*$@ro.logd.size=65536@' /system/build.prop

# https://android.googlesource.com/platform/system/core/+/d1f41d6/logd/README.property
/sbin/busybox sed -i 's@ro.logd.kernel=.*$@ro.logd.kernel=false@' /system/build.prop
/sbin/busybox sed -i 's@ro.logd.statistics=.*$@ro.logd.statistics=false@' /system/build.prop

/sbin/busybox grep -F -v -q 'ro.setupwizard.network_required=' /system/build.prop && echo 'ro.setupwizard.network_required=false' >> /system/build.prop
/sbin/busybox grep -F -v -q 'ro.setupwizard.wifi_required=' /system/build.prop && echo 'ro.setupwizard.wifi_required=false' >> /system/build.prop
/sbin/busybox grep -F -v -q 'ro.logd.size=' /system/build.prop && echo 'ro.logd.size=65536' >> /system/build.prop
/sbin/busybox grep -F -v -q 'ro.logd.kernel=' /system/build.prop && echo 'ro.logd.kernel=false' >> /system/build.prop
/sbin/busybox grep -F -v -q 'ro.logd.statistics=' /system/build.prop && echo 'ro.logd.statistics=false' >> /system/build.prop

exit 0
