#!/system/bin/sh

fastboot=$(getprop ro.boot.bootreason | cut -d, -F2)
if [[ $fastboot == "bootloader" || $fastboot == "longkey" || $fastboot == "reboot" ]]
then
	insmod /vendor/lib/modules/ftm5.ko
	insmod /vendor/lib/modules/sec_touch.ko
fi
if [[ $fastboot == "recovery" || $fastboot == "reboot,recovery" ]]
then
	#twrp mount vendor
	#cp /vendor/lib/modules/heatmap.ko /vendor/lib/modules
	#cp /vendor/lib/modules/touch_offload.ko /vendor/lib/modules
	#cp /vendor/lib/modules/ftm5.ko /vendor/lib/modules
	#cp /vendor/lib/modules/sec_touch.ko /vendor/lib/modules
	#twrp unmount vendor
	#insmod /vendor/lib/modules/heatmap.ko
	#insmod /vendor/lib/modules/touch_offload.ko
	#insmod /vendor/lib/modules/ftm5.ko
	#insmod /vendor/lib/modules/sec_touch.ko
fi
