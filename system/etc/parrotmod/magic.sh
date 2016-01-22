#!/system/bin/sh
bb=/system/xbin/busybox
# https://01.org/android-ia/user-guides/android-memory-tuning-android-5.0-and-5.1
cd /sys/kernel/mm/ksm 
echo 100 > pages_to_scan
echo 500 > sleep_millisecs
echo 1 > run
setprop dalvik.vm.heapstartsize 8m
setprop dalvik.vm.heapgrowthlimit 128m
setprop dalvik.vm.heapsize 174m
setprop dalvik.vm.heaptargetutilization 0.75
setprop dalvik.vm.heapminfree 512m
setprop dalvik.vm.heapmaxfree 8m
for i in 0 1 2 3; do
echo performance > /sys/devices/system/cpu/cpu${i}/cpufreq/scaling_governor
done
echo cfq > /sys/block/mmcblk0/queue/scheduler
echo 1 > /proc/sys/kernel/perf_event_max_sample_rate
cd /sys/block/mmcblk0/queue
echo 2048 > nr_requests
echo 0 > add_random # dont contribute to entropy
echo 512 > read_ahead_kb # this is low because queue & inode settings balance it out
echo 1 > rq_affinity # stay on same cpu core
echo 1 > nomerges # don't try as hard to merge requests (cpu hog)
echo 0 > rotational # obviously
echo 0 > iosched/slice_idle
echo 0 > iosched/group_idle
# maybe 64?
#echo 33554432 > discard_max_bytes not in 3.1.10
echo 0 > iostats # cpu hog
echo 4096 > /proc/sys/vm/min_free_kbytes
chmod 664 /sys/module/lowmemorykiller/parameters/adj
echo "0,1,2,5,7,16" > /sys/module/lowmemorykiller/parameters/adj 
chmod 444 /sys/module/lowmemorykiller/parameters/adj 
chmod 664 /sys/module/lowmemorykiller/parameters/minfree 
echo "9933,10728,14950,17510,20019,31385" > /sys/module/lowmemorykiller/parameters/minfree 
chmod 444 /sys/module/lowmemorykiller/parameters/minfree 
for m in /data /cache; do
mount | grep "$m" | grep -q ext4 && mount -o remount,rw,noauto_da_alloc,delalloc,discard,journal_async_commit,journal_ioprio=5,data=ordered,barrier=0,commit=15,noatime,nodiratime,inode_readahead_blks=64 "$m" "$m"
done
mount | grep '/system' | grep -q ext4 && mount -o remount,ro,inode_readahead_blks=128 /system /system
echo 0 > /sys/devices/tegradc.0/smartdimmer/enable
echo 0 > /sys/devices/host1x/gr3d/enable_3d_scaling
$bb renice -10 $($bb pidof mmcqd/0)
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
