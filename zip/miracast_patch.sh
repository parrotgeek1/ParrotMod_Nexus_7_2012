#!/sbin/sh
# for addon.d later
rm -f /system/etc/parrotmod/libstagefright_wfd.so.orig
cp /system/lib/libstagefright_wfd.so /system/etc/parrotmod/libstagefright_wfd.so.orig
# sometimes the most compatible way is the worst way
LC_ALL=C busybox sed -i 's@intra-refresh-mode@intra-refresh-NOPE@g' /system/lib/libstagefright_wfd.so
