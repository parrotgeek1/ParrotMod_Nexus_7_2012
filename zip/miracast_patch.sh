#!/sbin/sh
/sbin/busybox test ! -e /system/lib/libstagefright_wfd.so && exit 0
# for addon.d later
rm /system/etc/parrotmod/libstagefright_wfd.so.orig
cat /system/lib/libstagefright_wfd.so > /system/etc/parrotmod/libstagefright_wfd.so.orig
# sometimes the most compatible way is the worst way
LC_ALL=C /sbin/busybox sed -i 's@intra-refresh-mode@intra-refresh-NOPE@g' /system/lib/libstagefright_wfd.so
exit 0