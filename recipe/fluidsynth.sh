# fluidsynth
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get install -y libglib2.0-dev libsndfile-dev cmake libpthread-stubs0-dev
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git git://git.code.sf.net/p/fluidsynth/code-git fluidsynth
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd fluidsynth/fluidsynth
	sed -i -- 's/AM_INIT_AUTOMAKE(fluidsynth, \$FLUIDSYNTH_VERSION)/AM_INIT_AUTOMAKE(fluidsynth, \$FLUIDSYNTH_VERSION)\nAC_DEFINE(DEFAULT_SOUNDFONT, "share\/soundfonts\/default.sf2", \[Default soundfont\])/' configure.ac
	autoreconf -i
	automake
	autoreconf -i
	./configure --disable-portaudio-support --disable-ladcca --disable-lash --disable-dart --disable-coremidi --disable-coreaudio --disable-aufile-support --disable-pulse-support --disable-alsa-support --disable-dbus-support  --disable-oss-support
	#mkdir build
	#cd build
	#cmake ..
	make
	sudo make install
	zynth_build_request ready
	make clean
	cd ..
fi
