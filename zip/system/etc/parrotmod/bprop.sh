#!/sbin/sh

change_or_add() {
	/sbin/busybox sed -i "s@${1}=.*$@${1}=${2}@" /system/build.prop
	/sbin/busybox grep -F -v -q "${1}=" /system/build.prop && echo "${1}=${2)" >> /system/build.prop
}

comment_out() {
	/sbin/busybox sed -i "s@^${1}=@#${1}=@" /system/build.prop
}

change_or_add ro.setupwizard.network_required false
change_or_add ro.setupwizard.wifi_required false
comment_out ro.sys.fw.bg_apps_limit # pure nexus fix
comment_out ro.config.low_ram # same ^
change_or_add ro.config.max_starting_bg 1

exit 0
