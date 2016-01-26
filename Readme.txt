What?
=====

This is an optimized ROM for the 2012 Nexus 7 aka grouper.

XDA thread: http://forum.xda-developers.com/nexus-7/orig-development/parrotmod-speed-2012-nexus-7-emmc-fix-t3300416

Download: http://download.parrotgeek.com/android/ParrotMod_Grouper_Stable.zip

Video: https://www.youtube.com/watch?v=CSp8mc5ZkkE

You can install it on top of stock 5.1.1 WITHOUT ERASING YOUR DATA!

Features:
=========

FLASH MEMORY SPEED INCREASE! up to 4x better performance WITHOUT F2FS OR DYNAMIC FSYNC
uses ext4 but can use data/cache f2fs
lots of features like sweep2wake/dt2w/governors/etc can be changed in Kernel Adiutor
1.5ghz overclock, 55mhz underclock, interactive governor, cfq
mostly audio stutter fix
scheduler tweaks
stagefright and lib(c)utils vulnerabilities fixed
miracast enabled
Bluetooth 4.0 enabled (BLE/GATT/SMP)
more apps open at once (minfree tweak, kernel samepage merging)
a bunch of processes reniced/io priority increased to fix lag
AOSP lollipop launcher without Google now
New default wallpaper (quality could be better though)
hard freezes are less likely
LCD color banding fix (error-diffusion dithering)
no nvidia smartdimmer/Prism
Battery percentage on by default
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
Fstrim system after install & Fstrim data & cache every boot

Instructions - From unrooted stock 5.1.1
========================================

Download KingRoot from http://www.kingroot.net/, install it, ignore the warnings, and tap Root
Install Flashify from the Play Store
Download the zip in the download link on your tablet
Download the zip from https://download.chainfire.eu/696/SuperSU on your tablet
Open Flashify and install TWRP recovery, the latest version
Open the KingRoot app, tap Menu 3 dots icon, General settings, uninstall KingRoot
Delete the KingRoot and Purify Apps
Plug your tablet into a computer! (not even a charger) otherwise it will freeze on the next step. This is a bug in the tablet itself.
Reboot your tablet while holding the power and volume down buttons. if this does not work power on while holding BOTH volume UP and DOWN. 
Scroll with volume buttons to Recovery mode and tap power button
You will see a Google screen and then TeamWin logo, just wait
Tap Never show this screen again and Swipe to allow modification
Tap Install
You will see the files on your internal storage, go to Download folder
Tap on ParrotMod_Grouper_Stable.zip
Tap add more zips
You will see the files on your internal storage, go to Download folder
Tap on UPDATE-SuperSU-v2.46.zip
Swipe to confirm flash
When it finishes installing tap Reboot System
Your tablet will reboot (THE FIRST BOOT WILL TAKE 5-10 MIN)
Wait for device to spontaneously reboot after the lock screen appears (this next boot will take ~45 sec)
Wait 30 seconds for the device to settle
Enjoy the improved speed! (You can delete ParrotMod_Grouper_Stable.zip now)

Instructions - Advanced users
=============================

Flash Stock LMY47V factory image https://developers.google.com/android/nexus/images?hl=en
Install TWRP and reboot to recovery.
Flash this zip (from the download link. don't extract it, just copy it to the tablet)
Flash SuperSU. IN THAT ORDER. If you don't root it will bootloop because su is used in an init.d script
Reboot (THE FIRST BOOT WILL TAKE 5-10 MIN)
Wait for device to spontaneously reboot (this boot will take ~35 sec)
Proceed with setup

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
https://www.kernel.org/doc/Documentation/block/cfq-iosched.txt 
https://www.kernel.org/doc/Documentation/sysctl/vm.txt
camera LP icon
sounds from new devices
other cve fixes http://forum.xda-developers.com/showpost.php?p=63661692&postcount=2 https://source.android.com/security/bulletin/
Ionice more audio/mmc kernel processes & realtime priority mediaserver etc http://www.askapache.com/optimize/optimize-nice-ionice.html 
script rerun on soft reboot
http://forum.xda-developers.com/showthread.php?t=1792531
version for tilapia w/ tcp opts/no tether check/sms enable
support otg native
not need permissive OR root
not insecure adb
more aosp apps?
version for any rom with miracast https://android.googlesource.com/platform/frameworks/av/+/master/media/libstagefright/wifi-display/source/Converter.cpp#161
S2W/DT2W settings
Fix wallet/Snapchat/etc with root cloak
deodex
OTA updates?
can change lid magnet switch behavior
config_safe_media_volume_enabled false overlay
install root
FRP?
ambient display?
viper4android?
update gapps
all BB symlinks auto https://gist.github.com/pocke/7667894 except su and use armv7 android busybox
WiFidisplaysupportsprotectedbuffers?
Add to website
Why does it reodex
Another contacts app with groups?
Cm calculator?
Wi-Fi tweaks and increase range
Parrot wallpaper looks bad in portrait
TCP congestion change?
Disable otas
Lower the amount of unwritten write cache to reduce lags when a huge write is required. Increase tendency of kernel to keep block-cache to help with slower RFS filesystem. 
more scheduler tweaks
http://andrs.w3pla.net/autokiller/kernel
http://www.droidforums.net/threads/simply-stunning-5-4-tweaks-for-all.154543/
Media mute? And other silent mode tweaks?
other governor?
look more at ss4n1
switch to http://forum.xda-developers.com/showthread.php?t=2168787 but NOT dynamic fsync
https://github.com/Metallice/android_kernel_grouper/commit/aac1d3ba8639a6b39f64fdba4daf4698b5a00655 audio perflock or change minimum cpu to 200ish?
MM boot anim
https://android.googlesource.com/platform/frameworks/av/+/master/media/libstagefright/wifi-display/source/Converter.cpp#161 bitrate miracast
