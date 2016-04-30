What?
=====

This is a mod to greatly improve the performance of the 2012 Nexus 7, on ANY rooted ROM. (except for 4.1.x, due to SuperSU incompatibility)

XDA thread: http://forum.xda-developers.com/nexus-7/orig-development/parrotmod-speed-2012-nexus-7-emmc-fix-t3300416

Download: http://download.parrotgeek.com/android/ParrotMod/
[THESE NEW VERSIONS DO NOT AUTO REBOOT AFTER INSTALL]
Don't use Universal_Test unless I tell you to

Github: https://github.com/parrotgeek1/ParrotMod_Grouper
Feel free to fork/pull request! But always credit me if you make something based on it and ask me for permission first.

Performance Video (very old): https://www.youtube.com/watch?v=CSp8mc5ZkkE

IMPORTANT NOTE
--------------

ParrotMod needs 8MB of free space on the system partition. Don't use huge gapps packages.
ParrotMod requires a recovery that has BusyBox built in. (All versions of TWRP do. CWM does not.)
PLEASE disable io scheduler/RAM/read ahead tweaks in kernel apps. They override ParrotMod's meticulously optimized settings.
REQUIRES LATEST SUPERSU INSTALLED FIRST http://download.chainfire.eu/supersu-stable
EVEN IF YOUR ROM HAS BUILT IN ROOT LIKE CYANOGENMOD, TURN IT OFF IN SETTINGS, THEN FLASH SUPERSU!!

It's a good idea to schedule fstrim using an app like Trimmer, or just leave your tablet on overnight (on silent) instead of turning it off, so it can automatically trim.

You can tell if ParrotMod is working by checking if the file /sys/block/mmcblk0/queue/read_ahead_kb contains "0", using a root explorer.

Features:
=========

FLASH MEMORY SPEED INCREASE! up to 4x better performance WITHOUT F2FS OR DYNAMIC FSYNC
uses ext4 but can use data/cache f2fs
audio stutter and multitasking fix
miracast enabled (but it freezes on disconnect unless you unplug from the receiver end)
can set up device without wifi
Bluetooth 4.0 enabled (BLE/GATT/SMP), CVE vulnerabilities fixed (for 5.x)
more apps open at once (minfree tweak, scheduler tweaks, 64k log buffers, zram optimized)
LCD color fix (no Nvidia smartdimmer/Prism)
internet optimizations
can use more storage space before it doesn't let you
Survives ROM updates with addon.d
tethering without carrier checks on tilapia
Speed up full disk encryption, but it's still pretty bad
GPU optimizations (without OC!)
Reverted to dlmalloc for reducing ram usage / ART_USE_HSPACE_COMPACT enabled for better garbage collection [Not on 5.0.x]

Extras
======

Fix for speaker/headphone buzzing while charging
http://download.parrotgeek.com/android/ParrotMod/ChargingNoiseFix/

Upgrade notes
-------------

It is safe to flash new ParrotMod versions without wiping data.
IF YOU UPGRADE MAJOR ANDROID VERSIONS YOU MUST WIPE SYSTEM, FLASH THE WHOLE ROM, AND REINSTALL PARROTMOD.
UPGRADING ROM BUILDS WORKS FINE! In ROMs with addon.d support, it will even keep ParrotMod installed.

Please don't use with ParrotMod:
--------------------------------

L Speed/any other "supercharger" like tweaks. I will ignore any support requests if you use them. Most are very badly programmed/full of placebos.
disable journaling zip (it conflicts with my script, and doesn't improve performance)
Don't limit background processes, it might even make the tablet SLOWER. As of version 2016-04-30, the installer script removes this setting from build.prop automatically.

Known Bugs
----------

F2FS optimizations are missing, mostly because I don't want to wipe data to test them. Performance should still be fine though.
Miracast will freeze the tablet on disconnection unless you disconnect from the TV/dongle side. This is a common Tegra issue.
The optimizations to the ART runtime do not work when Xposed is installed, and you will see reduced performance! They also don't work on 4.4 or 5.0.

Recommended Kernel: 
===================
http://forum.xda-developers.com/nexus-7/development/kernel-dc-kernel-t3310642

Slow charging hardware fix:
===========================
http://forum.xda-developers.com/showthread.php?p=65039448

Credit
------

Busybox from BSZAospLp ROM LMY49H
libc/libart from i9300 CM13/JustArchi CM12.1 old beta
Charging Noise Fix is based on an apk from the Moto G 2015 stock ROM.
Bluetooth 4.0 libs from https://github.com/manuelnaranjo/AndroidBluetoothLowEnergyEnabler/tree/master/releases
5.x BT libs from Dreams - version 5.3.9.4 for Maguro

Thanks
------

Thanks to bangsergio on XDA for testing several dozen beta versions




How ParrotMod Works
-------------------

ParrotMod works by trying to counteract the slow eMMC flash speed, by decreasing unnecessary reads and writes, and also optimizing how well processes share the bandwidth.
To optimize RAM, it also changes minfree values, replaces libart and libc with optimized versions (reverting to the memory allocator that was in 4.4.4), and enables zram (but in a less CPU intensive compression mode).
It also enables GPU clock scaling instead of throttling based on CPU speed, to improve performance in GPU-bound games. It also disables nvidia PRISM adaptive backlight to fix washed out screen in videos. 
It increases the CPU priority of audio players, and the hd-audio0 kernel thread, to fix sound stutter when multitasking.
Finally, it increases wifi transmit power and noise filter in nvram.txt to increase wifi range.
(I also made my own patches to enable miracast and BT 4.0)
The code on GitHub is extremely well commented.
