#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

# https://android.googlesource.com/device/huawei/angler/+/master/init.angler.power.sh

################################################################################
# helper functions to allow Android init like script
function write() {
    $bb echo -n $2 > $1
}
################################################################################

# ram tuning
# https://01.org/android-ia/user-guides/android-memory-tuning-android-5.0-and-5.1

cd /sys/kernel/mm/ksm 
echo 100 > pages_to_scan
echo 500 > sleep_millisecs
echo 1 > run

setprop ctl.stop perfprofd # useless service on M+

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

# https://android.googlesource.com/platform/system/core/+/master/rootdir/init.rc#108
    # scheduler tunables
    # Disable auto-scaling of scheduler tunables with hotplug. The tunables
    # will vary across devices in unpredictable ways if allowed to scale with
    # cpu cores.
    write /proc/sys/kernel/sched_tunable_scaling 0
    write /proc/sys/kernel/sched_latency_ns 10000000
    write /proc/sys/kernel/sched_wakeup_granularity_ns 2000000
    write /proc/sys/kernel/sched_compat_yield 1
    write /proc/sys/kernel/sched_child_runs_first 0
# SNIP irrelevant security stuff
    write /proc/sys/net/unix/max_dgram_qlen 600
    write /proc/sys/kernel/sched_rt_runtime_us 950000
    write /proc/sys/kernel/sched_rt_period_us 1000000

# https://android.googlesource.com/platform/system/core/+/master/rootdir/init.rc#444
    # Tweak background writeout
    write /proc/sys/vm/dirty_expire_centisecs 200
    write /proc/sys/vm/dirty_background_ratio  5

# battery
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

# fs tune

for m in /data /cache /system; do
	mount | $bb grep "$m" | $bb grep -q ext4 && mount -o remount,noauto_da_alloc,delalloc,discard,journal_async_commit,journal_ioprio=5,barrier=0,commit=15,noatime,nodiratime,inode_readahead_blks=64,dioread_nolock,max_batch_time=15000,nomblk_io_submit "$m" "$m"
	mount | $bb grep "$m" | $bb grep -q f2fs && mount -o remount,nobarrier,flush_merge,inline_xattr,inline_data,inline_dentry,discard "$m" "$m"
done
mount | $bb grep '/system' | $bb grep -q ext4 && mount -o remount,inode_readahead_blks=128,max_batch_time=20000 /system /system

for f in /sys/fs/ext4/*; do
	$bb test "$f" = "/sys/fs/ext4/features" && continue
	echo 8 > ${f}/max_writeback_mb_bump
	echo 1 > ${f}/mb_group_prealloc
	echo 0 > ${f}/mb_stats
	echo 32 > ${f}/mb_stream_req # 128kb
done

if $bb test -e "/sys/block/dm-0/queue"; then # encrypted
	cd /sys/block/dm-0/queue
	$bb test -e scheduler && echo none > scheduler # don't need two schedulers
	echo 1 > nr_requests # unnecessary
	echo 0 > add_random # don't contribute to entropy
	echo 64 > read_ahead_kb # encryption is cpu intensive so put back closer to default
	echo 0 > rq_affinity # there is no queue, who cares
	echo 0 > nomerges # try to merge
	echo 0 > rotational # obviously
	echo 0 > iostats # cpu hog
	mount | $bb grep "/data" | $bb grep -q ext4 && mount -o remount,commit=20,inode_readahead_blks=128,max_batch_time=20000 "/data" "/data"
fi

for f in /sys/devices/system/cpu/cpufreq/*; do
	$bb test -e ${f}/io_is_busy && echo 1 > ${f}/io_is_busy
done

echo 0 > /proc/sys/vm/page-cluster # zram is not a disk with a sector size

if $bb test -e "/sys/block/zram0"; then 
	echo lz4 > /sys/block/zram0/comp_algorithm # less cppu intensive than lzo
	echo 2 > /sys/block/zram0/max_comp_streams # on 2015 Google devices, this is half the number of cores
fi

# GPU

echo 0 > /sys/devices/tegradc.0/smartdimmer/enable
setprop persist.tegra.didim.enable 0
echo 1 > /sys/devices/host1x/gr3d/enable_3d_scaling

# for (mostly) fixing audio stutter when multitasking

$bb renice -10 $($bb pidof hd-audio0) #avoid underruns
$bb nohup su -cn u:r:init:s0 -c "$bb sh /system/etc/parrotmod/postboot.sh" >/dev/null 2>&1 &
