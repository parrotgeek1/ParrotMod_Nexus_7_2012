#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 1; done

sleep 1

[ -e "/system/etc/parrotmodstock/postboot.sh" ] && . "/system/etc/parrotmodstock/postboot.sh" # @me: don't get rid of .

if [ "$(settings get global parrotmod_univ_last_version)" != "2.0rc7" ]; then
  settings put global sys_storage_threshold_percentage 2
  settings put global sys_storage_threshold_max_bytes 104857600
  settings put global tether_dun_required 0
  
  settings put global parrotmod_univ_last_version "2.0rc7"
  
  am start -a android.intent.action.REBOOT # cleaner reboot
fi

service call SurfaceFlinger 1009 i32 1 # https://android.googlesource.com/platform/frameworks/native/+/a45836466c301d49d8df286b5317dfa99cb83b70

echo "0,1,2,4,7,15" > /sys/module/lowmemorykiller/parameters/adj  # https://android.googlesource.com/platform/frameworks/base/+/master/services/core/java/com/android/server/am/ProcessList.java#50
echo "8192,10240,12288,14336,16384,20480" > /sys/module/lowmemorykiller/parameters/minfree # the same as Moto G 5.1, and AOSP 4.x
$bb chmod -R 0555 /sys/module/lowmemorykiller/parameters # so android can't edit it

#block ota
pm disable 'com.google.android.gms/.update.SystemUpdateActivity'
pm disable 'com.google.android.gms/.update.SystemUpdateService$ActiveReceiver'
pm disable 'com.google.android.gms/.update.SystemUpdateService$Receiver'
pm disable 'com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver'
pm disable 'com.google.android.gsf/.update.SystemUpdateActivity'
pm disable 'com.google.android.gsf/.update.SystemUpdatePanoActivity'
pm disable 'com.google.android.gsf/.update.SystemUpdateService$Receiver'
pm disable 'com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver'
