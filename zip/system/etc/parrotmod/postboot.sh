#!/system/bin/sh
bb=/system/xbin/busybox

while [ "$(getprop sys.boot_completed)" = "" ]; do sleep 1; done
sleep 5

if [ "$(cat /data/lastpmver_univ.txt)" != "1" ]; then
	settings put global sys_storage_full_threshold_bytes 8388608
	settings put global sys_storage_threshold_percentage 2
	settings put global sys_storage_threshold_max_bytes 104857600
	echo 1 > /data/lastpmver_univ.txt
	setprop ctl.restart zygote # soft reboot
fi
