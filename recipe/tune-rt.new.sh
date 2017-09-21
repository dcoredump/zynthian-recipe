# tune-rt
# http://linuxrealtime.org/index.php/Improving_the_Real-Time_Properties
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
# Add "cgroup_enable=cpuset" to /boot/cmdline.txt!
# "isolcpus=2,3"
# ps xawf -eo pid,user,cgroup,args
#

partrt create 0xc # 0xc=<mask of CPU 2,3>
partrt list
partrt run -c 0xc rt cyclictest -n -i 10000 -l 10000
partrt move `pidof cyclictest` nrt

# BDI writeback affinity
echo 0 > /sys/bus/workqueue/devices/writeback/numa

# Increase flush time to disk
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs

