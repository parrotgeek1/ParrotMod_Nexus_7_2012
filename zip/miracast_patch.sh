#!/sbin/sh
# sometimes the most compatible way is the worst way
LC_ALL=C /sbin/busybox sed -i 's@intra-refresh-mode@intra-refresh-NOPE@g' /system/lib/libstagefright_wfd.so
exit 0
