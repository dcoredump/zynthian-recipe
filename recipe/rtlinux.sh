#
# RPI3-Kernel Linux RT recipe
#
# Description by autostatic:
# https://autostatic.com/2017/06/27/rpi-3-and-the-real-time-kernel/
# 

cd "${HOME}/tmp"
mkdir rtlinux
cd rtlinux
git clone -b 'rpi-4.9.y' --depth 1 https://github.com/raspberrypi/linux.git
git clone https://github.com/raspberrypi/tools.git
export KERNEL=kernel7
export ARCH=arm
export CROSS_COMPILE=/"${HOME}"/tmp/rtlinux/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-
export CONCURRENCY_LEVEL=$(nproc)
cd linux
make bcm2709_defconfig
cd ..
wget https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.47-rt37.patch.xz 
cd linux
xzcat ../patch-4.9.47-rt37.patch.xz | patch -p1
cd ..
wget https://www.osadl.org/monitoring/patches/rbs3s/usb-dwc_otg-fix-system-lockup-when-interrupts-are-threaded.patch
cd linux
patch -i ../usb-dwc_otg-fix-system-lockup-when-interrupts-are-threaded.patch -p1
make clean
scripts/config --disable DEBUG_INFO
make -j$(nproc) deb-pkg
