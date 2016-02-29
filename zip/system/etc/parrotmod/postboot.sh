#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

while [ "$(getprop sys.boot_completed)" = "" ]; do sleep 1; done

settings put global sys_storage_full_threshold_bytes 8388608
settings put global sys_storage_threshold_percentage 2
settings put global sys_storage_threshold_max_bytes 104857600

echo 1 > /data/lastpmver_univ.txt

am start -a android.intent.action.REBOOT # cleaner reboot
