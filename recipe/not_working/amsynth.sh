# amsynth
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get install -y autoconf autopoint pandoc intltool
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/amsynth/amsynth.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd amsynth
	export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig/"
	sh autogen.sh
	LV2_LIBS=`pkg-config --libs lv2` LV2_CFLAGS=`pkg-config --cflags lv2` ./configure CXXFLAGS="${CXXFLAGS} -std=c++11" --without-gui --without-jack --without-alsa --without-oss --without-vst --without-sndfile --with-lv2
	make
	sudo make install
	zynth_build_request ready
fi
#make clean
cd ..
