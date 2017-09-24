# rt-tools
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/OpenEneaLinux/rt-tools.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd rt-tools
	mkdir -p build && cd build
	cmake ..
	make
	sudo make install
	zynth_build_request ready
	make clean
	cd ..
	sed -i -r -- "s/\s+cgroup_enable=.+ / /" /boot/cmdline.txt
	sed -i -r -- "s/\s+isolcpus==.+/ /" /boot/cmdline.txt
	sed -i -r -- "s/\s+rootwait\s*/ cgroup_enable=cpuset isolcpus=1,2,3 rootwait/" /boot/cmdline.txt
fi
