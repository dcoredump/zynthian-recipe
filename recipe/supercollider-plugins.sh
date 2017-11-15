# supercollider-plugins
# http://supercollider.github.io/development/building-raspberrypi
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git_recursive https://github.com/supercollider/sc3-plugins.git --depth 1
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd sc3-plugins
    mkdir build && cd build
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
    cmake -L -DCMAKE_BUILD_TYPE="Release" -DSUPERNOVA=OFF -DNATIVE=ON -DSC_PATH=../../supercollider/ ..
	make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ../..
fi
