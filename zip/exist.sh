#!/sbin/sh
echo 'file.exists=0' > /tmp/exist.prop
/sbin/busybox test -e "$1" && echo 'file.exists=1' > /tmp/exist.prop
exit 0