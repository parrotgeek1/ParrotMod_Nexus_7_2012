#!/sbin/sh
busybox grep -F -v -q 'ro.setupwizard.network_required=' /system/build.prop && echo 'ro.setupwizard.network_required=false' >> /system/build.prop
busybox grep -F -v -q 'ro.logd.size=' /system/build.prop && echo 'ro.logd.size=65536' >> /system/build.prop
exit 0
