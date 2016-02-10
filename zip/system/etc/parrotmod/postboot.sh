#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

# haveged, to compensate for setting add_random to 0

echo 64 > /proc/sys/kernel/random/read_wakeup_threshold
$bb nohup /system/etc/parrotmod/haveged -r 0 -w 1024 > /dev/null 2>&1 & # number of entropy bytes to keep full

while [ "$(getprop sys.boot_completed)" = "" ]; do sleep 1; done
sleep 5

if [ "$(cat /data/lastpmver_univ.txt)" != "1" ]; then
	settings put global sys_storage_full_threshold_bytes 8388608
	settings put global sys_storage_threshold_percentage 2
	settings put global sys_storage_threshold_max_bytes 104857600
	echo 1 > /data/lastpmver_univ.txt
	setprop ctl.restart zygote # soft reboot
fi
