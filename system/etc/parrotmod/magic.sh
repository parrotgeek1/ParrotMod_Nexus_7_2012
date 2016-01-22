#!/system/bin/sh
bb=/system/xbin/busybox
while [ "$(getprop sys.boot_completed)" = "" ]; do sleep 1; done
sleep 5
# for (mostly) fixing audio stutter when multitasking
$bb renice -15 $($bb pidof mediaserver) #disk io important
$bb renice -7 $($bb pidof hd-audio0) #avoid underruns but can't be faster than media server
#cfq adjusts disk io based on nice value
$bb renice -10 $($bb pidof sdcard)
$bb renice -15 $($bb pidof lmkd) # stop hard freezes from low memory killer being CPU starved
settings put global wifi_networks_available_notification_on 0
settings put global wifi_display_certification_on 1
settings put global verifier_verify_adb_installs 0
settings put global sys_storage_full_threshold_bytes 8388608
settings put global sys_storage_threshold_percentage 2
settings put global sys_storage_threshold_max_bytes 104857600
settings put global wifi_allow_scan_with_traffic 1
$bb fstrim -v /cache
am idle-maintenance #trim etc
for i in 0 1 2 3; do
echo interactive > /sys/devices/system/cpu/cpu${i}/cpufreq/scaling_governor
done
echo 1 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
$bb date > /data/local/tmp/parrotmod.txt
