#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

while [ "$($bb pidof com.android.systemui)" = "" ]; do sleep 1; done

[ -e "/system/etc/parrotmodstock/postboot.sh" ] && . "/system/etc/parrotmodstock/postboot.sh" # @me: don't get rid of .

if [ "$(settings get global parrotmod_univ_last_version)" != "2.0rc5" ]; then
# do I need these??
  settings put global sys_storage_full_threshold_bytes 8388608
  settings put global sys_storage_threshold_percentage 2
  settings put global sys_storage_threshold_max_bytes 104857600
  settings put global fstrim_mandatory_interval 259200000 # 3 days, same as stock
  settings put global tether_dun_required 0
  
  settings put global parrotmod_univ_last_version "2.0rc5"
  $bb rm -f /data/lastpmver.txt /data/lastpmver_univ.txt
  
  am start -a android.intent.action.REBOOT # cleaner reboot
  
fi

# FIXME: block changes by AM (again)
echo "0,1,2,4,7,15" > /sys/module/lowmemorykiller/parameters/adj  # https://android.googlesource.com/platform/frameworks/base/+/master/services/core/java/com/android/server/am/ProcessList.java#50
echo "8192,10240,12288,14336,16384,20480" > /sys/module/lowmemorykiller/parameters/minfree # the same as Moto G 5.1, and AOSP 4.x

#block ota
pm disable 'com.google.android.gms/.update.SystemUpdateActivity'
pm disable 'com.google.android.gms/.update.SystemUpdateService$ActiveReceiver'
pm disable 'com.google.android.gms/.update.SystemUpdateService$Receiver'
pm disable 'com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver'
pm disable 'com.google.android.gsf/.update.SystemUpdateActivity'
pm disable 'com.google.android.gsf/.update.SystemUpdatePanoActivity'
pm disable 'com.google.android.gsf/.update.SystemUpdateService$Receiver'
pm disable 'com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver'
