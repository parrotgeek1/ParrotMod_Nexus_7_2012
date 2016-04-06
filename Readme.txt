What?
=====

This is a mod to greatly improve the performance of the 2012 Nexus 7, on ANY rooted ROM. 

XDA thread: http://forum.xda-developers.com/nexus-7/orig-development/parrotmod-speed-2012-nexus-7-emmc-fix-t3300416

Download: http://download.parrotgeek.com/android/ParrotMod_Grouper_Stable_Universal.zip

Performance Video (old): https://www.youtube.com/watch?v=CSp8mc5ZkkE

Upgrade notes
-------------

It is safe to flash new ParrotMod versions without wiping data, but if you use the Stock 5.1.1 version you must flash Universal update first.
IF YOU UPGRADE MAJOR ANDROID VERSIONS YOU MUST WIPE SYSTEM, FLASH THE WHOLE ROM, AND REINSTALL PARROTMOD.
UPGRADING ROM BUILDS WORKS FINE! In ROMs with addon.d support, it will even keep ParrotMod installed.

Notes
-----

REQUIRES LATEST SUPERSU INSTALLED FIRST http://download.chainfire.eu/supersu-stable
Miracast will freeze the tablet on disconnection unless you disconnect from the TV/dongle side. This is a common Tegra issue.
The optimizations to the ART runtime do not work when Xposed is installed, and you will see reduced performance! They also don't work on 4.4 or 5.0.

Recommended Kernel: 
===================
http://forum.xda-developers.com/nexus-7/development/kernel-dc-kernel-t3310642

Slow charging hardware fix:
===========================
http://forum.xda-developers.com/showthread.php?p=65039448

Features:
=========

FLASH MEMORY SPEED INCREASE! up to 4x better performance WITHOUT F2FS OR DYNAMIC FSYNC
uses ext4 but can use data/cache f2fs
audio stutter and multitasking fix
miracast enabled (but it freezes on disconnect unless you unplug from the receiver end)
can set up device without wifi
Bluetooth 4.0 enabled (BLE/GATT/SMP)
more apps open at once (minfree tweak, scheduler tweaks, 64k log buffers, zram optimized)
LCD color fix (no Nvidia smartdimmer/Prism)
internet optimizations
can use more storage space before it doesn't let you
Survives ROM updates with addon.d
block Google ota updates
tethering without carrier checks on tilapia
Speed up full disk encryption, but it's still pretty bad
GPU optimizations (without OC!)
Reverted to dlmalloc for reducing ram usage
ART_USE_HSPACE_COMPACT enabled for better garbage collection

Credit
------

Busybox from https://busybox.net/downloads/binaries/
libc/libart from i9300 CM13/JustArchi CM12.1 old beta

Thanks
------

Thanks to bangsergio on XDA for testing several dozen beta versions
