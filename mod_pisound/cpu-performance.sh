#!/bin/sh
for cpu in /sys/devices/system/cpu/cpu[0-9]*; do 
	echo -n performance | tee $cpu/cpufreq/scaling_governor
done
