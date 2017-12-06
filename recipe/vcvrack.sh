# vcvrack.sh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
sudo apt-get -y --no-install-recommends install libx11-dev libgl1-mesa-dev libxrandr-dev libxinerama-dev libxcursor-dev librtmidi-dev librtaudio-dev libglu1-mesa-dev libgtk2.0-dev
zynth_git_recursive https://github.com/VCVRack/Rack.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
        zynth_build_request clear
	cd Rack
	git submodule update --init --recursive
	make dep
	sed -i.orig -- "s,-march=nocona ,," compile.mk
	cp src/engine.cpp src/engine.cpp.orig
	sed -i -- "s,^#include <xmmintrin.h>,//#include <xmmintrin.h>," src/engine.cpp
	sed -i -- "s,_MM_SET_FLUSH_ZERO_MODE(_MM_FLUSH_ZERO_ON);,//_MM_SET_FLUSH_ZERO_MODE(_MM_FLUSH_ZERO_ON)," src/engine.cpp
	make
	cd plugins
	git clone https://github.com/VCVRack/Fundamental.git
	cd Fundamental
	git submodule update --init --recursive
	make
	cd ../../..
	zynth_build_request ready
fi
