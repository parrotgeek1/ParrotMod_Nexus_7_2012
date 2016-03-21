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
setprop persist.debug.wfd.enable 1

setprop persist.sys.purgeable_assets 1 # only for CM

setprop net.tethering.noprovisioning true

echo 4096 > /proc/sys/vm/min_free_kbytes

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

if $bb test -e "/sys/block/dm-0/queue"; then # encrypted
	cd /sys/block/dm-0/queue
	$bb test -e scheduler && echo noop > scheduler # don't need two schedulers
	echo 1 > nr_requests # don't need two queues either
	echo 0 > add_random # don't contribute to entropy
	echo 64 > read_ahead_kb # encryption is cpu intensive so put back closer to default
	echo 0 > rq_affinity # there is no queue, who cares
	echo 1 > nomerges # ditto
	echo 0 > rotational # obviously
	echo 0 > iostats # cpu hog
fi

for f in /sys/devices/system/cpu/cpufreq/*; do
	$bb test -e ${f}/io_is_busy && echo 1 > ${f}/io_is_busy
done


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

# from LMR1 init.rc, for old versions
echo 300 > /proc/sys/net/unix/max_dgram_qlen
# Define TCP buffer sizes for various networks
#   ReadMin, ReadInitial, ReadMax, WriteMin, WriteInitial, WriteMax,
setprop net.tcp.buffersize.default 4096,87380,110208,4096,16384,110208
setprop net.tcp.buffersize.wifi 524288,1048576,2097152,262144,524288,1048576
setprop net.tcp.buffersize.ethernet 524288,1048576,3145728,524288,1048576,2097152
setprop net.tcp.buffersize.lte 524288,1048576,2097152,262144,524288,1048576
setprop net.tcp.buffersize.umts 58254,349525,1048576,58254,349525,1048576
setprop net.tcp.buffersize.hspa 40778,244668,734003,16777,100663,301990
setprop net.tcp.buffersize.hsupa 40778,244668,734003,16777,100663,301990
setprop net.tcp.buffersize.hsdpa 61167,367002,1101005,8738,52429,262114
setprop net.tcp.buffersize.hspap 122334,734003,2202010,32040,192239,576717
setprop net.tcp.buffersize.edge 4093,26280,70800,4096,16384,70800
setprop net.tcp.buffersize.gprs 4092,8760,48000,4096,8760,48000
setprop net.tcp.buffersize.evdo 4094,87380,262144,4096,16384,262144
# Define default initial receive window size in segments.
setprop net.tcp.default_init_rwnd 60

# for (mostly) fixing audio stutter when multitasking

$bb renice -15 $($bb pidof hd-audio0) #avoid underruns
$bb nohup su -cn u:r:init:s0 -c "$bb sh /system/etc/parrotmod/postboot.sh" >/dev/null 2>&1 &
