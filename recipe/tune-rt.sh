# tune-rt
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
# Add "cgroup_enable=cpuset" to /boot/cmdline.txt
mount -t tmpfs none /sys/fs/cgroup
mkdir /sys/fs/cgroup/cpuset
mount -t cgroup -o cpuset none /sys/fs/cgroup/cpuset/
mkdir /sys/fs/cgroup/cpuset/rt
mkdir /sys/fs/cgroup/cpuset/nrt
echo 0 > /sys/fs/cgroup/cpuset/nrt/cpuset.cpus
echo 1,2,3 > /sys/fs/cgroup/cpuset/rt/cpuset.cpus
echo 1 > /sys/fs/cgroup/cpuset/rt/cpuset.cpu_exclusive
# memory nodes
echo 0 > /sys/fs/cgroup/cpuset/nrt/cpuset.mems
echo 0 > /sys/fs/cgroup/cpuset/rt/cpuset.mems
# disable load-balancing in RT cpuset
echo 0 > /sys/fs/cgroup/cpuset/cpuset.sched_load_balance
echo 0 > /sys/fs/cgroup/cpuset/rt/cpuset.sched_load_balance
echo 1 > /sys/fs/cgroup/cpuset/nrt/cpuset.sched_load_balance
# move unwanted IRQs to nrt
echo 3 > /proc/irq/default_smp_affinity

# move tasks to nrt
echo `pidof python3 /zynthian/zynthian-sw/mod-ui/server.py` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof midori` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof sshd` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof systemd` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof xorg` > /sys/fs/cgroup/cpuset/nrt/tasks
echo `pidof pisound-btn` > /sys/fs/cgroup/cpuset/nrt/tasks

# move taks to rt
echo `pidof jackd` > /sys/fs/cgroup/cpuset/rt/tasks
echo `pidof mod-host` > /sys/fs/cgroup/cpuset/rt/tasks

