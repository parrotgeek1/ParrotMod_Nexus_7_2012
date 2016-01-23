#!/system/bin/sh
bb=/system/xbin/busybox
while [ "$($bb pidof bootanimation)" = "" ]; do sleep 1; done
$bb renice 15 $($bb pidof bootanimation)
while [ "$(getprop sys.boot_completed)" = "" ]; do sleep 1; done
sleep 5
cd /sys/block/mmcblk0/queue
echo cfq > scheduler
echo 0 > iosched/slice_idle
echo 0 > iosched/group_idle
echo 200 > iosched/target_latency # ms
echo "1" > iosched/low_latency
echo "1" > iosched/back_seek_penalty # no penalty
echo "1000000000" > iosched/back_seek_max
# https://01.org/android-ia/user-guides/android-memory-tuning-android-5.0-and-5.1
# ksm after boot better
cd /sys/kernel/mm/ksm 
echo 100 > pages_to_scan
echo 500 > sleep_millisecs
echo 1 > run
# CFS
echo -1 > /proc/sys/kernel/sched_rt_runtime_us
echo 100000 > /proc/sys/kernel/sched_rt_period_us
echo 95000 > /proc/sys/kernel/sched_rt_runtime_us
# for (mostly) fixing audio stutter when multitasking
$bb renice -15 $($bb pidof mediaserver) #disk io important
$bb renice -7 $($bb pidof hd-audio0) #avoid underruns but can't be faster than media server
#cfq adjusts disk io based on nice value
$bb renice -10 $($bb pidof sdcard)
$bb renice -15 $($bb pidof lmkd) # stop hard freezes from low memory killer being CPU starved
$bb fstrim -v /cache
am idle-maintenance #trim etc
for i in 0 1 2 3; do
echo interactive > /sys/devices/system/cpu/cpu${i}/cpufreq/scaling_governor
done
echo 1 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
$bb date > /data/local/tmp/parrotmod.txt
if [ "$(cat /data/lastpmver.txt)" != "1" ]; then
settings put global wifi_networks_available_notification_on 0
settings put global wifi_display_certification_on 1
settings put global verifier_verify_adb_installs 0
settings put global sys_storage_full_threshold_bytes 8388608
settings put global sys_storage_threshold_percentage 2
settings put global sys_storage_threshold_max_bytes 104857600
settings put global wifi_allow_scan_with_traffic 1
echo 1 > /data/lastpmver.txt
am start -a android.intent.action.REBOOT # cleaner reboot
fi