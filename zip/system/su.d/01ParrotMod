#!/system/bin/sh
bb=/system/xbin/busybox

# remove selinux

echo 0 > /sys/fs/selinux/enforce

# ram tuning
# https://01.org/android-ia/user-guides/android-memory-tuning-android-5.0-and-5.1

setprop dalvik.vm.heapstartsize 8m
setprop dalvik.vm.heapgrowthlimit 128m
setprop dalvik.vm.heapsize 174m
setprop dalvik.vm.heaptargetutilization 0.75
setprop dalvik.vm.heapminfree 512m
setprop dalvik.vm.heapmaxfree 8m

setprop persist.sys.purgeable_assets 1 # only for CM

logcat -b all -G 65536 # lower logd size

echo 4096 > /proc/sys/vm/min_free_kbytes

# http://review.cyanogenmod.org/#/c/101476/ instead ???
$bb chmod -R 0775 /sys/module/lowmemorykiller/parameters/adj
echo "0,1,2,5,7,16" > /sys/module/lowmemorykiller/parameters/adj 
echo "9933,10728,14950,17510,20019,31385" > /sys/module/lowmemorykiller/parameters/minfree 
echo "24" > /sys/module/lowmemorykiller/parameters/cost # default 32
$bb chmod -R 0555 /sys/module/lowmemorykiller/parameters # so android can't edit it

# TUNE THESE https://oakbytes.wordpress.com/2012/06/06/linux-scheduler-cfs-and-latency/ http://www.postgresql.org/message-id/50E4AAB1.9040902@optionshouse.com
echo "10" > /proc/sys/vm/dirty_ratio

echo never > /sys/kernel/mm/transparent_hugepage/enabled

# process scheduling

echo 1 > /proc/sys/kernel/perf_event_max_sample_rate
echo "18000000" > /proc/sys/kernel/sched_latency_ns
echo "3000000" > /proc/sys/kernel/sched_wakeup_granularity_ns
echo "1500000" > /proc/sys/kernel/sched_min_granularity_ns
echo "10000000000" /proc/sys/kernel/sched_stat_granularity_ns

# investigate these!
mount -t debugfs none /sys/kernel/debug
echo NO_FAIR_SLEEPERS > /sys/kernel/debug/sched_features
echo NO_NORMALIZED_SLEEPER > /sys/kernel/debug/sched_features

# eMMC speed

$bb renice -10 $($bb pidof mmcqd/0)
cd /sys/block/mmcblk0/queue
echo noop > scheduler
echo 4096 > nr_requests
echo 0 > add_random # don't contribute to entropy
if [ -f "/data/no_readahead" ]; then
	echo 0 > read_ahead_kb
else
	echo 4 > read_ahead_kb # yes, I am serious, see http://forum.xda-developers.com/showthread.php?t=1032317
fi
echo 1 > rq_affinity # stay on same cpu core
echo 0 > nomerges # try hard to merge requests 
echo 0 > rotational # obviously
echo 0 > iostats # cpu hog

# Misc tweaks for battery life DO THESE DO ANYTHING WITHOUT SWAP?
echo "500" > /proc/sys/vm/dirty_writeback_centisecs
echo "1000" > /proc/sys/vm/dirty_expire_centisecs

for m in /data /cache; do
	mount | grep "$m" | grep -q ext4 && mount -o remount,rw,noauto_da_alloc,delalloc,discard,journal_async_commit,journal_ioprio=5,data=writeback,barrier=0,commit=15,noatime,nodiratime,inode_readahead_blks=64,dioread_nolock,max_batch_time=15000 "$m" "$m"
done
mount | grep '/system' | grep -q ext4 && mount -o remount,ro,inode_readahead_blks=128,dioread_nolock,max_batch_time=20000 /system /system

# https://www.kernel.org/doc/Documentation/filesystems/ext4.txt look more
for f in /sys/fs/ext4/*; do
	echo 8 > ${f}/max_writeback_mb_bump
	echo 1 > ${f}/mb_group_prealloc
	echo 0 > ${f}/mb_stats
	echo 32 > ${f}/mb_stream_req # 128kb
done

# GPU

echo 0 > /sys/devices/tegradc.0/smartdimmer/enable
echo 0 > /sys/devices/host1x/gr3d/enable_3d_scaling

# haveged, to compensate for setting add_random to 0

echo 64 > /proc/sys/kernel/random/read_wakeup_threshold
/system/etc/parrotmod/haveged -r 0 -w 1024 # number of entropy bytes to keep full

# tcp

setprop wifi.supplicant_scan_interval 180
echo 65535 > /proc/sys/net/core/rmem_default
echo 174760 > /proc/sys/net/core/rmem_max
echo 65535 > /proc/sys/net/core/wmem_default
echo 131071 > /proc/sys/net/core/wmem_max
echo "4096 16384 131072" > /proc/sys/net/ipv4/tcp_wmem
echo "4096 87380 174760" > /proc/sys/net/ipv4/tcp_rmem
echo 0 > /proc/sys/net/ipv4/tcp_slow_start_after_idle
echo 0 > /proc/sys/net/ipv4/tcp_timestamps
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
# buffersize tweaks do nothing!

# fstrim on install

if [ "$(cat /data/lastpmver_univ.txt)" != "1" ]; then
	$bb fstrim -v /data
	$bb fstrim -v /cache
fi

# start postboot script

$bb nohup /system/xbin/busybox sh /system/etc/parrotmod/postboot.sh >/dev/null 2>&1 &
