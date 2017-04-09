# guitarix
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get install -y libglibmm-2.4-dev libeigen3-dev libzita-convolver-dev libzita-resampler-dev libglibmm-2.4-dev
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git http://git.code.sf.net/p/guitarix/git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	if [ ! -d guitarix ]
	then
		ln -s git guitarix
	fi
	zynth_build_request ready
	cd guitarix/trunk
	git checkout 589dd79b2d7ad2b5e0db4c18c25279d6e94a1552
	./waf configure --lv2-only --lv2dir=$ZYNTHIAN_PLUGINS_DIR --no-avahi --no-bluez --no-ladspa --no-new-ladspa --shared-lib --optimization --download --no-lv2-gui --no-faust
	./waf build
	sudo ./waf install
	zynth_build_request ready
else
	cd guitarix/trunk
	./waf clean
fi
cd ../..
