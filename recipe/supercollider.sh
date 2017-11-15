# supercollider
# http://supercollider.github.io/development/building-raspberrypi
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git_recursive https://github.com/supercollider/supercollider
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd supercollider
    git submodule init && git submodule update
    mkdir build && cd build
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
    cmake -L -DCMAKE_BUILD_TYPE="Release" -DBUILD_TESTING=OFF -DSUPERNOVA=ON -DNATIVE=ON -DSC_WII=OFF -DSC_IDE=OFF -DSC_QT=OFF -DSC_ED=OFF -DSC_EL=OFF -DSC_VIM=ON ..
	make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ../..
fi
