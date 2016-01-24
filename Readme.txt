What?
=====

This is an optimized ROM for the 2012 Nexus 7 aka grouper.

Download: http://download.parrotgeek.com/android/ParrotMod_Grouper_Stable.zip

You can install it on top of stock 5.1.1 WITHOUT ERASING YOUR DATA!

Instructions - From unrooted stock 5.1.1
========================================

Download KingRoot from http://www.kingroot.net/, install it, ignore the warnings, and tap Root
Install Flashify from the Play Store
Download the zip in the download link on your tablet
Open Flashify and install TWRP recovery, the latest version
Open the KingRoot app, tap Menu 3 dots icon, General settings, uninstall KingRoot
Delete the KingRoot and Purify Apps
Reboot your tablet while holding the power and volume down buttons
Scroll with volume buttons to Recovery mode and tap power button
You will see a Google screen and then TeamWin logo, just wait
Tap Never show this screen again and Swipe to allow modification
Tap Install
You will see the files on your internal storage, go to Download folder
Tap on ParrotMod_Grouper_Stable.zip
Swipe to confirm flash
When it finishes installing tap Reboot System
Your tablet will reboot (THE FIRST BOOT WILL TAKE 5-10 MIN)
Wait for device to spontaneously reboot after the lock screen appears (this next boot will take ~45 sec)
Wait 30 seconds for the device to settle
Enjoy the improved speed! (You can delete ParrotMod_Grouper_Stable.zip now)

Instructions - Advanced users
=============================

Flash Stock LMY48V factory image https://developers.google.com/android/nexus/images?hl=en
Install TWRP and reboot to recovery.
Flash this zip (from the download link. don't extract it, just copy it to the tablet)
Flash SuperSU. IN THAT ORDER. If you don't root it will bootloop because su is used in an init.d script
Reboot (THE FIRST BOOT WILL TAKE 5-10 MIN)
Wait for device to spontaneously reboot (this boot will take ~35 sec)
Proceed with setup

Features:
=========

FLASH MEMORY SPEED INCREASE! up to 4x better performance WITHOUT F2FS OR DYNAMIC FSYNC
uses ext4 but can use data/cache f2fs
lots of features like sweep2wake/dt2w/governors/etc can be changed in Kernel Adiutor
1.5ghz overclock, 55mhz underclock, interactive governor, cfq
mostly audio stutter fix
scheduler tweaks
stagefright and lib(c)utils vulnerabilities fixed
Fstrim every boot
miracast/chromecast enabled (need to click disable intra macroblock refresh in app)
Bluetooth 4.0 enabled (BLE/GATT/SMP)
more apps open at once (minfree tweak, kernel samepage merging)
a bunch of processes reniced/io priority increased to fix lag
hard freezes are less likely
LCD color banding fix (error-diffusion dithering)
no nvidia smartdimmer/Prism
faster boot
debloat
64k log buffers
no Gentle Fair Sleepers (I don't know, either. It helps with lag spikes)
new wallpaper
adb insecure
camera app is shown
simple file manager https://play.google.com/store/apps/details?id=fm.clean&hl=en
Permissive selinux (let's call it a feature)
no preferred networks nag
always allow wifi roam scans
can use more storage space before it doesn't let you
Fstrim data/cache/system after install
Fstrim cache every boot

Credit
------

The kernel is Plain Kernel by @Snuzzo on XDA
Busybox from https://busybox.net/downloads/binaries/
Miracast libs & app are modded versions of kensuke/s107ken's mira4u
BSZAospLp rom for stagefright libs http://forum.xda-developers.com/nexus-7/development/rom-t2931064
Nexus 7 Camera https://play.google.com/store/apps/details?id=com.helffo.cameralauncher&hl=en

To do
-----

Real extended power menu
more debloat?
A faster browser optimized for tegra? and/or optimize chrome and webview
Renice the framework/system ui/other system processes/DL manager -5, etc
Wallpapers from GNL
Does swappiness do anything
https://www.kernel.org/doc/Documentation/block/cfq-iosched.txt 
https://www.kernel.org/doc/Documentation/sysctl/vm.txt
camera LP icon
sounds from new devices
gpu oc/uv/etc, MAYBE cpu
bootanim
other cve fixes
Ionice more audio/mmc kernel processes & realtime priority mediaserver etc http://www.askapache.com/optimize/optimize-nice-ionice.html 
mira4u without apk & hex edit for xml path
script rerun on soft reboot
http://forum.xda-developers.com/showthread.php?t=1792531
version for tilapia w/ tcp opts/no tether check/sms enable
support otg native
not need permissive OR root
not insecure adb
app ops/autostarts/supersu in settings?
no media scanner at boot
more aosp apps?
Make marshmallow version with miracast from http://forum.xda-developers.com/galaxy-nexus/development/rom-dreams-version-5-1-t2510649/post57458796#post57458796, and version for any rom
S2W/DT2W settings
Fix android pay/wallet/Snapchat/etc with root
deodex?
OTA updates?
