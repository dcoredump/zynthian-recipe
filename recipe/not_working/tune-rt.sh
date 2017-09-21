# tune-rt
# http://linuxrealtime.org/index.php/Improving_the_Real-Time_Properties
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
# Add "cgroup_enable=cpuset" to /boot/cmdline.txt!
# "isolcpus=3" # man 2 sched_setaffinity
# ps xawf -eo pid,user,cgroup,args
#
# create rt/nrt cgroups
mount -t tmpfs none /sys/fs/cgroup
if [ ! -d "/sys/fs/cgroup/cpuset" ]
then
        mkdir /sys/fs/cgroup/cpuset
fi
mount -t cgroup -o cpuset none /sys/fs/cgroup/cpuset/
if [ ! -d "/sys/fs/cgroup/cpuset/rt" ]
then
        mkdir /sys/fs/cgroup/cpuset/rt
fi
if [ ! -d "/sys/fs/cgroup/cpuset/nrt" ]
then
        mkdir /sys/fs/cgroup/cpuset/nrt
fi

# advise CPUs to rt/nrt
echo 0,1,2 > /sys/fs/cgroup/cpuset/nrt/cpuset.cpus
echo 3 > /sys/fs/cgroup/cpuset/rt/cpuset.cpus
echo 1 > /sys/fs/cgroup/cpuset/rt/cpuset.cpu_exclusive

# memory nodes
echo 0 > /sys/fs/cgroup/cpuset/nrt/cpuset.mems
echo 0 > /sys/fs/cgroup/cpuset/rt/cpuset.mems

# disable load-balancing in RT cpuset
echo 0 > /sys/fs/cgroup/cpuset/cpuset.sched_load_balance
echo 0 > /sys/fs/cgroup/cpuset/rt/cpuset.sched_load_balance
echo 1 > /sys/fs/cgroup/cpuset/nrt/cpuset.sched_load_balance

# move unwanted IRQs to nrt
echo 7 > /proc/irq/default_smp_affinity

# BDI writeback affinity
echo 0 > /sys/bus/workqueue/devices/writeback/numa

# Increase flush time to disk
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs

# move tasks to nrt
#echo `pidof midori` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof sshd` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof systemd` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof xorg` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof pisound-btn` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof mod-host` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof python3 /zynthian/zynthian-sw/mod-ui/server.py` > /sys/fs/cgroup/cpuset/nrt/tasks

# move taks to rt
echo `pidof jackd` > /sys/fs/cgroup/cpuset/rt/tasks
