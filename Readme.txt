What is ParrotMod?
==================

This is a mod to greatly improve the performance of the 2012 Nexus 7, on ANY rooted Android 4.3+ ROM.
It doesn't work on Nougat. I can't fix it, because I don't own this device anymore - I gave it to a friend's little brother.
Feel free to fork it and fix that.

(Got a 2013 Nexus 7? Use this version: http://forum.xda-developers.com/nexus-7-2013/orig-development/beta-1-parrotmod-improve-2013-nexus-7-t3375928)

Download: http://download.parrotgeek.com/Android/ParrotMod/

Use the 2016-08-31 one if the latest one doesn't improve the speed.

GitHub: https://github.com/parrotgeek1/ParrotMod_Grouper
Feel free to fork/pull request! But always credit me if you make something based on it and ask me for permission first.

Performance Video (very old): https://www.youtube.com/watch?v=CSp8mc5ZkkE

IMPORTANT NOTE
--------------

ParrotMod needs 8MB of free space on the system partition. Don't use huge gapps packages.
ParrotMod requires a recovery that has BusyBox built in. (All versions of TWRP do. CWM does not.)

PLEASE disable IO scheduler/RAM/read ahead tweaks in kernel apps. They override ParrotMod's meticulously optimized settings.

REQUIRES LATEST SUPERSU INSTALLED FIRST http://download.chainfire.eu/supersu-stable
EVEN IF YOUR ROM HAS BUILT IN ROOT LIKE CYANOGENMOD, TURN IT OFF IN SETTINGS, THEN FLASH SUPERSU!!

If the installer warns you about TRIM on boot being disabled, it's a good idea to schedule TRIM using an app like Trimmer, or just leave your tablet on overnight (on silent) instead of turning it off, so it can automatically trim.

You can tell if ParrotMod is working by opening a terminal emulator app and typing:

su
getprop parrotmod.running

If it says "yes" then it works.

Features:
=========

FLASH MEMORY SPEED INCREASE! up to 4x better performance WITHOUT F2FS OR DYNAMIC FSYNC
Auto trim at boot, but ONLY for Samsung flash storage (it is too slow for Hynix/Kingston)
Uses ext4 but can use data/cache f2fs
Audio stutter and multitasking fix
Miracast enabled (but it freezes on disconnect unless you unplug from the receiver end)
Can set up device without Wi-Fi
Bluetooth 4.0 enabled (BLE/GATT/SMP), CVE vulnerabilities fixed (for 5.x)
More apps open at once (minfree tweak, scheduler tweaks, 64k log buffers, zram optimized)
LCD color fix (no Nvidia smartdimmer/Prism)
Internet optimizations
Can use more storage space before it doesn't let you
Survives ROM updates with addon.d
Tethering without carrier checks on 3G Nexus 7
Speed up full disk encryption
GPU optimizations (without OC!) and hardware acceleration properties, decrease GPU RAM usage by 4.4mb per app!
Reverted to dlmalloc for reducing ram usage / ART_USE_HSPACE_COMPACT enabled for better garbage collection [Not on 5.0.x]

Instructions - From unrooted stock 5.1.1
========================================

Download KingRoot apk from http://www.kingroot.net/ on your tablet, install it, ignore the warnings about the app being unsafe, and tap Root. If it says root failed, try again. It will eventually work.
Install Flashify from the Play Store
Download the latest Universal zip in the download link above on your tablet
Download the SuperSU zip from http://download.chainfire.eu/supersu-stable on your tablet
Open Flashify and install TWRP recovery, the latest version (3.0.2 currently)
Open the KingRoot app, tap Menu 3 dots icon, General settings, uninstall KingRoot
Delete the KingRoot and Purify Apps
Plug your tablet into a computer! (not even a charger) otherwise it will freeze on the next step. This is a bug in the tablet itself.
Reboot your tablet while holding the power and volume down buttons. If this does not work power on while holding BOTH volume UP and DOWN. 
Scroll with volume buttons to Recovery mode and tap power button
You will see a Google screen and then TeamWin logo, just wait
Tap Never show this screen again and Swipe to allow modification
Tap Install
You will see the files on your internal storage, go to Download folder
Tap on ParrotMod_Grouper_Universal_XXXXXXX.zip
Tap add more zips
You will see the files on your internal storage, go to Download folder
Tap on UPDATE-SuperSU-v2.XX.zip
Swipe to confirm flash
When it finishes installing tap Reboot System
Your tablet will reboot
Wait 30 seconds for the device to settle
Enjoy the improved speed! (You can delete ParrotMod_Grouper_Universal_XXXXXXX.zip now)

Extras
======

Fix for speaker/headphone buzzing while charging: http://download.parrotgeek.com/android/ParrotMod/ChargingNoiseFix/

Upgrade notes
-------------

It is safe to flash new ParrotMod versions without wiping data.
IF YOU UPGRADE MAJOR ANDROID VERSIONS YOU MUST WIPE SYSTEM, FLASH THE WHOLE ROM, AND REINSTALL PARROTMOD.
UPGRADING ROM BUILDS WORKS FINE! In ROMs with addon.d support, it will even keep ParrotMod installed.

Please don't use with ParrotMod:
--------------------------------

L Speed/any other "supercharger" like tweaks. I will ignore any support requests if you use them. Most are very badly programmed/full of placebos.
Disable journaling zip (it conflicts with my script, and doesn't improve performance)
Don't limit background processes, it might even make the tablet SLOWER. As of version 2016-04-30, the installer script removes this setting from build.prop automatically.

Known Bugs
----------

Miracast will freeze the tablet on disconnection unless you disconnect from the TV/dongle side. This is a common Tegra issue.
The optimizations to the ART runtime do not work when Xposed is installed, and you will see reduced performance! They also don't work on 4.4.x or 5.0.x.

Recommended Kernel: 
===================
http://forum.xda-developers.com/nexus-7/development/kernel-dc-kernel-t3310642

Slow charging hardware fix:
===========================

http://forum.xda-developers.com/showthread.php?p=65039448

Credit
------

Busybox from BSZAospLp ROM LMY49H
libc/libart from i9300 CM14/i9300 CM13/i9300 JustArchi CM12.1 old beta
Charging Noise Fix is based on an apk from the Moto G 2015 stock ROM.
Bluetooth 4.0 libs for 4.3 from https://github.com/manuelnaranjo/AndroidBluetoothLowEnergyEnabler/tree/master/releases
BT4.0 KitKat libs from cm-11-20160509-UNOFFICIAL-grouper by @dookie23
BT4.0 5.x libs from Dreams - version 5.3.9.4 for Maguro
BT4.0 6.x libs from aosp_grouper-ota-eng-20160803.ds.zip by @AndDiSa
BT4.0 7.x libs from cm-14.0-20160924-UNOFFICIAL-i9300.zip by @Taker18

Thanks
------

Thanks to @bangsergio for testing several dozen beta versions.
Thanks to @nereis for showing me a zram tweak.

How ParrotMod Works
-------------------

ParrotMod works by trying to counteract the slow flash storage speed, by decreasing unnecessary reads and writes, and also optimizing how well processes share the bandwidth.
To optimize RAM, it also changes minfree values, replaces libart and libc with optimized versions (reverting to the memory allocator that was in 4.4.4), and enables zram (but in a less CPU intensive compression mode).
It also enables GPU clock scaling instead of throttling based on CPU speed, to improve performance in GPU-bound games. It also disables nvidia PRISM adaptive backlight to fix washed out screen in videos. 
It increases the CPU priority of audio players, and the hd-audio0 kernel thread, to fix sound stutter when multitasking.
Finally, it increases wifi transmit power and noise filter in nvram.txt to increase wifi range.
I also made my own patches to enable miracast and BT 4.0.