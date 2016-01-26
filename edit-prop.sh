#!/sbin/sh
busybox grep -F -v -q 'persist.debug.wfd.enable=1' /system/build.prop && echo 'persist.debug.wfd.enable=1' >> /system/build.prop
busybox grep -F -v -q 'ro.config.wallpaper=' /system/build.prop && echo 'ro.config.wallpaper=/system/media/wallpaper.jpg' >> /system/build.prop
busybox grep -F -v -q 'ro.setupwizard.wifi_required=' /system/build.prop && echo 'ro.setupwizard.wifi_required=false' >> /system/build.prop
busybox sed -i 's/id=LMY47V.*$/id=LMY47V_ParrotMod_2016-01-25_21:44:08/g' /system/build.prop
busybox grep -F -v -q 'persist.sys.wfd.noimr=1' /system/build.prop && echo 'persist.sys.wfd.noimr=1' >> /system/build.prop
