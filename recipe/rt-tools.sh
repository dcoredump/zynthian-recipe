# rt-tools
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/OpenEneaLinux/rt-tools.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd rt-tools
	mkdir build && cd build
	cmake ..
	make
	sudo make install
	zynth_build_request ready
	make clean
	cd ..
fi
