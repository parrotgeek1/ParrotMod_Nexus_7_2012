#!/sbin/sh
echo 'bb.exists=0' > /tmp/bb.prop
/sbin/busybox true && echo 'bb.exists=1' > /tmp/bb.prop
exit 0
