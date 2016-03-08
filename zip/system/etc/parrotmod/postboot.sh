#!/system/bin/sh
bb=/system/etc/parrotmod/busybox

while [ "$(getprop sys.boot_completed)" = "" ]; do sleep 1; done

if [ "$(cat /data/lastpmver_univ.txt)" != "1" ]; then

  settings put global sys_storage_full_threshold_bytes 8388608
  settings put global sys_storage_threshold_percentage 2
  settings put global sys_storage_threshold_max_bytes 104857600
  
  echo 1 > /data/lastpmver_univ.txt
  
  am start -a android.intent.action.REBOOT # cleaner reboot
  
fi

# http://review.cyanogenmod.org/#/c/101476/ instead ???
$bb chmod -R 0775 /sys/module/lowmemorykiller/parameters
echo "0,1,2,5,7,16" > /sys/module/lowmemorykiller/parameters/adj 
echo "9933,10728,14950,17510,20019,31385" > /sys/module/lowmemorykiller/parameters/minfree 
echo "24" > /sys/module/lowmemorykiller/parameters/cost # default 32
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
