#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 1; done

sleep 1

if [ "$(settings get global parrotmod_univ_last_version)" != "2.0.0" ]; then

  [ -e "/system/etc/parrotmodstock/postboot.sh" ] && . "/system/etc/parrotmodstock/postboot.sh" # @me: don't get rid of .
  
  settings put global parrotmod_univ_last_version "2.0.0"
  
  settings put global fstrim_mandatory_interval 0 # never
  settings put global storage_benchmark_interval -1 # never

  am start -a android.intent.action.REBOOT # cleaner reboot
fi

$bb renice -15 $($bb pidof mediaserver) #avoid underruns
$bb ionice -c 1 -n 3 $($bb pidof mediaserver)

echo 600000 > /dev/cpuctl/bg_non_interactive/cpu.rt_runtime_us # fix lag by bg tasks was 700000

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
