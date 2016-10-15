#!/tmp-mksh/tmp-mksh

if test "`getprop parrotmod.running`" = ""; then
	exec /tmp-mksh/tmp-mksh /system/su.d/01ParrotMod.sh
fi
