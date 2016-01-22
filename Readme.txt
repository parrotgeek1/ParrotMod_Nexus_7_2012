What?
=====

This is an optimized rom for the 2012 Nexus 7 aka grouper.

Download: https://github.com/parrotgeek1/grouper_stockmod/archive/master.zip

Features:
=========

FLASH MEMORY SPEED INCREASE! up to 6x better performance WITHOUT F2FS OR DYNAMIC FSYNC
uses ext4 but can use data/cache f2fs
audio stutter fix
stagefright and lib(c)utils vulnerabilities fixed
Fstrim every boot
miracast/chromecast enabled (need to click disable intra macroblock refresh in app)
Bluetooth 4.0 enabled (BLE/GATT/SMP)
more apps open at once (minfree tweak, kernel samepage merging)
a bunch of processes reniced/io priority increased to fix lag
hard freezes are less likely
LCD color banding fix (error-diffusion dithering)
no nvidia smartdimmer/Prism
faster boot (wip)
debloat
new wallpaper
adb insecure
camera app is shown
MiXplorer file manager
rebooter app
Permissive selinux (let's call it a feature)
no preferred networks nag
always allow wifi roam scans
HDCP disabled
can use more storage space before it doesn't let you

Instructions
============

Flash Stock LMY48V but keep TWRP
Flash this zip
Flash SuperSU. IN THAT ORDER. If you don't root it will bootloop because su is used in an init.d script

Credit
------

The kernel is Plain Kernel by @Snuzzo on XDA
Busybox from https://busybox.net/downloads/binaries/
Miracast libs & app are modded versions of kensuke/s107ken's mira4u
reboot app https://play.google.com/store/apps/details?id=com.stephansmolek.reboot&hl=en
BSZAospLp rom for stagefright libs http://forum.xda-developers.com/nexus-7/development/rom-t2931064
HootanParsa for MiXplorer http://forum.xda-developers.com/showthread.php?t=1523691
Nexus 7 Camera https://play.google.com/store/apps/details?id=com.helffo.cameralauncher&hl=en

To do
-----

the other reboot app https://play.google.com/store/apps/details?id=phongit.quickreboot&hl=en ?
Real extended power menu not app
Fstrim data/cache/system after install
Fstrim cache every boot
performance/noop at boot
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
Make marshmallow version with miracast from tegra device, and version for any rom
S2W/DT2W settings
Fix android pay/wallet/Snapchat/etcwith root
deodex?
OTA updates?
