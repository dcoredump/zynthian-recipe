#
# RPI3-Kernel Linux RT recipe
#
# Ideas taken from:
# https://www.raspberrypi.org/documentation/linux/kernel/building.md
# https://raspberrypi.stackexchange.com/questions/13137/how-can-i-mount-a-raspberry-pi-linux-distro-image
# http://www.frank-durr.de/?p=203
#
ZYNTHIAN_SD_IMAGE=${HOME}/Downloads/zynthian_gorgona_rbpi3-2017-05-13-rt.img
TMP_MNT="/mnt"
RT_INSTALLATION_PATH="${HOME}/tmp/rpi-rt-linux"
RPI=2 # DON'T TOUCH!
#
mkdir -p $RT_INSTALLATION_PATH
cd ${RT_INSTALLATION_PATH}

if [ ! -d $RT_INSTALLATION_PATH/rpilinux-rt/linux ]
then
	sudo apt install -y gcc-arm-linux-gnueabihf git bc
	mkdir rpilinux-rt
	cd rpilinux-rt
	git clone --depth=1 https://github.com/raspberrypi/linux.git
	#wget https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.20-rt16.patch.xz
	wget https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.30-rt21.patch.xz
	xz -d patch-4.9.30-rt21.patch.xz
	cd linux
	cat ../patch-4.9.27-rt17.patch | patch -p 1 | tee log
	grep_failed=`grep -i failed log`
	if [ $? = 0 ]
	then
		echo "#########################################################################"
		echo "Errors during patching - fix them by yourself an restart with '$0 fixed':"
		echo "#########################################################################"
		find . -iname "*.rej"
		exit 1
	fi
else
	if [ `find . -iname "*.rej"` ]
	then
		echo "Remove *.rej file after fixing by hand and try again:"
		find . -iname "*.rej"
		exit 2
	fi
	cd rpilinux-rt/linux
	KERNEL=kernel7
	if [ ${RPI} = 2 ]
	then
		make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig # RPi2
	else
		make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2835_defconfig #RPi3
	fi
# check for the following vars and set them:
	sed -i -- 's/# CONFIG_PREEMPT_RT_FULL is not set/CONFIG_PREEMPT_RT_FULL=y/' .config
	sed -i -- 's/# CONFIG_HIGH_RES_TIMERS is not set/CONFIG_HIGH_RES_TIMERS=y/' .config
	sed -i -- 's/CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y/CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=n/' .config
	sed -i -- 's/# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set/CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y/' .config
	echo "CONFIG_DEBUG_PREEMPT=n" >> .config
	echo "CONFIG_RCU_CPU_STALL_TIMEOUT=21" >> .config
	echo "CONFIG_PREEMPT_TRACER=n" >> .config
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 zImage modules dtbs
	SD_BOOT_START_BLOCK=`fdisk -l ${ZYNTHIAN_SD_IMAGE} | grep img1 | cut -d" " -f11`
	SD_ZYNTHIAN_START_BLOCK=`fdisk -l ${ZYNTHIAN_SD_IMAGE} | grep img2 | cut -d" " -f7`
	sudo mkdir ${TMP_MNT}/zynthian
	# install new kernel
	sudo mount -v -o offset=`echo "512 * ${SD_BOOT_START_BLOCK}" | bc` -t vfat ${ZYNTHIAN_SD_IMAGE} ${TMP_MNT}/zynthian
	sudo cp arch/arm/boot/zImage ${TMP_MNT}/zynthian/$KERNEL-rt.img
	sudo cp arch/arm/boot/dts/*.dtb ${TMP_MNT}/zynthian 
	sudo cp arch/arm/boot/dts/overlays/*.dtb* ${TMP_MNT}/zynthian/overlays/
	sudo cp arch/arm/boot/dts/overlays/README ${TMP_MNT}/zynthian/overlays
	sudo sed -i -- 's/# Load RT Kernel for RBPI2/#Load RT Kernel for RBPI3/' ${TMP_MNT}/zynthian/config.txt
	sudo sed -i -- "s/#kernel=kernel7-rt.img/kernel=$KERNEL-rt.img/" ${TMP_MNT}/zynthian/config.txt
	sudo umount ${TMP_MNT}/zynthian
	# install new modules
	sudo mount -v -o offset=`echo "512 * ${SD_ZYNTHIAN_START_BLOCK}" | bc` -t ext4 ${ZYNTHIAN_SD_IMAGE} ${TMP_MNT}/zynthian
	sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=${TMP_MNT}/zynthian modules_install
	sudo umount ${TMP_MNT}/zynthian
	sudo rm -r ${TMP_MNT}/zynthian
fi
echo "Done."
