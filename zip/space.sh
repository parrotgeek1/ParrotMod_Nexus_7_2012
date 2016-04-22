#!/sbin/sh
bb=/sbin/busybox
need=$1
echo 'enough.space=0' > /tmp/space.prop
has=$($bb df -m /system | $bb tail -n 1 | $bb awk '{print $4}')
/sbin/busybox test "$has" -ge "$need" && echo 'enough.space=1' > /tmp/space.prop
exit 0