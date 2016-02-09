What?
=====

This is a mod to greatly improve the performance of the 2012 Nexus 7, on ANY rooted ROM.

XDA thread: http://forum.xda-developers.com/nexus-7/orig-development/parrotmod-speed-2012-nexus-7-emmc-fix-t3300416

Download: http://download.parrotgeek.com/android/ParrotMod_Grouper_Stable_Univ.zip

Performance Video: https://www.youtube.com/watch?v=CSp8mc5ZkkE

You can install it on top of stock 5.1.1 WITHOUT ERASING YOUR DATA!

Features:
=========

FLASH MEMORY SPEED INCREASE! up to 4x better performance WITHOUT F2FS OR DYNAMIC FSYNC
uses ext4 but can use data/cache f2fs
lots of features like sweep2wake/dt2w/governors/etc can be changed in Kernel Adiutor
1.5ghz overclock, 55mhz underclock, interactive governor, cfq
mostly audio stutter fix
scheduler tweaks
miracast enabled
Bluetooth 4.0 enabled (BLE/GATT/SMP)
more apps open at once (minfree tweak, kernel samepage merging)
a bunch of processes reniced/io priority increased to fix lag
hard freezes are less likely
LCD color banding fix (error-diffusion dithering)
no nvidia smartdimmer/Prism
Battery percentage on by default
faster boot
64k log buffers
no Gentle Fair Sleepers (I don't know, either. It helps with lag spikes)
adb insecure, permissive selinux (let's call it a feature)
no preferred networks nag
always allow wifi roam scans
can use more storage space before it doesn't let you
Fstrim system after install & Fstrim data & cache every boot

Credit
------

The kernel is Plain Kernel by @Snuzzo on XDA
Busybox from https://busybox.net/downloads/binaries/
haveged from ArchiDroid