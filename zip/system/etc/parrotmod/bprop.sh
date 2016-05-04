#!/sbin/sh

change_or_add() {
	/sbin/busybox sed -i "s@${1}=.*@${1}=${2}@" /system/build.prop
	/sbin/busybox grep -F -v -q "${1}=" /system/build.prop && echo "${1}=${2}" >> /system/build.prop
}

comment_out() {
	/sbin/busybox sed -i "s@^${1}=@#${1}=@" /system/build.prop
}

change_or_add ro.setupwizard.network_required false
change_or_add ro.setupwizard.wifi_required false
comment_out ro.sys.fw.bg_apps_limit # pure nexus fix
comment_out ro.config.low_ram # same ^
change_or_add ro.config.max_starting_bg 1 # fix boot lag

# hwui cache settings https://source.android.com/devices/tech/config/renderer.html
change_or_add ro.hwui.disable_scissor_opt 1 # it is on some tegra3/4
change_or_add ro.hwui.texture_cache_size 20 # was 24, save 4M ram per process!
change_or_add ro.hwui.texture_cache_flush_rate 0.5 # recommended value by Google! was 0.6
change_or_add ro.hwui.gradient_cache_size 0.1 # in mb. A single gradient = 1-4 KB. recommended large enough to hold at least 12 was 0.5
# total savings 4.4 mb per process!

exit 0
