#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

# stop LMK conflict

$bb killall -STOP lmkd

# haveged, to compensate for setting add_random to 0

echo 128 > /proc/sys/kernel/random/read_wakeup_threshold
/system/etc/parrotmod/haveged -w 1024 -n 0 -p /data/local/tmp/haveged.pid

while [ "$(getprop sys.boot_completed)" = "" ]; do sleep 1; done

if [ "$(cat /data/lastpmver_univ.txt)" != "1" ]; then
	settings put global sys_storage_full_threshold_bytes 8388608
	settings put global sys_storage_threshold_percentage 2
	settings put global sys_storage_threshold_max_bytes 104857600
	echo 1 > /data/lastpmver_univ.txt
	setprop ctl.restart zygote # soft reboot
fi
