# jack_midi_clock
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/jack_midi_clock.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd jack_midi_clock
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
