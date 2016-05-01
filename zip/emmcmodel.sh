#!/sbin/sh
manfid=$(cat /sys/block/mmcblk0/device/manfid)
echo "emmc.manfid=$manfid" > /tmp/emmc.prop
exit 0