#https://www.raspberrypi.org/documentation/linux/kernel/building.md
sudo apt install gcc-arm-linux-gnueabihf
mkdir rpilinux-rt
cd rpilinux-rt
git clone --depth=1 https://github.com/raspberrypi/linux.git
wget https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.20-rt16.patch.xz
xz -d patch-4.9.20-rt16.patch.xz
cd linux
cat ../patch-4.9.20-rt16.patch | patch -p 1 | tee log
# now correct FAILED hunks 
KERNEL=kernel7
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig
# check for the following vars and set them:
# CONFIG_PREEMPT_RT_FULL=y
# CONFIG_HIGH_RES_TIMERS=y
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 zImage modules dtbs

