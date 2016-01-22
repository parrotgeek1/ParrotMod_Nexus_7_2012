What?
=====

This is an optimized rom for the 2012 Nexus 7 aka grouper.

Download: https://github.com/parrotgeek1/grouper_stockmod/archive/master.zip

Features:

FLASH MEMORY SPEED INCREASE! up to 6x better performance WITHOUT F2FS OR DYNAMIC FSYNC
uses ext4 but can use data/cache f2fs
audio stutter fix
stagefright fix
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

Instructions
============

Flash Stock LMY48V but keep TWRP
Flash this zip
Flash SuperSU. IN THAT ORDER. If you don't root it will bootloop because su is used in an init.d script

Credit
-----

The kernel is Plain Kernel by @Snuzzo on XDA

To do
-----

performance/noop at boot
more debloat?
A faster browser optimized for tegra?
Renice the framework/system ui/other system processes/DL manager -5, etc
Wallpapers from GNL
Does swappiness do anything
https://www.kernel.org/doc/Documentation/block/cfq-iosched.txt 
https://www.kernel.org/doc/Documentation/sysctl/vm.txt
camera LP icon
sounds from new devices
bootanim
other cve fixes
Ionice more audio/mmc kernel processes & realtime priority mediaserver etc http://www.askapache.com/optimize/optimize-nice-ionice.html 
mira4u without apk & hex edit for xml path
script rerun on soft reboot
http://forum.xda-developers.com/showthread.php?t=1792531
version for tilapia w/ tcp opts/no tether check/sms enable
support otg native
not need permissive
app ops/autostarts/supersu in settings?
no media scanner at boot
more aosp apps?
