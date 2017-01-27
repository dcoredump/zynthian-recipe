# guitarix
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get install -y libglibmm-2.4-dev libeigen3-dev libgxw-dev libgxwmm-dev
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git http://git.code.sf.net/p/guitarix/git
if [ ! -d guitarix ]
then
	ln -s git guitarix
fi
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd guitarix/trunk
	./waf configure --no-lv2-gui --lv2-only --disable-sse --lv2dir=$ZYNTHIAN_PLUGINS_DIR --no-avahi --no-bluez --no-ladspa --no-faust
	./waf build
	sudo ./waf install
	zynth_build_request ${0} ready
fi
./waf clean
cd ..
