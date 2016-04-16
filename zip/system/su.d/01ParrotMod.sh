#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

# https://android.googlesource.com/device/huawei/angler/+/master/init.angler.power.sh

################################################################################
# helper functions to allow Android init like script
function write() {
    $bb echo -n $2 > $1 2>/dev/null
}
################################################################################

# Disable sysrq from keyboard
write /proc/sys/kernel/sysrq 0

# ram tuning
# https://01.org/android-ia/user-guides/android-memory-tuning-android-5.0-and-5.1

write /sys/kernel/mm/ksm/run 0 # too cpu intensive, not much savings

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

# https://developers.google.com/speed/articles/tcp_initcwnd_paper.pdf
write /proc/sys/net/ipv4/tcp_default_init_rwnd 16

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

    # Tweak background writeout MODDED for N7
    write /proc/sys/vm/dirty_expire_centisecs 200
    write /proc/sys/vm/dirty_background_ratio 10 # was 5, a bit too low
    write /proc/sys/vm/vfs_cache_pressure 20 # default is 50
    write /proc/sys/vm/highmem_is_dirtyable 1

# battery
# https://github.com/CyanogenMod/android_kernel_asus_grouper/blob/cm-13.0/kernel/sched_features.h

write /sys/kernel/debug/sched_features ARCH_POWER

# eMMC speed

write /proc/sys/kernel/blk_iopoll 0 # polling does not speed up this emmc & it makes cpu worse

cd /sys/block/mmcblk0/queue
echo 2048 > nr_requests
echo 0 > add_random # don't contribute to entropy
echo 0 > read_ahead_kb # yes, I am serious, see http://forum.xda-developers.com/showthread.php?t=1032317
echo 1 > rq_affinity # stay on same cpu core
echo 0 > nomerges # try hard to merge requests 
echo 0 > rotational # obviously
echo 0 > iostats # cpu hog

# https://www.kernel.org/doc/Documentation/block/cfq-iosched.txt

echo cfq > scheduler
echo 8 > iosched/slice_async_rq # they should be the same ratio as slices
echo 24 > iosched/quantum 
echo 40 > iosched/slice_async
echo 120 > iosched/slice_sync
echo 0 > iosched/slice_idle 
echo 1 > iosched/group_idle # TESTING for enable kernel request ordering
echo 80 > iosched/fifo_expire_sync
echo 240 > iosched/fifo_expire_async
echo "1" > iosched/low_latency
write iosched/target_latency 240 # not in 3.1
echo "1" > iosched/back_seek_penalty # no penalty
echo "1000000000" > iosched/back_seek_max # i.e. the whole disk

# fs tune

# not using discard because it makes audio stutter worse

for m in /data /cache /system; do
	$bb fstrim $m
	mount | $bb grep "$m" | $bb grep -q ext4 && mount -o remount,noauto_da_alloc,delalloc,journal_async_commit,journal_ioprio=7,barrier=0,commit=15,noatime,nodiratime,inode_readahead_blks=8,dioread_nolock,max_batch_time=15000,nomblk_io_submit "$m" "$m"
	mount | $bb grep "$m" | $bb grep -q f2fs && mount -o remount,nobarrier,flush_merge,inline_xattr,inline_data,inline_dentry "$m" "$m"
done
mount | $bb grep '/system' | $bb grep -q ext4 && mount -o remount,inode_readahead_blks=16 /system /system

for f in /sys/fs/ext4/*; do
	$bb test "$f" = "/sys/fs/ext4/features" && continue
	# http://lxr.free-electrons.com/source/fs/ext4/mballoc.c#L133
	echo 4 > ${f}/max_writeback_mb_bump
	echo 256 > ${f}/mb_group_prealloc
	echo 0 > ${f}/mb_stats
	echo 32 > ${f}/mb_stream_req # 128kb
	write ${f}/mb_min_to_scan 8
	write ${f}/mb_max_to_scan 8
done

for f in /sys/devices/system/cpu/cpufreq/*; do
	write ${f}/io_is_busy 0 # no poll
done

if $bb test -e "/sys/block/dm-0/queue"; then # encrypted
	cd /sys/block/dm-0/queue
	$bb test -e scheduler && echo none > scheduler # don't need two schedulers
	echo 1 > nr_requests # unnecessary
	echo 0 > add_random # don't contribute to entropy
	echo 0 > rq_affinity # there is no queue, who cares
	echo 0 > nomerges # try to merge
	echo 0 > rotational # obviously
	echo 0 > iostats # cpu hog
	mount | $bb grep "/data" | $bb grep -q ext4 && mount -o remount,inode_readahead_blks=16,max_batch_time=25000 "/data" "/data" # unsafe to increase commit=
	for f in /sys/devices/system/cpu/cpufreq/*; do
		write ${f}/io_is_busy 1 # increased cpu because encrypted
	done
fi


write /proc/sys/vm/page-cluster 0 # zram is not a disk with a sector size

if $bb test -e "/sys/block/zram0"; then # 256 mb zram if supported
	# use busybox bc some old roms swap utils don't work
	$bb swapoff /dev/block/zram0 >/dev/null 2>&1
	$bb umount /dev/block/zram0 >/dev/null 2>&1
	write /sys/block/zram0/reset 1
	write /sys/block/zram0/comp_algorithm lz4 # less cpu intensive than lzo
	write /sys/block/zram0/max_comp_streams 2 # on 2015 Google devices, this is half the number of core
	write /sys/block/zram0/disksize $((256*1024*1024))
	$bb mkswap /dev/block/zram0
	$bb swapon -p 32767 /dev/block/zram0 # max priority
fi

# GPU

echo 0 > /sys/devices/tegradc.0/smartdimmer/enable
setprop persist.tegra.didim.enable 0
echo 1 > /sys/devices/host1x/gr3d/enable_3d_scaling

$bb renice 5 $($bb pidof mmcqd/0)
$bb ionice -c 2 -n 4 -p $($bb pidof mmcqd/0) # to stop auto ionice from renice

# restrict /system/bin/sdcard to only 2 cpus. 
# Google enabled it to use 4 threads in 5.0.2 to supposedly help performance
# it actually causes MORE lag with ParrotMod
# I can't change init.rc to tell it to use only 2 threads without a custom kernel

$b test "$(getprop ro.build.version.sdk)" -ge 21 && $bb taskset 0x00000003 -p "$($bb pidof sdcard)" # 0x00000003 is processors #0 and #1

$bb nohup su -cn u:r:init:s0 -c "$bb sh /system/etc/parrotmod/postboot.sh" >/dev/null 2>&1 &
