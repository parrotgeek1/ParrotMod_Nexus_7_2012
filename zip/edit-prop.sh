#!/sbin/sh
busybox grep -F -v -q 'persist.debug.wfd.enable=1' /system/build.prop && echo 'persist.debug.wfd.enable=1' >> /system/build.prop
busybox grep -F -v -q 'persist.sys.wfd.nohdcp=1' /system/build.prop && echo 'persist.sys.wfd.nohdcp=1' >> /system/build.prop
busybox grep -F -v -q 'persist.sys.wfd.noimr=1' /system/build.prop && echo 'persist.sys.wfd.noimr=1' >> /system/build.prop
