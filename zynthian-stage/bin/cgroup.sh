# create rt/nrt cgroups
mount -t tmpfs none /sys/fs/cgroup
mkdir /sys/fs/cgroup/cpuset
mount -t cgroup -o cpuset none /sys/fs/cgroup/cpuset/
mkdir /sys/fs/cgroup/cpuset/rt
mkdir /sys/fs/cgroup/cpuset/nrt

# advice CPUs to rt/nrt
echo 0,1,2 > /sys/fs/cgroup/cpuset/nrt/cpuset.cpus
echo 3 > /sys/fs/cgroup/cpuset/rt/cpuset.cpus
echo 1 > /sys/fs/cgroup/cpuset/rt/cpuset.cpu_exclusive

# enable CPU hotplugging for RT CPUs
echo 0 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu3/online

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

# Disable the watchdog
echo 0 > /proc/sys/kernel/watchdog

# Increase flush time to disk
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
