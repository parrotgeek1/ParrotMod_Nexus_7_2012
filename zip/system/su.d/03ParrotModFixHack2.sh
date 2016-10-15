#!/system/bin/sh

if test "`getprop parrotmod.running`" = ""; then
	exec /system/bin/sh /system/su.d/01ParrotMod.sh
fi
