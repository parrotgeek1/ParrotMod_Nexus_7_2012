#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

# remove selinux

echo 0 > /sys/fs/selinux/enforce

# ram tuning
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

setprop persist.sys.purgeable_assets 1 # only for CM

logcat -b all -G 65536 # lower logd size

echo 4096 > /proc/sys/vm/min_free_kbytes

# http://review.cyanogenmod.org/#/c/101476/ instead ???
$bb chmod -R 0775 /sys/module/lowmemorykiller/parameters
#echo "0,1,2,5,7,16" > /sys/module/lowmemorykiller/parameters/adj 
echo "9933,10728,14950,17510,20019,31385" > /sys/module/lowmemorykiller/parameters/minfree 
echo "24" > /sys/module/lowmemorykiller/parameters/cost # default 32
$bb chmod -R 0555 /sys/module/lowmemorykiller/parameters # so android can't edit it

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

# https://www.kernel.org/doc/Documentation/block/cfq-iosched.txt

echo cfq > scheduler
echo 4 > iosched/slice_async_rq
echo 12 > iosched/quantum
echo 40 > iosched/slice_async
echo 120 > iosched/slice_sync
echo 0 > iosched/slice_idle
echo 0 > iosched/group_idle
echo 80 > iosched/fifo_expire_sync
echo 240 > iosched/fifo_expire_async
echo 240 > iosched/target_latency # ms, maybe change to bigger?
echo "1" > iosched/low_latency
echo "1" > iosched/back_seek_penalty # no penalty
echo "1000000000" > iosched/back_seek_max # i.e. the whole disk

for f in /sys/devices/system/cpu/cpufreq/*; do
	echo 1 > ${f}/io_is_busy
done

# tweaks for background disk

echo "500" > /proc/sys/vm/dirty_writeback_centisecs
echo "1000" > /proc/sys/vm/dirty_expire_centisecs
echo 4 > /proc/sys/vm/page-cluster
echo "60" > /proc/sys/vm/dirty_ratio
echo "10" > /proc/sys/vm/dirty_background_ratio

# fs tune

for m in /data /cache; do
	mount | $bb grep "$m" | $bb grep -q ext4 && mount -o remount,rw,noauto_da_alloc,delalloc,discard,journal_async_commit,journal_ioprio=5,data=writeback,barrier=0,commit=15,noatime,nodiratime,inode_readahead_blks=64,dioread_nolock,max_batch_time=15000 "$m" "$m"
	mount | $bb grep "$m" | $bb grep -q f2fs && mount -o remount,rw,nobarrier,flush_merge,inline_xattr,inline_data,inline_dentry,ram_thresh=8 "$m" "$m"
done
mount | $bb grep '/system' | $bb grep -q ext4 && mount -o remount,ro,inode_readahead_blks=128,dioread_nolock,max_batch_time=20000 /system /system
mount | $bb grep '/system' | $bb grep -q f2fs && mount -o remount,ro,nobarrier,flush_merge,inline_xattr,inline_data,inline_dentry,ram_thresh=16  /system /system

for f in /sys/fs/ext4/*; do
	echo 8 > ${f}/max_writeback_mb_bump
	echo 1 > ${f}/mb_group_prealloc
	echo 0 > ${f}/mb_stats
	echo 32 > ${f}/mb_stream_req # 128kb
done

# GPU

echo 0 > /sys/devices/tegradc.0/smartdimmer/enable
setprop persist.tegra.didim.enable 0
echo 0 > /sys/devices/host1x/gr3d/enable_3d_scaling

# tcp

setprop wifi.supplicant_scan_interval 60 # was 15
echo 65535 > /proc/sys/net/core/rmem_default
echo 174760 > /proc/sys/net/core/rmem_max
echo 65535 > /proc/sys/net/core/wmem_default
echo 131071 > /proc/sys/net/core/wmem_max
echo "4096 16384 131072" > /proc/sys/net/ipv4/tcp_wmem
echo "4096 87380 174760" > /proc/sys/net/ipv4/tcp_rmem
echo 0 > /proc/sys/net/ipv4/tcp_slow_start_after_idle
echo 0 > /proc/sys/net/ipv4/tcp_timestamps
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
echo westwood > /proc/sys/net/ipv4/tcp_congestion_control
# buffersize tweaks do nothing!

# for (mostly) fixing audio stutter when multitasking

$bb renice -15 $($bb pidof hd-audio0) #avoid underruns

# start postboot script

$bb nohup $bb sh /system/etc/parrotmod/postboot.sh >/dev/null 2>&1 &
