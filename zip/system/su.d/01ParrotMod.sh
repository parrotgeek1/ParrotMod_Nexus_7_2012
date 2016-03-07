#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

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

# process scheduling

echo 1 > /proc/sys/kernel/perf_event_max_sample_rate
echo "18000000" > /proc/sys/kernel/sched_latency_ns
echo "3000000" > /proc/sys/kernel/sched_wakeup_granularity_ns
echo "1500000" > /proc/sys/kernel/sched_min_granularity_ns

# https://github.com/CyanogenMod/android_kernel_asus_grouper/blob/cm-13.0/kernel/sched_features.h

echo NO_GENTLE_FAIR_SLEEPERS > /sys/kernel/debug/sched_features
echo ARCH_POWER > /sys/kernel/debug/sched_features

# eMMC speed

$bb renice -10 $($bb pidof mmcqd/0)
cd /sys/block/mmcblk0/queue
echo 4096 > nr_requests
echo 0 > add_random # don't contribute to entropy
echo 4 > read_ahead_kb # yes, I am serious, see http://forum.xda-developers.com/showthread.php?t=1032317
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
echo "1" > iosched/low_latency
$bb test -e iosched/target_latency && echo 240 > iosched/target_latency # not in 3.1
echo "1" > iosched/back_seek_penalty # no penalty
echo "1000000000" > iosched/back_seek_max # i.e. the whole disk

for f in /sys/devices/system/cpu/cpufreq/*; do
	$bb test -e ${f}/io_is_busy && echo 1 > ${f}/io_is_busy
done

# tweaks for background disk

echo "250" > /proc/sys/vm/dirty_writeback_centisecs
echo "500" > /proc/sys/vm/dirty_expire_centisecs
echo 4 > /proc/sys/vm/page-cluster
echo "60" > /proc/sys/vm/dirty_ratio
echo "5" > /proc/sys/vm/dirty_background_ratio

# fs tune

for m in /data /cache; do
	mount | $bb grep "$m" | $bb grep -q ext4 && mount -o remount,rw,noauto_da_alloc,delalloc,discard,journal_async_commit,journal_ioprio=5,barrier=0,commit=15,noatime,nodiratime,inode_readahead_blks=64,dioread_nolock,max_batch_time=15000,nomblk_io_submit "$m" "$m"
	mount | $bb grep "$m" | $bb grep -q f2fs && mount -o remount,rw,nobarrier,flush_merge,inline_xattr,inline_data,inline_dentry,discard "$m" "$m"
done
mount | $bb grep '/system' | $bb grep -q ext4 && mount -o remount,ro,inode_readahead_blks=128,dioread_nolock,max_batch_time=20000,nomblk_io_submit /system /system
mount | $bb grep '/system' | $bb grep -q f2fs && mount -o remount,ro,nobarrier,flush_merge,inline_xattr,inline_data,inline_dentry,discard  /system /system

for f in /sys/fs/ext4/*; do
	$bb test "$f" = "/sys/fs/ext4/features" && continue
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
# investigate buffersize!

# for (mostly) fixing audio stutter when multitasking

$bb renice -15 $($bb pidof hd-audio0) #avoid underruns
$bb nohup su -cn u:r:init:s0 -c "$bb sh /system/etc/parrotmod/postboot.sh" >/dev/null 2>&1 &
