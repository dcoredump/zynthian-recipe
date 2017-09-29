# amsynth
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends autoconf libgtk2.0-dev intltool libgtkmm-2.4-dev
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/amsynth/amsynth.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd amsynth
	sh autogen.sh
	./configure CXXFLAGS="${CXXFLAGS} -std=c++11" --without-jack --without-alsa --without-oss --without-vst --without-sndfile --without-dssi --without-lash --with-lv2
	make
	sudo make install
	rm -rf $ZYNTHIAN_PLUGINS_DIR/lv2/amsynth.lv2
	mv /usr/local/lib/lv2/amsynth.lv2 $ZYNTHIAN_PLUGINS_DIR/lv2
	ln -s $ZYNTHIAN_PLUGINS_DIR/lv2/amsynth.lv2 /usr/local/lib/lv2
	zynth_build_request ready
	make clean
	cd ..
fi
