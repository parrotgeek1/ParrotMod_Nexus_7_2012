#!/system/bin/sh

# stop this script from being killed

mypid=$$
echo "-1000" > /proc/$mypid/oom_score_adj

bb=/system/etc/parrotmod/busybox

# https://android.googlesource.com/device/huawei/angler/+/master/init.angler.power.sh

################################################################################
# helper functions to allow Android init like script
function write() {
    $bb echo -n $2 > $1 2>/dev/null
}
################################################################################

# Disable sysrq from keyboard, Marshmallow does this
write /proc/sys/kernel/sysrq 0

#enable miracast
setprop persist.debug.wfd.enable 1

#enable tethering even if carrier blocks it (tilapia)
setprop net.tethering.noprovisioning true

# MULTITASKING

setprop persist.sys.purgeable_assets 1 # only for CM, can purge bitmaps

write /sys/kernel/mm/ksm/run 0 # NO KSM, too cpu intensive, not much savings

# ram tuning
# https://01.org/android-ia/user-guides/android-memory-tuning-android-5.0-and-5.1
# these are from intel's recommendation for 1gb devices

setprop dalvik.vm.heapstartsize 8m
setprop dalvik.vm.heapgrowthlimit 128m
setprop dalvik.vm.heapsize 174m
setprop dalvik.vm.heaptargetutilization 0.75
setprop dalvik.vm.heapminfree 512k
setprop dalvik.vm.heapmaxfree 8m

echo "0,1,2,4,7,15" > /sys/module/lowmemorykiller/parameters/adj  # https://android.googlesource.com/platform/frameworks/base/+/master/services/core/java/com/android/server/am/ProcessList.java#50
echo "8192,10240,12288,14336,16384,20480" > /sys/module/lowmemorykiller/parameters/minfree # the same as Moto G 5.1, and AOSP 4.x
echo 48 > /sys/module/lowmemorykiller/parameters/cost
$bb chmod -R 0555 /sys/module/lowmemorykiller/parameters # so android can't edit it

# Disable auto-scaling of scheduler tunables with hotplug. The tunables
# will vary across devices in unpredictable ways if allowed to scale with
# cpu cores.
write /proc/sys/kernel/sched_tunable_scaling 0

write /proc/sys/vm/highmem_is_dirtyable 1 # i dont actually know but it works!


cd /sys/block/mmcblk0/queue
echo 512 > nr_requests # don't clog the pipes
# ANY READ that is unnecessary is bad
echo 0 > add_random # don't contribute to entropy, it reads randomly in background
echo 0 > read_ahead_kb # yes, I am serious, see http://forum.xda-developers.com/showthread.php?t=1032317
echo 2 > rq_affinity # moving cpus is "expensive"

# https://www.kernel.org/doc/Documentation/block/cfq-iosched.txt

echo cfq > scheduler
echo 4 > iosched/slice_async_rq # they should be the same ratio as slices
echo 16 > iosched/quantum # can dispatch more to a 2048-big queue at once
echo 0 > iosched/slice_idle # never idle WITHIN groups
echo 10 > iosched/group_idle # BUT make sure there is differentiation between cgroups
echo "1" > iosched/low_latency # duh
echo "1" > iosched/back_seek_penalty # no penalty
echo "2147483647" > iosched/back_seek_max # i.e. the whole disk

# fs tune
# not using discard because it makes audio stutter worse

# trim is super slow on kingston
manfid=$(cat /sys/block/mmcblk0/device/manfid)

for m in /data /realdata /cache /system ; do
	$bb test ! -e $m && continue
	$bb test $manfid != "0x000070" && fstrim -v "$m"
	mount | $bb grep "$m" | $bb grep -q ext4 && mount -o remount,noauto_da_alloc,delalloc,journal_async_commit,journal_ioprio=7,barrier=0,commit=15,inode_readahead_blks=8,dioread_nolock "$m" "$m"
	mount | $bb grep "$m" | $bb grep -q f2fs && mount -o remount,nobarrier,flush_merge,inline_xattr,inline_data,inline_dentry "$m" "$m"
done

for f in /sys/fs/ext4/*; do
	$bb test "$f" = "/sys/fs/ext4/features" && continue
	echo 8 > ${f}/max_writeback_mb_bump # don't spend too long writing ONE file if multiple need to write
done

for f in /sys/devices/system/cpu/cpufreq/*; do
	write ${f}/io_is_busy 0 # no polling so io does not use cpu
done

if test -e "/sys/block/dm-0/queue"; then # encrypted
	cd /sys/block/dm-0/queue
	echo 0 > add_random # don't contribute to entropy
	echo 2 > rq_affinity # moving cpus is "expensive"
fi


write /proc/sys/vm/page-cluster 0 # zram is not a disk with a sector size, can swap 1 page at once

if $bb test -e "/sys/block/zram0"; then # 256 mb zram if supported
	# use busybox bc some old roms swap utils don't work
	$bb swapoff /dev/block/zram0 >/dev/null 2>&1
	$bb umount /dev/block/zram0 >/dev/null 2>&1
	write /sys/block/zram0/reset 1
	write /sys/block/zram0/comp_algorithm lz4 # less cpu intensive than lzo
	write /sys/block/zram0/max_comp_streams 2 # on 2015 Google devices, this is half the number of cores
	write /sys/block/zram0/disksize $((256*1024*1024))
	$bb mkswap /dev/block/zram0
	$bb swapon -p 32767 /dev/block/zram0 # max priority
	echo noop > /sys/block/zram0/queue/scheduler # it's not a disk
	echo 2 > /sys/block/zram0/queue/nomerges
	echo 0 > /sys/block/zram0/queue/read_ahead_kb 
	echo 2 > /sys/block/zram0/queue/rq_affinity # moving cpus is "expensive"
fi

# GPU

echo 0 > /sys/devices/tegradc.0/smartdimmer/enable # PRISM off
setprop persist.tegra.didim.enable 0 # PRISM off (2)
echo 1 > /sys/devices/host1x/gr3d/enable_3d_scaling # stop throttling gpu

# for fixing audio stutter when multitasking
# increase priority of audio, decrease priority of eMMC *when something else is using the CPU ONLY*

$bb renice -10 $($bb pidof hd-audio0)
$bb ionice -c 1 -n 2 -p $($bb pidof hd-audio0)

$bb renice 5 $($bb pidof mmcqd/0)
$bb ionice -c 2 -n 4 -p $($bb pidof mmcqd/0) # to stop auto ionice from renice
