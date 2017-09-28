# jack_capture
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get install -y libmp3lame-dev --no-install-recommends
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/kmatheussen/jack_capture.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd jack_capture
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ..
fi
